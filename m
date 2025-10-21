Return-Path: <linux-kernel+bounces-862769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9CBF61C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D903A55A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905632E6B3;
	Tue, 21 Oct 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X6A8Vg+W"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41F244693;
	Tue, 21 Oct 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047022; cv=none; b=tXnIjoQBwlo5P2cAnbmoqTgEe4pWZImKdzIBItvVPW0wqZ9S9nvTlX8C5BlhVcGP/hEYR3GIM3cVFim/sJRxmwc8ykH1wA4SA5sRGXmvuu3VAewvdi+HT8ccTO+za+YBR9C1+disEqI9X3jHfGcRY9cW3DyUCktHK8ATBzWxwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047022; c=relaxed/simple;
	bh=4/wPubUubr6qTSSbAihLczvGyM352rWdAaTJHeSVTBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPnBvw/aoGAzkHbqbaj+cbbdbWtNBUG8W9KwFwYN3LuxsGzyBjA8wgI2RV+31nKZ2PhxLwdqCg0Mf3vbQE7nyEdShn4QoXa0HBQpBdJV09ik3BTtnJtL71OWkuthdYskUhAkVWFlMFxjYeSsZdF/RP2Nge/kYZMy6F1t/emUgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X6A8Vg+W; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761047018;
	bh=4/wPubUubr6qTSSbAihLczvGyM352rWdAaTJHeSVTBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6A8Vg+WYATpuhsFpQ3ZsJxt/QswcDrcGTpcfIoEoQIS63m673G0GbGfTRQL8aydv
	 +ccpa8fOn0/TF2FvpJGMdtw0ffwoUDQLJn4zA96ldPBS/BlMMsG0uGyrMbwdSvDkCk
	 cVP37O9DJBzFd7fbgnfPjW19UrL+XZOngS5BcIhOxhb68KfeAFiC5BfWfW778xBL8h
	 BSoMudQQwKJw2RKbCnudstHVmQkkoJ+MN8CSXPhp3tlKlBOakfHMPpnKe+73m08/Rz
	 LG9VWkhwuOkiPA+fmuEVp4neXVFjyrD3lXjoSoHMVuM2ex8xkyMuVCoWQuGDd+kyaA
	 selFJWS4cADRA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 873A917E0CA3;
	Tue, 21 Oct 2025 13:43:37 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:43:31 +0200
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
Subject: Re: [PATCH v5 05/12] drm/gem: Add huge tmpfs mountpoint helpers
Message-ID: <20251021134331.549ebeea@fedora>
In-Reply-To: <20251021113049.17242-6-loic.molinari@collabora.com>
References: <20251021113049.17242-1-loic.molinari@collabora.com>
	<20251021113049.17242-6-loic.molinari@collabora.com>
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

On Tue, 21 Oct 2025 13:30:42 +0200
Lo=C3=AFc Molinari <loic.molinari@collabora.com> wrote:

> Add the drm_gem_huge_mnt_create() and drm_gem_has_huge_mnt() helpers
> to avoid code duplication in the i915, V3D, Panfrost and Panthor
> drivers. The former creates and mounts a dedicated huge tmpfs
> mountpoint, for the lifetime of a DRM device, used at GEM object
> initialization. The latter checks whether a dedicated huge tmpfs
> mountpoint is in use by a DRM device.
>=20
> The next commits will port drivers to this helper.
>=20
> v3:
> - store huge tmpfs mountpoint in drm_device
>=20
> v4:
> - return 0 in builds with CONFIG_TRANSPARENT_HUGEPAGE=3Dn
> - return 0 when huge_mnt already exists
> - use new vfs_parse_fs_string() helper
>=20
> v5:
> - removed warning on !dev->huge_mnt and reset to NULL on free
> - inline drm_gem_huge_mnt_create() to remove func from text and avoid
>   calls in builds with CONFIG_TRANSPARENT_HUGEPAGE=3Dn
> - compile out drm_device's huge_mnt field in builds with
>   CONFIG_TRANSPARENT_HUGEPAGE=3Dn
> - add drm_gem_has_huge_mnt() helper
>=20
> Signed-off-by: Lo=C3=AFc Molinari <loic.molinari@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 39 +++++++++++++++++++++++++++++
>  include/drm/drm_device.h  | 15 +++++++++++
>  include/drm/drm_gem.h     | 52 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a98d5744cc6c..161da048330e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -29,6 +29,9 @@
>  #include <linux/export.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#include <linux/fs_context.h>
> +#endif
>  #include <linux/iosys-map.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/mm.h>
> @@ -82,6 +85,42 @@
>   * up at a later date, and as our interface with shmfs for memory alloca=
tion.
>   */
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void drm_gem_huge_mnt_free(struct drm_device *dev, void *data)
> +{
> +	kern_unmount(dev->huge_mnt);
> +}
> +
> +int __drm_gem_huge_mnt_create(struct drm_device *dev, const char *value)
> +{
> +	struct file_system_type *type;
> +	struct fs_context *fc;
> +	int ret;
> +
> +	if (unlikely(drm_gem_has_huge_mnt(dev)))
> +		return 0;
> +
> +	type =3D get_fs_type("tmpfs");
> +	if (unlikely(!type))
> +		return -EOPNOTSUPP;
> +	fc =3D fs_context_for_mount(type, SB_KERNMOUNT);
> +	if (IS_ERR(fc))
> +		return PTR_ERR(fc);
> +	ret =3D vfs_parse_fs_string(fc, "source", "tmpfs");
> +	if (unlikely(ret))
> +		return -ENOPARAM;
> +	ret =3D vfs_parse_fs_string(fc, "huge", value);
> +	if (unlikely(ret))
> +		return -ENOPARAM;
> +
> +	dev->huge_mnt =3D fc_mount_longterm(fc);
> +	put_fs_context(fc);
> +
> +	return drmm_add_action_or_reset(dev, drm_gem_huge_mnt_free, NULL);
> +}
> +EXPORT_SYMBOL_GPL(__drm_gem_huge_mnt_create);
> +#endif
> +
>  static void
>  drm_gem_init_release(struct drm_device *dev, void *ptr)
>  {
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 778b2cca6c49..684939987d83 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -3,6 +3,9 @@
> =20
>  #include <linux/list.h>
>  #include <linux/kref.h>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#include <linux/mount.h>
> +#endif
>  #include <linux/mutex.h>
>  #include <linux/idr.h>
>  #include <linux/sched.h>
> @@ -168,6 +171,18 @@ struct drm_device {
>  	 */
>  	struct drm_master *master;
> =20
> +	/**
> +	 * @huge_mnt:
> +	 *
> +	 * Huge tmpfs mountpoint used at GEM object initialization
> +	 * drm_gem_object_init(). Drivers can call drm_gem_huge_mnt_create() to
> +	 * create a huge tmfps mountpoint. The default tmpfs mountpoint
> +	 * (`shm_mnt`) is used if NULL.
> +	 */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

Can we move the ifdef before the kernel doc for this field?

> +	struct vfsmount *huge_mnt;
> +#endif
> +
>  	/**
>  	 * @driver_features: per-device driver features
>  	 *
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 7c8bd67d087c..9845854850fb 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -492,6 +492,58 @@ struct drm_gem_object {
>  		DRM_GEM_FOPS,\
>  	}
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +int __drm_gem_huge_mnt_create(struct drm_device *dev, const char *value);
> +#endif
> +
> +/**
> + * drm_gem_huge_mnt_create - Create, mount and use a huge tmpfs mountpoi=
nt
> + * @dev: DRM device a huge tmpfs mountpoint should be used with
> + * @value: huge tmpfs mount option value
> + *
> + * This function creates and mounts a dedicated huge tmpfs mountpoint fo=
r the
> + * lifetime of the DRM device @dev which is used at GEM object initializ=
ation
> + * with drm_gem_object_init().
> + *
> + * The most common option value @value is "within_size" which only alloc=
ates
> + * huge pages if the page will be fully within the GEM object size. "alw=
ays",
> + * "advise" and "never" are supported too but the latter would just crea=
te a
> + * mountpoint similar to the default one (`shm_mnt`). See shmemfs and
> + * Transparent Hugepage for more information.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +static inline int drm_gem_huge_mnt_create(struct drm_device *dev,
> +					  const char *value)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	return __drm_gem_huge_mnt_create(dev, value);
> +#else
> +	return 0;
> +#endif
> +}

Unless __drm_gem_huge_mnt_create() is really used internally (at first
glance, that doesn't seem to be the case), I'd suggest renaming it
drm_gem_huge_mnt_create() and having:

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value);
#else
static inline int drm_gem_huge_mnt_create(struct drm_device *dev,
					  const char *value)
{
	return 0;
}
#endif

> +
> +/**
> + * drm_gem_has_huge_mnt - Check if a huge tmpfs mountpoint is in use
> + * @dev: DRM device
> + *
> + * This function checks whether a huge tmpfs mountpoint is in use after =
by DRM
> + * device @dev. A huge tmpfs mountpoint is used after a successful call =
to
> + * drm_gem_huge_mnt_create() on builds with Transparent Hugepage enabled.
> + *
> + * Returns:
> + * true on success, false otherwise.
> + */
> +static inline bool drm_gem_has_huge_mnt(struct drm_device *dev)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	return !!dev->huge_mnt;
> +#else
> +	return false;
> +#endif
> +}
> +
>  void drm_gem_object_release(struct drm_gem_object *obj);
>  void drm_gem_object_free(struct kref *kref);
>  int drm_gem_object_init(struct drm_device *dev,


