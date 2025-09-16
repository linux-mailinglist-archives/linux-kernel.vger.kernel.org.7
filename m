Return-Path: <linux-kernel+bounces-818342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBDB5902D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1290717B5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FA23E229;
	Tue, 16 Sep 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qK9yMZfU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC287242
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010568; cv=none; b=nffBuPiUD/AY5QpeKU0KTnebbLqj7r5FiDnocJc2iEQXYdbfSehMpvaHX+2OgNgVMdE6ikZiN3RIIDvetK7YkuE/pe1H9tAJjvE0F/PhatWFb26hi5SMPfcS6/UbvAAg8+mZGpOZzyIQCtHAc6QxbnPmRdAS9x/FQp41hSsYfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010568; c=relaxed/simple;
	bh=m871iIeOfCazaoSPmTALTlNsX9LyCc0jz8OY6/Cozzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz4lrFzF9xF27kfI0pRX5o44fOjPpV0uwQBxZZVSkEf5f0v7b19V8J8AO9ZHtaBWBop1xAfCc6Th4EIyCVN3ckmYht0lYr8cO+esQ28O8bN2PDsxtxkaHy/3QxPerUt/TqZCChN2JTqcvkWfTtAHyIhD5N1j4O+ES+Fc3Q2Cylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qK9yMZfU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2f894632so32225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758010565; x=1758615365; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meShyEXsOGbbZChp3RRq7DlLygLq0PznBxg+g8h90lU=;
        b=qK9yMZfUFhomlZOxP5M9uB3D5i1WaJVdnheFuvyzrmRcn9GxDLN4q49ilSYUbET+qr
         kHM/VtPWZBqpTv6R8nMYIucJZINuuVIg0NuSJqJazlpmhkg5rq56tExo+7EdLKsVHozL
         Ln9RDObO+kUJz7D9LqK69HNi4fC/WHwR1FQdZXqZYY6g+vo2i8jvSDVU8wS+vvzHxUbJ
         HoBc1gFDEvJb0F4MtvzO0OxEBrVCeIUhQYvaa6ST1GyXDlkYWRj4G1Lq1vur3/yzi2JV
         it5oG+O69+65Gm6InXBSYSV1PwV9x2MIoKkrYQYmqN2wsd2xqQPWvNpQANkBvbHw4Vzx
         hv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010565; x=1758615365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meShyEXsOGbbZChp3RRq7DlLygLq0PznBxg+g8h90lU=;
        b=nV5kq7z4bBL6YyZnw9TXp0bUsjdHa/eICTFIsLEumXPtCf1ZUacLRuYY2EwUYjVtkk
         EfvaDGX1I0y9GyUm3oPc5aBEgAad8kF0t7qOum1pVyldKJc2WVPR0tuYDxGBE9z8J0Go
         dLbxNA3Bd+ije/VqtF246P2FsABkQzvML/5hPwelN4uh0DD3rDr11p8EXk5EqTbAn0eA
         Tatk2LDd+DHLTj1Pnmih1IPPclOlkuYQFd8yaNon/gJZkJRjf0ui9pkvDA1dmwSiPo+l
         EmEw0hPzb9BIZgm5TidBR031bWM+UQeSRigwFwwWdX+S4YBDxry+14a20BvxCkQ4QXiF
         rLGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV3bsYeAFOjvq17HfrBNE+6eeZIu2vYJv0WlMpwOsWDX6ZMsjqyO6ZV0CeSBv8Tixx71okujsU9cbD3HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQzfR5BsvLxSsVaIqVQEemAI3NisMr9xKE/EQ8neaiZ1lbPSA
	oX2NVw4oMiDZKKqqtg73KNrse9FSPiILgaagHNEStNkKZu/gAFRtcabN7fqdn+uUJA==
X-Gm-Gg: ASbGncvXn53hVBGq4ev4oQAvbX3T3DvtxBmc/wm+ruZbs95v0jTdFj565dGx98MSbBQ
	n9IMptyujjES5nhd81h9eCz66ez5etWTFcmcXl4Ni2aBfYwRXpKsWqYSsYad5EUBVfxDEtys0bJ
	/cjBM1joj7q9fiIRAOElnUuT22eCGJ1/LabSc39GWEsh8PGi98cyc8/tHpsU5z2wvyIP9Od+Z70
	KpOR4BD1gHVDPxfY6IsQeHbS1JbjZdHIfV53n3J7devd7yjz6QJlSa8tnTBLaLuciHej5O5LcYh
	l3+GnyL1kESIl/cBTKNRE7ohbcPTtKIqztpzucoWMzG6/P26Ga84Szmx6fB4BMP0hlPAycNda8r
	4dqINZ880EaGriaOp4vX2jMJXGCRyCY0hutRKzmjFKp/oj1/M8vYxaW6TXW3/3W55mL3uGA==
X-Google-Smtp-Source: AGHT+IHNkoboGHrMun5G1DUGWBcXZWuBWQV4A74ZxNJ1t1bghrprssY/hv3V1PDkdyjCOmCzxhKQPQ==
X-Received: by 2002:a05:600c:2d08:b0:45f:2e6d:c9ee with SMTP id 5b1f17b1804b1-45f320ea054mr964325e9.6.1758010565354;
        Tue, 16 Sep 2025 01:16:05 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm217980535e9.7.2025.09.16.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:16:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:16:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <aMkcwZpr84eMc4fF@google.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <aMfQCoLuVeR0nf02@google.com>
 <yq5a348n823t.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a348n823t.fsf@kernel.org>

On Tue, Sep 16, 2025 at 09:45:18AM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > Hi Aneesh,
> >
> > On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Currently, we enforce the use of bounce buffers to ensure that memory
> >> accessed by non-secure devices is explicitly shared with the host [1].
> >> However, for secure devices, this approach must be avoided.
> >
> >
> > Sorry this might be a basic question, I just started looking into this.
> > I see that “force_dma_unencrypted” and “is_swiotlb_force_bounce” are only
> > used from DMA-direct, but it seems in your case it involves an IOMMU.
> > How does it influence bouncing in that case?
> >
> 
> With the current patchset, the guest does not have an assigned IOMMU (no
> Stage1 SMMU), so guest DMA operations use DMA-direct.
> 
> For non-secure devices:
>  - Streaming DMA uses swiotlb, which is a shared pool with the hypervisor.
>  - Non-streaming DMA uses DMA-direct, and the attributes of the allocated
>    memory are updated with dma_set_decrypted().
> 
> For secure devices, neither of these mechanisms is needed.

I see, thanks for the explanation!

Thanks,
Mostafa

> 
> -aneesh

