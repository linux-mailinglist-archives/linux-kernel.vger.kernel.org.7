Return-Path: <linux-kernel+bounces-854542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C45BDEAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA064FD0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F519322A1D;
	Wed, 15 Oct 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KypksD7o"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B62D0C7F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533776; cv=none; b=akpVjSVp8p47ngIjzmaW5a84gbYiVId3XNCKjKBmwh5XFHnrDDF7NFviIOSjudrqmq1Dl0ichVpgtHZS1+Kd0NkEPwQodUunPBalJKijsCUIThcfq/oQQqgwS+4lMQaBLamN/RM3Kn6zAnatyPyLLShuz3Wv46ljaaLhDy82zmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533776; c=relaxed/simple;
	bh=QaXo/9LbVR+tBaOZHohIKGkjMYP/u3JenqZBxSXMx9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN+eGn0gkuxf7uoTZSPHpEMEcAXRrh4nILRwXzqLF61/ZRge/kc81DpR0hZ6OTCfCUGDVg+U6pzRdL+QJptWxV4+iHCb4Z6C0QKAl/4UYqAXVfK/dTV0EDIghhFio6UKO2PinLEXXw08tQ23AEbZKwcUv7++a6jxA0CQDNi24Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KypksD7o; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760533772;
	bh=QaXo/9LbVR+tBaOZHohIKGkjMYP/u3JenqZBxSXMx9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KypksD7oZEmujpy6XjotRWQaxryLNjUL1a+0MJUsCZx4+fVJ1efrWNYdoLTnovd33
	 6YohNFTxHYLwUW8ZV0CgwVoT1SSoUNR17WewzGeOx+sEHOesL+fiWvjAzJiUZcoox6
	 8bQceecvY8EPTgrKyLTMBg/jvyz2DqQEEbBkm8zm5auqG/IjGg/GAlDtM2h7fjCCW5
	 zbbK6tEgM2NtoNxob1GoUUvbSgtZG3l6BoTzVmxVnObsjUGtIa/cXzNS01cjxIotTh
	 2N6ilIP2gLhJexoJyMUrGPcR2ZfUYD8PCs66Npr1wBnRsTJFU6G9TjdyXw6FJ0QqEV
	 X+gTn022pgaOw==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D472F17E0125;
	Wed, 15 Oct 2025 15:09:31 +0200 (CEST)
Message-ID: <6f1fb1a5-5d6f-4ebf-bf12-3481d360fb7f@collabora.com>
Date: Wed, 15 Oct 2025 15:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] drm/panthor: Introduce huge tmpfs mount point
 option
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, =?UTF-8?Q?Miko=C5=82aj_Wasiak?=
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>,
 Nitin Gote <nitin.r.gote@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Christopher Healy <healych@amazon.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, kernel@collabora.com
References: <20251004093054.21388-1-loic.molinari@collabora.com>
 <20251004093054.21388-8-loic.molinari@collabora.com>
 <20251006092856.02fbfd9e@fedora>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20251006092856.02fbfd9e@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/10/2025 09:28, Boris Brezillon wrote:
> On Sat,  4 Oct 2025 11:30:50 +0200
> Loïc Molinari <loic.molinari@collabora.com> wrote:
> 
>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
>> index fdbe89ef7f43..a2be3b904ca2 100644
>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>> @@ -1623,6 +1624,12 @@ static const struct drm_driver panthor_drm_driver = {
>>   #endif
>>   };
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +bool panthor_transparent_hugepage;
>> +module_param_named(transparent_hugepage, panthor_transparent_hugepage, bool, 0400);
>> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with Transparent Hugepage enabled (false = default)");
> 
> nit: I'd go for a slightly shorter name, like [panthor_]enable_thp.

For v4, in order to be consistent with the "transparent_hugepage*" 
kernel parameters, I'd prefer to keep the "panthor.transparent_hugepage" 
(and "panfrost.transparent_hugepage") module parameter name

I could keep the parameter name as is and change the variable name though.

> The patch is
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> regardless.
> 

