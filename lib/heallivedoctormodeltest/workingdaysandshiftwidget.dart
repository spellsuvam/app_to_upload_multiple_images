import 'package:camera_app/heallivedoctormodeltest/availableday.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'clinicdata.dart';
import 'timeslot.dart';

class WorkingDaysAndShiftWidget extends StatefulWidget {
  const WorkingDaysAndShiftWidget(
      {Key? key,
      required this.day,
      required this.index,
      required this.onDelete})
      : super(key: key);
  final AvailableDay day;
  final Function onDelete;
  final int index;
  @override
  State<WorkingDaysAndShiftWidget> createState() =>
      _WorkingDaysAndShiftWidgetState();
}

class _WorkingDaysAndShiftWidgetState extends State<WorkingDaysAndShiftWidget> {
  var weekDays = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    "friday",
    "saturday"
  ];
  List<String> selectedWeekDays = [];

  IconButton deleteButton(Function _function) => IconButton(
      onPressed: () {
        _function();
      },
      icon: const Icon(Icons.delete));

  Divider horizontalDivider() {
    return const Divider(
      color: Colors.black,
    );
  }

  TextButton addShiftButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            clinic1.availableDays[widget.index].availableTimeSlots
                .add(TimeSlot(startTime: "", endTime: ""));
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Add Shift"), Icon(Icons.add)],
        ));
  }

  Padding selectTimeSlots(TimeSlot timeSlot, int index) {
    TextEditingController startTime =
        TextEditingController(text: timeSlot.startTime);
    TextEditingController endTime =
        TextEditingController(text: timeSlot.endTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: startTime,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Start Time',
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: endTime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Start Time',
              ),
            ),
          ),
          Visibility(
              visible: widget.day.availableTimeSlots.length > 1,
              child: deleteButton(() {
                setState(() {
                  clinic1.availableDays[widget.index].availableTimeSlots
                      .removeAt(index);
                });
              }))
        ],
      ),
    );
  }

  Row selectWorkingDays() {
    return Row(
      children: [
        Expanded(
          child: MultiSelectDialogField(
            buttonIcon: const Icon(Icons.add),
            chipDisplay: MultiSelectChipDisplay<String>(
              icon: const Icon(Icons.cancel),
              onTap: (String value) {
                setState(() {
                  selectedWeekDays.remove(value);
                });
              },
              items: [
                ...selectedWeekDays.map((e) => MultiSelectItem(e, e)).toList(),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10)),
            barrierColor: Colors.black.withOpacity(0.5),
            title: const Text("Select Working Days."),
            items: weekDays.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (List<String> values) {
              selectedWeekDays = values.map((String e) => e).toList();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        horizontalDivider(),
        Row(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "Working Days and Shifts. ",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Visibility(
                visible: clinic1.availableDays.length > 1,
                child: deleteButton(() {
                  widget.onDelete();
                }))
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                selectWorkingDays(),
                const SizedBox(
                  height: 10,
                ),
                ...widget.day.availableTimeSlots
                    .asMap()
                    .map((i, element) => MapEntry(
                          i,
                          selectTimeSlots(element, i),
                        ))
                    .values
                    .toList(),
                addShiftButton(),
                horizontalDivider(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
