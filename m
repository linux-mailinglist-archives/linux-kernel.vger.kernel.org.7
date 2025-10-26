Return-Path: <linux-kernel+bounces-870354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A852C0A820
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36C9B4EB7A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5EF2E8DF6;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FQZ4C1j4"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBD2DE6E3;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482558; cv=none; b=ZdQC2O4MK/2VCxFbP36L2IqLZ11DNnAftxlJ9fum7kWgPXI2GqdoVh0DJKvVCMm42l2TZIFhctC44ZLHt/kyNi1gFqL9uihJ8t2LSv3KrLCDWR9vDJOHeAO97BUBrofexCG2XMBrpCUkWjwRM8qEDDltas2sHiyRRHrH/7eJjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482558; c=relaxed/simple;
	bh=rNZIoC6pDpscutI+1aAPe3z6yjg/MlPZ7XDTm/LQhsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsnDrwzXqnnLz8R1iYdLfbMWe4CiAtOuQQmaC/J4cg3MHxdVsZ8Tmc0o7NYWLNihOX+SHO+OfsW6qZSV6hjkvjH7cEGO3fqD1YlcxkihhLHTXiDIi+i2iWx59ck1zzsO9P3+efKASBCXYVQoynUv/NLjQnohzhcdFnbuOjPyQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FQZ4C1j4; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=K7qoI4NF+hR2zU8RlYf5/2Ju3tpWLz9BGYsIERml1u8=; t=1761482555;
	x=1761914555; b=FQZ4C1j4YrS/vJORr4XB06Pv7fNh3TBAwbekJSPHgile9OG1S7ouVVuA/ySX1
	bAt2Cyfb828/2ZEwqrJen82hr39B1D5qXoVoY6dQIgYCYPwmr1ew+8mazds/aTTsgEs05bowL2XRC
	wkg3FRthOUTvBwUovabvxw5eNIrSuM0/H35wZV8/L8gIPUYpashzSNVMhddWswwjsixUOXac4FVbs
	BvpqwzGb0DkM4BIKWCTzbCk23FLFtBI4vfmiSxupATHS+6g5FHjEOOpHEqm2hWjOarCnf2Lq49bEu
	O81ikzqxJ0bVVa0tD7h4YzAPRXyeDVfymhBTl/JxYrSDqhvPDw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04v-001mZC-16;
	Sun, 26 Oct 2025 13:42:33 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 29/30] docs: reporting-issues: separate steps for follow-up tasks
Date: Sun, 26 Oct 2025 13:42:20 +0100
Message-ID: <e3430ec1b5513a3fed6c3152202d86343e292a61.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482555;32bd3f7a;
X-HE-SMSGID: 1vD04v-001mZC-16

Create three separate steps that cover things that are important for bug
reporters to keep an eye on after submitting the report.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 347 +++++++++---------
 1 file changed, 175 insertions(+), 172 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index c147191a7d0987..d81d558c245953 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -372,12 +372,41 @@ following the others is usually in your own interest.
 
  [:ref:`details <submit_repiref>`]
 
- * Wait for reactions and keep the thing rolling until you can accept the
-   outcome in one way or the other. Thus react publicly and in a timely manner
-   to any inquiries. Test proposed fixes. Do proactive testing: retest with at
-   least every first release candidate (RC) of a new mainline version and
-   report your results. Send friendly reminders if things stall. And try to
-   help yourself, if you don't get any help or if it's unsatisfying.
+.. _keeprolling_repisbs:
+
+* Wait for reactions and keep the ball rolling until you can accept the outcome
+  in one way or the other. Hence react publicly and in a timely manner to any
+  inquiries and requests for testing patches.
+
+ [:ref:`details <keeprolling_repiref>`]
+
+.. _retest_repisbs:
+
+* Retest at least every first release candidate (e.g., -rc1) of a new mainline
+  version released and report your findings in a reply to your report.
+
+ [:ref:`details <retest_repiref>`]
+
+.. _reminder_repisbs:
+
+* If things stall for more than three weeks, evaluate why. It can happen due to
+  good or bad reasons -- like an inadequate report or because you
+  missed a request for further details or testing. If it is unlikely to be
+  something like that, send a friendly inquiry as a reply-to-self, as it might
+  be a mundane reason like an over-eager spam filter or a developer being on
+  vacation.
+
+ [:ref:`details <reminder_repiref>`]
+
+.. _yourself_repisbs:
+
+* Be aware that nobody is obliged to help you, unless it is a recent regression,
+  a security issue, or an extremely severe problem. Hence, try to help yourself
+  if you don't receive any or only unsatisfying help.
+
+ [:ref:`details <yourself_repiref>`]
+
+.. _readysolved_repisubs:
 
 
 Handling non-regressions only occurring in stable or longterm kernels
@@ -1327,193 +1356,167 @@ The step-by-step guide covers all the important details already.
 [:ref:`back to step-by-step guide <submit_repisbs>`]
 
 
-Duties after the report went out
---------------------------------
+.. _keeprolling_repiref:
+
+Things to do after the report went out
+--------------------------------------
 
-    *Wait for reactions and keep the thing rolling until you can accept the
-    outcome in one way or the other. Thus react publicly and in a timely manner
-    to any inquiries. Test proposed fixes. Do proactive testing: retest with at
-    least every first release candidate (RC) of a new mainline version and
-    report your results. Send friendly reminders if things stall. And try to
-    help yourself, if you don't get any help or if it's unsatisfying.*
+  *Wait for reactions and keep the ball rolling until you can accept the outcome* [:ref:`... <keeprolling_repisbs>`]
 
-If your report was good and you are really lucky then one of the developers
-might immediately spot what's causing the issue; they then might write a patch
-to fix it, test it, and send it straight for integration in mainline while
-tagging it for later backport to stable and longterm kernels that need it. Then
-all you need to do is reply with a 'Thank you very much' and switch to a version
-with the fix once it gets released.
+If your report was good and you are lucky, some developers might immediately
+spot what is causing the issue. They then might provide a fix for you to test,
+which you should do in a timely manner; afterwards they then send it out for
+integration into the mainline kernel while tagging it for backporting to
+affected stable and longterm kernels if appropriate.
 
-But this ideal scenario rarely happens. That's why the job is only starting
-once you got the report out. What you'll have to do depends on the situations,
-but often it will be the things listed below. But before digging into the
-details, here are a few important things you need to keep in mind for this part
-of the process.
+But frequently it is a little less straightforward. That is why the job often
+is only starting once you send a report. What you'll have to do depends on the
+situation. Here are a few tips:
 
+**Check who you deal with**: Most of the time a
+developer for the particular area of code will respond. But as
+issues are usually reported in public, it could be anyone --
+including people that want to help but in the end send you off
+track. That is why it might be wise to run a quick search on `lore <https://lore.kernel.org/all/>`_
+to see who you are interacting with.
 
-General advice for further interactions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+**Inquiries for data**: Often you will be asked to test something or provide
+additional details. Try to supply the requested information soon, as you have
+the attention of someone willing to help and risk losing it the longer you
+wait; that outcome is even likely if you do not provide the information within
+a few business days.
 
-**Always reply in public**: When you filed the issue in a bug tracker, always
-reply there and do not contact any of the developers privately about it. For
-mailed reports always use the 'Reply-all' function when replying to any mails
-you receive. That includes mails with any additional data you might want to add
-to your report: go to your mail applications 'Sent' folder and use 'reply-all'
-on your mail with the report. This approach will make sure the public mailing
-list(s) and everyone else that gets involved over time stays in the loop; it
-also keeps the mail thread intact, which among others is really important for
-mailing lists to group all related mails together.
+**Always reply in public!** When you submitted the issue in a bug tracker,
+always reply there and do not contact any of the developers privately; for
+mailed reports, always use the 'Reply-all' function when replying to any emails
+you receive. That includes emails with any additional data you might want to add
+to your report: Go to your email application's 'Sent' folder and use 'reply-all'
+on your email with the report. This approach will make sure the public mailing
+lists and everyone else who becomes involved later can access everything; it
+also keeps the email thread intact, which, among others, is really important for
+others that later run into the same problem and check the thread for a solution.
 
 There are just two situations where a comment in a bug tracker or a 'Reply-all'
 is unsuitable:
 
- * Someone tells you to send something privately.
+* Someone tells you to send something privately.
+
+* You were told to supply something containing
+  information that should not be exposed to the public. In that case, it is okay
+  to send it in private to the person who asked for it. But note in the ticket
+  or an email that you did so to keep the public record straight.
 
- * You were told to send something, but noticed it contains sensitive
-   information that needs to be kept private. In that case it's okay to send it
-   in private to the developer that asked for it. But note in the ticket or a
-   mail that you did that, so everyone else knows you honored the request.
+**Requests for testing**: When you are asked to test a diagnostic patch or a
+possible fix, try to test it in a timely manner, too. But do it thoroughly and
+do not rush it: Mixing things up can happen easily and leads to a lot of
+confusion. A common mistake, for example, is thinking a proposed fix was applied
+when building a test kernel, when in fact it was not.
 
-**Do research before asking for clarifications or help**: In this part of the
+**Try to help yourself** before asking for help: During this part of the
 process someone might tell you to do something that requires a skill you might
 not have mastered yet. For example, you might be asked to use some test tools
-you never have heard of yet; or you might be asked to apply a patch to the
-Linux kernel sources to test if it helps. In some cases it will be fine sending
-a reply asking for instructions how to do that. But before going that route try
-to find the answer own your own by searching the internet; alternatively
-consider asking in other places for advice. For example ask a friend or post
-about it to a chatroom or forum you normally hang out.
-
-**Be patient**: If you are really lucky you might get a reply to your report
-within a few hours. But most of the time it will take longer, as maintainers
-are scattered around the globe and thus might be in a different time zone – one
-where they already enjoy their night away from keyboard.
-
-In general, kernel developers will take one to five business days to respond to
-reports. Sometimes it will take longer, as they might be busy with the merge
-windows, other work, visiting developer conferences, or simply enjoying a long
-summer holiday.
-
-The 'issues of high priority' (see above for an explanation) are an exception
-here: maintainers should address them as soon as possible; that's why you
-should wait a week at maximum (or just two days if it's something urgent)
-before sending a friendly reminder.
-
-Sometimes the maintainer might not be responding in a timely manner; other
-times there might be disagreements, for example if an issue qualifies as
-regression or not. In such cases raise your concerns on the mailing list and
-ask others for public or private replies how to move on. If that fails, it
-might be appropriate to get a higher authority involved. In case of a WiFi
-driver that would be the wireless maintainers; if there are no higher level
-maintainers or all else fails, it might be one of those rare situations where
-it's okay to get Linus Torvalds involved.
-
-**Proactive testing**: Every time the first pre-release (the 'rc1') of a new
-mainline kernel version gets released, go and check if the issue is fixed there
-or if anything of importance changed. Mention the outcome in the ticket or in a
-mail you sent as reply to your report (make sure it has all those in the CC
-that up to that point participated in the discussion). This will show your
-commitment and that you are willing to help. It also tells developers if the
-issue persists and makes sure they do not forget about it. A few other
-occasional retests (for example with rc3, rc5 and the final) are also a good
-idea, but only report your results if something relevant changed or if you are
-writing something anyway.
-
-With all these general things off the table let's get into the details of how
-to help to get issues resolved once they were reported.
-
-Inquires and testing request
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Here are your duties in case you got replies to your report:
-
-**Check who you deal with**: Most of the time it will be the maintainer or a
-developer of the particular code area that will respond to your report. But as
-issues are normally reported in public it could be anyone that's replying —
-including people that want to help, but in the end might guide you totally off
-track with their questions or requests. That rarely happens, but it's one of
-many reasons why it's wise to quickly run an internet search to see who you're
-interacting with. By doing this you also get aware if your report was heard by
-the right people, as a reminder to the maintainer (see below) might be in order
-later if discussion fades out without leading to a satisfying solution for the
-issue.
+you have never heard of yet; or you are asked to apply a patch to the
+Linux kernel sources to test. It usually will be fine replying asking for
+instructions on how to do that. But before going that route, try to find the
+answer on your own by searching the internet; alternatively,
+consider asking elsewhere for advice. For example, ask a friend or post
+your question to a chat room or forum you normally hang out in.
 
-**Inquiries for data**: Often you will be asked to test something or provide
-additional details. Try to provide the requested information soon, as you have
-the attention of someone that might help and risk losing it the longer you
-wait; that outcome is even likely if you do not provide the information within
-a few business days.
+**Be patient**: If you are really lucky, you might receive a reply to your
+report within a few hours. But most of the time it will take longer, as
+maintainers might be in a different time zone -- one where people currently
+take a few days off or already enjoy their night away from the keyboard. They
+might also simply be busy with other work, on a trip to a conference, or simply
+enjoying a long holiday.
 
-**Requests for testing**: When you are asked to test a diagnostic patch or a
-possible fix, try to test it in timely manner, too. But do it properly and make
-sure to not rush it: mixing things up can happen easily and can lead to a lot
-of confusion for everyone involved. A common mistake for example is thinking a
-proposed patch with a fix was applied, but in fact wasn't. Things like that
-happen even to experienced testers occasionally, but they most of the time will
-notice when the kernel with the fix behaves just as one without it.
+[:ref:`back to step-by-step guide <keeprolling_repisbs>`]
+
+
+.. _retest_repiref:
+
+Regularly check if the bug is still present
+-------------------------------------------
+
+  *Retest at least every first release candidate (e.g., -rc1) of a new mainline
+  version released and* [:ref:`... <retest_repisbs>`]
+
+Every time the first pre-release of a new mainline kernel version is released
+(the 'rc1'), go and check if the issue is fixed there or if anything of
+importance has changed. Mention the outcome in the ticket or in a mailed reply
+to your report (make sure to CCs everyone that up to that point participated in
+the discussion). This will show your commitment. It also tells developers the
+issue persists and acts as an implicit reminder.
+
+An occasional retest at another time (for example, with -rc4 or -rc7) is also
+wise, but only report your results if something relevant changed or if you are
+writing anyway.
+
+[:ref:`back to step-by-step guide <retest_repisbs>`]
+
+
+.. _reminder_repiref:
 
 What to do when nothing of substance happens
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Some reports will not get any reaction from the responsible Linux kernel
-developers; or a discussion around the issue evolved, but faded out with
-nothing of substance coming out of it.
-
-In these cases wait two (better: three) weeks before sending a friendly
-reminder: maybe the maintainer was just away from keyboard for a while when
-your report arrived or had something more important to take care of. When
-writing the reminder, kindly ask if anything else from your side is needed to
-get the ball running somehow. If the report got out by mail, do that in the
-first lines of a mail that is a reply to your initial mail (see above) which
-includes a full quote of the original report below: that's on of those few
-situations where such a 'TOFU' (Text Over, Fullquote Under) is the right
-approach, as then all the recipients will have the details at hand immediately
-in the proper order.
-
-After the reminder wait three more weeks for replies. If you still don't get a
-proper reaction, you first should reconsider your approach. Did you maybe try
-to reach out to the wrong people? Was the report maybe offensive or so
-confusing that people decided to completely stay away from it? The best way to
-rule out such factors: show the report to one or two people familiar with FLOSS
-issue reporting and ask for their opinion. Also ask them for their advice how
-to move forward. That might mean: prepare a better report and make those people
-review it before you send it out. Such an approach is totally fine; just
+--------------------------------------------
+
+  *If things stall for more than two to three weeks, evaluate why. It can
+  happen due to good or bad reasons, like* [:ref:`... <reminder_repisbs>`]
+
+Sometimes you will not receive any reaction from the responsible
+developers; or a discussion around the issue evolves but ends fruitlessly.
+
+In these cases, wait two to three weeks before sending a friendly
+reminder: Maybe the right developers were just away from their keyboards when
+you sent your report or had something more important to take care of.
+
+When writing the reminder, kindly ask if there was anything wrong with the
+report or if anything from your side is needed to get the ball rolling. If the
+report was submitted by email, send a reply inserting your query after quoting
+the intro while including a full quote of the original report below: Then all
+the recipients will have both the gist of the problem and the details at hand
+immediately in convenient order.
+
+After sending a reminder, wait three more weeks for replies. If you still don't
+receive a proper reaction, reconsider your approach. Did you maybe try
+to reach out to the wrong people? Was the report possibly offensive or so
+confusing that people decided to stay away from it?
+
+The best way to
+rule out such factors: Show the report to one or two people familiar with FLOSS
+issue reporting and ask for their opinion. Also ask them for their advice on how
+to move forward. That might mean preparing a better report and making those
+people review it before sending it out. Such an approach is totally fine; just
 mention that this is the second and improved report on the issue and include a
 link to the first report.
 
-If the report was proper you can send a second reminder; in it ask for advice
-why the report did not get any replies. A good moment for this second reminder
-mail is shortly after the first pre-release (the 'rc1') of a new Linux kernel
-version got published, as you should retest and provide a status update at that
-point anyway (see above).
-
-If the second reminder again results in no reaction within a week, try to
-contact a higher-level maintainer asking for advice: even busy maintainers by
-then should at least have sent some kind of acknowledgment.
-
-Remember to prepare yourself for a disappointment: maintainers ideally should
-react somehow to every issue report, but they are only obliged to fix those
-'issues of high priority' outlined earlier. So don't be too devastating if you
-get a reply along the lines of 'thanks for the report, I have more important
-issues to deal with currently and won't have time to look into this for the
-foreseeable future'.
-
-It's also possible that after some discussion in the bug tracker or on a list
-nothing happens anymore and reminders don't help to motivate anyone to work out
-a fix. Such situations can be devastating, but is within the cards when it
-comes to Linux kernel development. This and several other reasons for not
-getting help are explained in 'Why some issues won't get any reaction or remain
-unfixed after being reported' near the end of this document.
-
-Don't get devastated if you don't find any help or if the issue in the end does
-not get solved: the Linux kernel is FLOSS and thus you can still help yourself.
-You for example could try to find others that are affected and team up with
-them to get the issue resolved. Such a team could prepare a fresh report
-together that mentions how many you are and why this is something that in your
-option should get fixed. Maybe together you can also narrow down the root cause
-or the change that introduced a regression, which often makes developing a fix
-easier. And with a bit of luck there might be someone in the team that knows a
-bit about programming and might be able to write a fix.
+If the report was proper, you can send a second reminder; in it, ask for advice
+on why the report did not receive any replies. An ideal moment for this is
+shortly after retesting with the first pre-release of a new mainline release
+(the 'rc1'), as you should retest and provide a status update at that point
+anyway (see above).
+
+[:ref:`back to step-by-step guide <reminder_repisbs>`]
+
+
+.. _yourself_repiref:
+
+In most cases nobody is obliged to help
+---------------------------------------
+
+*Be aware that nobody is obliged to help you, unless it is* [:ref:`... <yourself_repisbs>`]
+
+Developers ideally should react somehow to every issue report, but sometimes do
+not reply or, in the end, do not address problems. This is due to reasons
+[:ref:`Why some bugs remain unfixed and some reports are ignored <unfixedbugs_repiapdx>`]
+explains in more detail, which also explains why some code does not even have
+maintainers.
+
+Try to help yourself in that case.
+You, for example, could team up with others affected to then create a better
+report or narrow down the root cause of a problem. With a bit of luck, someone
+on the team might even know a bit about programming and provide a fix.
+
+[:ref:`back to step-by-step guide <yourself_repisbs>`]
 
 
 Appendix: additional background information
-- 
2.51.0


