Return-Path: <linux-kernel+bounces-829119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41916B96555
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F19B3B8CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9F22A7F1;
	Tue, 23 Sep 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKkYbL9/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454618E20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638156; cv=none; b=PgDBKdYCb6DxERvEd+voEX7sS7dHNO1uXofKrY0M6SQFP54R4sviVnItoLLHwhzPjUNP4XHlBAYi+GUrHBV8Qf6sg1VF9/ypN8LO+D5Z1RPOPM7ehcX/3im2op53shJZgSeLnqtFbn/Kymf3K98eTjVYlVaz3EEZhg9ACQe+Szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638156; c=relaxed/simple;
	bh=+qI76m61UBIiYSKYa7PKpe19ghecX989zXs+Qyuqc5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+j4GBkka+22G8kwXTWcY+k3mCGkWSoJDDxK7UdWVqS6397ykmXKPgELFwJoRhuUq2eDvr2t49KQYvRAkDbj+4yIfxe6bUv5Rh2LA0NOtu/yeCjfY34HGJJYr/u643WtPQbXCBSuqSeGbIYk9YYEUzWNfeVSt81jgtRZcaSo4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKkYbL9/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46d72711971so77915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758638153; x=1759242953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w7gFiyv7OnRS5nGrN+3NtlLFQvUag+pzI6L45ZXC1s8=;
        b=vKkYbL9/Fi/ixAGHhFsK9n6bsVeIB7w7nnXJr4B0Y+gYU91UK28S+M/dR3xieloMGR
         MoKSm7ZHyOEjW5Ur7ezUB6pvD0uL5IvQuMjtKIqIS4nZnFEUhyLcTqs1thZboePCTnH2
         qHmfTcxDeW8aqSmLb7tcGmYFwY5YXadnxvx5OrE2MD49U5KQqqI0vVjhE8sKLgOW+RlR
         Hv5myhYS7FSHypMtE+7J5UKb0HAPIBHZa+gps0irw+6P17grdiCikQoGlPnulrh2/8gX
         XVes2DmNx9qsGXhyObUkmMegRdJen8uchi1My/5MSLPlIvZ0dOhKhr5LRs8n2tM7zi9v
         Pvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638153; x=1759242953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7gFiyv7OnRS5nGrN+3NtlLFQvUag+pzI6L45ZXC1s8=;
        b=qwx+ahDfm/BcyI/HPH6+qzbaX8sUpp2pTOoY8JWgrdhBuQ/Lgpm+vwU5o/DmGSylq4
         gTJ3HGe4hXHuBSv/ml/sN5yMeK1m47RFDF32ArUpMg8cA+qIEVwVgz7Pqz2IZC0Wwsf6
         KBx9JMGIQHtaDCM+9PlzJNGQ+ixYHsIJIadP8h/x22TIkydM2ar6heDFDE9V0ZU19acJ
         CJlanA/IMcFn7gSFBF1SdAkUKCoKLmw+7frPFYDWY08fyDt7cZauQBB+D8BsrWKMViyg
         WNeEMmWikz55Ff3vWP3E4Kmk+8VDMP8C6dIhL94AgC5levdIcWUmu2ngFBogpAuRRseC
         FQgA==
X-Gm-Message-State: AOJu0YwDX5T43UKfo0yvxejvJsroFVbO+0ecwpVUq6k3f++QzPvhJ0En
	vijAg5SaYXhWnAgmcAG1S8prSMF2mOK1+iam3lLi3PgVh1pE5koQoKLGwTetHaRREg==
X-Gm-Gg: ASbGncuB89CInLEo6U+lx0Wb1lt6gaarJh4ESj52IXZORyh3zsRwym3E3enlwFcwe2m
	5ThHUtT7tZxUch8jXy2Jnn7gju7VqdQDLwoDy0532mtFhWIXOmumznbvLocuAAfmyLoQyaxaxu5
	+22ZVwdeWLEEZUVCGibLDufPvwxEJ1GltCXhV/3sr7Ls2uyLJ7TdK04AFjaGbjrG9fKJhB6CtfB
	f58ZdifPmnJEfgHcj/Gx/dwzjE6+JPrhxsFaOazDN3T1SXBZyxNj945E43Uq3FQuLWj34ahKh5x
	XFonTJGYo9Gjl/YdyaEQlGjOaH8PVLSh9DDBauzs5egsEGNSKXSzSGo6Vu5r9q+ROrGFkENyOeq
	lkVFe/jgxWA0Roxko7qQCisLzWELXewJ41ijuUJu6UhPTm/5gwHBYBZV0CfYYz0fzWE8=
X-Google-Smtp-Source: AGHT+IFvUZC8hU4aVaM+B2ZVSTNY2pCK/nLLcGd0XFRXs64IKLx9ZNGK9gnrvBoN85r9vD2bqa+nEg==
X-Received: by 2002:a05:600c:a40a:b0:45f:2e6d:ca01 with SMTP id 5b1f17b1804b1-46e1dc7b863mr1452625e9.4.1758638152887;
        Tue, 23 Sep 2025 07:35:52 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07408258sm24481309f8f.19.2025.09.23.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:35:52 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:35:48 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <aNKwROPzDCWgJBGQ@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQmA9cLaeYWG5_C@willie-the-truck>

On Fri, Sep 12, 2025 at 02:54:11PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:43PM +0000, Mostafa Saleh wrote:
> > While in KVM mode, the driver must be loaded after the hypervisor
> > initializes.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 ++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 10ca07c6dbe9..a04730b5fe41 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -4576,12 +4576,6 @@ static const struct of_device_id arm_smmu_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> >  
> > -static void arm_smmu_driver_unregister(struct platform_driver *drv)
> > -{
> > -	arm_smmu_sva_notifier_synchronize();
> > -	platform_driver_unregister(drv);
> > -}
> > -
> >  static struct platform_driver arm_smmu_driver = {
> >  	.driver	= {
> >  		.name			= "arm-smmu-v3",
> > @@ -4592,8 +4586,27 @@ static struct platform_driver arm_smmu_driver = {
> >  	.remove = arm_smmu_device_remove,
> >  	.shutdown = arm_smmu_device_shutdown,
> >  };
> > +
> > +#ifndef CONFIG_ARM_SMMU_V3_PKVM
> > +static void arm_smmu_driver_unregister(struct platform_driver *drv)
> > +{
> > +	arm_smmu_sva_notifier_synchronize();
> > +	platform_driver_unregister(drv);
> > +}
> > +
> >  module_driver(arm_smmu_driver, platform_driver_register,
> >  	      arm_smmu_driver_unregister);
> > +#else
> > +/*
> > + * Must be done after the hypervisor initializes at module_init()
> > + * No need for unregister as this is a built in driver.
> > + */
> > +static int arm_smmu_driver_register(void)
> > +{
> > +	return platform_driver_register(&arm_smmu_driver);
> > +}
> > +device_initcall_sync(arm_smmu_driver_register);
> > +#endif /* !CONFIG_ARM_SMMU_V3_PKVM */
> 
> I think this is a bit grotty as we now have to reason about different
> initialisation ordering based on CONFIG_ARM_SMMU_V3_PKVM. Could we
> instead return -EPROBE_DEFER if the driver tries to probe before the
> hypervisor is up?

I looked a bit into this and I think the current approach would be
better because:
1- In case KVM fails to initialise or was disabled from command line,
   waiting for the hypervisor means SMMUs may never probe.
   One of the things I was cautious to get right is the error path,
   so if KVM or if the nested driver fails at any point at initialization,
   the SMMUs should still be probed and the systems should still be running
   even without KVM.

2- That's not as bad, but it leaks some KVM internals as we need to either
   check (is_kvm_arm_initialised()\or kvm_protected_mode_initialized) from
   driver code, as opposed to registering the driver late based on a kernel
   config for the nested SMMUv3.

If we really want to avoid the current approach, we can keep deferring probe,
until a check for a new flag set from “finalize_pkvm” which is called
unconditionally of KVM state.

Thanks,
Mostafa

> 
> Will

