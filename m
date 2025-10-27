Return-Path: <linux-kernel+bounces-871713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB8C0E22A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E7519C5CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521142065;
	Mon, 27 Oct 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fh7MzK7Y"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D252C21EB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572352; cv=none; b=axEu7l9ftSaF5XfQ+vsr+1zV8r/3yXMci/jDMkrDxRJMHeqZWL0010AoW+5v723r2f8wlJdVbXrTWEtHa4gKfwELXw1mWgn8vhxKyg4E/myS9Qhc51E4Z1GbwwP8y0E1tAUbI8j+r4E8wST4Gitg2b7j50Vl134IEB08UTmJu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572352; c=relaxed/simple;
	bh=DrMgdbkeAXpGtDwPpAb/Vgeub4TvwtXcw149FCkVBvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yse8aWTJiMkJIJrlRg+iQgfCvWXLQhjjHiIE8QOy8fe8rvRUOzxzLFLB8f2PxnsBxGalyojPFoBEBa+Tgivhgl7BTifjGumX3eLf+mwSYUdQCrhYiT0GRCEov7Npf3xrRfP1013wx5xT7Y/5v1dtqfVZgDnk324Q/9fqhkPGVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fh7MzK7Y; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89c81839de7so248120385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761572346; x=1762177146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNkoF/gkgZc4g4sej3nOYR+b3B4yGNdCwv3Dr1zemYE=;
        b=Fh7MzK7YIa7DfDf/NRbhdvQzvCA6wwvJWUy7cBvr4Plz9V7XmagISz2CZLAVlU+ocQ
         ajWNxfUxE+6VWi4sUSN8vH2uhKKMwSekBnzWTU9Ro5YA+ejzwUc3O/uZeANUu4cr//DY
         22Pqy5UNRLrR4Z4Bx4cuHfBs2YG4BE9zj/Tj12HAzm1SPi5iJLPl9EjVm/1w1Sx7BxlV
         7vC87Sprcla+WEO6IBGmwbB6gJ0xm9hUvFbuSQ+jrWHdc3jItvX8vrn8sRch4WipX5+D
         OGNd0wZExyawk793F1cDSxw64TGuh6qslQdgDaH7L2qDQqwkdIQ2IQWMce/4pTHk+3+a
         oHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572346; x=1762177146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNkoF/gkgZc4g4sej3nOYR+b3B4yGNdCwv3Dr1zemYE=;
        b=u1jE8/IuhIAvR3E9OHQF/lLZ0q/5qRViW42vY9mP7ScsLKM5KYfe0Vnbhd+fNx9cTv
         4JmTrZmLS5MN44Fc03OwBZ998bSPaS93SOpeHH3VMJ6lycl3cJpQcdjwc5/HmZbZX+zw
         i+FISF918kWZBb6Xmv3gSG06ITyfxZEvrbNtHZtQL/ZqmEOIHmJ9I9HFeLCV8yO3Ay6M
         o8h/UfjNhnyYfvJ+fitQdvbFdhd70zQjTLVH6z4JfZDOrZ8TZnCllkbK6DZxKuVXpr4X
         PnhHX0RFDGenUUBijMbTjZs9mYANTJYrNCJk8uiYz7yNCs9Pzl3B59QQgMaHuqhxxmny
         LDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYQ36k+K9gnSHnl8EJWJ938iGKwzRJ6KyT9rYcuRBfECEugrb8z3JGsyaqdoWQkjUhhpBrWq2juGwlUtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKn8KRlzDOIdgi24BY1Lck0YTZK7X6NN0jz8B1qjJvTpvh90K
	spcj685C9lHyq+BvSa9aKMWKNpnFLjvce8zG4ufnQUFwUN7RswEY7I+jsgRP6XWYbwI=
X-Gm-Gg: ASbGncumHYQke4lXzJhVkfAnzLvhh61TR2TlOE5RJ2Js44dtf7UytZWhwA8xA0NNdoB
	ipg9gwKmhxplmYFsaeU1ZzkKCIioB4BWRkTD+5E6mZg/ht5hfX4aBbe59+PefAcIUA6LhUSk3X1
	5hXqkL5E749lZYFupsmI6a2IAe17c3mp3k+8v58F1a0YEmT29RUg1PQ/ljxzxUKpw3kdd6ku8hR
	9Jod9gIfGpIHmBv3OBBQxcinyvl7LzbdgIxnd16c58M8Zb38MIPKgtjbRyOgvIvnrkkTPlyEhYr
	DVIpfK2DWqq4rgSEla0c7FURnmS/2mutOcBsp7sjm51JgeWtOpRhNMTYOz5typ9gO2yuKAOr8o6
	eiuw/9lFXKXIyuVsfsPBW9fC3zgng1sl8XfHroaieZajrfeB/LFWEjTCESxhshV9HYWCoyqEKJb
	SYOOwsBX7dd5rtNxzyS1pt1iEv8aX/GuhYVBtetUwi0shwZZn+72RnWCsI
X-Google-Smtp-Source: AGHT+IEvPD8Xv+HWH7vG+G5rqjY4Q6Du/D6ZeZRFIO7syuVxh5kiJIEGRCcGkZt+ToBw6XHQJbRf3g==
X-Received: by 2002:a05:620a:372a:b0:88f:315:4c36 with SMTP id af79cd13be357-8906e8b00c8mr4598524085a.2.1761572346084;
        Mon, 27 Oct 2025 06:39:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc6fsm597656885a.9.2025.10.27.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:39:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDNRA-00000004F6U-3Inv;
	Mon, 27 Oct 2025 10:39:04 -0300
Date: Mon, 27 Oct 2025 10:39:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] vfio: handle DMA map/unmap up to the addressable
 limit
Message-ID: <20251027133904.GE760669@ziepe.ca>
References: <20251012-fix-unmap-v4-0-9eefc90ed14c@fb.com>
 <aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com>

On Sat, Oct 25, 2025 at 11:11:49AM -0700, Alex Mastro wrote:
> Alex and Jason, during my testing, I found that the behavior of range-based
> (!VFIO_DMA_UNMAP_FLAG_ALL) VFIO_IOMMU_UNMAP_DMA differs slightly when using
> /dev/iommu as the container.
> 
> iommufd treats range-based unmap where there are no hits in the range as an
> error, and the ioctl fails with ENOENT.

> vfio_iommu_type1.c treats this as a success and reports zero bytes unmapped in
> vfio_iommu_type1_dma_unmap.size.

Oh, weird...

What do you think about this:

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b8..1124f68ec9020d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -707,7 +707,8 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	struct iopt_area *area;
 	unsigned long unmapped_bytes = 0;
 	unsigned int tries = 0;
-	int rc = -ENOENT;
+	/* If there are no mapped entries then success */
+	int rc = 0;
 
 	/*
 	 * The domains_rwsem must be held in read mode any time any area->pages
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85c..ef5e56672dea56 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -367,6 +367,8 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 				     &unmapped);
 		if (rc)
 			goto out_put;
+		if (!unmapped)
+			rc = -ENOENT;
 	}
 
 	cmd->length = unmapped;


Thanks,
Jason

