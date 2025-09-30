Return-Path: <linux-kernel+bounces-837906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575ABAE04F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36734A3435
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41303090FA;
	Tue, 30 Sep 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kipK6wKf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403812FFDE6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248584; cv=none; b=Onw0YFGFObZ/oXuy/3oK8rSbmvKvrq9fgECvcOrqsGNwyONSEFKUJzPGYoPGg31IACZRnwSP8nU0IfnNjo0yDvYBhOBSNMlTZGeVV++EFEG4go3vRGr4zr5B8l18eW8/BvLKHl8vW1IBEVC7QB6aX8W9DwRZMrgnah7xY/6gh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248584; c=relaxed/simple;
	bh=zNOqW8q3K8VzrkGpGhn/Rwg2ryt2C/LYQAHlbYXM5zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKBJljXlbcuOYX81bN47O3LnJIpLSxjIi1OZPA5udol9J7xbnsICeFk59pHYU2mey2fi9sf++6ndXWaxEgWqYKB7BOI9UAjq4jYikKWA6gfHJ1IhljBXtSelz1NGN92TZMkldbO6X2iTd2kytGG3tgJtndYjWIEg9E5fCin2Glg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kipK6wKf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759248579;
	bh=zNOqW8q3K8VzrkGpGhn/Rwg2ryt2C/LYQAHlbYXM5zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kipK6wKfCNDwXwPqAORdhW6HgjiNlNdE0KuHuBqz2AHHfRWmbcMjSrLfFIdXkLnpz
	 p1M8hRm8VMktfTq1sULOVF+By7uOvMef3OfFPZW2hlzz9zlCbIZuc7sVIVHE9kTpDv
	 Qzqu6Gi2EkT6BOpsLFvjVo8Hz++DRwsTFSAf+jF2WKYTxEx1pDJurafyWxK1JdrQnS
	 tPyt36VADlrD9S+otqgz4MoUQrrys9qZIfE9zLIvuFBzDQ6R7DFGoXNhgUS0YjSY+V
	 xuFkAzEubr5lEy5gp9gpYnc0Y5/rMd3WqyQMhvoOhvrdT5DBqq3Uh1o5d3t1Q/3q/G
	 F1rT/b30CeMFg==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C64D17E010B;
	Tue, 30 Sep 2025 18:09:38 +0200 (CEST)
Message-ID: <cd9084e1-16d9-4fd6-9c64-1876d53d5225@collabora.com>
Date: Tue, 30 Sep 2025 18:09:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/gem: Introduce drm_gem_get_unmapped_area() fop
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
 <andi.shyti@linux.intel.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, kernel@collabora.com
References: <20250929200316.18417-1-loic.molinari@collabora.com>
 <20250929200316.18417-3-loic.molinari@collabora.com>
 <20250930123003.75370854@fedora>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20250930123003.75370854@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/09/2025 12:30, Boris Brezillon wrote:
> On Mon, 29 Sep 2025 22:03:10 +0200
>
> Loïc Molinari <loic.molinari@collabora.com> wrote:
>> +unsigned long drm_gem_get_unmapped_area(struct file *filp, unsigned long uaddr,
>> +					unsigned long len, unsigned long pgoff,
>> +					unsigned long flags)
>> +{
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	struct drm_gem_object *obj;
>> +	unsigned long ret;
>> +
>> +	obj = drm_gem_object_lookup_from_offset(filp, pgoff, len >> PAGE_SHIFT);
>> +	if (IS_ERR(obj))
>> +		return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0,
>> +					    flags);
>> +
>> +	ret = shmem_get_unmapped_area(obj->filp, uaddr, len, 0, flags);
>> +
>> +	drm_gem_object_put(obj);
>> +
>> +	return ret;
>> +#else
>> +	return mm_get_unmapped_area(current->mm, filp, uaddr, len, 0, flags);
> 
> Looks like the above code covers the non-THP case too, do we really need
> to specialize for !CONFIG_TRANSPARENT_HUGEPAGE here?

It does cover the !CONFIG_TRANSPARENT_HUGEPAGE case 
(shmem_get_unmapped_area() would just call and return the 
mm_get_unmapped_area() address) but the idea here is to avoid the GEM 
object lookup cost by calling mm_get_unmapped_area() directly.

>> +#endif
>> +}
>> +EXPORT_SYMBOL(drm_gem_get_unmapped_area);

Loïc

