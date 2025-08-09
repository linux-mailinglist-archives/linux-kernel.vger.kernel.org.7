Return-Path: <linux-kernel+bounces-761107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9152B1F47A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCAF18C2E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B127FB03;
	Sat,  9 Aug 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLxn6cmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B018FC92
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754740681; cv=none; b=WokZJQ9StFiAdyE9TO+Jx19Ggc3toHo7wCwLHtGMQqn6iKntFAabG7T8gKemt4ATTt2g7BqvzYvPSOuByVSvQ2EIg0sG0kDI0HhsyDy3mYEyRuQzA0B1f6NZ/u9Thtr7MDpn7z1UlFx+BLF+QqX4xcrpvb8sn0OArbsGG15WhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754740681; c=relaxed/simple;
	bh=96kNACRVCV1c87TFTqINC4yqHRBAKaSPpsPng/1U7Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4SPMfWDTr2DY7suxNhqCdqHznwth6RRSWR45/VaWpY0QVMRXKKKaN3OCRJ+LnENSCD4n7qg58YNpGteTGx14HXDYavW7itLrTVzgEayoyWBZ9V51bHIUzTFamlomIxuijR42N91y8xs5gDwVFTHkEoG6zA+0TafgOhsrmfnek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLxn6cmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A95C4CEE7;
	Sat,  9 Aug 2025 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754740681;
	bh=96kNACRVCV1c87TFTqINC4yqHRBAKaSPpsPng/1U7Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YLxn6cmZfxv/e3LqoLgDaqqG138UdGxN0qEuIae/myH0Yy7NDNe1IBO6Gtc1BgL8e
	 xLAkWuUMU9rToaM+GsmQy/u6SBPKvll0TNnyyQuRHy4BWuh29UkrxeVd0qXNOmHc4U
	 PaoD3IGEoFlxEsKyl3vcMmDTsa0K8H7tl/TAU8niDOz5+Gq3mHWXOiITgCD2gD9CiT
	 71nxKaV3Sqjm0JDOpbuA+ccgiwuI1GhAknU40P/XVek8iN/htP4J0pAhjkIRgZFs+D
	 9NNQ5pemm5baU6PoYIMel+7Udydi+0CsK3qGOjwR6zWsFxuB8WQy4FstDevpMv+dEL
	 ut4TjM7bct2AA==
Message-ID: <2cbb1df8-bb1c-4bae-8be0-c2ce2c7fa6fc@kernel.org>
Date: Sat, 9 Aug 2025 13:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: nouveau: fifo: ga100: fix null pointer dereferences
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: lyude@redhat.com, airlied@gmail.com, simona@ffwll.ch, bskeggs@redhat.com,
 kherbst@redhat.com, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
References: <aJcACwrvcjCq78eH@bhairav-test.ee.iitb.ac.in>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aJcACwrvcjCq78eH@bhairav-test.ee.iitb.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Akhilesh,

On 8/9/25 10:00 AM, Akhilesh Patil wrote:
> Fix potential NULL pointer dereference in ga100_fifo_nonstall_allow()
> and ga100_fifo_nonstall_block() when nvkm_runl_get() returns NULL.
> Fix CVE-476 as reported by coverity tool (CID: 1660771)
> 
> Fixes: 55e1a5996085 ("drm/nouveau/fifo/ga100-: add per-runlist nonstall intr handling")
> Addresses-Coverity-ID: 1660771
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Thanks for the patch.

> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
> index e74493a4569e..a441fb602f28 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c
> @@ -520,7 +520,9 @@ ga100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
>   	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
>   	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
>   
> -	nvkm_inth_block(&runl->nonstall.inth);
> +	WARN_ON(!runl);

There's two potential cases here. Either nvkm_runl_get() may expectedly return
NULL in this context, or nvkm_runl_get() returning NULL would be a bug.

In the former case we should gracefully handle it, i.e. no WARN_ON() etc. In the
latter case, there is no need to check, otherwise we'd need to check every
pointer for NULL all the time.

In this case it should be the latter, so the code should be correct as is.

> +	if (runl)
> +		nvkm_inth_block(&runl->nonstall.inth);
>   }
>   
>   static void
> @@ -529,7 +531,9 @@ ga100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
>   	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
>   	struct nvkm_runl *runl = nvkm_runl_get(fifo, index, 0);
>   
> -	nvkm_inth_allow(&runl->nonstall.inth);
> +	WARN_ON(!runl);
> +	if (runl)
> +		nvkm_inth_allow(&runl->nonstall.inth);
>   }
>   
>   const struct nvkm_event_func


