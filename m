Return-Path: <linux-kernel+bounces-888309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4812C3A735
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E62188C538
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12B30CD89;
	Thu,  6 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mi4pcrrL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F63019D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427179; cv=none; b=KgC32KIwp481yrbe0Dl6fz9cXPClLTzyh4rTWoSD4RygbkSlOJNSNvZbglchlsS61RITMPJn9MXlOhv+QSqmz2CKK0qlHLwpfbNqLx9wgqMAAgyzxiBgj3EifFxHN+2kD7sUG9ZefTJ98ezPg9Pujgjij300WrXr8MH9+W6s6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427179; c=relaxed/simple;
	bh=4cS4awkDakBBGs7QL/xXO0LyzLmqQrXz8qdFmMEuZhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEnUyUOLnmZREb1rlApYVztBUP0ikD/tksiqgYiKXoX0yQaDfgsAxVVxzNmwjEHGbvGE0XrjidNIRTyU1CkVXP8acDnzbE2yom6pI4jBF2rW2ShTLrf3hhE2RRkx4pt93HP7Q7UdwbYuV2Ju9dCJkj1fPorg/bbO2GRbd8CaaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mi4pcrrL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso42505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762427176; x=1763031976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xP2QazUoPgLd8bd4CuoIUWxA+WJ3ehNooABdbD8w52A=;
        b=Mi4pcrrLVUv6upERcGcAvAqvXIPkakfOk71fXBvZUBPbS9VPSlbmkRi76t4lMg/ayl
         fz/VirDrh0biqdvORbTrlxuRRMRFD0IMs2A46tZZ6DFaZ+m0lCJPRUxYTQBlwSmFUdhm
         jJst/rv7vlbe2K/PaTDNBm2uX6u/y/mpvKXNa64a74ik3ZVACIqd0jw1PVFgtwNAb8qa
         p8CFMXGFfu8zC2n+HVl5GIcOzoC1eZ/iRhn9yqvusOmhO04hfqiaAZ95joy3qtjJ0f2J
         lWTOJlGlDq0rAxGVbToWGiRs72ws+IleeGtAoydTy8GUhPRsoZ+aSO2sevonpByLSqAx
         mgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427176; x=1763031976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP2QazUoPgLd8bd4CuoIUWxA+WJ3ehNooABdbD8w52A=;
        b=S5nEwqAMl7qnpsKydpxxzTl3hlHn8x+BJXoh1h08ocd/Eq+o816vGD46+WMrJFDgeS
         F4yrwKlcDdIg6R7q1PX2RJKh6g9rpSIJwp7iGIi2lVftpafnqUYDl6Od8zIDYEDD/P7q
         DJDoYBDl1T6KVQ2vsb84S/4qSV9GnGgeoDJ2DivIQF9tKeGOvPMf1AlioVxDOhTcyz3B
         O33+c++nEiuH/nlL69fmC7LoqvMt5yhJMj6bkp6iVvsLNPb6nFD+00E0jiPtg3EtRFCV
         HHLlPVjzZMC0ZCuH5PBloEW4zN05+yp4UXmIPNkxRmf41a93NSEyUiDjf0hFL6CtozX8
         UXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCSwSsQgTMkFReTerhkbuZahjH9w2bj+ds1gCRe0rROcmHOOFQwkLxce7qxm5SgAW3UyndEIk2B+ksFEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCr6SsCCfXk5whYlp0oighEC7jJwRW3MT8lUszWMbFJFpjpsMd
	iieqtdUN8MGLKgZrb/kFBXOB4cBvOqIPY0HZ3JVF4LhUjxjLMQZWmxnQbrvZUvvibA==
X-Gm-Gg: ASbGnctx9xz2o3BZp+16mo0yPZcwjlq+RtqH0fmnpZiehSFhQ509zQMGkJpUdKWCoRR
	aU+G9DAJklnX/huJt1x/WGxoyblFMOlDUmWru75surbW7fxHPLLJsuql0Dm+ZoItVtIY8ZDK0bQ
	CWCKQhH5hdxgwPzK+ox4hf5m94eg1DjkhuscVMR15RzVR3wnP4ogm51MLgMyBew7GjHUbCj5Bwi
	Yxc6LCRU+x+BL4YznPy3WNhpB0aV/Kp9rg/kTCiN2e0fpxP6Ip484YaTE60mQL/agKFIlyjiTa5
	T0OHj89rFKD7+hko1EXegH8o0QkcpTpQ70D7dc4AB75UJhuAlR9z/HAxUCBCxeFZHAcaa/uybyD
	/cCxqa8pO3CtLs4pV83VULGpdfw21QZK32f2+Dkt7LAlVjNUsz/C6TiRUac3DFHNB9ZI6YCylYP
	LEi0q7UhQBHPYtYj+8w7wwdrcKIkG92UCKsMXAsvecBozT8VAhVw==
X-Google-Smtp-Source: AGHT+IEUOv1ZE3UbDFaV92jPApWKF4Ndj0TjhhcPgVhbXYQBhOFnOW3XBZWOwcR3RPC6W7WWXNjURQ==
X-Received: by 2002:a05:600c:58d1:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-477628cece0mr1822875e9.4.1762427175811;
        Thu, 06 Nov 2025 03:06:15 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm4426519f8f.32.2025.11.06.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:06:15 -0800 (PST)
Date: Thu, 6 Nov 2025 11:06:11 +0000
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
Message-ID: <aQyBIohAuxNHV-XI@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105171208.GN1204670@ziepe.ca>

On Wed, Nov 05, 2025 at 01:12:08PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 04:40:26PM +0000, Mostafa Saleh wrote:
> > However, that didn’t work because, as from Linux perspective the
> > nested driver was bound to all the SMMUs which means that any
> > device that is connected to an SMMUv3 has its dependencies met, which
> > caused those drivers to start probing without IOMMU ops.
> 
> ??
> 
> What code is doing this?
> 
> If a struct device gets a fwspec attached to it then it should not
> permit any driver to probe until iommu_init_device() has
> succeeded. This broadly needs to work to support iommu drivers as
> modules that are loaded by the initrd.
> 
> So the general principal of causing devices to not progress should
> already be there and work, if it doesn't then maybe it needs some
> fixing.
> 
> I expect iommu_init_device() to fail on devices up until the actual
> iommu driver is loaded. iommu_fwspec_ops() should fail because
> iommu_from_fwnode() will not find fwnode in the iommu_device_list
> until the iommu subsystem driver is bound, the kvm driver cannot
> supply this.
> 
> So where do things go wrong for you?

Thanks for the explanation, I had a closer look, and indeed I was
confused, iommu_init_device() was failing because of .probe_device().
Because of device_set_node(), now both devices have the same fwnode,
so bus_find_device_by_fwnode() from arm_smmu_get_by_fwnode() was returning
the wrong device.

driver_find_device_by_fwnode() seems to work, but that makes me question
the reliability of this approach.

> 
> > It seems device links are not the write tool to use.
> 
> Yes
>  
> > So far, the requirements we need to satisfy are:
> > 1- No driver should bind to the SMMUs before KVM initialises.
> 
> Using the above I'd expect a sequence where the KVM SMMU driver loads
> first, it does it's bit, then once KVM is happy it creates the actual
> SMMU driver which registers in iommu_device_list and triggers driver
> binding.
> 
> This is basically an identical sequence to loading an iommu driver
> from the initrd - just the trigger for the delayed load is the kvm
> creating the device, not udev runnign.

SMMUv3 driver as a module won't be a problem as modules are loaded later
after KVM initialises. The problem is mainly with the SMMUv3 driver
built-in, I don't think there is a way to delay loading of the driver,
besides this patch, which registers the driver later in case of KVM.

> 
> > 2- Check if KVM is initialised from the SMMUv3 driver,
> >    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
> >    KVM driver macro and cmdline to enable protected mode.
> 
> SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
> actual working driver? Do this by not creating the struct device until
> it is ready.
> 
> Also Greg will not like if you use platform devices here, use an aux
> device..
> 

But I am not sure if it is possible with built-in drivers to delay
the binding.

Also, I had to use platform devices for this, as the KVM driver binds
to the actual SMMUv3 nodes, and then duplicates them so the SMMUv3
driver can bind to the duplicate nodes, where the KVM devices are the
parent, but this approach seems complicated, besides the problems
mentioned above.


The other approach would be to keep defering in case of KVM:

@@ -4454,6 +4454,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 
+	if (IS_ENABLED(CONFIG_ARM_SMMU_V3_PKVM) && is_protected_kvm_enabled() &&
+	    !static_branch_unlikely(&kvm_protected_mode_initialized))
+		return -EPROBE_DEFER;

That works for me. And if we want to back the KVM driver with device I was
thinking we can rely on impl_ops, that has 2 benefits:

1- The SMMUv3 devices can be the parent instead of KVM.
2- The KVM devices can be faux/aux as they are not coming from FW and
   don't need to be on the platform bus.

And this is simpler.

Besides this approach and the one in this patch, I don't see a simple way
of achieving this without adding extra support in the driver model/platform
bus to express such dependency.

Thanks,
Mostafa



> Jason

