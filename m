Return-Path: <linux-kernel+bounces-782439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE5B3205D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F52856178A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5327261B9E;
	Fri, 22 Aug 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="Dt+cUg77"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603E537E9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879448; cv=none; b=Ps44ZwuROxY79tvseatM+/meQTM9JNxS10T/lc8j0nbv1PYasc9ZJ3TJQFxKMVTDB1I7oUEmomS1cjgCwD/AEMdrs5QbzsxX4adeXoq70yQqDZFR6X2Cf6x408sCnpal2KrBo4wG/C2BfDlE7Uj1XNSs8n+LUfwQf7/UTjfPjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879448; c=relaxed/simple;
	bh=9xZFE6t3K0AB2P7C5JCK+h3dwtQwyGwLIK7hLb2Y9t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPfqbBw3MIkmH1iUAqIlVgntooB7zQr8V1z6fibe1a0WaFLzCth8//rkMslbTxEuePCKwV3Pt4ss8vPjbd/52/mWq1Ea8euWKnD5467kGHfQSWxUaQhZaP+4BPZp69i3aoVAjf+kZiEp2StGQn5rzXOrKXGMAKk/w/hEZjpIync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net; spf=fail smtp.mailfrom=gfxstrand.net; dkim=pass (2048-bit key) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b=Dt+cUg77; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gfxstrand.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gfxstrand.net
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47174c8e45so2138883a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1755879446; x=1756484246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXrBj7czlnifHIIbHLhwjoziAY7MsV3SxS2LubZ5kMI=;
        b=Dt+cUg77fJhPI46tWqj7MeWDRutOWeDMO5Zt/eN4jHVvMvTYKE8oPLGslXJAAXq+Bo
         UBsVJiXzMV6PJe7F1Yri6Xt00LjiM3JqRg2QAfmhcl9PiZ/0ktGo23q7bqDfGANb6AMo
         SBRA+8yJzwT6Ss2i2i/IJ0J6BXyGGKpTSbtzv2N8uAptakaSym+6xlM0M9zF/YzYBAeU
         8rJlw4KNGmdk95aB3uCvE8RAgBQK2Z+tLqhhB0+Lo+cI/4y4AGI+lH8DGWn8VYC6hYU8
         AZJTsHgbRDbFR/M9DoXRgubhcTo2Wh5GIUbTSQ8CAvG1OZprG47C9nCofqqKNqJusTJ/
         Kzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755879446; x=1756484246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXrBj7czlnifHIIbHLhwjoziAY7MsV3SxS2LubZ5kMI=;
        b=h4NY7OvqinvZwf9JllTQ6bXO2ltGW/CLq3O/08jLSSlRlxq/nDVbsouLrtuYsrQSSr
         Z3El9NswdwDkHwFL8OfzLpL334SbXCvNrAcEGGLAS0Kmp8Qyj979p+V6TQPHcADF3o0v
         jgYEjCnJ8w9n/SJC56xVmu/AfpuipXfsCjY8NBauDslos6wPXp+IuWIjkYEhTzBAZsgO
         rbW7m38HQLR+h3paxm+7arv9eDjTvZdTc9IJBotALvnWUEbz/eNtF+Inl/VGiWx/IKre
         638dJqO3XJs+w2Q2QKWswZiyPW9TZ8QgUXg1qWmhNhMl6yu/2y+PIlI3zHpqyCrZ3jNp
         Z7uw==
X-Forwarded-Encrypted: i=1; AJvYcCXeDSj0OluHyQ7ytIwZ3swHDZbdYQDtKAfI0ENPZzM99fWeeT6rkj9NaDqp32pqEY7OWiYgAtTGe7kfmBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSNJjOCPpAzKnngZNenDFl4ikwWrbQto7zgzFb1+GRUcZx/U0
	mvs/NMoM4IKzdiH6vxfZ8y12N2UoN4kxfCzLu4utgFFSGSIYOCXHivhOostMIhptuVLVBHD7fDD
	8gYGEoWD/v1BmKr7FTZepJK4V3Cq1mJKD8mYOCMSISg==
X-Gm-Gg: ASbGncveh+x/H74GMq3h1lA59nUYJWPWZyNc3eTXjmpvAOWupaBysGd6KBxXudnsGr6
	8yUUcAr09HNMro9UhMtCen9k5LTFo+TFXHNzfkocdn3L4KkyFWrvusUk74AQvKeoWV/gthJ/nb0
	q6LZFmUxJnOdOACYoMBKC5fSP0KqqbcmAVgVOl5/0WL/cU7gkpWPco9FLFyCAytuiEP2Ygcih0r
	2JrJ2g=
X-Google-Smtp-Source: AGHT+IGKWtnF8OMUPJUOBvgQeqNkELMzDuHtBwU+4iu0PtZ/qxp4Qh7KY9Mf/HhXhmKEYahJdPwQFQh0rwo7p48KCm8=
X-Received: by 2002:a17:902:ced0:b0:246:4e37:e8e0 with SMTP id
 d9443c01a7336-2464e37e9e9mr25615135ad.38.1755879445875; Fri, 22 Aug 2025
 09:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811220017.1337-1-jajones@nvidia.com> <20250811220017.1337-3-jajones@nvidia.com>
In-Reply-To: <20250811220017.1337-3-jajones@nvidia.com>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 22 Aug 2025 12:17:14 -0400
X-Gm-Features: Ac12FXzLE4N5nRMxFA42E8ma-vDPWeG1DvDUBRrSAZcCpMWQJqqBY0NIR6FzHhY
Message-ID: <CAOFGe96j4+j4=3gcPH2k3aA7ST=ZS13O8woLUER2rKyF6xEgwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/nouveau/disp: Always accept linear modifier
To: James Jones <jajones@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:57=E2=80=AFPM James Jones <jajones@nvidia.com> wr=
ote:
>
> On some chipsets, which block-linear modifiers are
> supported is format-specific. However, linear
> modifiers are always be supported. The prior
> modifier filtering logic was not accounting for
> the linear case.
>
> Fixes: c586f30bf74c ("drm/nouveau/kms: Add format mod prop to base/ovly/n=
vdisp")
> Signed-off-by: James Jones <jajones@nvidia.com>

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

> ---
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/no=
uveau/dispnv50/wndw.c
> index 11d5b923d6e7..e2c55f4b9c5a 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> @@ -795,6 +795,10 @@ static bool nv50_plane_format_mod_supported(struct d=
rm_plane *plane,
>         struct nouveau_drm *drm =3D nouveau_drm(plane->dev);
>         uint8_t i;
>
> +       /* All chipsets can display all formats in linear layout */
> +       if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
> +               return true;
> +
>         if (drm->client.device.info.chipset < 0xc0) {
>                 const struct drm_format_info *info =3D drm_format_info(fo=
rmat);
>                 const uint8_t kind =3D (modifier >> 12) & 0xff;
> --
> 2.50.1
>

