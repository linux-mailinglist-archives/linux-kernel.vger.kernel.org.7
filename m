Return-Path: <linux-kernel+bounces-872802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59EC12124
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C641A2145B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A65032E68C;
	Mon, 27 Oct 2025 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7JaOIIl"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277B2F1FDA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608237; cv=none; b=Rp5qw0mqu2+N4tPJnEA2pmC0yo0zlFs9FJynqTWE+6cUEb+97KJ9SR6XbzgzGv/Q4kB7axZtd5jMMbiJh1gi05sOHlTWeB1eKXPg81gccJfKNrwbCQC87iROa04AyehuBwPEIgPKJQ8gMwoMldGkDGeykECWcpDulyewfNW3+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608237; c=relaxed/simple;
	bh=5fxdEJqLRN1tb+ss8xTO6a1FlGbLgSxQYup7sfAznOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI9JqRMV+6H10w5xSd43uPB5XqUkpF4/3b5dj4s/qL+0ZRg80DE6DmfsUm9NsnLwUKuY+q8lqga/knSdcCTaYVrv6W84zNXt+4+gQq7sVuYogCDfsbv/xDTKg6UYYhoeAjE0IK4yd1iQaUijcFFwzJvC/t6rL4aqsdErPuOMb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7JaOIIl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5119576a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761608236; x=1762213036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25RVEc5uqdT77E62cdiRIe7zTZsno+Zu/0KbIShg9A=;
        b=m7JaOIIlQm+eKJYwobgLwOcOTA0ZD7WCnE9bwrhCdmJDTZ9zga2Jy9w7UPHVwTGWIY
         swWt2dWlH6+XSnffAMJnNnsC0FNi57A4mwQheMPq4KqZEqLDP+QXPj075aUYBQa66vZE
         o7xRjOwaBJ3KcdmqwjPK3luN1t5m5eArnXISeiE78Gy9GTYv2/XQZIWaGTvYNKoksCva
         WtY/+sLfWH/ehuVOVulmlZxQPd9SWw1K+1Z6LAdo3Kz0F0joyyUG+eFIbT5SECxLxX1v
         DL/bHJfX+NBKfDq9hPJ200jBYBY5GNEMoJ0H1O2FODsldLDe87s4rjSUXEtV7aUitrhw
         HATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761608236; x=1762213036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y25RVEc5uqdT77E62cdiRIe7zTZsno+Zu/0KbIShg9A=;
        b=X7OIsBsuFj1mhpdX1CNxA3vm75r7vuoQN4IdJIOtYWpmpdGLFkNFs7u7RAGwNn6JN7
         dEdNS/L2nMmFDit5qjfbGggrijWL18Jk7Fp7jm9h36I4AqRKDDOqfkQRzU4IYKVoCeT/
         MCIDDt96IC7cwvMP3FwPRlx/aMQSdrOLPvwvxEeKDu3Ezfz01ObTKwU2cguweZP60MLE
         bbjDqr0mXLoRqBaR5WaE+fWzkjXIz3isy0NWHH4H/C2YdvIwnUzMtjpaz0s7WNN7O46l
         M2gE51B5Yig4dRg2tuS3/GE2L17dTptG7Z9at6u+pfcpZGQscSDRqZ7EHq8EMxxZxLa2
         O8rw==
X-Forwarded-Encrypted: i=1; AJvYcCXGA/owt+h5DM3t+MAI9Jyt0Qu9zbpZxZg8mHVmPIJWuxTaVJIWWKQoSHmXzYEW7Za3GsELBrSyKD7yyxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKheQ+22Jo5sA87uyohZt4+thqoNKH0zsSqf4qRra/3XsOOtgn
	MsNF+muAjDSaVuo+nH4FiUziLdRvqMXQk5ef/s4OLBFDE8dUM98Cckhs0NWJs25usQ==
X-Gm-Gg: ASbGncseYow2z7SHnGwLiBtYOH76w1b0ndkhGxtnQnTY3F8i6No+pSZxO9LXq78Glq+
	zkE6JTidELN/QId7Eho/YfMYVp35IGI6CzOad3ElEyXX5vvW1QPH2gAu7Nmi6XZhgACl2omko3Z
	vJJ/axCSTjloMMFF5PTDxrWVirYnErOQXtE1813efjp/Bgf6w5ho2vDcRnu8Kq1qJdzJZxy8SJJ
	VuizT9Qy+ecp2q3/QFUuPm7Sx1jwFUq2DXwHfTVt9It0BJM/e7X8pPSYpzEll9pk1lUhQPhyfpb
	/K79gLRDwF2+MY+j22msD/unATGIp0iRZeY47Aitc4xb0SX/RPuw8Fj+SgJdPVIzW99pAyOAvp7
	gNphv1e7qHL2czMH00n7Wq//bvEtTVtnX9BQw5BHvCIHrqYGG017YGFDhUVHl/UqTXVsF59JERJ
	wSvSZuxRNj27vgM7HHc22GiUqP0l2AnN6wE3igxMqHlIdyCbBnreLGikkHOZwumb4=
X-Google-Smtp-Source: AGHT+IGmKX74epTI3A/iK0KHRQ0gJ5rV+oqAQAXmFZTOi70Jf1LkFq+8kZDCItWUYfvqvUNhL5cm4Q==
X-Received: by 2002:a17:90b:4d0c:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-34027ab36bcmr1685369a91.33.1761608235576;
        Mon, 27 Oct 2025 16:37:15 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed80aa48sm9919097a91.13.2025.10.27.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:37:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 23:37:10 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] vfio: selftests: update DMA map/unmap helpers to
 support more test kinds
Message-ID: <aQACJucKne4DRv06@google.com>
References: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
 <20251027-fix-unmap-v5-4-4f0fcf8ffb7d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-fix-unmap-v5-4-4f0fcf8ffb7d@fb.com>

On 2025-10-27 10:33 AM, Alex Mastro wrote:
> Add __vfio_pci_dma_* helpers which return -errno from the underlying
> ioctls.
> 
> Add __vfio_pci_dma_unmap_all to test more unmapping code paths. Add an
> out unmapped arg to report the unmapped byte size.

nit: Please append () to function names in commit messages and comments
(e.g. "Add __vfio_pci_dma_unmap_all() to test ..."). It helps make it
obvious you are referring to a function.

> The existing vfio_pci_dma_* functions, which are intended for happy-path
> usage (assert on failure) are now thin wrappers on top of the
> double-underscore helpers.
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>

Aside from the commit message and the braces nits,

  Reviewed-by: David Matlack <dmatlack@google.com>

> @@ -152,10 +153,13 @@ static void vfio_iommu_dma_map(struct vfio_pci_device *device,
>  		.size = region->size,
>  	};
>  
> -	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &args);
> +	if (ioctl(device->container_fd, VFIO_IOMMU_MAP_DMA, &args))
> +		return -errno;

Interesting. I was imagining this would would return whatever ioctl()
returned and then the caller could check errno if it wanted to. But I
actually like this better, since it simplifies the assertions at the
caller (like in your next patch).

> +int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
> +{
> +	int ret;
> +	struct vfio_dma_region *curr, *next;
> +
> +	if (device->iommufd)
> +		ret = iommufd_dma_unmap(device->iommufd, 0, UINT64_MAX,
> +					device->ioas_id, unmapped);

This reminds me, I need to get rid of INVALID_IOVA in vfio_util.h.

__to_iova() can just return int for success/error and pass the iova up
to the caller via parameter.

> +	else
> +		ret = vfio_iommu_dma_unmap(device->container_fd, 0, 0,
> +					   VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
> +
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry_safe(curr, next, &device->dma_regions, link) {
> +		list_del_init(&curr->link);
> +	}

nit: No need for {} for single-line loop.

