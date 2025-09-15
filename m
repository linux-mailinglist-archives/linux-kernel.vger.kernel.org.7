Return-Path: <linux-kernel+bounces-817445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613C1B5824F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB72A3B8703
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F7279359;
	Mon, 15 Sep 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pR69w2f4"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6727877D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954342; cv=none; b=InqqrQMMryZigo428lWZEV2+sqSVRJIbG6wNQaGsPwlMU6V+uerHNsPsHqU86VrAsknxgMkm9+GFBmDNGegyZMQq6uIlKr63hgnMtdas4KlZSrxRBOheN08z/kPWnAMKGtMN8iLB4fDsBDEH2IDI107am03cRpsKmhZmBa/3tos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954342; c=relaxed/simple;
	bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt5V9LD/vzlcw/EV2kGkHcc1CGd8IIokkL4kOrA9PuCh61pXpBzHV4wOH/LWo3e/YH8+wtmKyFGkZaBGK1rhsoGY2CXSlnrQQDABqQtZ9CcWwUFicpr8Zt575/hWRHD68zBnI/Uu26fVqlIlNDd8eOZItRfBeQKSOPnSIrX9auI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pR69w2f4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5488c409d1so2876787a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757954341; x=1758559141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
        b=pR69w2f4ERBWPUvmBAcanK6KWXnwP8mTBzrThmB2TovBD7WP20ZcY6FLAVO2lv/XcH
         dQZ7n++uSXJQ3yRZZ9aj2z+ubwvTHUymgNHzAh5F/CTjSVEhGzOMeHcNw3Yhon0TnR7v
         ob6b7vz+BX4t3XDHI+BIjyEhkam5iWDdKfFPy+Nrki8Kxc7aap5JxbY9O7qg2i084hDs
         +r0QntE+imoImixAR70rHl9kUjuchA+t2LlXzjLGvL0GlcAmNXusUolruxqsPGXYS/QM
         Yeufv1G1atp556t2uD3vZUi2gHbxMt5CXad5iujRpabH+g5YAm+Qo8GdRTzfAZZQ4J0m
         7+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954341; x=1758559141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEs4pZ5z6UV6DIBPa4q4aPt9EKdlHVU1+3WYy5ax+Bk=;
        b=FRHFXDFiky6opoVI9rkS5nAj6SKssZU3/ZWX0BXFvL84Edav5RRDvNqZ0kvBjha1h0
         QgiIA7IR7PkRUN+HPIJcJ75xgIRBv+URHRJ0/QWvhteBGepjbvXl1X9KAW+KQCuGv5pl
         7NUswPydKmcHuLPmMKrF5edzbmMqvhu0ayGJOdpm28ZYXoBVLzMufGfvIT4xu0ePZgtm
         4pqbysG76OM4k9eMtj1orgJcOcnJCnQ63gL+mVQbcsDrkcJSFNvtw7T4Zo6jhwwxaytb
         9rAgVdLYn74WSCsuBY6y7M0koZoenMEOloij8TUbqB4EdJ3d7N9uqCb/cBjRXl/eug3Q
         yt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV10Bfk0VacZGnLer4kk8yHbavN6b926C6UIeTJMi/adQmaftMTArtzIwvjCK0/e3t6DkvszC5nkbyr0bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMieJuOR27aBurFjz4VF1/m97hkKpyLyoeP+TanSfgd3GTmap
	0CM49RTUY+6OvZ2Kl7PcD7b0IG/IvpNBpLXaaAQGyZFzg8GkgH1EHOJzj2TkAFaktZE=
X-Gm-Gg: ASbGncsDiniuewYgCKik88iX2cgcB15oSNytRhntHM2A+WB3EiAojY1QJ411reqf69M
	TQeh3fzX7DKHWVQ/MyhXQH6iNpawnUaOJ9oyvHW/d4NoAlKSbMilu0FjJTrHe2+iE/mAb4jl782
	wC68MphN8fI3J8NgatMx5l1OWz4qD8DKnVb/gHRn585wSWBb8SEi2WPhSirAG4r+kY3M4AocLSU
	t+Bgu8u9Un/iuwjkbtNUxoYPN6qMHbKvyHxkFuAcU4PyhC2PffZLCuBMngKd3iAH27z2I3xuhFk
	YywSbKu58Qw99ss588uwnnTr2CtOn6QTDpYb4nov9K8pCtn7PdOHli4aBKNKDat+iaQhGztR
X-Google-Smtp-Source: AGHT+IEq+05CDclx85E3rLT3itHmH/cfmy9YNLof0QbJTkKIbzLS8n6ulerDKoJUcV6j36ozIpBilw==
X-Received: by 2002:a17:902:f693:b0:24c:e232:f92a with SMTP id d9443c01a7336-25d26e47c1fmr168980405ad.44.1757954340679;
        Mon, 15 Sep 2025 09:39:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a61besm43370025ad.53.2025.09.15.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:39:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyCEE-00000004THo-3rBl;
	Mon, 15 Sep 2025 13:38:58 -0300
Date: Mon, 15 Sep 2025 13:38:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <20250915163858.GK882933@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQroI4NDu74PDGT@willie-the-truck>

On Fri, Sep 12, 2025 at 03:18:08PM +0100, Will Deacon wrote:
> Ideally, the data structures that are shadowed by the hypervisor would
> be mapped as normal-WB cacheable in both the host and the hypervisor so
> we don't have to worry about coherency and we get the performance
> benefits from the caches. Indeed, I think that's how you've mapped
> 'host_cmdq' above _however_ I sadly don't think we can do that if the
> actual SMMU hardware isn't coherent.

That seems like the right conclusion to me, pkvm should not be mapping
as cachable unless it knows the IORT/IDR is marked as coherent.

This is actually something I want to fix in the SMMU driver, it should
always be allocating cachable memory and using
dma_sync_single_for_device() instead of non-cachable DMA coherent
allocations. (Or perhaps better is to use
iommu_pages_flush_incoherent())

I'm hearing about an interesting use case where we'd want to tell the
SMMU to walk STEs non-cachable even if the HW is capable to do
cachable. Apparently in some SOCs it gives better isochronous
properties for realtime DMA.

IMHO for this series at this point pkvm should just require a coherent
SMMU until the above revisions happen.

Jason

