Return-Path: <linux-kernel+bounces-797001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A15B40A93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BDD3BBE85
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE37337687;
	Tue,  2 Sep 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eicYPysB"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869532A825
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830543; cv=none; b=ZIGMaDTeeXGQFgA0zDcHtVCawYmAPYK/N0RVGEZ5HJjzEbHcgZFoB07615h1Jk8z4xOikskhwiQGrnQm5YQ74StpMA8HlZydhN/BSJN9m9mzn5VL8sL+ys45Ty+ggUNadMgfKZ+m3JFtK0OA8yqss6TH00od74AV/8YKbVZ9iSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830543; c=relaxed/simple;
	bh=TIGUtVmXfyG5AOMlrQu/Tk0wWcNgx23M3QCPxT9Z208=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pow1jYsABLs0MMTNsc52eTpbc+nxiWyldCESYDl1OJs1x+DSGttKEWm/tmvOVjE9o3SN1Om99Amvho8R+vINdvZ0VjD9/+5FfAYI/x85+HjkHaoqf5XFDKlu0WeIbNGT387b5b5ePu20vz0HkWh16mN2hTpaJ2uob21C8Vhx/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eicYPysB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f777836c94so487146785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756830541; x=1757435341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzNFRizoK0DA+pBHHDrMUD4m1SbYvscM/f3av0PJpIQ=;
        b=eicYPysB2TK8lmfsIHJ38TjdxDx+dKG4hD0GeRIHC4StTed0USnO2hotcCx/sQrKeF
         O17Sfn7BFrDjDDGMjFpQAXvjdWZdSEucxckmSrYeYMUNmy1iCx2MeCeDVnXzmadiW/eU
         aat5+xWPRFH+mLxkCqQt4A6vDoXuISZ7xUs3FPDuWHL2OaBzwctNp4ry9aAV6U0yt/io
         WxQYXrh+frtwvxQdAu1/2OAi4qlJb26VGLWKMXH+t8mPJc2NSXaZoON8Yx29kLEXbGo1
         OIpAtZH8Dg1o4rejnyttZ1YbqTvZBO7Fr1BuU5uVrtscZ2TeKc2KDKf69mjO3QVwAuuW
         DXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830541; x=1757435341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzNFRizoK0DA+pBHHDrMUD4m1SbYvscM/f3av0PJpIQ=;
        b=ONCwCPSGGhKXhyGDVyh1kE0xmyvwid2hFNVg4LeyI3CXW2I2mUqhMNna1V87uBsUPY
         AY+kQ1smuGf7nt5kg67waoA8a1fvYgykZBeter6cCziTlTYtXpF7R04OlACw7OG3BG8+
         2R5yz0Rb6hPxJLv6kO7/n/U6FaxHQL4CUda7C6Kwmt+Yf6K6s7AhFRZa87wylUsHa6kM
         rvvZRZ8hc6L+wHyt1hFgtMXu279nG9BxDpmCpJsQ4EoEfiqgPKcrX3+DvITzppe1U7ub
         39Zoe0u1wwQgWltVxo/DHf/9qhZpIkgx2VBWkmaNeXIg8cx8jNJrb51N2HZH3w8Es5ac
         4G8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9qNqOXQnahq+TfPOeLMn7znmmxv5ZLNXz7lP+O7CsrJhKYz7TfSnE9hRNWqYNMJxIVFhJ4knRrpZ8bfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CukGR2dZuLM4WxyylIZv1xIs+qYgzEEPlVbhUxnMxI/xVwfo
	5v0jbCvRy1udtQlaAMj5MBwNE8rQbYAgnaf05rsPVjxVPI4LA2uZWNaMdDkFSFsnSfc=
X-Gm-Gg: ASbGncu9PrIyR92H7JiT54usmbgGxv6IE52WSVtW0o7pKeo1yZxO7+qw32lDvLk7r5Z
	C8sqXqGlo6e9aRYev/fn3vBnwthD5bDWt3bUxBf7VDCpfVOEcNekJVh+uiucKyH+o9sWf4hmoFV
	gLY7ND/eLJd04RBZz9gVEAyfIHm0bGt8qObTcxurb5q/aOuuYeAgh4eC6dLO4X/E5/ErhEC8z9p
	eUFEqaRFxFg2wxoFMrlTxvhfV7SvZanFwcyRwg5SciNXGyMq2ZxsYZs1lrwdduzUaxLMmKjQ3xa
	1TuQRlRWmodLF41daq/qNNG6bLAaTwk9N9sbzXZrk6VqbWyHslGrHs28T2msnO3ye9Au1nTjoC3
	Ke+oCjqdT2Vsp5cg0tq56c8JY2Qbg9Qc5HLuCvh/joo9Hx8bePQmI+MOjlEXYRq0nnQoD
X-Google-Smtp-Source: AGHT+IGlkUdvrs/4d/cbiDbFE0x0xyuHO/9lDjr2DrV2pOTG2L8+cMT8JXT2TmmRvRF3DAjlGXP+KA==
X-Received: by 2002:a05:620a:3193:b0:7e8:324e:ba20 with SMTP id af79cd13be357-7ff2aa20af1mr1183564585a.48.1756830541067;
        Tue, 02 Sep 2025 09:29:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069d6b1ff7sm162410985a.69.2025.09.02.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:29:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utTsR-00000001ZjP-3QE9;
	Tue, 02 Sep 2025 13:28:59 -0300
Date: Tue, 2 Sep 2025 13:28:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] iommu/vt-d: fix iommu pasid memory alloc & max pasid err
Message-ID: <20250902162859.GE184112@ziepe.ca>
References: <20250830130737.1930726-1-guanghuifeng@linux.alibaba.com>
 <cdd1c8ff-6bb5-4665-a55a-9d86cd81a8ef@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd1c8ff-6bb5-4665-a55a-9d86cd81a8ef@linux.intel.com>

On Mon, Sep 01, 2025 at 03:28:29PM +0800, Baolu Lu wrote:
> On 8/30/25 21:07, Guanghui Feng wrote:
> > When intel_pasid_alloc_table allocates memory for Scalable Mode PASID
> > directories, the specified memory page order is incorrect, and an
> > additional PAGE_SHIFT is added. There is also an error in calculating
> > the maximum number of supported PASID directories. In the revised
> > implementation, 1 << (order + PASID_PDE_SHIFT - 3) represents the memory
> > occupied by the Scalable Mode PASID directory, divided by 8 to represent
> > the number of PASID directories, and then multiplied by the number of (1
> > << PASID_PDE_SHIFT) entries in each PASID directory.
> 
> Do you see any specific issues if the changes described in this patch
> are lacking?
> 
> > 
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 52f678975da7..9969913b600b 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -61,14 +61,14 @@ int intel_pasid_alloc_table(struct device *dev)
> >   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> >   	order = size ? get_order(size) : 0;
> >   	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> > -					1 << (order + PAGE_SHIFT));
> > +					1 << order);
> 
> This converts the order to the allocation size.

Yeah, I don't understand this patch at all, 

iommu_alloc_pages_node_sz() takes bytes and get_order(size) returns
order.

  bytes == 1 << (get_order(size) + PAGE_SHIFT)

Is correct

So why is this being changed?

Jason

