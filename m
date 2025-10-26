Return-Path: <linux-kernel+bounces-870349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5CC0A80E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7637734A0B4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464D2E7BB4;
	Sun, 26 Oct 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="grqmNnf2"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02F2DCF65;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482557; cv=none; b=SPYMryORFh2lOqbKf0rS+fOZsj9T2VTewdmG7cr3cJXPM0QLKtAr4mdH68u9uHhqBxXpVbOMjRPdpqj43XYwM8OXQo6bDspP4iSdbiaPunVIOqS7/2jcfgwao7p4NKn5jhUcLEfaXQWPXQhOcZlMwlxUDmuFE5tke/ZaQeOhmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482557; c=relaxed/simple;
	bh=kKbNh5P3MB7UNe2n6wRJ8m4EFNbtUTJ0tM46QLtzYCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3bLT+J/YWwXSEq2Q00e7uiKdJJpD/i6ZDw64ZL7H+dZPGNW9DTVMwgRoKYi8jxPTUPV5WBBO/059Ji0AX/ttdDDspjtDAwQ2M+lWVKhnZqWKaOdtsfNdodvHxunmBELf89zWJlG72LhkqC4j7F7Ba6JDkdTUfsCBRTYklB+p4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=grqmNnf2; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=7xfO2yVPgMJsrmePB23iI1EzaVJiMZt5mKtEwJsE4MI=; t=1761482554;
	x=1761914554; b=grqmNnf2Ms/H1kcyHR12RYfKEx4v09dW3XShe6XbsPSZ340fiPsWOT43pEiXk
	O5AkZss+wG94bhL/WW9PE0R0YenVplBwBmT5Qxx93AiRae07kUMiNTGduXJUaXAl4lZpN9WxY9t0/
	JeaZNK8kdzsWNfzpnAs83HagRpPaHQuNQ6wBm66yuoV8+JzRONCWOySM0AmYT1cQYkWw9TD3mfLlD
	LwIp/mWs4okBUfOuddNdUA0FLOTV+4zqhDjoU871XXExW9c6zxKRkGNvjxOOeaZLR+LiwWxjtYxMT
	lmq/8K2aIgNX2DVIbGYPfvY2xCGFnvC9b+El9UGBn7y8t7gNVw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04u-001mZC-2A;
	Sun, 26 Oct 2025 13:42:32 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 27/30] docs: reporting-issues: make collecting files a separate step
Date: Sun, 26 Oct 2025 13:42:18 +0100
Message-ID: <d8b882675351b12d32977045b2c2db3c323f86e4.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482554;2f8dc1da;
X-HE-SMSGID: 1vD04u-001mZC-2A

Make collecting files a separate step and tone down the need to decode
stack traces somewhat.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 158 +++++++++---------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index aad98ccb49add8..5c991163039f82 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -269,8 +269,34 @@ following the others is usually in your own interest.
 
  [:ref:`details <checkloretwo_repiref>`]
 
- * If your failure involves a 'panic', 'Oops', 'warning', or 'BUG', consider
-   decoding the kernel log to find the line of code that triggered the error.
+.. _attachments_repisbs:
+
+* Collect relevant files to supply with the report.
+
+  It almost always is wise to store the log messages (``journalctl -k``) from
+  the kernel used for the verification to a file. In case of a regression,
+  create a file with log messages from a working kernel, too.
+
+  What else is appropriate to supply depends on your problem. In case of build
+  errors, the build configuration (the '.config' file) used for the verification
+  is important to provide. Other times it is wise to include separate files
+  with the output from commands such as ``lsblk``, ``lspci -nn``, ``lsusb.py``,
+  ``alsa-info.sh``, or ``grep -s '' /sys/class/dmi/id/*``; occasionally the
+  output of ``lscpu``, ``lsirq``, ``lsmod``, ``sudo lspci -vvv``, or ``lsscsi``
+  makes sense, too.
+
+  Only compress files larger than a megabyte. Do not use an archiver to package
+  multiple files together.
+
+  If you later have to file the report in a bug tracker, attach the files. If
+  you have to email it, attach them when they in total are smaller than 250
+  KByte; if they are bigger, attach only the most relevant and send the rest in
+  a reply-to-all to your own report. Alternatively, create a ticket in
+  `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ with a brief note that
+  the ticket is only meant to store files used in a mailed report; attach the
+  files there and later link to them in your report.
+
+ [:ref:`details <attachments_repiref>`]
 
  * Start to compile the report by writing a detailed description about the
    issue. Always mention a few things: the latest kernel version you installed
@@ -1009,58 +1035,77 @@ and potential fixes.
 [:ref:`back to step-by-step guide <checkloretwo_repisbs>`]
 
 
+.. _attachments_repiref:
+
+Collect files to provide
+------------------------
+
+  *Collect relevant files to supply with the report.* [:ref:`... <attachments_repisbs>`]
+
+The developers will usually ask for files with details about your system, as
+what is needed highly depends on the nature of the problem. But it is often
+wise to provide at least the kernel log and maybe a few things along with the
+report, as outlined in the step-by-step guide.
+
+When collecting the kernel's log messages with ``dmesg``, make sure they start
+with a line like 'Linux version 5.8-1 (foobar@example.com) (gcc (GCC) 10.2.1,
+GNU ld version 2.34) #1 SMP Mon Aug 3 14:54:37 UTC 2020'. The kernel discarded
+messages from the first boot phase already if it is missing. In that case,
+instead consider using ``journalctl -k``; alternatively, reboot and reproduce
+the issue, before calling ``dmesg`` right afterwards.
+
+In case the kernel's log messages contain a 'panic', 'Oops', 'warning', or
+'BUG', you might want to decode them as described below if that is easy for you
+-- but that is optional, as many bugs can be solved without this.
+
+On many Linux distributions the tools mentioned by the guide are installed by
+default, except maybe ``alsa-info.sh``, which `the sound subsystem developers
+provide <https://www.alsa-project.org/wiki/AlsaInfo>`_.
+
+
 Decode failure messages
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
-    *If your failure involves a 'panic', 'Oops', 'warning', or 'BUG', consider
-    decoding the kernel log to find the line of code that triggered the error.*
+A 'panic', 'Oops', 'warning', or 'BUG' includes a stack trace, which contains
+addresses that allow pinpointing the exact path to the line in your kernel's
+source code that triggered the issue. Many bugs can be resolved without
+decoding these addresses, but for some it is helpful or required.
 
-When the kernel detects an internal problem, it will log some information about
-the executed code. This makes it possible to pinpoint the exact line in the
-source code that triggered the issue and shows how it was called. But that only
-works if you enabled CONFIG_DEBUG_INFO and CONFIG_KALLSYMS when configuring
-your kernel. If you did so, consider to decode the information from the
-kernel's log. That will make it a lot easier to understand what lead to the
-'panic', 'Oops', 'warning', or 'BUG', which increases the chances that someone
-can provide a fix.
+That is why it is fine to report problems without bothering about this, but
+when asked for this, try to decode the stack trace. Note: This requires a
+kernel build with CONFIG_DEBUG_INFO and CONFIG_KALLSYMS enabled.
 
-Decoding can be done with a script you find in the Linux source tree. If you
-are running a kernel you compiled yourself earlier, call it like this::
+Usually you want to decode using a script shipped in the Linux sources. If you
+are running a kernel you compiled yourself, call it like this::
 
-       [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
+   [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
 
-If you are running a packaged vanilla kernel, you will likely have to install
-the corresponding packages with debug symbols. Then call the script (which you
-might need to get from the Linux sources if your distro does not package it)
-like this::
+If you are running a packaged kernel, you will likely have to install packages
+with the corresponding debug symbols. Then call the script (which you might need
+to fetch from the Linux sources if your distro does not package it) like this::
 
-       [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh \
-        /usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
+   [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh \
+   /usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/debug/kernel-5.10.10-4.1.x86_64/
 
 The script will work on log lines like the following, which show the address of
 the code the kernel was executing when the error occurred::
 
-       [   68.387301] RIP: 0010:test_module_init+0x5/0xffa [test_module]
+   [   68.387301] RIP: 0010:test_module_init+0x5/0xffa [test_module]
 
 Once decoded, these lines will look like this::
 
-       [   68.387301] RIP: 0010:test_module_init (/home/username/linux-5.10.5/test-module/test-module.c:16) test_module
+   [   68.387301] RIP: 0010:test_module_init (/home/user/linux-5.10.5/test-module/test-module.c:16) test_module
 
 In this case the executed code was built from the file
-'~/linux-5.10.5/test-module/test-module.c' and the error occurred by the
+'~/linux-5.10.5/test-module/test-module.c' and the error occurred during the
 instructions found in line '16'.
 
 The script will similarly decode the addresses mentioned in the section
-starting with 'Call trace', which show the path to the function where the
-problem occurred. Additionally, the script will show the assembler output for
-the code section the kernel was executing.
+starting with 'Call trace', which shows the path to the function where the
+problem occurred. The script, furthermore, will show the assembler output for
+the code section the kernel was executing at that time.
 
-Note, if you can't get this to work, simply skip this step and mention the
-reason for it in the report. If you're lucky, it might not be needed. And if it
-is, someone might help you to get things going. Also be aware this is just one
-of several ways to decode kernel stack traces. Sometimes different steps will
-be required to retrieve the relevant details. Don't worry about that, if that's
-needed in your case, developers will tell you what to do.
+[:ref:`back to step-by-step guide <attachments_repisbs>`]
 
 
 Write and send the report
@@ -1119,46 +1164,12 @@ but there are some things you should include always:
  * if you are dealing with a regression and performed a bisection, mention the
    subject and the commit-id of the change that is causing it.
 
-In a lot of cases it's also wise to make two more things available to those
-that read your report:
-
- * the configuration used for building your Linux kernel (the '.config' file)
-
- * the kernel's messages that you get from ``dmesg`` written to a file. Make
-   sure that it starts with a line like 'Linux version 5.8-1
-   (foobar@example.com) (gcc (GCC) 10.2.1, GNU ld version 2.34) #1 SMP Mon Aug
-   3 14:54:37 UTC 2020' If it's missing, then important messages from the first
-   boot phase already got discarded. In this case instead consider using
-   ``journalctl -b 0 -k``; alternatively you can also reboot, reproduce the
-   issue and call ``dmesg`` right afterwards.
-
-These two files are big, that's why it's a bad idea to put them directly into
-your report. If you are filing the issue in a bug tracker then attach them to
-the ticket. If you report the issue by mail do not attach them, as that makes
-the mail too large; instead do one of these things:
-
- * Upload the files somewhere public (your website, a public file paste
-   service, a ticket created just for this purpose on `bugzilla.kernel.org
-   <https://bugzilla.kernel.org/>`_, ...) and include a link to them in your
-   report. Ideally use something where the files stay available for years, as
-   they could be useful to someone many years from now; this for example can
-   happen if five or ten years from now a developer works on some code that was
-   changed just to fix your issue.
-
- * Put the files aside and mention you will send them later in individual
-   replies to your own mail. Just remember to actually do that once the report
-   went out. ;-)
-
 Things that might be wise to provide
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Depending on the issue you might need to add more background data. Here are a
 few suggestions what often is good to provide:
 
- * If you are dealing with a 'warning', an 'OOPS' or a 'panic' from the kernel,
-   include it. If you can't copy'n'paste it, try to capture a netconsole trace
-   or at least take a picture of the screen.
-
  * If the issue might be related to your computer hardware, mention what kind
    of system you use. If you for example have problems with your graphics card,
    mention its manufacturer, the card's model, and what chip is uses. If it's a
@@ -1178,17 +1189,6 @@ few suggestions what often is good to provide:
    its driver. If you have a filesystem issue, mention the version of
    corresponding filesystem utilities (e2fsprogs, btrfs-progs, xfsprogs, ...).
 
- * Gather additional information from the kernel that might be of interest. The
-   output from ``lspci -nn`` will for example help others to identify what
-   hardware you use. If you have a problem with hardware you even might want to
-   make the output from ``sudo lspci -vvv`` available, as that provides
-   insights how the components were configured. For some issues it might be
-   good to include the contents of files like ``/proc/cpuinfo``,
-   ``/proc/ioports``, ``/proc/iomem``, ``/proc/modules``, or
-   ``/proc/scsi/scsi``. Some subsystem also offer tools to collect relevant
-   information. One such tool is ``alsa-info.sh`` `which the audio/sound
-   subsystem developers provide <https://www.alsa-project.org/wiki/AlsaInfo>`_.
-
 Those examples should give your some ideas of what data might be wise to
 attach, but you have to think yourself what will be helpful for others to know.
 Don't worry too much about forgetting something, as developers will ask for
-- 
2.51.0


