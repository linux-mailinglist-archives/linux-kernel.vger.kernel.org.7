Return-Path: <linux-kernel+bounces-836284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448CCBA9313
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BDC3C201D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF1305954;
	Mon, 29 Sep 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0dIEz+A"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4A2C032E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148676; cv=none; b=Y1/zkMnyGQLQN9cfl8BC2M6AA+drNhjHbu6+a8Y6bwpX4Mbyft1qipI1zujatMzIt2bbggEsjP3cU53E9RNNkFX1MksOmv+LGhv0pfTCdcqUd8IMCKnXIg3jXmC6nDlD7UzmMmc/tZZY0T8N6YVru6zP4FJXxGuZg7Iy5L+o0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148676; c=relaxed/simple;
	bh=5KdGJe/bEGi1FhUqrPmS9UicetsUrP9DB3DL92NpLN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTFGpBv36AzimK3SQ1hjNQUXDsK8LveA/H2G8Qh2r8Hbno8aO3s4g3LNfaBhEUmoZaNJBpTaWh4WuLCkhPIX6Km9BzyGLJ6d3Rl7fKH7aSjeVf12feb9+jWZLdTELKCZR8zOPGgDtGtb6wnGSM2lfimtrEZqctTijlGtqND3v78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0dIEz+A; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso124825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759148672; x=1759753472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSFD5HCO/fWrI/TwXdCpgBbytcTu1BHw+rvoEt1zy1U=;
        b=H0dIEz+Azaw6kbE4yFx/QVAxI76ObZb8zGEYg14GG2FWi0JTfvAbcYu7yU4zTS0Uty
         PbcRxWsGeVuro+j68CUBkDuPMMiZMzqlOcqI90VZyOroGNgdtSPicj3m4IvU662v0Wmz
         3+3kwyX1MMpn3KwTl8qPWd7rKlgeB3tOrQqShiVJKO8dT3ZGQ0HbNqCItKe6F5nnTC18
         2+h+TU394vuUfyjA/VScGPHidb9l8ziY357PuMNKeb98reaL/swur5vnFMhCrYM0aidZ
         z/Q4rWzfNnGjFjajBWdX6VJ04xU5lm77PhX+tfND9EPXp3OLbwLCHrH6PZDjCs+E0NmY
         VkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759148672; x=1759753472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSFD5HCO/fWrI/TwXdCpgBbytcTu1BHw+rvoEt1zy1U=;
        b=j/7ElGC7dcYTfIaRy4ey94BoAOjHxaNvicanJNfAyjiHUBaqCROUZNL0JJGxwrbsX6
         H4HxPMJpldQd3S73K1caC0sSOwvf4caL270bv2GbHYF0pYGYQLQprW/nIVO+X964cL21
         /Ou9ROIRZqWtHGt+n9bRdnAlh/cw/s7PP5iXyG3DdUSh4agbONmChrHIliz81ssdT92v
         lc3HBaSJUh6FcRPOBDJE0iwLzADr8pqHlrc3ccz3vkrKT3U41FCUGf/ZMr9N9eMqEX6R
         0jX57mSzkGaWUFBoWKE00DtLrVEoVykGpXcSYJtV3sREFAaxv7dajs3yu2P7d4mnbVrp
         /I7w==
X-Forwarded-Encrypted: i=1; AJvYcCXMst9hw4VGC72lNjOA17qOFb+6zddCylFTZ64Zo8ll+jjKs9wBaAHl0wdDYSN6tfvJRyqZEIoZqs0JN08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEGpEPeKvK9e3flzJn5J5HkqQ7qpilBGzGUCRjsONWMetoZoE
	Q43zc+QKNjl7incoD8CU89gMCk77sN1aM8SfcL0RBe8ENvdaowCuhHMEj7pXNqKFxO0dYM6ufZw
	jXILFfQ==
X-Gm-Gg: ASbGncu+uRWyHJQHdOWGOJyIFqJkfeXoQyFqY9wblScSqyhZNkr8Obzy66bFDDBOIym
	2qJWsCEwo5kVEXB6MsvPxVY8pWsFZENrKtpGrcwTCzbGdgMdg632BX1JycjgQdiJthZeMyaTtCM
	c+fUwPGnvi6tgReW5tU6yJ8+Jrw0cdPTy1jBwyj/WtFFcR4CbtbZdch8rB414jeEmGaHRuxDejZ
	LdGBibeJT0S/td+vX7cMZog0+0QTu5A1SWL8ABAXCTZ8i8WE/K6PWCZnVqBuEyDZfMS3+qaY8Fe
	/StlNxmnnci/fpmJp5A8j3b9tRe9TNjPpwTFV3X/XUZmCmbgpSSLag/jL13rbDqhX3T3HZZm/hv
	tADAI+8jA3fFEBwley6oxNHc0mqIKVTK0jEuzbp/vpNihTxZK/GRaRibx+vk9GuyQGYA=
X-Google-Smtp-Source: AGHT+IHUrvcIjuK8K/AD/L7fltFhFhuLnwnDhrskN4yhDHWfTGxrdtG5cZIEZ2TKcQtBDbGt6u158w==
X-Received: by 2002:a05:600c:3417:b0:46e:1b09:1cda with SMTP id 5b1f17b1804b1-46e575a9c53mr363595e9.5.1759148672430;
        Mon, 29 Sep 2025 05:24:32 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm17977354f8f.59.2025.09.29.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:24:31 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:24:28 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNp6fJNoehs8hMyF@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929115803.GF2617119@nvidia.com>

On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> >  		.map_pages		= arm_smmu_map_pages,
> >  		.unmap_pages		= arm_smmu_unmap_pages,
> >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> 
> Shouldn't this avoid defining the op on coherent systems?

Does that mean we need to have 2 iommu_ops, one for
coherent/non-coherent SMMUs, as both can be mixed in the same system.

The current implementation would skip the page table call on coherent
SMMUs, As in the first patch it only sets the pointer for them:
 .iotlb_sync_map = cfg->coherent_walk ? NULL : arm_lpae_iotlb_sync_map.

Thanks,
Mostafa

> 
> Jason

