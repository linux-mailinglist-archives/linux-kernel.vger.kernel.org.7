Return-Path: <linux-kernel+bounces-814587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941BB55619
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CDA3B6284
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84832ED28;
	Fri, 12 Sep 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ByFZ4YU7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B723009D5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701627; cv=none; b=otYvGmwfKeBkWWwK0eFltY/aOdwLaONW1xdbnBIh20RSvR/y6wQo5M2HCWNxxiahh+GhHpW382sAJi0jNqrhp3q0QSqYTMPKEpK8rwbKhWnJk9vn9Z32N4XChrQmUwJrsM4lrBr/xU1n31dNjJYJz5LPqg/oUodf75+ZCaCghok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701627; c=relaxed/simple;
	bh=uf1MpVa7hu3R+Dlp/s38NGIOLG55B82K/WwvCNFzo1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEGGPJpzHrJRoBXcuopu/9XQHXJ8M+h6rsKl5CmxWC6f5MxT06MiZM+RgOWzvZejJyAj5HKOXpjmlPU2V1qNb9dzw5JMPyGOWIFlJUHsYCJi7Q71SUWgiYrN+Hl+7r8sc6fktcIpxn4rmmrG2kR+hhQnsc4RexEAeFTGH/6jqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ByFZ4YU7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D0D240E0163;
	Fri, 12 Sep 2025 18:27:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZR8eo5wKTNnl; Fri, 12 Sep 2025 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757701617; bh=tEkWpVShjHWN8G7HDsDrSrhuSPzivfZLLla+d0bsxFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByFZ4YU7fXS0RD4Vc6jeL+QZ6opIHVbXFQEoOI8YLYH5c2bjYO9K6zIe1AozwlUw8
	 3WbTQpHQBtNsYq/eqbyCHuN0UtC4DpINy7y+VjOY82B5L1pNCNiQErCX8xXpxWCXx9
	 2/3j2tG11ii+0roHNWr1E8oIcDyLzUfgKE382rujku4//U80cFxZaTB3vEcAh1vAfn
	 kIB68SXMh1WVAjmnPJMcI6detW6gSz4Eg3iJXGkdDEOP2bM1rPbXP4nRyNLLDKkho0
	 ixog7mcQdkFZPX/IFkjk017rx4rh4u+f75X8ijww8a9Wam/itTP/9Tnavqu9wzq2o2
	 GF+5wH1sm3Lhyl9It/xpgZVt4voXl7ojHTGa4cKv1kwxObEuxPI+fzpfVswxbM3kI+
	 7qjZbK1v8rmq1rcNcxM18LdCtfVxf3QB7mWUOWlDb+oU+uTLLKbKEyYRSTUBEbVbwT
	 ZZ/UzS2JTH6hIc9XaapIOswUmWGpgfg4Q+KkLoGlnV4z+AyM+aoKd7387f21K3b8CX
	 TNJHi4XENvGyFmRZMK09psqfInZMshCOV0w0lLH2DRtY/nR3hCegXrSgRKiei1Qlld
	 aUZk/OjDcZhKA9YAsxTcOQcc7ABF+IYdWpjqgtqZX5lAe4YkokXcsy7tWIzI0BLLOJ
	 JcHtpD5R7LivFs7x+p1riEmA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E340040E00DD;
	Fri, 12 Sep 2025 18:26:47 +0000 (UTC)
Date: Fri, 12 Sep 2025 20:26:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/boot 10/10]
 arch/x86/boot/compressed/sev-handle-vc.c:104 do_boot_stage2_vc() error: we
 previously assumed 'boot_ghcb' could be null (see line 101)
Message-ID: <20250912182642.GCaMRl4nu7R9C8uP6R@fat_crate.local>
References: <202505100719.9pE7wDfB-lkp@intel.com>
 <CAMj1kXHyVh7KwNyekd8ZAATufnMHyzyMismVf2xW8F=LfBJviQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHyVh7KwNyekd8ZAATufnMHyzyMismVf2xW8F=LfBJviQ@mail.gmail.com>

On Sat, May 10, 2025 at 09:57:23AM +0200, Ard Biesheuvel wrote:
> The logic is a bit clunky here: for clarity, it could be rewritten as
> 
> if (!boot_ghcb) {
>   early_setup_ghcb();
>   if (!boot_ghcb)
>     sev_es_terminate(...);
> }

I like that. Untested patch below:

---

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 12 Sep 2025 20:21:39 +0200
Subject: [PATCH] x86/sev: Clean up boot_ghcb assignment

Make it more obvious that early_setup_ghcb() assigns the boot_ghcb
pointer by simply returning it. This way the code becomes a bit
more readable and comprehensible.

No functional changes intended.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202505100719.9pE7wDfB-lkp@intel.com
---
 arch/x86/boot/compressed/misc.h          |  2 +-
 arch/x86/boot/compressed/sev-handle-vc.c |  5 ++++-
 arch/x86/boot/compressed/sev.c           | 11 +++++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index db1048621ea2..648f751538de 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -150,7 +150,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt);
 enum es_result vc_decode_insn(struct es_em_ctxt *ctxt);
 bool insn_has_rep_prefix(struct insn *insn);
 void sev_insn_decode_init(void);
-bool early_setup_ghcb(void);
+struct ghcb *early_setup_ghcb(void);
 #else
 static inline void sev_enable(struct boot_params *bp)
 {
diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
index 7530ad8b768b..66b29fbb9f57 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -101,7 +101,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	struct es_em_ctxt ctxt;
 	enum es_result result;
 
-	if (!boot_ghcb && !early_setup_ghcb())
+	if (!boot_ghcb)
+		boot_ghcb = early_setup_ghcb();
+
+	if (!boot_ghcb)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 
 	vc_ghcb_invalidate(boot_ghcb);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6e5c32a53d03..f9dcd1b795d7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -75,10 +75,10 @@ void snp_set_page_shared(unsigned long paddr)
 	__page_state_change(paddr, paddr, &d);
 }
 
-bool early_setup_ghcb(void)
+struct ghcb *early_setup_ghcb(void)
 {
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
-		return false;
+		return NULL;
 
 	/* Page is now mapped decrypted, clear it */
 	memset(&boot_ghcb_page, 0, sizeof(boot_ghcb_page));
@@ -92,7 +92,7 @@ bool early_setup_ghcb(void)
 	if (sev_snp_enabled())
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 
-	return true;
+	return boot_ghcb;
 }
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
@@ -216,6 +216,9 @@ void snp_check_features(void)
 {
 	u64 unsupported;
 
+	if (!boot_ghcb)
+		boot_ghcb = early_setup_ghcb();
+
 	/*
 	 * Terminate the boot if hypervisor has enabled any feature lacking
 	 * guest side implementation. Pass on the unsupported features mask through
@@ -224,7 +227,7 @@ void snp_check_features(void)
 	 */
 	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
-		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
+		if (ghcb_version < 2 || !boot_ghcb)
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
 		sev_es_ghcb_terminate(boot_ghcb, SEV_TERM_SET_GEN,
-- 
2.51.0



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

