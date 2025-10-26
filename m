Return-Path: <linux-kernel+bounces-870345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6BC0A81D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0543B1811
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AD2DFA28;
	Sun, 26 Oct 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mLBGvZ0x"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B22DCF5D;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482556; cv=none; b=OwCxxkP/J0sMnouE8ifQLBe2FZdaRwcXQMaErFxMfGELY88la85t4Ly8BVG7SFqkK+qQhyau4VtOE75070QcX95wqCWBAmCvRMuB774rRhJlItpJVxH2mE2KPsPZ8cEyoez1cmFZtMLhfbMdElisQkUZJWRT9RxntIkXqpXso/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482556; c=relaxed/simple;
	bh=aN4oTmpwa1enpG9GmHeTbntkM9KkPOpY1JAM1Mzc3/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjhLVwYL9bKSjzZXpsoDmMpIaQYHfx7jfWU5FyIFFHd3OG9PR7BfRMTAbjCU9K3L7mSTQDdOAIKM0NrPc0WJfzfegr5ZDr7nK62wg55Gp2g1o3OxnXSQ4vh1s33NVwdA5bnNrXJyNC0D6FQ70kfbQtnCSutMjZbvekDQYx+rBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mLBGvZ0x; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KECSvN3gX56Uge9ltO6cw9IleaALx97sD5id01QLlPo=; t=1761482554;
	x=1761914554; b=mLBGvZ0xnJ68q4nCNgqgkO9HFCnfouVfJJJGYLNvrKa3jPVMXwaAHt0bS4C4B
	9NWXnDAJAwos8OgmMnXI321P4nn3qO2/ZK3K6l5s89T6OIhOfAARL45AfAiE9UX0M48U5K1qoPGGb
	awnrcodPa/GerhqKIixF8Ceu+f/mzTYQ3J2vIWUYDCtCyO4iYbdyCVtZ61MQDFJ5nctTQbIi4G5PD
	N2qy6GdVUQTIAXcsgSjs8Npb/y1DdTB64LHcsbnIP3SGxmTpFv0tDDefUtBYIotzQl8Aa76EOu5+b
	m5LFLolt4j7Zwyf6FFVAks5XZOAHmXCsSE/wn2hbdXxAZleUUQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04p-001mXn-0T;
	Sun, 26 Oct 2025 13:42:27 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/30] docs: reporting-issues: improve environment check
Date: Sun, 26 Oct 2025 13:42:04 +0100
Message-ID: <958f8daae33cfc44124ad9cc6579daa417ba0a77.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04p-001mXn-0T

Fine-tune the instructions regarding the environment check.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 74 ++++++++++++-------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 861237aaf94126..439ec52f270167 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -92,9 +92,17 @@ following the others is usually in your own interest.
 
  [:ref:`details <taintone_repiref>`]
 
+.. _checkenv_repisbs:
+
+* Evaluate briefly if some glitch in your kernel's environment might make it
+  misbehave -- like a hardware defect, an updated system firmware, a
+  misconfigured BIOS, an overclocked component, a kernel parameter enabling
+  something unsupported, a broken initramfs, an inconsistent file system,
+  changes to the linux-firmware files, or some malfunction/misconfiguration in
+  your Linux distribution.
+
+ [:ref:`details <checkenv_repiref>`]
 
- * Make sure it's not the kernel's surroundings that are causing the issue
-   you face.
 
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
@@ -481,39 +489,49 @@ These are the most frequent reasons why the kernel set the flag:
 [:ref:`back to step-by-step guide <taintone_repisbs>`]
 
 
-Ensure a healthy environment
-----------------------------
+.. _checkenv_repiref:
+
+Ensure there is nothing wrong with the kernel's surroundings
+------------------------------------------------------------
+
+  *Evaluate briefly if some glitch in your kernel's environment might make it
+  misbehave -- like a* [:ref:`... <checkenv_repisbs>`]
+
+Problems that look like a kernel issue are sometimes caused by its
+surroundings. It is impossible to detect sometimes -- but it is wise to rule
+out a few common causes before wasting time on a meaningless bug report:
+
+* When dealing with a regression (e.g., something stopped working or works worse
+  after updating the kernel), make sure it is not something else that changed
+  in parallel. That could be something else you updated at the same time, like
+  the BIOS, the boot loader, Mesa, the linux-firmware package, or something
+  else close to the kernel; but it could also be some change you performed in
+  the BIOS setup or your Linux distribution's configuration.
+
+* Try to make sure the hardware is healthy, as problems with it can result in a
+  multitude of issues that look like kernel bugs.
 
-    *Make sure it's not the kernel's surroundings that are causing the issue
-    you face.*
+  Ideally try to rule out faulty RAM or a dying device causes the problem.
 
-Problems that look a lot like a kernel issue are sometimes caused by build or
-runtime environment. It's hard to rule out that problem completely, but you
-should minimize it:
+  Also ensure your computer components run within their design specifications;
+  that is especially important for the main processor, the RAM, and the
+  motherboard. Therefore, stop undervolting or overclocking when facing a
+  potential kernel issue.
 
- * Use proven tools when building your kernel, as bugs in the compiler or the
-   binutils can cause the resulting kernel to misbehave.
+* Temporarily remove any optional kernel parameters you use, as they might
+  enable unsupported or experimental features.
 
- * Ensure your computer components run within their design specifications;
-   that's especially important for the main processor, the main memory, and the
-   motherboard. Therefore, stop undervolting or overclocking when facing a
-   potential kernel issue.
+* In case of any problems related to booting, check if the initramfs was
+  generated correctly.
 
- * Try to make sure it's not faulty hardware that is causing your issue. Bad
-   main memory for example can result in a multitude of issues that will
-   manifest itself in problems looking like kernel issues.
+* When dealing with a file system issue, check the file
+  system in question with ``fsck``, as it might be damaged in a way that leads
+  to unexpected kernel behavior.
 
- * If you're dealing with a filesystem issue, you might want to check the file
-   system in question with ``fsck``, as it might be damaged in a way that leads
-   to unexpected kernel behavior.
+* Use proven tools when building your kernel, as bugs in the compiler or the
+  linker can cause the resulting kernel to misbehave.
 
- * When dealing with a regression, make sure it's not something else that
-   changed in parallel to updating the kernel. The problem for example might be
-   caused by other software that was updated at the same time. It can also
-   happen that a hardware component coincidentally just broke when you rebooted
-   into a new kernel for the first time. Updating the systems BIOS or changing
-   something in the BIOS Setup can also lead to problems that on look a lot
-   like a kernel regression.
+[:ref:`back to step-by-step guide <checkenv_repisbs>`]
 
 
 Search for existing reports, first run
-- 
2.51.0


