Return-Path: <linux-kernel+bounces-819491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E19B5A194
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A630F527232
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF42DFA4A;
	Tue, 16 Sep 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAzFDOVG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCF238178
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051888; cv=none; b=uWi6Npf3oclA+R0i171XEx+wTYBl5MC11BP5Ydi/vnL6zwt55B487gTrbwxw99yVwt7pKG9Y8pz7S8jCpV7WLLE/4zErOzjJZV6WlxhbbIdR+3sG5Quq/Xnaf8X6YsMNO/GrjcOxCrpFKHD7NvmFXCy2lhrlkRAHRxnpPTNYExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051888; c=relaxed/simple;
	bh=Bj5UJz56fZYcozZfKjnd0X0pC7phusQmPamMJPmrBCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lzZNwM+l99GcIU5U9yjXPIxcjmi9ptyvOs9ds4W3Rn/dh35I97ip6FpsmT4h7Ztw0A61uAQzTT7jwzGgfBXjFzpiNXNAAHixmObfiAyR00ERlfem/OD/0We/M4pOLYyk/dTISvsnEZUQ5tBqju1eD5rHH/agqwvxTGByrfesGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAzFDOVG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32db3d5f20aso5011872a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758051886; x=1758656686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=blJ1+eWWzlJEt2GGVDQEpISmZA9TNH9W/hvuPdFhLSk=;
        b=vAzFDOVGNO3CDwgF4Co1OPkuXz3ExM75Y7slKHIRHgi4TBGZzAG7Ev2Uf1h3w6FGsY
         B1ihqw7K+zraKVpFvpC976E5le28F7nYpQtrqyE63kkl+Ms8ZLNP7Taz6mHa1lU1Omqh
         YBUIQMfNh1PPXmqDWGf2+vFuLmcVXFSwhFwpWe/xFDu2/UvF2i3wD3scOAZ3Y+KAqbnL
         lAaM8/rK1PE7zzL09CMJgL3g1kX5n8bg2IbLjNrSQ0JT4rhALd3daI/XIYAYFXHy3EMR
         fNx1800puSQbBjSwKVkS62qnuicQhSE10y4DTseIzhH2tu+jLpYqUHJR7b/qJ1rLgQ1U
         /Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758051886; x=1758656686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blJ1+eWWzlJEt2GGVDQEpISmZA9TNH9W/hvuPdFhLSk=;
        b=iPByrNlpFySl5HNXK+a8GtpSO15D6NvZyNCuloGyIjrBpZishdzMQ9GAYlolxFOnS7
         qr5uhNHfoAjSVmPZRJtVE85T8tBIQUbtwiOKcKWnONricluin1QXV1zhwfHcI+Wk3yK4
         5A2FHTG5CAw9e1eRAMQ263lq59h2mbx1D9Nb6Mf7MhRuS35z8DXeuD6UafXxV4gL9XKi
         lBULkl88ws40oKlVIql8iiHuAkNwOzMf7yOtxeoAvOtqTuSleEIpPeaMmnpIFgzBDApI
         hC9JECy914HdBOIi+gW8bYAN1v/w6BilNh5KMcWEfHTzGQkVW7Jt1jlasAod2HOHbjc0
         1i0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBOW6Xe+Hcfrmuxd93gnDF6YjGiamdlxQFZA2U9YbsN4k+KI7S1C9Fr94O1ALzUoRIbLlyCTYGGTFnpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/t9VazywiYJPKH1isP2tHsHl4aZ+J4P1DadQutUkiuLp0Byp
	k9DwLqzHuffr6YesN5AOIvAJTlvUs/fUxxKwqJgHDmE8JEV6hlIWEQtqk33PRV15Q+z79IFwTM5
	YyEibPQ==
X-Google-Smtp-Source: AGHT+IEPKdyex7jz8in5XFqN4DYJcVLlKPHGMJXbamUaBHBfxWZpWsWJt7RliMxdJnu3mE2/a/pWQBJaGPY=
X-Received: from pjv14.prod.google.com ([2002:a17:90b:564e:b0:32d:69b3:b7b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3904:b0:32e:7123:7076
 with SMTP id 98e67ed59e1d1-32e712371d6mr9405723a91.11.1758051886069; Tue, 16
 Sep 2025 12:44:46 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:44:44 -0700
In-Reply-To: <797c84fe-aec7-3e29-a581-d6d1a3878aaa@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908202034.98854-1-john.allen@amd.com> <20250908202034.98854-3-john.allen@amd.com>
 <797c84fe-aec7-3e29-a581-d6d1a3878aaa@amd.com>
Message-ID: <aMm-LMjCeXguOhay@google.com>
Subject: Re: [PATCH v2 2/2] x86/sev-es: Include XSS value in GHCB CPUID request
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, pbonzini@redhat.com, dave.hansen@intel.com, 
	rick.p.edgecombe@intel.com, mlevitsk@redhat.com, weijiang.yang@intel.com, 
	chao.gao@intel.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	mingo@redhat.com, tglx@linutronix.de
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Tom Lendacky wrote:
> On 9/8/25 15:20, John Allen wrote:
> > When a guest issues a cpuid instruction for Fn0000000D_{x00,x01}, the
> > hypervisor will be intercepting the CPUID instruction and will need to access
> > the guest XSS value. For SEV-ES, the XSS value is encrypted and needs to be
> > included in the GHCB to be visible to the hypervisor.
> > 
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: John Allen <john.allen@amd.com>
> > ---
> >  arch/x86/coco/sev/vc-shared.c | 11 +++++++++++
> >  arch/x86/include/asm/svm.h    |  1 +
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
> > index 2c0ab0fdc060..079fffdb12c0 100644
> > --- a/arch/x86/coco/sev/vc-shared.c
> > +++ b/arch/x86/coco/sev/vc-shared.c
> > @@ -1,5 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> > +#ifndef __BOOT_COMPRESSED
> > +#define has_cpuflag(f)                  boot_cpu_has(f)
> > +#endif
> > +
> >  static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
> >  					    unsigned long exit_code)
> >  {
> > @@ -452,6 +456,13 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
> >  		/* xgetbv will cause #GP - use reset value for xcr0 */
> >  		ghcb_set_xcr0(ghcb, 1);
> >  
> > +	if (has_cpuflag(X86_FEATURE_SHSTK) && regs->ax == 0xd && regs->cx <= 1) {

Only CPUID.0xD.1 consumes XSS.  CPUID.0xD.0 only consumes XCR0.  I.e. this could
be "&& regs->cx == 1".

> Just a nit, but I wonder if we should be generic here and just do
> has_cpuflag(X86_FEATURE_XSAVES) since that should be set if shadow stack
> is enabled, right? And when X86_FEATURE_XSAVES is set, we don't
> intercept XSS access (see sev_es_recalc_msr_intercepts()).

On the other hand, by exposing XSS to the host only on CPUID #VCs, you've already
"optimized" this code based on presumed usage of XSS by the hypervisor.

