Return-Path: <linux-kernel+bounces-755690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA2B1AA72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6F7A8D14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6B23AB8F;
	Mon,  4 Aug 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcTWFPT5"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393C19C556
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343753; cv=none; b=stehL/FgCXlSKyV/vJ2g3qlAHtNOguEw+CDjMVjAVU/ubYPWfRTDgc1pR29bhkMDWW8uxCVgpurS2EamoOJi7ujA9TZbqRECrLPlNtvlv3uFIL1a3qngzD/EFc7tD3UowKm1iq4mK05/Vr86/a52BqNb1ZVG6kCXFo7h725EKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343753; c=relaxed/simple;
	bh=D8QxJZysKTr2iVWnvFFEbI3IJltEzBfqdkoDQ9NCy3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFaWJRa55csUraQQo3UgUWMY/TcuXuk3V9faWr3py70qufT5LIsea9NJmJJtOiMjajYkAhMXD11U7pNnPKCqHw2xvmwa/cHp0PhV72D8bw2006cp71NLVCdcJtJHroHpvN4fQDRBpfOhM7C7zBeLVizsfMlBTO9HGad0X2pFig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcTWFPT5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3324e6a27a0so26592381fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754343750; x=1754948550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BibRjQ5YczxfcG6WRzvvUeamoebLWFnSrIxY8TQYGbc=;
        b=dcTWFPT55W1tqAhxl6LJK+OFCU89ib5k8ywQynQNWc73afzRkj/FrWA0nDlgBWF/yD
         dKmi3Uakrf3LoPVoxofhcFslj0LF0AuFTZJyB1KIeoO2FF06AWcRAu7Qq4oMpRlWLkrZ
         RptOuu0zEyW0tACSHnTJ8YtudC7lYYLboSxIUVIFQQZOlGXRikgHde6S+tAv+hrVYupU
         JocZFhnaSzRu52ApeWU1wSyqt9T5r2Iv7Zkv4MJ9HRK2MuG6idjhclGuOpiEFDDYSmxH
         kJEOVTZAH2qLlzTEyXpvSdGc/QSt0C8ys/jN64oSqREgvK36wBKwIia9A02rzKceDnlE
         A4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343750; x=1754948550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BibRjQ5YczxfcG6WRzvvUeamoebLWFnSrIxY8TQYGbc=;
        b=clQ5+6KBfXhRD61AHK6Zbrz+YQSLOiwnqaR6eV8/QOQQnSxb0OITelol1fQ6veiIiL
         w0p7+PU3As8n/Ct1Ofy1sJC3fnoHcz9oFvGszdLoWQBOYOZyH1jRyxDPEWE3gmqGrNvx
         qjRljbDDrYr1cY1RXuVNiA6hdAgbDRWkgHDrbNv5kce26JzUhGMLDj+40IVGsrzwzL9S
         oZuedhVd0WGPM0RpPDfp7nYPQlXQqDwXJOFg2/HrIBwbGAj8nbl0p+ojFNvQpZE5ueUj
         OqfboydrEkVYetQlOlZ2wzrUHtzUZ0c26J15bx/KuE0tkU/F9up4PrShDkpVPQTjfJD1
         a46Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9SKVQ11OBPkq37qlld9gMVnxPm5Tf9kLLZEdzE0nQ0rztZYP6ND4yR0bwPahwtWXLywWNgTYvxZXsI5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhD7NQes8wJ4nFbI01XQIZYHbEV5oZN3l8lR457B2JzxbKXyT
	hKWiqo8Y3UFGfES1nOW+KT4pjoZB4D99Fisd/nqrIvtUkKhKZc8RxvdKvtgKa4j+ZsjcdkA8yGS
	tv+jLQpcyF4XgBT8ryp0Wf+q6cBkggM8=
X-Gm-Gg: ASbGncsuTpWfC5l20bQeOkx8iqPIzKdughRrFdW4jJPSwptASuQI650cvHmNwr1r8mi
	hUBLBRAjtQwjiTiiYSyHNdZOOdkG0+N81krsNbMO90CrnVqyGGopTE9+9nyXTQW2DBb+lFCynqk
	sZZHWSlMSKObtcQc9/hY+NWk0knY/5YMSHFEk+Bp0YtPRZhTAa58nLF5j6AOcwAg8ZJj8Zo36wf
	iZO8Kg=
X-Google-Smtp-Source: AGHT+IFevc6Fzoz164jOxM1Z8SDPgIvXeRLhJyRdexOYSjzheOXWHaLebZQ/VtjLGFTbF7bp+XQSanAGy1RLQejd5N8=
X-Received: by 2002:a05:651c:217:b0:32c:b83d:64ab with SMTP id
 38308e7fff4ca-33256778daamr20294731fa.24.1754343749483; Mon, 04 Aug 2025
 14:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802161309.1198855-1-hsukrut3@gmail.com> <20250803165611.GG4906@pendragon.ideasonboard.com>
 <CAHCkknr+w3B0NWM065Rr_d9n9QEak7YmhehByQTdfwYr30RbSQ@mail.gmail.com> <20250804213347.GI30355@pendragon.ideasonboard.com>
In-Reply-To: <20250804213347.GI30355@pendragon.ideasonboard.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Mon, 4 Aug 2025 23:42:17 +0200
X-Gm-Features: Ac12FXy0phlLWltVfBe2pxMGctR2Sx9XnCESPbNc77AqSDO-4Mu0yImStrNWMmY
Message-ID: <CAHCkknr9JOWxqjMLikJhC2bOHOW_0UbY2YrN5nAGANM3m3y2pg@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_bridge: Document 'connector' parameter in drm_bridge_detect()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 11:34=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Aug 04, 2025 at 11:24:58PM +0200, sukrut heroorkar wrote:
> > On Sun, Aug 3, 2025 at 6:56=E2=80=AFPM Laurent Pinchart wrote:
> > > On Sat, Aug 02, 2025 at 06:13:05PM +0200, Sukrut Heroorkar wrote:
> > > > drm: drm_bridge: fix missing parameter documentation
> > > >
> > > > The function documentation was missing description for the
> > > > parameter 'connector'.
> > > >
> > > > Add missing function parameter documentation for drm_bridge_detect(=
)
> > > > to fix kernel-doc warnings.
> > > >
> > > > Warning: drivers/gpu/drm/drm_bridge.c:1241 function parameter 'conn=
ector' not described in 'drm_bridge_detect'
> > > >
> > >
> > > A Fixes: tag would be nice.
> > >
> > > > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_bridge.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bri=
dge.c
> > > > index dd45d9b504d8..387a3b6cda54 100644
> > > > --- a/drivers/gpu/drm/drm_bridge.c
> > > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > > @@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
> > > >  /**
> > > >   * drm_bridge_detect - check if anything is attached to the bridge=
 output
> > > >   * @bridge: bridge control structure
> > > > + * @connector: connector associated with the bridge
> > >
> > > "associated with the bridge" isn't very clear.
> > >
> > > >   *
> > > >   * If the bridge supports output detection, as reported by the
> > > >   * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.de=
tect for the
> >
> > Thanks for the review.
> > I will send a V2 shortly with updated connector description and Fixes
> > tag, as suggested.
>
> It appears that a competing patch got merged in the meantime:
> https://lore.kernel.org/r/20250716125602.3166573-1-andyshrk@163.com
>
> It was submitted earlier than yours, and the usual rule in the kernel is
> that the first patch wins when there are multiple similar or identical
> submissions.
>
> --
> Regards,
>
> Laurent Pinchart

Thanks for the update.

Regards,
Sukrut.

