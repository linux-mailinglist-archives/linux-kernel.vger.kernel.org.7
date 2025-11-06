Return-Path: <linux-kernel+bounces-889071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934EC3C985
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D87F188FC3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7EF284665;
	Thu,  6 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSnSg7qw"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24796285CBC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448087; cv=none; b=ZswIwyRnaRspfn2i24mgrh3wLmy1KZPy+rZ6emDB/7SbIo8xbs2ZIi2XbqCRSUC6kKkD6pyftifFgL3O8+ZVyG6LNi3o56HzgZ/E601D66g5TSXwlU6sTkQcBmQVI1t83ugbSknohmd3ZdKGD+JF2uc5ri6vFRBi0Acd0gg1ViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448087; c=relaxed/simple;
	bh=+er897VeBk4n/vRglajwaZ5PSzwLJpIHytxIjwJ2hFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxswUqrBjMr3HVb5Ccyoy0InSJ5g2Wt1nWV/bRMziaV2DFo4tfGL+4U40sZ/bLm0kJ6YfR0Gf+hxhj+jcJRy7JRE4yyLx2BVS831FtGQXVMjfNn3gMkpL9BmLq/pPjoOcdxUFleaBX8eWmb6yATxzERHbzDE9ZyVaNqDOQ/MaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSnSg7qw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47754e0a13bso86545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762448083; x=1763052883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qy5jSwN7S6PcN2+UAQhcACOnAgI06MV590m9VcIejho=;
        b=MSnSg7qw4+vQ9qYhCVauQnT/UVXc5vcjiEBq2BE23Gps9eXOjPcFGAN5gEX46Pu+OB
         yzPlgBKxHdDo0ikAXK+0yJ6tDqoT4a4oZ3//F+NM0ANbw1dW+cGhJfe9Dgbww/iWl5Ga
         7IvAAgzpbSGV+PVfEzFTq+UTw4jmYX7dvblwCcGGd0mzB2lVP76vrIKzo/u9LE+oqzKu
         WzM5LRvmqlTdrfG7KfQ6C6fgCdafBkyrQRtGTfhHZ4S/jyNCxb0pUmlzq5UxqJMOfQKs
         ZTe32zNxRzNPyOvvReX86U7mKlUYjVDrbfGWSIEtAyHgIzUmVZF3s03ruyalYqbJdsK4
         3DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448083; x=1763052883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy5jSwN7S6PcN2+UAQhcACOnAgI06MV590m9VcIejho=;
        b=wxIEGP09hbZvolc0OCUGfTodhlJ2v2GPRrOr7jN0Jca1y7oneFKBXlCG47LdnOW93x
         SB1iGmMPDJMr9gQTT1cTqrJFR8VyvyXv7x6SWZymXLXmKT+QCq56td9ru5WJbNH+7ZOk
         ztnKQyeHXanCtBtCbUFYGaZzvgYUgyb9z/gjoqmoOvcVKpz2p47V8qKou4XimCgXzvOv
         S/fK5e9IEdRVjZT4segmijsGN/h7koW50rd9gT5h39aKdKLPsvhUpRaNxGIa6KlY9FW3
         9mlWmnf8nyzuyvv4++bqraEovFH+AH13JG2MadCKT15Z7jhOcdG4kpvuDLGc4iTKljBJ
         fhbg==
X-Forwarded-Encrypted: i=1; AJvYcCVBAlHeoL+65B0cxxcBe6Gfw5CyU52NW9L6znrmk6vlHgeCHayctSRsl76s5i1NoIDVH0HrFuzxzh0yanU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcz5GGksH51mgYEsSAuCIMeyhbRoIfaGTCMJMxawZqezdOF0w
	h5ywHIdkOpuuu/hTs31kAFrZZATR4iMsKkMwNpvB9NYfiqfYkW+XPdgAV5O4q/dyEg==
X-Gm-Gg: ASbGncuWSR5Fsj9rXb4ry3CbKg6JIWrqyD5VcVWLks8P9oiYP7xNof6lyUBovY03ibr
	mwCg/suh+70aSrY5J1MWpel3htR/NdBcgtgiCTiiY8eqtSINQh87LqJtwV/0q+NoJIyIyIOK9/d
	fb9phF9FTK3bX7FHlFoC17ugG2K4s1TLjdNiBG/B5czTIrhr8DDuyKqM4jR+iSFM/eBzv1lQ6yv
	AldkmInoQgLmeAPl9duDk3olBqzm2aT3RwUouheQjNFCafSVRem1vk5Mr1uRFFxMg32nLXBmuq6
	Yen1xPFLKMkUnMgmkcuMzAPv+IFtQ6Tz1oW0BQyLd96IHgstijYMk6kXemdDEqOJrtPZKhk5HND
	L9tfrbvvoX0ManfkV/1lQ5ZX8PqToUEosuwve4mZrXIFo6SgrShzzG9BkhqSq4Bxu3WTwJNza5e
	jUQWWdFewAHstySnGvJjLllPdHHNtsyO5ULgdhamMtu7ZHi0ildyPPA/+RH8OV
X-Google-Smtp-Source: AGHT+IH9Sel42fS+BYooq+9ScS2mxKoFKXpJsaK/tHTCGPR8SBDeDrXp6AvREwD204lt8g8KrZ9JGg==
X-Received: by 2002:a05:600c:c10f:b0:477:1afe:b962 with SMTP id 5b1f17b1804b1-4776410ec16mr2231445e9.1.1762448083254;
        Thu, 06 Nov 2025 08:54:43 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm120476545e9.12.2025.11.06.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:54:42 -0800 (PST)
Date: Thu, 6 Nov 2025 16:54:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <aQzSzhcndQ3Ry0a2@google.com>
References: <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
 <aQyBIohAuxNHV-XI@google.com>
 <20251106132331.GU1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106132331.GU1204670@ziepe.ca>

On Thu, Nov 06, 2025 at 09:23:31AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 11:06:11AM +0000, Mostafa Saleh wrote:
> > Thanks for the explanation, I had a closer look, and indeed I was
> > confused, iommu_init_device() was failing because of .probe_device().
> > Because of device_set_node(), now both devices have the same fwnode,
> > so bus_find_device_by_fwnode() from arm_smmu_get_by_fwnode() was returning
> > the wrong device.
> > 
> > driver_find_device_by_fwnode() seems to work, but that makes me question
> > the reliability of this approach.
> 
> Yeah, this stuff is nasty. See the discussion here.
> 
> https://lore.kernel.org/linux-iommu/0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com/
> 
> riscv doesn't search, so maybe ARM should follow it's technique:
> 
> static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
> {
>         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>         struct riscv_iommu_device *iommu;
>         struct riscv_iommu_info *info;
>         struct riscv_iommu_dc *dc;
>         u64 tc;
>         int i;
> 
>         if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
>                 return ERR_PTR(-ENODEV);
> 
>         iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
>         if (!iommu)
>                 return ERR_PTR(-ENODEV);
> 
> It would make it reliable..

That makes sense, and it will address the problem Robin was solving also:
https://lore.kernel.org/r/6d7ce1dc31873abdb75c895fb8bd2097cce098b4.1733406914.git.robin.murphy@arm.com

> 
> > > > 2- Check if KVM is initialised from the SMMUv3 driver,
> > > >    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
> > > >    KVM driver macro and cmdline to enable protected mode.
> > > 
> > > SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
> > > actual working driver? Do this by not creating the struct device until
> > > it is ready.
> > > 
> > > Also Greg will not like if you use platform devices here, use an aux
> > > device..
> > 
> > But I am not sure if it is possible with built-in drivers to delay
> > the binding.
> 
> You should never be delaying binding, you should be delaying creating
> the device that will be bound.
> 
> pkvm claims the platform device.
> 
> pkvm completes its initialization and then creates an aux device
> 
> smmu driver binds the aux device and grabs the real platform_device
> 
> smmu driver grabs the resources it needs from the parent, including
> the of node. No duplication.
> 
> Seems straightforward to me.

Maybe I am misunderstanding this, but that looks really intrusive to me,
at the moment arm-smmuv-3.c is a platform driver, and rely on the
platform bus to understand the device (platform_get_resource...)

You are suggesting to change that so it can also bind to AUX devices, then
change the “arm_smmu_device_probe” function to understand that and possibly
parse info from the parent device?

One of the main benefits from choosing trap and emulate was that it
looks transparent from the kernel of point view, so doing such radical
changes to adapt to KVM doesn't look right to me, I think the driver
should remain as is (a platform driver that thinks it's directly
talking to the HW).
The only thing we need to do is to make the SMMUs available after
KVM is up (at device_sync initcall).

> 
> > Also, I had to use platform devices for this, as the KVM driver binds
> > to the actual SMMUv3 nodes, and then duplicates them so the SMMUv3
> > driver can bind to the duplicate nodes, where the KVM devices are the
> > parent, but this approach seems complicated, besides the problems
> > mentioned above.
> 
> I don't think you need to do this this, you can use aux device and the
> fwspec things all search the iommu_devices_list to find the
> iommu_driver. You don't need to duplicate anything.
> 
> Create the aux driver when the emulated smmu is ready to go.

See my point above.

> 
> > That works for me. And if we want to back the KVM driver with device I was
> > thinking we can rely on impl_ops, that has 2 benefits:
> 
> > 1- The SMMUv3 devices can be the parent instead of KVM.
> > 2- The KVM devices can be faux/aux as they are not coming from FW and
> >    don't need to be on the platform bus.
> 
> IMHO this is backwards. The kvm driver should be probing first, the
> smmu driver should come later once kvm is ready to go.

Agree.

>  
> > Besides this approach and the one in this patch, I don't see a simple way
> > of achieving this without adding extra support in the driver model/platform
> > bus to express such dependency.
> 
> You shouldn't need anything like this.

Agree.

Thanks,
Mostafa

> 
> Jason

