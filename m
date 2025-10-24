Return-Path: <linux-kernel+bounces-868083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F49FC044E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE73B7E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6827FD44;
	Fri, 24 Oct 2025 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Y7McdDrE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CD1FBEAC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278640; cv=pass; b=PlZMtOJz5vu3l4dRNCJs1o+fpovNcBK48bzdEkwhVwhFj2Jb68Q8YWHhWsFns2gRKqubDLWXLi+s4w1lO7PPgkZGW4h7t3nBFbsh6LO7sRTRFnUi8hdj03APrFUqUw8WE0oL0x1d4V8c3KysHhuMUZTwrbTcrRT6zCUISkcOlKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278640; c=relaxed/simple;
	bh=RVA+WZS855bqOStPebB4Gqkaty8GfAbOh8DWI+20EhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkL+qvzetT7WYgAW5iFYb41Xoros0rrBTOwi6eJd5sdT3HRtGiiOUUaamhcgaJGAsJJCkbnYbO/Q+4sRQjFHxSOWjsfcEwJiBjRcQ0QexSS5PMyka8N/cwCWrd8ZLlTPBc4Z4kTHbiORcTgU2//QDDXgnvislBgdw/BXYYAgyqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Y7McdDrE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761278607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fx6tNeu44+jKL039L9enrrNP6z1uJXZ95NSvltJ5BOrUOAkEbddYbmIabG1bPHngtMb8u95iCa1HA7r1W8YMr/726XDjIgPd93oIvwMng/IpOOFcyb5xPL2FHFzqLDJQcsrRd6lG5eJd8zGhWHmbx+82DIwpI1afxYJqWrtG6e0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761278607; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NDOaKADMyDyMltSNR68GqJBLf3lWbNHHak09GIQIPA8=; 
	b=La9emBwyAZGWyNqtzNgXhStV0Jkoj8ZiGAFTEBZU7IRjTQ3W4KCjR8sLrpW4Arp3xK+jZxxfc7yK81Lrelqy7iDUVMkzNJr5RbqlpyEF36xgd1+xPN72+R+0JZdpZieOBCgQmk34jh8VWEopWhLkU7DCtpUQzN7fnf3myZdS+uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761278607;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NDOaKADMyDyMltSNR68GqJBLf3lWbNHHak09GIQIPA8=;
	b=Y7McdDrEUghsUa599fyfeXXHhb/2MwRR5OdSddNMLdn/U26oH1Vrx+cQT90YU4Dp
	VXlhYaKJZQGmwROBKYi7fjH53erPDsz6obQ7zWh72NAY2RDPzpRO3PN6S8QOWXcRbi8
	hUAeZO6xA/QokmI6O6+U7pL1Wg+ymo2IWlqdhmvY=
Received: by mx.zohomail.com with SMTPS id 1761278605761341.5097583210113;
	Thu, 23 Oct 2025 21:03:25 -0700 (PDT)
Message-ID: <9aa46e0e-5a10-47d5-815f-8e97d42fff94@collabora.com>
Date: Fri, 24 Oct 2025 07:03:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250402-virtio-gpu-host-page-size-v2-0-0afdc8c16cb9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/2/25 20:45, Sergio Lopez wrote:
> There's an incresing number of machines supporting multiple page sizes
> and on these machines the host and a guest can be running, each one,
> with a different page size.
> 
> For what pertains to virtio-gpu, this is not a problem if the page size
> of the guest happens to be bigger or equal than the host, but will
> potentially lead to failures in memory allocations and/or mappings
> otherwise.
> 
> To improve this situation, we introduce here the HOST_PAGE_SIZE feature.
> This feature indicates that the host has an extended virtio_gpu_config
> structure that include it's own page size a new field.
> 
> On the second commit, we also add a new param that can be read with
> VIRTGPU_GETPARAM by userspace applications running in the guest to
> obtain the host's page size and find out the right alignment to be used
> in shared memory allocations.
> 
> There has been a discussion in virtio-comments about whether the
> information about alignment restrictions must be shared in a generic or
> in a device-specific way, favoring the latter:
> 
> https://lore.kernel.org/virtio-comment/CY8PR12MB7195B5E575099CD9CA1F2F39DCAF2@CY8PR12MB7195.namprd12.prod.outlook.com/T/#t
> 
> v2:
>  - Rebase on top of current upstream.
>  - Make a reference in the cover to the discussion about how device
>    page alignment restrictions should be shared with the driver.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Sergio Lopez (2):
>       drm/virtio: introduce the HOST_PAGE_SIZE feature
>       drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>  drivers/gpu/drm/virtio/virtgpu_kms.c   | 13 ++++++++++---
>  include/uapi/drm/virtgpu_drm.h         |  1 +
>  include/uapi/linux/virtio_gpu.h        |  5 +++++
>  6 files changed, 24 insertions(+), 3 deletions(-)
> ---
> base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
> change-id: 20250402-virtio-gpu-host-page-size-282c99dfe44c
> 
> Best regards,

Hi Sergio,

Curious if this feature still wanted. The protocol was updated many
months ago with the VIRTIO_GPU_F_BLOB_ALIGNMENT addition.

-- 
Best regards,
Dmitry

