Return-Path: <linux-kernel+bounces-619808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8988A9C1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84303B1624
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C623D29E;
	Fri, 25 Apr 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D21DPx1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166923D290
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570579; cv=none; b=GUgw0FU05PeK0nbYNcLFCE43vacV8pmSXp2Jd24Qv9KF77fAeXj45hWCUkVqapgeHNhcyPoQBFQbdLLnsUncp76oBHchlAhXFwJrnaXPcaxILxY1of3CpE46TTRoBPw5X48H0DXmy2NPb2ZmEz7i26/0swLuapClDaVc9Y8NRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570579; c=relaxed/simple;
	bh=5/u3s+SDSs6FzQ3HhIm0qydmhERheu0IGsLhIfwXftI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKbosUWh6Vds3k/IdoRLAzUFFUmxP6sk6gqd3z10eUd040RZZDkrR3mY3CeYGWQ7hTVxT1iIYKgHU0cnIvy6wfDYlz8DYE04jgfmuZh3FaRwFxDQ/a2RkKaZJMbE0/BEWLPaMhoz28MxyEkXoejxPTHFUGzRvslVd4C7N3dL/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D21DPx1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7963DC4CEEA;
	Fri, 25 Apr 2025 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745570579;
	bh=5/u3s+SDSs6FzQ3HhIm0qydmhERheu0IGsLhIfwXftI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D21DPx1pLAs1PFbfxZr1ZdcKdb3OvD5Mx1ipUL5Lv+0yxyatfgFV6f+qO5zAMyxxI
	 1cBkAjPAtX6BN0kkh8DOTikw5vFAtfSI5XHizCiEcieJVHosV25sBs36/tGd5ruBJZ
	 LdDbdHPC8PUJ9kXS4tsvaYzamiLR7Xz5Cp1TrJwyAIUNqunFBrEvBDWbBSzu8Ql8rC
	 R3yuePwI2gsR/q4zFu+JhdXh47UpYPCHZ6AezOhh9VoR8pOJH11xqzkGPYHjdzXO7e
	 s2o9q/l+gKnSIvcByg0hZzGsihlpDmUiJEE+nLtD1tf0YpJvxNELs9QfMFbozbplhm
	 WEq+5wqdRhoLg==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/15] x86/fpu: Remove the 'no387' boot option
Date: Fri, 25 Apr 2025 10:42:06 +0200
Message-ID: <20250425084216.3913608-10-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250425084216.3913608-1-mingo@kernel.org>
References: <20250425084216.3913608-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without math emulation there's no point to this option.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 arch/x86/Kconfig                                | 20 +++++++++-----------
 arch/x86/kernel/cpu/common.c                    |  7 -------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b34..6d391d76336f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4049,10 +4049,6 @@
 			These settings can be accessed at runtime via
 			the nmi_watchdog and hardlockup_panic sysctls.
 
-	no387		[BUGS=X86-32] Tells the kernel to use the 387 maths
-			emulation library even if a 387 maths coprocessor
-			is present.
-
 	no4lvl		[RISCV,EARLY] Disable 4-level and 5-level paging modes.
 			Forces kernel to use 3-level paging instead.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cd9dd10b15d2..137b5ddf1f86 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2725,18 +2725,16 @@ menuconfig APM
 	  1) make sure that you have enough swap space and that it is
 	  enabled.
 	  2) pass the "idle=poll" option to the kernel
-	  3) switch on floating point emulation in the kernel and pass
-	  the "no387" option to the kernel
-	  4) pass the "floppy=nodma" option to the kernel
-	  5) pass the "mem=4M" option to the kernel (thereby disabling
+	  3) pass the "floppy=nodma" option to the kernel
+	  4) pass the "mem=4M" option to the kernel (thereby disabling
 	  all but the first 4 MB of RAM)
-	  6) make sure that the CPU is not over clocked.
-	  7) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
-	  8) disable the cache from your BIOS settings
-	  9) install a fan for the video card or exchange video RAM
-	  10) install a better fan for the CPU
-	  11) exchange RAM chips
-	  12) exchange the motherboard.
+	  5) make sure that the CPU is not over clocked.
+	  6) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
+	  7) disable the cache from your BIOS settings
+	  8) install a fan for the video card or exchange video RAM
+	  9) install a better fan for the CPU
+	  10) exchange RAM chips
+	  11) exchange the motherboard.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called apm.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126adbc3a9..1755ef511fd7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1574,13 +1574,6 @@ static void __init cpu_parse_early_param(void)
 	int arglen;
 
 #ifdef CONFIG_X86_32
-	if (cmdline_find_option_bool(boot_command_line, "no387"))
-#ifdef CONFIG_MATH_EMULATION
-		setup_clear_cpu_cap(X86_FEATURE_FPU);
-#else
-		pr_err("Option 'no387' required CONFIG_MATH_EMULATION enabled.\n");
-#endif
-
 	if (cmdline_find_option_bool(boot_command_line, "nofxsr"))
 		setup_clear_cpu_cap(X86_FEATURE_FXSR);
 #endif
-- 
2.45.2


