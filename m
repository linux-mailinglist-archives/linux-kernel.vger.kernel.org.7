Return-Path: <linux-kernel+bounces-897195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A2BC52391
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0C69349952
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA477328602;
	Wed, 12 Nov 2025 12:18:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2D328B40
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949888; cv=none; b=eiR/B4yykMvz8zoaPsCJ/wAu4OPLAIRMk2hFVQ450OE4TX8SOJHLvvM74/mRdO7L1Ne9hsOqwjE5V9a6rKN07Lmr5KL7pLRjaNCzoM1hM4XBAts8rRpuT0uHZ1fe7lgyayFrlOMWKp/06vXDgN6sJ5wRy53HdoBEl820S954Bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949888; c=relaxed/simple;
	bh=U1wkHqQ/RzPc5yZ4GQaY0fCPrrdhvptHL5fIHNTPZ3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOu84UFAqHv8yD/NbCfI9khl/oaHEjpMQ9mwke+BnqtlJH7i94j/XfAG/3ByGpHwKA8cv0SpsMh0FArGaf0MxQlWeZ9TN+GvwfnJAFwsdSm4bS0MxG8zBoSwu9/otwFG0W3LzdewUuRZ1KcGKEeVLQEXBduMhbHlFnhORjHfEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83B61515;
	Wed, 12 Nov 2025 04:17:53 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F11C3F5A1;
	Wed, 12 Nov 2025 04:18:00 -0800 (PST)
Date: Wed, 12 Nov 2025 12:17:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Khaja Hussain Shaik Khaji <khaja.khaji@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, kprobes@vger.kernel.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	catalin.marinas@arm.com, masami.hiramatsu@linaro.org
Subject: Re: [PATCH] arm64: insn: Route BTI to simulate_nop to avoid XOL/SS
 at function entry
Message-ID: <aRR68v7oABi_72zo@J2N7QTR9R3>
References: <20251106104955.2089268-1-khaja.khaji@oss.qualcomm.com>
 <aRMPZB6W04_l7iSB@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRMPZB6W04_l7iSB@J2N7QTR9R3>

On Tue, Nov 11, 2025 at 10:26:44AM +0000, Mark Rutland wrote:
> On Thu, Nov 06, 2025 at 04:19:55PM +0530, Khaja Hussain Shaik Khaji wrote:
> > On arm64 with branch protection, functions typically begin with a BTI
> > (Branch Target Identification) landing pad. Today the decoder treats BTI
> > as requiring out-of-line single-step (XOL), allocating a slot and placing
> > an SS-BRK. Under SMP this leaves a small window before DAIF is masked
> > where an asynchronous exception or nested probe can interleave and clear
> > current_kprobe, resulting in an SS-BRK panic.
> 
> If you can take an exception here, and current_kprobe gets cleared, then
> XOL stepping is broken in general, but just for BTI.

Sorry, I typo'd the above. That should say:

  If you can take an exception here, and current_kprobe gets cleared,
  then XOL stepping is broken in general, *not* just for BTI.

I took a look at the exception entry code, and AFIACT DAIF is not
relevant. Upon exception entry, HW will mask all DAIF exception, and we
don't unmask any of those while handling an EL1 BRK.

Given that, IIUC the only way this can happen is if we can place a
kprobe on something used during kprobe handling (since BRK exceptions
aren't masked by DAIF). I am certain this is possible, and that kprobes
isn't generally safe; the existing __kprobes annotations are inadequent
and I don't think we can make kprobes generally sound without a
significant rework (e.g. to make it noinstr-safe).

Can you share any details on how you triggered this? e.g. what functions
you had kprobes on, whether you used any specific tooling?

Mark.

> > Handle BTI like NOP in the decoder and simulate it (advance PC by one
> > instruction). This avoids XOL/SS-BRK at these sites and removes the
> > single-step window, while preserving correctness for kprobes since BTI’s
> > branch-target enforcement has no program-visible effect in this EL1
> > exception context.
> 
> One of the reasons for doing this out-of-line is that we should be able
> to mark the XOL slot as a guarded page, and get the correct BTI
> behaviour. It looks like we don't currently do that, which is a bug.
> 
> Just skipping the BTI isn't right; that throws away the BTI target
> check.
> 
> > In practice BTI is most commonly observed at function entry, so the main
> > effect of this change is to eliminate entry-site single-stepping. Other
> > instructions and non-entry sites are unaffected.
> > 
> > Signed-off-by: Khaja Hussain Shaik Khaji <khaja.khaji@oss.qualcomm.com>
> > ---
> >  arch/arm64/include/asm/insn.h            | 5 -----
> >  arch/arm64/kernel/probes/decode-insn.c   | 9 ++++++---
> >  arch/arm64/kernel/probes/simulate-insn.c | 1 +
> >  3 files changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> > index 18c7811774d3..7e80cc1f0c3d 100644
> > --- a/arch/arm64/include/asm/insn.h
> > +++ b/arch/arm64/include/asm/insn.h
> > @@ -452,11 +452,6 @@ static __always_inline bool aarch64_insn_is_steppable_hint(u32 insn)
> >  	case AARCH64_INSN_HINT_PACIASP:
> >  	case AARCH64_INSN_HINT_PACIBZ:
> >  	case AARCH64_INSN_HINT_PACIBSP:
> > -	case AARCH64_INSN_HINT_BTI:
> > -	case AARCH64_INSN_HINT_BTIC:
> > -	case AARCH64_INSN_HINT_BTIJ:
> > -	case AARCH64_INSN_HINT_BTIJC:
> > -	case AARCH64_INSN_HINT_NOP:
> >  		return true;
> >  	default:
> >  		return false;
> > diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> > index 6438bf62e753..7ce2cf5e21d3 100644
> > --- a/arch/arm64/kernel/probes/decode-insn.c
> > +++ b/arch/arm64/kernel/probes/decode-insn.c
> > @@ -79,10 +79,13 @@ enum probe_insn __kprobes
> >  arm_probe_decode_insn(u32 insn, struct arch_probe_insn *api)
> >  {
> >  	/*
> > -	 * While 'nop' instruction can execute in the out-of-line slot,
> > -	 * simulating them in breakpoint handling offers better performance.
> > +	 * NOP and BTI (Branch Target Identification) have no program‑visible side
> > +	 * effects for kprobes purposes. Simulate them to avoid XOL/SS‑BRK and the
> > +	 * small single‑step window. BTI’s branch‑target enforcement semantics are
> > +	 * irrelevant in this EL1 kprobe context, so advancing PC by one insn is
> > +	 * sufficient here.
> >  	 */
> > -	if (aarch64_insn_is_nop(insn)) {
> > +	if (aarch64_insn_is_nop(insn) || aarch64_insn_is_bti(insn)) {
> >  		api->handler = simulate_nop;
> >  		return INSN_GOOD_NO_SLOT;
> >  	}
> 
> I'm not necessarily opposed to emulating the BTI, but:
> 
> (a) The BTI should not be emulated as a NOP. I am not keen on simulating
>     the BTI exception in software, and would strongly prefer that's
>     handled by HW (e.g. in the XOL slot).
> 
> (b) As above, it sounds like this is bodging around a more general
>     problem. We must solve that more general problem.
> 
> > diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> > index 4c6d2d712fbd..b83312cb70ba 100644
> > --- a/arch/arm64/kernel/probes/simulate-insn.c
> > +++ b/arch/arm64/kernel/probes/simulate-insn.c
> > @@ -200,5 +200,6 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
> >  void __kprobes
> >  simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> >  {
> > +	/* Also used as BTI simulator: both just advance PC by one insn. */
> >  	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> >  }
> 
> This comment should go.
> 
> Mark.
> 

