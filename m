Return-Path: <linux-kernel+bounces-750957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860FB16353
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703D7564B00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F852DC350;
	Wed, 30 Jul 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVJVlSNY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD12DC323
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888041; cv=none; b=TtaSsccr7ApiG5kvUtmiwskThVDuiTQf6pMFJNgVEijHLG5hWG8JGvHWQgsqIzPcG2n+5SxGgjkloCC+Q2xqsLZxXpG3382MJRT/pXZpSaM+18a+5+cUfkXtRXEff7+P7Jbgwmaw08DyqwC7b4vhTxpA7znlqeOg1+lyiSvOT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888041; c=relaxed/simple;
	bh=dCek+LVoEASGAo11jE4aq2PC6g9GeAbOlhCDXCoh3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUa9YBOlVoQuch0UwpS3T5TBmqNi+JgxcHyttO3cX+Bl7imtaURQvAz+hlwG1ttukIexRxaTFOu0GWqu6a+3pQtsCEOkO5TJYxiVImJUYNYp4I9NjLCB61khHWmWOpgNvuCuiASRkWCj2zm+VLtWvmCF8cl1FUWHcJ1h3lEFB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVJVlSNY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so87435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753888038; x=1754492838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwnA2oNKgnZXUtMiDazVBO1hROK96MeArFT9225UuGA=;
        b=gVJVlSNYcE0ivhJ79VdJkcgimNrlCV1PH9kbLGutoXOh+YgvwewuRcBwTZqR4dvjua
         4bA0x88ROj+fmOrmKBae6rBqFAWIMufAe2lkXGQUH3PCcoVFWV4MkohYRnOjiTC9SZlw
         L2SzyW9e4omuXLjtLUwY2/KXuENngMKSTWWbunJyqx2GKw0aXseZfxBIDB7BtpoUMgBL
         aWYETOxb9dSBZObMEcLjVNYlzwuW+jB8LoyGqfzlurlerxN9fZzaYBxQuY8HEL5f9pYu
         I5vGqoIOpgVi45TOPMCMH7hzFPRhzXFyxQzouvpc9WsdASmPjNyW5Ryu5hTwo+anGz9A
         aLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753888038; x=1754492838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwnA2oNKgnZXUtMiDazVBO1hROK96MeArFT9225UuGA=;
        b=hMfM07Gt5R1bCxcRltcw7lRbyawTV+7yYc1jfAdQZHquAXcTl1A71XlBOWGDclMMfN
         M951b5wVlpNFzknsO+NrZaH3ox+Gvbsdx04vYQPtXMfYxUned66hd53VJ3aHNLUZ5bE0
         hvPNnNslQG+mqg2y7/W/oLPdZYbpvsH/jYGapNDzM8FjeD71N8MOGx1ObYz9doNMHki4
         ipOtc2MQhRznkcxy+hMAXpkX27CrruoYu+FLoAV9fVdwdwCgYoSKybCqgYjqO9/KhlgA
         4APhpGaR/ze9HABsPyJHdHjSDkP/ekQEJ1WShpIZaTTe7HBQbVSy4r4H1/6eSIM/Yu+d
         2K/w==
X-Gm-Message-State: AOJu0YyHmg0pfPiDZUGN5XziH3fM6nb3G3rVDvm+RxveNkvCGxAsKNHP
	bLz+4g1pxSLsgVXnX5aOIFbEqO+64xyJOTW9BsYO1Lf6LkMpOKWgErF1OmHkqND19g==
X-Gm-Gg: ASbGnct3MMsukgJPdKbaT6LuS2dC5VlmrtyPKzBT1wF2WHnaDusmwtcvaRIGAL5hp5k
	U9ssWlrD6MzexqsnMtKUZRmhWhaOAwFZYbwYyXWhcdT3rhnucnwL7KXA2RSY8zEUjOfkgjkTPec
	H/PjCZ4sxKtu1gcNYe5uhsWF/XqCdvTke7fWy61r+G3TmbAvaE1mJmN+mEXQx2pWz0+civZbEDV
	cQuG6PZ3FwtOwGEs08lRi7uPZfLWMhoAgyeJGS9hTWMUlG8WArq5T0RpBupgd3dZ9eE1l83GuzX
	4d0ljoQWGLlseP+QpW+QqQy0E3rvPfxZg22JT+JpaiXIs5pIQYYv/a3uGAm6VNJuBkQHuV7yfDr
	pTE+nJKxwn+fGbXDxlctJSqrCQgPt+oTp/529rK0u9+gM49R5T6+rqR9VFnwN/5Ajw2Tc
X-Google-Smtp-Source: AGHT+IFXd4tj1Gi+aSqsAPlyaWZo7LbAx7OS/cZ5blys8+9sDywLpzMvfiK5whFAaT6QiTiBqgdEJA==
X-Received: by 2002:a05:600c:8b66:b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-45893a978a1mr1755975e9.4.1753888038295;
        Wed, 30 Jul 2025 08:07:18 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588ee11c91sm35868305e9.4.2025.07.30.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 08:07:17 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:07:14 +0000
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
Message-ID: <aIo1ImP7R7VhRpVE@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730144253.GM26511@ziepe.ca>

On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > Register the SMMUv3 through IOMMU ops, that only support identity
> > domains. This allows the driver to know which device are currently used
> > to properly enable/disable then.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> Can you split the new iommu subysstem driver out please? I think I
> asked this before.

Sorry, maybe I misunderstood, do you mean split this patch into multiple
patches or split all KVM SMMUv3 driver out of this series?

> 
> This series is big, reviewing a new iommu driver should be done separately.
> 
> Please review all the comments for the verisilicon driver, I think
> many of the remarks apply here too:

Thanks, I will go through them.

> 
>  - Domain attachment looks questionable. Please do not have
>    attach/detach language at all in the hypervisor facing API.

I am not sure I understand this one, the hypervisor API has no
attach/detach APIs?
We only notify the hypervisor via “enable/disable” hypercalls when
devices are attached or released (as only IDENTITY DOMAIN is supported)
so it can enable or disable translation.

>  - Get the ordering and APIs right so replace works. You need this to support RMRs

I see, we can’t support bypass for security reasons, but we can enable
the identity map for such devices.

>  - Use a blocking domain not some unclear detatch idea

There is not a single detach in this driver, we only support attach and release
operation, which just goes to the hypervisor as enable/disable identity.

>  - Use a blocking domain for release

I see, I can add “blocked_domain” similar to “arm_smmu_blocked_domain”
which just disables the device translation, I will look into, I am just
concerned it's more code as this driver only supports a single domain
type.

>  - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.

This is using “dev_iommu_fwspec_get” similar to the SMMUv3 driver,
am I missing something?

The driver only save the "struct arm_smmu_device" in drvdata, which is
exactly what the other driver does (which allows us to re-use a lot of
the code)

Thanks,
Mostafa


> 
> Jason

