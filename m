Return-Path: <linux-kernel+bounces-842628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E0BBD321
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CB18932D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7A1D5151;
	Mon,  6 Oct 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ow50FbFk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8D1339A4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735089; cv=none; b=biiSccIAvCi9pt8fPPnKT6ujSLSIDQmxDybT61g8wbOZwPxSN2MrGEGXRK6GWxHDQA0WZ66U61RJxljY3401zzBEc6od5sr2zfx65rPAo97G8SLpIBs4GOqPjFS9R8Aa4RzdbmW1w4jJDGxauQksxFlb//YQE8SOlh0g1MvFl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735089; c=relaxed/simple;
	bh=lZ/n0Q4PSONNTacZa2zCgNApaZj6MNu9EC54zqvaIns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ4IvNXK/Xg4ZjXqTF3wH8khzE9N3xriABzz+JpqXIO6zPgi63CdFQVW/j45PKqgDhQlcb80RxHSEnIEEtBJCWOAtC/tstDhCaB6zMtqo+F474CS3wgpNX/omlzkO1ur6Zu4P+0afmv6mz8Z/So8EzZ15I+Nz+9g8GXvRFC15sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ow50FbFk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759735084;
	bh=lZ/n0Q4PSONNTacZa2zCgNApaZj6MNu9EC54zqvaIns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ow50FbFkx9Jixg+xEFpCEeUdFIUmpo3MSKyC3xnJorfUbDFZ/fJysTWtjafpnM8Hm
	 C/XlyCYm51AVAptfBdDo1DlhBvYI63wmI754IIQXpWWqMf6EKleqB1z633vHz7ixtx
	 TTiVymqIf7f9isv1ffCeMbhh3nYd+EbpGqn4nYnIjGudG9stfnZGlmeCD6lRVTtXlb
	 eyJMoOL/zr7UZd7GSIcPNxQTraC2/Z2o+G3Xrz7N9ogU3JCTuCJeHNXaMMpPrJFrfb
	 HkPVMlxgaHbPG4G6RgoFFS2A2gCpHSzL7s0xHgmWxSmV30rZmrv/KQw1k7vHKJm840
	 9X+7cxunp2JPQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 536E017E1292;
	Mon,  6 Oct 2025 09:18:03 +0200 (CEST)
Date: Mon, 6 Oct 2025 09:17:57 +0200
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
 Christopher Healy <healych@amazon.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH v3 06/10] drm/gem: Get rid of *_with_mnt helpers
Message-ID: <20251006091757.642d912d@fedora>
In-Reply-To: <20251004093054.21388-7-loic.molinari@collabora.com>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
	<20251004093054.21388-7-loic.molinari@collabora.com>
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

On Sat,  4 Oct 2025 11:30:49 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> drm_gem_object_init_with_mnt() and drm_gem_shmem_create_with_mnt() can
> be removed now that the drivers use drm_gem_huge_mnt_create().
>=20
> Signed-off-by: Lo=C3=AFc Molinari <loic.molinari@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem.c              | 34 ++++++-----------------
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++--------------------
>  drivers/gpu/drm/v3d/v3d_bo.c           |  3 +-
>  include/drm/drm_gem.h                  |  3 --
>  include/drm/drm_gem_shmem_helper.h     |  3 --
>  5 files changed, 17 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index b4e4947210ef..a29f57943b93 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -181,28 +181,26 @@ drm_gem_init(struct drm_device *dev)
>  }
> =20
>  /**
> - * drm_gem_object_init_with_mnt - initialize an allocated shmem-backed G=
EM
> - * object in a given shmfs mountpoint
> + * drm_gem_object_init - initialize an allocated shmem-backed GEM object
>   *
>   * @dev: drm_device the object should be initialized for
>   * @obj: drm_gem_object to initialize
>   * @size: object size
> - * @gemfs: tmpfs mount where the GEM object will be created. If NULL, use
> - * the usual tmpfs mountpoint (`shm_mnt`).
>   *
>   * Initialize an already allocated GEM object of the specified size with
> - * shmfs backing store.
> + * shmfs backing store. A huge mountpoint can be used by calling
> + * drm_gem_huge_mnt_create() beforehand.
>   */
> -int drm_gem_object_init_with_mnt(struct drm_device *dev,
> -				 struct drm_gem_object *obj, size_t size,
> -				 struct vfsmount *gemfs)
> +int drm_gem_object_init(struct drm_device *dev, struct drm_gem_object *o=
bj,
> +			size_t size)
>  {
>  	struct file *filp;
> =20
>  	drm_gem_private_object_init(dev, obj, size);
> =20
> -	if (gemfs)
> -		filp =3D shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
> +	if (dev->huge_mnt)
> +		filp =3D shmem_file_setup_with_mnt(dev->huge_mnt,
> +						 "drm mm object", size,
>  						 VM_NORESERVE);
>  	else
>  		filp =3D shmem_file_setup("drm mm object", size, VM_NORESERVE);
> @@ -214,22 +212,6 @@ int drm_gem_object_init_with_mnt(struct drm_device *=
dev,
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL(drm_gem_object_init_with_mnt);
> -
> -/**
> - * drm_gem_object_init - initialize an allocated shmem-backed GEM object
> - * @dev: drm_device the object should be initialized for
> - * @obj: drm_gem_object to initialize
> - * @size: object size
> - *
> - * Initialize an already allocated GEM object of the specified size with
> - * shmfs backing store.
> - */
> -int drm_gem_object_init(struct drm_device *dev, struct drm_gem_object *o=
bj,
> -			size_t size)
> -{
> -	return drm_gem_object_init_with_mnt(dev, obj, size, NULL);
> -}
>  EXPORT_SYMBOL(drm_gem_object_init);
> =20
>  /**
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 22c4b09e10a3..5c1c1e8040b4 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -49,7 +49,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_=
funcs =3D {
>  };
> =20
>  static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_s=
hmem_object *shmem,
> -				size_t size, bool private, struct vfsmount *gemfs)
> +				size_t size, bool private)
>  {
>  	struct drm_gem_object *obj =3D &shmem->base;
>  	int ret =3D 0;
> @@ -61,7 +61,7 @@ static int __drm_gem_shmem_init(struct drm_device *dev,=
 struct drm_gem_shmem_obj
>  		drm_gem_private_object_init(dev, obj, size);
>  		shmem->map_wc =3D false; /* dma-buf mappings use always writecombine */
>  	} else {
> -		ret =3D drm_gem_object_init_with_mnt(dev, obj, size, gemfs);
> +		ret =3D drm_gem_object_init(dev, obj, size);
>  	}
>  	if (ret) {
>  		drm_gem_private_object_fini(obj);
> @@ -102,13 +102,12 @@ static int __drm_gem_shmem_init(struct drm_device *=
dev, struct drm_gem_shmem_obj
>   */
>  int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obje=
ct *shmem, size_t size)
>  {
> -	return __drm_gem_shmem_init(dev, shmem, size, false, NULL);
> +	return __drm_gem_shmem_init(dev, shmem, size, false);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_init);
> =20
>  static struct drm_gem_shmem_object *
> -__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private,
> -		       struct vfsmount *gemfs)
> +__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	struct drm_gem_object *obj;
> @@ -128,7 +127,7 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t=
 size, bool private,
>  		obj =3D &shmem->base;
>  	}
> =20
> -	ret =3D __drm_gem_shmem_init(dev, shmem, size, private, gemfs);
> +	ret =3D __drm_gem_shmem_init(dev, shmem, size, private);
>  	if (ret) {
>  		kfree(obj);
>  		return ERR_PTR(ret);
> @@ -149,31 +148,10 @@ __drm_gem_shmem_create(struct drm_device *dev, size=
_t size, bool private,
>   */
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev=
, size_t size)
>  {
> -	return __drm_gem_shmem_create(dev, size, false, NULL);
> +	return __drm_gem_shmem_create(dev, size, false);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
> =20
> -/**
> - * drm_gem_shmem_create_with_mnt - Allocate an object with the given siz=
e in a
> - * given mountpoint
> - * @dev: DRM device
> - * @size: Size of the object to allocate
> - * @gemfs: tmpfs mount where the GEM object will be created
> - *
> - * This function creates a shmem GEM object in a given tmpfs mountpoint.
> - *
> - * Returns:
> - * A struct drm_gem_shmem_object * on success or an ERR_PTR()-encoded ne=
gative
> - * error code on failure.
> - */
> -struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_de=
vice *dev,
> -							   size_t size,
> -							   struct vfsmount *gemfs)
> -{
> -	return __drm_gem_shmem_create(dev, size, false, gemfs);
> -}
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_mnt);
> -
>  /**
>   * drm_gem_shmem_release - Release resources associated with a shmem GEM=
 object.
>   * @shmem: shmem GEM object
> @@ -878,7 +856,7 @@ drm_gem_shmem_prime_import_sg_table(struct drm_device=
 *dev,
>  	size_t size =3D PAGE_ALIGN(attach->dmabuf->size);
>  	struct drm_gem_shmem_object *shmem;
> =20
> -	shmem =3D __drm_gem_shmem_create(dev, size, true, NULL);
> +	shmem =3D __drm_gem_shmem_create(dev, size, true);
>  	if (IS_ERR(shmem))
>  		return ERR_CAST(shmem);
> =20
> @@ -926,7 +904,7 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_=
map(struct drm_device *dev,
> =20
>  	size =3D PAGE_ALIGN(attach->dmabuf->size);
> =20
> -	shmem =3D __drm_gem_shmem_create(dev, size, true, NULL);
> +	shmem =3D __drm_gem_shmem_create(dev, size, true);
>  	if (IS_ERR(shmem)) {
>  		ret =3D PTR_ERR(shmem);
>  		goto fail_detach;
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 6b9909bfce82..ef9e9c15da3c 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -151,8 +151,7 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, =
struct drm_file *file_priv,
>  	struct v3d_bo *bo;
>  	int ret;
> =20
> -	shmem_obj =3D drm_gem_shmem_create_with_mnt(dev, unaligned_size,
> -						  dev->huge_mnt);
> +	shmem_obj =3D drm_gem_shmem_create(dev, unaligned_size);
>  	if (IS_ERR(shmem_obj))
>  		return ERR_CAST(shmem_obj);
>  	bo =3D to_v3d_bo(&shmem_obj->base);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 7285a62d9afc..42d9066b1785 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -497,9 +497,6 @@ void drm_gem_object_release(struct drm_gem_object *ob=
j);
>  void drm_gem_object_free(struct kref *kref);
>  int drm_gem_object_init(struct drm_device *dev,
>  			struct drm_gem_object *obj, size_t size);
> -int drm_gem_object_init_with_mnt(struct drm_device *dev,
> -				 struct drm_gem_object *obj, size_t size,
> -				 struct vfsmount *gemfs);
>  void drm_gem_private_object_init(struct drm_device *dev,
>  				 struct drm_gem_object *obj, size_t size);
>  void drm_gem_private_object_fini(struct drm_gem_object *obj);
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shm=
em_helper.h
> index 589f7bfe7506..6b6478f5ca24 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -109,9 +109,6 @@ struct drm_gem_shmem_object {
> =20
>  int drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obje=
ct *shmem, size_t size);
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev=
, size_t size);
> -struct drm_gem_shmem_object *drm_gem_shmem_create_with_mnt(struct drm_de=
vice *dev,
> -							   size_t size,
> -							   struct vfsmount *gemfs);
>  void drm_gem_shmem_release(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
> =20


