Return-Path: <linux-kernel+bounces-791505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D29B3B7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FFA3B2576
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A981304BC2;
	Fri, 29 Aug 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YvcKF4Cl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CE304BA6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460726; cv=none; b=hsliMre3vg+k+D5DOn8/p1MD9MLX1EdLd/aJTr5o5t914a1eP7ANgTr/kxquxBgPNWNmnk8Myaf4mw1Z9/yQMqgBPNlDtNLPW5OKR9zF3t0ct6oJUlyT0qjwJuUIG03xKa4g//tMgmIlwR6rJasUqmrH4fd6IdF1ZK8URinAmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460726; c=relaxed/simple;
	bh=+foucGYzxJBON3Mn9SgAn9akNnnjJ/qONQHRu5ILRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPRkV5hjbrzqOsIy++UBWCWt1jRx33TpCFmGFcFbUd5ATTChdf49iDayEyNpg3D0QDBTOlzsIEA9gZdomINb72xFVi58U37ilOdylCUCVLbfTt2mRxCX6voYPNR6sbvWllb4xf79JJ4qlhcYWfzVv8NYJtb+J2Yk4rmL/pb31ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YvcKF4Cl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD62140E0176;
	Fri, 29 Aug 2025 09:45:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vfz1mTCKzWGZ; Fri, 29 Aug 2025 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756460714; bh=EJv9K06Xys9sxOb2km/k6kE2MNMGFGWR5/GASrLguJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvcKF4ClIS+Yhj1soELckA3sS30BhH/7UvPcPlM7Cj+M4MuvQPevMHxCDazxBQVxP
	 nqKiZtiv3qJzwxfqF+uq8qb0Y//p7rlvhlDKzWUi6ix5A3rCih4SX+FFd1AyxrYP/v
	 D1uNqkiHakCNj85c+4rYKiIIcL6P3J1kWo82n2UFdmI8FK5h1m7juTJkA3ANcMcfNM
	 HR5B5f0kvPgP+jhVGtK60MDr5ai846So+3STynvMRU9QHtBtvsFbOK9bfLl1DrOWyx
	 x31Sa8tan2e62X824YesjzoZ/wexnyA3Uf1VBEqSyJcSvjSHlOFcHHq6A4plTGus27
	 hTsI1Bjqp0gsXh3YYlep664kqW+kZdwYij+7bPNXfwU7JNVttvV7CcUWVyKwhsRuLP
	 N2fwINBzuNSPImJnI48YAH5a1E10JnBKzGFboxekjOWRRrrvnvuZvJtgqJ4ggnNiiq
	 OL0uRIDsyOXz1OfdjEpeq0EPnx1DsNQdLd6e0UHYGYnu+OXvCJwOiRfXidjgz8nVp7
	 94YhKVfFGYheaQ6ACKKWw1GtpaHZE+74QMvyUImaodJEJlq9lgVKNfxk2qbFgbdaob
	 sBjw8Xz7vuuwnFVjPp5DK5bu35DrEVzlj14+z4lVc2dKt2Di6eJyeQ2G18K7nXzI/3
	 yUiT2USrNWxbFJaMmKjU++hc=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 713F940E016D;
	Fri, 29 Aug 2025 09:45:09 +0000 (UTC)
Date: Fri, 29 Aug 2025 11:45:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
Message-ID: <20250829094502.GAaLF2nkL2EtFlDGOB@fat_crate.local>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
 <2cd370e9-6fd8-4aed-8fe8-c8526a1ab97f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cd370e9-6fd8-4aed-8fe8-c8526a1ab97f@intel.com>

On Wed, Aug 20, 2025 at 10:19:11PM -0700, Sohil Mehta wrote:
> Does this need to be (IS_ENABLED(CONFIG_MICROCODE_DBG) && dbg)?

Both you and Nikolay have a point - we don't need both. So actually, dbg can
go and can be added when really needed.

Right now, the debugging stuff is for in a guest only and will be build-time
enabled.

If we decide we want to have runtime controllable and *baremetal* debugging,
then we can extend that and add the cmdline switch.

I think...

---

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7badf2aba63..2c142e5f9f06 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3774,8 +3774,6 @@
 			Set the base microcode revision of each thread when in
 			debug mode.
 
-			dbg: enable debugging mode when run in a guest
-
 			dis_ucode_ldr: disable the microcode loader
 
 			force_minrev:
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index f045670a1fae..f75c140906d0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -53,8 +53,6 @@ bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
  * instead, leave them in. When microcode debugging is not enabled,
  * those are meaningless anyway.
  */
-/* enable loader debugging */
-bool dbg;
 /* base microcode revision for debugging */
 u32 base_rev;
 u32 microcode_rev[NR_CPUS] = {};
@@ -130,7 +128,8 @@ bool __init microcode_loader_disabled(void)
 	 *    overwritten.
 	 */
 	if (!cpuid_feature() ||
-	    ((native_cpuid_ecx(1) & BIT(31)) && !dbg) ||
+	    ((native_cpuid_ecx(1) & BIT(31)) &&
+	      !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr = true;
 
@@ -145,9 +144,6 @@ static void early_parse_cmdline(void)
 	if (cmdline_find_option(boot_command_line, "microcode", cmd_buf, sizeof(cmd_buf)) > 0) {
 		while ((s = strsep(&p, ","))) {
 			if (IS_ENABLED(CONFIG_MICROCODE_DBG)) {
-				if (!strcmp(s, "dbg"))
-					dbg = true;
-
 				if (strstr(s, "base_rev=")) {
 					/* advance to the option arg */
 					strsep(&s, "=");
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index bca806dd1aac..ae8dbc2b908d 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -46,7 +46,6 @@ extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 extern u32 microcode_rev[NR_CPUS];
 extern u32 base_rev;
-extern bool dbg;
 
 struct cpio_data find_microcode_in_initrd(const char *path);
 
@@ -128,7 +127,7 @@ static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
 
 #define ucode_dbg(fmt, ...)					\
 ({								\
-	if (dbg)						\
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG))			\
 		pr_info(fmt, ##__VA_ARGS__);			\
 })
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

