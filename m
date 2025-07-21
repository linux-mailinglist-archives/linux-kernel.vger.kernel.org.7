Return-Path: <linux-kernel+bounces-739534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840ECB0C779
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C8F7A89D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F312DECB4;
	Mon, 21 Jul 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Fm9xDV"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1A28F95E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111424; cv=none; b=DUsm3HzJWJHMczHT2/ks+L4sKn0UcqKmfTzgrm73VG1aoY/z+rOMuMeUA75XnYCVDD/SBNsy+U9yMuF7rFP7Bt0/N04HosWz5xV1gX8Ax8CVNO7wfinDnpt8cf15MkPRhBpKaTRnm9aJwsUD7o4UYkYJxM1rMxxrn8B6t7nyfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111424; c=relaxed/simple;
	bh=UKcsPH1ccUZCrZdvbJM70DMX2Zg+ahSt2Wjc4X3vwN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvObGDoib6rl3HA47hQqY6t2/TMhgJ6lu4aH7NuVlUoLBJEjUa41heI1XhpgrUUjxTMBBskC2NadpukSCpkjmoFXxnwN4fx2o7IeYPu7LxTSfUNEqiZjivuKuTHdFXTgtn/wVvfp7HK6zkZfhwqZrPD9U1IVmGFnMj/6MB9wN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5Fm9xDV; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7086dcab64bso42137887b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753111421; x=1753716221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ocvCdNkMDo3BT/2klOEQ80TxvH7OEKmFAc3Lk06t9fs=;
        b=M5Fm9xDVARvAQHSLdnnRScYOTrK5SjxS4abYu4GVfambjHiFX0VbnknVeO4cYDjirM
         3wMFW/U9TpfX+vSuG6oUvwFppFsXZ6kwvqAHVR4ItxZ/C/+2bG1qt0lu+nmAlQzOvXrc
         Ip3mozmL30HIZ1dlkWbne4ZuY8gSx+YLCBYF5dHf5/zUV43pTVXO8e9v6KwUdJ+JwX1O
         nljOK7MIDDxGUnqyEa4nGtoJzML0PQ0AUE1ovjFekRwqWYzy7fPYww2YvW3TrxyEXbHB
         yozTGtfyZHgI8vyYa/519YcnNFrWQ0vREiHuMGpGGpCssW4+c3PIa8Bb6HTsXIQqTeS9
         Lt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111421; x=1753716221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocvCdNkMDo3BT/2klOEQ80TxvH7OEKmFAc3Lk06t9fs=;
        b=e141C8YEGvgwrA8YZowNOvzHST/hj7SHgZQnA50eavQ0+U0SIx3D9Iq738ekjkVEW/
         kCI8oF5d2mnyzOSPVbJ6Pty0WQsnnHsKPEKj2XL9zhyzbBmZKgb0/YheFlg96xm6oain
         mvTGeuytQXZqSwEyfkliVHE9J6nYumuXqsS5YkuzlAecDkgcZnM6g2KqxufLBn7hWMMM
         LFUOf+/izDU7jhLImlIvFX2KZcf3WwRhSsMpdS3ZymA/zXC0QY93w4oB+XN+Lo2C6gop
         tDHPbb4fZhVTjeRchBHGzyHXibY8zY9VdFKiEvMmqfCAxbCoqyWidRU5aHNbGyviUYyd
         ml1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaZ5jrwKStBAJyRPea4HVwY6B123t1JgXOc1KX/TIQQznX2vDaq2i2IM1kLMYcw8vsYf7gF9MHD15rgtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzosTdPy5dZWnYyAkzP3cC0HeTWtLKXmoKXzyqOwbN3EqmIx0mj
	Trxtlw7VmQVYGFed9ZrfGr0Rkry9mnZRNAIen2lyJKpm9yRx3Civ/ofG2W/gUzxoYBT+isPSE7X
	jLoQA3cH/KnvL5imL6vbwp/18YWaRENU=
X-Gm-Gg: ASbGncsSvZapl9Ii0BHwaLBq5SS0Idf9pS3d7XJZgdf6Huvn90SCzoOrdHlQhuzhuJ+
	ZI9fwoKuXyxxWWMnKJTRIeKn75WV2Nt5rTog3+3GJdqMMMkXQGbJyhEszBq0WvX4vCTfxnKPnFn
	Afrz483PlL10F/HD2/251Lkf2OYrx8qrF76htcCKJah1LBoVL+iQ5z3IsoylqqtV01mq2ZDjC9Z
	1ErSg==
X-Google-Smtp-Source: AGHT+IGDqF1I4DS9nKlVhWi4p8AckbCXnGXLDdebh9p9ANMlpPhx+AIsCl2r5Sejbu7oTGHOxFQF6NEH4KurfJM6lrY=
X-Received: by 2002:a05:690c:2504:b0:710:edf9:d93b with SMTP id
 00721157ae682-71836ca0601mr207342497b3.11.1753111420979; Mon, 21 Jul 2025
 08:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFrh3J85tsZRpOHQtKgNHUVnn=EG=QKBnZTRtWS8eWSc1K1xkA@mail.gmail.com>
 <c32114e7-a61a-4c2b-ab4b-b103d028d05f@app.fastmail.com> <CAFrh3J-SpU03=Kgi8vj1XLsMfruQyF1Rew6L2+aYUgZnkTLJAw@mail.gmail.com>
 <0d8287db-4943-4cce-87d1-25a22d3228ea@app.fastmail.com>
In-Reply-To: <0d8287db-4943-4cce-87d1-25a22d3228ea@app.fastmail.com>
From: Satadru Pramanik <satadru@gmail.com>
Date: Mon, 21 Jul 2025 11:23:29 -0400
X-Gm-Features: Ac12FXxXG-T1U3EjWURIg231EER9GysEO4MyI2_9r4ytnugZ-FUAEu6zWl_DSPM
Message-ID: <CAFrh3J9OupHCjKYd0FS2vsZA3qgJhz9t1Wb1B-ATsGysUKNRAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: check ioctl command codes better
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Airlie <airlied@gmail.com>, Dave Airlie <airlied@redhat.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, bskeggs@redhat.com, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
	Simona Vetter <simona@ffwll.ch>, Timur Tabi <ttabi@nvidia.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: multipart/mixed; boundary="000000000000800ba8063a720f7f"

--000000000000800ba8063a720f7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately, that doesn't seem to fix the issue.

glxinfo -B still shows llvmpipe being used, just like on stock 6.16-rc7:
glxinfo -B
name of display: :0
display: :0  screen: 0
direct rendering: Yes
Extended renderer info (GLX_MESA_query_renderer):
    Vendor: Mesa (0xffffffff)
    Device: llvmpipe (LLVM 19.1.7, 256 bits) (0xffffffff)
    Version: 25.2.0
    Accelerated: no
    Video memory: 15388MB
    Unified memory: yes
    Preferred profile: core (0x1)
    Max core profile version: 4.5
    Max compat profile version: 4.5
    Max GLES1 profile version: 1.1
    Max GLES[23] profile version: 3.2
Memory info (GL_ATI_meminfo):
    VBO free memory - total: 0 MB, largest block: 0 MB
    VBO free aux. memory - total: 12389 MB, largest block: 12389 MB
    Texture free memory - total: 0 MB, largest block: 0 MB
    Texture free aux. memory - total: 12389 MB, largest block: 12389 MB
    Renderbuffer free memory - total: 0 MB, largest block: 0 MB
    Renderbuffer free aux. memory - total: 12389 MB, largest block: 12389 M=
B
Memory info (GL_NVX_gpu_memory_info):
    Dedicated video memory: 0 MB
    Total available memory: 15388 MB
    Currently available dedicated video memory: 0 MB
OpenGL vendor string: Mesa
OpenGL renderer string: llvmpipe (LLVM 19.1.7, 256 bits)
OpenGL core profile version string: 4.5 (Core Profile) Mesa
25.2.0~rc1+git2507191056.03f67b52319~p~mesarc0
OpenGL core profile shading language version string: 4.50
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile

OpenGL version string: 4.5 (Compatibility Profile) Mesa
25.2.0~rc1+git2507191056.03f67b52319~p~mesarc0
OpenGL shading language version string: 4.50
OpenGL context flags: (none)
OpenGL profile mask: compatibility profile

OpenGL ES profile version string: OpenGL ES 3.2 Mesa
25.2.0~rc1+git2507191056.03f67b52319~p~mesarc0
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.20

I ran `strace -f -o glxinfo_after_new_patch.txt -e trace=3Dioctl -X raw
glxinfo -B` to get the output attached.

I also ran `strace -f -o glxinfo_after_new_patch_no_X.txt -e
trace=3Dioctl glxinfo -B` and that output is also attached.

(This latter output is substantially the same as the output from
running this on stock 6.16-rc7.)

I'm happy to test any other patches.

Best,

Satadru

On Mon, Jul 21, 2025 at 9:50=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Jul 21, 2025, at 14:50, Satadru Pramanik wrote:
> > Sure!
> >
> > Here you go.
> >
> > The command I ran was 'glxinfo -B'
> >
> > diff glxinfo_working.txt glxinfo_broken.txt
>
> Unfortunately, the 'diff' output makes this a little harder,
> try 'diff -u' next time. I suppose passing "-X raw" to strace
> would also help since the ioctl commands are heavily overloaded.
>
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x48), 0x7ffc5a254340) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0x88),
> > 0x7ffc5a254390) =3D 0
>
> I think this is where it goes wrong first: (0x64, 0x47)
> is the correct type and number for NVIF, but after my patch
> I only accept the _IOC_READ|_IOC_WRITE caller but not _IOC_WRITE.
>
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_CPU_PREP, 0x7ffc5a254250) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
>
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
>
> More of the same
>
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
>
> This one manages to actually overload a command from another
> driver, but DRM_IOCTL_XE_EXEC_QUEUE_DESTROY happens to also work
> out to _IOC(_IOC_WRITE, 0x64, 0x47, 0x18).
>
> Obviously these commands still need to be supported, so we need
> to (at least) allow both _IOC_READ and _IOC_READ|_IOC_WRITE versions
> of it.
>
> Maintainers, do you prefer to just revert back to the original
> version, or should we do another round that allows exactly the
> necessary commands?
>
> It does get pretty ugly at that point, and is not that far off
> the origial version, with only really the _IOC_TYPE check remaining:
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 7bb64fcdd497..8bc61dfe7d9d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1284,7 +1284,7 @@ nouveau_ioctls[] =3D {
>         DRM_IOCTL_DEF_DRV(NOUVEAU_EXEC, nouveau_exec_ioctl_exec, DRM_REND=
ER_ALLOW),
>  };
>
> -#define DRM_IOCTL_NOUVEAU_NVIF _IOC(_IOC_READ | _IOC_WRITE, DRM_IOCTL_BA=
SE, \
> +#define DRM_IOCTL_NOUVEAU_NVIF _IOC(_IOC_WRITE, DRM_IOCTL_BASE, \
>                                     DRM_COMMAND_BASE + DRM_NOUVEAU_NVIF, =
0)
>
>  long
> @@ -1300,7 +1300,7 @@ nouveau_drm_ioctl(struct file *file, unsigned int c=
md, unsigned long arg)
>                 return ret;
>         }
>
> -       if ((cmd & ~IOCSIZE_MASK) =3D=3D DRM_IOCTL_NOUVEAU_NVIF)
> +       if ((cmd & ~(IOCSIZE_MASK | IOC_OUT) =3D=3D DRM_IOCTL_NOUVEAU_NVI=
F)
>                 ret =3D nouveau_abi16_ioctl(filp, (void __user *)arg, _IO=
C_SIZE(cmd));
>         else
>                 ret =3D drm_ioctl(file, cmd, arg);
>
>     Arnd
>
> -----
> (full quote below, as the reply was off-list)
>
> > 1,129c1,20
> > < 10221 ioctl(4, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(4, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(4, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254e20) =
=3D
> > 0
> > < 10221 ioctl(4, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254e20) =
=3D
> > 0
> > < 10221 ioctl(5, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(5, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(5, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254340) =
=3D
> > 0
> > < 10221 ioctl(5, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254340) =
=3D
> > 0
> > < 10221 ioctl(6, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_VERSION, 0x5564c66a4e50) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x48), 0x7ffc5a254340) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0x88),
> > 0x7ffc5a254390) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254330) =
=3D
> > 0
> > < 10221 ioctl(6, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254330) =
=3D
> > 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC, 0x7ffc5a2541b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a2541c0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254110) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254110) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254110) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254110) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a254210) =
=3D
> > 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254260) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_CPU_PREP, 0x7ffc5a254250) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a2541e0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254260) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_ETNAVIV_GET_PARAM or
> > DRM_IOCTL_EXYNOS_GEM_CREATE or DRM_IOCTL_IVPU_GET_PARAM or
> > DRM_IOCTL_LIMA_GET_PARAM or DRM_IOCTL_NOUVEAU_GETPARAM or
> > DRM_IOCTL_OMAP_GET_PARAM or DRM_IOCTL_PVR_DEV_QUERY or
> > DRM_IOCTL_QAIC_MANAGE or DRM_IOCTL_TEGRA_GEM_CREATE, 0x7ffc5a2542a0) =
=3D
> > 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254260) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254260) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254260) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_READ|_IOC_WRITE, 0x64, 0x47, 0xa0),
> > 0x7ffc5a254200) =3D 0
> > < 10221 ioctl(6, _IOC(_IOC_WRITE, 0x64, 0x47, 0x38), 0x7ffc5a254240) =
=3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254230) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GET_CAP, 0x7ffc5a254270) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a2549f0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254940) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254940) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254940) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254940) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_CPU_PREP, 0x7ffc5a2548f0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254a10) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a2546c0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a2547a8) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a2547a8) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a2547a8) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a2547a8) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a2547a8) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254a10) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254960) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254960) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254960) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254960) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_CPU_PREP, 0x7ffc5a254a40) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254a30) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254c70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254ba0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254c80) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254cc0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254cc0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254730) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254a30) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254980) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254980) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254980) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254980) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_CPU_PREP, 0x7ffc5a254a60) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254a50) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254c70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254ba0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254c80) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254cc0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254cc0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254d00) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254730) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_PRIME_HANDLE_TO_FD, 0x7ffc5a254818) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254f70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254ee0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_NEW, 0x7ffc5a254e10) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_GEM_PUSHBUF, 0x7ffc5a254ef0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f30) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f30) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a254f70) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a2550b0) =3D 0
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(7, DRM_IOCTL_XE_EXEC_QUEUE_DESTROY, 0x7ffc5a2550e0) =3D -=
1
> > EBADF (Bad file descriptor)
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a255060) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a255060) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a255060) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_GEM_CLOSE, 0x7ffc5a255060) =3D 0
> > < 10221 ioctl(6, DRM_IOCTL_NOUVEAU_CHANNEL_FREE, 0x7ffc5a2550b8) =3D 0
> > < 10222 +++ exited with 0 +++
> > < 10221 +++ exited with 0 +++
> > ---
> >> 5236  ioctl(4, UDMABUF_CREATE, 0x7fffd017e990) =3D 6
> >> 5236  ioctl(6, DMA_BUF_IOCTL_EXPORT_SYNC_FILE, 0x7fffd017ea00) =3D 0
> >> 5252  +++ exited with 0 +++
> >> 5251  +++ exited with 0 +++
> >> 5249  +++ exited with 0 +++
> >> 5248  +++ exited with 0 +++
> >> 5250  +++ exited with 0 +++
> >> 5247  +++ exited with 0 +++
> >> 5246  +++ exited with 0 +++
> >> 5245  +++ exited with 0 +++
> >> 5237  +++ exited with 0 +++
> >> 5238  +++ exited with 0 +++
> >> 5239  +++ exited with 0 +++
> >> 5240  +++ exited with 0 +++
> >> 5241  +++ exited with 0 +++
> >> 5242  +++ exited with 0 +++
> >> 5243  +++ exited with 0 +++
> >> 5244  +++ exited with 0 +++
> >> 5253  +++ exited with 0 +++
> >> 5236  +++ exited with 0 +++
> >
> > On Mon, Jul 21, 2025 at 8:38=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Mon, Jul 21, 2025, at 14:22, Satadru Pramanik wrote:
> >> > Hello all,
> >> >
> >> > I suspect this commit in 6.16-rc7 has broken acceleration with Mesa'=
s
> >> > nouveau drivers on my machine.
> >> >
> >> > glxinfo -B reports that I'm using llvmpipe.
> >>
> >> Thanks for the report!  Can you run the failing command with
> >> 'strace -f -o logfile.txt -e trace=3Dioctl ...' to see which command
> >> it tries?
> >>
> >> Either I made a stupid mistake in my patch and don't catch the
> >> intended command any more, or the command that gets sent is actually
> >> different from the one that the kernel expects.
> >>
> >>       Arnd
> >
> > Attachments:
> > * glxinfo_working.txt
> > * glxinfo_broken.txt

--000000000000800ba8063a720f7f
Content-Type: text/plain; charset="US-ASCII"; name="glxinfo_after_new_patch.txt"
Content-Disposition: attachment; filename="glxinfo_after_new_patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mdd8y94n0>
X-Attachment-Id: f_mdd8y94n0

NTA5OCAgaW9jdGwoNCwgMHg0MDE4NzU0MiwgMHg3ZmZkZjQ5YzY1NDApID0gNgo1MDk4ICBpb2N0
bCg2LCAweGMwMDg2MjAyLCAweDdmZmRmNDljNjViMCkgPSAwCjUxMTAgICsrKyBleGl0ZWQgd2l0
aCAwICsrKwo1MTE0ICArKysgZXhpdGVkIHdpdGggMCArKysKNTExMSAgKysrIGV4aXRlZCB3aXRo
IDAgKysrCjUxMDkgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo1MTEzICArKysgZXhpdGVkIHdpdGgg
MCArKysKNTExMiAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjUxMDggICsrKyBleGl0ZWQgd2l0aCAw
ICsrKwo1MTA3ICArKysgZXhpdGVkIHdpdGggMCArKysKNTA5OSAgKysrIGV4aXRlZCB3aXRoIDAg
KysrCjUxMDEgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo1MTAwICArKysgZXhpdGVkIHdpdGggMCAr
KysKNTEwMiAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjUxMDMgICsrKyBleGl0ZWQgd2l0aCAwICsr
Kwo1MTA0ICArKysgZXhpdGVkIHdpdGggMCArKysKNTEwNSAgKysrIGV4aXRlZCB3aXRoIDAgKysr
CjUxMDYgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo1MTE1ICArKysgZXhpdGVkIHdpdGggMCArKysK
NTA5OCAgKysrIGV4aXRlZCB3aXRoIDAgKysrCg==
--000000000000800ba8063a720f7f
Content-Type: text/x-patch; charset="US-ASCII"; name="new_nouveau.patch"
Content-Disposition: attachment; filename="new_nouveau.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mdd90zfw1>
X-Attachment-Id: f_mdd90zfw1

ZGlmZiAtTnBhdXIgYS9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X2RybS5jIGIvZHJp
dmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9kcm0uYwotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bm91dmVhdS9ub3V2ZWF1X2RybS5jCTIwMjUtMDctMjEgMTA6MzE6MzMuMTkxNDI4NTY5IC0wNDAw
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZHJtLmMJMjAyNS0wNy0yMSAx
MDozMzoyNS4zNzE3MzY1MDcgLTA0MDAKQEAgLTEyODQsNyArMTI4NCw3IEBAIG5vdXZlYXVfaW9j
dGxzW10gPSB7CiAJRFJNX0lPQ1RMX0RFRl9EUlYoTk9VVkVBVV9FWEVDLCBub3V2ZWF1X2V4ZWNf
aW9jdGxfZXhlYywgRFJNX1JFTkRFUl9BTExPVyksCiB9OwogCi0jZGVmaW5lIERSTV9JT0NUTF9O
T1VWRUFVX05WSUYgX0lPQyhfSU9DX1JFQUQgfCBfSU9DX1dSSVRFLCBEUk1fSU9DVExfQkFTRSwg
XAorI2RlZmluZSBEUk1fSU9DVExfTk9VVkVBVV9OVklGIF9JT0MoX0lPQ19XUklURSwgRFJNX0lP
Q1RMX0JBU0UsIFwKIAkJCQkgICAgRFJNX0NPTU1BTkRfQkFTRSArIERSTV9OT1VWRUFVX05WSUYs
IDApCiAKIGxvbmcKQEAgLTEzMDAsNyArMTMwMCw3IEBAIG5vdXZlYXVfZHJtX2lvY3RsKHN0cnVj
dCBmaWxlICpmaWxlLCB1bnMKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlpZiAoKGNtZCAmIH5JT0NT
SVpFX01BU0spID09IERSTV9JT0NUTF9OT1VWRUFVX05WSUYpCisJaWYgKChjbWQgJiB+SU9DU0la
RV9NQVNLIHwgSU9DX09VVCkgPT0gRFJNX0lPQ1RMX05PVVZFQVVfTlZJRikKIAkJcmV0ID0gbm91
dmVhdV9hYmkxNl9pb2N0bChmaWxwLCAodm9pZCBfX3VzZXIgKilhcmcsIF9JT0NfU0laRShjbWQp
KTsKIAllbHNlCiAJCXJldCA9IGRybV9pb2N0bChmaWxlLCBjbWQsIGFyZyk7Cg==
--000000000000800ba8063a720f7f
Content-Type: text/plain; charset="US-ASCII"; name="glxinfo_after_new_patch_no_X.txt"
Content-Disposition: attachment; filename="glxinfo_after_new_patch_no_X.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mdd95ki22>
X-Attachment-Id: f_mdd95ki22

NjQxMiAgaW9jdGwoNCwgVURNQUJVRl9DUkVBVEUsIDB4N2ZmZTlkNWM0NDQwKSA9IDYKNjQxMiAg
aW9jdGwoNiwgRE1BX0JVRl9JT0NUTF9FWFBPUlRfU1lOQ19GSUxFLCAweDdmZmU5ZDVjNDRiMCkg
PSAwCjY0MjggICsrKyBleGl0ZWQgd2l0aCAwICsrKwo2NDI1ICArKysgZXhpdGVkIHdpdGggMCAr
KysKNjQyNiAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjY0MjMgICsrKyBleGl0ZWQgd2l0aCAwICsr
Kwo2NDI3ICArKysgZXhpdGVkIHdpdGggMCArKysKNjQyMiAgKysrIGV4aXRlZCB3aXRoIDAgKysr
CjY0MjQgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo2NDIxICArKysgZXhpdGVkIHdpdGggMCArKysK
NjQxMyAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjY0MTQgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo2
NDE1ICArKysgZXhpdGVkIHdpdGggMCArKysKNjQxNyAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjY0
MTggICsrKyBleGl0ZWQgd2l0aCAwICsrKwo2NDE2ICArKysgZXhpdGVkIHdpdGggMCArKysKNjQx
OSAgKysrIGV4aXRlZCB3aXRoIDAgKysrCjY0MjAgICsrKyBleGl0ZWQgd2l0aCAwICsrKwo2NDI5
ICArKysgZXhpdGVkIHdpdGggMCArKysKNjQxMiAgKysrIGV4aXRlZCB3aXRoIDAgKysrCg==
--000000000000800ba8063a720f7f--

