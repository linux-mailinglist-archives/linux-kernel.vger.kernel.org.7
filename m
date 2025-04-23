Return-Path: <linux-kernel+bounces-616840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387ADA996D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE12E920BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D63F280CFF;
	Wed, 23 Apr 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XV88OjQX"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3433289365
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429938; cv=none; b=I98R0S1G5cP5p63V9EoJ2lBx19cel78v3SaceVJ0+CSCpnwvjETA2OltBFk3pOMzlYPcJxKb+GjIxK4/QVqMt2zeUh+xfH15+Ke9V/A2PbzQZ7+cwheFDnP8OPr8iQhL5zw2PNJ1LMVtcnPzZENb0/2ja91TF0WYdmZnq5zWDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429938; c=relaxed/simple;
	bh=jyCSrAMbJeJJMtfyLp932NW76okHOgg35e8+PFG3Bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7Q9hdEQb+ioMTN70rR9GP4e/Qwe+WsS9Q3cxg1eH2igWxiu67s04OX6TMjtfCesf9fBEULZ6kTi4Z87jxXKgnuCpH1POt1BEMLH7vOjKlwZULDpuky2qziDGzPVsPkpv6hPHNFWY8hCnMkGY8n3VVLWKu635pvIfBAkBtgFnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XV88OjQX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5675dec99so10034985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429935; x=1746034735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=XV88OjQXLvia7kK4o00ZKUcesjYunq5WroYYymOJIGPMGmbS/9i7/qihmuV7uOasU4
         OXl8PETx5N3fBmnwdHey/3OYAFXqGUH3OPC9lDRQ3t7t5ywtpMDnAQfl5fXiXDw0kz0Y
         CY7vXgT33OAcwYME65ecscD4qSwBEzKjCIcCmKALFBpmrDUzivrqYevJro0byOJABFZm
         U27EyPyD2OYa9Q5WnrYhRvJ6IlClmvfZsSYDVXfiY18SHL3rcq5umqVuzT5sD0yp3yd5
         P0OLu9NB/5EVomSa/v3aTFE9KbMXn5dTG7PuVElsFKFgm+UzdsRy6Q7MuGfp0offCZkj
         bQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429935; x=1746034735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=S/bmpeitSK+mX3y1W4YbgSOrtxHYoFvNGTo+1LoVRemb+1Ery2NWgAbE2LWTiXPQYu
         8CtzvqH9NM+gCzDOQWIxvPi9J/8VdqItPlyo/af7jDOsf6rw+Brh0S4wFgD6FHR/2vxU
         AUa1lBSkox+GoUX6zRvzr0aT1ZB2wqDl4Sne3v9ziXt4rnsmVudfiCTmxGGjQymcYYB7
         cH/yppBdHrE18W8or3jAAU7HvYHZEYq918/vy7H78EQrLkg8WN0LCJpvhBU2nvcmvGtR
         BffDgpAwL1oLo4C/C9A2KWTlPMlx9bfY61vkKxWZkj0XQaPQ7eYB8dPAf0CIDB5zSe5M
         pZxw==
X-Forwarded-Encrypted: i=1; AJvYcCVspyhR8Ratwv3fla9+X5kbkCO82f1vqYAPwVg3H8/anp6L1+I0u07Bd9CDFdei4qiOn+4rfyJJjjiwOA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWuOKHSDEPno3QbvojIQumFO6+WIgGwpWa5Bl/df3dLdo6kuAQ
	n1UIsBfEzI1MQkCAoQbcZt+T/EUryImzoszschzRqS2v42t0VKU0Jz6UtRNjjSk=
X-Gm-Gg: ASbGncvJh/JN67ISZSWFe68pxnyG1ZxfSAvWH19L2VoFQ6TTQW+Xu0c7oUdmhAVLEf9
	8AF2tyuBp8lLP+6xEvLTIxNe6SzGN6SBHujYf27OSuK13yl84X4tubx3jmL3R+3amGCN+F8EuUR
	g4q2vaCPia3cYabgRpmKsQBOZlWGMeCCICjWVZWfANnDtPRzi+go+23bJjrc4fgdAJEU0U8G89w
	HymY465mLBaDITsAwlhuwtg10I+lIJS3GfJfZlMQrC+v+/AIuhAMwzW0kgMFiT22L31otDtkm6w
	5Az54nBS1fSgAK07iw0xh4oqWt9h3eOdOmOMIRkpSkyg/rOzDSKZSQI7MnN9vmaUH8307qSnw2W
	zN2aL8so2k8KsBbkbvUY=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

