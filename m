Return-Path: <linux-kernel+bounces-837892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7786BADFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E7132330F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441C3081D7;
	Tue, 30 Sep 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdD5calo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC9846F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248020; cv=none; b=Mt/H9LhWympXH71Xien6/sfA0m8trvywQfLAtRuaGmfqF3/GPj8vvjvu5UhGJtcxysmdpxiYiHJAA0RqGyFeW3lmUa3ik0TG8c062odE761k27Yn8Kw/BA2i8WityEsqwDPREo2xB5ejUeGSbAG3YCBwTojkxS4Yuk3IAwLh4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248020; c=relaxed/simple;
	bh=GSJ3Tuqk0z4h10iD0gbxeErGgrOcpwHkxFR1XG0xRnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pu11yy8n/XrFiHLOhZhAOO97wUBJZHHGv9SGRVcXY6xtiZ7JE4MbV7HFlcXg5DEB1Klukc47gLB4LtMrSknW5sTpyBSpdAXFa0dS3qQnSjNYrdEkp2OXXuh9s1BoEFd3UqWKsEYKUI+xI6jMIegt0DKEEvqo1OBE2oNvnOxigGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdD5calo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5516e33800so7599118a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759248018; x=1759852818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rYsMrv7cvWNmJN7SEMktbFDyW8Yqojne1XpRSP9vpNs=;
        b=MdD5calojp9WQvXvPg+C9fAOze1KkXu2ztEnkIH2aaQ2aW+TRJOtHrWhjC3rnLzYAw
         Gz3zBMV7916gEAMJwSoNPVCImgIQF1Ppe0xbD8s+mH/eMO3sCjQERVTfIQflZM0U/iw9
         8W0H1bT6qC3cS+91Avqz01ILvLZsN0bZLoNQCP0tRBJ+UjReFKOkSsOVZ6Q/uy4IU+1H
         S/RCCHoHIk2WsAgQ7Q1uVJEras5LAENEYoz901ys+Wa51LMGPm8guZd7M1gxuJlpgbJf
         Iu0kTuKGIjLHpMMp3GYhziXTdiq86eu1ywaWEdqNgHfEdGrufledOvSIzztC20pi3Vh+
         UBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248018; x=1759852818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYsMrv7cvWNmJN7SEMktbFDyW8Yqojne1XpRSP9vpNs=;
        b=FeQQcC+ujm0OobfdHymVA4JSZsgmgAkUM+9l5myaSDdhV+FONOmUnDJYLYb4llLnIX
         h34usdwNhyjJH0CiOnN9WzeXlOKfWavJRuUuwPXySE3qscdLM2bl875dFORTsaZmNH+2
         /ec+OW2dLWFsCmPivs8EOzzSl2q95aYoSGpqSdfrAmNt5luKKrhBJxQ/J92sHlF16djS
         0b1m+QsDQNiLvA6NfWougTvfGu1X+yrSm0oAoddOvN/rT3MLVYEoa9UeBoD8O3Uf3JhQ
         gyNSPFZo1RiqT+ruzYsTMBZ3BdJaNo0K9dlROFVAa5rerq45DEI6O3J7HhCKCkkIrs1S
         dDpw==
X-Gm-Message-State: AOJu0YxvgLtNFjrHWtjjVQwkLVhUcFBakxKIhAhlPH+dGvyHvEnMqUCE
	q8fAkdnTHoXBt7rI75s17V/vPVpnvpDqraNLdJUdWelk0PoXRuM0K2McyNircwTBs5BM7jq13cl
	U4bs8Jg==
X-Google-Smtp-Source: AGHT+IGQIiv7hGVKB4D9BMN1zk7aNOmZXS6xXEoiu7JC9hiy6UVJ6TA6GcUrXlm1N41JvKhX4MpoDxhxdbM=
X-Received: from pgbfe1.prod.google.com ([2002:a05:6a02:2881:b0:b55:644:2ce1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3947:b0:2c2:f61b:5ff2
 with SMTP id adf61e73a8af0-321db66064fmr364127637.39.1759248018025; Tue, 30
 Sep 2025 09:00:18 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:00:16 -0700
In-Reply-To: <20250930070356.30695-10-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250930070356.30695-1-jgross@suse.com> <20250930070356.30695-10-jgross@suse.com>
Message-ID: <aNv-kJbDXYJpievg@google.com>
Subject: Re: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev, 
	xin@zytor.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Juergen Gross wrote:
> When available use one of the non-serializing WRMSR variants (WRMSRNS
> with or without an immediate operand specifying the MSR register) in
> __wrmsrq().
> 
> For the safe/unsafe variants make __wrmsrq() to be a common base
> function instead of duplicating the ALTERNATIVE*() macros. This
> requires to let native_wrmsr() use native_wrmsrq() instead of
> __wrmsrq(). While changing this, convert native_wrmsr() into an inline
> function.
> 
> Replace the only call of wsrmsrns() with the now equivalent call to
> native_wrmsrq() and remove wsrmsrns().
> 
> The paravirt case will be handled later.

...

> @@ -268,21 +357,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
>  	return err;
>  }
>  
> -/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
> -#define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
> -
> -/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
> -static __always_inline void wrmsrns(u32 msr, u64 val)

FYI, a use of wrmsrns() is likely coming in through the KVM (x86) tree, commit
65391feb042b ("KVM: VMX: Add host MSR read/write helpers to consolidate preemption
handling").

Probably makes sense to spin v3 after the merge window?  Or on linux-next? (I
can't tell what was used as the base, and I double-checked that the above commit
is in linux-next).

> -{
> -	/*
> -	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
> -	 * DS prefix to avoid a trailing NOP.
> -	 */
> -	asm volatile("1: " ALTERNATIVE("ds wrmsr", ASM_WRMSRNS, X86_FEATURE_WRMSRNS)
> -		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
> -		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
> -}
> -
>  static inline void wrmsr(u32 msr, u32 low, u32 high)
>  {
>  	wrmsrq(msr, (u64)high << 32 | low);
> -- 
> 2.51.0
> 

