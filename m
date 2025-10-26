Return-Path: <linux-kernel+bounces-870332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A6CC0A7FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0BD3B06CD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B922E092A;
	Sun, 26 Oct 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fbF2fMxh"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9702D7DCD;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482553; cv=none; b=HYIIJq+FYDuTOotvWvRJMdBai4GQZlYokj2CIKeFfHBl2mnK0wgxmxHzC5louNsD73DrWRvwde5V4c4/ciphOfeJIPNPbPtBMirPNgtJHhoOftSAkItYNZmm9cxV96+8p+jD+LFlRFopNnBVONn3n4VCXmYhEwJcsxpUWexXkEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482553; c=relaxed/simple;
	bh=VFMjt34iiE7rL173jXtwP9Qu1mZQyBO5BjezitHnlfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl1Fy6l8P3n0ch5QfOwHEtjSKivaIVf87NPSBjt7cxe/qeUick6zecZLgVQNLnbF+pS+7AEyNkNvKboTkUDeGKEsDkrii+pUvbTx4fuZlzbLU9pywVdsrkyWKKqQkfLryPuIvARhTHzJfFG0m1gd5QTbW0wg5BGQqv/0/fUokgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fbF2fMxh; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=LBImDqI3AgmfnWBCE/oEL79UonVWSQFWC9Yg5W3f/io=; t=1761482550;
	x=1761914550; b=fbF2fMxhG53BJymHDjgVGq2uCJkJBVgvoGam5xVUEGCOUljQP20WM+s/I0PeQ
	rPgmNe0hXR2gOjrkCi0O0OIhbHwfnAFSjbFcP/w3cNGgclOGEhRzbGKcMCBrffj9jauVqQ3Ap7QQ7
	cj8bqDaBMTcmzOTUWEwIVuYV+o35F+Sj1UQK97WIiMJlWsUnNDQf52y9TC/0uSGJsOkUi+fJxwOSv
	A2yd0ZqZk+cDYCrEhAZ1jItP+dRvlJzXOSQgZXndqQHEXHq2AxNEDdu8w6h5pQ1JnhMlyOjQ/dPYb
	2xCzpYg371nTiRQSqZUCOmfT7lbnUyF8Dep6zn6+DY4R13yRzw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04q-001mYF-3A;
	Sun, 26 Oct 2025 13:42:29 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/30] docs: reporting-issues: improve text on looking up place to report
Date: Sun, 26 Oct 2025 13:42:09 +0100
Message-ID: <9d3ad70d6b0eb75b4d32e5ba04ad3bd3d3d66621.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482550;db804c08;
X-HE-SMSGID: 1vD04q-001mYF-3A

Fine-tune the instructions about checking the MAINTAINERS file.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 169 +++++++++---------
 1 file changed, 86 insertions(+), 83 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index e9d304040e3b54..56e004ba038403 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -149,10 +149,13 @@ following the others is usually in your own interest.
 
  [:ref:`details <reginquiry_repiref>`]
 
- * Locate the driver or kernel subsystem that seems to be causing the issue.
-   Find out how and where its developers expect reports. Note: most of the
-   time this won't be bugzilla.kernel.org, as issues typically need to be sent
-   by mail to a maintainer and a public mailing list.
+.. _maintainers_repisbs:
+
+* *You must* consult ':ref:`MAINTAINERS <maintainers>`' to determine where
+  developers of the affected driver or subsystem want bugs to be submitted to;
+  use your best guess if in doubt which is appropriate.
+
+ [:ref:`details <maintainers_repiref>`]
 
  * Create a fresh backup and put system repair and restore tools at hand.
 
@@ -705,119 +708,121 @@ answer these emails on a best-effort basis.
 [:ref:`back to step-by-step guide <reginquiry_repisbs>`]
 
 
-Check where you need to report your issue
------------------------------------------
+.. _maintainers_repiref:
 
-    *Locate the driver or kernel subsystem that seems to be causing the issue.
-    Find out how and where its developers expect reports. Note: most of the
-    time this won't be bugzilla.kernel.org, as issues typically need to be sent
-    by mail to a maintainer and a public mailing list.*
+Check how to report your issue
+------------------------------
 
-It's crucial to send your report to the right people, as the Linux kernel is a
+  *You must consult MAINTAINERS to determine where developers of the affected
+  driver or subsystem want bugs to be submitted to; use your best guess, if* [:ref:`...  <maintainers_repisbs>`]
+
+It is crucial to submit your report to the right place, as the Linux kernel is a
 big project and most of its developers are only familiar with a small subset of
-it. Quite a few programmers for example only care for just one driver, for
-example one for a WiFi chip; its developer likely will only have small or no
-knowledge about the internals of remote or unrelated "subsystems", like the TCP
-stack, the PCIe/PCI subsystem, memory management or file systems.
+it. Quite a few programmers, for example, only care for just one driver, like
+one for a particular WiFi chip; its developer likely will only have small or no
+knowledge about the internals of near, remote, or unrelated subsystems, like
+the TCP stack, the PCIe/PCI subsystem, memory management, or file systems.
 
-Problem is: the Linux kernel lacks a central bug tracker where you can simply
+Problem is: The Linux kernel lacks a central bug tracker where you can simply
 file your issue and make it reach the developers that need to know about it.
-That's why you have to find the right place and way to report issues yourself.
+That is why you have to find the right place and way to report issues yourself.
 You can do that with the help of a script (see below), but it mainly targets
-kernel developers and experts. For everybody else the MAINTAINERS file is the
-better place.
+kernel developers and experts. For everybody else, using the MAINTAINERS file is
+the better approach.
 
 How to read the MAINTAINERS file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 To illustrate how to use the :ref:`MAINTAINERS <maintainers>` file, let's assume
-the WiFi in your Laptop suddenly misbehaves after updating the kernel. In that
-case it's likely an issue in the WiFi driver. Obviously it could also be some
-code it builds upon, but unless you suspect something like that stick to the
-driver. If it's really something else, the driver's developers will get the
-right people involved.
+the WiFi in your Laptop misbehaves. In that
+case it is likely an issue in the WiFi driver. Obviously it could also be some
+underlying code from other subsystems, but unless something hints at that,
+stick to the driver; if it is really something else, the driver's developers
+will involve the
+right people.
 
 Sadly, there is no way to check which code is driving a particular hardware
 component that is both universal and easy.
 
-In case of a problem with the WiFi driver you for example might want to look at
-the output of ``lspci -k``, as it lists devices on the PCI/PCIe bus and the
+In case of a problem with the WiFi driver, you, for example, might want to look
+at the output of ``lspci -k``, as it lists devices on the PCI/PCIe bus and the
 kernel module driving it::
 
-       [user@something ~]$ lspci -k
-       [...]
-       3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
-         Subsystem: Bigfoot Networks, Inc. Device 1535
-         Kernel driver in use: ath10k_pci
-         Kernel modules: ath10k_pci
-       [...]
+   [user@something ~]$ lspci -k
+   [...]
+   3a:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 32)
+   Subsystem: Bigfoot Networks, Inc. Device 1535
+   Kernel driver in use: ath10k_pci
+   Kernel modules: ath10k_pci
+   [...]
 
 But this approach won't work if your WiFi chip is connected over USB or some
-other internal bus. In those cases you might want to check your WiFi manager or
-the output of ``ip link``. Look for the name of the problematic network
+other internal bus. In those cases you might want to check your network manager
+or the output of ``ip link``. Look for the name of the problematic network
 interface, which might be something like 'wlp58s0'. This name can be used like
 this to find the module driving it::
 
-       [user@something ~]$ realpath --relative-to=/sys/module/ /sys/class/net/wlp58s0/device/driver/module
-       ath10k_pci
+   [user@something ~]$ realpath --relative-to=/sys/module/ /sys/class/net/wlp58s0/device/driver/module
+   ath10k_pci
 
 In case tricks like these don't bring you any further, try to search the
 internet on how to narrow down the driver or subsystem in question. And if you
-are unsure which it is: just try your best guess, somebody will help you if you
-guessed poorly.
+are unsure which it is: Just try your best guess, somebody will usually help out
+if you guessed poorly.
 
 Once you know the driver or subsystem, you want to search for it in the
 MAINTAINERS file. In the case of 'ath10k_pci' you won't find anything, as the
 name is too specific. Sometimes you will need to search on the net for help;
-but before doing so, try a somewhat shorted or modified name when searching the
-MAINTAINERS file, as then you might find something like this::
-
-       QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
-       Mail:          A. Some Human <shuman@example.com>
-       Mailing list:  ath10k@lists.infradead.org
-       Status:        Supported
-       Web-page:      https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
-       SCM:           git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
-       Files:         drivers/net/wireless/ath/ath10k/
-
-Note: the line description will be abbreviations, if you read the plain
-MAINTAINERS file found in the root of the Linux source tree. 'Mail:' for
-example will be 'M:', 'Mailing list:' will be 'L', and 'Status:' will be 'S:'.
-A section near the top of the file explains these and other abbreviations.
-
-First look at the line 'Status'. Ideally it should be 'Supported' or
+but before doing so, try a somewhat shortened or modified name when searching
+the MAINTAINERS file, as then you might find something like this::
+
+   QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
+   Mail:          A. Some Human <shuman@example.com>
+   Mailing list:  ath10k@lists.infradead.org
+   Status:        Supported
+   Web-page:      https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
+   SCM:           git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+   Files:         drivers/net/wireless/ath/ath10k/
+
+Note: Line descriptions like 'Status' will be abbreviations like 'S:' if you
+read the plain MAINTAINERS file found in the root of the Linux source tree.
+
+First look at the line 'Status' ('S:'). Ideally it should be 'Supported' or
 'Maintained'. If it states 'Obsolete' then you are using some outdated approach
 that was replaced by a newer solution you need to switch to. Sometimes the code
 only has someone who provides 'Odd Fixes' when feeling motivated. And with
 'Orphan' you are totally out of luck, as nobody takes care of the code anymore.
-That only leaves these options: arrange yourself to live with the issue, fix it
+That only leaves these options: Arrange yourself to live with the issue, fix it
 yourself, or find a programmer somewhere willing to fix it.
 
-After checking the status, look for a line starting with 'bugs:': it will tell
-you where to find a subsystem specific bug tracker to file your issue. The
+After checking the status, look for a line starting with 'bugs:' ('B:'): It
+will tell you where to find a subsystem-specific bug tracker to file your
+issue. The
 example above does not have such a line. That is the case for most sections, as
-Linux kernel development is completely driven by mail. Very few subsystems use
+Linux kernel development is completely driven by email: Very few subsystems use
 a bug tracker, and only some of those rely on bugzilla.kernel.org.
 
-In this and many other cases you thus have to look for lines starting with
-'Mail:' instead. Those mention the name and the email addresses for the
+In this and many other cases, you thus have to look for lines starting with
+'Mail:' ('M:') instead. Those mention the name and the email addresses for the
 maintainers of the particular code. Also look for a line starting with 'Mailing
-list:', which tells you the public mailing list where the code is developed.
-Your report later needs to go by mail to those addresses. Additionally, for all
-issue reports sent by email, make sure to add the Linux Kernel Mailing List
-(LKML) <linux-kernel@vger.kernel.org> to CC. Don't omit either of the mailing
-lists when sending your issue report by mail later! Maintainers are busy people
-and might leave some work for other developers on the subsystem specific list;
-and LKML is important to have one place where all issue reports can be found.
+List:' ('L:'), which tells you the public mailing list where the code is
+developed. Your report later needs to go by email to those addresses.
+Additionally, for all issue reports sent by email, make sure to add the Linux
+Kernel Mailing List (LKML) <linux-kernel@vger.kernel.org> to CC. Don't omit
+either of the mailing lists when sending your issue report by email later!
+Maintainers are busy people and might leave some work for other developers on
+the subsystem-specific list -- and LKML is important to have one place where all
+issue reports can be found.
 
 
 Finding the maintainers with the help of a script
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-For people that have the Linux sources at hand there is a second option to find
-the proper place to report: the script 'scripts/get_maintainer.pl' which tries
+For people that have the Linux sources at hand, there is a second option to find
+the proper place to report: The script 'scripts/get_maintainer.pl' which tries
 to find all people to contact. It queries the MAINTAINERS file and needs to be
 called with a path to the source code in question. For drivers compiled as
-module if often can be found with a command like this::
+module, it often can be found with a command like this::
 
    $ modinfo ath10k_pci | grep filename | sed 's!/lib/modules/.*/kernel/!!; s!filename:!!; s!\.ko\(\|\.xz\)!!'
    drivers/net/wireless/ath/ath10k/ath10k_pci.ko
@@ -832,20 +837,18 @@ Pass parts of this to the script::
    netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
    linux-kernel@vger.kernel.org (open list)
 
-Don't sent your report to all of them. Send it to the maintainers, which the
-script calls "supporter:"; additionally CC the most specific mailing list for
-the code as well as the Linux Kernel Mailing List (LKML). In this case you thus
-would need to send the report to 'Some Human <shuman@example.com>' with
-'ath10k@lists.infradead.org' and 'linux-kernel@vger.kernel.org' in CC.
+Usually you want to send your report to all of them.
 
-Note: in case you cloned the Linux sources with git you might want to call
+Note: In case you cloned the Linux sources with Git, you might want to call
 ``get_maintainer.pl`` a second time with ``--git``. The script then will look
 at the commit history to find which people recently worked on the code in
-question, as they might be able to help. But use these results with care, as it
-can easily send you in a wrong direction. That for example happens quickly in
-areas rarely changed (like old or unmaintained drivers): sometimes such code is
-modified during tree-wide cleanups by developers that do not care about the
-particular driver at all.
+question, as they might be able to help. But use these results with care, as
+they can easily send you in the wrong direction. That, for example, happens
+quickly in areas rarely changed (like old or unmaintained drivers): Sometimes
+such code is modified during tree-wide cleanups by developers that do not care
+about the particular driver at all.
+
+[:ref:`back to step-by-step guide <maintainers_repisbs>`]
 
 
 Prepare for emergencies
-- 
2.51.0


