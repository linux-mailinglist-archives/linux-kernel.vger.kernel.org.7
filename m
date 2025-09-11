Return-Path: <linux-kernel+bounces-812822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC6B53D21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68B9A03A86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751729E0F4;
	Thu, 11 Sep 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCYKeIt5"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6629ACD8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622256; cv=none; b=PRPCrxIKSiq/NpSprwJ9DcLg/rXnMz3SfKRnNH+L4zt9Y5hYqU4S8D0dBklsAWhWlo3vpUW7kxi3uwdch9M2mrt+vE9UkTCZZIapp0eOQa3tNB2j3AfCGKdCZAJpVhmHB+BfaDDAK/5RswCyOaxTmFBM6svEIhCoI+012+7PDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622256; c=relaxed/simple;
	bh=VEqYDFK+4M4ioHWAgCDYHHwNnsvkDHBWj5Gw99+OFX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHu+4yfqJ3/JsvOFPXiVaO1rkTwcQPo9ISqGXVdUAnrfDk2MPKFfjsKW7kDu8XNhu3qPJ1xL7EIW5W2B5nxCCndDP+eeIISXfXAdg7HUGAhtcNb5ulAf3Y5eRT2v/PvVf3AhWmk4VnX7C70LsPnSaz/I63BscoEZEwZhBdgIWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCYKeIt5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so1541519a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757622254; x=1758227054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ImUP08qXEYZd8wdDPMleb0gaoUp5hn7TmovTJESoHr0=;
        b=ZCYKeIt50kMum8S52+0bJOmt0gObE2iJC04L2dxDnL/ngc/8CQbYJ1fOHsFekRS+Z6
         o40Bf0cBVE7GthOHJ1N2B3EOX4Eui4AdlQ8Z7m9xP5bPym2eESMpAepo8AYtqqM9wLWx
         RrtU/W+7Uo1dQUUMd8ecquT96cD3eyephOW4cDYXq4EW5wLDNnynNtR8yAJH90sq1DUD
         gY4qM4FarkmrWats+N6QcWsmIk6XXBwd4BEcNSawQ2XXL7dxzvm/lBVWNxzw6bBapF1s
         62oUbKLG3aa8fPYdvKKsJZv7lTS5RaCAvbaLAnRFnHV7yUjqtXv6pNRYSYl5A4Pi74lc
         a3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622254; x=1758227054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImUP08qXEYZd8wdDPMleb0gaoUp5hn7TmovTJESoHr0=;
        b=jJV1Wc3prDpH4euiab6EuK5NSmSY5wo5UTLTA5KRadR/jRhNmg658/NZEPdmq9NRrQ
         smITnx6haR0pdUfdJMPm5k1iqbBRvCpmSIiSNr3UAkMQ1UOvdRDS5GiBRrXYxfgprDdj
         7f+j9jeIyLE1vMwXceYOxN5Yav1SdhPb6A1XUbO96d8czhVQ1YO0NtTUczYucX3U4o9p
         UzOhBGf9czAKhSbKHbKTWTQDmbbuSztPS/77A1jYgpxIX2s3SZLWo151rTVb8VDyYxRI
         xfodrqVleoM283tDKCyVEE/maEnyXRWBVfKtV9H2aZ3pH7HUnOuf3rX98ADJFn3kl0Xl
         t0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVvqRoan/rQ2UbXIobjJbE83hLl4aHL3aOZKjaGLzo2nBfosHtnwlcjQItIWUtz/hpbpD0uXcdtlGYGyZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpLhcxZW7LLJnMOT7sIQtOrwVC1ocaCPKYNcYmMOHgjPzzqkq
	CuNkmwGjg86ek7Ce1apLP3Wnuzdi8qAPNRCSOsHytD/up8JP/ChFs9HwOX0OaHv4LIEXbL+Cu2l
	TwYkYmg==
X-Google-Smtp-Source: AGHT+IE/cgMS70+jzVlIiX1LZGwYOhHwrMDurlykExzOq6pqvmYbqU/lRYRS4UjNgyCW43iedFpnavIfWd8=
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:b54:ac4f:20f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d89:b0:252:2bfe:b668
 with SMTP id adf61e73a8af0-2602a49da54mr604180637.4.1757622254481; Thu, 11
 Sep 2025 13:24:14 -0700 (PDT)
Date: Thu, 11 Sep 2025 13:24:13 -0700
In-Reply-To: <aMKQO8+XwWF5UOSR@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-12-chao.gao@intel.com>
 <bd2999b5-f2fc-4d86-a5c8-0d1af4d51bc0@intel.com> <aMKQO8+XwWF5UOSR@intel.com>
Message-ID: <aMMv7bAMBWu-0ZhQ@google.com>
Subject: Re: [PATCH v14 11/22] KVM: VMX: Emulate read and write to CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	john.allen@amd.com, mingo@kernel.org, mingo@redhat.com, 
	minipli@grsecurity.net, mlevitsk@redhat.com, namhyung@kernel.org, 
	pbonzini@redhat.com, prsampat@amd.com, rick.p.edgecombe@intel.com, 
	shuah@kernel.org, tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 11, 2025, Chao Gao wrote:
> On Thu, Sep 11, 2025 at 04:05:23PM +0800, Xiaoyao Li wrote:
> >On 9/9/2025 5:39 PM, Chao Gao wrote:
> >> From: Yang Weijiang <weijiang.yang@intel.com>
> >> 
> >> Add emulation interface for CET MSR access. The emulation code is split
> >> into common part and vendor specific part. The former does common checks
> >> for MSRs, e.g., accessibility, data validity etc., then passes operation
> >> to either XSAVE-managed MSRs via the helpers or CET VMCS fields.
> >
> >I planed to continue the review after Sean posts v15 as he promised.
> >But I want to raise my question regarding it sooner so I just ask it on v14.
> >
> >Do we expect to put the accessibility and data validity check always in
> >__kvm_{s,g}_msr(), when the handling cannot be put in kvm_{g,s}et_common()
> >only? i.e., there will be 3 case:
> 
> For checks that are shared between VMX/SVM, I think yes and there is no other
> sensible choice to me; other options just cause code duplication.

+1.  Put as much emulation as possible into x86.c, e.g. validity checks, state
tracking, etc.  Ideally, the only thing in vendor code is vendor specific, e.g.
checks that are unique such as CR4.VMXE interactions, and propagation to/from
the VMCS/VMCB.  See also https://lore.kernel.org/all/aLDm9YID-r5WWcD9@google.com.

> For checks that are not common, we have to put them into vendor code.
> 
> >
> >- All the handling in kvm_{g,s}et_common(), when the MSR emulation is common
> >to vmx and svm.
> >
> >- generic accessibility and data validity check in __kvm_{g,s}et_msr() and
> >vendor specific handling in {vmx,svm}_{g,s}et_msr()
> >
> >- generic accessibility and data validity check in __kvm_{g,s}et_msr() ,
> >vendor specific handling in {vmx,svm}_{g,s}et_msr() and other generic
> >handling in kvm_{g,s}et_common()

