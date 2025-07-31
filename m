Return-Path: <linux-kernel+bounces-752457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C370CB175C7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE016209F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC62797AC;
	Thu, 31 Jul 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYKAIJJD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD422FF2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983903; cv=none; b=NIBJzDXdVrNhJnhTtyDQcq1M1PgbLosoH27dnndOBTp29Vc56krJ5EVHB5hV6TjpP+OsHfnWrrLTRZce3SOLWMD4TD4/gSxFIyxqWa0jX98hy7nAI/Wupihmj22He5xJChZZr7ZHGB7xo9rCoZTdiJ464ogz507sWLo7zpNvAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983903; c=relaxed/simple;
	bh=McEipDWDZ0a4efpZE1Lw4KPrrD4u60yjBO1dH6BPMys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGea4RWWEdmeIC5Gs0Ri5xjcKz/kmmhO7keSlmmziT/yVLi0ptRfdoSM+pI0f4N+CYnSZOZgwsOJICS3UjhtQSJZIay4KuAqhbDveITgEk9wSrMn5/cVqT7hhVwUiN9cFW45pj4R6HKIeQdqwRmWFvY9jQhvjd+d7FSAnd+TzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYKAIJJD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b63bfa52so4055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753983900; x=1754588700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+kfkGzJlve/WLoyPW+HY4jJ87yR9ziLhY0paEWgfM94=;
        b=nYKAIJJDFQYPOW5UVTwn8YXcAtWR7qzeKgK9QlzuME6d7I6VcXyKlWki2Zuk9h3rwB
         gWpSy9r2p40bY/vOrIRClMl2W5oYBTZec69J42XvVR87IbClUKDsD8Ca0bmldEY1yWe1
         MwF960W78I2U37jWx8ZCDPb8O7wHjlvAN1+TBBEDFneBxB77kv2imYtpuAMWj9GokQTH
         be6NELJFscbbOIMc+Ix/+xz2/xBzMJVgOjZckzXN9+Z8FFaUgosH2ncGBtd79mx/AyDj
         QHN7IW6xABEOkWaSpQ5egwD6K5jZc/8QPcFPyTc+5HWT7sXgrVwj39pG+AbKB7DNSV//
         q2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983900; x=1754588700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kfkGzJlve/WLoyPW+HY4jJ87yR9ziLhY0paEWgfM94=;
        b=p6KYyZ9qE97OycfaD9z6h8Ust4NOVAz2dy5lHVllILCMq43aI41QHzHm3rNPjVSax0
         TSqYgTsGgsFx2HhIHjmIaANMCyla4ZQJK76STJgoImZVaWr9VE8hJ2TH9jwuy06Jn+xW
         ZyM5FD3pxR6iwZq02DrcJ4YHL6xlX60A4zPj51Fg0Qr9u15jOK2m85i63jPz87GCWc5W
         /nYGJ/0nTzDwUY+oLFxaIxy5ykFIGH96XFWfeKMSLN4sR10uY3N7v41SAj8NoPxOvY6j
         QO1lEBb/0OpgGzYKbLn+0vtXJ2//do+tTqb8m+QUVtPbm1gs7veChs/YHjiVBw8reXNH
         GJnA==
X-Gm-Message-State: AOJu0YxZwupm0Jh0XBJHZ+ysVem79G9VkxR9rXDRLb3DVWx86FUBJLWZ
	Tf4MJ/ZKVoy5dxbAm7YKM4EmwSwfn2vy6FCx6LnO8Os+Qg5Xm7RhSAZBZw3AD6hXqw==
X-Gm-Gg: ASbGncsVeYxlc4TU2wnf88/uW1vfZSxhq/P9/znd7QFOX8VYqVKM2drCTUZB2y0f/Wd
	N7sgys89GXCVAOzezvDHWKTOipFdvO4UsL0dtMP9aX0WVG31lujBrfR+T63wnoxuiTIS02zcktr
	AQCzwKuX2/kUTmqxZCumxfdL5DEBrv75HYmB1Qg8BdsQ0L+6t80eCSQ9RpiExvK0D6xdYHhpWft
	zkCWxYkrZW3UFrnz9MZ2UG+Iz+yfIr273GPWhvi5d3l5/uWfEKTr4ZVpDGV+D4r2Wqtf/aHD/OV
	I7pdiYYqsdwEtvat+0LVxsuVPYjmDxOLOlWb+20ioSL4eecVC4Ljj0zmZKoIsNKv/+G4CuolOxg
	xwyBjdedi7sADW4iWjpgPA+0RUDeGNFUKhMtC2OQKrRAkHaFuuI+V8QKIDatSobKNVnuyJhB/fo
	Dw
X-Google-Smtp-Source: AGHT+IG0cqauf8/W+uT6V17ni4XHUoScwT7roD06o9nChNvdBz0aFFnqL9Kizfjs0f2g6AbozeOGQw==
X-Received: by 2002:a05:600d:1a:b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-458a8fc9acfmr19755e9.4.1753983899719;
        Thu, 31 Jul 2025 10:44:59 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458981d0b06sm76559425e9.5.2025.07.31.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:44:59 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:44:55 +0000
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
Message-ID: <aIurlx5QzEtjpFLd@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731165757.GZ26511@ziepe.ca>

On Thu, Jul 31, 2025 at 01:57:57PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 31, 2025 at 02:17:17PM +0000, Mostafa Saleh wrote:
> > On Wed, Jul 30, 2025 at 01:47:52PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> > > > On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > > > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > > > > domains. This allows the driver to know which device are currently used
> > > > > > to properly enable/disable then.
> > > > > > 
> > > > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > > > ---
> > > > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > > > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Can you split the new iommu subysstem driver out please? I think I
> > > > > asked this before.
> > > > 
> > > > Sorry, maybe I misunderstood, do you mean split this patch into multiple
> > > > patches or split all KVM SMMUv3 driver out of this series?
> > > 
> > > Yes the latter, the iommu driver introduction is best as its own
> > > series
> > 
> > I thought about that but I was worried the maintainers wouldn't like
> > introducing the infrastructure first in the hypervisor without a user.
> > I am open to split this, but let’s see what they think.
> 
> You can merge both series at the same time

Ok, I can split the last 12 patches which are the SMMUv3 driver, if the
maintainers are ok with that.

> 
> > Makes sense, from the kernel point of view it will be attached to
> > identity/blocking domains, but the hypervisor api is just enable/disable HVC
> > as it doesn’t know what is a domain. If terminology is really a problem,
> > I can make it one hypercall as “set_state” with on/off or identity/blocking
> 
> I would call it set_state with states IDENTITY/BLOCKING. That is
> clear. enable/disable is ambiguous.

Ok, will do that.

> 
> > TBH, I am not sure what hardware does that. So, another option is to fail
> > gracefully if RMR exists (which falls back to the current driver) and then
> > pKVM would run with DMA isolation, which is the status quo.
> 
> iGPUs either access the DRAM through the iommu or they use some OS
> invisible side band channel.
> 
> The ones that use the iommu have this quirk.

I see, I think that can be added later, and these devices can keep using the
current SMMU_V3 driver as it, I can add a check to elide this
registeration this driver if the platform have this quirk so the other
driver can probe the SMMUs after.

> 
> > They are not random, as part of this series the SMMUv3 driver is split
> > where some of the code goes to “arm-smmu-v3-common.c” which is used by
> > both drivers, this reduces a lot of duplication.
> 
> I find it very confusing.
> 
> It made sense to factor some of the code out so that pKVM can have
> it's own smmv3 HW driver, sure.
> 
> But I don't understand why a paravirtualized iommu driver for pKVM has
> any relation to smmuv3. Shouldn't it just be calling some hypercalls
> to set IDENTITY/BLOCKING?

Well it’s not really “paravirtualized” as virtio-iommu, this is an SMMUv3
driver (it uses the same binding a the smmu-v3)
It re-use the same probe code, fw/hw parsing and so on (inside the kernel),
also re-use the same structs to make that possible. The only difference is
that the page tables and STEs are managed by the hypervisor.
In part-2[1] I add event q parsing, which reuses 90% of the irq/evtq,
insert/remove_master logic, otherwise we have to duplicate all of that logic.

So, I think it makes sense to re-use as much logic as possible, as both drivers
are smmu-v3 drivers with one caveat about HW table management

As mentioned in the cover letter, we can also still build nesting on top of
this driver, and I plan to post an RFC for that, once this one is sorted.

[1] https://android-kvm.googlesource.com/linux/+log/refs/heads/for-upstream/pkvm-smmu-v3-part-2


> 
> > I am not sure if we need get_resv_regions, maybe it's useful for sysfs
> > "/sys/kernel/iommu_groups/reserved_regions"? I will double check.
> 
> It is important to get this info from the FW..
>
Yes, I think that should remain.

Thanks,
Mostafa
> Jason

