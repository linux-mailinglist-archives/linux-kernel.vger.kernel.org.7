Return-Path: <linux-kernel+bounces-870335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05693C0A7CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E934919D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82892E092D;
	Sun, 26 Oct 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dxWmeTjd"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756022C11EC;
	Sun, 26 Oct 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482553; cv=none; b=hF+cg/MqzpSc29RrumNLRHLTzTjyCSyGVxOmsH9hutv81DAOn5F+NHk8Fa+3EwhmPLgp9pDbF2eoiEsXgC56IdOZ+YP3keh5N9ZfqZYuM2GmSxz/OeCcJ6kwg0wqLQQAUv483OKrCJO3E0j5A7ZGWCkOnxBbq1p2YgDyYOa+u8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482553; c=relaxed/simple;
	bh=j11Gc/5QYiUy6F+P2RyEr/2EB+XN5KyxRXrWVYzN3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C18BgROYjQGpprHsUzv3Gpf+hTPK/jLeVnfHlYYt1I5iAG2OSjvGAvwvLyWr2HSjZbMwCGZ52XAgLRqUWvpwxP04Tls4g1XI+vjfHd6olGSm52LIdUL6SYfu03WyUU9HffNzSuOIhoHKzMoz350MfYi+OGebTm9cJw4H00XRWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dxWmeTjd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+oSFmLCLJ2XeD/SLV19HCOuUmPh+XxTv83L0oJR/kUU=; t=1761482551;
	x=1761914551; b=dxWmeTjda+jjl2pCaR3qB/GCv4fs1xC0xbQUtz4y06QXBX89+QRzZwm7GZ0PS
	2KPt7XO6Ajap2JU3csRU2vBJ97LHxmkWdDVCIkGzIiHhgK2T9Cl5ujFp8gw2iLuDAAlO1pXQBI0KS
	qI7NpBm1JQ3qLc0w3RXCBhZVwi9YGPXjagCSjCAp4xCUs0Vev+1EJ7qYt4zh7cipJuNEt0d8uXFvK
	vaeYmPkVVlaoZlUu0oSav752YlgB9gYugtRaPowyjiDaXAVpGzkCnTZ0FnrWZFsxoXGEXdLQIWsh3
	oxN3i0O3w/3sqNGghprEqHf6rSJ25Ndn8Y/oCA2C3I04rTH3Nw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04l-001mX6-2O;
	Sun, 26 Oct 2025 13:42:23 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/30] docs: reporting-issues: add proper appendix
Date: Sun, 26 Oct 2025 13:41:55 +0100
Message-ID: <c3d92d4e74557bfff3627d8ceb6a9911612af52a.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482551;009d26c6;
X-HE-SMSGID: 1vD04l-001mX6-2O

Turn the "Why some bugs remain unfixed and some report are ignored"
section into a proper appendix while improving it slightly.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 102 +++++++++---------
 1 file changed, 54 insertions(+), 48 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 9676ba85e1b73c..745e698cb6be8b 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1693,60 +1693,66 @@ for the subsystem where the issue seems to have its roots; CC the mailing list
 for the subsystem as well as the stable mailing list (stable@vger.kernel.org).
 
 
-Why some issues won't get any reaction or remain unfixed after being reported
-=============================================================================
+Appendix: additional background information
+===========================================
 
-When reporting a problem to the Linux developers, be aware only 'issues of high
-priority' (regressions, security issues, severe problems) are definitely going
-to get resolved. The maintainers or if all else fails Linus Torvalds himself
-will make sure of that. They and the other kernel developers will fix a lot of
-other issues as well. But be aware that sometimes they can't or won't help; and
-sometimes there isn't even anyone to send a report to.
+.. _unfixedbugs_repiapdx:
 
-This is best explained with kernel developers that contribute to the Linux
-kernel in their spare time. Quite a few of the drivers in the kernel were
-written by such programmers, often because they simply wanted to make their
-hardware usable on their favorite operating system.
+Why some bugs remain unfixed and some report are ignored
+--------------------------------------------------------
+
+When reporting a problem to the Linux developers, be aware that they are only
+obliged to fix regressions, security issues, and severe problems. Developers,
+maintainers, or, if all else fails, Linus Torvalds himself will make sure of
+that. They will fix a lot of other issues as well, but sometimes they can't or
+won't help -- and sometimes there isn't even anyone to send a report to.
+
+This situation is best explained using kernel developers that contribute to the
+Linux kernel in their spare time. Quite a few of the drivers in the kernel were
+written by such programmers; often they simply wanted to make the
+hardware they owned usable on their favorite operating system.
 
 These programmers most of the time will happily fix problems other people
-report. But nobody can force them to do, as they are contributing voluntarily.
-
-Then there are situations where such developers really want to fix an issue,
-but can't: sometimes they lack hardware programming documentation to do so.
-This often happens when the publicly available docs are superficial or the
-driver was written with the help of reverse engineering.
-
-Sooner or later spare time developers will also stop caring for the driver.
-Maybe their test hardware broke, got replaced by something more fancy, or is so
-old that it's something you don't find much outside of computer museums
-anymore. Sometimes developer stops caring for their code and Linux at all, as
-something different in their life became way more important. In some cases
-nobody is willing to take over the job as maintainer – and nobody can be forced
-to, as contributing to the Linux kernel is done on a voluntary basis. Abandoned
-drivers nevertheless remain in the kernel: they are still useful for people and
-removing would be a regression.
+report. But nobody can force them to do so, as they are contributing
+voluntarily.
+
+There are also situations where such developers would like to fix issues,
+but can't: They might lack programming documentation to do so or hardware to
+test. The former can happen when the publicly available docs are superficial or
+when a driver was written with the help of reverse engineering.
+
+Sooner or later, spare-time developers usually stop caring for the driver.
+Maybe their test hardware broke, was replaced by something more fancy, or
+became so old that it is something you don't find much outside of computer
+museums anymore. Other times developers also stop caring when
+something different in life becomes more important to them. Then sometimes
+nobody is willing to take over the job as maintainer -- and nobody else can be
+forced to, as contributing is voluntary. The code nevertheless often stays
+around, as it is useful for people; removing it would also cause a regression,
+which is not allowed in Linux.
 
 The situation is not that different with developers that are paid for their
-work on the Linux kernel. Those contribute most changes these days. But their
-employers sooner or later also stop caring for their code or make its
-programmer focus on other things. Hardware vendors for example earn their money
-mainly by selling new hardware; quite a few of them hence are not investing
-much time and energy in maintaining a Linux kernel driver for something they
-stopped selling years ago. Enterprise Linux distributors often care for a
-longer time period, but in new versions often leave support for old and rare
-hardware aside to limit the scope. Often spare time contributors take over once
-a company orphans some code, but as mentioned above: sooner or later they will
-leave the code behind, too.
-
-Priorities are another reason why some issues are not fixed, as maintainers
-quite often are forced to set those, as time to work on Linux is limited.
-That's true for spare time or the time employers grant their developers to
-spend on maintenance work on the upstream kernel. Sometimes maintainers also
-get overwhelmed with reports, even if a driver is working nearly perfectly. To
-not get completely stuck, the programmer thus might have no other choice than
-to prioritize issue reports and reject some of them.
-
-But don't worry too much about all of this, a lot of drivers have active
+work on the upstream Linux kernel. Those contribute the most changes these days.
+But their employers set the priorities. And those sooner or later stop caring
+for some code or make their
+employees focus on other things. Hardware vendors, for example, earn their money
+mainly by selling new hardware -- they thus often are not much interested in
+investing much time and energy in maintaining a Linux kernel driver for a chip
+they stopped selling years ago. Enterprise Linux distributors often care for a
+longer time period, but in new versions might set support for old and rare
+hardware aside to limit the scope, too. Often spare-time contributors take over
+once employed developers orphan some code, but as mentioned earlier: Sooner or
+later they will usually leave the code behind, too.
+
+Priorities are another reason why some issues are not fixed, as developers
+quite often are forced to set those: The spare-time of volunteers or the time
+employers allot for upstream Linux kernel work is often limited. Sometimes
+developers are also flooded with good and bad reports, even if a driver is
+working well. To
+not get completely stuck, the programmers might have no other choice than
+to prioritize bug reports and ignore some.
+
+But do not worry too much about all of this, a lot of drivers have active
 maintainers who are quite interested in fixing as many issues as possible.
 
 
-- 
2.51.0


