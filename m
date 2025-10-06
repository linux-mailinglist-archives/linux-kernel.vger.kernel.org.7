Return-Path: <linux-kernel+bounces-842932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47922BBDFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E85B334B751
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6027E040;
	Mon,  6 Oct 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="glKNsKHq"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B06ADD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752983; cv=none; b=MvXVFWe21bwxJq5Vq1/xsPxYAYocXRDj/a+b+PNyNEEOiyBrUHshe5916aU/hS1bAXcms9GBDojlUEYHrSzuOx7c7Vv3/IVcDSXdwiralW5Ct0mP2jamsWZgY+am+luQEUDDwbIUxHiaJM1XxXO6wLJjMghptiH3HVDJQ8Jg8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752983; c=relaxed/simple;
	bh=18r0HQkzSwcgI73ep+fZOSbWLEQuKhP4jP5h62Ds7KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBiBEMLIiGmCWkzAH9Y6s9M4qg9h3ob+FKizOjtQ9v7jQOVTyL1Aq0u248zKtMQvqlr4EDKDQZ+5Ctq6d3iPc8ykqZKMxChYu7lNIBAHD24Z+z8zHVF2bZCUqVHOpPizZrU4u4HIl+60AkcqPAnrSVp9efUVVRUO5fsDKT5ouGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=glKNsKHq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4dfb1f481ecso64470861cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759752980; x=1760357780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/XVK1R0UPbW39R8bw8unhnts52CGKV4hWqxUYh+h4U=;
        b=glKNsKHq0XKW7xCU72etmQGF86E7zJgwUw+5YymRllVJJe9ges+ecCzlRDav+Z0dZk
         hGOQF+avbLMQ4Vu7lMVqy5RkjHacLz/rYj4qhqAlXwjXsddN/SK248KLq6qKNYz7gPJ8
         2ZZYYt8QKIqZWtnNkGPbhT+NsnU8b3rZmBjHJ4hNfsgIHjXwTKs2T6bZ0FsKU4A4/b6k
         bXSxcVCykFZOneEvNxxNuHV74v2+NLlNfX1e8EYExg51wThyTVBcgngRUVTw2U1KhDMw
         PYfkKdNooghNkQlBxaEzMaIQBBMqYUymAbM0cc9TDdJpDUQ5JuMooceaJ1dkXu+SM5V3
         JHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752980; x=1760357780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/XVK1R0UPbW39R8bw8unhnts52CGKV4hWqxUYh+h4U=;
        b=rF/9VgCd3hZVWCSbPa8omi9YkRW7uvNEFFG+C5Y9moDz/dd6i3UNgyn1vETD/T0U1A
         EcU0d18gME5YFpQ93OimL1n9FWNGdZHcYxSSMRDocfFdjZoIzQ+2Lp2zxVFG9KQUDLOa
         g0MMsisxGISaTZRlzi6n7Fqmd3ukQjPgD0rlLqrUYkxPfEkXCNsMqwntmkLiyZyMJ5/2
         M++zhXgj4s5P27kuCkXD1F+azG33sdB4XAtPDpsNWuiRDhnLtjB4ZK6FDv7tPkdXJmqR
         aPKI5rIF71TYb7qX7LMeJwvvehm9YeRPrN+cOI//lKow4Y4voQmNesrtZL51SoH60izC
         QUtg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Q6mZBs3dqV8mQ2HrURC69ztXDfv2yWHvwB6Ux93vixGz7UMCqd5YkD/pqSe1809RWIczLWP+uWfBu2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM29u1Bwc6I9oUj5YdN4SW7IsaeIhUf3xj2huG6cTrmhCVe7PB
	f6VNeDmSxJZpBALPK0YFbUSogKa65RuRlbXTmqJpAi1Y5y1kYxGie/PGGs8bSOlfoGI=
X-Gm-Gg: ASbGncsj/y83GUUtVvmMx+iLudVqcWFe9z/ekE51sMsXQtC5nS0YGHPUoTKGe5eVHZa
	vYUjr8DdgEcN8GuWm1d4r5vd575080+bxCc5zKL5ts/NXHsKqVnDO0MnYCoDzTIqa6IIbs9vDQz
	tHo4ySuIQIJY1k195pTRa/OmJqTcZT5e+5xwLZw/YJ05W/0zkLUAFh/T6+59MF6mvk9nrqzFRds
	WWG+l9AtOaBQNPCZY4Ar1vwlHnvKpsOfN+TfxqffZzrD6ZF7p5bLHqEpAmc7Y571bVFXg8nn7Zo
	naayFLSbXoPqlij5J9HGHKfGqoses+QjVuB2hXYvRrJgFpHeB4zqsFe6O8V5iXL5X32gdF1sY/e
	HSsLHuskx8wB9tANKBUV5pKOkY7BB7JuIjBUNhHRuV+RpgsrYqAUWs3yH2QxgSdMLzhv0ZkIHyn
	W90Wy+f11izWoTQgbNvRoDMKQWkWc=
X-Google-Smtp-Source: AGHT+IHHE/cXeP5n6eP+zy1nV9e5JfVEW4+WPPt2lQBPbies4CCCoOlEMX7n35sZH/VeOrDgIO4ZYg==
X-Received: by 2002:a05:622a:83:b0:4b5:e7e4:ba74 with SMTP id d75a77b69052e-4e576b22551mr158847341cf.56.1759752980019;
        Mon, 06 Oct 2025 05:16:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e58a7f098bsm55878991cf.28.2025.10.06.05.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:16:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v5k8Y-0000000EPl0-2nb0;
	Mon, 06 Oct 2025 09:16:18 -0300
Date: Mon, 6 Oct 2025 09:16:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <20251006121618.GA3365647@ziepe.ca>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>

On Sun, Oct 05, 2025 at 08:38:42PM -0700, Alex Mastro wrote:
> vfio_find_dma_first_node is called to find the first dma node to unmap
> given an unmap range of [iova..iova+size). The check at the end of the
> function intends to test if the dma result lies beyond the end of the
> unmap range. The condition is incorrectly satisfied when iova+size
> overflows to zero, causing the function to return NULL.
> 
> The same issue happens inside vfio_dma_do_unmap's while loop.
> 
> Fix by comparing to the inclusive range end, which can be expressed
> by u64.
> 
> This bug was discovered after querying for vfio_iova_range's via
> VFIO_IOMMU_GET_INFO, making a VFIO_IOMMU_MAP_DMA inside the last range,
> and then attempting to unmap the entirety of the last range i.e.
> VFIO_IOMMU_UNMAP_DMA(iova=r.start, size=r.end-r.start+1).
> 
> ---
> I don't think iommufd is susceptible to the same issue since
> iopt_unmap_iova computes the inclusive end using checked addition, and
> iopt_unmap_iova_range acts on an inclusive range.

Yeah, iommufd was careful to use inclusive ranges so that ULONG_MAX
can be a valid IOVA.

This doesn't seem complete though, if the range ends at the ULONG_MAX
then these are not working either:

		if (start < dma->iova + dma->size) {

?

And I see a few more instances like that eg in
vfio_iova_dirty_bitmap(), vfio_dma_do_unmap(), vfio_iommu_replay()

Jason

