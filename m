Return-Path: <linux-kernel+bounces-855071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D653EBE022B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 829333567D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECA301482;
	Wed, 15 Oct 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f1PeSLWV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493910E0;
	Wed, 15 Oct 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552266; cv=none; b=kc/9v2+/16GVQSi2htKgU/CvQdJNuMHCFaErvEuUTmSE6bo2+xbAXtTpsnayJ5gYc/reIEB8yJDZ0yL8ZKOKQDo1Gzo12VCkkbnMn+PxWL9Z9XBWu2VSW2a4lXuYR6A1wI1qkxlWb4FNNGIStcZTi3sGO9LD5aYUiKW/kq6d2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552266; c=relaxed/simple;
	bh=7ptcchgLxwIkPXE05LECg/WjIoBNqSmV17ABYHJJQkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQDIDa17trX4MUr5LtQ+7IeT3jMYhk55BUg05AXMJ94j8KSd2Gq187P14Pf+uMIW5hTyUxq+yPorL4BMe6lDSGAbxlfMQHrsAviyVF94KVte0GRP8VoOdO0ifmWe9MrWH5+Ea/L42EL72/G1+FftKzpbK+GsG+19b5Q9CgoRhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f1PeSLWV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760552262;
	bh=7ptcchgLxwIkPXE05LECg/WjIoBNqSmV17ABYHJJQkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f1PeSLWViiy6lxbY6mDbjfWggl+sS8rbLqvJXDcrtvzph1hKk1BhB+QzIrCa6yeuT
	 fXE0WRi9qr1C1SM75AnWVeYxLlsYCj/rxVLmDhYF8BA7TwYpaBgyTmWJg5RPbPcp/r
	 wxpE5vmB/QJLrvrmJvKTnyQFMc/vDnm7uETEX1UuPc62pvjquSIhJ0hHCL1pKnupj1
	 /0XwcrIohZ/b19Kh3Ft5phd6lAa0acTCj5hnlsr0kFGVExMLJ8PMM5VcV6AB937jPN
	 80KENnV6aVcCTM7MjFBIJ66Erqljq4yCO7RQj41W/AfL79LXOMywQoTDzVT8j9yMjh
	 iViOcUEBUGKQQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 557FD17E0125;
	Wed, 15 Oct 2025 20:17:41 +0200 (CEST)
Date: Wed, 15 Oct 2025 20:17:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mcanal@igalia.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, =?UTF-8?B?TWlrb8WCYWo=?= Wasiak
 <mikolaj.wasiak@intel.com>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Christopher Healy <healych@amazon.com>,
 Matthew Wilcox <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 08/13] drm/v3d: Fix builds with
 CONFIG_TRANSPARENT_HUGEPAGE=n
Message-ID: <20251015201737.3956f801@fedora>
In-Reply-To: <20251015153018.43735-9-loic.molinari@collabora.com>
References: <20251015153018.43735-1-loic.molinari@collabora.com>
	<20251015153018.43735-9-loic.molinari@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 17:30:12 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> Don't declare "super_pages" on builds with CONFIG_TRANSPARENT_HUGEPAGE
> disabled to prevent build error:
>=20
> ERROR: modpost: "super_pages" [drivers/gpu/drm/v3d/v3d.ko] undefined!

I believe this is a bug introduced by the previous commit: the
compiler probably drops any code between the
IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) check and the err label
because IS_ENABLED() evaluates to false at compile time. So I'd squash
those changes in the previous commit.

>=20
> Signed-off-by: Lo=C3=AFc Molinari <loic.molinari@collabora.com>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.h | 2 ++
>  drivers/gpu/drm/v3d/v3d_gem.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 99a39329bb85..481502104391 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -564,7 +564,9 @@ extern const struct dma_fence_ops v3d_fence_ops;
>  struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q=
);
> =20
>  /* v3d_gem.c */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern bool super_pages;
> +#endif
>  int v3d_gem_init(struct drm_device *dev);
>  void v3d_gem_destroy(struct drm_device *dev);
>  void v3d_reset_sms(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 635ff0fabe7e..0039063eb8b2 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -269,7 +269,9 @@ v3d_huge_mnt_init(struct v3d_dev *v3d)
>  	 * match our usecase.
>  	 */
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	if (super_pages)
> +#endif
>  		err =3D drm_gem_huge_mnt_create(&v3d->drm, "within_size");

Why not

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  	if (super_pages)
  		err =3D drm_gem_huge_mnt_create(&v3d->drm, "within_size");
#endif

I guess

	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && super_pages)
		err =3D drm_gem_huge_mnt_create(&v3d->drm, "within_size");

would also do, since it's likely to rely on the same optimization the
previous v3d_gemfs_init() implementation was relying on, but it's
fragile (not sure what happens when compiled with -O0).

> =20
>  	if (v3d->drm.huge_mnt)


