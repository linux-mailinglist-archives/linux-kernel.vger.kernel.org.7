Return-Path: <linux-kernel+bounces-788158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAAB3807D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496F668619C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADB28C847;
	Wed, 27 Aug 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bwNfZLaq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31872610
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292671; cv=none; b=uC5jGIvzaBKCO0BkR/RGYa6sY7vtBobYEfIklP1e9pv6LXcyntDp0AwyJlBEZvwVdUJU/iZdsrSouZ/Gj8A1eaUpRChNsx6fWJqV7trKGBV84mMbM2yvxH7np3BDhnnwVTzTYxjS7fmIhB8gbkDwDBlEyyCc6HCQxDEYtBnaY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292671; c=relaxed/simple;
	bh=K36l9umpnqWgj8g6Q2RwkkKgncxZouxjfP9Lbr6Jdqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozAYPWP1m5xmK4D3gwN5kgKJe7a6TJ+7nTtIHXdHWBmMTuBMXEQPoGKjPc2KuOIf4wee/3b1YaPhEocRdjhWQaHLpVbdFYu86qiTqfguv7SsrQ9yfC6tbUHH4qU9BrGHiJaBKUMo/9QjpWiGSdRz1y4ET1r1jixq2R2QmBoFJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bwNfZLaq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 706E140E00DA;
	Wed, 27 Aug 2025 11:04:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hzLaTepRCXGe; Wed, 27 Aug 2025 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756292659; bh=PfmIB8d56084Al/dW08mm5EUnSaNoxbgDODtYCnpiwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwNfZLaqEfa7kpRdH7P7KJh2LrTtqIuXpNd4AN2PB0HIFt4fsEv2X1jadOR8WWvyp
	 AbYuG6by20VMlSQySS2v9BesIIOAMhUNoIGBqmv7pSmTM9dIPTNy52qM86GMqs68iF
	 DJh3MJYIYWNQaKFsvT2UMrxEO+t6yJ7uqAqGTarHRONcE4hhLSX43asLJPwKhoHQJY
	 rPREllq42Pn1MBqgftQ+Yyh1UKGSe9Ai5OyY6MM7d1P9Yosu+8GlVn0DFLsxzXtLdl
	 o7BOXatTBgczdcmMtmmLW09hXPu1p4DsWFjEM295tG0vsMUZ1/nAf7F0RvHIy2eHmQ
	 0o8F7GCcte0qmI7odP2pYQqXF/IChVpGYtdR7Hgl+M9p/GIUmvtkKe//8/w6BMXOCa
	 OQirYJFP+Ht4c6sBLy/SfESql4HVkfprIWUZpTejGNPr3ZBIgQF+JxKrtGnWKQ0w6/
	 JBhZtu1xw8ukJWSs4E+C+Q00tSHx4lr+RMNQsrTNIIyDICQiLkloZArbMMwL4aH8wU
	 fB9+QxltGgVW40RSOr/vQqcJusevKcj7xkm4/kj1SLXSkBTTe64lJWUdQ62uwSmxn5
	 OV18rX1UQfCQ9SdpvD34VZCZ7lXRkMcnR+qJBeM14lqDFNlGFSlBhX8DYbMXKMBDTO
	 2E94yvnMHaIYG42eNdVEPwHw=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34F0040E0176;
	Wed, 27 Aug 2025 11:04:09 +0000 (UTC)
Date: Wed, 27 Aug 2025 13:04:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>

On Wed, Aug 27, 2025 at 12:27:54PM +0200, Borislav Petkov wrote:
> Fixed and expediting this one so that 6.17 releases with the full attack
> vectors functionality.

Ok, so I'm thinking we should do a minimal fix like this below which goes to
Linus now so that 6.17 has full attack vectors support and then slap
all cleanups ontop. Thoughts?

---
From: David Kaplan <david.kaplan@amd.com>
Date: Tue, 19 Aug 2025 14:21:59 -0500
Subject: [PATCH] x86/bugs: Add attack vector controls for SSB

Attack vector controls for SSB were missed in the initial attack vector series.
The default mitigation for SSB requires user-space opt-in so it is only
relevant for user->user attacks.  Add an AUTO mitigation for SSB and use this
attack vector control to select the SSB mitigation.

Fixes: 2d31d2874663 ("x86/bugs: Define attack vectors relevant for each bug")
Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/20250819192200.2003074-5-david.kaplan@amd.com
---
 .../hw-vuln/attack_vector_controls.rst            |  5 +----
 arch/x86/include/asm/nospec-branch.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                        | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
index 6dd0800146f6..5964901d66e3 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -215,7 +215,7 @@ Spectre_v2            X                           X
 Spectre_v2_user                      X                           X            *       (Note 1)
 SRBDS                 X              X            X              X
 SRSO                  X              X            X              X
-SSB                                                                                   (Note 4)
+SSB                                  X
 TAA                   X              X            X              X            *       (Note 2)
 TSA                   X              X            X              X
 =============== ============== ============ ============= ============== ============ ========
@@ -229,9 +229,6 @@ Notes:
    3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU is
    vulnerable, and STIBP is not supported
 
-   4 --  Speculative store bypass is always enabled by default (no kernel
-   mitigation applied) unless overridden with spec_store_bypass_disable option
-
 When an attack-vector is disabled, all mitigations for the vulnerabilities
 listed in the above table are disabled, unless mitigation is required for a
 different enabled attack-vector or a mitigation is explicitly selected via a
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 10f261678749..e263c126723a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -514,6 +514,7 @@ enum spectre_v2_user_mitigation {
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_AUTO,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
 	SPEC_STORE_BYPASS_SECCOMP,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 49ef1b832c1a..159beed05ee8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -416,6 +416,10 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST) ||
 		       (smt_mitigations != SMT_MITIGATIONS_OFF);
+
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER);
+
 	default:
 		WARN(1, "Unknown bug %x\n", bug);
 		return false;
@@ -2619,7 +2623,8 @@ void cpu_bugs_smt_update(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
+static enum ssb_mitigation ssb_mode __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
 
 /* The kernel command line selection */
 enum ssb_mitigation_cmd {
@@ -2695,6 +2700,13 @@ static void __init ssb_select_mitigation(void)
 	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
 		return;
 
+	if (ssb_mode == SPEC_STORE_BYPASS_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+		else
+			ssb_mode = SPEC_STORE_BYPASS_NONE;
+	}
+
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_SECCOMP:
 		/*
@@ -2935,6 +2947,7 @@ static int ssb_prctl_get(struct task_struct *task)
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
+	case SPEC_STORE_BYPASS_AUTO:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ssb_noexec(task))
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

