Return-Path: <linux-kernel+bounces-825227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F7B8B53B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B15B188F10D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C82D0C78;
	Fri, 19 Sep 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbHHLC3a"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E61BEF7E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317103; cv=none; b=ZOq0kTOo+1Rbomk0+1cB0BPsTZRy+QUPeRu/BIynOdseo4RbCbbA0i8yLZ+aMOcJYsddtvLQ2Tk1TfpT0V4s24iWxA2mVxpDCjphcS5rF8X87hHV8gF5ExQ2WaY3w4p66Q1lhLEVGWF/xse/vYmXKJcHKD7zbdG4YA7rxZ8riFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317103; c=relaxed/simple;
	bh=BoJlkfvqdznM80fL0xsvOPGegnaQY8desuyY1GCT70U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMlnd1aypz/uvS2HJKPkErPsBCcd4wsu+lJmcRoNA4ZiXINSghsYbU362iU4GXYxlmre42JySgJq2pknK5qP8ZkOEnImfyLRXoX6QSo/vcWT5gsJwG8egVDwvzakJMnnCWFe/4hH+ovEuaZ2f2BSoz2aljZH7yr2Tln3ACbGi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbHHLC3a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so3284275a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758317101; x=1758921901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5h+SgQfon+gdUf/bP5J0QnKtAug4HH7BbuoEPg9ZKk=;
        b=gbHHLC3a3Vf7QA044Y4mFEsO9EwmJ2Ymh0Li7uNTU0e5QDH3Ea45W+pHFCXviNMTLB
         VILTReVXeKpD7r3upQHQNIO0vhncyzH52YHiKT3lQNRyfcRDznCmh4F/EwQbIodWJv2b
         HcTJSacMhVk98yR0sCu/Tv6KSyfnmFR2wf5nE+/+fwwsSgVI3pqGGRDQMR+Qb+mgbrcK
         D4+lki7sgtzbMZog0wnsNHQ5SgrjCLzDYThxpBhUlkBlDqaMRamOnbYS2YfEDZ69On4I
         5qEZtoU/vKhYEx3Z5DWIRBrbxosMA6yJNtv6ErIvO3yua4S7Ou1NDJem08jSyMhQPJBC
         tnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758317101; x=1758921901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5h+SgQfon+gdUf/bP5J0QnKtAug4HH7BbuoEPg9ZKk=;
        b=ZMyFGCRYU8fOlvXuMn239VTfoMP0LwMeVuoU9kLfSmaCNKsWUxAfUc0pdsknlJggnI
         93KxrwNInevtoJ74tVDfdw6q9img2IQVrxahhSv8LjJZmPJAZlEjzEyECAyfjJN0B7PX
         g3F/0kw5rLzW4UePlzzEaz+jb+lscYsrI8Fk5f7ozXdLR7smz+cQKekqJhnsJD9f35v5
         t+82eu/SbrWzBEK+RAE/Up/JAhPWEls1lUaH9raWqp/MDpbdjZoW8XsgKW8F1JEx26Sb
         pHQfPnn9Bf7XK3h4lmN+c932y3oJrE98YMAYUihDcoYQnTuRUCqmHpdDd5rvrZcPXjw9
         DNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVkGrXN2IW/5XeoTz6L7IqsQeVhOW3vB9o3qse9gUJLFocalaxssRYgy7/DbuX1Ee5fJLtflUrUYieLPZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXJxCWduz+r3soxrculachnY8vP1VeC+5jXeXHOcsiq4zPuCS
	/mudD6baog1GFOuL0olIJzIdiKpB34d8s0nkv5L4KfK/zVoxy9axJ/ZNH2uH4G0KhflmigIxYHM
	lHXVO1Q==
X-Google-Smtp-Source: AGHT+IE/QM4XWrhvy2xXijLP75RJTcqwGdCRh/1/g+LlBQP/KUM7+8MRopsPRSzaT/IOFwN+kfG0jI26YFw=
X-Received: from pjqq8.prod.google.com ([2002:a17:90b:5848:b0:327:4fa6:eaa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8f:b0:32e:d649:f98c
 with SMTP id 98e67ed59e1d1-33097fd4481mr5876189a91.1.1758317100760; Fri, 19
 Sep 2025 14:25:00 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:24:58 -0700
In-Reply-To: <20250919181635.GFaM2eA8GFtZ48sfb0@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808172358.1938974-1-seanjc@google.com> <20250808172358.1938974-2-seanjc@google.com>
 <20250919181635.GFaM2eA8GFtZ48sfb0@fat_crate.local>
Message-ID: <aM3KKo84920sZ4Nc@google.com>
Subject: Re: [PATCH 1/3] x86/umip: Check that the instruction opcode is at
 least two bytes
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 19, 2025, Borislav Petkov wrote:
> On Fri, Aug 08, 2025 at 10:23:56AM -0700, Sean Christopherson wrote:
> > When checking for a potential UMIP violation on #GP, verify the decoder
> > found at least two opcode bytes to avoid false positives when the kernel
> > encounters an unknown instruction that starts with 0f.  Because the array
> > of opcode.bytes is zero-initialized by insn_init(), peeking at bytes[1]
> > will misinterpret garbage as a potential SLDT or STR instruction, and can
> > incorrectly trigger emulation.
> > 
> > E.g. if a vpalignr instruction
> > 
> >    62 83 c5 05 0f 08 ff     vpalignr xmm17{k5},xmm23,XMMWORD PTR [r8],0xff
> > 
> > hits a #GP, the kernel emulates it as STR and squashes the #GP (and
> > corrupts the userspace code stream).
> > 
> > Arguably the check should look for exactly two bytes, but no three byte
> > opcodes use '0f 00 xx' or '0f 01 xx' as an escape, i.e. it should be
> > impossible to get a false positive if the first two opcode bytes match
> > '0f 00' or '0f 01'.  Go with a more conservative check with respect to the
> > existing code to minimize the chances of breaking userspace, e.g. due to
> > decoder weirdness.
> 
> So I did some staring... I guess this fix is trying to address our insn
> decoder shortcoming and calls it "weirdness", right?
> 
> $ objdump -d a.out | awk -f ./arch/x86/tools/objdump_reformat.awk | ./arch/x86/tools/insn_decoder_test 
> ./arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> ./arch/x86/tools/insn_decoder_test: warning:    0:      62 83 c5 05 0f 08 ff    vpalignr $0xff,(%r8),%xmm23,%xmm17{%k5}
> ./arch/x86/tools/insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
> ./arch/x86/tools/insn_decoder_test: warning: Decoded and checked 1 instructions with 1 failures
> 
> Looks like it.
> 
> a.out has:
> 
> 0000000000000000 <.text>:
>    0:   62 83 c5 05 0f 08 ff    vpalignr $0xff,(%r8),%xmm23,%xmm17{%k5}
> 
> I guess just adding the insn to the table doesn't fix it.

vpalignr is just one example of an unhandled instruction, that's not what I find
weird.

The "weirdness" I am referring to is purely speculative; what I was trying to say
is that I deliberate went with a "bad" check on nbytes, i.e. it really should be
"insn->opcode.nbytes == 2".  But I didn't want to risk breaking some bizarre
userspace that happened to be relying on a quirk of the kernel's decoder (I
haven't dug into the decoder, so I genuinely have/had no idea what all could
happen).

> Masami?
> 
> ---
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index 262f7ca1fb95..a23ff3c16908 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -23,7 +23,7 @@
>  #
>  # AVX Superscripts
>  #  (ev): this opcode requires EVEX prefix.
> -#  (es): this opcode requires EVEX prefix and is SCALABALE.
> +#  (es): this opcode requires EVEX prefix and is SCALABLE.
>  #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
>  #  (v): this opcode requires VEX prefix.
>  #  (v1): this opcode only supports 128bit VEX.
> @@ -867,7 +867,7 @@ AVXcode: 3
>  0c: vblendps Vx,Hx,Wx,Ib (66)
>  0d: vblendpd Vx,Hx,Wx,Ib (66)
>  0e: vpblendw Vx,Hx,Wx,Ib (66),(v1)
> -0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1)
> +0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1) | vpalignr Vx,kz,Hx,Wx,Ib (ev)
>  14: vpextrb Rd/Mb,Vdq,Ib (66),(v1)
>  15: vpextrw Rd/Mw,Vdq,Ib (66),(v1)
>  16: vpextrd/q Ey,Vdq,Ib (66),(v1)
> 
> 
> > Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
> > Reported-by: Dan Snyder <dansnyder@google.com>
> > Analyzed-by; Nick Bray <ncbray@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kernel/umip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> > index 5a4b21389b1d..406ac01ce16d 100644
> > --- a/arch/x86/kernel/umip.c
> > +++ b/arch/x86/kernel/umip.c
> > @@ -156,8 +156,8 @@ static int identify_insn(struct insn *insn)
> >  	if (!insn->modrm.nbytes)
> >  		return -EINVAL;
> >  
> > -	/* All the instructions of interest start with 0x0f. */
> > -	if (insn->opcode.bytes[0] != 0xf)
> > +	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
> > +	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] != 0xf)
> >  		return -EINVAL;
> >  
> >  	if (insn->opcode.bytes[1] == 0x1) {
> > -- 
> > 2.50.1.703.g449372360f-goog
> > 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

