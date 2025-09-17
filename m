Return-Path: <linux-kernel+bounces-820714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80674B7E7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C60E188A126
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58930328996;
	Wed, 17 Sep 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqPcO/cH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AA2D480D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113275; cv=none; b=Mai0lU4FM9JJHu5N7Skh0vaomYi5HEnLpGoRHgeSy1U+zSDI1iLeqNCYt3zKxV9VJYLlPKp1dz1c8CPs6dzoLh/x1MjhSW9IeujDZW+dasFY/yn/qdEmDW4LdCgZhZmmH9WNdrbB68ZsiIaRUnYHtmXSr/vaAyMT8xy4EXpWj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113275; c=relaxed/simple;
	bh=RQINUxGsJC4fFGW9Pga0A1D4M8TL6sYnSYVhtigYag8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bEMEiCGuUxhe69ZEFoRCY1ckV9HYwoQjVvo0XjVUcdXnf6LDf9ynlsyNHeLSzxMm2P6DYzDsfnkWcntDuclpyIkz3G+zEPEKJ+ixCLp2Y7U2Ks72TE2cdWBXroVwv+7S2L2o7VqsX/hT6RrRDCXjVTfpkeBrsEODSHkP/DLw54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqPcO/cH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2507ae2fa99so122539635ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758113273; x=1758718073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhI+ZLb55QOi22SZbshrFRw3Xyx04NRrqgLS645MTmk=;
        b=eqPcO/cHXAGggYBHwZa3SOXFPA7g/R2o/g31T02no00DMewtGvJiN+jPWEJVqq2eTH
         d7iwScULz59ascoz3pmUqiBPuZZ4LIbbL2VrTMqlgzJ2hg5ILkxrAgtxuJAvArx2Uf8f
         EVlUGi/ZTI6GQVUs5W+94hwZwpKI4zAMaVJE83HJXZ8cfa/qaBFYdpepToGkHuKo0v7a
         NlgD2rXSuYCP9nqTbCi9lIFSq1wvPmrdolHfaPPmeeiFel0psZRocWYDktshAPZNn4ff
         RV5NYtRygn6X3fsK9x50fpwxAyovzfvVSRCZ5lR+8Fad9haQBAifPe1XokHElewbv7CP
         YqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113273; x=1758718073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhI+ZLb55QOi22SZbshrFRw3Xyx04NRrqgLS645MTmk=;
        b=GgOmn5z2onphXeX35T7pwc8RGny0ViMtiSVhDF8h3BrVUctjPBHbBxcjkAc2RXN2rY
         ertU6crkrKA6rWYjQf+UZTHGnwYFOlMuEu37/Tm3+GyNEa2JqAPfaF1e0N9jJGE7ZpbG
         M8vNjnAxF8geibNIC+Kv/pSWliTrBm6n9dBbO0Gfe9/MZrPkbuYgM2/KrhL0bgLsZBMQ
         pHIpCF+fThRSuVtc6fA8l7dV07EKkdAkXsj7+AzUvhQ6fUFB0ODFpJ1XmEPxCvpp9RzE
         cx7adVKNYQl2sKvF3H/yXX6/TEYpasMnBMa8OD9bUhPkcvH/mrAWww1Iy4xwPdXFovjG
         V8gw==
X-Forwarded-Encrypted: i=1; AJvYcCXs2BNVQyw4NYfJ2my88kwJAyk/6P9NeK4Gw6NI7OBxCL3ktXdeZ6MGjSwsN8lDN1rk2PzqN+TDhq5rD/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOv4zVa0ZAf5FLzDjP6H+whTQcGw5FABK7IIIyOE/ynl4j2mN7
	e2srNlPR7s1dZ4Fh5QMjsjaCKDGmb/eo1GA1Qn3dFL0PBg/9IZH+udpJeRPYQXIdaskSlOzV63B
	1XTwTcA==
X-Google-Smtp-Source: AGHT+IGZMZLBQ8oPAPbG5AROKZBqoW5d8+AhwGK8pLbbX+9Eioaxg8jtAuHu8IyLmAYtzzOu/Q9PRNGhYEc=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:32d:df7e:66c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b03:b0:251:3d1c:81f4
 with SMTP id d9443c01a7336-26813cf3339mr29737275ad.54.1758113267744; Wed, 17
 Sep 2025 05:47:47 -0700 (PDT)
Date: Wed, 17 Sep 2025 05:47:45 -0700
In-Reply-To: <c4b9d87b-fddc-420b-ac86-7da48a42610f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-10-seanjc@google.com>
 <c4b9d87b-fddc-420b-ac86-7da48a42610f@linux.intel.com>
Message-ID: <aMqt46hxeKxCxkmq@google.com>
Subject: Re: [PATCH v15 09/41] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 16, 2025, Binbin Wu wrote:
> > +/*
> > + * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
> 
> 
> Lock is unconditional and reload is conditional.
> "and/or" seems not accurate?

Agreed.  This?

/*
 * Lock andr (re)load guest FPU and access xstate MSRs. For accesses initiated
 * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
 * guest FPU should have been loaded already.
 */

> 
> > + * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
> > + * guest FPU should have been loaded already.
> > + */
> > +static __always_inline void kvm_access_xstate_msr(struct kvm_vcpu *vcpu,
> > +						  struct msr_data *msr_info,
> > +						  int access)
> > +{
> > +	BUILD_BUG_ON(access != MSR_TYPE_R && access != MSR_TYPE_W);
> > +
> > +	KVM_BUG_ON(!is_xstate_managed_msr(vcpu, msr_info->index), vcpu->kvm);
> > +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> > +
> > +	kvm_fpu_get();
> > +	if (access == MSR_TYPE_R)
> > +		rdmsrq(msr_info->index, msr_info->data);
> > +	else
> > +		wrmsrq(msr_info->index, msr_info->data);
> > +	kvm_fpu_put();
> > +}
> > +
> > +static __maybe_unused void kvm_set_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > +{
> > +	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_W);
> > +}
> > +
> > +static __maybe_unused void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > +{
> > +	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
> > +}
> > +
> >   int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >   {
> >   	u32 msr = msr_info->index;
> > @@ -4551,11 +4614,25 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
> >   		    int (*do_msr)(struct kvm_vcpu *vcpu,
> >   				  unsigned index, u64 *data))
> >   {
> > +	bool fpu_loaded = false;
> >   	int i;
> > -	for (i = 0; i < msrs->nmsrs; ++i)
> > +	for (i = 0; i < msrs->nmsrs; ++i) {
> > +		/*
> > +		 * If userspace is accessing one or more XSTATE-managed MSRs,
> > +		 * temporarily load the guest's FPU state so that the guest's
> > +		 * MSR value(s) is resident in hardware, i.e. so that KVM can
> 
> Using "i.e." and "so that" together feels repetitive.[...]

		/*
		 * If userspace is accessing one or more XSTATE-managed MSRs,
		 * temporarily load the guest's FPU state so that the guest's
		 * MSR value(s) is resident in hardware and thus can be accessed
		 * via RDMSR/WRMSR.
		 */

