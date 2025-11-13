Return-Path: <linux-kernel+bounces-898503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA6C556C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51833A5392
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA22F6576;
	Thu, 13 Nov 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ewVT+7dU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C318D636
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000471; cv=pass; b=YKgsQrh9SOqNTw9tOfuolnyUCMbjEgk0XFvabliKdQkOIh7w0P4zf9LPUFxtUSgLdkFbvBwPHB/9O3AOvWV16SmwK4cCREkRCG+Ve3glsaYtUNJ8IsvSMtHB0P/D626AJP/xI91f2Jwb4rgZsJZoRnphIpxnM5CnjTiXwiYLRdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000471; c=relaxed/simple;
	bh=+gfd7j5QAgc9EpQwQVrF3LjbXXI1A6wHs5aGlkrFkWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2zNwYEENOVE+8i2wvuCRU+alBLeRLVkQLrwsX1jo1sneBsikUOsNwOZI/ufnntn7pUhVZEZpYm8+RubyZVMcgjImgvdB8Ryu+gbzuOypzZVUpUELOGaYiwO5O4tmilu6FEX8e6I6s/7CapGyRroyLazadYaxr49OANtnWHLAoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ewVT+7dU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763000452; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kmYOQaxioT9b5FLQ51Jl3oYVHY06BtNudAk0KzUakVNkhQ/EBiCMDfV5Xou9XH2H+iFNStnj92rooJRlrfJg6QqRpfPLh4G6iiQ73FSCKlZpIf7lbOsmSFjXEp9EGwIaeCQOQKPuYjkiW61hVc5nT9Nz7LURBVA1KD4BEBp7J2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763000452; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=CXbCEYcoIZPhCKLcaNaYTRUshcOwu+FGWa82wu+M1QI=; 
	b=aRrDgyATyFQFm498va5cwdmPwrDHf0E0xL4a1jFgkYs22kE2el96hSV1SEoWETzp2G3Uvgfz9ZiIJQ93L7V1ZSi/yrJyJr+3tXdEcZ+ql4HzINY1zklP6BS4X2qOT4Dgy6o0Xm3vZ4ywwQMgN0JmNhn5WV4RKaWjkK1Ayn0vtGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763000452;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=CXbCEYcoIZPhCKLcaNaYTRUshcOwu+FGWa82wu+M1QI=;
	b=ewVT+7dUej6DO3PGZypeXdikOfDqH8ybtF9oPhy5bgrD9tbxNiryBKL9A4vxnTYy
	AxqQvyxUUk/qnPKQmL6eK7hVNOaHQS8I6CBtY8vRTdf7eJk1rJdwZfjcpqsxxLuqkMd
	gwXRnNnBAacnb/VcjxGmr3HFpmeymJ+qTgMXNGVY=
Received: by mx.zohomail.com with SMTPS id 1763000449665737.2364341632508;
	Wed, 12 Nov 2025 18:20:49 -0800 (PST)
Message-ID: <43c1ee1b-a9be-489b-82f6-0f4d24a409d5@collabora.com>
Date: Thu, 13 Nov 2025 05:20:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/virtio: honor blob_alignment requirements
To: Sergio Lopez <slp@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251110125213.12633-1-slp@redhat.com>
 <20251110125213.12633-3-slp@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251110125213.12633-3-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 15:52, Sergio Lopez wrote:
> @@ -216,8 +216,14 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
>  		return ret;
>  	}
>  
> -	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
> -					    0);
> +	ret = virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params,
> +						  NULL, 0);
> +	if (ret) {
> +		drm_gem_free_mmap_offset(obj);
> +		kfree(vram);
> +		return ret;
> +	}

virtio_gpu_cleanup_object() shall be used to free obj, otherwise
resource_ida and etc is leaked

-- 
Best regards,
Dmitry

