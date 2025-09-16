Return-Path: <linux-kernel+bounces-818976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9CB5990F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942B33B04DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4A3218A7;
	Tue, 16 Sep 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRJwn5PZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29297302758
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031858; cv=none; b=ndX5hcrqe+ovCAfqAEi48eHLQOhRuIK4MHzNGd4YIHrszPrH/qCK7h8ISoq5wDSgf8GCMyc5CMr/KWuk2LGBeTmkyUYbnG6VePMOalRSHCiMUwlaiggIzisVloUhEN5b5wa+Kb4q0sVkvKB2ZrygzT+/E34gl9ovDkw2rnehgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031858; c=relaxed/simple;
	bh=Uxf8MqdO1X/OQcBfHGqc0vs8bgkDRlBb7pU7mDzTtxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN5m/1/VEGAagWR8dr4Aa6vYy69WBzlOhja4A0SqTb46GcTFq42BPmbBxbZQ8KgamDnCh7jUj9HVoSeVJPni10n/Ze7S1pvBvR8bg2bssCwjqY1BsuUVwM9YaCfcfzYh1rm5vMQWS3ikOSNkhNhktDzPSS8MZ7poLU7w2J3G5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRJwn5PZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso53915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031854; x=1758636654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAXPi8+KuwRaa3qx04ySFQpznpxpBD4ALEEO3wmFkAo=;
        b=VRJwn5PZDpgmhznkb62xQpKU29R5FnyLWz3yiWq0MVz2b+HA26oOkKrtWHuHkDuKuR
         KR4tFDyzzZNKjdOm6J3Mp2W8uF0YVXvwCbpN5iEzr94ZimpB2mqz4kjI7RtWe++OexAr
         ICCvTGFUY77rC+aqK9hXl5UETI6ad1rKtkyF89JjMvf5IXJbF4QSj7SQg3HpT+SQqmm7
         yl5OMUG3zRLGmqIa40Bgs8m98JzbkSL1y8Nuf/W8b7A827Mditj+SGleUVM6QA2rAMbM
         wVslbAzKnHvEmwvFlCRLvfBAf1ocaYty0Nv9tzKWjKtPdC3xhzFfRkZawz6Q4CB78EiW
         lzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031854; x=1758636654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAXPi8+KuwRaa3qx04ySFQpznpxpBD4ALEEO3wmFkAo=;
        b=b/6SQy85Ib07LjBF6dERlo/YorjcvP+11Bk9gkUK3TgDIm1IlojZhtyDaZLOW89WUQ
         I0bda9hE20d7n99NmARHBolT1jZvsusPHho6EJ16PiTTugj1UI20dLV+OXSXGZn2GkC5
         42D0N5L/yLuMa8DYeqvM8emly3pAFP0E9Vvxy38OD9tdRdtfTjqZ7qT03eTTFENzTTim
         8YPrx5vfsBDx3taMS+PNEiRrzUFZczD9g/AVMAGT4wrDTkJ7CGzADwXKvJ4QHefLAgfe
         pXuoKT4wuKM1KcU7i7XxkyjF4OfzYXGtuQ+bGnXtjPjpMFyHYBc2c/z5bc8FaNqUtlax
         oAlQ==
X-Gm-Message-State: AOJu0YzfayBP0Pdim5E8pL8aOJk1G25atmW7TvmFotA6qaVw2T7u99n7
	+ZmlXDuIIFd2r9iRgcb9ImnIevZfZkjE5BA3lYmLFOpLYa/+RoZT0Bd4ZPxKQWr+gA==
X-Gm-Gg: ASbGncuWxuUkefCX7EFsSaYFNV89W0Fh8pCOeJcf/fB7EU4676QGayhZVXRUlvCNYQo
	mSjmkokn7IzpJAnH90EEflTalgy/gtRbpww2u3RacAkg5uMgIF6ji4WWrQr/C7vck+hOgDJKWEx
	dAJS09MOzl8NkufiM9aX4IokvIIbH5XDPcpZnbkoLxC6JJvrLV+j00F1lPl7pZWWQnkZmopVa2T
	IkK2taf+0etoB5J2RoZc3d6X5bus2ZAqGovSeuPMabhpAUbt8XzKJ25aCwlICGqNuHbTvb6VD95
	pUv+/MOo2iR70xj5tz//sNjop0dHALkhyqJtTchtzzAUie4t5teQ7Dx6QcRoj4MYlun/f6J8I0s
	SVXfc+oRTjNFxA0DIlyUFPGAgTlarC3UGveaq+j5rqSypHFjFZaGBx/mw7LRVdMWCxJoV//LnXK
	0guKBP
X-Google-Smtp-Source: AGHT+IGcTe1ECO2GamWj51rf4zuyd3cbzaJnBRpBuslk+LBrCQjMJhqgUMk66hHXtNsu5/Krbmp77Q==
X-Received: by 2002:a05:600c:3b85:b0:45c:b4fb:f0b3 with SMTP id 5b1f17b1804b1-45f3278c3admr1396305e9.3.1758031854210;
        Tue, 16 Sep 2025 07:10:54 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c9d91sm219090395e9.20.2025.09.16.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:10:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:10:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 06/28] iommu/arm-smmu-v3: Split code with hyp
Message-ID: <aMlv6rLaZ80j33OV@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-7-smostafa@google.com>
 <aMA4UpDgLDuiGYf8@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMA4UpDgLDuiGYf8@willie-the-truck>

On Tue, Sep 09, 2025 at 03:23:14PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:34PM +0000, Mostafa Saleh wrote:
> > The KVM SMMUv3 driver would re-use some of the cmdq code inside
> > the hypervisor, move these functions to a new common c file that
> > is shared between the host kernel and the hypervisor.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
> >  .../arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c  | 114 ++++++++++++++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 146 ------------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  44 ++++++
> >  4 files changed, 159 insertions(+), 147 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > index 493a659cc66b..1918b4a64cb0 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> > +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
> > -arm_smmu_v3-y := arm-smmu-v3.o
> > +arm_smmu_v3-y := arm-smmu-v3.o arm-smmu-v3-common-hyp.o
> >  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
> >  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
> >  arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c
> > new file mode 100644
> > index 000000000000..62744c8548a8
> > --- /dev/null
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-hyp.c
> > @@ -0,0 +1,114 @@
> 
> Given that this thie is linked into both the kernel and the hypervisor
> objects, I think I'd drop the '-hyp' part from the filename. Maybe
> something like 'arm-smmu-v3-lib.c' instead?
> 

Yes, that makes more sense, will do that.

Thanks,
Mostafa

> Let the bike-shedding begin!
> 
> Will

