Return-Path: <linux-kernel+bounces-836501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD62BA9DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAB3B4CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D630C0EB;
	Mon, 29 Sep 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BKhiGetN"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0921770C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161089; cv=none; b=Jim/DB8ddHkQ0OydHWq2OJTUJyfxk2y3S+04cG5P0EWJFHSXjqUt08tHDyYYdcfFbXzOFh7mXPfZf7AM/SjEjPpr0mYYcsbuX4eJQivsqSR1I/FiAxYgbDxGw8YB+Cx1xBSkSdU8E2VPrsUzuyRvVFhhDC86DqdAEiq2K7C1TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161089; c=relaxed/simple;
	bh=j12PYgPvI4mST8WYTzVIepUS1TEez0LNB32yuIJo0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXpYEpqn9pU31b0N85KW6cn0CsOymthlcJul6TBrGBWisgF9fg6Q394BMRSTWmt0dMB1iDQ5GdyARjXn3ko526JSxZkR6W9NaPvAi03PgLFUEXFOkNt4IWgavk3ofNtUYc0FhdaLUZW0CYPxWFKTsheaROHUlQfTTztjVliaSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BKhiGetN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ddabf2ada5so45516451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161086; x=1759765886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Put4MtO4NY6a2XmnhJf3sCRZjJgIgJeqBjj8elXuKDg=;
        b=BKhiGetNPp3ijcb/bg15X9aJ16NDLpbPESCgB+lfJPPniXLTpjC8wduyp1TnSCmn6t
         9jaLiwQ2H9+pbvCI6p4AeaOrxQYyE9ZWh13VUL1sr4doQK98nEUgMcYSCmfxw8jDG+lW
         F2AH6mlILAlfws4ezWaLwM6kWnq9Si7ua/nKt5Mkevq8u721u/YcXzoRl+XMmID7JN1h
         hV8zewb+uhE7Nd4JoyruzT4SYCgl0iQYJ4irjomTaPsq7fOteV+RDRbK3A6sfOowDkFV
         JIdfSwuQIpS9/gz093UXH6s5DLLhvjOecY2P5ZrQFfg9+SkQs1X6amf/f9bBSNMw+gqu
         POow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161086; x=1759765886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Put4MtO4NY6a2XmnhJf3sCRZjJgIgJeqBjj8elXuKDg=;
        b=NBlNKN3m74xKbv5r1DAhy/7ZiccwvJn9wIZ8DO2MRwoWn0Is/BP7MkmSwqgjgEYQHx
         rcA9ORSvexqyOT4nZotfPJHeWBd4GJh1592tr1bNdgY8KTfdg2s1NmdSYhMyO7BrBb2a
         LikF7ueDfzHV+M78I3O482+uzEaIIxeZH/inaXJgA2k/PGptjIaYpHsblUanIi1TEvnd
         sJ4PibTvvqqc27xQN5y8GjXpDJXJ/iRqQoU1XsnjJ5qzxerOuMlWRtIHbGf7cbZnyUKz
         l3ra35LJ5NLf+bVvogFtGTNH6/hzueKO9c3AlPwjMOiTPuH4yibfqqkRpbecnEs7B5J3
         U5rg==
X-Forwarded-Encrypted: i=1; AJvYcCVCTyHvfj5YLAsBhRnXswoKQWKm03BQ1kh/lAeJ/m7lq0GjbcZZYCpRpGKIqpUjNqBBNqddEo4Q+MQpPrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEl0XMuU2nx2Qe8u+WbagzqZuVNwhVtP47TLIxIrd4dzctxM0Z
	MMpocGxzjplIH3D3fEP1UrHUYziYugjK0geuf4SdlW2FYZnaa2CZowIC8aW57fiCmCiG54HpOBg
	9U4cFyPA=
X-Gm-Gg: ASbGnctRhECqgbvGJpvsU1hdRl9mpSeG2md42RuRQSw+vlQthaFLvNSaLEOOi0ahwkq
	UKxY8b91mpupRJouObVk0RDqUET4MijGmELzOdSmewr42pm4X9b7WPQWfb9YoRiIHD924Chb04y
	2HZ5BjWtfMFg4bJ6WM3qNSrWNzOvx1CA8UspfkyJYK6VmxEkDnU6LcakJ91ECpyC7hcUxa8UMVn
	RnEt94ilIRcbAHigA1g/6+uflGRWNxSmYrHANulSVa3OSQfl430++M203OkEgGNrT8g7B/3u+lr
	lUxP4quGO8WAVTjudmmUbR0fhdCj0hS161HDpP+92Dd+P4xgCNf7+2E11Yb1fJA7oXjZ32Kh
X-Google-Smtp-Source: AGHT+IGgK/H6E95ZEVHjccaoGgpq05fPxt0rIDHkithQ/hz8a0kgKH5wKvNfO2Kv1RxwdJoxGAgPtQ==
X-Received: by 2002:a05:622a:212:b0:4b5:ed9d:7bcd with SMTP id d75a77b69052e-4da47c05749mr321551731cf.16.1759161085754;
        Mon, 29 Sep 2025 08:51:25 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db108726a2sm79374111cf.34.2025.09.29.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:51:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3G9r-0000000CM2n-36dx;
	Mon, 29 Sep 2025 12:51:23 -0300
Date: Mon, 29 Sep 2025 12:51:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 03/15] iommu/vt-d: Prevent hotplugs when live update
 state is not normal
Message-ID: <20250929155123.GC2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-4-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:11PM +0000, Samiullah Khawaja wrote:
> Hotplugs should not be allowed when the live update state is not normal.
> This means either we have preserved the state of IOMMU hardware units or
> restoring the preserved state.
> 
> The live update semaphore read lock should be taken before checking the
> live update state.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/dmar.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ec975c73cfe6..248bc7e9b035 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -26,6 +26,7 @@
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include <linux/liveupdate.h>
>  #include <linux/numa.h>
>  #include <linux/limits.h>
>  #include <asm/irq_remapping.h>
> @@ -2357,6 +2358,10 @@ static int dmar_device_hotplug(acpi_handle handle, bool insert)
>  	if (tmp == NULL)
>  		return 0;
>  
> +	guard_liveupdate_state_read();
> +	if (!liveupdate_state_normal())
> +		return -EBUSY;

Pasha, this is madness!

Exactly why I said we should not have these crazy globals, people are
just going to sprinkle them randomly everywhere with no possible way
of ever understanding why or what they even are supposed to protect!

There is no reason to block hotplug. Do the locking and state tracking
properly so you only manage the instances that need to participate in
luo because they are linked to already plugged devices that are also
participating in luo.

Jason

