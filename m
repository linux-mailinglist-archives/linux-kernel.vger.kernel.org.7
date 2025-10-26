Return-Path: <linux-kernel+bounces-870357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73373C0A838
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC31E3B3ABD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375882EB5B1;
	Sun, 26 Oct 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Ag8GKHQh"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019852DECA5;
	Sun, 26 Oct 2025 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482559; cv=none; b=KMEu22S+hxWyIfn0gyz/6nUacr8hYMfQXoZPrAYVjFmifO9UINpKVrREdRk6jqNnTjTpUavuLe62Z0WYJQcLKMJHK7B3+knrE+aUufho0BYZrfIP5sSRwc+MqXcYZymhJHXK+p4NhjuzEFTelwP3dQJOJQGmJ47zYW63hiwG+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482559; c=relaxed/simple;
	bh=h6SqvcvUog3ZeKTv5PDcD6B9tSNUV8nC3QKFWkF9PX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA6T1Z5CPW+U90Bx7zFblfFDw44gGeKU+m5O/26/53iUYs2rv5TOi8w99b8ntCwv36AfeeS8hVNfJr4lrDBuV+eJP7gHnUEJ59C4nJYJN//OxBWfL56ShhyUYFQPk2pZoLa0V6mZ328YbeHX1zAImA1BBSm/o1zmWJIPu/uHav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Ag8GKHQh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=x532wENFbOyhena6xhVRGm7cbvhCcWeQykKTHgTZZA8=; t=1761482556;
	x=1761914556; b=Ag8GKHQhSsXBddRbFCuKUchSUyu3ORipw1nVqw4GDS/0e3cjgp827vfRkmk1v
	Vb4rKCD3tAbnqg9CS9+Rk+nNuMnRNx2FKcki/ax4g8IovZMkuZD1BLOqfSlGGBMMZjvab0+YmrkrI
	LZjozfG412Ixh6sllE+oQlsI0oRP6pTC/9oSIwNOfyOvcQgc+mVHKz2+C7TslsVepqCu1V/lfDu43
	ovLuOlBCuHf/i8SE99XzPNz5YpQ+b453pOJInPYlGQUnrs1ZwdMNGdOBQtODs+P4TqTKSUDMhDLxZ
	/KBBuB5b8oBCpDO9ZZtbKsdW+nf7LkKEH+6Rqb58FzM9UYliew==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04v-001mZc-31;
	Sun, 26 Oct 2025 13:42:34 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 30/30] docs: reporting-issues: fix a few line breaks
Date: Sun, 26 Oct 2025 13:42:21 +0100
Message-ID: <d510175c21b0a6d00a619527e450600d069c6697.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482556;46d92887;
X-HE-SMSGID: 1vD04v-001mZc-31

Rewrap a few paragraphs that have odd line breaks to keep the diff
clearer in preceding changes. Apart from that no text changes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 230 +++++++++---------
 1 file changed, 111 insertions(+), 119 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index d81d558c245953..3b1519fe80511f 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -615,29 +615,29 @@ Check 'taint' flag
   *Check if the kernel was already 'tainted' when the issue first occurred* [:ref:`... <taintone_repisbs>`]
 
 The kernel marks itself with a 'taint' flag when something happens that might
-lead to follow-up errors looking totally unrelated. Your issue might
-be such an error, in which case there is nothing to report. That is why it is
-in your interest to check the taint status early in the reporting process. This
-is the main reason why this step is here in the guide, as you most likely will
-have to install a different kernel for reporting later -- and then need to
-recheck the flag, as that is when it matters.
+lead to follow-up errors looking totally unrelated. Your issue might be such an
+error, in which case there is nothing to report. That is why it is in your
+interest to check the taint status early in the reporting process. This is the
+main reason why this step is here in the guide, as you most likely will have to
+install a different kernel for reporting later -- and then need to recheck the
+flag, as that is when it matters.
 
 To check the tainted flag, execute ``cat /proc/sys/kernel/tainted``: If it
 returns '0' everything is fine; if it contains a higher number, it is tainted.
 
-In some situations it is impossible to check that file. That is
-why the kernel also mentions the taint status when it reports small (a
-'warning' or a 'bug') or big (an 'Oops' or a 'panic') problems. In such cases,
-search for a line starting with 'CPU:' near the top of the error messages
-printed on the screen or in the log. If the kernel at that point considered
-itself to be fine, it will end with 'Not tainted'; if not, you will see
-'Tainted:' followed by a few spaces and some letters.
+In some situations it is impossible to check that file. That is why the kernel
+also mentions the taint status when it reports small (a 'warning' or a 'bug') or
+big (an 'Oops' or a 'panic') problems. In such cases, search for a line starting
+with 'CPU:' near the top of the error messages printed on the screen or in the
+log. If the kernel at that point considered itself to be fine, it will end with
+'Not tainted'; if not, you will see 'Tainted:' followed by a few spaces and some
+letters.
 
 If your kernel is tainted, check Documentation/admin-guide/tainted-kernels.rst
-to find out why. Note: It is quite possible that the problem you ran into
-caused the kernel to taint itself, in which case you are free to ignore the
-flag. But if the kernel was tainted beforehand, you might have to eliminate the
-cause or rule out that it is an influence.
+to find out why. Note: It is quite possible that the problem you ran into caused
+the kernel to taint itself, in which case you are free to ignore the flag. But
+if the kernel was tainted beforehand, you might have to eliminate the cause or
+rule out that it is an influence.
 
 These are the most frequent reasons why the kernel set the flag:
 
@@ -649,18 +649,17 @@ These are the most frequent reasons why the kernel set the flag:
        Oops: 0000 [#1] SMP
 
    That is the first Oops since boot-up, as the '#1' between the brackets shows.
-   Every later Oops and any other problem that happens afterwards might be
-   a follow-up issue
-   that would never have happened otherwise, even if both look totally unrelated.
-   Rule this out by eliminating the cause for the first Oops and reproducing
-   the issue afterwards. Sometimes simply restarting will be enough; other times
-   a change to the configuration followed by a reboot can eliminate the Oops.
+   Every later Oops and any other problem that happens afterwards might be a
+   follow-up issue that would never have happened otherwise, even if both look
+   totally unrelated.  Rule this out by eliminating the cause for the first Oops
+   and reproducing the issue afterwards. Sometimes simply restarting will be
+   enough; other times a change to the configuration followed by a reboot can
+   eliminate the Oops.
 
    Note: Do not invest too much time into this while you are still on an
-   outdated or vendor kernel: The cause for the Oops might already be fixed in
-   a newer Linux kernel
-   version you most likely will have to install for reporting while following
-   this guide.
+   outdated or vendor kernel: The cause for the Oops might already be fixed in a
+   newer Linux kernel version you most likely will have to install for reporting
+   while following this guide.
 
 2. Your system uses software that installs externally developed kernel modules,
    for example, kernel modules from Nvidia, OpenZFS, VirtualBox, or VMware. The
@@ -838,10 +837,9 @@ development process:
 * You deal with a regression, if some application or practical use case running
   fine with one Linux kernel version works worse or not at all with a newer
   version compiled using a similar configuration; the 'no regression' rule
-  forbids that. The document
-  Documentation/admin-guide/reporting-regressions.rst explains these and
-  additional aspects in more detail, but everything important is covered in
-  this document.
+  forbids that. The document Documentation/admin-guide/reporting-regressions.rst
+  explains these and additional aspects in more detail, but everything important
+  is covered in this document.
 
 * What qualifies as a security issue is left to your judgment. Consider reading
   Documentation/process/security-bugs.rst before proceeding, which
@@ -892,12 +890,10 @@ How to read the MAINTAINERS file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To illustrate how to use the :ref:`MAINTAINERS <maintainers>` file, let's assume
-the WiFi in your Laptop misbehaves. In that
-case it is likely an issue in the WiFi driver. Obviously it could also be some
-underlying code from other subsystems, but unless something hints at that,
-stick to the driver; if it is really something else, the driver's developers
-will involve the
-right people.
+the WiFi in your Laptop misbehaves. In that case it is likely an issue in the
+WiFi driver. Obviously it could also be some underlying code from other
+subsystems, but unless something hints at that, stick to the driver; if it is
+really something else, the driver's developers will involve the right people.
 
 Sadly, there is no way to check which code is driving a particular hardware
 component that is both universal and easy.
@@ -953,9 +949,8 @@ only has someone who provides 'Odd Fixes' when feeling motivated. And with
 That only leaves these options: Arrange yourself to live with the issue, fix it
 yourself, or find a programmer somewhere willing to fix it.
 
-After checking the status, look for a line starting with 'bugs:' ('B:'): It
-will tell you where to find a subsystem-specific bug tracker to file your
-issue. The
+After checking the status, look for a line starting with 'bugs:' ('B:'): It will
+tell you where to find a subsystem-specific bug tracker to file your issue. The
 example above does not have such a line. That is the case for most sections, as
 Linux kernel development is completely driven by email: Very few subsystems use
 a bug tracker, and only some of those rely on bugzilla.kernel.org.
@@ -1158,9 +1153,9 @@ addresses that allow pinpointing the exact path to the line in your kernel's
 source code that triggered the issue. Many bugs can be resolved without
 decoding these addresses, but for some it is helpful or required.
 
-That is why it is fine to report problems without bothering about this, but
-when asked for this, try to decode the stack trace. Note: This requires a
-kernel build with CONFIG_DEBUG_INFO and CONFIG_KALLSYMS enabled.
+That is why it is fine to report problems without bothering about this, but when
+asked for this, try to decode the stack trace. Note: This requires a kernel
+build with CONFIG_DEBUG_INFO and CONFIG_KALLSYMS enabled.
 
 Usually you want to decode using a script shipped in the Linux sources. If you
 are running a kernel you compiled yourself, call it like this::
@@ -1187,10 +1182,10 @@ In this case the executed code was built from the file
 '~/linux-5.10.5/test-module/test-module.c' and the error occurred during the
 instructions found in line '16'.
 
-The script will similarly decode the addresses mentioned in the section
-starting with 'Call trace', which shows the path to the function where the
-problem occurred. The script, furthermore, will show the assembler output for
-the code section the kernel was executing at that time.
+The script will similarly decode the addresses mentioned in the section starting
+with 'Call trace', which shows the path to the function where the problem
+occurred. The script, furthermore, will show the assembler output for the code
+section the kernel was executing at that time.
 
 [:ref:`back to step-by-step guide <attachments_repisbs>`]
 
@@ -1202,10 +1197,10 @@ Prepare and optimize the report
 
   *Prepare and optimize the report.* [:ref:`... <compile_repisbs>`]
 
-Most developers just take a few seconds to skim a report before deciding
-between taking a closer look or moving on, as they receive a ton of messages.
-That is why the title/subject, the first sentence, and the three or four
-following it are crucial.
+Most developers just take a few seconds to skim a report before deciding between
+taking a closer look or moving on, as they receive a ton of messages.  That is
+why the title/subject, the first sentence, and the three or four following it
+are crucial.
 
 People will also stop reading if the report's text is long or hard to follow;
 the same is true if crucial information is not at hand. So be sure to describe
@@ -1373,12 +1368,11 @@ But frequently it is a little less straightforward. That is why the job often
 is only starting once you send a report. What you'll have to do depends on the
 situation. Here are a few tips:
 
-**Check who you deal with**: Most of the time a
-developer for the particular area of code will respond. But as
-issues are usually reported in public, it could be anyone --
-including people that want to help but in the end send you off
-track. That is why it might be wise to run a quick search on `lore <https://lore.kernel.org/all/>`_
-to see who you are interacting with.
+**Check who you deal with**: Most of the time a developer for the particular
+area of code will respond. But as issues are usually reported in public, it
+could be anyone -- including people that want to help but in the end send you
+off track. That is why it might be wise to run a quick search on `lore
+<https://lore.kernel.org/all/>`_ to see who you are interacting with.
 
 **Inquiries for data**: Often you will be asked to test something or provide
 additional details. Try to supply the requested information soon, as you have
@@ -1412,21 +1406,21 @@ do not rush it: Mixing things up can happen easily and leads to a lot of
 confusion. A common mistake, for example, is thinking a proposed fix was applied
 when building a test kernel, when in fact it was not.
 
-**Try to help yourself** before asking for help: During this part of the
-process someone might tell you to do something that requires a skill you might
-not have mastered yet. For example, you might be asked to use some test tools
-you have never heard of yet; or you are asked to apply a patch to the
-Linux kernel sources to test. It usually will be fine replying asking for
-instructions on how to do that. But before going that route, try to find the
-answer on your own by searching the internet; alternatively,
-consider asking elsewhere for advice. For example, ask a friend or post
-your question to a chat room or forum you normally hang out in.
+**Try to help yourself** before asking for help: During this part of the process
+someone might tell you to do something that requires a skill you might not have
+mastered yet. For example, you might be asked to use some test tools you have
+never heard of yet; or you are asked to apply a patch to the Linux kernel
+sources to test. It usually will be fine replying asking for instructions on how
+to do that. But before going that route, try to find the answer on your own by
+searching the internet; alternatively, consider asking elsewhere for advice. For
+example, ask a friend or post your question to a chat room or forum you normally
+hang out in.
 
 **Be patient**: If you are really lucky, you might receive a reply to your
 report within a few hours. But most of the time it will take longer, as
-maintainers might be in a different time zone -- one where people currently
-take a few days off or already enjoy their night away from the keyboard. They
-might also simply be busy with other work, on a trip to a conference, or simply
+maintainers might be in a different time zone -- one where people currently take
+a few days off or already enjoy their night away from the keyboard. They might
+also simply be busy with other work, on a trip to a conference, or simply
 enjoying a long holiday.
 
 [:ref:`back to step-by-step guide <keeprolling_repisbs>`]
@@ -1462,12 +1456,12 @@ What to do when nothing of substance happens
   *If things stall for more than two to three weeks, evaluate why. It can
   happen due to good or bad reasons, like* [:ref:`... <reminder_repisbs>`]
 
-Sometimes you will not receive any reaction from the responsible
-developers; or a discussion around the issue evolves but ends fruitlessly.
+Sometimes you will not receive any reaction from the responsible developers; or
+a discussion around the issue evolves but ends fruitlessly.
 
-In these cases, wait two to three weeks before sending a friendly
-reminder: Maybe the right developers were just away from their keyboards when
-you sent your report or had something more important to take care of.
+In these cases, wait two to three weeks before sending a friendly reminder:
+Maybe the right developers were just away from their keyboards when you sent
+your report or had something more important to take care of.
 
 When writing the reminder, kindly ask if there was anything wrong with the
 report or if anything from your side is needed to get the ball rolling. If the
@@ -1477,17 +1471,16 @@ the recipients will have both the gist of the problem and the details at hand
 immediately in convenient order.
 
 After sending a reminder, wait three more weeks for replies. If you still don't
-receive a proper reaction, reconsider your approach. Did you maybe try
-to reach out to the wrong people? Was the report possibly offensive or so
-confusing that people decided to stay away from it?
-
-The best way to
-rule out such factors: Show the report to one or two people familiar with FLOSS
-issue reporting and ask for their opinion. Also ask them for their advice on how
-to move forward. That might mean preparing a better report and making those
-people review it before sending it out. Such an approach is totally fine; just
-mention that this is the second and improved report on the issue and include a
-link to the first report.
+receive a proper reaction, reconsider your approach. Did you maybe try to reach
+out to the wrong people? Was the report possibly offensive or so confusing that
+people decided to stay away from it?
+
+The best way to rule out such factors: Show the report to one or two people
+familiar with FLOSS issue reporting and ask for their opinion. Also ask them for
+their advice on how to move forward. That might mean preparing a better report
+and making those people review it before sending it out. Such an approach is
+totally fine; just mention that this is the second and improved report on the
+issue and include a link to the first report.
 
 If the report was proper, you can send a second reminder; in it, ask for advice
 on why the report did not receive any replies. An ideal moment for this is
@@ -1507,14 +1500,14 @@ In most cases nobody is obliged to help
 
 Developers ideally should react somehow to every issue report, but sometimes do
 not reply or, in the end, do not address problems. This is due to reasons
-[:ref:`Why some bugs remain unfixed and some reports are ignored <unfixedbugs_repiapdx>`]
-explains in more detail, which also explains why some code does not even have
-maintainers.
+[:ref:`Why some bugs remain unfixed and some reports are ignored
+<unfixedbugs_repiapdx>`] explains in more detail, which also explains why some
+code does not even have maintainers.
 
-Try to help yourself in that case.
-You, for example, could team up with others affected to then create a better
-report or narrow down the root cause of a problem. With a bit of luck, someone
-on the team might even know a bit about programming and provide a fix.
+Try to help yourself in that case.  You, for example, could team up with others
+affected to then create a better report or narrow down the root cause of a
+problem. With a bit of luck, someone on the team might even know a bit about
+programming and provide a fix.
 
 [:ref:`back to step-by-step guide <yourself_repisbs>`]
 
@@ -1548,35 +1541,34 @@ test. The former can happen when the publicly available docs are superficial or
 when a driver was written with the help of reverse engineering.
 
 Sooner or later, spare-time developers usually stop caring for the driver.
-Maybe their test hardware broke, was replaced by something more fancy, or
-became so old that it is something you don't find much outside of computer
-museums anymore. Other times developers also stop caring when
-something different in life becomes more important to them. Then sometimes
-nobody is willing to take over the job as maintainer -- and nobody else can be
-forced to, as contributing is voluntary. The code nevertheless often stays
-around, as it is useful for people; removing it would also cause a regression,
-which is not allowed in Linux.
-
-The situation is not that different with developers that are paid for their
-work on the upstream Linux kernel. Those contribute the most changes these days.
-But their employers set the priorities. And those sooner or later stop caring
-for some code or make their
-employees focus on other things. Hardware vendors, for example, earn their money
-mainly by selling new hardware -- they thus often are not much interested in
-investing much time and energy in maintaining a Linux kernel driver for a chip
-they stopped selling years ago. Enterprise Linux distributors often care for a
-longer time period, but in new versions might set support for old and rare
-hardware aside to limit the scope, too. Often spare-time contributors take over
-once employed developers orphan some code, but as mentioned earlier: Sooner or
-later they will usually leave the code behind, too.
-
-Priorities are another reason why some issues are not fixed, as developers
-quite often are forced to set those: The spare-time of volunteers or the time
+Maybe their test hardware broke, was replaced by something more fancy, or became
+so old that it is something you don't find much outside of computer museums
+anymore. Other times developers also stop caring when something different in
+life becomes more important to them. Then sometimes nobody is willing to take
+over the job as maintainer -- and nobody else can be forced to, as contributing
+is voluntary. The code nevertheless often stays around, as it is useful for
+people; removing it would also cause a regression, which is not allowed in
+Linux.
+
+The situation is not that different with developers that are paid for their work
+on the upstream Linux kernel. Those contribute the most changes these days.  But
+their employers set the priorities. And those sooner or later stop caring for
+some code or make their employees focus on other things. Hardware vendors, for
+example, earn their money mainly by selling new hardware -- they thus often are
+not much interested in investing much time and energy in maintaining a Linux
+kernel driver for a chip they stopped selling years ago. Enterprise Linux
+distributors often care for a longer time period, but in new versions might set
+support for old and rare hardware aside to limit the scope, too. Often
+spare-time contributors take over once employed developers orphan some code, but
+as mentioned earlier: Sooner or later they will usually leave the code behind,
+too.
+
+Priorities are another reason why some issues are not fixed, as developers quite
+often are forced to set those: The spare-time of volunteers or the time
 employers allot for upstream Linux kernel work is often limited. Sometimes
 developers are also flooded with good and bad reports, even if a driver is
-working well. To
-not get completely stuck, the programmers might have no other choice than
-to prioritize bug reports and ignore some.
+working well. To not get completely stuck, the programmers might have no other
+choice than to prioritize bug reports and ignore some.
 
 But do not worry too much about all of this, a lot of drivers have active
 maintainers who are quite interested in fixing as many issues as possible.
-- 
2.51.0


