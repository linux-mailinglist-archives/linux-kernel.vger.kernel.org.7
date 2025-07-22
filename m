Return-Path: <linux-kernel+bounces-741430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4573B0E401
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED395AA0A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E8B280305;
	Tue, 22 Jul 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NkrEs0k7"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF817C224
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211879; cv=pass; b=bvv3ubsQz2rGLXXmhNyacw0l7KF9al86sLalxZogx+bA7FoXFSBzPo2OXXN7vdmC8y6JLt7Dy24uQUzfcB+IlhM0TcMhKSiUlvaeSUTw+vjtmLT0LWijAM5gEKLTU3o5Al4BRtmlu2wUy0k0CF7LDWTvtCr6Z1CC6Iy+zpgtoUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211879; c=relaxed/simple;
	bh=svNWukdvOwkk5bSFg2FCSF85UHGeDSsrCwYABZWX+7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb9XfhuqTzJaGdKnF6XYVpGiMWx/1uvkPDiz4FeEUcL+NoZKu3KjqPCYyiK2VRcmtauzcE0rnAhkyhJflCrFRO9dVHGJEcPrl2y+ElLpdpg+eZ1U5S7KxzyVbLqMJvp5c/qK+z79HsQYb1QdPLAq3fjeUVTGEdZgxIjRWm8LtZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=NkrEs0k7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753211844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V1MFNMXtbVII3OyG/PJfG0pIn5cGQmWJ4e/Sa9JRmZPWY0akP2RlV+ZnN+vqV50ngc1EmCGNe39HaEPHStoCqhvgA+gILA0+waTLDO1VLsOF8La91m+Zx0Rag5cBr8yVyzEgQnnbLpwsJqXi/QGiyAZrnXZtzTpiNIOZ5d5ACkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753211844; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+zesf94SJA+dm4PLjqUTSklRh64IZWgPDN+EL0S1jgA=; 
	b=lIq+/U/ngfwnEQArKc/zm49Isyp9glr+rMW02rr6bzs23xI/1yGD0cWSdIuKSgoTazwjXHDR2a9jGz5dYTteXCXP3uGehdue/hkGmIYzOjrC6sPEwnc7bDVf+NuBUuPNH88emANlhQnczidwBTSsukHvsXrJirxvUY533iecsa0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753211844;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+zesf94SJA+dm4PLjqUTSklRh64IZWgPDN+EL0S1jgA=;
	b=NkrEs0k7zPTimqzWvCjoW9+Bd/rI9Ug5K94zoa0qRdoj3HE06H8f219b7J1Xh9Yz
	NTfZ13GNH3A+lkfif3dfcUqP3Cb9RRnoSKVGmoNI1qYaFGZ84BWikovUTIojJhCPO1/
	dc9T8UjzgwRyLQaSyA0IJT94uUoYTqe8vHZedLho=
Received: by mx.zohomail.com with SMTPS id 1753211840656362.2056657687194;
	Tue, 22 Jul 2025 12:17:20 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:17:14 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Caterina Shablia <caterina.shablia@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v4 4/7] drm/gpuvm: Add a helper to check if two VA can be
 merged
Message-ID: <bvoiomc5x7cbyc4l35rbideznuyw557u2ttp7utoifaxs27j3m@6mc7ya7asmpy>
References: <20250707170442.1437009-1-caterina.shablia@collabora.com>
 <20250707170442.1437009-5-caterina.shablia@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707170442.1437009-5-caterina.shablia@collabora.com>

On 07.07.2025 17:04, Caterina Shablia wrote:
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
> index 05978c5c38b1..dc3c2f906400 100644
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

If we're reordering the VAs for the rest of the checks, when could underflow happen?

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

