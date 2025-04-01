Return-Path: <linux-kernel+bounces-583206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF49A777E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18771888C21
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98A1EE7DA;
	Tue,  1 Apr 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bU+d4FUY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF18DF9D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500388; cv=none; b=ouctbDkCnBWb9ApwvBr74Z0whSKcUbcUD2e1+dU28QiRR4zdzW21S/YKepDRU9RpWjn7YDShS5zVgZpqRpzJKJ1nfD2Hflk+6TM891hfzssvpwatzTukYW+Auz0jcDeVjhMxtee3Qmw1HhvwxK2orbvQvnVFlrDiC75LBo6ujB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500388; c=relaxed/simple;
	bh=Ah+mV8yuvZRy/olIXu1yJ6+e1HLEkDn2tSZ5n3RQDuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xsahn6zS1vL8XEIjiglqcjCfOiGEDXb9BgAisGQAL4i6DMsWNk6GbHq9BVGd9pfgHNko+63wlZqxmhVIEiiTfuFrxMx1FQEV1BcGUIIT5MXA0O7zYgXmVcA5YdVLSmx0ADq8pqRfMxp6q1ssSk083HdEE4mbDNE2UnpFD/tJXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bU+d4FUY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1743500385;
	bh=Ah+mV8yuvZRy/olIXu1yJ6+e1HLEkDn2tSZ5n3RQDuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bU+d4FUYY/c4bGEcpy0FZircnLalG2hJ+JQfnaYRxkTK72wUc91t/EY0QeWe/E6UM
	 ydNAWupakCbIwl6WR4jP4SAxdtwQQcnATpUZaOlJ6nr0teQNacsbtsZGAPjwLxm+4M
	 ARFq9yzY55L0SeNjp3CuCf8CXt0XMX6AaIFaPmaulfo6tTrM/zktPxGE+ma7qumUd0
	 s7BTxsb6hzi2vMvmFMgxOodb0UeTjF2TieJd97ISIzq+NRq6pWXHSXkvDh0sBBLGKl
	 9vpC0F9+4V4yOt0ttxHC/L5ogRSxR29DYO39z+AmuehX8Kaqbf4cgMihGlNX8Yu/wq
	 n3nYTAtbKTlTg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7273017E0CD1;
	Tue,  1 Apr 2025 11:39:44 +0200 (CEST)
Date: Tue, 1 Apr 2025 11:39:40 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 6/6] drm/panfrost/panthor: Take sparse objects
 into account for fdinfo
Message-ID: <20250401113940.089e4e14@collabora.com>
In-Reply-To: <20250326021433.772196-7-adrian.larumbe@collabora.com>
References: <20250326021433.772196-1-adrian.larumbe@collabora.com>
	<20250326021433.772196-7-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 02:14:26 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Make use of the new shmem helper for deciding whether a GEM object has
> backing pages.

This should be done in patch 4, otherwise the series is not bisectible.

>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
>  drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 0cda2c4e524f..2c6d73a7b5e5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -200,7 +200,7 @@ static enum drm_gem_object_status panfrost_gem_status=
(struct drm_gem_object *obj
>  	struct panfrost_gem_object *bo =3D to_panfrost_bo(obj);
>  	enum drm_gem_object_status res =3D 0;
> =20
> -	if (bo->base.base.import_attach || bo->base.pages)
> +	if (drm_gem_shmem_is_populated(&bo->base))
>  		res |=3D DRM_GEM_OBJECT_RESIDENT;
> =20
>  	if (bo->base.madv =3D=3D PANFROST_MADV_DONTNEED)
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 8244a4e6c2a2..48930fe7b398 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -155,7 +155,7 @@ static enum drm_gem_object_status panthor_gem_status(=
struct drm_gem_object *obj)
>  	struct panthor_gem_object *bo =3D to_panthor_bo(obj);
>  	enum drm_gem_object_status res =3D 0;
> =20
> -	if (bo->base.base.import_attach || bo->base.pages)
> +	if (drm_gem_shmem_is_populated(&bo->base))
>  		res |=3D DRM_GEM_OBJECT_RESIDENT;
> =20
>  	return res;


