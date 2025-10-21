Return-Path: <linux-kernel+bounces-862800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDCBF6377
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7D19A2346
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28769343214;
	Tue, 21 Oct 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X75QaTCh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA82342CA9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047171; cv=none; b=Rd431xoeKv8QzKdi7zpqxV904oG2MMcYekodI+41bSzfOw/H1Q4A46JWxF1f2T97TwKNBLl06xByxQl+7JduRQ5Ba3wrmtUc8i3C4v6ULwKQPYh51oeG+2Yn6Hs1OMBcA/yG4lkjd6gniKBqYxN1kAGR+TlaTWX2LwdRDEJgDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047171; c=relaxed/simple;
	bh=zMIhkhz3h7k4JTdPmYQDau/zLc7Og9w1ZJqQb/3IURQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKnZIcp78vxlaco982FGBHOrpwhDYSrP8aJr5oXH3hZHLEkl1NS3h2GPCClWZAMUDzA7So9UGtprR+QUb8SV4YSuxz594aSHCUFcMuqNHNoEpIZJ63hSyre538Msvi2Y4dY9O9oOnIpwR9lZWxG2kSgbrhyDkCmdERoWQDprffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X75QaTCh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B75F840E00DE;
	Tue, 21 Oct 2025 11:46:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0W_APc-Z99YH; Tue, 21 Oct 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761047159; bh=yxV1oJp1tA9xOSRaGwAzu03hV2SSPLA2YN4EeBVpoaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X75QaTCh8Kc++ZTy+upzA0kBjn0JD13W7icC4Hjub/wuf/kgi8bhItN5zY4THbJVu
	 jq5nvHbnuTDTrmXPiPPGcv5SM8sngyRynCb/KyvL1SxuI7MUdAsTKf/w7b0IyitO7H
	 LA7lu7ltvIpbOn4tQDkKCwPlkXR8BIqO4FtwJSxMdCPPFWKoX0C9ekCtlD+ZmzVBK3
	 4VIXWiyjasu5pagjnAY09tGnTDCM7ackBhUzGNJIh5Zy2M6uvBAucZTYa7EgPv2K3L
	 x8kvey610sIUQb0mF4kjZSew/G2FSoeFyIPm4llsFdw4IDNyvuPODg94odpzGKyovZ
	 F5hxNVngPxWPZtzVQSaWdvXqzPHmudwJb5JAczzmDSSkkZ19sO/v+u2BcOR5gZvMWp
	 +vsHQqHu+Q8q+3lEBG0q/zxYnS9Y7401XutgyDjLa9j08YPAUQEfgkmwaep2PrTmDy
	 f6O+ocFLbIxa5s24fXskn/DrEN7M4Ls44k7Q3URDg2Bms4jfY4ZGsf/bC+RFZ7wLja
	 vnXUwCOPhQPvMKBEKtUcZgh0k0Hh+xDYPlwrvTOphEAXH6f0HLbypfWdCzgpG1FgHV
	 nKP5XDEXVDa24uKH3TtkDHfdeUyW1ZE2QLiV25qi+cWNV8hdEzLOk1vgDVZkMHHNr1
	 LbpPnpTZhZItsBnREd8zRSto=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5877740E01A5;
	Tue, 21 Oct 2025 11:45:52 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:45:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/alternative: Patch a single alternative location
 only once
Message-ID: <20251021114546.GCaPdyaobVuEDvt_yi@fat_crate.local>
References: <20251015093001.14840-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015093001.14840-1-jgross@suse.com>

On Wed, Oct 15, 2025 at 11:30:01AM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 4f3ea50e41e8..b6b2fa59eaa9 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -642,57 +642,62 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  	 * So be careful if you want to change the scan order to any other
>  	 * order.
>  	 */
> -	for (a = start; a < end; a++) {
> +	for (a = start; a < end; a = b) {
				^^^^^^^


>  		unsigned int insn_buff_sz = 0;
> +		struct alt_instr *p = NULL;
> +		u8 len = 0;
>  
>  		/*
>  		 * In case of nested ALTERNATIVE()s the outer alternative might
>  		 * add more padding. To ensure consistent patching find the max
>  		 * padding for all alt_instr entries for this site (nested
>  		 * alternatives result in consecutive entries).
> +		 * Find the last alt_instr eligible for patching at the site.
>  		 */
> -		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
		     ^^^^^^^^^^^

No,  this is not a contest in how to make an already obfuscated code more
obfucated.

And I already told you to use helper functions...

The intent is to separate this loop logically into helper functions so that it
is easily extendable and understandable. What it is becoming now, is
unreadable mess.

And piling up more and more hackery ontop doesn't make it better.

Here's what I mean below.

- you carve out the logic which analyzes the patch sites into a separate
  function and you do all the analysis there

- The struct patch_site is there to carry results which we copy back to the
  loop variables for easier review so that the diff doesn't become unwieldy.
  There's no problem to switch to using a patch_site everywhere in the loop as
  the actual info collecting structure which controls the patching on each
  iteration

- In other patches, you can carve out the actual patching into a separate
  function. There you can add the patch_one_site function to make it even more
  clear

Can it be made even simpler? 

Sure, this was my first attempt.

Just don't make an already complex dance even more complex.

Thx.

---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e377b06e70e3..f8e4679b7638 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -586,6 +586,34 @@ static inline u8 * instr_va(struct alt_instr *i)
 	return (u8 *)&i->instr_offset + i->instr_offset;
 }
 
+struct patch_site {
+	u8 len;
+	u8 *instr_va;
+	u8 *repl_va;
+};
+
+/*
+ * In case of nested ALTERNATIVE()s the outer alternative might add more
+ * padding. To ensure consistent patching find the max padding for all
+ * alt_instr entries for this site (nested alternatives result in
+ * consecutive entries).
+ */
+static void __init_or_module analyze_patch_site(struct patch_site *ps, struct alt_instr *p,
+						struct alt_instr *end)
+{
+	struct alt_instr *tmp;
+
+	ps->len = p->instrlen;
+
+	for (tmp = p+1; tmp < end && instr_va(tmp) == instr_va(p); tmp++)
+		ps->len = max(p->instrlen, tmp->instrlen);
+
+	BUG_ON(ps->len > MAX_PATCH_LEN);
+
+	ps->instr_va = instr_va(p);
+	ps->repl_va  = (u8 *)&p->repl_offset + p->repl_offset;
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -601,7 +629,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 {
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr, *replacement;
-	struct alt_instr *a, *b;
+	struct alt_instr *a;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
@@ -626,23 +654,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 */
 	for (a = start; a < end; a++) {
 		unsigned int insn_buff_sz = 0;
+		struct patch_site ps = {};
+		u8 len;
 
-		/*
-		 * In case of nested ALTERNATIVE()s the outer alternative might
-		 * add more padding. To ensure consistent patching find the max
-		 * padding for all alt_instr entries for this site (nested
-		 * alternatives result in consecutive entries).
-		 */
-		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
-			u8 len = max(a->instrlen, b->instrlen);
-			a->instrlen = b->instrlen = len;
-		}
-
-		instr = instr_va(a);
-		replacement = (u8 *)&a->repl_offset + a->repl_offset;
-		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
+		analyze_patch_site(&ps, a, end);
+
+		instr = ps.instr_va;
+		len = ps.len;
+		replacement = ps.repl_va;
+
 		/*
 		 * Patch if either:
 		 * - feature is present
@@ -650,16 +672,16 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, instr, a->instrlen);
-			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(instr, insn_buff, a->instrlen);
+			memcpy(insn_buff, instr, len);
+			optimize_nops(instr, insn_buff, len);
+			text_poke_early(instr, insn_buff, len);
 			continue;
 		}
 
 		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
+			instr, instr, len,
 			replacement, a->replacementlen, a->flags);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
@@ -668,12 +690,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		if (a->flags & ALT_FLAG_DIRECT_CALL)
 			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
 
-		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+		for (; insn_buff_sz < len; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+		text_poke_apply_relocation(insn_buff, instr, len, replacement, a->replacementlen);
 
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, instr, len, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

