Return-Path: <linux-kernel+bounces-763467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991EB214FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AA23AE9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5EB2E2DE0;
	Mon, 11 Aug 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D3w92lQg"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497862E2DCB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938528; cv=none; b=SBvtcTlE+NloSwuGOljYYmSXNd81Ynu5mBJho/UblgPKQuyjJLleJ3W2ld1WZwgQy4e085app532LtYjgSSyqMt3AhXaisQCKgq0ELT4J9Cxrqpu2LzBRiN+Ktdfp1wn9OMf8b3Hm2TPCSV0IoGCEbpVbVSjsP2krpQguJCumOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938528; c=relaxed/simple;
	bh=uQ3fr3pfhXh7AS8ejvnx1d8aiWIIkDyvsDnvhr3mk9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQSgr8MWQZ66iknOjJyaTqumD8OiBgm9ugAsopbExBj9T21sMC+HPcsQifMg2L0/wKkO5bG69zI/t9XcXlX6O1E4XCaIhPeLqbCAONrWz3Hhm2pXswJgfdhydVJNa0N5FG7XZ6ncacjbf8MtVpXITxZmpNn7iNdM+RiqZiITt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D3w92lQg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b07d777d5bso54091351cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754938525; x=1755543325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+1xezh5zigs0Eh1IHXpsvZxf5v0NNa8iAaWLGnBO56k=;
        b=D3w92lQgeUY6UadxTmG8ZBA/HYEO2r3gIqBDfsoc4qbpFyZDT6mFAR6m9OY76HZv0u
         vLlobA0DebE87kPBTsiMjmfBKC5oldK7eHjHIysQPZyr8IHizDk+pt82fBEZAdnxHger
         WlQOf+NHbPhbGW+GOZkrQSSKsNOBU4+NIpWq0C0kFyzd8l6l4AVQvNIgvemZtgtor21c
         9LT5w9MXgBj2MbyqdgdJV5/fmPEjGvQrpOAGuV8v2k7BkFLFawQhcjoyZnEdPNxtI9aU
         pcU0duUKlW/kQAZWNrxMHH/BvDNadTkPw1PxHDfOhXfOio3oq0Lwv1CUgldt4ng6jqT+
         MnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754938525; x=1755543325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1xezh5zigs0Eh1IHXpsvZxf5v0NNa8iAaWLGnBO56k=;
        b=W8ZYaPYOFg+ovb+sdXQQJNbESZB4aSTwOuTbB1jnu+TJvXYDh2FcOJCT33rAwNfHCl
         /bfa82rxPd8rIwQoYMW6ojiJH8+bJw+1nDM+O0giLKiIdojU2Ujs5iqy66aql9x60jGn
         gZ1IgepBQtkpfTv0tmYZ3htFHFV+L7CdDwHXc5olNJ6BfiHw01Tn/m7yv5VbQS180Tj9
         aFGp8xCPAm0cYDJR2FP0IMHuq8bFhu7fQCVwEOHjSJFJHHSZZadGFBGn33TJTmNXHKmf
         ct69SY224mBXSzcCwScvjr5d9yoVdv9aLyL6ERqvEj/opUA+sUJ3uxbJW4Y13/PyAeiz
         4Iyg==
X-Gm-Message-State: AOJu0Yx46H1wBAeYru0ubAV8RTjp9ZGdSaoYvFVV6wt4t8mYG+yWxz8E
	pqXWsDemqdBGAMUgtfzCXeoG9FWAhGA6TU3qVDIWVPikM2PpWGrT7QfW530pm0qVc14=
X-Gm-Gg: ASbGnctHzsH5ZEKn4i/xZfQNlv9z3z9FyC0gGre8tWW6WHeuRlo1HIPglIKy+++JdFl
	eF7+nlltGOYHT4eqjS7StFS13xLGd9edZVrWD2TsI51hvGPYChTw3GG6SQrstdkRckhlX4VZCv5
	nJmpDswkU3SzgHFNx9tt7X7DvL9ERF0yxxD6YwVNHzwkcpClPTdp2SUJ+IxdQ6xSVo0ryCLd8R/
	CA+Ek6TwYEHZinvgWNLtYeC+b6ZtzyFKcDcQkkCXdSmSM6LZC+T95guHv+QoBTWAO28mJTd8VrF
	CGhMu2j2XZqmHOvlJn1M8vw2uSi7Zrg/bflnrx7e2h5PPH6RC4KaNlw7tq4sHUZJCAQvv8BkMEj
	GaUDmCQy1oA3SQmurhy+zZLhyRHB6qhjjiWyUW+jHDmHQTM0j4iQtmgqPqxQoBc0iMaSP
X-Google-Smtp-Source: AGHT+IGgJZJcKTKM3XxOf4YsuboP55lfsrq1eYtf1kTos3YrkSFpLqpnWNoLYcx3tr3obv49p1pGYQ==
X-Received: by 2002:a05:622a:2507:b0:4b0:7b80:4761 with SMTP id d75a77b69052e-4b0ecc76dbdmr9999781cf.37.1754938524860;
        Mon, 11 Aug 2025 11:55:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b08cfbc7b9sm81757831cf.23.2025.08.11.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:55:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulXg3-00000002V2t-2HW8;
	Mon, 11 Aug 2025 15:55:23 -0300
Date: Mon, 11 Aug 2025 15:55:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250811185523.GG377696@ziepe.ca>
References: <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJNiW48DdXIAFz8r@google.com>

On Wed, Aug 06, 2025 at 02:10:35PM +0000, Mostafa Saleh wrote:
> I am not sure I understand, the SMMU driver will register its IOMMU
> ops to probe the devices

You couldn't do this. But why do you need the iommu subsystem to help
you do probing for the pKVM driver? Today SMMU starts all devices in
ABORT mode except for some it scans manually from the fw tables.

They switch to identity when the iommu subsystem attaches devices, you
can continue to do that by having the paravirt driver tell pkvm when
it attaches.

What is wrong with this approach?

> > > Also I am not sure how that
> > > looks from the kernel perspective (do we have 2 struct devices per SMMU?)
> > 
> > I think you'd want to have pkvm bound to the physical struct device
> > and then spawn new faux, aux or something devices for the virtualized
> > IOMMUs that probes the new paravirt driver. This driver would be fully
> > self contained.
> 
> I think it’s hard to reason about this as 2 devices, from my pov it seems
> that the pKVM HVCs are a library that can be part of separate common file,
> then called from drivers. (with common ops)
> Instead of having extra complexity of 2 drivers (KVM and IOMMU PV).
> However, I can see the value of that as it totally abstracts the iommu ops
> outside the device specific code, I will give it more thought.
> But it feels that might be more suitable for a full fledged PV
> implementation (as in RFC v1 and v2).

Maybe, but I'm feeling sensitive here to not mess up the ARM SMMU
driver with this stuff that is honestly looking harder and harder to
understand what it is trying to do...

If you can keep the pkvm enablement to three drivers:
 - A pKVM SMMU driver sharing some header files
 - A the untrusted half of the above driver
 - A para virt IOMMU driver

And not further change the smmu driver beyond making some code
sharable it sure would be nice from a maintenance perspective.

> I had an offline discussion with Will and Robin and they believe it might
> be better if we get rid of the kernel KVM SMMUv3 driver at all, and just
> rely on ARM_SMMU_V3 + extra hooks, so there is a single driver managing
> the SMMUs in the system.

> This way we don’t need to split current SMMUv3 or have different IOMMU ops,
> and reduces some of the duplication, also that avoids the need for a fake device.
> 
> Then we have an extra file for KVM with some of the hooks (similar to the
> hooks in arm_smmu_impl_ops we have for tegra)
> 
> And that might be more suitable for nesting also, to avoid the bind/unbind flow.
> 
> I will investigate that and if feasible I will send v4 (hopefully
> shortly) based on this idea, otherwise I will see if we can separate
> KVM code and SMMU bootstrap code.

Maybe, not sure what exactly you imagine here.. You still have your
para virt driver, yes?

This especially is what bothers me, I don't think you should have a
para virt driver for pkvm hidden inside the smmu driver at all.

And if we have a smmu driver that optionally doesn't register with the
iommu subsystem at all - that seems unwise..

Jason

