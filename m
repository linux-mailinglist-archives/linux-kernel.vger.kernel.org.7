Return-Path: <linux-kernel+bounces-728037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA1B022DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EBD1C286D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE842F1FF1;
	Fri, 11 Jul 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo4b895n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E82F198D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255721; cv=none; b=nT3TWG/RDkwMujYpBVknK/3PfpE/kKydtrAObAWghl8qUEA5+tl2s0kbSFttdjfM74aXQ0vE2MJb0Hng9D432ZE7Tdb7CQG/JKvkLWJu645LAl9AAdXKsWMmURB8PXImZ2IVkZhAwDSO9FOA//nWQDBLvEr9bFtLcN7+AQ+Lg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255721; c=relaxed/simple;
	bh=sb4Xf0ULCx2Ti9sAnwhk9/aOAFZICH+JDYlm80FvR6c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bUd+r+cRrap3hw6osbMBVPbBRpO1yKyhFHNMHhH/vgX99wtFOiRihQFR4W7tuE/rrpSVQEX1JXXALcXkP7YQxcPHGNxGBJ3/D9y/Xra5LEIFRoHlRhuC91UxVtYlqNTA/GB3oERbAdWnJLxP4cJzU/bqVUXPXqmx8aNZYvxBlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo4b895n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1473CC4CEED;
	Fri, 11 Jul 2025 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255720;
	bh=sb4Xf0ULCx2Ti9sAnwhk9/aOAFZICH+JDYlm80FvR6c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Xo4b895nuT7lxuwx0uddkCG8D0N+iV8pxQbVl+/ov6kLwHP5Ih0PT1nfPFsF3ltxa
	 vN7mkTbxD/jnWW57qLt/8OwM23tmcRlKiO5XlQ/rVsW7vvNIwd2GXY9/UUH5Hpf3bN
	 vj6OhS9HgyJ+1eh9dWSOJuJOSP+VygwUt2V1lIZSpObV9MJlow5RLmVi1q2GVW/vsK
	 oIz32xhPk7iG64PmgJqDStWdpsqm7hTR+ahk5NFz5uMX5kgsSpxLQTC+XQLp+ecNlL
	 yKwf/QQU1J2UG9ZaB7nz+KDuAOSmYXXdUVyxaIIMtGnCVFrzyme+SpnSzJw3FEtNyj
	 /IK2muToGegtg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 19:41:56 +0200
Message-Id: <DB9ET7AG2N2D.YCVQRF9398V2@kernel.org>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
Cc: "Lyude Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Ben Skeggs" <bskeggs@redhat.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Ben Skeggs" <bskeggs@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250711072458.2665325-1-arnd@kernel.org>
In-Reply-To: <20250711072458.2665325-1-arnd@kernel.org>

On Fri Jul 11, 2025 at 9:24 AM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> nouveau_drm_ioctl() only checks the _IOC_NR() bits in the DRM_NOUVEAU_NVI=
F
> command, but ignores the type and direction bits, so any command with
> '7' in the low eight bits gets passed into nouveau_abi16_ioctl() instead
> of drm_ioctl().
>
> Check for all the bits except the size that is handled inside of the hand=
ler.
>
> Fixes: 27111a23d01c ("drm/nouveau: expose the full object/event interface=
s to userspace")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 1527b801f013..506eeb44f0d4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1284,6 +1284,9 @@ nouveau_ioctls[] =3D {
>  	DRM_IOCTL_DEF_DRV(NOUVEAU_EXEC, nouveau_exec_ioctl_exec, DRM_RENDER_ALL=
OW),
>  };
> =20
> +#define DRM_IOCTL_NOUVEAU_NVIV _IOC(_IOC_READ|_IOC_WRITE, DRM_IOCTL_BASE=
, \
> +				    DRM_COMMAND_BASE + DRM_NOUVEAU_NVIF, 0)

Is there any intention behind NVIV vs NVIF? Indicator that size is not
considered?

> +
>  long
>  nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg=
)
>  {
> @@ -1297,14 +1300,10 @@ nouveau_drm_ioctl(struct file *file, unsigned int=
 cmd, unsigned long arg)
>  		return ret;
>  	}
> =20
> -	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
> -	case DRM_NOUVEAU_NVIF:
> +	if ((cmd & ~IOCSIZE_MASK) =3D=3D DRM_IOCTL_NOUVEAU_NVIV)
>  		ret =3D nouveau_abi16_ioctl(filp, (void __user *)arg, _IOC_SIZE(cmd));
> -		break;
> -	default:
> +	else
>  		ret =3D drm_ioctl(file, cmd, arg);
> -		break;
> -	}
> =20
>  	pm_runtime_mark_last_busy(dev->dev);
>  	pm_runtime_put_autosuspend(dev->dev);


