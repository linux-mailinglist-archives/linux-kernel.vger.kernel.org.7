Return-Path: <linux-kernel+bounces-864432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F21BFAC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16819500930
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEF301715;
	Wed, 22 Oct 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OqTfjc8C"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31E2FFF80
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120369; cv=none; b=tn24KSGsFViQpJAuZiz9Me9RQ11T+J+r/rP5SOx2JorUAfuU+CJvDnCMmrDQVB7BBJ8WgZHwSBrVESs9+eCqR2AZ3QJbDtwkAB2oDY4tjix0whI7WqfxcFXh+VhmPq6I8tmmRCOLqA3wkQO0RJwStSUW1C+Qilhn0Hox1ixmoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120369; c=relaxed/simple;
	bh=Vv5HW4hMaQ9k6PZF5xQoMjollRe8szXt8vgnUejMW7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfyd7hG/ME6ZkkS6EcI9aY/G7y9mCo9S9bhq9J5aPJnDopgghu8oT1AzEqkVcSJRxAosa4LrXvz8ihEdm7Isqf8KUEOnHaUfByY1lcFz+Hl/9O7PUJ+ErPQIrCcZDpeWogzHWyuIVn+GeYUUnO5QQH5TLjVJW9yKfKkbYHfibgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OqTfjc8C; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761120364;
	bh=Vv5HW4hMaQ9k6PZF5xQoMjollRe8szXt8vgnUejMW7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OqTfjc8CeEZodXvloy6yGK0vCCVA3ZUOYsnD0vEOc6mxtUqJblDcDaqLtizrvul49
	 PqaCN2GxY14WvR3VNgeQ6zH+ZkRWkBdHFATc+T0ISJSIMQstxywXwEhe0f3sau3hIG
	 2s1hgKhwTABfdbTdBWu4g5VySi3p1xg2O3YFMA2bTO4hbIaZP4x1JTuHz0o5J7avAv
	 19F3fOgQTfNDUMFdBhHG99F8iDFH0tjUYUu71nrlziw30LL85XwkNuoNo/cpdUHuFp
	 4h97W1yuKztO1Kr1rsUpThg7hLXqk0irWVaBaETOxDtvitMsoLJE9UkotUICc839pE
	 OXfWXcVlNP8NA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CE6317E12C4;
	Wed, 22 Oct 2025 10:06:03 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:05:48 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: kernel test robot <lkp@intel.com>
Cc: =?UTF-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Boris Brezillon
 <bbrezillon@kernel.org>, Rob Herring <robh@kernel.org>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Melissa Wen
 <mwen@igalia.com>, =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Hugh
 Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Nitin
 Gote <nitin.r.gote@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Christopher Healy <healych@amazon.com>,
 Matthew Wilcox <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpers
Message-ID: <20251022100548.4dee241e@fedora>
In-Reply-To: <202510221301.wU3TSqMg-lkp@intel.com>
References: <20251021113049.17242-7-loic.molinari@collabora.com>
	<202510221301.wU3TSqMg-lkp@intel.com>
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

On Wed, 22 Oct 2025 11:25:10 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Lo=C3=AFc,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on next-20251021]
> [also build test ERROR on v6.18-rc2]
> [cannot apply to akpm-mm/mm-everything drm-misc/drm-misc-next linus/maste=
r v6.18-rc2 v6.18-rc1 v6.17]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Lo-c-Molinari/drm-=
shmem-helper-Simplify-page-offset-calculation-in-fault-handler/20251021-193=
355
> base:   next-20251021
> patch link:    https://lore.kernel.org/r/20251021113049.17242-7-loic.moli=
nari%40collabora.com
> patch subject: [PATCH v5 06/12] drm/i915: Use huge tmpfs mountpoint helpe=
rs
> config: x86_64-randconfig-003-20251022 (https://download.01.org/0day-ci/a=
rchive/20251022/202510221301.wU3TSqMg-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251022/202510221301.wU3TSqMg-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510221301.wU3TSqMg-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/gpu/drm/i915/gem/i915_gem_shmem.c: In function '__create_shmem=
':
> >> drivers/gpu/drm/i915/gem/i915_gem_shmem.c:511:59: error: 'struct drm_d=
evice' has no member named 'huge_mnt' =20
>      511 |                 filp =3D shmem_file_setup_with_mnt(i915->drm.h=
uge_mnt, "i915",
>          |                                                           ^
>=20
>=20
> vim +511 drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>=20
>    486=09
>    487	static int __create_shmem(struct drm_i915_private *i915,
>    488				  struct drm_gem_object *obj,
>    489				  resource_size_t size)
>    490	{
>    491		unsigned long flags =3D VM_NORESERVE;
>    492		struct file *filp;
>    493=09
>    494		drm_gem_private_object_init(&i915->drm, obj, size);
>    495=09
>    496		/* XXX: The __shmem_file_setup() function returns -EINVAL if size=
 is
>    497		 * greater than MAX_LFS_FILESIZE.
>    498		 * To handle the same error as other code that returns -E2BIG when
>    499		 * the size is too large, we add a code that returns -E2BIG when =
the
>    500		 * size is larger than the size that can be handled.
>    501		 * If BITS_PER_LONG is 32, size > MAX_LFS_FILESIZE is always fals=
e,
>    502		 * so we only needs to check when BITS_PER_LONG is 64.
>    503		 * If BITS_PER_LONG is 32, E2BIG checks are processed when
>    504		 * i915_gem_object_size_2big() is called before init_object() cal=
lback
>    505		 * is called.
>    506		 */
>    507		if (BITS_PER_LONG =3D=3D 64 && size > MAX_LFS_FILESIZE)
>    508			return -E2BIG;
>    509=09
>    510		if (drm_gem_has_huge_mnt(&i915->drm))
>  > 511			filp =3D shmem_file_setup_with_mnt(i915->drm.huge_mnt, "i915", =
=20
>    512							 size, flags);

Maybe instead of this drm_gem_has_huge_mnt() (or in addition to), we
should have a drm_gem_get_huge_mnt() helper, so we don't have drivers
dereferencing drm_device::huge_mnt directly and we can get rid of it on
non THP configs.

>    513		else
>    514			filp =3D shmem_file_setup("i915", size, flags);
>    515		if (IS_ERR(filp))
>    516			return PTR_ERR(filp);
>    517=09
>    518		/*
>    519		 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on =
shmem
>    520		 * objects by setting O_LARGEFILE.
>    521		 */
>    522		if (force_o_largefile())
>    523			filp->f_flags |=3D O_LARGEFILE;
>    524=09
>    525		obj->filp =3D filp;
>    526		return 0;
>    527	}
>    528=09
>=20


