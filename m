Return-Path: <linux-kernel+bounces-760166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26FB1E748
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3C1C211B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5E276030;
	Fri,  8 Aug 2025 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz7FmYUo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1227465B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652380; cv=none; b=TWmgX5TebLfiAd8N907bQFI7ymN+OfFjRDGIwXF8ItU2mUbh9gBVmACASoT7aLfqH0ZHVn0+yQ3zJfW8kiITpb2/MFK/rYLn1joy7WFo5meSqJe/Keoysc8awbO2ytygPbPYZDbaIjCQEn/uRldFJrbfzi+tljXV9tc32zTSAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652380; c=relaxed/simple;
	bh=k0A8SEwr9YEM82RQSEfv6eQV60PVVOgkI3XkiazoVq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr3uC7yAkH7pBFz+5ypWaOJM6enMIsYRABh3b+uULaudft6vrC+YVI5TI8ddZ2RCO9o40EkVBpOjIcp4oIxjJ8MT8YMEkkrLt7lCuqfmsmB9qwLUu1A89VktjzHZLwDtLvGXjxpaxjes957oiJLpvk3yHvwHFsS2kP4TL5Edp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz7FmYUo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754652375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ07bfQKJ55z5/ZFRW4FDXltPPcwKKigW3feHNbRLXM=;
	b=Sz7FmYUovTtP/lqsoCCwh1IHCU5VUlo03QyKBH9PgkK3fWIR5inHUpNwSNNez+go8A+6op
	59c3Oj9h28vUkZcSiJwvQLwnX4+Fd4/VuLWR7FZaG7//LmoGBhAxZiu597MQM3qC9ACF2e
	dJiWLcngWV83Ya3xy6OidtAI1EB/yM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-2urKFeSxNomhd68wOXXldg-1; Fri, 08 Aug 2025 07:26:14 -0400
X-MC-Unique: 2urKFeSxNomhd68wOXXldg-1
X-Mimecast-MFC-AGG-ID: 2urKFeSxNomhd68wOXXldg_1754652373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459db6e35c3so15906475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652373; x=1755257173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ07bfQKJ55z5/ZFRW4FDXltPPcwKKigW3feHNbRLXM=;
        b=EIJaSOUae8rMY6qV00YKFmMIgh/77AVae7o67tB8MplsYL8MisVXfjUzt9nHDAGard
         aJdHWsZ5bcr5VC9GSSZOVRsG2CSBzOctTY3yzaJWH3hQnRmeXTu+c66Rch6w8Q4n4y4Z
         LJhSLDV0PloRBVK18RXt2guxz786ZcrPKP31kkMWhdytSxSiS6KNuVbVQ9dPcnJxtN/u
         NjRgElRgKEDQE/VaXg4k7I8G+D8zxC4hAOc2P1Dp6CM3VP9+um2bJKJTtBEe8nls2LcA
         hSAr6x6xRD5QcAlde6ULqexAmm4sA9PvIILXLXjdhebPnpyPNnbH01+qfJA1O5MLHAbA
         10Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWznQieD3mYdcPGna1b4kjUao41QMIoxGCxC7IdHwJTSULrIj6B+p95khygb3vOwSM/mK+4QmQp8c0wCDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw7JjjczDUaZfOi01+9AzeWDi7ECj9HAf30RfYQyvZMM/aeqE
	cfJz+VYY5VTYltfzGZJJomc5jyzuULsHJiP1XVVBftKnbHPEMEbfB0tUMLdrbzyPONixH42Tpt8
	8LUItdORVJGlS6HXHMDZkwmg+VhtfDprkrWmPzWmKJ8OWY6Y8V4kVivN342B1uweclQ==
X-Gm-Gg: ASbGncv4uQgBnJAdZY0FN/iV7PhNZFfz8KZmjV2lI6ozQAjVdyW+aDv0BMvrurGvpRY
	T/14Qcaar9qcJFDVm2phlL9jTAd2gHxyobt5EYgtaDZUHdGIfycbHd487eADzvkWqwIO+M15zIx
	7iYx1GpqHiMpP0ocvua6lM2ObOLIo7uFdqTFvmesKhKtrfwqT+4OCpa7u2emcOIZkV5WDMhlwgV
	K3FSdwVC1bNktzkUnm46HaKXfxC2YkIiTyjOSVXI6+/1hz/p1fjfdJ2PprrslcvH9SL9j0eZpAB
	V++IxkTOOK69xqTMyg3GHBfYMkUkqYG7
X-Received: by 2002:a05:6000:26c8:b0:3a5:8d08:6239 with SMTP id ffacd0b85a97d-3b900b4d3d3mr2056915f8f.21.1754652372841;
        Fri, 08 Aug 2025 04:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA9/k3yhh1VIv9RCtmLiti9qOFoG49fzaTwYSvxJDxAb5Rj0fU3D0pOzBQfzEMDyq3eal5Og==
X-Received: by 2002:a05:6000:26c8:b0:3a5:8d08:6239 with SMTP id ffacd0b85a97d-3b900b4d3d3mr2056896f8f.21.1754652372421;
        Fri, 08 Aug 2025 04:26:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm158780705e9.1.2025.08.08.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:26:11 -0700 (PDT)
Date: Fri, 8 Aug 2025 07:26:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: sami.md.ko@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
	dmitry.osipenko@collabora.com
Subject: Re: [PATCH v2] Revert "virtio: reject shm region if length is zero"
Message-ID: <20250808072533-mutt-send-email-mst@kernel.org>
References: <20250807130326.82662-4-igor.torrente@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807130326.82662-4-igor.torrente@collabora.com>

On Thu, Aug 07, 2025 at 10:03:29AM -0300, Igor Torrente wrote:
> The commit 206cc44588f7 ("virtio: reject shm region if length is zero")
> breaks the Virtio-gpu `host_visible` feature.
> 
> Right now in the Virtio-gpu code, `host_visible_region.len` is zero because
> the struct comes directly from the `kzalloc` allocation. And Virtio-gpu
> is using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read
> the `addr` and `len` from Qemu/Crosvm.
> 
> ```
> drivers/gpu/drm/virtio/virtgpu_kms.c
> 132 vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
> [...]
> 177 if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
> 178                           VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> ```
> Now it always fails.
> 
> As the Virtio-gpu relies on the previous behavior, this patch reverts
> the offending commit.
> 
> Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible")
> 
> This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.
> 
> Signed-off-by: Igor Torrente <igor.torrente@collabora.com>


Fixes has to be adjacent to Signed-off-by.
But anyway, I already included v1 in my tree, pls check it out
and tell me if more fixes are needed.

> ---
> v2: Improve the commit message (Michael S. Tsirkin)
> 
>  include/linux/virtio_config.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b3e1d30c765b..169c7d367fac 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,8 +329,6 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>  			   struct virtio_shm_region *region, u8 id)
>  {
> -	if (!region->len)
> -		return false;
>  	if (!vdev->config->get_shm_region)
>  		return false;
>  	return vdev->config->get_shm_region(vdev, region, id);
> -- 
> 2.49.0


