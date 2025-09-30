Return-Path: <linux-kernel+bounces-837833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBFBAD5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297093C5AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93293305040;
	Tue, 30 Sep 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBYPUi6E"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299018CBE1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244172; cv=none; b=lpvvMc8IhrPEurmggadxarD4hjtFuawrewti/3d5Tm2c0YOFrYr81k03uYO/ib/lOvUSc4p5QDC9e41SRD9luQ9zTiFKXkPSSqN+LuUqpu3jfSFFUVLYvzF8ploH/cBVSlI6kdK2RMyVRr4U5jMUFlnKimdKu6SaXdGv9iZLQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244172; c=relaxed/simple;
	bh=F+2PpfgjzAxd5eTgzmtA9811HRwzmk6SihyZQnBi8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax3iKbecrsbQGr2uuy4e0dDeRRAsGJCf7EjtIiq5u8M+p/WI1g71D3zJdOyXJftcAjJmC0s45i/VcVDnykelHWXwv8FxkzibEcipRk/rQuPK9D2Uk1EQ3y13dpVDZftJCKAui/E1NS6n3/HJyTOyEbiCYkxKImlWFmpsOK0hvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBYPUi6E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so260615ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759244171; x=1759848971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4R6lGWGAQ1gnxosb2gwPcgs8a9GrC1uXsCsflzO0H4=;
        b=OBYPUi6E8y4lI7zAC+FJAJkHgI6f3aSBiz+AdM/hmYzLAASr0XjkU+WULS8WWDJvKt
         sIPoZppSmw7wCP48BmPHetBBdYVM2LXa3Z1MfXS3y0qsjjfNXd0huqhkrUr6nihTmemY
         YexKG8ZSUx9x/6H1DD0IaW/xUl0n6lVnwVUq9HeWc5I+H48z4SW8QwuIW7wMumeYY3BE
         Bfk9YiMdL2jwDyjYoMj/TnszK+M4KezLHQloUIebG32b7e//SAqD4MkJsBj7Q1Ck+Dqa
         iRlP3SlybM200lBtOtdl5n+d8uZzRgKTNBZN+w3s0IpZbU78ihTOHrWkybWxnl3HcncK
         CEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244171; x=1759848971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4R6lGWGAQ1gnxosb2gwPcgs8a9GrC1uXsCsflzO0H4=;
        b=D1FEe/dXhLnxRXtbhioKV4HqTnTRGQE7+dKhICEXkp+ZEOj9GwVpIIb0mkfwGIalrQ
         gQk1sIQfUsplqKNsJZtdwO5sMYq0FIEMqWS7e4OjrjcEpVUiFX9oKqoGWH0VUklUSsIo
         Ccdx8PGy1Aucx/5LSyFGuKTo0HGyaJxyny3sZ7uvg+jZMIjGis10djgTi9zgPZdSFia+
         /gCGm/HAL3tsCXI7DApgvZt78eK6E4GBLoMTScv7MiiX/QJ7hkxfGh9hgyiSvlC08fst
         BXogsBwKK0k+8xtOy+K/5umqqH8ylXWR4adVsO7MCYf+fYZE57vzeQiyNmJk9yvQjur8
         FAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkJqAdDta4livsFD9kcC2HlckYkOzoaqu+7zLXjAkOTysfsNIZa0OmussK0B8yVIBPbDumlTNAdNvrEE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MUFD3VqsLUWm4qT1riDk7TPLASWHco+7TGzGfbEjgX3iMzNv
	dHdQLAoDFbDQrryI4CRJyDJZMVXNaGWSDyUdL9DyB+/MiAngDFghEpEF0c/L2rQaUQ==
X-Gm-Gg: ASbGnctDh/VZBNIOZuDZ5EU81WPl9UqPJdgSioQjGLf3bFCQuTTXkzmNBozSnPY0P83
	O7HrFdP5Lgi/3hCQbD7bGFu0WfeH5eSgZFn8V9JGAFtpQZyDItMA0JcKfa2OedGDeQqEu0McWrN
	kXFU444KqB400m+/id7IhLOCepBpYvw8O2S14Japp+SFjmb+9JJ4QNz9LRLdV9VBg+pXNxLcUmT
	RR0Rd57J2yP7UUnkMKZpHRIE9LNrHJhbMCrQa4r9BE5dWPed4KE9q37Eg4dUohqpeXJEwC2Sf+F
	Sn/RSqUeGKVLNg2/U7BF+HX7FLk5b5tLLZy8IH5ecmbySvW8nrth/aCojP04OCIKBCY01vd9sNo
	YMUW1UMm47atlyow9IBfmEWRdXN4jAv9l8P3V9KT9QN/NUARDoDitbmdL8s2MIAtKuL/jmjG5jD
	zkYgYdjqt6qTNR8kCuNCElpA==
X-Google-Smtp-Source: AGHT+IEKto9Z/ZQPK+LiszayWv4jowiWlKBwakXzvWFsQoNBQ3FBBuXDg73TnRLqqEz8s/+/yr7S4Q==
X-Received: by 2002:a17:902:f64d:b0:28d:195a:7d77 with SMTP id d9443c01a7336-28e2f8a16e6mr5318465ad.16.1759244170301;
        Tue, 30 Sep 2025 07:56:10 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c1867sm14193305b3a.35.2025.09.30.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:56:09 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:56:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNvvhFsfySp9mW93@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
 <aNsjFm56D8pnAKDp@google.com>
 <aNuieevIo9MuzBq2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuieevIo9MuzBq2@google.com>

On Tue, Sep 30, 2025 at 09:27:21AM +0000, Mostafa Saleh wrote:
> On Tue, Sep 30, 2025 at 12:23:50AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > > > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > > > >  		.map_pages		= arm_smmu_map_pages,
> > > > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > > > 
> > > > > Shouldn't this avoid defining the op on coherent systems?
> > > > 
> > > > Does that mean we need to have 2 iommu_ops, one for
> > > > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> > > 
> > > Yes, I think you'd have to do it with two ops..
> > > 
> > > It just seems wrong to penalize the normal fast case for these
> > > systems.
> > > 
> > 
> > I see we plan to set defer_sync_pte = true always. What if we invoke the
> > ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:
> > 
> > static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> > 				    unsigned long iova, size_t size)
> > {
> > 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> > 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> > 	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
> > 
> > 
> > 	if (!ops || !ops->iotlb_sync_map || is_coherent)
> > 		return 0;
> > 
> > 	ops->iotlb_sync_map(ops, iova, size);
> > 	return 0;
> > }
> > 
> > If needed we can push the coherency check to the io-pgtable op
> > iotlb_sync_map() as well. Just an idea..
> > 
> 
> iotlb_sync_map is already NULL for coherent SMMUs, I beleive
> Jason's point is about that the iommu_ops.default_domain_ops
> will have the extra pointer which will be called by the core code
> anyway, which immediatly returns; wasting some cylces.

Ohh okay, I see.

> To avoid this we can have 2 sets of the default_domain_ops for
> coherent and non-coherent devices, to be chosen at domain alloc time.
> 

I guess it'd be better to have non-coherent def domain ops then.

> Though, It would be intersting to measure how much overhead does the
> current approach have in practice, maybe through dma_map_benchmark?
>

Yes, dma_map_benchmark can be used but its results won't reflect the
impact on scatter-gather workloads since the benchmark doesn't cover
dma_map_sg IIRC. I believe even a small per-call regression may get
amplified at scale though.

Thanks,
Praan

