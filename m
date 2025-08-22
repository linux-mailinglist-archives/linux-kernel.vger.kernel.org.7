Return-Path: <linux-kernel+bounces-781614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1DB314A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0B63BA75E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417F2E3AE2;
	Fri, 22 Aug 2025 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iR6M0zai"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4FE1BFE00;
	Fri, 22 Aug 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856552; cv=none; b=Fgzhqe6ElfxwEJHsY8O6Si2py5uVdwHdKjjFRTlmViuydQ9/jpLajY4i5jcaD8uEDmP3w8BqoqlNkMoDo1IqF9Eoro7zUHJWL0kgYgNtgPC5j2ZZI+tfeZP2n3bD9/mH4zMBtNSU7egCv9Lo1PWU442Xg/tBJAtH6DEjEs5ONpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856552; c=relaxed/simple;
	bh=wDBEFLPmjwZ34IQiVCdIlZcm6IWKZupOgrJpMtnNCHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWvdz8zjYtirom0diw/deYc7ays0SaXUuJpK+wtp0vw0+DkGmlu8Ez3nRIClJtrmsRSycokmmpgaQAhzAZ3SN1sqSSaOJkQXoZnN0wCqygCEJjDrWkpnVsTbMvKozbqyhh9mnVn9lA3ct0hDGbIAmpuKdYsrx5GSVFhWEdJ19rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iR6M0zai; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755856548;
	bh=wDBEFLPmjwZ34IQiVCdIlZcm6IWKZupOgrJpMtnNCHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iR6M0zaiYMA2yFuALx82u4oDmOKHGSeEiIhs1GHiUYYJLl7nht3XMF+wws8gbctsH
	 ACcPY4iR09B18G6iNAP2inGyRxrD6LDxe8NLjau3ZTjRfNdCBomeQezyOqiNwKkhlK
	 JG96pLqUosQ62t1qgM1RWyOBSZg3dgxWwyde6XFuIwnrR7+xM2B8gOG03Awrv46Pej
	 4olr90PnPypIbb/fF9ka1mSJ+ywWLUpqZV+0SYopofXo5d/UqquFYNFU+xzeTiDG25
	 ZRYHaIXYyrQRdeSGDQT9KWiPeznzrNOkzRyIJnCcvQSYEtxYQcJwiOs6ecdrph4Q4x
	 PDCAZJW1/nP3Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CEFB517E0C54;
	Fri, 22 Aug 2025 11:55:47 +0200 (CEST)
Date: Fri, 22 Aug 2025 11:55:43 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] gpuvm: remove gem.gpuva.lock_dep_map
Message-ID: <20250822115543.62094f53@fedora>
In-Reply-To: <20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com>
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
	<20250822-gpuva-mutex-in-gem-v2-3-c41a10d1d3b9@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:28:26 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 5934d8dc267a65aaf62d2d025869221cd110b325..85a25bbb387c4590678e4ba243b51acd94b008ed 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -402,17 +402,22 @@ struct drm_gem_object {
>  	 *
>  	 * Provides the list of GPU VAs attached to this GEM object.
>  	 *
> -	 * Drivers should lock list accesses with the GEMs &dma_resv lock
> -	 * (&drm_gem_object.resv) or a custom lock if one is provided. The
> -	 * mutex inside this struct may be used as the custom lock.
> +	 * When DRM_GPUVM_IMMEDIATE_MODE is set, this list is protected by the
> +	 * mutex. Otherwise, the list is protected by the GEMs &dma_resv lock.
> +	 *
> +	 * Note that all entries in this list must agree on whether
> +	 * DRM_GPUVM_IMMEDIATE_MODE is set.
>  	 */
>  	struct {
>  		struct list_head list;
>  
> +		/**
> +		 * @gpuva.lock: Only used when DRM_GPUVM_IMMEDIATE_MODE is set.
> +		 * It should be safe to take this mutex during the fence
> +		 * signalling path, so do not allocate memory while holding
> +		 * this lock.
> +		 */

To follow-up on my comment on patch 1: this makes
drm_gem_object::gpuva::list the only field to not have a proper doc.
This patch is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

regardless.

Thanks,

Boris

