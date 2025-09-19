Return-Path: <linux-kernel+bounces-824291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D9B8896F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AF33B6E29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1822F5A17;
	Fri, 19 Sep 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GfGmo4Vq"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDF2ECEAB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274537; cv=pass; b=shOWzHFZXYElWOHSg+zWk8A4GjZTPse75VpucqPgOLRjS7L7sTnNkpce5ckuprgoNur88YADiga5C2rsEBSu6nxbAGspMAYoAznyunpe01gYVLo7aHXRBwgAKSRrSTCQePJaEST43OrJ76xzmByb/cf0DXhKyzUIePUppQ6ZEPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274537; c=relaxed/simple;
	bh=4m+AxGVJUfIpRSL/uquYuv5dLWJVM25j7KnoFxT8J6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yaf5PlOD7Qq6uCL0IMjjG6tsYuxBWyQQ30HV4+TUJdImJ2Tqc4T2iW389Nq2/udq87+cZ3wRW2ECMmeAkmx9NXLbDu09e/pxBiyZhgl73GGl6+zLdRCNggLT4fOxvTJlSAUgRe96knf7F6cmEvpvS0AblT0rdfzWR4SVDdX9xRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=GfGmo4Vq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758274530; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ia/weqB67JSOOFDADLRgnZnK1FSgsllrjF7nnMivBIzpsKy4d/24ygj7PjZkuX3hLKveVj9spU13OIgC6sYgHIrYa3x07YqoF8mXEH8Qpb07REJTaQ+EXYOAKMfqSzB7oqFDr7Aa7dr57x1Wlqw9I3O1M2Ldi0P9RBDs3dzhj50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758274530; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q4AgxNNAIA3/Y/jnWgb7B4t21i6FI8oSC22E+XxRvPA=; 
	b=aZEpgt7OJ92jBCcTdVl+9pF09w/UFhZUmiUnhzBFVx0f1+C00bGBHTa5W4w45DjZbUL/bsIx4xAealShlTCKoA10dHPR3fp2rgbHX1rZhVnblwuEGl1tJ1sJxij+EffGtnw7HxxNTXG7sSspluj88TAzyqDR9u4mooyFme9m4wM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758274530;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=Q4AgxNNAIA3/Y/jnWgb7B4t21i6FI8oSC22E+XxRvPA=;
	b=GfGmo4VqF9j3Te3raCUUXsUy7ppKdoQm/P+I4RWLjPumoDI1atAwH8F5zvAfixqH
	tpJXAVKiBEQUwlWEeq/Akcl+wTv5qWqRiEA1weaBHJ3JgXXK9ndf70lYX7pLz2UxUP8
	TVRGxlfr3HIAX6N8mqEc9UudqUKR0nAFU0XokrMA=
Received: by mx.zohomail.com with SMTPS id 1758274529027121.54735845958476;
	Fri, 19 Sep 2025 02:35:29 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:35:25 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Bump the minor version number
Message-ID: <76ob3x7aeflkz3q2sm44zz7wk55sarrprxixixzq32xi2qkjm3@gmctkhzl5w3c>
References: <20250919080700.3949393-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919080700.3949393-1-steven.price@arm.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 19.09.2025 09:07, Steven Price wrote:
> Commit a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
> added new ioctls to the driver and was meant to bump the version number.
> However it actually only added a comment and didn't change the exposed
> version number. Bump the number to be consistent with the comment.
>
> Fixes: a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3af4b4753ca4..22350ce8a08f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -853,7 +853,7 @@ static const struct drm_driver panfrost_drm_driver = {
>  	.name			= "panfrost",
>  	.desc			= "panfrost DRM",
>  	.major			= 1,
> -	.minor			= 4,
> +	.minor			= 5,
>
>  	.gem_create_object	= panfrost_gem_create_object,
>  	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,
> --
> 2.39.5

Adrian Larumbe

