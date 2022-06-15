import 'dart:developer';

import 'package:camera_app/heallivedoctormodeltest/availableday.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  InkWell addShiftButton() {
    return InkWell(
      onTap: () {
        setState(() {
          clinic1.availableDays[widget.index].availableTimeSlots
              .add(TimeSlot(startTime: "", endTime: ""));
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Add shift"),
          const SizedBox(
            width: 8,
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
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
            child: TextFormField(
              validator: ((value) {
                if (value!.isEmpty) {
                  return "Please enter start time";
                }
                return null;
              }),
              onTap: (() {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then(
                  (value) {
                    if (value != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(value.format(context).toString());
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      clinic1
                          .availableDays[widget.index]
                          .availableTimeSlots[index]
                          .startTime = value.format(context);
                      setState(() {
                        startTime.text = value.format(context);
                      });
                    }
                  },
                );
              }),
              readOnly: true,
              controller: startTime,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: 'Start Time',
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              validator: ((value) {
                if (value!.isEmpty) {
                  return "Please enter end time";
                }
                return null;
              }),
              onTap: (() {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then(
                  (value) {
                    if (value != null) {
                      DateTime parsedTime = DateFormat.jm()
                          .parse(value.format(context).toString());
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(parsedTime);
                      clinic1
                          .availableDays[widget.index]
                          .availableTimeSlots[index]
                          .endTime = value.format(context);
                      setState(() {
                        endTime.text = value.format(context);
                      });
                    }
                  },
                );
              }),
              readOnly: true,
              controller: endTime,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: 'End Time',
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
            buttonIcon: const Icon(Icons.keyboard_arrow_down),
            buttonText: const Text("Select Working Days"),
            validator: ((value) {
              if (value!.isEmpty) {
                return "Please choose any day";
              }
              return null;
            }),
            separateSelectedItems: true,
            initialValue: clinic1.availableDays[widget.index].workingDays,
            chipDisplay: MultiSelectChipDisplay<String>(
              icon: const Icon(Icons.cancel),
              onTap: (String value) {
                clinic1.availableDays[widget.index].workingDays.remove(value);
                setState(() {});
              },
              items: clinic1.availableDays[widget.index].workingDays
                  .map((e) => MultiSelectItem(e, e))
                  .toList(),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10)),
            barrierColor: Colors.black.withOpacity(0.5),
            title: const Text("Select Working Days."),
            items: weekDays.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (List<String> values) {
              clinic1.availableDays[widget.index].workingDays = values;
              // selectedWeekDays = values.map((String e) => e).toList();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          horizontalDivider(),
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Select Days and Shifts. ",
                  style: TextStyle(
                    fontSize: 14,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Days"),
                  const SizedBox(
                    height: 10,
                  ),
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
                  // horizontalDivider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
