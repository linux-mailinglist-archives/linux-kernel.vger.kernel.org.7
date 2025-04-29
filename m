Return-Path: <linux-kernel+bounces-843926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB87BC09C1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAAA3AD5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417AC253F1A;
	Tue,  7 Oct 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hhBevQ4F"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F8747F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825405; cv=none; b=fjCRWmmH2VO/suS1LpCpClGi84zMNunLAkPDrbYK5wgnHH9jx32KKUfhS9XUL2CSw+myA5JaH62ZrctU1QmPq1dOgSoe+LUd0dqxFfTGdJ+a3qkc2U2Of9EMDDRIfvDrhQlc7kCTOaalVDVQissk+TAj5b/iM9U6bMk7RAVnbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825405; c=relaxed/simple;
	bh=jZGhVKHkpRai0Y2/EIkeTlYu8tYQjbtzz7neJZoq66Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdJpb7aJGs+eD1XCxKxr5BXDeuoa/ZfTwxD5JSMm9hB7fSjY1D7L160g3NWnck3PQuAdZ+Lvh3glNg2umPWa4epxUhJkeLp8js/zSBsko7uioTLWQ2NEjonVMeU6nN1XPZ7XABAgrrEiKeqK8J7giM+gIQR2IEyKVqFkOkWxrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hhBevQ4F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759825400;
	bh=jZGhVKHkpRai0Y2/EIkeTlYu8tYQjbtzz7neJZoq66Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhBevQ4FxG0mKuDSwCVH9MUQZUzbI9dc4vsE9e4IxI0SJ7ZQBa3/U4BjqS4QQoIrE
	 442WDmAKxaMvnFPlBlIMaVSDDB/CTF7keuQohdSUR9/q3oc+Qa6Uiiea3DL+wasEw4
	 3RJeS0nrJQLFqijuxIdhBzrgoiL8vB0Ba5TVbs3lTXBP7aINAkMBWxlAsdu0KhHeC7
	 BMIS6TpDQ0RS+nIEiEv9Ffv8IEtU7dazF6F472jdXZX/+W888gFYCswmVbgsi9PTW5
	 omc948QAAwAy3p+bc5bCqGyNVV33FnczE8K2rtefkwmB8oYFGOXF5qTP9v8LtQ9jwi
	 pl2FIE3Jh1oEw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E56B117E0A28;
	Tue,  7 Oct 2025 10:23:19 +0200 (CEST)
Date: Tue, 29 Apr 2025 18:13:05 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panthor: Fix build warning when DEBUG_FS is
 disabled
Message-ID: <20250429181305.47d65c9a@collabora.com>
In-Reply-To: <20250424184041.356191-1-adrian.larumbe@collabora.com>
References: <20250424184041.356191-1-adrian.larumbe@collabora.com>
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
X-ZM-MESSAGEID: 1745943243961134400

On Thu, 24 Apr 2025 19:40:34 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM
> objects over DebugFS") causes a build warning and linking error when
> built without support for DebugFS, because of a non-inline non-static
> function declaration in a header file.
>=20
> On top of that, the function is only being used inside a single
> compilation unit, so there is no point in exposing it as a global
> symbol.
>=20
> This is a follow-up from Arnd Bergmann's first fix.
> Also move panthor_gem_debugfs_set_usage_flags() into panthor_gem.c and
> declare it static.
>=20
> Fixes: a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM objec=
ts over DebugFS")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/dri-devel/20250424142419.47b9d457@collabo=
ra.com/T/#t
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Queued to drm-misc-next.

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 5 +++++
>  drivers/gpu/drm/panthor/panthor_gem.h | 8 --------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pant=
hor/panthor_gem.c
> index 2dcf308094b2..7c00fd77758b 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -42,11 +42,16 @@ static void panthor_gem_debugfs_bo_rm(struct panthor_=
gem_object *bo)
>  	mutex_unlock(&ptdev->gems.lock);
>  }
> =20
> +static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_objec=
t *bo, u32 usage_flags)
> +{
> +	bo->debugfs.flags =3D usage_flags | PANTHOR_DEBUGFS_GEM_USAGE_FLAG_INIT=
IALIZED;
> +}
>  #else
>  static void panthor_gem_debugfs_bo_add(struct panthor_device *ptdev,
>  				       struct panthor_gem_object *bo)
>  {}
>  static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
> +static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_objec=
t *bo, u32 usage_flags) {}
>  #endif
> =20
>  static void panthor_gem_free_object(struct drm_gem_object *obj)
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/pant=
hor/panthor_gem.h
> index 4641994ddd7f..4dd732dcd59f 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -212,14 +212,6 @@ void panthor_kernel_bo_destroy(struct panthor_kernel=
_bo *bo);
>  #ifdef CONFIG_DEBUG_FS
>  void panthor_gem_debugfs_print_bos(struct panthor_device *pfdev,
>  				   struct seq_file *m);
> -static inline void
> -panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 u=
sage_flags)
> -{
> -	bo->debugfs.flags =3D usage_flags | PANTHOR_DEBUGFS_GEM_USAGE_FLAG_INIT=
IALIZED;
> -}
> -
> -#else
> -void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, =
u32 usage_flags) {};
>  #endif
> =20
>  #endif /* __PANTHOR_GEM_H__ */
>=20
> base-commit: 3a2b7389feea9a7afd18d58cda59b7a989445f38


