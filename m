Return-Path: <linux-kernel+bounces-885136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91579C3210D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC6E18C1F09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23BF33373F;
	Tue,  4 Nov 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMcTzQ8d"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97317333445
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273866; cv=none; b=V1+wa3YsMCC664D6RaotpprlKhyQ8Gkx2L11C7OecLSuZBv8KcKzu1Ee7SCi3cV3FxloL/Fe/6LJ4faoRBhNbMdfcDo+N1pi2SD9qwviqXCVl9VAmUqOO9KhKsmiSNMIr/7CmRmrOpGFAupt+icQOPEmakePcOwiMhXBMqa4RRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273866; c=relaxed/simple;
	bh=A/yfd8jdGr+pFUR3XHiPL7+bb9IBKOGPpvRZdjY/3oU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZPFOxSnaAE/wT/V3jEVXveuCqn5JtOtde2KhdqSuNURbO3QnRZDqqkMu7WX+49dHmGGMfutB4sIUuh5aDYKtMYDfnBhTjiRQOg81fCTdQkm9n8wADgzzEuNmcOV4yyK2SMm9B3SMwCgo4vHnHDLdgGNr+vzNWCa0zAENm7iqzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qMcTzQ8d; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33d75897745so13994596a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762273864; x=1762878664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Sb6f6VhAgw9tNbhfts2Rrb10ZloGtd+JKJI3B0aR8=;
        b=qMcTzQ8dbQOOoGx89ivQdY/FRhF8jCiXIk82bAKmg1SOwv9RFV3iX3MJJ6jhlYGJyL
         k+Y6Mfur1Z8gaAB6Vcr95T+iXKrfZDxLFeRtL+XOU+LFnMawfFrJ7i0hAT7M9W6RXIXL
         bxPDtKNsskkBfltuEze49wEJGjiUbVsVv3Trq4dck92aLrOAIiblEGPWUoArn99K/9Mp
         TpNf4PC+skflc85HxG/EU1yM/6O95z5yy51cY6NUlzSe+bsZXJpaZn97wwdYICjI2qoY
         O1nelEq93b0npTKpFWp2FTBxp1pXTEM3pdXmRrLo/qNSi9ke8F2aEy7Xn9J691woklit
         741A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273864; x=1762878664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Sb6f6VhAgw9tNbhfts2Rrb10ZloGtd+JKJI3B0aR8=;
        b=rH3OVG/3tdfEhFG1fqYUmw5vjFLPNE+2ANYFHVsiTG1pQDBBERDYZQPvbxHCARcgu4
         AdKaF8qT89/6mOi/WxsfvGX6Ce7hjciBrJ/4l0XB2C1izCLW5fGwiQ04d46Ik682v4Gi
         Zptw6h1CEHwOfpTPoEGns2iSvdlScjtPAML8sOdmR+7MZ4IFsWqzfywXbzW79skUEEVi
         N9++IwKbN6Ka4oDHmmu8+VcPjTbRDhQF7Y+PlFGr/DrDwQwLZ8awzypLteLHcUEh/s/6
         pWuxu7pi2nWe/dxoqcLnv//jeTUh7mhD1PFFTqOXlRur8jKXEP8QskRVBdokA7ChbxIA
         U2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXycNIBW5lfI3ZVDA3QlK1YhU5xVrIvy/i8N+1IvR9xgqZJ2FKdiSjcJlw4+1wz+q0Y16qQEG59Ru6vsKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNp+wiH/1kFJNETySCkpGa/F9WbNMG5KPMOo85zFKCvEvzv8/b
	b3/m2QqOfVlEwv8u+dzI3JOdRP6Mj2PyTyqD/wBD1zD8VULaE1knAr1fOLaBQUs44NWdXH0iUux
	Ae//qaQ==
X-Google-Smtp-Source: AGHT+IEdQIr4M4XGWf0zRZoQtdQw+taTREO4d8GsRuDyXslQHePyubkG85oVwJP7U4BBQL/hLY8JoYEzu04=
X-Received: from pjbbt5.prod.google.com ([2002:a17:90a:f005:b0:340:bd8e:458f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17ca:b0:340:d569:d295
 with SMTP id 98e67ed59e1d1-340d569d470mr15274032a91.24.1762273863798; Tue, 04
 Nov 2025 08:31:03 -0800 (PST)
Date: Tue, 4 Nov 2025 08:31:02 -0800
In-Reply-To: <72503421-803c-4fa8-8e28-b0c793798c7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103234435.0850400B@davehans-spike.ostc.intel.com>
 <20251103234437.A0532420@davehans-spike.ostc.intel.com> <72503421-803c-4fa8-8e28-b0c793798c7c@intel.com>
Message-ID: <aQoqRqb-vN5GxT-x@google.com>
Subject: Re: [v2][PATCH 1/2] x86/virt/tdx: Remove __user annotation from
 kernel pointer
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 04, 2025, Xiaoyao Li wrote:
> On 11/4/2025 7:44 AM, Dave Hansen wrote:
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > Separate __user pointer variable declaration from kernel one.
> > 
> > There are two 'kvm_cpuid2' pointers involved here. There's an "input"
> > side: 'td_cpuid' which is a normal kernel pointer and an 'output'
> > side. The output here is userspace and there is an attempt at properly
> > annotating the variable with __user:
> > 
> > 	struct kvm_cpuid2 __user *output, *td_cpuid;
> > 
> > But, alas, this is wrong. The __user in the definition applies to both
> > 'output' and 'td_cpuid'. Sparse notices the address space mismatch and
> > will complain about it.
> > 
> > Fix it up by completely separating the two definitions so that it is
> > obviously correct without even having to know what the C syntax rules
> > even are.
> > 
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Fixes: 488808e682e7 ("KVM: x86: Introduce KVM_TDX_GET_CPUID")
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> the prefix of the shortlog is still "x86/virt/tdx". I think Sean will change
> it to "KVM: TDX:", if it gets routed through KVM tree.

Ya, I'll fixup when applying.

