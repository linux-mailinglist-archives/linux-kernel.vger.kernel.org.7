Return-Path: <linux-kernel+bounces-829974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63037B98597
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244F82E4992
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38723C8D5;
	Wed, 24 Sep 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDDbqDwX"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059F2D7BF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694070; cv=none; b=imUC+/HgF426O32O6A7SbLhxL/Rcs0l0nhVTUglbRurw8lP+Mx07cFQ78L6ds7S7YJMvdF5JYviDyi0MUTLyvHrytf2NYvNaHvJo+cGhNZq82AXwleNgJRHL2qjzHkbky7w9Ho8NZiyTue5Og7J8yWnd4w9eAzDD7Qan0WtTtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694070; c=relaxed/simple;
	bh=I06BXhpPXpJEEUQCQ5M1faoAt4YtubozaPfMBEUCyL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpNd0x5TaELn3zxhKxkVojlInEkv12dHqnaL9V67KT/nrmfKz0y9DKHYdiXHiq3goKqJ8+lmKd0gegtGQYa3zF4wRpKRIEomYWJGFbzwtR74Nno9tNLfl6i3Lxr+yiWmUAiWz97i0YXUtza9XbsrxuoXsa3W5qGXh74IOCX4T4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDDbqDwX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8ca2e53c0d3so121410439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758694068; x=1759298868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dasyWeqvVNrFPy7VboPpD0Yyy39SDT10f/tzxZcxFug=;
        b=EDDbqDwX0stB+vQcESJBG969PCV+iKuYYIIaolMVwcv9IpmGaZfoFYKGc1tFUoFrPO
         Q/e1XciashOAgjKAmH9UgDIQVlg6jzeDOWugCY4dpWFeR8KG+zkZP1Pj5M6egb6QazOM
         cUlhreqBF863zes9OMTKCE49kj79mMAk6x2JXx7TYREjowlSdDxeQCNw65py+njtTbHN
         D6zyJCyk4NnJoee9lo0FVVSUMCIHAtsTDDOVlacQpHiU0BgrDjXrHFSBNclW9NCme8F4
         2p9stoYPF0e3n98wSP1k9jWMontpMvSA/Es7WlhNL9+EPM12ukjfl5QjVLQuzcGevyAu
         ZdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694068; x=1759298868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dasyWeqvVNrFPy7VboPpD0Yyy39SDT10f/tzxZcxFug=;
        b=xToRI0unSxn/GktIIJYU+fkQjiMlUinfATMJrLalUnXsnZsQ6Hhww6uPq4F8FnaBa2
         Tx0AI1OoxI4eVx5wFhpiNQ36e8i+pRmTmG1R0gV2620AenyO6jx5053ntAXJn6JjeOgk
         xLgFwpaRLHHBvtHLe3PfWRGGvKkqfvU12AEu7MeSVWdiadgYTve9LKqNyvMXFzYUokcy
         iB7PbW8sQQ2QlalnPjoYH4riTHND5vPFZ7XUkQrw6rwWj2Fjrjio4iiDUbDjtWZh0XBW
         RrcgJOpdpEzIG/f3k18s6B2tAxJpGwjCeRNlKKA/KQF3TJsW1gKKkRIDW0CQdyoU3oi/
         NKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUIBe+Fafdl9ijfYOedk6oCP+PHSMSh2rRSwiaROmCAJs+hIFvIMKhZPW2hN49vsuI+PV0ApJW3zryF5Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPlk1tlSigPJB/ZfG1XvxxyfK+LBv5IWSB+AtnkD0am8e2b7D
	Mwfjk39A84qo//pLTc3z81SvC/JTUSOykMzvPH0qDyVCOMsbjCjdSSF5nXju4uh2hudP9Ul3rz2
	Qp/rBSdJzL4d7qQ8qEeFCzrSRCBLhuOo=
X-Gm-Gg: ASbGncsHMqGb5RdQDssFKU611/Gy3/LpAjIFFU6cm8pi6jC/npfqnGbKp4/KkpWk1H5
	/mbTfkbScRiHTLs5R8grX3Z2doR8315hwK7jgWZSjqe+gP2Dni/71DYAAm/MRQBB8GL/iuaAU5G
	yBbtuaB08vu0UUFGbtHagaCq3zwJxwW/XbyAT4E9zMSL2y5NnGsX1I1dlmIh2QYUZhCDvIMklcJ
	Sd2fw==
X-Google-Smtp-Source: AGHT+IF7Azm3CSbUgIQ4C9xp80mGayFs6CTpry8PZJSTktWx2LuSb+ASvg7efRnLQb4fysk7hEHLlIkaBjL07vspxo0=
X-Received: by 2002:a05:6e02:1d8a:b0:424:82a6:3105 with SMTP id
 e9e14a558f8ab-42581e7a637mr77513085ab.18.1758694068284; Tue, 23 Sep 2025
 23:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923110025.1358920-1-rk0006818@gmail.com> <712a27fc6c4060e67b3da58cb8564387b40b5971@intel.com>
In-Reply-To: <712a27fc6c4060e67b3da58cb8564387b40b5971@intel.com>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Wed, 24 Sep 2025 11:37:36 +0530
X-Gm-Features: AS18NWD5IFOEWGCNPxL9ZnD6mR-sqY_bheO6aEH2LgX-tdaroQ-7z_CDe3m7m7E
Message-ID: <CAKY2RybJ+kyj=5E1pnu2RUEW3T7rXLrqyedR5LkfX=bUOv=_8A@mail.gmail.com>
Subject: Re: [PATCH] drm/tiny: Use kmalloc_array() instead of kmalloc()
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: lanzano.alex@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:21=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Tue, 23 Sep 2025, Rahul Kumar <rk0006818@gmail.com> wrote:
> > Documentation/process/deprecated.rst recommends against the use of
> > kmalloc with dynamic size calculations due to the risk of overflow and
> > smaller allocation being made than the caller was expecting.
> >
> > Replace kmalloc() with kmalloc_array() in drivers/gpu/drm/tiny/repaper.=
c
> > to make the intended allocation size clearer and avoid potential overfl=
ow
> > issues.
> >
> > Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
> > ---
> >  drivers/gpu/drm/tiny/repaper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repa=
per.c
> > index 5c3b51eb0a97..4d439a2d973a 100644
> > --- a/drivers/gpu/drm/tiny/repaper.c
> > +++ b/drivers/gpu/drm/tiny/repaper.c
> > @@ -535,7 +535,7 @@ static int repaper_fb_dirty(struct drm_framebuffer =
*fb,
> >       DRM_DEBUG("Flushing [FB:%d] st=3D%ums\n", fb->base.id,
> >                 epd->factored_stage_time);
> >
> > -     buf =3D kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
> > +     buf =3D kmalloc_array(fb->width, fb->height / 8, GFP_KERNEL);
>
> That's just not the same thing, though.
>

Thanks Jani, you are right. My change made the allocation size
different from the original (width * height / 8). The current code is
fine, so I will not change it.

Thanks,
Rahul


> BR,
> Jani.
>
> >       if (!buf) {
> >               ret =3D -ENOMEM;
> >               goto out_exit;
>
> --
> Jani Nikula, Intel

