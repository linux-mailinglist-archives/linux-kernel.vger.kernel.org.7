Return-Path: <linux-kernel+bounces-782496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B9B32133
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2FDB619B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546A31353E;
	Fri, 22 Aug 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="yCFxpbWt"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD72EE5FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882651; cv=none; b=C6VTfSQSsB6DSc6yqLcRYOXbdbKUWdQHt5jCDhn0R5bQ90Wkvq0UyLX7JuwqtLD02JD5CgmdniStdekJ1ZzYujh+opyGe7v5k0zwg/Ym+eCdszAa9Lmw9AIQlEdC+XJd3K3AA2dXxNLIHzP75wrz2qcVI/y/U0SvqkbpyEQNdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882651; c=relaxed/simple;
	bh=Wr5Kn7nqDDpxYdlp8aT1OG6n8qS2EMF0tEfcnxalo9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfFMlCRCHIqh/vlqffxaMxAizzMbOFePnPT1Td5wwrLCVNiXQQmQT/RobqGLRBswl09y8SMAtuUGtjnhMtOyWIGEkoRRfARImOPU0DhND/zXcFiFD3txY9KFyo3ZflJxfoPzEfHatDb/z8qma8zu9U3svq9BmJR+vk58UMxmXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net; spf=fail smtp.mailfrom=gfxstrand.net; dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b=yCFxpbWt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gfxstrand.net
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717ba0d5dso1696992a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1755882649; x=1756487449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOod9volShfVq9bcTCDYoGUjrhOK2U2VuJ0VwTTSFOs=;
        b=yCFxpbWt8cL5hV+QN+4pWikdRYteycPYuXNJklYGLYMn0DHv/BOih7hXuywpF6tZ0n
         gNp0Ck2vLdEcyEU9SwWy7vmuZ+dCNNI4b6i9iuF/OwRYFNL2Mt+JjuPz5rsF9O2Fpw7a
         xoZuUL6ZW3c9KQG6hM/q/dXzYAz2haEli89j4v77rVTA2P9F/ECPCUo4/W044lxdsqEn
         zyIP7IPHnWYyoKEhXLhQPrb+fyumcPXUl9jt2tizgjLpKBzUggE3FWLmQY+kVna7SgnU
         ORT6BGVxc+/vZQRz7R2ZMdEqtFQaafYNxt/ipTLrYfCnwKYB5H3MpalzY0CQMl8ZzDhl
         fteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882649; x=1756487449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOod9volShfVq9bcTCDYoGUjrhOK2U2VuJ0VwTTSFOs=;
        b=gWmCJ7dQ3ScpPcLciiscu0IeYtagfJTCas0Sci/nEvVs7XSu0zD8LhqdEIKI5Z6TIR
         cgIkaA6LiurzBhJrnEbWXGbLTp6KMB4FRZHkh2raotfya7R1EHLtKUIjSludDAlhpSHu
         UzG/f1XHceBN04xSJgmDzQBD2cVh/mwkMjjldM1MnRs89lpOY9hol0Aq6b0SJx/XAvkK
         upVfoQM5oXQf25KslD0o1y8J3bEnObdwibDGM/gIqILL4ovdDQcZxxR0yU5hF/C6Ensw
         YDq9/IXaV5vKnd69VdObV8d4P0Pf8QuN+CV3vURQyC1660zCdIaCvif2G+NRPpuA3nwS
         MoBg==
X-Forwarded-Encrypted: i=1; AJvYcCWO57/k8HpEsVTqr6495bmaf4J2m8tXFkyqk9EyXBvEY8IZ7omzhLCf+BnxSpaNganXdRXFnB82mvrfUqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkeLKrMaIf3vnjjEQRq0bR7hKcZlrfJoCCKSwZKyou+Giz8J/
	WT67+ipf8+qpfFoabscQfr8nWru3oi7VJx64jUW/riUr5vojfUYJYRTx+nIz7/MqSjs9dhvGStH
	SdtegNxHZSStcwr91CL00KmLZVOHOX5f8xLl5rjCC83dA67cyyyEbXBM=
X-Gm-Gg: ASbGncso5o4ZR8XvvPFNgQH1DfOqR/y4EBwpgvcPhuEv5oR991KJPeWBxx6gVm8jmIa
	7DrY4isg1qs1tuUJHF/XFtk184+9whfBgZgxbfRKK0uHO2VHjGG8RYUdoFItxqMrKhVbbBltKLJ
	qGY2b3pcC2NlCU5iMjBmghtRDP62pXDwff2UYE44WScZszxIhAdSWCukA3x45nb9B4zXB/SZc02
	+z0z1s=
X-Google-Smtp-Source: AGHT+IHxcbQSyIs4Pe5d8vlJ26jI9eO+0yZG0kWEuQAN38UzJn8be0v+nBoaWdpp6eJH0oJbZDOhuqOMwpvILCfHdbk=
X-Received: by 2002:a17:903:2a8b:b0:240:3245:6d40 with SMTP id
 d9443c01a7336-246328030e6mr47133755ad.0.1755882648772; Fri, 22 Aug 2025
 10:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220017.1337-1-jajones@nvidia.com> <20250811220017.1337-4-jajones@nvidia.com>
 <CAOFGe97AN_yo7Mg4Z7s=qOFzSGzzs6CLEAhByf-ks2GthFj0aw@mail.gmail.com> <2cf6b444-33cd-4313-a624-8d1a9cd6ec9a@nvidia.com>
In-Reply-To: <2cf6b444-33cd-4313-a624-8d1a9cd6ec9a@nvidia.com>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 22 Aug 2025 13:10:37 -0400
X-Gm-Features: Ac12FXw7aUzU6hPTcvS2h37yBJiQzAmsZzEd2-s-EMafvbthF_kln0kIYtYxyWQ
Message-ID: <CAOFGe97w3qgRL5Va=EO4kjayHojSq5SGpufoXCMG4riVew5cew@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/nouveau: Advertise correct modifiers on GB20x
To: James Jones <jajones@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:03=E2=80=AFPM James Jones <jajones@nvidia.com> wr=
ote:
>
> On 8/22/25 08:48, Faith Ekstrand wrote:
> >
> > On Mon, Aug 11, 2025 at 5:57=E2=80=AFPM James Jones <jajones@nvidia.com
> > <mailto:jajones@nvidia.com>> wrote:
> >
> >     8 and 16 bit formats use a different layout on
> >     GB20x than they did on prior chips. Add the
> >     corresponding DRM format modifiers to the list of
> >     modifiers supported by the display engine on such
> >     chips, and filter the supported modifiers for each
> >     format based on its bytes per pixel in
> >     nv50_plane_format_mod_supported().
> >
> >     Note this logic will need to be updated when GB10
> >     support is added, since it is a GB20x chip that
> >     uses the pre-GB20x sector layout for all formats.
> >
> >     Signed-off-by: James Jones <jajones@nvidia.com
> >     <mailto:jajones@nvidia.com>>
> >     ---
> >       drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 ++-
> >       drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
> >       drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 24 +++++++++++++--
> >       drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c | 33 ++++++++++++++++=
+++++
> >       4 files changed, 59 insertions(+), 3 deletions(-)
> >
> >     diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/
> >     drm/nouveau/dispnv50/disp.c
> >     index e97e39abf3a2..12b1dba8e05d 100644
> >     --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> >     +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> >     @@ -2867,7 +2867,9 @@ nv50_display_create(struct drm_device *dev)
> >              }
> >
> >              /* Assign the correct format modifiers */
> >     -       if (disp->disp->object.oclass >=3D TU102_DISP)
> >     +       if (disp->disp->object.oclass >=3D GB202_DISP)
> >     +               nouveau_display(dev)->format_modifiers =3D
> >     wndwca7e_modifiers;
> >     +       else if (disp->disp->object.oclass >=3D TU102_DISP)
> >                      nouveau_display(dev)->format_modifiers =3D
> >     wndwc57e_modifiers;
> >              else
> >              if (drm->client.device.info <http://
> >     client.device.info>.family >=3D NV_DEVICE_INFO_V0_FERMI)
> >     diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/
> >     drm/nouveau/dispnv50/disp.h
> >     index 15f9242b72ac..5d998f0319dc 100644
> >     --- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
> >     +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
> >     @@ -104,4 +104,5 @@ struct nouveau_encoder *nv50_real_outp(struct
> >     drm_encoder *encoder);
> >       extern const u64 disp50xx_modifiers[];
> >       extern const u64 disp90xx_modifiers[];
> >       extern const u64 wndwc57e_modifiers[];
> >     +extern const u64 wndwca7e_modifiers[];
> >       #endif
> >     diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/
> >     drm/nouveau/dispnv50/wndw.c
> >     index e2c55f4b9c5a..ef9e410babbf 100644
> >     --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> >     +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> >     @@ -786,13 +786,14 @@ nv50_wndw_destroy(struct drm_plane *plane)
> >       }
> >
> >       /* This function assumes the format has already been validated
> >     against the plane
> >     - * and the modifier was validated against the device-wides modifie=
r
> >     list at FB
> >     + * and the modifier was validated against the device-wide modifier
> >     list at FB
> >        * creation time.
> >        */
> >       static bool nv50_plane_format_mod_supported(struct drm_plane *pla=
ne,
> >                                                  u32 format, u64 modifi=
er)
> >       {
> >              struct nouveau_drm *drm =3D nouveau_drm(plane->dev);
> >     +       const struct drm_format_info *info =3D drm_format_info(form=
at);
> >              uint8_t i;
> >
> >              /* All chipsets can display all formats in linear layout *=
/
> >     @@ -800,13 +801,32 @@ static bool
> >     nv50_plane_format_mod_supported(struct drm_plane *plane,
> >                      return true;
> >
> >              if (drm->client.device.info <http://
> >     client.device.info>.chipset < 0xc0) {
> >     -               const struct drm_format_info *info =3D
> >     drm_format_info(format);
> >                      const uint8_t kind =3D (modifier >> 12) & 0xff;
> >
> >                      if (!format) return false;
> >
> >                      for (i =3D 0; i < info->num_planes; i++)
> >                              if ((info->cpp[i] !=3D 4) && kind !=3D 0x7=
0)
> >     return false;
> >     +       } else if (drm->client.device.info <http://
> >     client.device.info>.chipset >=3D 0x1b2) {
> >     +               const uint8_t slayout =3D ((modifier >> 22) & 0x1) =
|
> >     +                       ((modifier >> 25) & 0x6);
> >     +
> >     +               if (!format)
> >     +                       return false;
> >     +
> >     +               /*
> >     +                * Note in practice this implies only formats where
> >     cpp is equal
> >     +                * for each plane, or >=3D 4 for all planes, are
> >     supported.
> >     +                */
> >     +               for (i =3D 0; i < info->num_planes; i++) {
> >     +                       if (((info->cpp[i] =3D=3D 2) && slayout !=
=3D 3) ||
> >     +                           ((info->cpp[i] =3D=3D 1) && slayout !=
=3D 2) ||
> >     +                           ((info->cpp[i] >=3D 4) && slayout !=3D =
1))
> >     +                               return false;
> >     +
> >     +                       /* 24-bit not supported. It has yet another
> >     layout */
> >     +                       WARN_ON(info->cpp[i] =3D=3D 3);
> >
> >
> > Should this really be a WARN_ON()? A DRM log message, maybe, but
> > WARN_ON() implies something went funky inside the kernel, not that
> > userspace asked for something it shouldn't.
>
> This is indeed a something funky in the kernel case. See the comment
> above: "This function assumes the format has already been validated
> against the plane and the modifier was validated against the device-wide
> modifier list at FB creation time." This isn't technically true at
> format blob query time, but in that case this function is just used as a
> filter against those same lists. Hence, the implication is someone
> modified the kernel to report 24-bit formats for some display plane on
> this device, and the WARN_ON is meant to guard against that/validate the
> assumption from the comment.
>
> I went through the DRM code again to verify the "format has already been
> validated" assumption still holds up, and I see these callers of this
> function:
>
> drm_plane_has_format() - Validates the format against the plane's format
> list right before calling this function. This is the path a format from
> userspace would go through, indirectly as a drm_framebuffer property,
> when validating it against a plane during a commit operation.
>
> create_in_format_blob() - As mentioned, simply iterates through the
> plane's format list.

Okay. I'm convinced.

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

> Thanks,
> -James
>
>
>
> >     +               }
> >              }
> >
> >              return true;
> >     diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c b/drivers/
> >     gpu/drm/nouveau/dispnv50/wndwca7e.c
> >     index 0d8e9a9d1a57..2cec8cfbd546 100644
> >     --- a/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c
> >     +++ b/drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c
> >     @@ -179,6 +179,39 @@ wndwca7e_ntfy_set(struct nv50_wndw *wndw,
> >     struct nv50_wndw_atom *asyw)
> >              return 0;
> >       }
> >
> >     +/****************************************************************
> >     + *            Log2(block height) ----------------------------+  *
> >     + *            Page Kind ----------------------------------+  |  *
> >     + *            Gob Height/Page Kind Generation ------+     |  |  *
> >     + *                          Sector layout -------+  |     |  |  *
> >     + *                          Compression ------+  |  |     |  |  */
> >     +const u64 wndwca7e_modifiers[] =3D { /*         |  |  |     |  |  =
*/
> >     +       /* 4cpp+ modifiers */
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 0),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 1),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 2),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 3),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 4),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 1, 2, 0x06, 5),
> >     +       /* 1cpp/8bpp modifiers */
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 0),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 1),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 2),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 3),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 4),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 2, 2, 0x06, 5),
> >     +       /* 2cpp/16bpp modifiers */
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 0),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 1),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 2),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 3),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 4),
> >     +       DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 3, 2, 0x06, 5),
> >     +       /* All formats support linear */
> >     +       DRM_FORMAT_MOD_LINEAR,
> >     +       DRM_FORMAT_MOD_INVALID
> >     +};
> >     +
> >       static const struct nv50_wndw_func
> >       wndwca7e =3D {
> >              .acquire =3D wndwc37e_acquire,
> >     --
> >     2.50.1
> >
>
>

