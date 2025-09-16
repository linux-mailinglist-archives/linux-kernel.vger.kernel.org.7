Return-Path: <linux-kernel+bounces-819031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C37B59A63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF913BDFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499E341AA3;
	Tue, 16 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpDnHXir"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC8303A13
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033028; cv=none; b=CTvm0IwUq1dWe1tpA0/ru8CV4YnWXv1y3zsVsuJNjzl9HYqNCoStyNjeKkg+oE94FHj6Jqd1xdZ+lQyrNaqB8Xvo/nYcP4aMCQKU0kSEAi3fSOrDYtnJ1QCDVtmgPgv4ucBioxpNmHJDQv3c7YIHK7wiarU9YWX2x+TtmrBxArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033028; c=relaxed/simple;
	bh=lXDcSFWQYp91MNC66yHZBJWni2JhoTUG5cLOCWW97Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl5l9M/HkJlp6jMIr5GxyRoSNJG999dL4ezjjIw66sqB6PszhBzDfpJxeUTo0uTmDh2ArDokcO5CYHZxzRCcSQekxBV2oA3eJDwToymTToqrQFfwTBGH4yq/Rrerr+Z73xjCQDkC+IOsDUwj60VYxbBliLGGImWdDt9q4jFJyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpDnHXir; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f30011eceso58635e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033024; x=1758637824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhmMdRL8qlR3Tvk3u8O3tOtlAqkQkVluaZ5zKHg+950=;
        b=dpDnHXirqCFW+Ec849gfBCGDKI/L4nOru8oeeN3MU7dIruq4aMzPnueafMX5496e86
         j37aEoqtpqjsY624bmQ4AlTm/d72CuXmxan7JSlM7LFWZb1avGrJKhu5WdZkZI2bdFGa
         35yKfsiZxIM7p+wMCQUSO29w2wWqE+VqkBFk61UZSrfembIc3jR0xQXggE2nkKyvRCit
         RiHcWJjLY02ppk+eTkBYiO5BUw4/N8t1/U0lqus/Wmremxpte28fLy5jC/2pzbnDIAvX
         ppIE6Rp7sqd8NC6J8ao3W1SZSD1gI7FEjYW8Z3w7poS5tigo0G0DTwNgQsZ0/vvPtBm8
         WErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033024; x=1758637824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhmMdRL8qlR3Tvk3u8O3tOtlAqkQkVluaZ5zKHg+950=;
        b=bExAUkjgujSm3DRCYk67/vrsk3plhkyTlnCpBeWY9IrD917mz/1eF+C0aE5X/LiIl1
         DT/MCBTt24qJbPUpyI5zbFOJKs9JkQFeD5tHW6e443SnB8ZTavpZsSeuuZMqLLbwWB0r
         JSseZRiSsF7cg1uqf5Z8/N9p9hXLXhQ89bjb8imymvk8ox5ITAdjRoOe6kGWAswCb3YG
         ZnKtYy1qjtYQQfB0N3/p+9FcTzDuY8wmwYxE5W4GaK+y3pS8Kx4AdFk3qg8QSoOL9E0J
         44ByC8sl3Q3yG64Dmy8uFNaGQvqH+sDkUgpoWIhTuAfr+mCIx+vvGrtgJnT8jYTcPQ1h
         +5Ow==
X-Gm-Message-State: AOJu0YxjUQllSRghVzH7/7Le8f/nu+aMBaNkvsFt32kn59O8KoLvoVOL
	ZWcUabi/YIjndxrzjkaEYeRzmwMPo/fua2hNws70tI4k7O7qUZaALmp26c5SP1P2qg==
X-Gm-Gg: ASbGncvn5nZ86nhTji0W8bYw63+vwe1+p/6iQTkgfP20sqWXZMssXE1gOh2hO1h2InA
	oQmz/n64y2CAI1ZuoPYmSkh14xPvuusJc2qMvv+oQ4pb6JKV3j1F/+mF87HnjCZID/FGCO1qpae
	gvmYaFdJmyjpnzrHyQEmzLAUVKE3T9HXJDFv4iqCl4bgWTrWDu9Gp0z1hLXy2FPjXJAePuyX/Cm
	tqSxtA5+V9wwXCbJgmny4qhtndwXEJ+ASeZR0HJPyT/mJ77VIsXebyFOmGugU0kxjq/ClsnFEdM
	xHJ5U8Uly7Pn0ICfXABbvskOnHk1XLZ5jNOmoe6j/mruZMcdpWAwdN9D3p8Xm1IMcoA4HoseBfE
	9zddkWM06z2ZyweSLxe4c3XUUq02DIbjS4yt3vqH3AHfM7T24fxvNTqIx1E9eELm8IAErHDBvbN
	dX83ztu4lpkKXQ8Zk=
X-Google-Smtp-Source: AGHT+IGo1adSqugDdIZRQSzWcjgsYTglPxgYm/2Pf1a15n6l2x2VoKYdVxQeE+Hpg647GI1uAq/aog==
X-Received: by 2002:a05:600c:8b35:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-45f320ea2dfmr1944965e9.4.1758033024087;
        Tue, 16 Sep 2025 07:30:24 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm340062f8f.46.2025.09.16.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:30:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:30:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 14/28] iommu/arm-smmu-v3: Add KVM mode in the driver
Message-ID: <aMl0fJJyV5sJKIKS@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-15-smostafa@google.com>
 <aMQlm9ucDtd5-15r@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQlm9ucDtd5-15r@willie-the-truck>

On Fri, Sep 12, 2025 at 02:52:27PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:42PM +0000, Mostafa Saleh wrote:
> > Add a file only compiled for KVM mode.
> > 
> > At the moment it registers the driver with KVM, and add the hook
> > needed for memory allocation.
> > 
> > Next, it will create the array with available SMMUs and their
> > description.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h             |  4 +++
> >  arch/arm64/kvm/iommu.c                        | 10 ++++--
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |  1 +
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 36 +++++++++++++++++++
> >  4 files changed, 49 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index fcb4b26072f7..52212c0f2e9c 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -1678,4 +1678,8 @@ struct kvm_iommu_ops;
> >  int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
> >  size_t kvm_iommu_pages(void);
> >  
> > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > +size_t smmu_hyp_pgt_pages(void);
> > +#endif
> > +
> >  #endif /* __ARM64_KVM_HOST_H__ */
> > diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
> > index 5460b1bd44a6..0475f7c95c6c 100644
> > --- a/arch/arm64/kvm/iommu.c
> > +++ b/arch/arm64/kvm/iommu.c
> > @@ -17,10 +17,16 @@ int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> >  
> >  size_t kvm_iommu_pages(void)
> >  {
> > +	size_t nr_pages = 0;
> > +
> >  	/*
> >  	 * This is called very early during setup_arch() where no initcalls,
> >  	 * so this has to call specific functions per each KVM driver.
> >  	 */
> > -	kvm_nvhe_sym(hyp_kvm_iommu_pages) = 0;
> > -	return 0;
> > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > +	nr_pages = smmu_hyp_pgt_pages();
> > +#endif
> 
> Rather than hard-code this here, I wonder whether it would be better to
> have a default size for the IOMMU carveout and have the driver tells us
> how much it needs later on when it probes. Then we could either free
> any unused portion back to the host or return an error to the driver if
> it wants more than we have.

I can do that, we can set the default from a config or cmdline (or
both).

Thanks,
Mostafa

> 
> Will
> 

