Return-Path: <linux-kernel+bounces-756689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C4B1B7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FC3178E16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A4289814;
	Tue,  5 Aug 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W/g+5qy1"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C327FB0E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408937; cv=none; b=iHQC66s2x1IZO/010/r66enKvsk1XsFkBHaRw48KljuSqmoLpzM9pdrjM8E8siDvHjphbGIkGXI/Etxpv5zUK2B3JiaeejDRCGBIvdK4Z2K3Dcn2h39QH6x3OG/OqEHY8nUZeymjDgMElKVt5J5TqJsQ31Ckl4kaPn3X0KjlDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408937; c=relaxed/simple;
	bh=vK/izEOcqRroDKEjuurkSpJYsxNQb8UJ35ZS/H8ApXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P255GmWTTy4NYrkFF34gsKS7KHSpacSobei9g6JG+I3nucEg0Ha8wwxGzMF8erPUh+pstslB6TQKn5KY3gtQBd2JKs4F+H4/VdQUAqL1v+edvpp+M2Jf9UvToNhLARSUxng3UPymtNWK/1//YikqgS/vIBpxQAvN6901/oPicRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W/g+5qy1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e69960c557so435506585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754408935; x=1755013735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvWDI0NE7eWO/Fmxnrgsva4q0z87yVrAZ5bf0Zwi6vs=;
        b=W/g+5qy1N+aiSfyl9mFKLc5XnV72R6zYDFZcWQJPjqdLsHUsIAuDHiQoVtKn6Rg7/X
         rY/lEI4g0b9lR0KYltjRRceXfmIaw4vhD/meguBkyIuE1AvFreNnNY3Hp4MLtEtA6Mp4
         kQhsjLLLKKGEeV5RJ5HXVHXYdCPPq982e1ys7Pmc6IgaXWl8RckHAavhu0IjjXlbU1lR
         kIDN+nWyJOy1FauoBHT4cdDlwTrSFjjg0vASa5Vv29rmTsiYGljVq/wNdtfbi+CcD3xF
         ULs1pOsaf5ONFEhttaKQViAucOG7s1MtXIPI8WOjlIhlCa5gaOgPijOMLEiTpYacXMa4
         86ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408935; x=1755013735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvWDI0NE7eWO/Fmxnrgsva4q0z87yVrAZ5bf0Zwi6vs=;
        b=vc8qQoMYzrtL79k9hDokgvS7jSF5pwagWXEWmIKreIG0zBhxc1N/l/8d1XTvg6Pds6
         nFrCxKOg2+Dm11/QysVOX2clTi1Nd11KhXFRfmq3cbHxGd5g0Vqs2Ja/wzdS/Dt7b6Ri
         mDWCkq4TmLT2Z2NcSZkJHz+av2r9OKEEpMSL6WZcpzJi/0vdmphJGs2nZ6DX5ies+xJY
         KYg1fuhAGHJScqJjwa3zhJcDupjX+q9k9GAhv5Nxso+U5+7utBfYGoXFgl1dbIIMME4b
         7aVEEYQH+uwl7X+zMqhdo8fCC4NeqGQhCmrfg5uZGCXlyIHUPdyEtc16B/k2R3EE/J3Z
         lVRA==
X-Forwarded-Encrypted: i=1; AJvYcCXINDh7it91ggv575lGB0Q/kuv57K3bTJIBdRiGJ4zJVY1v1HMJBfRyVaAWnGF7Vhaz6fLoLEP+R3yV/d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRGCeJy6wRFFlCMPSZlVw0VR78gvErKjCJe0+luP/HNh8f62R
	45JHygTnciYyefN4E6zUIFoyO7HTmS8LT3/0z+WLJFn96uIwOiefe8BIBGJnrhIEMVM=
X-Gm-Gg: ASbGncvxlQ1qujfbvqdZ2f5ehooBIBpo5gLwfapZxZH1DltSXAaZKDt4JvX4GX9Qv1T
	TTO6bPUiIxv+8xOrnnwwUK02aPNXBsCiemf0MgXVZZsDcVVQ4xMKlBqGbQshrWVaYJNN9qOrO7A
	LJdM8ZbXXGEazaMLt5j5CnD5ZXC3R5Tb68GpibQBLWo9QxBS1nlZE0aT+vvIbxPM2jOxBj1N31a
	DBYTCPY+suE5v5zy8XZyyIxbA+fDqj+KVIUrmsAFkO2khXAn29XwrrZ/G5hjG1yMK0xZwpQM777
	RLlgEsjX8bwAXCPNibWLGz3ushWwajXaSmQlX2u4DoNvA2BZaCU58MVIdaKho51Jx+JPPOVm1tQ
	rPlBFTL/V4PWGzDihvfhgMmRkapPmy4tB+SNWhVHMoWUgt0QMMngaVRZvjocFeQMdkN4H
X-Google-Smtp-Source: AGHT+IHt6aPFR2Bw0HlJGSa/mOk3c8+BRcWZQsYV0g4OgyGhD3tGZLbn6be+rsoLdw/XIZZFhDjoag==
X-Received: by 2002:a05:620a:2541:b0:7e6:3030:e480 with SMTP id af79cd13be357-7e6963a6eedmr1890516185a.57.1754408933141;
        Tue, 05 Aug 2025 08:48:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8040a9154sm214850385a.70.2025.08.05.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:48:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJuF-00000001Ydr-4AIQ;
	Tue, 05 Aug 2025 12:48:52 -0300
Date: Tue, 5 Aug 2025 12:48:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Message-ID: <20250805154851.GT26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
 <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfac9ab6-9115-44d5-90c8-e22c3dbdb607@amd.com>

On Mon, Aug 04, 2025 at 08:02:23AM +0530, Alexey Kardashevskiy wrote:
> I ended up exporting the guestmemfd's kvm_gmem_get_folio() for gfn->pfn and its fd a bit differently in iommufd - "no extra referencing":
> https://github.com/AMDESE/linux-kvm/commit/f1ebd358327f026f413f8d3d64d46decfd6ab7f6

This patch needs to explain how the lifecylce works and why the IOMMU
can't UAF the memory. I think it cannot really work as shown without
more things like an invalidation callback.

IOW you need to define for how long the return result of
guest_memfd_get_pfn() is valid for.

> > I was kind of thinking it would be nice to have a guestmemfd mode that
> > was "pinned", meaning the memory is allocated and remains almost
> > always mapped into the TSM's page tables automatically. VFIO using
> > guests would set things this way.
> 
> Yeah while doing the above, I was wondering if I want to pass the fd
> type when DMA-mapping from an fd or "detect" it as I do in the above
> commit or have some iommufd_fdmap_ops in this fd saying "(no)
> pinning needed" (or make this a flag of IOMMU_IOAS_MAP_FILE).

It should be autodetected.

Since this is unique behavior for guestmemfd it is fine to start
there..

> btw in the AMD case, here it does not matter as much if it is
> private or shared, I map everything and let RMP and the VM deal with
> the permissions. Thanks,

I think ARM would like to do this as well.

Hence my suggestion that guestmemfd could just have unchanging 1G PFNs
and all shared/private changes have no impact on iommufd.

If so likely all this needs is an invalidation callback from
guestmemfd to iommufd to revoke on ftruncate.

Jason

