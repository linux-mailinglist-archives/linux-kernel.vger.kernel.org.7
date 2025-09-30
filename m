Return-Path: <linux-kernel+bounces-837415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A560FBAC454
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0617A1925C56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0972F4A1E;
	Tue, 30 Sep 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0EdPkQ4P"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80D2E9751
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224449; cv=none; b=eWYfqNJRot/0dHzZiMUaPeOqPOdraRKH3ObbDs39cCZUVt40XqN6SrZS8YZxs/6I4M1U4Z1mquKsi7T4JDgsB2q+E5IpuEgwlB3AXKBqXsMShDzVZJYaxK7FuQ2sQkW6Mxa/bAHJUglC6+89tE0F9VQFXEWQs03m/nDfk7nL6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224449; c=relaxed/simple;
	bh=2HX8ugR5tVnj66NMcDsSytcxmQ8znP8neJT/Ryq2niU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX5xNjAsvG78DIDs9P4HecJw86gc2a491rcx77nqWwrTTv2p1gNpYoofITRuRrpuhLo9qdwbWXTWZbDO5uugM3vCvGIyoZ8U5Vpxc5fW6z7mPeaSweUpQ6YCt1aNcGuL7YsVXrH2n/rj2TSZMGXmBNwGe2U5gzEg25fjsdXGzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0EdPkQ4P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so38915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759224446; x=1759829246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QN7PHWfqfHR5N/DcATDm3hhOqXSyCS3Nkqfi3WstvM8=;
        b=0EdPkQ4PEJ2Jnqc8LJPoQwHB8o9n81G/+do+GlQX/GIviQzv+yZxhNoayqKipn7qtW
         O0nE0QKZPUNLP5V6nT/xZ4409iYq+FOUNNh+kUod8atGK4i5JCwGP1H+v2ZdDUIflT7n
         oCXY+yO63x0gNYPk5AUKPZ2TWuu0ktadRyL4cg85omu25JLYvFMnYP/npUmpmVM0toXk
         dZdWX9yDMREtcgmqpCAtzkSJUDXjgOEWRjAhFU6g/6M3yIhmgjsbid1S4U3Qi5NCOR9p
         1be5zRS1wcCGZCfTT4WZ4x71+VnJe7F/nOlxIhCAFJ8UbaKjwnGZbYwbEXy9JHLPb219
         7nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224446; x=1759829246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN7PHWfqfHR5N/DcATDm3hhOqXSyCS3Nkqfi3WstvM8=;
        b=j3Vff83HcuS4+YMUrBrYGtNn4HQZ+Zvh8ZW+qcofXX8Hd7pCxx9AppRpADHkjAuWmD
         6YDTwIOCnIEwZ2vD2yWtcw73in9gPP+j3tbQ9Y8T/aUBO+LnCcy5cKj2hQ+3np6z6D9r
         aoAANcfCmqQksz/xOBdrun9ko3cWQyfKQOEiDuno2d9jE0X1A0627tewpnCKhmbBePqr
         cb1ZzpqKdhYPQO1AiUB+PvTA4u9CzWBdmtmOz+LUvr4eiP0cqvMY9RJmRkcI/A8/O+2R
         0HjIuKxjVOGBcOlHKK7VlPxhwMUXxLLRdst+3tuY+x66DpjKMks/NFKXhMbOTYYk6iUA
         DbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUZrFDmbQZ3jbk5EpBhCKvQ2T7Bwy/dkupBNos2WWXqM0MgxXUmej/FRr/JCNVJYVWB5gIXQZSgG0uTnZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhfHnvvviVvK8CQQXEATUDveeZwgitD8+vMOQ0Shj2uAEKjGK
	joAauZ82s++X4CWdNOK5M86a8iHQnYWWUOwipQhBfduwvUiXAp/H3bg2fsfZRcft6A==
X-Gm-Gg: ASbGnctaLNsm/d1+UcL99hHWu2WpUzujpCqc7kiJw1pWq9G2OTmKvpI588VRoQEwSQj
	3lzEe61Prnrgjr15s4nI9OXwqkKCOJuKIcnzQKK3p4eDaVhju9xcH7pxcTATiIQmB8R3+aMDxr+
	pSX+9SKNqay3qB2M2QJec33wx2rMF93tT9nDafkc2+ahL2R6iErt8B6K0n6LSbKDKek0CRiXGTp
	H+9Q0Uz+CYsnMpTFj7XdGcSBFuSkzWi+j1EIDFCHwQZJ6EJ4ecxwTNTmJ6aqkB3HxVs2i8M7CgH
	EnOcuRdipU22sKRGfquh6mPJdFg7ju+0q8eQcpFXGa3M590ltdOPr1bG4vKc7c6tU+qWwlJOLnS
	jrqXbodz3MaEZ6ceN1lpQPPRfzDXawSj/uy5ScjdPGM7uJX8dA//NPZfgF2r4Xnohgu4gPXxcDE
	kN6yXhANKD5ZUB0Bw=
X-Google-Smtp-Source: AGHT+IH1yV5qF+JFSdcRmxcBuPDpaQAsKJC//b8C6mcxmI2sXqJnZXAEpAcPpMpubgQmmUzlsr/1JA==
X-Received: by 2002:a05:600c:8a0c:20b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-46e59c5c91bmr1653685e9.2.1759224445782;
        Tue, 30 Sep 2025 02:27:25 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b576badsm11337405e9.0.2025.09.30.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:27:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:27:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNuieevIo9MuzBq2@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
 <aNsjFm56D8pnAKDp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNsjFm56D8pnAKDp@google.com>

On Tue, Sep 30, 2025 at 12:23:50AM +0000, Pranjal Shrivastava wrote:
> On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > > >  		.map_pages		= arm_smmu_map_pages,
> > > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > > 
> > > > Shouldn't this avoid defining the op on coherent systems?
> > > 
> > > Does that mean we need to have 2 iommu_ops, one for
> > > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> > 
> > Yes, I think you'd have to do it with two ops..
> > 
> > It just seems wrong to penalize the normal fast case for these
> > systems.
> > 
> 
> I see we plan to set defer_sync_pte = true always. What if we invoke the
> ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:
> 
> static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
> 				    unsigned long iova, size_t size)
> {
> 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> 	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
> 
> 
> 	if (!ops || !ops->iotlb_sync_map || is_coherent)
> 		return 0;
> 
> 	ops->iotlb_sync_map(ops, iova, size);
> 	return 0;
> }
> 
> If needed we can push the coherency check to the io-pgtable op
> iotlb_sync_map() as well. Just an idea..
> 

iotlb_sync_map is already NULL for coherent SMMUs, I beleive
Jason's point is about that the iommu_ops.default_domain_ops
will have the extra pointer which will be called by the core code
anyway, which immediatly returns; wasting some cylces.
To avoid this we can have 2 sets of the default_domain_ops for
coherent and non-coherent devices, to be chosen at domain alloc time.

Though, It would be intersting to measure how much overhead does the
current approach have in practice, maybe through dma_map_benchmark?

Thanks,
Mostafa

> > Jason
> 
> Thanks,
> Praan

