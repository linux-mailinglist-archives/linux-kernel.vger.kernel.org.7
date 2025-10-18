Return-Path: <linux-kernel+bounces-859097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42746BECC63
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18FD624335
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FE285CB9;
	Sat, 18 Oct 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1eDfeEj"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476B287256
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779347; cv=none; b=nbu6P//HU34e9gS7JBYcJmWvXuEvw6QEFb0a5sozEkJtn3JS6wimoqtJNBojsEcVc3B9OeJr6+0k2P0Zh0bvCIA8+lVLlgBqWwoqFaJH6aLvmH0vonFbltV5ijErXTQEHSvAHijGTwpMIHuZfMzwR/qJS91JRonTvC4t/FVNVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779347; c=relaxed/simple;
	bh=hhVH8BkTy/gjKD1kTBbZU+bCce00nFxG6odly3zlq+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VchFq6YSX7wKDJ/7fHkM7crkfMUOPfEqEZ4ZrqOIs6g63GMb9G8KTCHYou6me/FCRU1dsWiiddGEnkr0p/wN+bxl4icU8JwFJEokj2sIWMWDos6fo+GfuYuzY3pBYMs2CU8vGAyGUGBbENhPsFNS0rq6XYejr85tqR8OTpjgnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1eDfeEj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290cd62acc3so21042605ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779346; x=1761384146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G9BxEckj/hKiD9YMQD9HVfTYNNFZve6IgS2FIJnpK0=;
        b=E1eDfeEj2AhBhO/FHJ4Ffl9bH04b//Hltc59h6ZdvLgAK3rZqE8yCB9SrZNetZYZv+
         yQruB4Ewnx/0vHDdyWVkjhdm+HiMdM1kqRbBmjNxyZ6Nxo2yWYkaEW2jJfYwYeXNZvDL
         SeddcsCkVZa6PBFGYl9Bj0pcE0gEA/DbtJfi5EOOO2RIylD/pBVt92c362gkXUpvrCgp
         QPgRC4u17fdXwESTpISTUkdhcqyjjzuIDTjgYCrx0HlUWS+BOqR8mYc7RyKehp+zo6ls
         GZXnd2OLnWWT0PmPkGQzCogBrN3hJjFwJWzh+UWbn9Nm27iJls7r/hFz1W3kE//p5x/U
         OKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779346; x=1761384146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G9BxEckj/hKiD9YMQD9HVfTYNNFZve6IgS2FIJnpK0=;
        b=NNkWooo3hfpWktZfOQiYH5RbNgyAqA7aeuBcepIlOn2W2OgUGhgyuq4swjgrtiN3Ep
         3YWCt0W6I4o4Kxli12wfxtajy1TCfESy+GF+RdEg+DMNw767MaeK1F6aqeWAvK+QS+/S
         cNDhNSkNcn77CSLm4MYqOo+y5cc0y1FgG1eNoQF/l7or7HcAJsEDchcc16s0UvgamnXC
         5rkl5KTQ74tU+gqijsOfO5rY5oNQXsB0qTPw+Naqgn3MIlGqAl07I2+omKjrqYZu3qJa
         3dK46QK/rayBZuukWhUv3yrKMLXPGQRpRWbeRtvuMwscrPqR5RJ/R02J0TwyWCXzKOCn
         0TxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9FeuoTf5L1x0cHpXbb19y9/m5IL0iXPqU9y3MzVhrFVUyx9MbSTpx7634yYnC+0lFhT3jkeeeFkHVSi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNZWhsLarrItUu8VQcdTXoWwyt+PocPp71qw/U0hfLKXQInJP
	YAC2sfx0viA0sa+xvt4QWHXjKeqXl9pEKnB3F9BA68BrmAQlPm8APBgx5IbWESO2HR3A/asZ0kV
	neELGw6aJ2vGEaVu9JnNzbortAM8F2nuW1g==
X-Gm-Gg: ASbGncuFGlW2AvaaROosR5Ht4I+Y2hvAKJTU5OifP3PsyJonQWkn1c9QyHugiaDfOxj
	/H7isfrP18413l2ekLNTYlvjJKayUlgBVkaau1L1FuWdIE+dh5YbEc1kqLVDyyEzObPWTy7h7HF
	h66Bk6keQ/pYSusPd6qzvkjXJ5Xuy3mgdI7zssZKNMh6ZTVuxH2DvtlD/8WcxfBYRpctajCibXt
	4JIyLw6UsP4NN9lYG9Ex4LegSSj9kLDufJeQmOfULfDKEcEUAkrGwhzWrvncu5i5uS9jUTASlzt
	LZ6rYOOYtzjkwU9SuGgo39bxAY9luQqbcCykSzE40/DsuaKQKKHazHxflDaWyZ6wgydcoymux4L
	O
X-Google-Smtp-Source: AGHT+IEDraNRZq42ZNDrvZOFr/ZhVuZxPKdBOfz5GcwmFXkQIMvrymtjNxBY7OaPdZra3os9hGzTd4YOk5RGIoRB1pc=
X-Received: by 2002:a17:903:15c7:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-290cbb49964mr84235515ad.46.1760779345803; Sat, 18 Oct 2025
 02:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054913.7871-1-opensource206@gmail.com> <CAKPKb8_8uQdzNevB4wVpXcRrBr0-rjfvBR=oNNyCCA4yASgK-g@mail.gmail.com>
In-Reply-To: <CAKPKb8_8uQdzNevB4wVpXcRrBr0-rjfvBR=oNNyCCA4yASgK-g@mail.gmail.com>
From: opensource india <opensource206@gmail.com>
Date: Sat, 18 Oct 2025 14:52:14 +0530
X-Gm-Features: AS18NWA37AT3s44AjDjx0AdSOALzC5N477YH04L3-Zo96vppdITWdCR4HCOVGAo
Message-ID: <CAKPKb8-JE5W58jQOFSxr74sguoRop=3BH9EsVid-dXyGZkEpCA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace schedule() with schedule_hrtimeout()
 in fallback wait
To: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 4:21=E2=80=AFPM opensource india <opensource206@gmai=
l.com> wrote:
>
> On Sun, Sep 28, 2025 at 11:19=E2=80=AFAM Pavan Bobba <opensource206@gmail=
.com> wrote:
> >
> > Replace the open-coded polling with schedule() in vmw_fallback_wait()
> > by schedule_hrtimeout(). The old code wakes up at jiffy granularity and
> > leads to unnecessary CPU wakeups during fence waits.
> >
> > schedule_hrtimeout() provides high-resolution sleep with finer control,
> > reducing CPU utilization without affecting fence correctness. For the
> > non-interruptible case, use schedule_timeout_uninterruptible().
> >
> > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_irq.c
> > index 05773eb394d3..64045b0efafc 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> > @@ -202,16 +202,12 @@ int vmw_fallback_wait(struct vmw_private *dev_pri=
v,
> >                 if (lazy)
> >                         schedule_timeout(1);
> >                 else if ((++count & 0x0F) =3D=3D 0) {
> > -                       /**
> > -                        * FIXME: Use schedule_hr_timeout here for
> > -                        * newer kernels and lower CPU utilization.
> > -                        */
> > -
> > -                       __set_current_state(TASK_RUNNING);
> > -                       schedule();
> > -                       __set_current_state((interruptible) ?
> > -                                           TASK_INTERRUPTIBLE :
> > -                                           TASK_UNINTERRUPTIBLE);
> > +                       ktime_t delta =3D ktime_set(0, NSEC_PER_MSEC);
> > +
> > +                       if (interruptible)
> > +                               schedule_hrtimeout(&delta, HRTIMER_MODE=
_REL);
> > +                       else
> > +                               schedule_timeout_uninterruptible(delta)=
;
> >                 }
> >                 if (interruptible && signal_pending(current)) {
> >                         ret =3D -ERESTARTSYS;
> > --
> > 2.43.0
> >
>
> anyone please review this patch?

Hi all, can anyone please review this?

