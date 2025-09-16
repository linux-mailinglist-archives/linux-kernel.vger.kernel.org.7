Return-Path: <linux-kernel+bounces-819131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311ADB59BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066D216717D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D734AB00;
	Tue, 16 Sep 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecmzUe/f"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB134573C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035950; cv=none; b=Nf+coY8yFseu50a65ofL/zYBj+BhW5kVNoz+TGrYBmtRpRR7+U9/A3fIR76TEpRkXGmS9ygSqQsfs0SExiP4bNnpI13xgJZvzGI+T9ME2OXDQXVdIZE7/4IYQt7kSJ5Ba+nzMfw1f23w12cK/BwIShb6q6MsTvd7MyqxZWizfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035950; c=relaxed/simple;
	bh=wBrIPR96d1vVz2LJ9BGOfDtmnzGJiG6F6ojCH1dA+qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ2bGwcZrM2Mw6yP4yDtmV5cWiYGQKvhXy+lMgCqLCK0KJk541FW+ZaSiRXYe71+Ju1hQOWWnoYfjUK21DZzpzAigI2w6KCwKkh+Wdt+mjXUgNn5cxPRFSEJMDHBIX5gpFnpE+bWuMS6pLquLl7FyZvTg8S2b52TL0NZrRaK4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecmzUe/f; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso61875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758035947; x=1758640747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIdF/st4oFvQewvhyAv6hWYWHihkA3x4ZWjHakET1Qg=;
        b=ecmzUe/f68BjJJLhOfqS7yuw0k3omlLZUdoq+yZpg9Zeb10tzBO+62q6DxVvBNihT2
         F+u9GuNat52t7dflIwD0pD1qzhN28krZ37wE8xQCDdk7w3DXZvplbVPTyAuVc5SHoX2Y
         j2zC5sUvLlAnjoxv1aoJWwTHL7fNsCIxtVKGjugRTDy+m33paUeJfhfQ7dHbbFfaKzHc
         AMNNGbLcoSW4wxypgw2EPXQ3F4J+gjyeGVKsDKWhV8aYn9u0pZQFiKHqSUocR3YN25+a
         VDr4vOrMnCUkk5n8WLS0Vi2Gg9p9zio5b1VmFUzQ5hGaYU0QO89RrzQBaK6k7b5Mkm93
         zkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035947; x=1758640747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIdF/st4oFvQewvhyAv6hWYWHihkA3x4ZWjHakET1Qg=;
        b=T7fHAVSny+KkMGbWueOj3mvVEYOHVepxVBEBml2FgTt2Sw4SJwo6vpbUAht98DaLqK
         HcD6KUhna7UdvYPReDLOstVzwLxRtETzRUl9e1dSbHi+eaTNpezCMtCfTEjh955AABnk
         J6hMl8wEADvFJKdDM5wFTxVZWhR/nwqPx7rrER+I/jf3rUZ3OL2VJmOu9/zTHjg7Uwgr
         +WWoxmctSRTQLMHxJrlhetBzSIHxE4Gy72mGJZK0VQ6DDMF9ejYmHDa0lSyUKK8Tqkts
         +SWJCXDICgeC/0tYn849qtKXFgqeAzpv4SzLcvTItz+0w2kSFUIDAVfl00UIn7Nd4sha
         MuFg==
X-Forwarded-Encrypted: i=1; AJvYcCUevPepeB7PiYNXOkDnxWnLYo7vrRT81jDWxy2TIEHv2YMrfUMZlsPKa+dzdlNjJETgVy739nSdrhVMBOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVQNhqfXrcjLpzkkbOWWohWxk8Y7oaGpPcsTp/MuUrOOb+WtV
	VxEwbVjjMJoQvdSi1AzgdEHWZQOH5K5icsGPrdurmjruElte4gxPvxS1oXMIStgVrg==
X-Gm-Gg: ASbGncunh++SSDb+7AwK2l3F7m8GRFuarEo77mtZj7JW9OfHhUv4Lz/H+p2c6L2hL38
	/B+B7KjwqdTXpCNxG3S56W3tyJ1WP3XGBFWwodoroaK4XU85A7F36qng+vZ6qkSCVUestNVPVcZ
	ep+rccfPkLPDrOrqRJA4Rv7HaMmrVtdDxpYSh3R9dcERoYOnXWPXNSux47Cal+U+fI7cpN7MsO2
	8Fq4awmHIzKyu0hkNoJMApy6rYPYHGXVXBiTm6psGI2X1/LL5y5eY6SQ40IO/RunhMVJzwJl+oG
	y+EzPElbKEcC/Hb9hW1b5476sNNyfpDmkpP6yeinyv7dFNXaqV4sMtSy7mq8JK9oC1kCnnpk29e
	RUgbXbN3wTr8qVplk4fLyxj6to+WfkmD881NUD2AAr+bq7a1Y9IWHht0kc9w9S5Y3aziZ1A==
X-Google-Smtp-Source: AGHT+IFZBaWrZvk9P69IbqntWvXL1sAk3O+k3JpJsQacEjetwuxi2scOhS4JAiiLO+ZhfieA/FFXgA==
X-Received: by 2002:a05:600c:8b6a:b0:45f:5b02:b0cb with SMTP id 5b1f17b1804b1-45f5b02b390mr1308995e9.0.1758035946681;
        Tue, 16 Sep 2025 08:19:06 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e41b6dbdbsm211187025e9.22.2025.09.16.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:19:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:19:02 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 22/28] iommu/arm-smmu-v3-kvm: Emulate CMDQ for host
Message-ID: <aMl_5j8G3IGulAC6@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-23-smostafa@google.com>
 <aMQroI4NDu74PDGT@willie-the-truck>
 <20250915163858.GK882933@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163858.GK882933@ziepe.ca>

On Mon, Sep 15, 2025 at 01:38:58PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 12, 2025 at 03:18:08PM +0100, Will Deacon wrote:
> > Ideally, the data structures that are shadowed by the hypervisor would
> > be mapped as normal-WB cacheable in both the host and the hypervisor so
> > we don't have to worry about coherency and we get the performance
> > benefits from the caches. Indeed, I think that's how you've mapped
> > 'host_cmdq' above _however_ I sadly don't think we can do that if the
> > actual SMMU hardware isn't coherent.
> 
> That seems like the right conclusion to me, pkvm should not be mapping
> as cachable unless it knows the IORT/IDR is marked as coherent.
> 
> This is actually something I want to fix in the SMMU driver, it should
> always be allocating cachable memory and using
> dma_sync_single_for_device() instead of non-cachable DMA coherent
> allocations. (Or perhaps better is to use
> iommu_pages_flush_incoherent())
> 
> I'm hearing about an interesting use case where we'd want to tell the
> SMMU to walk STEs non-cachable even if the HW is capable to do
> cachable. Apparently in some SOCs it gives better isochronous
> properties for realtime DMA.

Interesting, I guess that would be more noticable for the page table
walks rather than the STE, as Linux doesn't invalidate STEs that much.
>
> 
> IMHO for this series at this point pkvm should just require a coherent
> SMMU until the above revisions happen.

I think the fix for the problem Will mentioned is to just use CMOs
before accessing the host structures, so that should be simple.
If it turns to be more complicated, I am happy to drop the support
for non-coherent devices from this series and we can add it later.

Thanks,
Mostafa
> 
> Jason

