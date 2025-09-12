Return-Path: <linux-kernel+bounces-814792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950DB558D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE599179FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C4283FF0;
	Fri, 12 Sep 2025 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Joz2Dj7x"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138F4C81
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714654; cv=none; b=iKBw6epwI1/+gHgSnyIKxrRWIKYhh2aJALN0ZaJSsdlhu0y3zi58TQs7fMN+GcAW1+tzMeCrQsR7RrRpvMlo+BPoghHZHpp8sFMIeuQmu72pv3L9NX1O0byLbA17JsAkTJGJ5bqU2dmWHh0te6HUpz6Sjf4u4IRb3g20bX45eXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714654; c=relaxed/simple;
	bh=1k4h6sSYZLPEb1T1GQD57kAM3wQMLuiOfTd5z9kKNAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MhCUueGFzH5i/XC9pPDmHVMIpwFP0rtKITEUVkrD5Ji68iG4WdHckWZCRXa+vFpk9SROA0FEoCnKfGha6NfEfjEpVZKlVR+SxS4/S2tXh/Q+6YN6bAO4HJR5uAn1XgPDvhRTAFlpIN/Lf7w6uN97ET7RhLWnijCuaRi4Yqd9pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Joz2Dj7x; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329e0a8337bso3431596a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757714651; x=1758319451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOnXqCTneQzY1nlQxY8LD3yfTLcbdMGUV0lpGUO6Hn4=;
        b=Joz2Dj7xuWOLFb12MFvfYFLVP0Qd6z8LnQRFxfLlo+/nvld+oMDlK5itnJHTgH6EM3
         C4b/OPcJHZAXQmVe9xQ8KGjdOl3CgDN+//ZNXpTzJaiCx7mLNdVbEMGHoxzdUQ8ErlGw
         VzN2Jt9SOSJDAy/r1LVK/QRYObHS0zEqb4H2W8f2kLsjO0Q8u1gGLpE+mOaayHI+CSRg
         mGkRB9/J/qjr1huOeh9Z96Myn2wZPw1m13zu0XzLXRfeKoltHEgzrNASdgIKR0/OGEU2
         5jTv+No08a1ZWsZ9mct0xx3VMTV9cmgxQJ5TZtrTscMctCQLUOEtny6+hgLh8C0/jnlY
         MZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757714651; x=1758319451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOnXqCTneQzY1nlQxY8LD3yfTLcbdMGUV0lpGUO6Hn4=;
        b=bmiAYefMGyfames0uioSe9YHsiONyvmY59nAB1rR7KG6LErroHKQQkp+76cnsMgAX+
         ZztckVyDpcmh20xldO43YwVsIdtwu62gjG+41tzyBmxwJc9/EBZHgddYcrrUuIVkUFWx
         wwcCn2NfuvvBmND2+/+xq7HQmZ8Xk9kkGJdYt64M4fEmV/c5aSNR7MCEoGtJCvryx0IL
         7ungk+IVYkZA0vRTcM+WhW2ABVOTV43gdaoimsFOyRStZW6LaoJILlJL3/dQTcXQIVN0
         tm2EVHtEjA6an96+gMGBeywP6dUKcFj5MBHQQOB3nMELFsehQMURXvqmP4PVJRJoUGf+
         MCUg==
X-Forwarded-Encrypted: i=1; AJvYcCVsIwwnvjYzLBFlW5RCNSBmwwQ5yk4ZuZppS3jKEFFKK008Ga0w/aZdmiNE3dl1yXiz59cxDzTs456vunE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0RmbubqTm0c5UzOdSk0DMzEpQ5mWjQ1yIYPTxck1BPnCxP5D2
	R10zhNtWV6VEc/kDFG8gXVVPnSLrrzEf7154Ck0VdglYKRtWZeuJ4fHiuY7jnqkOykr1yVOB7Fo
	6GA/Tcw==
X-Google-Smtp-Source: AGHT+IHaZW4YTkAwLQ+mFC02kVapk34S7ndyYyK/6P4OrjB6MmeThbeRPbd4boVT3o71WQ0UAr704qqNMzw=
X-Received: from pjbqd7.prod.google.com ([2002:a17:90b:3cc7:b0:32b:9872:3300])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2c7:b0:32d:dd0e:d319
 with SMTP id 98e67ed59e1d1-32de4fb3bf8mr4359183a91.32.1757714651232; Fri, 12
 Sep 2025 15:04:11 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:04:09 -0700
In-Reply-To: <20250909093953.202028-15-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-15-chao.gao@intel.com>
Message-ID: <aMSY2e2vNe1D-hHj@google.com>
Subject: Re: [PATCH v14 14/22] KVM: VMX: Set host constant supervisor states
 to VMCS fields
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, john.allen@amd.com, 
	mingo@kernel.org, mingo@redhat.com, minipli@grsecurity.net, 
	mlevitsk@redhat.com, namhyung@kernel.org, pbonzini@redhat.com, 
	prsampat@amd.com, rick.p.edgecombe@intel.com, shuah@kernel.org, 
	tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, xin@zytor.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Chao Gao wrote:
>  void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79861b7ad44d..d67aef261638 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9890,6 +9890,18 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  		return -EIO;
>  	}
>  
> +	if (boot_cpu_has(X86_FEATURE_SHSTK)) {

This needs to check for "|| IBT"

> +		rdmsrq(MSR_IA32_S_CET, kvm_host.s_cet);
> +		/*
> +		 * Linux doesn't yet support supervisor shadow stacks (SSS), so
> +		 * KVM doesn't save/restore the associated MSRs, i.e. KVM may
> +		 * clobber the host values.  Yell and refuse to load if SSS is
> +		 * unexpectedly enabled, e.g. to avoid crashing the host.
> +		 */
> +		if (WARN_ON_ONCE(kvm_host.s_cet & CET_SHSTK_EN))
> +			return -EIO;
> +	}

