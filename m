Return-Path: <linux-kernel+bounces-898501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615DC556BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA373ADBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1918D636;
	Thu, 13 Nov 2025 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="B6TsU7WV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FC2F6563
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000433; cv=pass; b=oMcnOr9jDd1XaIb6N3jzC1VBsolgNJqssNuCkMbGz1LpiYxPCa//6wEt0nAhVTzmHapjqD9POnW1Wz1jgcqVqIp9rtuBHks8OJCf4ATob8qWa9o8RMaUgaEh/Qo/XJl4OY/RIGnF8edDxSY20Y0TWzGIeYJhAs58+c/zjuF4EEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000433; c=relaxed/simple;
	bh=HqOdbn19raCLnfIYLJqhZBbMpFYjRxv54iPmZyG9sL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NOYvFQ5Uq+7PV110eBcQVwXwEsRuImzCwB4GwSdHEpoz5+R7o9pIGLi4NnXwDV2GQspB6BwlXPA+BrRwFmhGqeIr9+OoLjSM7FtZ+qHw0/NsqxngwZAdsgzem6fsDqJ4e4mFMCVOVU0OezR2BxB1FhYimM6k56PjyxMm+ILuY84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=B6TsU7WV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763000408; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LSZ6LEO1NqTQQ8wn6RID77+aUyvkfdEi/nD/Hs+PhvX44sOI+Y5wcy27ozk9SiUJRikt60phuQs4G/uBNU9m2Q/b2MBv7XApM4lLnuFDtKxwZeaeVFERKo38S0hZLR7oOJVzr1CSgthpoKzJ5d8laBFN99v6IpddxCEgiYF8w8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763000408; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=yHrOo7Ig/iyo6ppLbPkyZ8m21XafQfUqYyXwsyWUUhU=; 
	b=Zoc7zmHwMQXxoFWevZedsRvwHBPNo7oj31vIpN6M+hYH+aIFFELcZdA4fpNtAUUM72SNCRhiRlzVGxxPxWTULN72JlaO1twLmW23PYWNygJEA3j75RNE8v/SofbyoBpiemMQEF0zejwp/0YzzJGtFX0bpfdnMy1iXydvtxWQQ+U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763000408;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=yHrOo7Ig/iyo6ppLbPkyZ8m21XafQfUqYyXwsyWUUhU=;
	b=B6TsU7WVwFTP8eHwOg4CkgwSsjDk/cV0g3MG2PFeyz4R+IaulaalppdqX6Tkqvqu
	ApJHu/JiZodo6vz4nKph6ZfAsmNtQTKZM2y3ICA++drFmAZmWiUreJ7swzoY1ZZUfIJ
	NyfaFrNg3DmAGMIRZdf+KFVN0bHGD60QSxL3szLk=
Received: by mx.zohomail.com with SMTPS id 1763000406300353.34661766299405;
	Wed, 12 Nov 2025 18:20:06 -0800 (PST)
Message-ID: <e89054b7-1914-4b06-b36b-bb7a3b03ba34@collabora.com>
Date: Thu, 13 Nov 2025 05:20:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
To: Sergio Lopez Pascual <slp@redhat.com>, David Airlie <airlied@redhat.com>,
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
 <20251110125213.12633-2-slp@redhat.com>
 <855ebbf1-0b02-45b5-8fa9-b50c05793e19@collabora.com>
 <CAAiTLFUbJ-YpV8+05PofXpmgOu=gNmUh9L6xgj_w80_mf7z8Tw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAAiTLFUbJ-YpV8+05PofXpmgOu=gNmUh9L6xgj_w80_mf7z8Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/12/25 19:49, Sergio Lopez Pascual wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 11/10/25 15:52, Sergio Lopez wrote:
>>> +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_ALIGNMENT)) {
>>> +		vgdev->has_blob_alignment = true;
>>> +		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
>>> +				blob_alignment, &blob_alignment);
>>> +		vgdev->blob_alignment = blob_alignment;
>>
>> Shouldn't blob_alignment be max(guest_alignment, host_alignment)?
> 
> virtio_gpu_config is the minimum alignment required by the device/host.
> If the guest requires a higher alignment than the device/host, I would
> expect that to be found by a different mechanism, as it would happen on
> gpu drivers other than virtio-gpu.

Alright, perhaps that will work.

-- 
Best regards,
Dmitry

