Return-Path: <linux-kernel+bounces-734237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD49B07EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A1E1C26AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9EC2D1;
	Wed, 16 Jul 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB+0ML5S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5B29E10F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697271; cv=none; b=uuog7cOGwk6UIfhRkLrq4PTQuKW427ENkXotRhLT/W4G2xLj+58JAVkmNXtEkBUN4R7Nrh7vFdwCuah2NB8Rhd2NGdWCi9EQgAB2fdSEGRdnjDaZ0Dk7mR4ca9B9Pj1OMmvHS1QAgOrg+IJcH4AAOVnsHDdf4WPkSa7U4FBEN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697271; c=relaxed/simple;
	bh=t88KmbHyB44bbJ+m9XJjRdiwTs2vrpjOGUTpqW6GDSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nuv8eIgrcyvPbc8rVVDkaYC2T58OqvLk0IAeY7aXueJUOD+8DDQd4Vmhb7h1QxlhtdjvLrTbNGmUdkFOQIeN0NJ0yvHR1A7UduXoDJyV6BZTmTOHCGhE9maNN3VrQPqZb4Fd5S3whIBNtIw0uL88dEv64PR1T3EJnmirkb/EUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eB+0ML5S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752697268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KRyfEizDervzB9URwnxaW4EOZooRbX81eT+I8qjpbU=;
	b=eB+0ML5SU+KGaHrV3yTDWWyUjOave5rSys8igqQ/pC+oOOpC0Dp3FRmZe+cLE8Pg/dtQHQ
	xNUzxS0IzCpB0FtR1hcuXgQm4oRjtYOW30i5Covj4l29XTOKwiBzKkE3TPDYRx4d0bbw3I
	fGeLAnTwE1gcYcA5+gavT8HyHES4q5o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-SEGBciPQNqm67YQ2uggp2w-1; Wed, 16 Jul 2025 16:21:05 -0400
X-MC-Unique: SEGBciPQNqm67YQ2uggp2w-1
X-Mimecast-MFC-AGG-ID: SEGBciPQNqm67YQ2uggp2w_1752697264
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87a17c254bfso5473639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697264; x=1753302064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KRyfEizDervzB9URwnxaW4EOZooRbX81eT+I8qjpbU=;
        b=a1kjSoT+LxI6ib4kEWaYHTPvVdj2HUOUnMeNu+dcBc6t05PfAI0IGq2aScWxPT4Rfh
         8bb7q3VgeKVAXPkzylM6GfZodyi736XGh/vr0IGx0Ks8SZUTH/fEg/Sw9tSF+FvV65yk
         GTueH41reGtz6WMIU9NOm6IMd/7uDBohvVmt19CvNCRLjJKGRh2VfPIKexExuYEHx4pI
         aGtm/L5dN0ySaWG3wCJX7/Wdit7iNZ1//aSeyxD2481B4dTb2oBNRDAZNMks0G8L7djd
         7KI1gLaur1ocUS8/xJVeg5BlmNLpPAqrMjQP2eowk6JqX6165PbvGabUzL+b1mEoLF1T
         BhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcXe7m5N+evMcbv1bXS1dGqOkg9PCv6OApcXwfeYqn6etEiibX0zim9B2EvYo17Y6k9N1PFavPVPJcYUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDU+6h8aIB5beAmKWxEMuOGXrZOtTbvP6LAfBzgWrc/IwNRwiT
	CdegcunXKxfuWVBkjFlqI+sfBusJIfUA/VLB91QJmeAsV98yS5ubojMjNYMGYIUwq0lmyDnWPRn
	yS7HdGTPkvV1Ndg3snp3h2+U/oA5Gm5yQuIciGNiWQFJbVjEn5OC6G5ghX93TBgpLxA==
X-Gm-Gg: ASbGncv0Wm0x0Z0RCO3v3mGnAnBEdlsMQQmz08NPqwz5DU3/mVsBaXNA4aW/DC3FIlF
	mKTEgD0NqjKudGU6NhxlPv8r66eydpCRAxcutUI5CdyaZJaPFFBGeOE2/qed4LU13qxiX4GLqI3
	moubp+CFCh4paLCaRC/g3MfmsgiadoRX/TkRN9MZGKrCJyouPwbRPWb0X2f+9mUTmkF+Aw+Dtwq
	x16QY8Yv/aAa3xj1ASv17/HEICFleD1j4N2pYTKNPIE3HDGP7mTb0F8cWauFfpnjwAcFFsjAmnp
	YTP1HXo+nwBn8Vi+AEb2houVUWJrXWXqH27Ofj1+8RY=
X-Received: by 2002:a05:6e02:4408:10b0:3de:2102:f1dc with SMTP id e9e14a558f8ab-3e282306bfcmr7967285ab.1.1752697264412;
        Wed, 16 Jul 2025 13:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyWD5jsgxIGv5H+miLBNx2eMzeqFCQfVYPaY0j+ulJJHdS7tIZYNZrZSZdkdlShI617odZGw==
X-Received: by 2002:a05:6e02:4408:10b0:3de:2102:f1dc with SMTP id e9e14a558f8ab-3e282306bfcmr7967225ab.1.1752697263897;
        Wed, 16 Jul 2025 13:21:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611ce92sm45232005ab.6.2025.07.16.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 13:21:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:21:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, david@redhat.com, jgg@ziepe.ca,
 peterx@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] vfio/type1: optimize vfio_pin_pages_remote() and
 vfio_unpin_pages_remote()
Message-ID: <20250716142102.1db0ec85.alex.williamson@redhat.com>
In-Reply-To: <20250710085355.54208-1-lizhe.67@bytedance.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 16:53:50 +0800
lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> This patchset is an integration of the two previous patchsets[1][2].
> 
> When vfio_pin_pages_remote() is called with a range of addresses that
> includes large folios, the function currently performs individual
> statistics counting operations for each page. This can lead to significant
> performance overheads, especially when dealing with large ranges of pages.
> 
> The function vfio_unpin_pages_remote() has a similar issue, where executing
> put_pfn() for each pfn brings considerable consumption.
> 
> This patchset primarily optimizes the performance of the relevant functions
> by batching the less efficient operations mentioned before.
> 
> The first two patch optimizes the performance of the function
> vfio_pin_pages_remote(), while the remaining patches optimize the
> performance of the function vfio_unpin_pages_remote().
> 
> The performance test results, based on v6.16-rc4, for completing the 16G
> VFIO MAP/UNMAP DMA, obtained through unit test[3] with slight
> modifications[4], are as follows.
> 
> Base(6.16-rc4):
> ./vfio-pci-mem-dma-map 0000:03:00.0 16
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.047 s (340.2 GB/s)
> VFIO UNMAP DMA in 0.135 s (118.6 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.280 s (57.2 GB/s)
> VFIO UNMAP DMA in 0.312 s (51.3 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.052 s (310.5 GB/s)
> VFIO UNMAP DMA in 0.136 s (117.3 GB/s)
> 
> With this patchset:
> ------- AVERAGE (MADV_HUGEPAGE) --------
> VFIO MAP DMA in 0.027 s (600.7 GB/s)
> VFIO UNMAP DMA in 0.045 s (357.0 GB/s)
> ------- AVERAGE (MAP_POPULATE) --------
> VFIO MAP DMA in 0.261 s (61.4 GB/s)
> VFIO UNMAP DMA in 0.288 s (55.6 GB/s)
> ------- AVERAGE (HUGETLBFS) --------
> VFIO MAP DMA in 0.031 s (516.4 GB/s)
> VFIO UNMAP DMA in 0.045 s (353.9 GB/s)
> 
> For large folio, we achieve an over 40% performance improvement for VFIO
> MAP DMA and an over 66% performance improvement for VFIO DMA UNMAP. For
> small folios, the performance test results show a slight improvement with
> the performance before optimization.
> 
> [1]: https://lore.kernel.org/all/20250529064947.38433-1-lizhe.67@bytedance.com/
> [2]: https://lore.kernel.org/all/20250620032344.13382-1-lizhe.67@bytedance.com/#t
> [3]: https://github.com/awilliam/tests/blob/vfio-pci-mem-dma-map/vfio-pci-mem-dma-map.c
> [4]: https://lore.kernel.org/all/20250610031013.98556-1-lizhe.67@bytedance.com/
> 
> Li Zhe (5):
>   mm: introduce num_pages_contiguous()
>   vfio/type1: optimize vfio_pin_pages_remote()
>   vfio/type1: batch vfio_find_vpfn() in function
>     vfio_unpin_pages_remote()
>   vfio/type1: introduce a new member has_rsvd for struct vfio_dma
>   vfio/type1: optimize vfio_unpin_pages_remote()
> 
>  drivers/vfio/vfio_iommu_type1.c | 111 ++++++++++++++++++++++++++------
>  include/linux/mm.h              |  23 +++++++
>  2 files changed, 113 insertions(+), 21 deletions(-)

Applied to vfio next branch for v6.17.  Thanks,

Alex


