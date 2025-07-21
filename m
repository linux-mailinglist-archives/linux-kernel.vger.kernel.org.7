Return-Path: <linux-kernel+bounces-739711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E643B0C9EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4413BA258
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE352E1742;
	Mon, 21 Jul 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRpduH6a"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DE1ACED7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119942; cv=none; b=Itmtrbf7jszbBLSHi05Ga2hE/jxaDrCDuzVCPgzRShK6g3dAF4BDq1FFjR9I7Z1PXCoGFAencp/KmKLqHpoCZHphQ/xtlmXSI8khLH66dNSt4QPAshF+yYDSQhbIBqz+4ZDzdW+sN5OgDgY59Ue38+vUal9zB8hVvKERZdE9sPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119942; c=relaxed/simple;
	bh=GB4zskA2ZYlvODr9l5/H+sJppM55rCMxnwfZA4FdtwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ja2kS+7Dt+VmQ0kzN4cFHXlviIqdf9cU/l4L0GERHm034rqxnnWYO+tJbLOR235MFLktwLYK2X3jq5bosk7baPNCjBdvJLjJzbuj/jvizEvOn2XsgmfX71Kwc1eVTzBKTDHKp3IWacxpMWvcFWfcbIa/18hrqM6AzbWIFcKk8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRpduH6a; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23692793178so37721245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753119940; x=1753724740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=di7TexfbhffoSOH6ZsYX7OktFXPZVnJiau3m+090UpA=;
        b=pRpduH6ao4dbfwVSKtvTtxZplskwlT0wq06rWUI9+NpkdBqPiu80EmY9wdDCJRrNBi
         982YJn0FNVkWYkVUEx3QBMFWa7CPtIxojTjRRJh0ZFd8dOuSs6UapPCErxuums+iI/97
         q7Pw2B/eqWgaEoXWtpErJktaPbA0xWHF0E/d3gbdOQNUslbA0MbebsRIjhl6aG3iSqLW
         tET4efRqSqTy1XjrMxzDDperOWPflkw+Qp6sjuyy0Dfy9JlkP4ZKgOTyjXwryqNgcOWk
         KSlt1ZVHrOK624YJksa1feQAx0oN0XpCMp6nXmgB1ETi+7S04WKqfAVjFmnQcpy0Ly89
         Kafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119940; x=1753724740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di7TexfbhffoSOH6ZsYX7OktFXPZVnJiau3m+090UpA=;
        b=SfqeXHS1RNyTiwL7ym2kfUwDkzRPoyfbhdReUCQav4K1h/VmrvlyHhVHljR9wVi5IZ
         0yo8O/nCPfvSFue1kMuUVHXKzGwISSyLic8RsaX05VyV6FpqY8lrzuT/ffjtZSPfntdz
         tbC35lCohFrlYC93OEeInQJve3b1XGNXdi7i8RVBFzvuOnDsOnsPwmuAX7Vjse2F+nG9
         UrURDFuQCurUtdgxILJlykPOJYNItrKiqhNv6ref0TV4gJeLVD925S7XKb/Y5U1qJO8C
         aP41JiI9AQnpGxqyL2QBhEB+jeu/Vd1ri9ojqnv1pyLiJakodtIhZYBet7g3aBfDyZvN
         mNzA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Rg9SOnMqfuqThSZe6chd+JE96ufvlpRNdT4CEYD7un4SYcx1Br29oWHiypbMC3OtEmitCYtnfhAF/Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4p3nJApoY2pToBKwbsKOU46O1gXL+KCgZpEVNWBBpAiFRN3b
	lphdgdi+quR6NgRw9fN3iqlt9YH9jmrv0JT6hiURDsTZhpABBdYcsAlS/+cy1J+zCSxWjFGlvQl
	GMxmwEw==
X-Google-Smtp-Source: AGHT+IHiKAzk+Gj92dMWbjReV05ys85siAtjhNZ+WoJphGuFPtx3rF6tRTIcG/LNVyw1tkXMwMoYptXCIv0=
X-Received: from pgbdw5.prod.google.com ([2002:a05:6a02:4485:b0:b3f:3145:8216])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54f:b0:234:c65f:6c0c
 with SMTP id d9443c01a7336-23e3b78d523mr188481485ad.15.1753119940553; Mon, 21
 Jul 2025 10:45:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:45:39 -0700
In-Reply-To: <4114d399-8649-41de-97bf-3b63f29ec7e8@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704085027.182163-1-chao.gao@intel.com> <20250704085027.182163-20-chao.gao@intel.com>
 <4114d399-8649-41de-97bf-3b63f29ec7e8@grsecurity.net>
Message-ID: <aH58w_wHx3Crklp4@google.com>
Subject: Re: [PATCH v11 19/23] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, pbonzini@redhat.com, dave.hansen@intel.com, 
	rick.p.edgecombe@intel.com, mlevitsk@redhat.com, john.allen@amd.com, 
	weijiang.yang@intel.com, xin@zytor.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 21, 2025, Mathias Krause wrote:
> On 04.07.25 10:49, Chao Gao wrote:
> > From: Yang Weijiang <weijiang.yang@intel.com>
> > 
> > Expose CET features to guest if KVM/host can support them, clear CPUID
> > feature bits if KVM/host cannot support.
> > [...]
> 
> Can we please make CR4.CET a guest-owned bit as well (sending a patch in
> a second)? It's a logical continuation to making CR0.WP a guest-owned
> bit just that it's even easier this time, as no MMU role bits are
> involved and it still makes a big difference, at least for grsecurity
> guest kernels.

Out of curiosity, what's the use case for toggling CR4.CET at runtime?

> Using the old test from [1] gives the following numbers (perf stat -r 5
> ssdd 10 50000):
> 
> * grsec guest on linux-6.16-rc5 + cet patches:
>   2.4647 +- 0.0706 seconds time elapsed  ( +-  2.86% )
> 
> * grsec guest on linux-6.16-rc5 + cet patches + CR4.CET guest-owned:
>   1.5648 +- 0.0240 seconds time elapsed  ( +-  1.53% )
> 
> Not only is it ~35% faster, it's also more stable, less fluctuation due
> to less VMEXITs, I believe.
> 
> Thanks,
> Mathias
> 
> [1]
> https://lore.kernel.org/kvm/20230322013731.102955-1-minipli@grsecurity.net/

> From 14ef5d8b952744c46c32f16fea3b29184cde3e65 Mon Sep 17 00:00:00 2001
> From: Mathias Krause <minipli@grsecurity.net>
> Date: Mon, 21 Jul 2025 13:45:55 +0200
> Subject: [PATCH] KVM: VMX: Make CR4.CET a guest owned bit
> 
> There's no need to intercept changes of CR4.CET, make it a guest-owned
> bit where possible.

In the changelog, please elaborate on the assertion that CR4.CET doesn't need to
be intercepted, and include the motiviation and perf numbers.  KVM's "rule" is
to disable interception of something if and only if there is a good reason for
doing so, because generally speaking intercepting is safer.  E.g. KVM bugs are
less likely to put the host at risk.  "Because we can" isn't not a good reason :-)

E.g. at one point CR4.LA57 was a guest-owned bit, and the code was buggy.  Fixing
things took far more effort than it should have there was no justification for
the logic (IIRC, it was done purely on the whims of the original developer).

KVM has had many such cases, where some weird behavior was never documented/justified,
and I really, really want to avoid committing the same sins that have caused me
so much pain :-)

> This change is VMX-specific, as SVM has no such fine-grained control
> register intercept control.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  arch/x86/kvm/kvm_cache_regs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
> index 36a8786db291..8ddb01191d6f 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -7,7 +7,8 @@
>  #define KVM_POSSIBLE_CR0_GUEST_BITS	(X86_CR0_TS | X86_CR0_WP)
>  #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
>  	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
> -	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE)
> +	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE \
> +	 | X86_CR4_CET)
>  
>  #define X86_CR0_PDPTR_BITS    (X86_CR0_CD | X86_CR0_NW | X86_CR0_PG)
>  #define X86_CR4_TLBFLUSH_BITS (X86_CR4_PGE | X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_SMEP)
> -- 
> 2.47.2
> 


