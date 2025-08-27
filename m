Return-Path: <linux-kernel+bounces-788577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C5B386B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C41C202B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A352E2C2347;
	Wed, 27 Aug 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kBbOZDtB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7760156C6A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308873; cv=none; b=E6TqtbPWZd1OJ8s7cpSg+5xsdR6RbKAR7A9l/BX8Mzan1KhL9feh21Vu9Jq9885vglQq31CCyTQw3WdPGpP5B8IfewML0wFon/NFxbheYkYEEugdGxMzChi3IxmFeXFvqAkqzflDeJsIOgKRVqez06pdSZ4HfJxwVxC0Mgun5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308873; c=relaxed/simple;
	bh=ZY8DE2wTTl7bjr8bmAc+o3P+HDSm1Zp6irHyv3+E/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yut2MpKTL/kgh1r0paAA3N9YWU+eyyFUVV1YDjl/PvLYXVVhh2wiKuW+Ur4P6DyHrolatPngfl3bWQ05I8nhQgPfedljc9IyejelKDt/67iRyhdcaiPt9ZYPuV898xwo6192cIOM5cGKyJDKkc+V9dKkUsFC0IAbqvkM4sZWXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kBbOZDtB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6280340E0176;
	Wed, 27 Aug 2025 15:34:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oC5_GvpXc-CZ; Wed, 27 Aug 2025 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756308860; bh=pP3eqlfkRLypmfm0nFTnGblm5dEJ+RXVRIYwXa6XIQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBbOZDtBwpn9Ez69em/RZo6+406izMEvFehiw8VT4hQzl3BqHfDCcjXQfjuJfVw0z
	 V9s2MApLnETG8yh4K5fSuqrnIh88cpTBpk8hqcGUfJC7cHXnWbqxoWZoHcxIPKATkr
	 nlJtz0uFLi4mhTB4xvAHxsMRJhokWDcuhATEEC9eDv0qIUBBPcYWF1RMaRA+xL3d79
	 X85QplnNBMBq51eSGEGfmtKXKt2por/ucOEiG0U60bfCO/NT3onRbPaMq3lQNuZuqH
	 +TXaeAhn9VsRsQHR2v1gyT5YSBhjeK9WeYxwK2pRJn9bsssjD9d97CM/uYj4Rz8skY
	 UCSJCbppp2uc7lzwOZXkRvhVWe8s3QDj9ae7BNsZGemWxdwV7NF9XLHy/bd6OKHyq8
	 GNZCSJ613PcWnbMUmtJEjGsWeqwA6hIHA6uVRiBvalYhWKh+5Y4Hu5fuILJ2BATxLw
	 Whp5ySwDs2zqdsCI9JqMZO9pyGg/ynhwJbQCFCNydN4SzpSoEmQjWqZN1wXujqZF9V
	 rIojhdKW70/N5XnbZP6ZsAhDYKjiYfg7a61x5ZtGgXNntiRnU8JvzC52u2iUSLkxVD
	 dK9uqiV6UcH50MWPtaA61yP9xpNCnPJQVAj/MlA9uPhNx9XZXTmpP46n8oxBv/p8Du
	 3gCxvhmITEInC5FMsTz8Jfpk=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4F9A40E00DD;
	Wed, 27 Aug 2025 15:34:10 +0000 (UTC)
Date: Wed, 27 Aug 2025 17:33:58 +0200
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
Message-ID: <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Aug 27, 2025 at 02:25:26PM +0000, Kaplan, David wrote:
> Ok.  Then I would go with the suggestion in my reply...move the
> should_mitigate_vuln() logic into the SPEC_STORE_BYPASS_CMD_AUTO branch of
> the switch.  I think that should work as expected.

Makes sense...

> Rest of the patch was fine I think.

Here it is - I *think* it looks good now but doublecheck me again pls.

Thx.

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
 .../admin-guide/hw-vuln/attack_vector_controls.rst  |  5 +----
 arch/x86/include/asm/nospec-branch.h                |  1 +
 arch/x86/kernel/cpu/bugs.c                          | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

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
index 49ef1b832c1a..7b4b43aabd18 100644
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
@@ -2710,6 +2715,11 @@ static void __init ssb_select_mitigation(void)
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
@@ -2935,6 +2945,7 @@ static int ssb_prctl_get(struct task_struct *task)
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

