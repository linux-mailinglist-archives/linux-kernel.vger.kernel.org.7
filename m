Return-Path: <linux-kernel+bounces-728191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E201B0247D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FFDA4023B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77881E1A05;
	Fri, 11 Jul 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QXP3eiyr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DE1DDA14
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261798; cv=pass; b=t0p2u3v3IUTuc9VGNvb1i49buk+UsxcwqB3pPGIqFHyBByh0VKuqdo29OLiH15azrgxP5dGByxRoL6FCjAYLMER+HqfjiRz9Im50XF8pt37+D9gCLiaDUiepzmWMxBImBKqhSqYoWyTakKw6alFW8JHM7oAcAGCj/Juh12Zg+hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261798; c=relaxed/simple;
	bh=OSirYDp+5zCh30TTlCuEyePGr7VeextkOcXYjcHqaEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+z0y90P1aF6tiNE9JAowxi44NJHXFt2wHAU0bjj5s3VYgmYdxueM09vtbQpWqRIQATepcdEpea7BNROyauLWgQ2DsdfrXgoK2hEcIjvPkfyK5cyiyKmOi+GQJHtqpGoWt4xYfs0de9dLeAhjHNDYUpzZJk5HGB2pgOt/HwDPng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=QXP3eiyr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752261772; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gm6PlPZ42mUuc0lCnaO/BMAIqal5iq0BBm2iJ0FgQ5vP4k4MxYFFLL2E0vQG9QJ7wzNgMYx700i7idr/MFIjXB+fSPUXX9hcVAFenK3pGoe4Mo0l6GqCJbDoXAuI0Cmk6Iy4sWQgEJzOFaFfC8tUuR1DOnNv2iJ1vZFhpS/scPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752261772; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CmFNQAJc/QuWXkyf69RAtnA9lwTAM02Mtxim41lVFgc=; 
	b=dL5/gKrb9hoYw3QsYU6musqJ6sGq3BeJFgqiQTAndU104CgM9ctnwKtmzmR035wjKJZ12SyyBMjP0dY2+a+OolEXxUJEs+DoqRQqxperoZIXMxoYc8XOBbGbAOJofobwweHcWtgvWN3nlw9IJbzK2d7sytaATMnk6dnKsHwNbbQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752261772;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CmFNQAJc/QuWXkyf69RAtnA9lwTAM02Mtxim41lVFgc=;
	b=QXP3eiyry4PyRzliZvxSjay5qGQ26pL4mGDRO6433bmimc1PA7nj083Quxnk+/26
	MIHqK1ldiS4zz0Mkp6l582wwsJfOzQNT7uMYbvPe7BqJJ4p78JPuZroIdb5n5qRabxX
	mRf3ADNYAKx15bU4xIT7l1HdoO6A1SjP/KGJcXG0=
Received: by mx.zohomail.com with SMTPS id 1752261769997706.4157126654749;
	Fri, 11 Jul 2025 12:22:49 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:22:46 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Caterina Shablia <caterina.shablia@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/gpuvm: Add a helper to check if two VA can be
 merged
Message-ID: <cb7h7u4roxm3xmmb2eagjw3uedy346v5diwjnxaljzqvibve7y@mcb6whvrigur>
References: <20250703152908.16702-2-caterina.shablia@collabora.com>
 <20250703152908.16702-6-caterina.shablia@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703152908.16702-6-caterina.shablia@collabora.com>

On 03.07.2025 15:28, Caterina Shablia wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
>
> We are going to add flags/properties that will impact the VA merging
> ability. Instead of sprinkling tests all over the place in
> __drm_gpuvm_sm_map(), let's add a helper aggregating all these checks
> can call it for every existing VA we walk through in the
> __drm_gpuvm_sm_map() loop.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c | 47 +++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index ae201d45e6b8..2df04dfcb6ef 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2098,12 +2098,48 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
>  	return fn->sm_step_unmap(&op, priv);
>  }
>
> +static bool can_merge(struct drm_gpuvm *gpuvm, const struct drm_gpuva *a,
> +		      const struct drm_gpuva *b)
> +{
> +	/* Only GEM-based mappings can be merged, and they must point to
> +	 * the same GEM object.
> +	 */
> +	if (a->gem.obj != b->gem.obj || !a->gem.obj)
> +		return false;
> +
> +	/* Let's keep things simple for now and force all flags to match. */
> +	if (a->flags != b->flags)
> +		return false;
> +
> +	/* Order VAs for the rest of the checks. */
> +	if (a->va.addr > b->va.addr)
> +		swap(a, b);
> +
> +	/* We assume the caller already checked that VAs overlap or are
> +	 * contiguous.
> +	 */
> +	if (drm_WARN_ON(gpuvm->drm, b->va.addr > a->va.addr + a->va.range))
> +		return false;
> +
> +	/* We intentionally ignore u64 underflows because all we care about
> +	 * here is whether the VA diff matches the GEM offset diff.
> +	 */
> +	return b->va.addr - a->va.addr == b->gem.offset - a->gem.offset;
> +}
> +
>  static int
>  __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  		   const struct drm_gpuvm_ops *ops, void *priv,
>  		   const struct drm_gpuvm_map_req *req)
>  {
>  	struct drm_gpuva *va, *next;
> +	struct drm_gpuva reqva = {
> +		.va.addr = req->va.addr,
> +		.va.range = req->va.range,
> +		.gem.offset = req->gem.offset,
> +		.gem.obj = req->gem.obj,
> +		.flags = req->flags,

struct drm_gpuvm_map_req::flags is not added until the next commit in the series
("drm/gpuvm: Add a flags field to drm_gpuva_op_map") so maybe you could reorder
the series and have Lina's commits come earlier than this one. Otherwise this is
going to break the build and make the series unbisectable.

> +	};
>  	u64 req_end = req->va.addr + req->va.range;
>  	int ret;
>
> @@ -2116,12 +2152,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  		u64 addr = va->va.addr;
>  		u64 range = va->va.range;
>  		u64 end = addr + range;
> -		bool merge = !!va->gem.obj;
> +		bool merge = can_merge(gpuvm, va, &reqva);
>
>  		if (addr == req->va.addr) {
> -			merge &= obj == req->gem.obj &&
> -				 offset == req->gem.offset;
> -
>  			if (end == req_end) {
>  				ret = op_unmap_cb(ops, priv, va, merge);
>  				if (ret)
> @@ -2163,8 +2196,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  			};
>  			struct drm_gpuva_op_unmap u = { .va = va };
>
> -			merge &= obj == req->gem.obj &&
> -				 offset + ls_range == req->gem.offset;
>  			u.keep = merge;
>
>  			if (end == req_end) {
> @@ -2196,10 +2227,6 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
>  				break;
>  			}
>  		} else if (addr > req->va.addr) {
> -			merge &= obj == req->gem.obj &&
> -				 offset == req->gem.offset +
> -					   (addr - req->va.addr);
> -
>  			if (end == req_end) {
>  				ret = op_unmap_cb(ops, priv, va, merge);
>  				if (ret)
> --
> 2.47.2


Adrian Larumbe

