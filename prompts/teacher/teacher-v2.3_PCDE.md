**2. Last Step Reached**

Capture the highest step the agent started speaking during the call.

Steps:
1. Greeting and opening: "हेलो", "मैं Tap team से बोल रही हूँ", identity question.
2. Time check and introduction: "क्या अभी बात हो सकती है?", the call recording line, "क्या आपके school में Tap की videos छात्रों को दिखाना शुरू हो गया है?"
3. Explanation: "School में आपका हिस्सा बस इतना है…", or the short version.
4. Teach-back: "क्या आप अपने शब्दों में बता सकते हैं कि हर हफ़्ते आपको क्या करना है?"
5. At home: "घर पर Tap Buddy, WhatsApp पर छात्रों को और activities और quizzes भेजती है…"
6. Commitment and close: the commitment question or the closing thanks.

Rules:
- Capture the highest step reached, from 1 to 6.
- Do not count a step the agent did not start.
- The RAPID SUMMARY (the half-minute summary for a busy teacher) is not a step of its own. Capture the step during which it was offered or started.
- If the call did not start → N/A.

Output only:
[1–6] / N/A

**3. Listened Through**

Determine whether the call reached Step 4 (teach-back).

Rules:
- If the call reached Step 4 → yes.
- If the call ended before Step 4 → no.

Output only:
yes / no

**6. Tap Period Started**

Capture the teacher's response to "क्या आपके school में Tap की videos छात्रों को दिखाना शुरू हो गया है?"

Rules:
- If the teacher confirms it has started → yes.
- If the teacher confirms it has not started → no.
- If the response is unclear → unsure.
- If the question was not asked → not_asked.

Output only:
yes / no / unsure / not_asked

**7. Teach-back Result**

Evaluate the teacher's first answer to the teach-back question ("क्या आप अपने शब्दों में बता सकते हैं कि हर हफ़्ते आपको क्या करना है?").

The three steps:
- (A) Video: the teacher shows the video to students in class.
- (B) Activity: the students do the activity.
- (C) Photo: the teacher sends a photo of the class's work on the Tap Buddy chat or WhatsApp.

Rules:
- Evaluate the first answer only, before the agent's reply.
- Judge the meaning, not the wording. Any wording that carries the step counts. For example, "class में video दिखाना", "period में दिखाएँगे" and "video चलाएँगे" all count for A; "photo भेजनी है", "photo या video भेजना" and "photo and video" all count for C.
- The transcript has speech-recognition errors. Read past them: "ChatGPT" or "chat GPT" in place of "chat", or a misheard word that clearly means a step, still counts.
- A missing step is never wrong. Only an incorrect action makes an answer wrong.
- accurate: A, B and C are all stated, and nothing incorrect.
- partial: one or two of A, B and C are stated, and nothing incorrect.
- agreed_only: the teacher agrees or acknowledges ("हाँ", "जी", "ठीक है", "समझ गए", "कर देंगे") but states no step.
- wrong_frame: the teacher thinks they must teach the content or prepare materials.
- wrong: the teacher states an incorrect action, such as sending photos of the students instead of their work, or students sending the class work themselves.
- no_answer: silence, or the teacher talks about something else.
- If Step 4 was not reached → N/A.

Output only:
accurate / partial / agreed_only / wrong_frame / wrong / no_answer / N/A

**New: Teach-back Missing**

Capture which of the three steps the teacher did not state in their first teach-back answer.

Rules:
- Use the same three steps and the same meaning-based rules as Teach-back Result.
- List each missing step: video, activity, photo.
- If all three were stated → none.
- If Teach-back Result is agreed_only, no_answer or N/A → N/A.

Output only:
video / activity / photo (one or more, comma-separated) / none / N/A

**New: Correction Given**

Determine whether the agent restated any step after the teacher's first teach-back answer.

Rules:
- If the agent restated one or more steps (for example "फिर पूरी class के काम की एक photo Tap Buddy chat पर भेजनी है।" or the full summary line) → yes.
- If the agent only confirmed the answer ("बिल्कुल सही, धन्यवाद।") → no.
- If Step 4 was not reached → N/A.

Output only:
yes / no / N/A

**9. Commitment Given**

Capture the teacher's response to the commitment question: "Monday को video दिखाकर, क्या आप class के काम की एक photo Tap Buddy chat पर भेज पाएँगे?" or "जब यह शुरू होगा, क्या आप Monday वाला video दिखाकर, class के काम की एक photo Tap Buddy chat पर भेज पाएँगे?"

Rules:
- Clear agreement to send the photo → yes.
- Explicit refusal → no.
- Agreement to show the video only, without agreeing to the photo → unclear.
- Vague politeness, uncertain response, or silence → unclear.
- If the question was not asked → N/A.

Output only:
yes / no / unclear / N/A

**10. Commitment Barrier**

Extract the reason given by the teacher for declining or being unable to commit.

Rules:
- Capture the explicitly stated reason.
- Examples: no device, video not received, lack of time.
- Do not assume a reason.
- If no barrier was mentioned → N/A.

Output only:
[Commitment Barrier] / N/A

**New: RAPID Summary**

Determine whether the agent gave the half-minute summary to a teacher who was busy or short on time.

Rules:
- The summary starts after the agent offers "क्या मैं बस आधे minute में आपका हिस्सा बता दूँ?", or after the teacher says they are short on time, and ends the call without the teach-back.
- If the agent gave it → yes.
- Otherwise → no.

Output only:
yes / no

**15. Support Route**

Identify the type of support required by the teacher.

Rules:
- tech: Video not arriving, photo not sending, or WhatsApp issues.
- device: No phone, projector, or classroom screen.
- role: Someone else handles Tap, or the teacher does not teach this class.
- none: No support requirement identified.
- Select only what is supported by the conversation.

Output only:
tech / device / role / none

**17. Workload Concern**

Identify whether the teacher expressed concern about additional programme workload.

Rules:
- Teacher explicitly says the programme creates extra work or workload concerns → yes.
- Otherwise → no.
- Do not interpret general busyness as workload concern.

Output only:
yes / no

**20. Unhandled Topics**

Capture questions or requests from the teacher that the agent could not answer.

Rules:
- Include:
  - questions the agent answered with "इसकी जानकारी अभी मेरे पास नहीं है" (or the English "I don't have that information");
  - questions the agent passed to the Tap coordinator because it had no answer;
  - questions or requests the agent ignored or did not address;
  - requests the script does not cover, such as asking for a WhatsApp call.
- Capture each one separately.
- Use the teacher's original question wherever possible.
- Do not include questions the agent answered.
- If no unhandled topics → N/A.

Output only:
[Unhandled Topics] / N/A

**New: Teacher Feedback**

Capture anything the teacher volunteered, without being asked, about how Tap runs in their school.

Rules:
- Include statements such as "students watch the video but don't do the activity", "videos come but aren't shown", "no projector in every class", or election duty.
- Use the teacher's words, briefly.
- Do not include questions; those go in Unhandled Topics.
- Do not include answers to the agent's questions.
- If nothing was volunteered → N/A.

Output only:
[Teacher Feedback] / N/A

**New: Retry Eligible**

Determine whether the teacher should be called again.

Rules:
- yes:
  - the teacher hung up before Step 2;
  - no answer to the identity question;
  - the teacher was busy, in class or asked to talk later, and did not hear the RAPID SUMMARY;
  - someone else answered and the teacher did not come on;
  - unclear audio;
  - the call ended on silence.
- no:
  - wrong number;
  - the teacher asked not to be called again;
  - the teacher has left the school, is on leave, or someone else handles Tap;
  - the teacher heard the RAPID SUMMARY;
  - the call reached Step 4 or later;
  - clear refusal;
  - child-safety concern or distress.
- If both apply, no wins.

Output only:
yes / no
