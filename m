Return-Path: <linux-kernel+bounces-764567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CACB2249C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCD544E2125
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98DF2EB5DC;
	Tue, 12 Aug 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jwuy6cl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A322D320E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994587; cv=none; b=anwZT5zG+j8zsM5jPUmtbKx27jDXt4I9V8jDSDhiUHu8/wGo5oabY7l7K6Vqwjlk0tDLidI/F8bGlehxKyTmAhv2oZu7Zf3rqzLDywnPG2LCKCIl+yCjXnSUDkfh5smS2YOuKX07Up/PNpP7lHbK/oehZAyXxM/3+tVGCOnSQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994587; c=relaxed/simple;
	bh=tTdx1UQ4bPBlbnqXoSHE5xrjt1WlM8z3PbQt6giizt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUJ0dzfY2Bcpfp/sONG98miyu2oRImXke88EjntgNVBU9uRJe6SRck8+c8HAWm0cjABXTOmGQaqH7UQaFpkJt343WZTdtUm8LwTKMVFbi2RlgTTh8tKlcEacapJO+01SAD+rsAwkx7mNonbuqeIk8/eya2q/PNHz5kk7k1qJRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jwuy6cl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so58385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754994583; x=1755599383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1/anwh1bqqHUf4EN9XkEDdbFNVMa1nyZcPFf3i2Ukg=;
        b=3jwuy6cllFSSGP3lm4jF1NLIvsmpPCkAeVx/Huqgjxg0jKPu3PCNoyOsStG0argTei
         3hj8ODe7xn0bg6+vbz94tEQFu9NsDp3aqd8iLMKGOcyQF/owvStB2pHc+b472A001Y9U
         tXRuV7ISE1to/g+BrSUCz9GRw9sSiT2EKZwbERCQd+VMXsPZvOqBQQF1LfOn/+tgpLYR
         leXPbQ8V9To3SOeMxZP1c5S1DUSijN1BkDaMVivEXTnysHPn8RrnvBmBdTBGUfF+VaIn
         he4omo0/7lJHxhlaPE8CgF0Jf2BKDCqiM/6ehr21KvHkTtDtPiPHgXH/89lVKlBJHmsT
         4q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994583; x=1755599383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/anwh1bqqHUf4EN9XkEDdbFNVMa1nyZcPFf3i2Ukg=;
        b=d8bNFZFxLHqIMuFeq2rwhm4TlXqmokHLLVY5kGZaEBCgfwdQTDkzq3Whev4TAQqUtu
         uA9X7n7wTqfJ9BYwKMjj23N0zKD7+e+QGuSom1AMvujmLvE1pmap8KV3snTJOYg8OIWm
         bKlJSoVBdRd6x368wnfqkdk3N4UH+ZLca6NQH0qsK7zhyQHOOda8HKTI7VPLD7TnCEGc
         OthsC3fPXNaSza8t1X5oIupoYCbqhdThP7jrUo3zcAAHUQY9ftIWybiTISNQClMXuE4X
         o5kvTmc0iRWrZfnKUTufFnQCCHdPqYMsE65B19U91mAhiWZVwqS1hrb4XhEqsvQcJrlA
         +KrQ==
X-Gm-Message-State: AOJu0YzVGwlFj9x7KOEu3BTqsy7KlDiVwTZHXi61d/HuYhFn9Rs7OXCL
	SuH7zeN/MSgPI+hx2cR/gSOlj4FtPfMZOq3tGuDbehJxfT/OMQOFy87BrgjgJTgjVg==
X-Gm-Gg: ASbGncsDcfLEcrJ3D2z7EMHsUY+iPGNp3sLQs0UIvGpRha5W7o+QD3mjy5aN0ovaaN9
	RMMTz+akot1xqzoMbIcKEin/4XkvlxAAtJC8X9S2onSaK7wcFsQdoK3LAf6pVmm1VSquRKtaR5p
	0A/NnQxGjxN6ZRroYGvGmlV78iytvChfJlakpkY1b7dkGOgFgQjtakQZuJ1YFmAaQoSuaT0tOFM
	s8WZ0+/aMTxERNVrRZbwwLn6A22a3BzQiFIaNBED009nTAD41tZx6hR+vDfppLvnBvBKeOpdgtf
	t77hP28fwR/xTGfYHLxl31zqW+s32STk22cn6D9TNtVvY33Nqetk7anqWDk/Y3NchHx5AXWZ2XY
	wZebqz1McPSNb2UUopzeNziQdH9oewQmrVZj94oNnS1ph0lcYoboBZwxKWZoyibWtW+Y18wvedN
	Bh
X-Google-Smtp-Source: AGHT+IHaYmnizcPqrn3Lb/9/nhKegnTEZ2frct1vzrtYBKDcVLr6eexdb/QiWRjNckapmQO/Wt9MMQ==
X-Received: by 2002:a05:600c:899:b0:458:b4ae:41a0 with SMTP id 5b1f17b1804b1-45a118d4771mr710605e9.5.1754994583250;
        Tue, 12 Aug 2025 03:29:43 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm43741716f8f.39.2025.08.12.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:29:42 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:29:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aJsXkidmcSl3jUJP@google.com>
References: <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811185523.GG377696@ziepe.ca>

On Mon, Aug 11, 2025 at 03:55:23PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> > I am not sure I understand, the SMMU driver will register its IOMMU
> > ops to probe the devices
> 
> You couldn't do this. But why do you need the iommu subsystem to help
> you do probing for the pKVM driver? Today SMMU starts all devices in
> ABORT mode except for some it scans manually from the fw tables.
> 
> They switch to identity when the iommu subsystem attaches devices, you
> can continue to do that by having the paravirt driver tell pkvm when
> it attaches.
> 
> What is wrong with this approach?
> 

My confusion is that in this proposal we have 2 drivers:
- arm-smmu-v3-kvm: Register arm_smmu_ops? binds to the SMMUs
- pkvm-iommu: Register pkvm_iommu_ops, binds to faux devices.
So how does attach/detach... (rest of iommu_ops) work? In that case we need
the pkvm driver to handle those. So, why do we need to have iommu_ops for the
kvm one?

> > > > Also I am not sure how that
> > > > looks from the kernel perspective (do we have 2 struct devices per SMMU?)
> > > 
> > > I think you'd want to have pkvm bound to the physical struct device
> > > and then spawn new faux, aux or something devices for the virtualized
> > > IOMMUs that probes the new paravirt driver. This driver would be fully
> > > self contained.
> > 
> > I think it’s hard to reason about this as 2 devices, from my pov it seems
> > that the pKVM HVCs are a library that can be part of separate common file,
> > then called from drivers. (with common ops)
> > Instead of having extra complexity of 2 drivers (KVM and IOMMU PV).
> > However, I can see the value of that as it totally abstracts the iommu ops
> > outside the device specific code, I will give it more thought.
> > But it feels that might be more suitable for a full fledged PV
> > implementation (as in RFC v1 and v2).
> 
> Maybe, but I'm feeling sensitive here to not mess up the ARM SMMU
> driver with this stuff that is honestly looking harder and harder to
> understand what it is trying to do...
> 
> If you can keep the pkvm enablement to three drivers:
>  - A pKVM SMMU driver sharing some header files
>  - A the untrusted half of the above driver
>  - A para virt IOMMU driver
> 
> And not further change the smmu driver beyond making some code
> sharable it sure would be nice from a maintenance perspective.

I am almost done with v4, which relies on a single driver, I don’t think
it’s that complicated, it adds a few impl_ops + some few re-works.

I think that is much simpler than having 3 drivers.
Also better for the current SMMUv3 driver maintainability to have the KVM driver
as mode, where all the KVM logic is implemented in a new file which relies on few
ops, similar to “tegra241-cmdqv.c”

I will post this version, and then it would be easier to compare both approaches.

> 
> > I had an offline discussion with Will and Robin and they believe it might
> > be better if we get rid of the kernel KVM SMMUv3 driver at all, and just
> > rely on ARM_SMMU_V3 + extra hooks, so there is a single driver managing
> > the SMMUs in the system.
> 
> > This way we don’t need to split current SMMUv3 or have different IOMMU ops,
> > and reduces some of the duplication, also that avoids the need for a fake device.
> > 
> > Then we have an extra file for KVM with some of the hooks (similar to the
> > hooks in arm_smmu_impl_ops we have for tegra)
> > 
> > And that might be more suitable for nesting also, to avoid the bind/unbind flow.
> > 
> > I will investigate that and if feasible I will send v4 (hopefully
> > shortly) based on this idea, otherwise I will see if we can separate
> > KVM code and SMMU bootstrap code.
> 
> Maybe, not sure what exactly you imagine here.. You still have your
> para virt driver, yes?
> 
> This especially is what bothers me, I don't think you should have a
> para virt driver for pkvm hidden inside the smmu driver at all.
> 
> And if we have a smmu driver that optionally doesn't register with the
> iommu subsystem at all - that seems unwise..

I was imagining just splitting all the KVM specific code outside of the
SMMU code, but not as a driver, it would be a library which “arm-smmu-v3-kvm”
calls into.

Thanks,
Mostafa

> 
> Jason

