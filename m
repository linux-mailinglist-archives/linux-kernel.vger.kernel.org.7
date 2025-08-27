Return-Path: <linux-kernel+bounces-788628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B60B38793
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C970A1C20CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F16350D70;
	Wed, 27 Aug 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gOSN5fG7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02466350D42
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311146; cv=none; b=M1mXDp7X54V2ziloEtKW91kOml5LymnBpzc2pGUVakXPvXhZLGfGGjigytFBqDis3Vi+dgtBDmG1QBi5F3bKcTngPTu9tAAG3UH1c+Rm7847CmsEX/YCx40T2L5P91Vwnj6nFArZk7N5+T180CXiLjuMJFroKAPUP3jd8gTt1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311146; c=relaxed/simple;
	bh=0JxrVzNpw3Jf9BCkoaMJwaZLJ223Jv0LANCgaQFioWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZWPQMHjF6UCubAGKAbLadk4NxrMKGMRV+VWzVphYbSpAB79KBEM5A2J7l/UFWmWOAykXB5P5QEQ5gisBaoFiSqOzOeeHJQ6s1WdTITCMEr8jjRwQbxyt2Amr5AWnYQimmOM+TD3+nBsyGNHi4UHKe+RpKolQImHeOl9AnCE1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gOSN5fG7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D03B340E00DD;
	Wed, 27 Aug 2025 16:12:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8LHbDrb2B3K0; Wed, 27 Aug 2025 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756311136; bh=5RQhtA81tuTodT1U0o77ysAnmlDypdy9Tu9wlb6GeaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOSN5fG7uYnIKo19Lry8DMyc+VssloRLg6Jie3G05yMz3S5KPn+eJ+lT3LDcl0odk
	 LSx95c4lw8UPIaB0LBa+q/c2gQtMUdUmALmpaUROWESh9GUeHrZX6X2yrF6CF4SP9O
	 hsAO5nETHBPlng1v0nX1hw4AMaWp6N6JvfHKG5ExCc6UF1iwEHi1tHDK3nz48uYwFq
	 02pawKLXLJTIgktYbpO2TejZgTWfH8yUImiS4VLOKtk53Yvv7cyhW8S2sI2twxUHU1
	 49/0dbrZXHj5Y0bUnMtFz7YGPfwRUeT3Mqj6BHO/id4M2svRgnWg404TIn/C7RYaix
	 L3xy8yIgJmRlqgZktnBvvXGefijDAWCB7WoaPvywT0e7od40/z8w4YsN3PZDtP0Cey
	 EV4/PPMfsQHQeopy8ed7f+ns8RaISBZEDGGyu2vGD83CXeMb5pWHKIknaPVxSP1t5s
	 kfLjehgiyZXNmVX9hahdsKeTpcRLneb3Ijic72tniqQIWyqtGLRlURCOXOKvOSpSFW
	 0wsKR9sa24X6wncgBljm9MYGtElUxVg9I5E9Zf6GiuPHTkmoUZh4/htYsEtSI6HE+O
	 888kAgBSYc1WVMIuore4XokYrflMgLSgUps5uCYik5tqs8MxTI3JWX83/yrekfyx9V
	 KFLPmfwVhbzZUj7icYUg/O+U=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C7FF40E00DA;
	Wed, 27 Aug 2025 16:12:06 +0000 (UTC)
Date: Wed, 27 Aug 2025 18:11:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <20250827161159.GKaK8uTy8aW6Xl7UCr@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
 <LV3PR12MB9265ABD1B81D759A618A20029438A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265ABD1B81D759A618A20029438A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Aug 27, 2025 at 03:47:10PM +0000, Kaplan, David wrote:
> After reviewing this further, this change should be removed.  The AUTO mitigation is intended to say 'choose based on attack vector', but with this patch you're not looking at ssb_mode to decide to do that.  You're looking at the ssb mitigation cmd (which already defaults to SPEC_STORE_BYPASS_CMD_AUTO).  Therefore there is no need for a SPEC_STORE_BYPASS_AUTO setting of ssb_mode.
> 
> (The clean-up patch removes ssb_mitigation_cmd entirely, so it needs an AUTO setting of ssb_mitigation)

...

> But more importantly, please remove this.  That's because in the current patch, if the user says 'nospec_store_bypass_disable' then the ssb_select_mitigation() function does not change ssb_mode.  So it needs to default to NONE.

Yah, agreed with both. Here's a minimal thing.

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
Link: https://lore.kernel.org/20250819192200.2003074-5-david.kaplan@amd.com
---
 .../admin-guide/hw-vuln/attack_vector_controls.rst       | 5 +----
 arch/x86/kernel/cpu/bugs.c                               | 9 +++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

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
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 49ef1b832c1a..af838b8d845c 100644
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
@@ -2710,6 +2714,11 @@ static void __init ssb_select_mitigation(void)
 		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
 	case SPEC_STORE_BYPASS_CMD_AUTO:
+		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+		else
+			ssb_mode = SPEC_STORE_BYPASS_NONE;
+		break;
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
 		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
-- 
2.51.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

