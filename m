Return-Path: <linux-kernel+bounces-894205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBEC49790
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC534BA52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638202F691B;
	Mon, 10 Nov 2025 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Th+o4/P/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993526657B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812241; cv=none; b=EZ2JGtM7re7ZTRW8703V7UFqpSj6S+3AuaNe4Chz3Uha0ptsqPcR2q94epTjmaVW0EA1fFUcjw36sh8wPD66Nb+dwb0OyKJTcbL8yuw5p+Vh//IqdH1drLC5OPj9VUB9gTHOqdgO6lWh07Ec8S0lInYyjOmVVbLzsO8FhplXDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812241; c=relaxed/simple;
	bh=W/+Qb13fLuIC+pUVsrfpojLJCEkS1lN/GKOP++Gtp9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqIDCfBe1i1JggPzJySS8ltIh4LRMeBJ3GwyPIB5CeF/BfoYeVXJnSpCkMHbd0M07AuAbvW//mFeyr3lJi7b6ZwcO9J9Z3lYmatXUyIhwxIeuucKxTr/9GTMBmWNXz42Oo+eA9aQ8VykYupHBEQ/ivaShIPx3DWFi8e44ps8GWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Th+o4/P/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-79af647cef2so2924088b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762812239; x=1763417039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhck2YVv24x1Tq6SL/L5kEfr8DPVNBJogPUSyg2Wx54=;
        b=Th+o4/P//bDKiz9NLRI23QbRXf6Jc1voFKAX0PDAn2iWqxCxrUlRHUgNQfNirMTbtS
         kT9y483e/32sCiQDcelfHtUS45H8ovDLzmKmaCTujp3Q0bPEFDQNkdDBE5pfeKpj7p+v
         WdPqmfzD6j09lrWrZRmR58rUFePaiRuYrmFwnAzcqRzxQGlgfQMVoCcmeil65IylSFax
         HQ/wlZ1z/N7GwVtW8NUktXg1UQ9SayuJuQR7arqMMoNiT1vjIAb3A/+AofZ3kGtsIQne
         5kTA6xU2ypyRm7EsyDKPAh7GaLAFQQHtptW9mD+vXZvUvXecuil8zmMmVANMLL0e/PHd
         6Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762812239; x=1763417039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhck2YVv24x1Tq6SL/L5kEfr8DPVNBJogPUSyg2Wx54=;
        b=aLxkvPK8q7xbyBtmA1MW3HfHa8MEka2Ux86h/vHxQ98GiO/UZsgHFaywLR40fXJKj+
         gF65Qs2xrsMSCMfQUHkTO0MiqieBzC/ce25NST9uH158IxxIWmZJKbHlzoE1Xdb9bZUe
         HwjtrOIAul3oUaSyT9P3lVbUWjO6dXGSpVs8VUlB4VFZKHT+iubMEWki/htS/CXkTCS0
         ZzqK1GnBhA7kpIhsKD8UMgWJhtjE8EkJPCJQOzwXo22yNsVHr8rASFu8l7ny0iQebn/t
         x2Gy0HJnlktzlptedWPad/aI2GAYQnX2mF6qU4qpBOIa/Y33AmNa3TYmhVhgjdNMXvl9
         nnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJTyl4+KVlwA6bpNI2cFa2ld59GKb2LaXifGmPMpxlrtvTDW7qJ/ADamcrqq4uAj8JECpKZ3GQggYx98Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwpvLP+Eo264oTsGPrEljX318AKA2/vtQDQ8DAMWWimHH7wuS
	cZc4sAlDLfW3m2o3AZo7d/EH8K/cI37Za/VQN/d6dYtBxVRHA6jDWPgRyTYYn2Anag==
X-Gm-Gg: ASbGnctAE7HX9UqeKR6mhHkPq1jv3ToQ0qFh0IgawuGD0PpOF29XLNvHosgWqOt8Gcj
	U4omTb09BtY+KIrTCj9iupk3ogrriKnQ+RcstnzVfy3jB5lRtUtSTpwE92DdPoDCmsNT73dbFZW
	Y7rbT7iFwMwIU4n0SKDLlUDjWzUUOVSZ6Nt9a9LJiMerntZyOF/SGzVXRx1Etf6KKcHeM6+y+rI
	+kQWMRUTwMJai2m9/gJKAHYnWRqA3TBnrVzuwYv+4hJ4gjW1yEkvhxJWQ3LpsITHpdDAl3CgqGr
	NGDl9dj5Qy9efKXg24betCgdo4npXu0BhcHGgH8N3wGnKb9/tMtiKoXHv7ZchGU67U+EjD1cg5A
	S8H5Cq1fCQZL38LyzeIfILpSQSst/96yEpcS803NJhVQLbcCEPGCbmhnZVJ7uXUHTVHUk1mbccq
	YiYvghefpmTjT9a1+hWN7VTwKkmB/IiLFhz/H/h53Q1mavMPBzMlyC8j6+0JHr3lc=
X-Google-Smtp-Source: AGHT+IGLIV/g6MCRKuipubTB9GVYmkpYIEQQohBhRaIhOj/Ez+CYSKMkODJsxMq554gdnbdi8bX1Mw==
X-Received: by 2002:a05:6a00:1892:b0:7ab:4fce:fa1b with SMTP id d2e1a72fcca58-7b225adc01fmr11346982b3a.4.1762812239386;
        Mon, 10 Nov 2025 14:03:59 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm12733156b3a.34.2025.11.10.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:03:58 -0800 (PST)
Date: Mon, 10 Nov 2025 22:03:54 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRJhSkj6S48G_pHI@google.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
 <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>

On 2025-11-10 01:10 PM, Alex Mastro wrote:
> +/*
> + * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
> + * report iommufd's iommu_iova_range. Free with free().
> + */
> +static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
> +						       size_t *nranges)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
> +	struct vfio_iommu_type1_info *buf;

nit: Maybe name this variable `info` here and in vfio_iommu_info_buf()
and vfio_iommu_info_cap_hdr()? It is not an opaque buffer.

> +	struct vfio_info_cap_header *hdr;
> +	struct iommu_iova_range *ranges = NULL;
> +
> +	buf = vfio_iommu_info_buf(device);

nit: How about naming this vfio_iommu_get_info() since it actually
fetches the info from VFIO? (It doesn't just allocate a buffer.)

> +	VFIO_ASSERT_NOT_NULL(buf);

This assert is unnecessary.

> +
> +	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +	if (!hdr)
> +		goto free_buf;

Is this to account for running on old versions of VFIO? Or are there
some scenarios when VFIO can't report the list of IOVA ranges?

> +
> +	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
> +	if (!cap_range->nr_iovas)
> +		goto free_buf;
> +
> +	ranges = malloc(cap_range->nr_iovas * sizeof(*ranges));
> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
> +		ranges[i] = (struct iommu_iova_range){
> +			.start = cap_range->iova_ranges[i].start,
> +			.last = cap_range->iova_ranges[i].end,
> +		};
> +	}
> +
> +	*nranges = cap_range->nr_iovas;
> +
> +free_buf:
> +	free(buf);
> +	return ranges;
> +}
> +
> +/* Return iova ranges of the device's IOAS. Free with free() */
> +struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
> +					     size_t *nranges)
> +{
> +	struct iommu_iova_range *ranges;
> +	int ret;
> +
> +	struct iommu_ioas_iova_ranges query = {
> +		.size = sizeof(query),
> +		.ioas_id = device->ioas_id,
> +	};
> +
> +	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	VFIO_ASSERT_EQ(ret, -1);
> +	VFIO_ASSERT_EQ(errno, EMSGSIZE);
> +	VFIO_ASSERT_GT(query.num_iovas, 0);
> +
> +	ranges = malloc(query.num_iovas * sizeof(*ranges));
> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	query.allowed_iovas = (uintptr_t)ranges;
> +
> +	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	*nranges = query.num_iovas;
> +
> +	return ranges;
> +}
> +
> +struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> +					      size_t *nranges)

nit: Both iommufd and VFIO represent the number of IOVA ranges as a u32.
Perhaps we should do the same in VFIO selftests?

