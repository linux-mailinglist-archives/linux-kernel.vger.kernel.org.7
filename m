Return-Path: <linux-kernel+bounces-870351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADDC0A826
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08D94EBAD3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99282E8E16;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="APpdyciq"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1E2DD5EF;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482558; cv=none; b=EAbKX6oHs+lb6pqFRSg7ucWB9rvM60JRUrABpwvJw4qi5msYe+g/ussI94uHs8MbBOyJ+mElFNCNh7lC2e0dITsiUBwQtzebUfN+XzcOJVm71YiS6J8zUKnVdmO1cWSscqu5Uef5qKA9huZVp3UAHoaZzm6Ey1sifG8oYToR69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482558; c=relaxed/simple;
	bh=IqDhGtp4nyvxdpoe48xN9U6qWwQ3W54JbdWSQG/FjaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKiRP2ExloaR4ZSxq1tHyVUMmovgkbyTWT4QQbVxgiaG0+5b6VGREm1X7YnZbHMV2V2CiWbGqt0lplkpQJhf9Qr2biUN7aNj1CacmQ3Bmm9Y05NFy4LQ/fITm8JAzdyxDnoJ17cq5ZqKIQF0TckDYUuKMbmz0XEta/kuQT81Wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=APpdyciq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=z/mmDtnORp4tMTfolU1iwiCKThwrxaag3p5onqizLFY=; t=1761482554;
	x=1761914554; b=APpdyciqkedRsoanh/bqcCZ5Bg+QLvH6SboUCHDROA6uxyBvzFNKhZvoqiFHY
	z12vwkjWA8dRs61qnqRdZgdiA/2sUf3nw6x4auCnv9SPnMNTpIO5Pyvp1QKaVJgjaz6coATSDX1Z3
	8iFfIOhKiaSxaM7xB8gzFEr0gJJHg0DhQl3zGepezHMb0rmjUrhNq4plr51OoU9wAGdc5Zm55ZJx7
	hlb0o6PYP/7z5nB6e3rAUn6uVitlD4mlnnEyYV/ybq3IDFkTT8T4vMyAMYfB/jebUVv4cEsaIVTRU
	GqNUocYCLpgABZ2/sqgZDvUlwvF7TiewvktA0wd2v9v8AsXIIg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04u-001mZC-3A;
	Sun, 26 Oct 2025 13:42:33 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 28/30] docs: reporting-issues: separate steps for optimizing and submitting reports
Date: Sun, 26 Oct 2025 13:42:19 +0100
Message-ID: <13f6dd4470f388220cc559d88afc490aa1c8cd12.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482555;32bd3f7a;
X-HE-SMSGID: 1vD04u-001mZC-3A

Make optimizing and submitting reports separate steps. The latter now
needs to cover regressions as well, which earlier was handled by a
separate section.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 341 ++++++++++--------
 1 file changed, 199 insertions(+), 142 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 5c991163039f82..c147191a7d0987 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -298,21 +298,79 @@ following the others is usually in your own interest.
 
  [:ref:`details <attachments_repiref>`]
 
- * Start to compile the report by writing a detailed description about the
-   issue. Always mention a few things: the latest kernel version you installed
-   for reproducing, the Linux Distribution used, and your notes on how to
-   reproduce the issue. Ideally, make the kernel's build configuration
-   (.config) and the output from ``dmesg`` available somewhere on the net and
-   link to it. Include or upload all other information that might be relevant,
-   like the output/screenshot of an Oops or the output from ``lspci``. Once
-   you wrote this main part, insert a normal length paragraph on top of it
-   outlining the issue and the impact quickly. On top of this add one sentence
-   that briefly describes the problem and gets people to read on. Now give the
-   thing a descriptive title or subject that yet again is shorter. Then you're
-   ready to send or file the report like the MAINTAINERS file told you, unless
-   you are dealing with one of those 'issues of high priority': they need
-   special care which is explained in 'Special handling for high priority
-   issues' below.
+.. _compile_repisbs:
+
+* Prepare and optimize the report.
+
+  Start by writing a text describing the problem. Ensure it contains all the
+  important bits directly so that readers do not have to open attachments or
+  follow links to understand roughly what the report is about -- you thus might
+  want to copy error messages and similarly important parts from supplied files
+  into the text.
+
+  Early on in the text, mention the distribution and kernel version used for the
+  bug verification.
+
+  In case of a regression, start the subject with '[REGRESSION]'. Furthermore,
+  specify early in the text the latest working versions and all known to be
+  broken; if you performed a bisection, mention the culprit's commit-id, title,
+  and authors instead.
+
+  Mention the Linux distribution used and other aspects of your environment
+  that might be relevant, like the machine's model name, the hardware
+  components involved, or the version of related userspace drivers.
+
+  Make sure to not overload the report with a long problem description, too
+  many details, or many attachments: Developers will ask for additional
+  information when needed.
+
+  Now write a subject, which is the only thing most people will read -- hence
+  try hard to make it as descriptive as possible without making it overly long,
+  as that is your best chance to grab people's attention. Your second best
+  chance is the first paragraph. If your problem description is longer than two
+  or three paragraphs, you thus want to create a small intro paragraph
+  describing the gist of the problem; if it is shorter, optimize the early
+  sentences.
+
+  At the end, review and optimize the report once more to make it as
+  straightforward as possible while ensuring the problem is easy to grasp for
+  people new to it.
+
+ [:ref:`details <compile_repiref>`]
+
+.. _submit_repisbs:
+
+* Submit your report in the appropriate way, which depends on the outcome of
+  the verification and the MAINTAINERS entry.
+
+  * Are you facing a regression within a stable or longterm kernel series you
+    were unable to reproduce with a fresh mainline kernel? Then report it by
+    email to the stable team while CCing the regressions list (To: Greg
+    Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>;
+    CC: stable@vger.kernel.org, regressions@lists.linux.dev); if you performed a
+    bisection, CC everyone in the culprit's 'Signed-off-by' chain, too.
+
+  * In all other cases, submit the report as specified in MAINTAINERS while
+    keeping Documentation/process/security-bugs.rst in mind in case you deal
+    with a security issue:
+
+    * If that means reporting by email, CC linux-kernel@vger.kernel.org. In case
+      of a regression, CC regressions@lists.linux.dev, too -- and when the
+      culprit is known, also everyone in its 'Signed-off-by' chain, while
+      addressing the email to the culprit's author.
+
+    * If that means submitting a regression to a bug tracker, perform
+      one more thing afterwards: Write a short heads-up email with a link to the
+      report to regressions@lists.linux.dev -- and if the culprit is known, CC
+      everyone that signed it off, while addressing the email to the culprit's
+      author.
+
+  Whichever way it is, in case you sent the brief inquiry mentioned initially
+  to the regressions list, try to keep that discussion involved: Either send
+  your report as a reply to the earlier inquiry while adding relevant parties
+  or send a quick reply-to-self with a link to the proper report.
+
+ [:ref:`details <submit_repiref>`]
 
  * Wait for reactions and keep the thing rolling until you can accept the
    outcome in one way or the other. Thus react publicly and in a timely manner
@@ -1108,166 +1166,165 @@ the code section the kernel was executing at that time.
 [:ref:`back to step-by-step guide <attachments_repisbs>`]
 
 
-Write and send the report
--------------------------
-
-    *Start to compile the report by writing a detailed description about the
-    issue. Always mention a few things: the latest kernel version you installed
-    for reproducing, the Linux Distribution used, and your notes on how to
-    reproduce the issue. Ideally, make the kernel's build configuration
-    (.config) and the output from ``dmesg`` available somewhere on the net and
-    link to it. Include or upload all other information that might be relevant,
-    like the output/screenshot of an Oops or the output from ``lspci``. Once
-    you wrote this main part, insert a normal length paragraph on top of it
-    outlining the issue and the impact quickly. On top of this add one sentence
-    that briefly describes the problem and gets people to read on. Now give the
-    thing a descriptive title or subject that yet again is shorter. Then you're
-    ready to send or file the report like the MAINTAINERS file told you, unless
-    you are dealing with one of those 'issues of high priority': they need
-    special care which is explained in 'Special handling for high priority
-    issues' below.*
-
-Now that you have prepared everything it's time to write your report. How to do
-that is partly explained by the three documents linked to in the preface above.
-That's why this text will only mention a few of the essentials as well as
-things specific to the Linux kernel.
-
-There is one thing that fits both categories: the most crucial parts of your
-report are the title/subject, the first sentence, and the first paragraph.
-Developers often get quite a lot of mail. They thus often just take a few
-seconds to skim a mail before deciding to move on or look closer. Thus: the
-better the top section of your report, the higher are the chances that someone
-will look into it and help you. And that is why you should ignore them for now
-and write the detailed report first. ;-)
+.. _compile_repiref:
+
+Prepare and optimize the report
+-------------------------------
+
+  *Prepare and optimize the report.* [:ref:`... <compile_repisbs>`]
+
+Most developers just take a few seconds to skim a report before deciding
+between taking a closer look or moving on, as they receive a ton of messages.
+That is why the title/subject, the first sentence, and the three or four
+following it are crucial.
+
+People will also stop reading if the report's text is long or hard to follow;
+the same is true if crucial information is not at hand. So be sure to describe
+things as short, straightforward, and simple as possible while providing
+everything important.
+
+How to do that is partly explained by the three documents linked to in the
+reference section's intro. The next few subsections thus will only mention a
+few essentials as well as things specific to the Linux kernel.
+
 
 Things each report should mention
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Describe in detail how your issue happens with the fresh vanilla kernel you
-installed. Try to include the step-by-step instructions you wrote and optimized
-earlier that outline how you and ideally others can reproduce the issue; in
-those rare cases where that's impossible try to describe what you did to
-trigger it.
+Describe the problem while mentioning all the important details about the
+environment others might need to fully understand the issue.:
+
+* The output from ``uname -r`` from the Linux kernel used for the verification.
 
-Also include all the relevant information others might need to understand the
-issue and its environment. What's actually needed depends a lot on the issue,
-but there are some things you should include always:
+* The Linux distribution used (``hostnamectl | grep 'Operating System'``)
 
- * the output from ``cat /proc/version``, which contains the Linux kernel
-   version number and the compiler it was built with.
+* The nature of the issue and when it occurs.
 
- * the Linux distribution the machine is running (``hostnamectl | grep
-   "Operating System"``)
+* If you are dealing with a regression and performed a bisection, mention
+  The author, subject, and commit-id of the culprit change.
 
- * the architecture of the CPU and the operating system (``uname -mi``)
+* If you are dealing with a 'warning', an 'OOPS' or a 'panic' from the kernel,
+  include it. If you can't copy and paste it, take a picture of the screen.
 
- * if you are dealing with a regression and performed a bisection, mention the
-   subject and the commit-id of the change that is causing it.
 
-Things that might be wise to provide
+Things that might be good to provide
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Depending on the issue you might need to add more background data. Here are a
-few suggestions what often is good to provide:
-
- * If the issue might be related to your computer hardware, mention what kind
-   of system you use. If you for example have problems with your graphics card,
-   mention its manufacturer, the card's model, and what chip is uses. If it's a
-   laptop mention its name, but try to make sure it's meaningful. 'Dell XPS 13'
-   for example is not, because it might be the one from 2012; that one looks
-   not that different from the one sold today, but apart from that the two have
-   nothing in common. Hence, in such cases add the exact model number, which
-   for example are '9380' or '7390' for XPS 13 models introduced during 2019.
-   Names like 'Lenovo Thinkpad T590' are also somewhat ambiguous: there are
-   variants of this laptop with and without a dedicated graphics chip, so try
-   to find the exact model name or specify the main components.
-
- * Mention the relevant software in use. If you have problems with loading
-   modules, you want to mention the versions of kmod, systemd, and udev in use.
-   If one of the DRM drivers misbehaves, you want to state the versions of
-   libdrm and Mesa; also specify your Wayland compositor or the X-Server and
-   its driver. If you have a filesystem issue, mention the version of
-   corresponding filesystem utilities (e2fsprogs, btrfs-progs, xfsprogs, ...).
-
-Those examples should give your some ideas of what data might be wise to
-attach, but you have to think yourself what will be helpful for others to know.
+In some cases it is wise to provide additional details:
+
+* The processor architecture used (``uname -mi``).
+
+* The relevant software in use. If you have problems with loading
+  modules, you want to mention the versions of kmod, systemd, and udev in use.
+  If one of the DRM drivers misbehaves, you want to state the versions of
+  libdrm and Mesa; also specify your Wayland compositor or the X-Server and
+  its driver.
+
+* If the issue might be related to your hardware, mention what kind
+  of system you use. If you, for example, have problems with your graphics card,
+  mention its manufacturer, the card's model, and what chip it uses. If it is a
+  laptop, specify its name, but try to make sure it is meaningful. 'Dell XPS
+  13', for example, is not, because that might be the one from 2012 or 2020;
+  the latter might not look that different, but apart from that it shares
+  nothing with the former. In such cases add the exact model number, like '9380'
+  or '7390' for XPS 13 models introduced during 2019. Names like 'Lenovo
+  Thinkpad T590' are also somewhat ambiguous: There are variants of this laptop
+  with and without a dedicated graphics chip, so try to find the exact model
+  name or specify the main components.
+
+Those examples should give you some ideas of what data might be wise to
+specify, but you have to think through yourself what will be helpful for others
+to know.
+
 Don't worry too much about forgetting something, as developers will ask for
 additional details they need. But making everything important available from
 the start increases the chance someone will take a closer look.
 
+Special handling for high-priority issues
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The important part: the head of your report
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Reports for high-priority issues need special handling:
 
-Now that you have the detailed part of the report prepared let's get to the
-most important section: the first few sentences. Thus go to the top, add
-something like 'The detailed description:' before the part you just wrote and
-insert two newlines at the top. Now write one normal length paragraph that
-describes the issue roughly. Leave out all boring details and focus on the
-crucial parts readers need to know to understand what this is all about; if you
-think this bug affects a lot of users, mention this to get people interested.
+* Regressions: Make the report's subject start with '[REGRESSION]'.
 
-Once you did that insert two more lines at the top and write a one sentence
-summary that explains quickly what the report is about. After that you have to
-get even more abstract and write an even shorter subject/title for the report.
+  In case you performed a successful bisection, use the title of the change that
+  introduced the regression as the second part of your subject. Make the report
+  also mention the commit-id of the culprit. In case of an unsuccessful
+  bisection, make your report mention the latest tested version that is working
+  fine (say 5.7) and the oldest where the issue occurs (say 5.8-rc1).
 
-Now that you have written this part take some time to optimize it, as it is the
-most important parts of your report: a lot of people will only read this before
-they decide if reading the rest is time well spent.
+  When sending the report by email, CC the Linux regressions mailing list
+  (regressions@lists.linux.dev). In case the report needs to be filed to some
+  web tracker, proceed to do so. Once filed, forward the report by email to the
+  regressions list; CC the maintainer and the mailing list for the subsystem in
+  question. Make sure to inline the forwarded report and do not attach it.
+  Also add a short note at the top where you mention the URL to the ticket.
 
-Now send or file the report like the :ref:`MAINTAINERS <maintainers>` file told
-you, unless it's one of those 'issues of high priority' outlined earlier: in
-that case please read the next subsection first before sending the report on
-its way.
+  When mailing or forwarding the report, in case of a successful bisection, add
+  the author of the culprit to the recipients; also CC everyone in the
+  signed-off-by   chain, which you find at the end of its commit message.
 
-Special handling for high priority issues
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+* Security issues: For these issues you will have to evaluate if a
+  short-term risk to other users would arise if details were publicly disclosed.
+  If that is not the case, simply proceed with reporting the issue as described.
+  For issues that bear such a risk, you will need to adjust the reporting
+  process slightly:
 
-Reports for high priority issues need special handling.
+  * If the MAINTAINERS file instructed you to report the issue by email, do not
+    CC any public mailing lists.
 
-**Severe issues**: make sure the subject or ticket title as well as the first
-paragraph makes the severeness obvious.
+  * If you were supposed to file the issue in a bug tracker, make sure to mark
+    the ticket as 'private' or 'security issue'. If the bug tracker does not
+    offer a way to keep reports private, forget about it and send your report as
+    a private email to the maintainers instead.
 
-**Regressions**: make the report's subject start with '[REGRESSION]'.
+ In both cases, make sure to also email your report to the addresses the
+ MAINTAINERS file lists in the section 'security contact'. Ideally, directly CC
+ them when sending the report by email. If you filed it in a bug tracker, forward
+ the report's text to these addresses; but on top of it, put a small note where
+ you mention that you filed it with a link to the ticket.
 
-In case you performed a successful bisection, use the title of the change that
-introduced the regression as the second part of your subject. Make the report
-also mention the commit id of the culprit. In case of an unsuccessful bisection,
-make your report mention the latest tested version that's working fine (say 5.7)
-and the oldest where the issue occurs (say 5.8-rc1).
+ See Documentation/process/security-bugs.rst for more information.
 
-When sending the report by mail, CC the Linux regressions mailing list
-(regressions@lists.linux.dev). In case the report needs to be filed to some web
-tracker, proceed to do so. Once filed, forward the report by mail to the
-regressions list; CC the maintainer and the mailing list for the subsystem in
-question. Make sure to inline the forwarded report, hence do not attach it.
-Also add a short note at the top where you mention the URL to the ticket.
+Optimize the report and especially its head section
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-When mailing or forwarding the report, in case of a successful bisection add the
-author of the culprit to the recipients; also CC everyone in the signed-off-by
-chain, which you find at the end of its commit message.
+Once you have everything covered in your report, it is wise to optimize the
+most important section: The first few sentences.
 
-**Security issues**: for these issues your will have to evaluate if a
-short-term risk to other users would arise if details were publicly disclosed.
-If that's not the case simply proceed with reporting the issue as described.
-For issues that bear such a risk you will need to adjust the reporting process
-slightly:
+If the report is long, it is usually a good idea to go to the top, add
+something like 'The detailed description:' before the part you just wrote, and
+insert two newlines at the top. Now write one normal length paragraph that
+describes the issue roughly. Leave out all boring details and focus on the
+crucial parts readers need to know to understand what this is all about.
+
+Whenever you have or do not have such a paragraph with a gist, ideally start the
+report with one sentence that explains quickly what the report is about.
+
+Now try to write an even shorter subject/title for the report.
 
- * If the MAINTAINERS file instructed you to report the issue by mail, do not
-   CC any public mailing lists.
+Spending time on these things is time well spent, as a lot of people will only
+read the subject and maybe the first sentence or two before they decide if
+reading the rest is worth it for them.
+
+Now send or file the report like the :ref:`MAINTAINERS <maintainers>` file told
+you, unless it is one of those 'issues of high-priority' outlined earlier: In
+that case, please read the next subsection first before sending the report on
+its way.
+
+[:ref:`back to step-by-step guide <compile_repisbs>`]
+
+
+.. _submit_repiref:
+
+Submit the report
+-----------------
 
- * If you were supposed to file the issue in a bug tracker make sure to mark
-   the ticket as 'private' or 'security issue'. If the bug tracker does not
-   offer a way to keep reports private, forget about it and send your report as
-   a private mail to the maintainers instead.
+  *Submit your report in the appropriate way, which depends on the outcome* [:ref:`... <submit_repisbs>`]
 
-In both cases make sure to also mail your report to the addresses the
-MAINTAINERS file lists in the section 'security contact'. Ideally directly CC
-them when sending the report by mail. If you filed it in a bug tracker, forward
-the report's text to these addresses; but on top of it put a small note where
-you mention that you filed it with a link to the ticket.
+The step-by-step guide covers all the important details already.
 
-See Documentation/process/security-bugs.rst for more information.
+[:ref:`back to step-by-step guide <submit_repisbs>`]
 
 
 Duties after the report went out
-- 
2.51.0


