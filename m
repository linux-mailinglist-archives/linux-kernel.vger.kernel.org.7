Return-Path: <linux-kernel+bounces-751072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938EB164FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2F45630F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854FD2DCF45;
	Wed, 30 Jul 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Oob4eaOA"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20275279DAE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894076; cv=none; b=rXfxByJHMTrDiL10hjfrvSNdx0eH1SO4bfdmXdxcsY4RqtaxIm5OQ6JsVpMD7YARmqUd199sa3NT4jkHzRBFDmBrf3hjSmjNgfBnyzRAkHP3PrBhdDM1y/ftbTGA1mPOWFGGnaEOdnaLyN+Du4Ges47Fx7HHZQDl6lln7R/KJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894076; c=relaxed/simple;
	bh=TQU2LXyowL1u/WcnoBMklVY1phcyp3eD1046ayEa83k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYTG3reYN+8RYOJnMP1c9JDh9KLpu0GLZLen/0K+01UbhUdHpVAGG47OPwUtDv96AX/XPB4oLv6TeU/OGblu2P8mIvWUVgzG9s9tnZ1fzVc3QLzCZc2xgzoeuL2XrC18qUz4vB7RS4PvHlmAxG7f29j00GriiI4RCpqRBrx19cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Oob4eaOA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70749d4c598so25036d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753894074; x=1754498874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFuG/A3j2Vv1mbEqh/G2TAhE+lxRzm1/wn84++4OCP8=;
        b=Oob4eaOAxOX3GiNVqSrFB7lJzpFnj8USHt9JSVl+pJKHHjChto8ICu+unS5qE7wMa4
         f9J6PxSGj1h372LfLf/W6EpmwWC23EjWX0XbSfTMCzsbk0KqU+gNYg7dyKT9qA3cHtBW
         pMPRlXRoglhCpLzTn3hptSgpu1RnGMCvd5XV1LMOydv78VNKDv2LHu1VGhk7ZomDjd/q
         L/cOITJxlFMhWR6Ph/JkvW7q09MUcLg7oRjEW8/jAwaWWygekPHy9cGF5uceLXbpgWdl
         oMJcp6IarQ+ijYAWt9T8fSUOybYJ5+YAao1pDO9IxJNwjJ7hNu3SWoAnM7I/08daWepj
         LVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894074; x=1754498874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFuG/A3j2Vv1mbEqh/G2TAhE+lxRzm1/wn84++4OCP8=;
        b=Q6p2RYe7TdqnHGbaPWvAmEDA4ld/u0skaEdpTqgn+R2bES3KVbCtQG1xIPvaAsL2LM
         NIhRdN+gziEM9htMWgreo5umgXCWbj+Q0EJpq/VHj+Z+Ij/1SsNkhlzu1JsNxS8IeOMv
         vuIzRp92KO51TPjah5AevLTrqJFL4WovESNm1ixXsUaoMiWri5KivI7q1lhR1GYxlT02
         uLYZHk/f9NRVsuTHLQOZSXOCLBsYHk5z9455V/fW2Goi225WlooJv/m1Xx0yWtaebKM6
         EjL1jbn2up/CmgW6L8bE1nqmxorLRP3mpFeKWcSt9XGyNzpb0qjQm5Vrx/gRZFwLgLx+
         M3ww==
X-Gm-Message-State: AOJu0YxXcYWBYsO9pOzeRjRsl5WvDpG94ORCp8w4UUWa5MRGdIpUUxsM
	pqASy7LfdegJTp0cW6Rr4TXWDoCc+ecbqp3xXY06h1kAB7HQmHxQKF48F36VPDQqHAg=
X-Gm-Gg: ASbGnctBhgClCAVSO772y3SFK6wGLCzo2IxDRDzcuUNcYnK/bU9lJRXR5M7XX/c/BuO
	lWXba9jp2Q3ZNi1oRD58RONcSKWDlizlwgi0mAhdkTGTU/zOuC0EseR05xH05XU0Pm5Ra1xriU4
	xwhmFLrw5REBWYLvI4SAr7hKousRMsQ+aGqZmRy003dLuDb4M/mb9p53Vf7WBCNSMC0Y6UYRmdE
	KF3PSd8oMwtAk5cHlfD89DID6PuyU8oxnWz4lut9n0sjFEfnt0x/4Lsa7aoVDdtZzcGJchArzU1
	3QWkDM62Ac5i+CiVXguimp8Opkm4D9FpeHwXys5hVFPBYlfnzmSHCEDtCg33s45pdF+R3F4CEUf
	Q4J7sSxVLHe68tXWiYcTfMKuIt8enbPccUvQBA+yoLKICmOkqgxOjDCriDdX3eVg2X4OTJYBVm+
	z2ntw=
X-Google-Smtp-Source: AGHT+IEYjgoPB2+hXPaGV5LTcJrEx5auyd7kyK9NRID9fF4xcgzzjcLh06XEPwQDU8NDYLbYj9Li/A==
X-Received: by 2002:a05:6214:624:b0:707:3829:d491 with SMTP id 6a1803df08f44-707669437aamr60902136d6.0.1753894073853;
        Wed, 30 Jul 2025 09:47:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c15a84sm61759986d6.48.2025.07.30.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:47:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uh9y4-00000000SQn-3S3W;
	Wed, 30 Jul 2025 13:47:52 -0300
Date: Wed, 30 Jul 2025 13:47:52 -0300
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
Message-ID: <20250730164752.GO26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIo1ImP7R7VhRpVE@google.com>

On Wed, Jul 30, 2025 at 03:07:14PM +0000, Mostafa Saleh wrote:
> On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > > Register the SMMUv3 through IOMMU ops, that only support identity
> > > domains. This allows the driver to know which device are currently used
> > > to properly enable/disable then.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > 
> > Can you split the new iommu subysstem driver out please? I think I
> > asked this before.
> 
> Sorry, maybe I misunderstood, do you mean split this patch into multiple
> patches or split all KVM SMMUv3 driver out of this series?

Yes the latter, the iommu driver introduction is best as its own
series

> >  - Domain attachment looks questionable. Please do not have
> >    attach/detach language at all in the hypervisor facing API.
> 
> I am not sure I understand this one, the hypervisor API has no
> attach/detach APIs?
> We only notify the hypervisor via “enable/disable” hypercalls when
> devices are attached or released (as only IDENTITY DOMAIN is supported)
> so it can enable or disable translation.

Same difference, different words.. We've had trouble with this kind of
ambiguous language.

attach identity
attach blocking

Keep it clean and simple

> >  - Get the ordering and APIs right so replace works. You need this to support RMRs
> 
> I see, we can’t support bypass for security reasons, but we can enable
> the identity map for such devices.

You will have a small issue if the bootup has the pkvm side put the
device into a blocking translation then later switches to an
"identity".

As far as I understand it display scan out buffers have to be
continuously hitlessly mapped. So you want all the transitions from
bootup bypass, pkvm isolation, "identity", etc to continuously
hitlessly map the RMRs containing the buffers.

I think :)

> >  - Use a blocking domain not some unclear detatch idea
> 
> There is not a single detach in this driver, we only support attach and release
> operation, which just goes to the hypervisor as enable/disable
> identity.

'disable' then.

> >  - Use a blocking domain for release
> 
> I see, I can add “blocked_domain” similar to “arm_smmu_blocked_domain”
> which just disables the device translation, I will look into, I am just
> concerned it's more code as this driver only supports a single domain
> type.

Yes, this is the right thing. There should not be operations in the
driver that change the underyling translation that are anything other
than attaching domains. It becomes too hard to maintain.

 
> >  - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.
> 
> This is using “dev_iommu_fwspec_get” similar to the SMMUv3 driver,
> am I missing something?

Oh I got it confused, you are just calling 

+       .device_group           = arm_smmu_device_group,
+       .of_xlate               = arm_smmu_of_xlate,
+       .get_resv_regions       = arm_smmu_get_resv_regions,

Which is also weird, why does an entirely new driver call 4 random functions
in arm smmu?

Maybe don't, they are all trivial functions, or you don't need
them. For example you don't need MSI_IOVA_BASE if the driver doesn't
support paging.

Jason

