Return-Path: <linux-kernel+bounces-898523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBBC55759
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 941474E2013
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ECC2F9DA7;
	Thu, 13 Nov 2025 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="JGviCYxa"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE632192F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001638; cv=pass; b=JH2rkPa2Ab521G+lCQ/Vuo+61m8yjdA2PuQ3u4oJsy+v0miMC1XWHUC+OUTT1e+5Y7vPeB0UFmGqVHe99/a0vFvgAitujVfSWwa6PO0UyJQv+tnHeWLiPvRCHKPD80mD+2L8raIXOD0Ko//LwIe3mJcchWq0BxJPYSOcORNSkNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001638; c=relaxed/simple;
	bh=Nh5bCiEWcALmZHNlvkuiqoU6Qltou8jCWO7YJ0jD/2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bUBZx1j69DhNtOyaJx8bE0cMGSgL2TNiNdyJmdcVDEpz/JqfFmnlspZmo0xQ0z1/ci9LsoevlkvA7jp5t9U7taGE0ZG8bg4jPCN7ya/kklieTpfiE108sbd0YPz23vL4/frgxqwDPJ0x1cHwcEyrKHAtD3XHP3gDp6ODjtCXUic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=JGviCYxa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763001617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iyTsqEd2FhFXG6ndWp8ddjToQ7VDhIqtGT5brGbDaflRcy0yvFW0YextaL/+RlQFczoLu5NNBNh06/2DgPDFwGp27m7V7DN/MST8ZxXfMT7PF4d1xrbqBnQSG5KHOCyyVI7wby4wAzlLWtoIdyjUwLJhX3VEN7VZU9TLSZI34ho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763001617; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=t2QX/A+qd/JjOp0/QfYOpuOScoW/0U3AxoS48EJguTg=; 
	b=ARYAkchiA8nzMV0PeHivgdx4T2HhzONwxfIWLNOSsQODlxxq72OXmhNphHez97SWpVwz5DBqZHEN+d7AWxxRMCukt7M8C8UwmihXpx25VAe/6D1lTrAvBjiCB/YFZVD/D6Xf0BCJhqAr3U/Jd9TD3XSo/xZiwn0YseXSCwMlhQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763001617;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=t2QX/A+qd/JjOp0/QfYOpuOScoW/0U3AxoS48EJguTg=;
	b=JGviCYxaaDWPjad0TWvfQIUNgXfTVuksueBNirSecCUBQ9vFS6elHNvaAREykIvL
	TIXXMep56wt5niwlT63tMyp9dFPV/49Pv2NdSz+FlfHNYBDiBMhS9dDDdqLQFO2PcG0
	YS2ReGeywAWvviH1BKorp5rID5lEEb5ckBkAi6NI=
Received: by mx.zohomail.com with SMTPS id 1763001616214779.1262853256575;
	Wed, 12 Nov 2025 18:40:16 -0800 (PST)
Message-ID: <452ccee9-11bf-437c-9b12-ca21e57f6563@collabora.com>
Date: Thu, 13 Nov 2025 05:40:09 +0300
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
> -void
> +int
>  virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
>  				    struct virtio_gpu_object *bo,
>  				    struct virtio_gpu_object_params *params,
> @@ -1436,6 +1440,10 @@ virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_resource_create_blob *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
>  
> +	if (vgdev->has_blob_alignment &&
> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> +		return -EINVAL;

Perhaps will be better to validate params.size earlier, within
verify_blob(). Then all the added errors handling should become unnecessary.

-- 
Best regards,
Dmitry

