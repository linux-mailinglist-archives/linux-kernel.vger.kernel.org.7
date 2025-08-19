Return-Path: <linux-kernel+bounces-776339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61CB2CC29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197BA1C25408
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED41130C345;
	Tue, 19 Aug 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQJIFC3Y"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB7248868
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628518; cv=none; b=hHTZif8567z5gPOwrPmHxnpt8ilvOQ6uP7IXIAD0+sLQLYU1LUFMxI1VJQ2TN1aQqlzdAGqK5kQt8DGaJou/rwqa/yzGsQbVVhdaqcrFUWHedrf0Xzcnzo6kvH/jHkePTEqJrPoc21Emfa7xcRh4r2swRKlMFr66b/hSRgKieKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628518; c=relaxed/simple;
	bh=KVnr0lzPmK/K2M/LHiIQ0GPqlWAfQAn8shKwNcTjtvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2GlaLUgJNZeukd83reE5cZPITSlth4kTD42+G9hK6iGXDh0rtN12bElOM/QlI/yABNFpGyTrLtDvt3Cc+HhRPPHclIO81rXxJhlpdM0MWkUb/h8rOPBs+JydgrQrXiZy4itz7mYDii36GIQ0DatKBpQ7zVEcqcAZZwsAwmHdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQJIFC3Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471754bd26so4411669a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755628516; x=1756233316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEbYDiyMo+jmQU6bUD6f7jdcP1hHDx6nqnYsD8exClg=;
        b=RQJIFC3YyLbGLkkaC3dztanj9u0YuH5SyPV+P8vnm6Svf8o7vD1o+uVFfwCvN0PysJ
         UfGyjHqlWqg+TIWQ7s46D/M6brYCZvSTORP1Cm5nz2KRZb+6GF5XnbjwG/vp4GbD8JsD
         vijZOA+PxBZ0jpzqsHS+mPKhsDBSUgQhRBZl8h7c+w4aT4z9OCvsbRGSjlPStdVsJkEW
         JYzebQ6GVQ7RpZSVEIOnCwvQRajLRFcLw6G2GpXotKpH/ti9K2Y31PXKSFYLIhL7tR/a
         L4v/qVUu3tz+kyedv8nYde2NJTobg+py0LkGxEV2s2NFSXx8Pl0fQaLOrre/p9Xs9KtH
         xxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628516; x=1756233316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEbYDiyMo+jmQU6bUD6f7jdcP1hHDx6nqnYsD8exClg=;
        b=qdpHT1aMz8tbOGT8Q6AaNEqM1gH3RpYO4thx8h+k4X2TP0A8JXZI8zQAAQCEXBfHZC
         pM2Yiz/cc92lDwoZnw0so5qu2WvTjHtEpEbTQLqMHjk2qJI2uVpAKC2xGUBD+1MLhtaC
         jKYiWm9MSkbWTosAWj42gmSPFQqzTlaEKJUvjLyzXhhqbBSM5VkS1hsFAUjJt+C/5Exy
         8AhtvjiAZFtONol4BnJ5CVBVTJLYOTKtc24fS9LahWREGJvGlVi0Tj6vNWnmP+DTX2wS
         lKHVoMKfRwGocF5//CfNBiBwmM8XdKa00O0RLyQF1F77t91yX7FMOOSp6Ei1qhOiCUZT
         7HDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+AOCiFynGvVUn/6e43P5yRl6np7qj4xg6Wey6/R3zBvT5k2q2zOMpQ7o7JZWMZf0R/9gQKUSic1zDic0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnKrxms9SmLCWzSCUb/bFGlG80SfmHiwZajhccN77CbFDEadx
	nqgTiMTyxEjIUaX0b7YR0L+S9McKanqe/EEAvLwdq4xb2ZIzy+QSriTGYtAL2hfge8gAyCRxtFR
	o2O+lRg==
X-Google-Smtp-Source: AGHT+IEIZc7BQTsfGtwoiEFG1EvdjoTHV4xKueGpfzyTzTT7dNMl/pmXwZwmeeJhtkHoxpdej+jblh3TQMQ=
X-Received: from pjgg11.prod.google.com ([2002:a17:90b:57cb:b0:31f:f3:f8c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2587:b0:321:160f:3349
 with SMTP id 98e67ed59e1d1-324e13e2422mr270639a91.21.1755628516340; Tue, 19
 Aug 2025 11:35:16 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:35:15 -0700
In-Reply-To: <915d0ca8-05c5-42c1-90fe-b214904b23bc@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-16-chao.gao@intel.com>
 <aKShs0btGwLtYlVc@google.com> <915d0ca8-05c5-42c1-90fe-b214904b23bc@zytor.com>
Message-ID: <aKTD42Gma7qG3k9_@google.com>
Subject: Re: [PATCH v12 15/24] KVM: VMX: Emulate read and write to CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, rick.p.edgecombe@intel.com, weijiang.yang@intel.com, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Xin Li wrote:
> On 8/19/2025 9:09 AM, Sean Christopherson wrote:
> > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_INT_SSP_TAB:
> > > +		if (!guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK))
> > > +			return KVM_MSR_RET_UNSUPPORTED;
> > > +		if (is_noncanonical_msr_address(data, vcpu))
> > This emulation is wrong (in no small part because the architecture sucks).  From
> > the SDM:
> > 
> >    If the processor does not support Intel 64 architecture, these fields have only
> >    32 bits; bits 63:32 of the MSRs are reserved.
> > 
> >    On processors that support Intel 64 architecture this value cannot represent a
> >    non-canonical address.
> > 
> >    In protected mode, only 31:0 are loaded.
> > 
> > That means KVM needs to drop bits 63:32 if the vCPU doesn't have LM or if the vCPU
> > isn't in 64-bit mode.  The last one is especially frustrating, because software
> > can still get a 64-bit value into the MSRs while running in protected, e.g. by
> > switching to 64-bit mode, doing WRMSRs, then switching back to 32-bit mode.
> > 
> > But, there's probably no point in actually trying to correctly emulate/virtualize
> > the Protected Mode behavior, because the MSRs can be written via XRSTOR, and to
> > close that hole KVM would need to trap-and-emulate XRSTOR.  No thanks.
> > 
> > Unless someone has a better idea, I'm inclined to take an erratum for this, i.e.
> > just sweep it under the rug.
> 
> Since WRMSR (WRMSRNS) and XRSTORS are the two instructions that write to
> MSRs in CPL0, Why KVM doesn't use the XSS-exiting bitmap?

Intercepting XRSTORS would introduce (likely) unacceptable performance overhead
if a guest actually used CET in PM, I have zero desire to try and proxy/emulate
XRSTORS from guest memory in KVM, and CET already has big gaping virtualization
holes.

