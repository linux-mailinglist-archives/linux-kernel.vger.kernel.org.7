Return-Path: <linux-kernel+bounces-798388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377AB41D2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48A21BA2F37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B32FAC12;
	Wed,  3 Sep 2025 11:37:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFC2EA14D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899463; cv=none; b=QLyJGNqFeI/x3p1g3Uoh/vRKWFi2zIj0TESWruQmZCuV/6jgbhhuDSbBJaCRJxFkDHlTaGL08U4S8Owt+v/m61QzzU62DF8JRUeKTY8tzWlYl54ZwPMpfScD8jdJhUkikPgVk+4O/sGVF0kVmm8rC+U9YSmmCkkbNVzdC3PU5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899463; c=relaxed/simple;
	bh=NQbYdswFi76tdmHsnzSN3w/ucWbcr78bCQR1bLisfZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Usi4zx1Bc20TB77603wwi2dwujUpPawyXY2cw+IFYWLxQjTXaNwYiL0afsij8yJzwnYTMtrO1bnuH0EYvvUB1X0fqeupfGFtxZdtzuzJHubtUZFtu5wrqnO9JAvuH8WRtJfiX8h8iYZZ0m92GJds665j62R3Z+8Co/W38QIYWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F37AA1688;
	Wed,  3 Sep 2025 04:37:32 -0700 (PDT)
Received: from [10.1.39.32] (e122027.cambridge.arm.com [10.1.39.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17F8D3F694;
	Wed,  3 Sep 2025 04:37:38 -0700 (PDT)
Message-ID: <988cd2c6-27c7-4f7a-a234-ce0dfd2ea773@arm.com>
Date: Wed, 3 Sep 2025 12:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: validate group queue count
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902192001.409738-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250902192001.409738-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 20:20, Chia-I Wu wrote:
> A panthor group can have at most MAX_CS_PER_CSG panthor queues.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

Good catch - that's a nasty bug.

I think this should have:

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ba5dc3e443d9c..249ab889ca91f 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3473,6 +3473,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
>  		return -EINVAL;
>  
> +	if (group_args->queues.count > MAX_CS_PER_CSG)
> +		return -EINVAL;
> +

I think this check would be better moved up to
panthor_ioctl_group_create() (where we already have a zero check). But
either way:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
>  	if (!group)
>  		return -ENOMEM;


