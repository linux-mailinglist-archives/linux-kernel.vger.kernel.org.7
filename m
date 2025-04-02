Return-Path: <linux-kernel+bounces-585558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D2A794B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D088E1895D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B01C7009;
	Wed,  2 Apr 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="O+GxSyYZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACE15CD46
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616541; cv=pass; b=g7t1nt/hzl12QOZix2VZG7wp1a5pjQ2zZNrScfBstBZ8RStjnuucBW1hkfI9inonskUVAHFeJVWctFwGEN6/5zGbBg/kZYyiLfcvL5bdz65VM/R9NLuGCpRL7BozA8gzcvEEYxBUjeDp++b6SmnyfzNsC+OGMvIX9qGwFLiRMcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616541; c=relaxed/simple;
	bh=CV6J3vXD80KJhXSYLkq+FWpmzjVg9m/5fRIn9KJLwUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrsRYJfN/Ks3eW+wfSdM++iY5utOCQPCqjXQqmXQJbTjYTtymHRb7myz31Ib2Gd/+3UYJ3U6f8qsbXYITCslZ5HMOYTSE3iMbyPEgJ507LncVcdl2lv48ElmoWrh2S0RJMV/BOjauO3AXXObf8Xp/H0akirP7n7HDYP+tgjzy/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=O+GxSyYZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743616517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dq8oFyNyYlwIijLBqUEAEtjQ9SeTbQjfZlqNM07RhuuMgjm4YfQnGR83jAW7X85wsu1agLMhmbB+R+0u1NqLz+jxKmji1yOZJGKu1j+r8+7IJZn3RcpfRWxK1PUqqreQ76CEPLY3DnmTTdKloyf8197Zx6wd7cpRE7rdqlQc8bY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743616517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4jIdQhvHBH28PFI2WuKCsKIOFiGxPR8GFY6OZ4sX0gA=; 
	b=Jn7vboabvMnnqZjwEX8skN5zCRqdf+lvFB4E52iv8LeY57yq1z//+R46g5f2h4w1jSOgowVqd6xtvyiYW050bQlLBnD0hCsP4fsU38pGdEDmVMIRSJRWRiDmm7oiBIJsT1cWj4F83Lc3OEJHpcbVQ+BypDYm3BD+vGQGLbUDZNw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743616517;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4jIdQhvHBH28PFI2WuKCsKIOFiGxPR8GFY6OZ4sX0gA=;
	b=O+GxSyYZOLPtLEpbgqBV53U0WuTflzL/GVn+HgRcBMcVK32JqJbPeY4sExwls/Vi
	wiYo/45qd0S48OWeHjSgOyG22B7yBS19ej8n7+zT/JqvAG07rtzqrz2ZXb4IBKnsFPE
	2k+n2bcq1MCTEIGmwONW9goJ3Ay/ENTvC3bKgds8=
Received: by mx.zohomail.com with SMTPS id 1743616516155342.8745540804241;
	Wed, 2 Apr 2025 10:55:16 -0700 (PDT)
Message-ID: <0227f234-8eac-4bf5-b2ba-4767936dd04c@collabora.com>
Date: Wed, 2 Apr 2025 20:55:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to
 params
To: Sergio Lopez <slp@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250402-virtio-gpu-host-page-size-v2-0-0afdc8c16cb9@redhat.com>
 <20250402-virtio-gpu-host-page-size-v2-2-0afdc8c16cb9@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250402-virtio-gpu-host-page-size-v2-2-0afdc8c16cb9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/2/25 20:46, Sergio Lopez wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c33c057365f85a2ace536f91655c903036827312..405203b3c3847a8b318a7118aa34356c839d249e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>  	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
>  		value = vgdev->has_context_init ? 1 : 0;
>  		break;
> +	case VIRTGPU_PARAM_HOST_PAGE_SIZE:
> +		if (!vgdev->has_host_page_size)
> +			return -EINVAL;

ENOENT

-- 
Best regards,
Dmitry

