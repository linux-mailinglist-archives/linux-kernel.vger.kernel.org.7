Return-Path: <linux-kernel+bounces-896250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED6C4FF96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23074189B687
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48A2D249E;
	Tue, 11 Nov 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5lGd+Nd"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88712221DAC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900263; cv=none; b=FoSOG8q5PUOPAOlHZlB7klCas1Dsf/lArGkPWQzKGt/lNVK0m4Yf44QxyvNLOFGuN53+Y/v8RSJEJ5LLOdvvl8e5mvAahKM/SUjZ/FXc8dwfv0VLM82iMNcysa18B51agZa302yKEq3EPPXVsT82y6vS6tppV3dEnU1fvl2uLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900263; c=relaxed/simple;
	bh=nBOmB4ONg8kALGVCz8jrfhPIlcVdJM+IcFGCif8wqF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5mlwbSWoUHziXyOFcMO01orTkTtYztee5qOb+gOfvmzliIXmA+zNwDjPv4zQGbqo3wTSi8d70hAmCnmWifSqYE+I0p0NTKj8dmJPaq3kTKENZudtCpxyZT8ygedEZtkhxKhvO6BKmcz4IinD5tRQ2yLnN/Q6sZ4nBC/EpQSve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5lGd+Nd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so363830b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762900260; x=1763505060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8RYt755g+phSGczRrtxqFHw21U9A5DwYjvKLhqMbA=;
        b=b5lGd+NdRKiKKKuMQzLLTIJ5dpTIPVw8mAULHAFjGv4YmTQbBuHAy1XUaZoUbPAAIq
         o2iOvA4kyFciRA+WEsMnVwCoo2ZMm2aLzFXBCeF/J015lNuDt2YaVexyKMcJ+9wpcr6K
         U8lBuCPqb68Jm5Rk5D7v+V651LjhUyDM6YLw7xPo+KcpBabWDvojuI7FylGCx584v3fJ
         8SIbVC9vOxkS9zQNzip5dBTe+TGvwtWhT70WcXbFmpvT+o+TplsdyIL8eUPSuKeaO6nj
         IZWOxkQO8sxBSFYQxa2hTe4oCdWfMd1SLV9JwrjPUKcMWIfbP3VwgHfuYxd7/521UMnx
         +4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762900260; x=1763505060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+O8RYt755g+phSGczRrtxqFHw21U9A5DwYjvKLhqMbA=;
        b=aeiKWDr7GrHkt7eC3D4hGa9NcL9bWwG9bbDVfkxxbra/szGo5+SXE5BRotM/i45jKJ
         UztRc2kFc2rKNOpEUwE8Yoj1mWgM1S9Fk4AcK4uCBheawAJuNBEFDRNEhGvdIlwaum5S
         v2RV+58A6m9oafXfQM65TfeghZTRAT2RuT3KFuWzVtVFrWEqFudMqO4a8NTbmWmhcJok
         AF6/pA9xzvWkCJa7LglZ5OuNj7SAWoEAPyF7aIIHut+G5OPZ+kJYn+20hl5z4N1dpKsD
         qY/dEMTcsnHql6hUpIWMKehb16jKP/UJhZkljdrtxZ6786tO+hXNs2Z3V3WrCxGiCH5i
         1tjw==
X-Forwarded-Encrypted: i=1; AJvYcCXdI18avwUmuMBMPQ1ulMF3QA/ky0MHdR1NJbVDYF/68Z30eqXcQ8FEctP3TVe8X+pX+74F+/IR1sX/Ono=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYwvPHygK+J+gIe/gc1giNexyxnJGzXeobyOe7gSjfqkYqG1L
	X+45jsI0jjZxRSKwS2Pus1eUW/M8UCoQQu3ITFcBya3Wy/i92y/nq4X5zGBL4MvVXzM2AQu8YUu
	Q8xXO2A==
X-Google-Smtp-Source: AGHT+IHtFVXr/uGxNz1xOC+oARtDBh6AgJQTtR8J1TlbgEsvQHGkSIKZOzneMX7GY0qygAOFGBUFmCHpdCc=
X-Received: from pfbea28.prod.google.com ([2002:a05:6a00:4c1c:b0:77f:2e96:5d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0f:b0:7ab:a41:2874
 with SMTP id d2e1a72fcca58-7b7a2d91dcdmr700837b3a.10.1762900259787; Tue, 11
 Nov 2025 14:30:59 -0800 (PST)
Date: Tue, 11 Nov 2025 14:30:58 -0800
In-Reply-To: <6ving6sg3ywr23epd3fmorzhovdom5uaty4ae4itit2amxafql@iui7as55sb55>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-3-yosry.ahmed@linux.dev> <aktjuidgjmdqdlc42mmy4hby5zc2e5at7lgrmkfxavlzusveus@ai7h3sk6j37b>
 <6ving6sg3ywr23epd3fmorzhovdom5uaty4ae4itit2amxafql@iui7as55sb55>
Message-ID: <aRO5ItX_--ZDfnfM@google.com>
Subject: Re: [PATCH 2/6] KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 11, 2025, Yosry Ahmed wrote:
> On Tue, Nov 11, 2025 at 03:11:37AM +0000, Yosry Ahmed wrote:
> > On Sat, Nov 08, 2025 at 12:45:20AM +0000, Yosry Ahmed wrote:
> > > svm_update_lbrv() is called when MSR_IA32_DEBUGCTLMSR is updated, and on
> > > nested transitions where LBRV is used. It checks whether LBRV enablement
> > > needs to be changed in the current VMCB, and if it does, it also
> > > recalculate intercepts to LBR MSRs.
> > > 
> > > However, there are cases where intercepts need to be updated even when
> > > LBRV enablement doesn't. Example scenario:
> > > - L1 has MSR_IA32_DEBUGCTLMSR cleared.
> > > - L1 runs L2 without LBR_CTL_ENABLE (no LBRV).
> > > - L2 sets DEBUGCTLMSR_LBR in MSR_IA32_DEBUGCTLMSR, svm_update_lbrv()
> > >   sets LBR_CTL_ENABLE in VMCB02 and disables intercepts to LBR MSRs.
> > > - L2 exits to L1, svm_update_lbrv() is not called on this transition.
> > > - L1 clears MSR_IA32_DEBUGCTLMSR, svm_update_lbrv() finds that
> > >   LBR_CTL_ENABLE is already cleared in VMCB01 and does nothing.
> > > - Intercepts remain disabled, L1 reads to LBR MSRs read the host MSRs.
> > > 
> > > Fix it by always recalculating intercepts in svm_update_lbrv().
> > 
> > This actually breaks hyperv_svm_test, because svm_update_lbrv() is
> > called on every nested transition, calling
> > svm_recalc_lbr_msr_intercepts() -> svm_set_intercept_for_msr() and
> > setting svm->nested.force_msr_bitmap_recalc to true.
> > 
> > This breaks the hyperv optimization in nested_svm_vmrun_msrpm() AFAICT.
> > 
> > I think there are two ways to fix this:
> > - Add another bool to svm->nested to track LBR intercepts, and only call
> >   svm_set_intercept_for_msr() if the intercepts need to be updated.
> > 
> > - Update svm_set_intercept_for_msr() itself to do nothing if the
> >   intercepts do not need to be changed, which is more clutter but
> >   applies to other callers as well so could shave cycles elsewhere (see
> >   below).
> > 
> > Sean, Paolo, any preferences?
> > 
> > Here's what updating svm_set_intercept_for_msr() looks like:

I am *very* strongly opposed to modifying svm_set_intercept_for_msr() to deal
with whatever mess LBRs has created.  Whatever the problem is (I haven't read
through all of this yet), it needs to be fixed in the LBR code, not in
svm_set_intercept_for_msr().

Recalculating MSR intercepts is supposed to done only as needed, I don't want to
encourage lazy code that works by optimizing paths that should be rare.

