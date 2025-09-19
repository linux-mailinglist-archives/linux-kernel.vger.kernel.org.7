Return-Path: <linux-kernel+bounces-824354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EAB88C12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DBF160F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1502D23BD;
	Fri, 19 Sep 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLeRMk+C"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFE381BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276381; cv=none; b=kq2Mf1PY4e+0MkG2n0xOhqvgInrA5g2ZLms6iOjYyBErPjrvlP1MP04hbOOeJLxfsTXUVmUS/j62OGuiufqFvpHLlvYKhXKs1M2BMSEuO74Ipb3gh8/5uL1B1lFk4Nz+G0MZ14g/MfkpuxmJhLPAqzD1Xtg1r6/0d0ctGhwtzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276381; c=relaxed/simple;
	bh=pGotopC/5Jk7V4SNfZ9mLDWTas1twe3tpwHA4hMtewU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8EtvKv+muwWBu3Z2IPYMd4IBR33BTfgKFl8lr3EhAIaqWAIlJF9nouPpBjaKQcdaV2sXtcXA7ubsUAWxeOH1/qwmxgPlstqT6T6Vw9atiINvYm+9cKYeiFM9Gzzs+4Uplg5K3DneXUSt5A4TeInTHaCAbeerIwaE2uB3CBGOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLeRMk+C; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so13136015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758276378; x=1758881178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAZLPCCH0EgC7m1vhKAbHLebwwq6tBL7BsLJTj4U7Qk=;
        b=mLeRMk+CY4uKmoDS49KXtA/GRjtCThihm/hDb8asCQEj4UZ+oPhrW3vTm6VcJQGz4C
         z2z1/2Gb3HY5uDjN6CpPfumrdEqNTTtcl1RSmEo1D9uL4oUttkeByz76xZtg37CA8Tpk
         KqJupXbifG2ppA4yIykeyn/VmPgRmpJSB0jZ8eEU9ovTEf6Pg7rJ7IdsAPedZ+/zT3fl
         8AuZVL0BmF2rvcjORHXHjCaMH0Th0SRKGHg4g4Tjs1AaXXHfPovpKIFEq4T2wyrrrHxm
         lImmJCd27jsMk205AdVW4sn5mHfWm/VY+xdx/Z6xYQmWn3JrNGxasS059CKSaZ3IwbI+
         +akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276378; x=1758881178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAZLPCCH0EgC7m1vhKAbHLebwwq6tBL7BsLJTj4U7Qk=;
        b=ubbiYPJ2rpOko+9ciBoF9fq1X2rKt2xONexw726qlnyeH2vgjbtGPY+IzHMkW1WKQp
         H/bX6F4FNIhpByS8KFZiI9klMIZEaysNLu/iCqWGDmDjABNN5NXD/mUxSRMKcZEnI4JT
         c7tQdBtMJ8a9s5+rxKIatflR6/vjV//rDyvl70GHeZi7Z986zcQzJSXw2TEH8J+S1pnK
         jHpc/YzQoZk9Ai7x8XeL63OOzZdCq2RYDZeZH52fg8HL4Pd+RDCGEKmfuMkH77/Cssne
         5kzXtyAEgv8le9jn9BjjFnEcA1NUP+r23ncBuUC7qFvjMHoVwHAxaeqh2FcIpC5HSBnw
         M2SA==
X-Forwarded-Encrypted: i=1; AJvYcCXULNyeDMeCJtpZvgyl84rcYC5nmm5Q4ojmrfoW6mehyVEaVVoi6DbxCohPfUAkeD3AWlIh4IzdDyOZLWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQXSFpm2BCJiulE9eg6gfVEZH64UxxgvMcKtQtXJPrvHRc1xB
	wqJuqb/6m1UZSQkl+5wEYlckVwXxVID6GYlmZleHZm835rh5Ja+C6N/Ze3rKXQpRFA==
X-Gm-Gg: ASbGncuUxmQ6V0uVTueUGWtYoPMQt9zQ1tRjoioWVkzkWLI4QwU+8sJsao3+kbpRR0w
	fE0bNTLqtk7bv0bketNWMISxO9r1pf/vY6NFJ7TkcZeXUwkM3m1TxWL5SFBwUoGvsGpSMPlwLe5
	ZXo+CmhVvpozJbJkY+yfOMw8+jXUPAyuMszkHhg1SENf3zTjli6nuE6+mHpMqT1JwgUorv/upBP
	jJUCsywfStklU3MZWR4jc9EYGA6jJ1SIQdRIQOB221xn7PYgrLI4J0rlesKdNo2yf+5f2u/5TnK
	ojvIE/pySBltDcu/uwwIQG+N6Xb/cYJl4kNtCnavTnYAvh8Sji1Q0JMoGSo1qWhna3BIo+kdQtx
	VW66+hC8zUWMxygqoRUbQmywg2m3hGuwnR453bcf8QY3ONXzbLICk3Y0OaEt0DCNaEQ==
X-Google-Smtp-Source: AGHT+IH7j5nrNszhPGZwafEQxw3v7iML2APU56b+3QSFjy1ZCXsWbsqVwmzYYDNqTZhcotIDu8aX+Q==
X-Received: by 2002:a05:600c:468a:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-467ea89da77mr24405135e9.22.1758276378163;
        Fri, 19 Sep 2025 03:06:18 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm81189215e9.24.2025.09.19.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:06:17 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:06:14 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Quentin Perret <qperret@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, sebastianene@google.com,
	keirf@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Validate input range for pKVM mem transitions
Message-ID: <aM0rFlaVKRkNxQPS@google.com>
References: <20250918180050.2000445-1-vdonnefort@google.com>
 <cf3v4dn233bf6y74ythiqulwfnshcdmddsdx3iqcenqjos5cct@zkcw7g5ieei7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3v4dn233bf6y74ythiqulwfnshcdmddsdx3iqcenqjos5cct@zkcw7g5ieei7>

On Fri, Sep 19, 2025 at 09:52:20AM +0000, Quentin Perret wrote:
> On Thursday 18 Sep 2025 at 19:00:49 (+0100), Vincent Donnefort wrote:
> > There's currently no verification for host issued ranges in most of the
> > pKVM memory transitions. The subsequent end boundary might therefore be
> > subject to overflow and could evade the later checks.
> > 
> > Close this loophole with an additional range_is_valid() check on a per
> > public function basis.
> > 
> > host_unshare_guest transition is already protected via
> > __check_host_shared_guest(), while assert_host_shared_guest() callers
> > are already ignoring host checks.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 8957734d6183..b156fb0bad0f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -443,6 +443,11 @@ static bool range_is_memory(u64 start, u64 end)
> >  	return is_in_mem_range(end - 1, &r);
> >  }
> >  
> > +static bool range_is_valid(u64 start, u64 end)
> > +{
> > +	return start < end;
> > +}
> > +
> >  static inline int __host_stage2_idmap(u64 start, u64 end,
> >  				      enum kvm_pgtable_prot prot)
> >  {
> > @@ -776,6 +781,9 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> >  	void *virt = __hyp_va(phys);
> >  	int ret;
> >  
> > +	if (!range_is_valid(phys, phys + size))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	hyp_lock_component();
> >  
> > @@ -804,6 +812,9 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
> >  	u64 virt = (u64)__hyp_va(phys);
> >  	int ret;
> >  
> > +	if (!range_is_valid(phys, phys + size))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	hyp_lock_component();
> >  
> > @@ -887,6 +898,9 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages)
> >  	u64 size = PAGE_SIZE * nr_pages;
> 
> It occurred to me that this can also overflow, so perhaps fold that
> calculation into your helper as well to be on the safe?

I believe this is currently fine everywhere because nr_pages is solely used for
size computation. But happy to use nr_pages as a range_is_valid() argument
(instead of end) to verify size as well. That'll surely be more future-proof.

Let me respin that.

> 
> Thanks,
> Quentin
> 
> >  	int ret;
> >  
> > +	if (!range_is_valid(phys, phys + size))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_OWNED);
> >  	if (!ret)
> > @@ -902,6 +916,9 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages)
> >  	u64 size = PAGE_SIZE * nr_pages;
> >  	int ret;
> >  
> > +	if (!range_is_valid(phys, phys + size))
> > +		return -EINVAL;
> > +
> >  	host_lock_component();
> >  	ret = __host_check_page_state_range(phys, size, PKVM_PAGE_SHARED_OWNED);
> >  	if (!ret)
> > @@ -949,6 +966,9 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!range_is_valid(phys, phys + size))
> > +		return -EINVAL;
> > +
> >  	ret = check_range_allowed_memory(phys, phys + size);
> >  	if (ret)
> >  		return ret;
> > 
> > base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
> > -- 
> > 2.51.0.470.ga7dc726c21-goog
> > 

