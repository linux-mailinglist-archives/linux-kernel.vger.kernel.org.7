Return-Path: <linux-kernel+bounces-752254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE562B17309
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FB47B3581
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53413C9A6;
	Thu, 31 Jul 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qv+wAlkr"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504D6DCE1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971445; cv=none; b=Xecp+zI7t1NF347VfwoEtJrQPWDpiyatuCJ1O3qYWeCMK++2kbTp5xDB+/h8Gg5CCSnjdvV+StztuF74f17Ked9okU6dNnxuFIZf44ZB5dN4S6et/c5VU6F4kdc5wgpDBtysRnHhGdW/irojUafv7afuZ6dXJ5FS8HpIjb+4Hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971445; c=relaxed/simple;
	bh=E1Mr78SFe7OCoQAaZ7NNFqP+kLbmSKTZ7SjbzvGIat0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHctSTa3q6IbttjJ2rQ+xDaw2rphJ5pAbWbNOkw1LRStdyECeC0EiLY2hL/MQx+IH7MiBTA4HNrjoZt5qn5JLPJPQnm4pkTKli9FEXi4iieF9Z/EoKG43LVxfhc5mSmpyMHe6Zln8/91vflp+ucTHxZL8Rz3BHp4mCmTaauoB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qv+wAlkr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so83245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753971442; x=1754576242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcWB14Cn8mezh693QdjehHNThSsfRoWZAjW9od9JFCc=;
        b=qv+wAlkr87SE7CITKoFiYE09wBDhV/ErGu6620XjE/dVAMaSAON4Z8o3vDcR/8tgUd
         Du2gb5cx6xazykB4jFe7qDt6R4Rywi8WLD5PAShrs2oe/3nlYEoo0FMgwrDbDaNh+4nf
         P18LB2PiuEzyVJmWELPVMs+MW9wct0eyVJP0SjrXulUDmCcPiHlcEbpLA49lJAwxlpW1
         ekuGx9geB9k1fT1wT81gXs5jYM3Ps+dOQHRF6REG2bvItytccSBLiYzmpdzGrI/vfbr/
         cntv7/B2jb1KnUp0iNoRL3E+aB4vaxnnvgYhG3YPU7u2JfRW4WFk3lxAmRcnkATsbefk
         Xyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971442; x=1754576242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcWB14Cn8mezh693QdjehHNThSsfRoWZAjW9od9JFCc=;
        b=GNetUCzvU50AWalIzVPeTXM9EYAq+f2vurRCONCwCJe0pSDLHPmTaljhwDNdCG60oZ
         Mh27nnWUfv3CEqElYDyXCGzoxccaVr9af3PC8vG54jIJXS3RUyb34z6upsh7q2lyZR8+
         17suatPq23+nDq+5b7MFmOM5+AK3eSb9bjwO17zV+X+sMzppTVJ7bPhahafHBYj+nbCX
         sIPJ2MqCbT2v8cdbssN/Vq/X1igWbHYhrwXXXr9eceltU3wTgjZCB8akFq2nMx9MUHNB
         MWnInUU+n1j2XGCaGLFF7e8Y+ga2+wqU2wBPikdxLE6odG7kGfsTS8ynHG9CR/QzdmBf
         fdQA==
X-Gm-Message-State: AOJu0Yx5PLv2ztaf+eGVN4lIN7eK1aQznsISGPMe6VxdFHULqycq0evA
	YJSL1mVIpdQ15VPGu88BZ3XYfJhBJ4ahBba+xi4gSrGhOJVEkxuOspuw3RHpLvWmTA==
X-Gm-Gg: ASbGncsrb0pjpQV1/R1zFhQzBIHynAL671JGhn50AkXDNbqQTCP5839e5Wj7solpbBT
	NLGRuP6V2xWGngXn77DLOA6VDQA1xI3327Tf6bbDHs9sI3fcPp6Zz9NFGjGPmQOoD4ynqIwDna1
	t6KYWqvQhh7SHs4jTDWqdGpm7hhoGhS6sPidmrutJhnW524qJdY8BQc247D2fdIN2JB9ijedN1U
	qK0tjYITrAkTLpcURB64Zk7WHxgNKrLi3gt+gj41EBhEUfWsR67kJKB8YYGk9BlH/zsDtADIcU7
	nwdeKBVwaQdf2dmdtVAJ4yumNR/OK0UNZM7yL//xq0lhKQCqacM+6QOstqeQYJhtrMvNIfe8IsL
	H/XD/HP7cpKIKQHOF01GzeofDtNiMXp9G7pTsCyxtopg3eCR8jh313mLzmmw4YuAZpA==
X-Google-Smtp-Source: AGHT+IHQna8PBH+0rnLeEfLwPLu5VSthuOinGeMrMZmAiA37gK//dxUBEvZYVDk/z0ZzOGHZAGlqMw==
X-Received: by 2002:a05:600d:108:10b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-4589f38f199mr1003195e9.4.1753971441527;
        Thu, 31 Jul 2025 07:17:21 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0d2sm28100345e9.18.2025.07.31.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:17:20 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:17:17 +0000
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
Message-ID: <aIt67bOzp6XS_yO-@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730164752.GO26511@ziepe.ca>

On Wed, Jul 30, 2025 at 01:47:52PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> > On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > > domains. This allows the driver to know which device are currently used
> > > > to properly enable/disable then.
> > > > 
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > 
> > > Can you split the new iommu subysstem driver out please? I think I
> > > asked this before.
> > 
> > Sorry, maybe I misunderstood, do you mean split this patch into multiple
> > patches or split all KVM SMMUv3 driver out of this series?
> 
> Yes the latter, the iommu driver introduction is best as its own
> series

I thought about that but I was worried the maintainers wouldn't like
introducing the infrastructure first in the hypervisor without a user.
I am open to split this, but let’s see what they think.

> 
> > >  - Domain attachment looks questionable. Please do not have
> > >    attach/detach language at all in the hypervisor facing API.
> > 
> > I am not sure I understand this one, the hypervisor API has no
> > attach/detach APIs?
> > We only notify the hypervisor via “enable/disable” hypercalls when
> > devices are attached or released (as only IDENTITY DOMAIN is supported)
> > so it can enable or disable translation.
> 
> Same difference, different words.. We've had trouble with this kind of
> ambiguous language.
> 
> attach identity
> attach blocking
> 
> Keep it clean and simple

Makes sense, from the kernel point of view it will be attached to
identity/blocking domains, but the hypervisor api is just enable/disable HVC
as it doesn’t know what is a domain. If terminology is really a problem,
I can make it one hypercall as “set_state” with on/off or identity/blocking

> 
> > >  - Get the ordering and APIs right so replace works. You need this to support RMRs
> > 
> > I see, we can’t support bypass for security reasons, but we can enable
> > the identity map for such devices.
> 
> You will have a small issue if the bootup has the pkvm side put the
> device into a blocking translation then later switches to an
> "identity".
> 
> As far as I understand it display scan out buffers have to be
> continuously hitlessly mapped. So you want all the transitions from
> bootup bypass, pkvm isolation, "identity", etc to continuously
> hitlessly map the RMRs containing the buffers.
> 
> I think :)

I think that would be hard with pKVM, maybe it’s possible to achieve
that seamingless, we would need to export such devices to pKVM at
boot before de-privilege.

TBH, I am not sure what hardware does that. So, another option is to fail
gracefully if RMR exists (which falls back to the current driver) and then
pKVM would run with DMA isolation, which is the status quo.

And then RMR support for pKVM can be added later if there is interset.

> 
> > >  - Use a blocking domain not some unclear detatch idea
> > 
> > There is not a single detach in this driver, we only support attach and release
> > operation, which just goes to the hypervisor as enable/disable
> > identity.
> 
> 'disable' then.
> 
> > >  - Use a blocking domain for release
> > 
> > I see, I can add “blocked_domain” similar to “arm_smmu_blocked_domain”
> > which just disables the device translation, I will look into, I am just
> > concerned it's more code as this driver only supports a single domain
> > type.
> 
> Yes, this is the right thing. There should not be operations in the
> driver that change the underyling translation that are anything other
> than attaching domains. It becomes too hard to maintain.

Will do as mentioned above.

> 
>  
> > >  - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.
> > 
> > This is using “dev_iommu_fwspec_get” similar to the SMMUv3 driver,
> > am I missing something?
> 
> Oh I got it confused, you are just calling 
> 
> +       .device_group           = arm_smmu_device_group,
> +       .of_xlate               = arm_smmu_of_xlate,
> +       .get_resv_regions       = arm_smmu_get_resv_regions,
> 
> Which is also weird, why does an entirely new driver call 4 random functions
> in arm smmu?
> 
> Maybe don't, they are all trivial functions, or you don't need
> them. For example you don't need MSI_IOVA_BASE if the driver doesn't
> support paging.
> 

They are not random, as part of this series the SMMUv3 driver is split
where some of the code goes to “arm-smmu-v3-common.c” which is used by
both drivers, this reduces a lot of duplication.

I am not sure if we need get_resv_regions, maybe it's useful for sysfs
"/sys/kernel/iommu_groups/reserved_regions"? I will double check.

Thanks,
Mostafa

> Jason

