Return-Path: <linux-kernel+bounces-730769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD57B04993
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C671892AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D9246BD9;
	Mon, 14 Jul 2025 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H64NFIs3"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCF27470
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528871; cv=none; b=WFs9QlQqwOPPEm8Mi+mhPziP4SR3X9ZxFEI9yka+GmLe7tjuy4i/vQx3z8s6VMobQOzbH+kO7MTFs47M+NwcdW8arC0FBvxX9wBO2jNs4W6mN9LXudocrmPm80nQTOWwKSBjODyUdzKDJMwK3c+5EaQgzgbR8QX6zRoa52EKmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528871; c=relaxed/simple;
	bh=BDSxVNaH7DxXtXg4d8lyl7WfXKs0R9S9LaI79MzV4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce6SCgu5XpUva9FV5X0yKOoLQI6QcftLwlmD8FGgwruY4pM0Vdh4+4t6bnR8dljrcdlgO2SEmXx1s6hYtdiTa6Ow77nQup7UAhaF4t4qK99rl2dVqniR3gLoDHp/j0+OQfM6/y7wNkeBuugyXNvxLvEyXf/Vh+prRSR6smdyNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H64NFIs3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7dfe2339eccso307763385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752528868; x=1753133668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjsur9DLBO9lraNK3jQ4gyxveT6GDJ/WoDBpZ+ezdw4=;
        b=H64NFIs3xudhgaJn2FeR9ukD/krnO0az+jjDzGbWA72hxRYd0nN8hDOKW4Z7lUZYo7
         40GIXHLOO03/35TnfA7i8poYK2rpRxCWSYBoMmdE0YVB2pCaHWADT77KrwSvkT9vU79+
         dGqyE7RbOOGPPE/K5G5T1Rs/Go3hydhUIJazHMbDAB1UEjqMVKHZo8FOtqOLVHKeoYBE
         S5IW1ZmsD3Ay2ycaxcwhmQMkmeWKeCKFn7RpfmXgR53pDkuEne237g+kxlHDeNloDJK1
         B304JzitB7cbZG+h4AjLPcIvgk3kwGhpCoicnHEXzn8PtAMebPe7JHg9RgCnZancNB5d
         V/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528868; x=1753133668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjsur9DLBO9lraNK3jQ4gyxveT6GDJ/WoDBpZ+ezdw4=;
        b=kifuQ6hmNrzxQjFQCtnuIZ3yPyfYP5mNQXoDDslrAU3Q2FUPc7/vgxYGDPzKm7wY/t
         aiWeNoLKuAV7KJDZLgXyLVvVjA3WC4/PvpHSF3Z+8YN4i0op5f2Wq+IhMtN+hsDxHYcD
         McLV4v2A9FjFrWCgRfPlJ7emwDtFtGORVvXMHSwGCLIYu3MgJHHCzYRGwyS3f1xR2DTz
         dMumMUtAAObZvBXcXdHRiTIx9b5FCrMbAcIRnQuhcnYIwwxpJup7bxlrQXtTVfumMKI8
         A1uwmJgs7wip7PBKouPgfh/K6YYvceyGZaEzEkV9ITddyCt8Yb7+9DgrpXyiP1r/MEzl
         /i+A==
X-Forwarded-Encrypted: i=1; AJvYcCV38/VXe15HG3AK8R7HilSR091gZo3F2rqRjylyPS6AjeSSsB7YumdXZG+m+v1ttBGLS2XRln9KplRGdPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFum36t/VT8OZwawdiGT18jlRD0G0kjayeulS4vpVl2mvkSlI
	5KOWAzGG81WnB/HQU4Z1Q+8IoEJPK0MKODVYhp6ippY2rYYG0Ce0TRx7YfegbJRsTYw=
X-Gm-Gg: ASbGncuoTSgQxufH/GI7wuIl6AHNF/uiDAw6sFpOWkpKzQbj3ZWCV3Kr9zos3kTsRGz
	e/73GQEGRHHuSiGY02RmXFL6J3be67YpaZglEpazLrN3fU4ZmOOA6owHrdNleAeCcQLuzKpIwn7
	Kya0Lhobs1ksJYbw74wBHar6hazSdMacdIAh0dmqNyjnvKbeQ1MC5+ZUMFxTxrJ3hb2GBX1eEfS
	EFvMXE0Y+WZNykRpNXHEeV9qxMNr76FYIANaWdcG2kGdFCoVThgb/TNGfpO5eu5SpuCZQl2tOED
	CzngeAAMraf8dKsBNgd90cVz+pgsfFP3NhSNrlyxmMfBfxNC4qPuQggahkn86tITVCVpTwNTAqL
	i/NAb/CrUvz4WSO03K1y1hbFOkCN/vU9mEuk9swsOycDVHBkzH0XRsNIGhH6buwhevdTwbRnRLA
	==
X-Google-Smtp-Source: AGHT+IFEx3lCJSamFS7GtCIM3DJJbVlIj8bmcaZbUD5CgXC67a7uWIwLe/hJ3o7zuNw/2yCru6JygQ==
X-Received: by 2002:a05:620a:20cf:b0:7e3:3682:6dee with SMTP id af79cd13be357-7e3378dd518mr183144785a.4.1752528867626;
        Mon, 14 Jul 2025 14:34:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3357a2f85sm57242685a.14.2025.07.14.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:34:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubQoc-00000008jqs-0p6Q;
	Mon, 14 Jul 2025 18:34:26 -0300
Date: Mon, 14 Jul 2025 18:34:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Nate Watterson <nwatterson@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra241-cmdqv: import IOMMUFD module namespace
Message-ID: <20250714213426.GJ1870174@ziepe.ca>
References: <20250714205747.3475772-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714205747.3475772-1-arnd@kernel.org>

On Mon, Jul 14, 2025 at 10:57:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tegra variant of smmu-v3 now uses the iommufd mmap interface but
> is missing the corresponding import:
> 
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_depend from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol iommufd_viommu_report_event from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_destroy_mmap from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_object_undepend from namespace IOMMUFD, but does not import it.
> ERROR: modpost: module arm_smmu_v3 uses symbol _iommufd_alloc_mmap from namespace IOMMUFD, but does not import it.
> 
> Fixes: b135de24cfc0 ("iommu/tegra241-cmdqv: Add user-space use support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied thanks

Jason

