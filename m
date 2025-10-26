Return-Path: <linux-kernel+bounces-870341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45656C0A802
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D1118A13D7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99C2E3B07;
	Sun, 26 Oct 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="2Axv5OB4"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6822DAFA2;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482555; cv=none; b=EiF3yqISQHrdwe3GW/tR0yT3kk2N6ssxw5eECdkrQRxU0uKkPcq5FjMH9rd9pScma8yOnIAUdsPQikNyjEpfDqRddSC43JPS39GUWfjGgXHowc1KP2lDwNQi1+Cr1kBG4WLrNB2c3fthQqm88jFgi11AIv30gR/IWT1zFXd5gaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482555; c=relaxed/simple;
	bh=mIfOql5N32gMBe8X0YcC5hGJmUeX5bAGGFy1Owp4xsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2ZwVbb9yEe7RFVoIY0GEiRFgTGn/ZqM9QrtjMS0MD/pSYuBRvlDyKBCINbKKF8QaUdsrOsZdyrnpwPAQSM+Lpuuy4XaZRgztLLBCQeSB6NZGpy5WkP/QfZ/uXdD4+MOXSrwL/xSiWZpfqkszAdfzQQ21fZEjMf+SdD1sncqiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=2Axv5OB4; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CSmPZuTVU5I53EMM1NfC1a+zinZRXjBZwbdJiYWrI/k=; t=1761482552;
	x=1761914552; b=2Axv5OB4hhu0eXwgpTOeu3zO1ZS5QyqJAq/gW/ecv3Uu1blQpKjyoalFSjJ6T
	jULiqpa/wFa+r7xtYHzIZ9cMS00jY4THu/Cmb2mAqYCXssc4s1RGE2u7bf+4Wdt8nqtuNFZrWVk1S
	PzDpX7NacLOBVaa1VOm6kY00xV3VPGJVcNxFKVLLfmtZblIeXnYOFg7QjycEMLCS4jWf32KsfwSKd
	Qj9Sgnv4NROzh6I5ac592DcXzOqfjMkLW13BKwJRLYhrVr9MZoNDl3ef0kF4Hrjap0z52oLD58smT
	tOqM4T/Vaox42GlDMXP/DwBMLClalBmhxV1qjz/ppmwSMFJ61g==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04m-001mXP-2z;
	Sun, 26 Oct 2025 13:42:24 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/30] docs: reporting-issues: explain need for fresh vanilla kernel
Date: Sun, 26 Oct 2025 13:41:58 +0100
Message-ID: <616e01c3b2212e3dc7c7cc40f551618092f40c62.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482552;81a32109;
X-HE-SMSGID: 1vD04m-001mXP-2z

Rewrite the section that explains why a fresh kernel is needed and why
bug reporters might have to compile one themselves for testing and
debugging purposes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 141 +++++++++++-------
 1 file changed, 85 insertions(+), 56 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 7dfb3ca4b3e322..2f387e8766f21d 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -49,11 +49,25 @@ Step-by-step guide on reporting Linux kernel issues
 Note: Only the steps starting with '*you must*' are strictly required -- but
 following the others is usually in your own interest.
 
- * Are you facing an issue with a Linux kernel a hardware or software vendor
-   provided? Then in almost all cases you are better off to stop reading this
-   document and reporting the issue to your vendor instead, unless you are
-   willing to install the latest Linux version yourself. Be aware the latter
-   will often be needed anyway to hunt down and fix issues.
+.. _intro_repisbs:
+
+* Be aware:
+
+  * You should report issues using a Linux kernel that is both really fresh and
+    vanilla. That often means that you will have to remove software that
+    requires externally developed kernel modules and install the newest upstream
+    Linux development kernel yourself.
+
+  * There is a decent chance you will have to report the problem by email, in
+    which case your email address will become part of public archives.
+
+  * You might need to patch and build your own kernel to help developers debug
+    and fix the bug.
+
+ If these three aspects sound too demanding, consider reporting the issue to
+ your Linux distributor or hardware manufacturer instead.
+
+ [:ref:`details <intro_repiref>`]
 
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
@@ -265,57 +279,72 @@ With that off the table, find below details for the steps from the detailed
 guide on reporting issues to the Linux kernel developers.
 
 
-Make sure you're using the upstream Linux kernel
-------------------------------------------------
-
-   *Are you facing an issue with a Linux kernel a hardware or software vendor
-   provided? Then in almost all cases you are better off to stop reading this
-   document and reporting the issue to your vendor instead, unless you are
-   willing to install the latest Linux version yourself. Be aware the latter
-   will often be needed anyway to hunt down and fix issues.*
-
-Like most programmers, Linux kernel developers don't like to spend time dealing
-with reports for issues that don't even happen with their current code. It's
-just a waste everybody's time, especially yours. Unfortunately such situations
-easily happen when it comes to the kernel and often leads to frustration on both
-sides. That's because almost all Linux-based kernels pre-installed on devices
-(Computers, Laptops, Smartphones, Routers, …) and most shipped by Linux
-distributors are quite distant from the official Linux kernel as distributed by
-kernel.org: these kernels from these vendors are often ancient from the point of
-Linux development or heavily modified, often both.
-
-Most of these vendor kernels are quite unsuitable for reporting issues to the
-Linux kernel developers: an issue you face with one of them might have been
-fixed by the Linux kernel developers months or years ago already; additionally,
-the modifications and enhancements by the vendor might be causing the issue you
-face, even if they look small or totally unrelated. That's why you should report
-issues with these kernels to the vendor. Its developers should look into the
-report and, in case it turns out to be an upstream issue, fix it directly
-upstream or forward the report there. In practice that often does not work out
-or might not what you want. You thus might want to consider circumventing the
-vendor by installing the very latest Linux kernel core yourself. If that's an
-option for you move ahead in this process, as a later step in this guide will
-explain how to do that once it rules out other potential causes for your issue.
-
-Note, the previous paragraph is starting with the word 'most', as sometimes
-developers in fact are willing to handle reports about issues occurring with
-vendor kernels. If they do in the end highly depends on the developers and the
-issue in question. Your chances are quite good if the distributor applied only
-small modifications to a kernel based on a recent Linux version; that for
-example often holds true for the mainline kernels shipped by Debian GNU/Linux
-Sid or Fedora Rawhide. Some developers will also accept reports about issues
-with kernels from distributions shipping the latest stable kernel, as long as
-it's only slightly modified; that for example is often the case for Arch Linux,
-regular Fedora releases, and openSUSE Tumbleweed. But keep in mind, you better
-want to use a mainline Linux and avoid using a stable kernel for this
-process, as outlined in the section 'Install a fresh kernel for testing' in more
-detail.
-
-Obviously you are free to ignore all this advice and report problems with an old
-or heavily modified vendor kernel to the upstream Linux developers. But note,
-those often get rejected or ignored, so consider yourself warned. But it's still
-better than not reporting the issue at all: sometimes such reports directly or
-indirectly will help to get the issue fixed over time.
+.. _intro_repiref:
+
+You likely need to compile at least one really fresh kernel
+-----------------------------------------------------------
+
+  *Be aware:You should report issues using a Linux kernel that is both really
+  fresh and vanilla. [...] Your email address will become part of public
+  archives [...] You might need to patch and build your own kernel* [:ref:`... <intro_repisbs>`]
+
+You most likely will have to fiddle with your setup and install at least one
+fresh Linux kernel while reporting the issue or trying to resolve it. The
+step-by-step guide mentions a few, but the most important is:
+
+The kernels most Linux users utilize are unsuitable for reporting bugs
+upstream, as the problem might have been fixed already or never happened with
+the upstream code in the first place. Such situations occur frequently when it
+comes to Linux:
+
+1. Many developers consider all 'longterm' (aka 'LTS') kernels as too old and
+   thus unsuitable for reporting, except for series-specific regressions (say
+   from 6.1.13 to 6.1.15) in still-supported series (see `frontpage of
+   kernel.org <https://kernel.org/>`_). Reporting using the newest version from
+   the latest 'stable' series can work -- but some developers only take a
+   closer look at bugs reported using a fresh mainline kernel, as the bug might
+   have been fixed already.
+
+2. Almost all Linux-based kernels pre-installed on devices (computers, laptops,
+   smartphones, routers, …) are therefore too old as well, but even when not,
+   often unsuitable for a second reason:
+
+  Most vendors modify Linux's source code (some heavily!) before building their
+  kernels; frequently their kernels also load externally developed modules
+  ('out-of-tree drivers'), too. Such modifications or enhancements might be
+  causing your issue, even when they seem tiny and unrelated. Upstream
+  developers can do nothing about such problems.
+
+  You therefore have to report issues with such kernels to the vendor. Its
+  developers should look into the report and, in case it turns out to be an
+  upstream issue, report or directly fix it there. In practice that often does
+  not work out or might not be what you want; installing your own fresh vanilla
+  kernel while steering clear of externally developed modules is your way out
+  here.
+
+Note: Some developers, despite the aforementioned aspects, are willing to handle
+reports about issues in kernels that are somewhat older or slightly diverged.
+If they will highly depends on the circumstances:
+
+* Your chances are quite good if the vendor performed only small changes to a
+  recent mainline codebase; that, for example, often holds true for the kernels
+  shipped by Debian GNU/Linux Sid (aka 'unstable') or Fedora Rawhide.
+
+* Chances are slightly worse but still relatively good for reports about issues
+  with the newest version from the latest Linux stable series. That is the case
+  even when the distributor slightly modified or enhanced the kernel's code --
+  this, for example, is often the case for the default kernels of Arch Linux and
+  openSUSE Tumbleweed, as well as regular Fedora releases when using the latest
+  stable series.
+
+You are free to ignore this advice and report problems to the upstream Linux
+developers occurring with kernels that are outdated, modified, or utilizing
+out-of-tree drivers. But be aware that developers might react coldly or never
+at all. Nevertheless, it is still better than not reporting the issue:
+sometimes such a report directly or indirectly helps to resolve issues over
+time.
+
+[:ref:`back to step-by-step guide <intro_repisbs>`]
 
 
 Search for existing reports, first run
-- 
2.51.0


