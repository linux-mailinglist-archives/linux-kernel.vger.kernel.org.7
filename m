Return-Path: <linux-kernel+bounces-742880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A4B0F7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C3B17A6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036E1E8337;
	Wed, 23 Jul 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6KYXAb9"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50B13A3ED
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286968; cv=none; b=LONB9QvQ8mJSp1kG4fb7km3kytR/jaGWOtruf8T8iMBZ2U7OcL91esjF1zgnz86B7knfs+0Bl6oNmjU4PzDCLdAuLB25Mi7XNbqtCsNpC21nUJ8pHUdQgqVyQE5FI46aslG5GF6pTJgrDWdYKvHIlATrdzrC6N5CqFPFjvO2mO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286968; c=relaxed/simple;
	bh=5i1B6f1WovekQb0t2Q4MX1vwgoil7srvBZBIH/a852c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWdSHSLSUrPKq+zmBfG54NkqZbf+YBENVqBhQpHjvdJP7UFpWCg0PCU2ZgqzYy8rYvkAjlG3HfxJQ5zY6jBPsZPRPxxLJ5l0tfYdojoOL8cHcuCLm0uUYTxMeIFWw6sT4DbdVxmFWwlaB5/4PLjNKZ6a0DeWt53uBD8kvgZ/bmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6KYXAb9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-886ba728c79so241018241.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753286966; x=1753891766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiqvICJjX31b+xDIjisgqgN7QHL9poDjF7NeTkSy/Yw=;
        b=l6KYXAb9Xxmg+I4qub0715DwIkI5KY5IkTY/IHbar2GdWyfDulk6TIFHPWXAFFyHc3
         9k+S9HGhLRA3trSaQtfQzP+ovzUaxtTuVdABNuWPXG4Hhy5j3NDoptoMRZKa8sPZocKq
         4AQtE4J3AOKMiDdc1rkIpvCxsPFsGx7GTuWFcGYjfelMNqPZEXf76p8FTEaKDEyFWPsH
         y5H3irikattueXlNvX+oRNOCEeBSV/4F169pS4Zh2/U7HHee1uC2cHsYP5HRbaLROunC
         rXhfRGH5yBGt1D3ylucA0tqpAqcUW+bQqz1jZrgq1QlMAT+wK1qHPfhm+BSzsQkkVAYk
         Bbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286966; x=1753891766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiqvICJjX31b+xDIjisgqgN7QHL9poDjF7NeTkSy/Yw=;
        b=WaZfqT0165PazX+ystfm48/1bL290zlFiPLNq9er8n0wZ5redxY2dkTa8b2B9m5phM
         tbFQM1NxC3pA2oXJRFNT37q4TnZwuAqPR2QDV1TNNluPyGA0+XJyaSDCQvKDP5BrPrfM
         X506+9fXg8Ek0GLxJKm0zyg251jVGW0SdkorAPUA/9vyAyujCe/yipznsFRluafEAfAT
         2mCwOoxnVKPspUe1jgTYfsLvg17PHaLALrS2vKPH904msrfqMKlrwsYYN7nfbo9ZHLkc
         b+FLS8yjG9vMVLEhEwxB3bG6DVt4QWxx1IoUsPQZiYJl7qCpU/zs3vnJ2kPjNQasAfnD
         yI7g==
X-Forwarded-Encrypted: i=1; AJvYcCVQivdowhCv0sxELTdOp0+9p4UZdmW/sGytKN6hyMXGjvH66MNpkiqSH+Ni5X/fz+4DXUd1XCcKD2zFst0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLghesQZIMStkkQcTPxsUS0/F3V2d0LE/wzZR/XtRKgqlYweV
	y5yIZKExY5Cr5+PmKoqhKkOPG/6ddLy9C2vFMycqqbY7CCfQp0CcU7Wd73lKn/SozNALPPVEjfs
	O5/oG0Z6yETWJHD2nU9QPk4Jqp/waBg==
X-Gm-Gg: ASbGncuC9eGOgn7XtnRz1oV/UmncBEUoouaI1qTNd3HNa+WFKe7NaAGYM3PtE13hGv7
	xZYPCpJr8j6rJSob83VnEobN/6DpHWJyzul2CRulMCIjpyDCA7+5niTSiaF70p//pMoxDuXdI+R
	INloRTah1E8hV3V3JisDRBcqHGMv/htKoihhXkrjHmJk2ixmXLbMrYPDd3Bv1sa0mGmjFVyqfJa
	Om9Kg==
X-Google-Smtp-Source: AGHT+IHLoLIi9Sn5t7UcwQDFfNGKZYmYTYj7fcHTonbPWflJFuRM2pCYd005+IusGSZWW9aDNPoyaalzfB6mYcmmYqg=
X-Received: by 2002:a05:6122:d0e:b0:537:3398:e3dc with SMTP id
 71dfb90a1353d-537af65b97emr575987e0c.2.1753286965800; Wed, 23 Jul 2025
 09:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722204114.3340516-1-chenyuan0y@gmail.com> <20250723-gigantic-wrasse-of-warranty-dc70d7@houat>
In-Reply-To: <20250723-gigantic-wrasse-of-warranty-dc70d7@houat>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 23 Jul 2025 09:09:14 -0700
X-Gm-Features: Ac12FXym4TiBdgoqhdHCo4mS7HgWJgQ8vXuIRZKZN-9W5bm3rxYkRm6h2V9wc34
Message-ID: <CALGdzurMksSELQMDxy11gHS=pfASP6x_d+Sw2uZfXguLqb=J9A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Add null pointer check for ITE IT6263
To: Maxime Ripard <mripard@kernel.org>
Cc: victor.liu@nxp.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, 
	biju.das.jz@bp.renesas.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the second email.
I am resending this message as the formatting in the previous version
was incorrect

On Tue, Jul 22, 2025 at 11:57=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> On Tue, Jul 22, 2025 at 03:41:14PM -0500, Chenyuan Yang wrote:
> > drm_atomic_get_new_connector_for_encoder and
> > drm_atomic_get_new_connector_state could return Null.
>
> They can, but not in that scenario. atomic_enable will never be called
> if either would return NULL.
>
> In which situation did you trigger this bug?

This is found by our static analysis tool based on the fact that
drm_atomic_get_new_connector_state() could return NULL.
We also noticed that under the same dir, the ITE IT6505 transmitter
has such checks.
Thus, we assume it would be good to have similar checks here.

> > Thus, add the null pointer check for them with a similar format with
> > it6505_bridge_atomic_enable in ITE IT6505.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: 049723628716 ("drm/bridge: Add ITE IT6263 LVDS to HDMI converter=
")
> > ---
> >  drivers/gpu/drm/bridge/ite-it6263.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/brid=
ge/ite-it6263.c
> > index a3a63a977b0a..3a20b2088bf9 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6263.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> > @@ -590,15 +590,28 @@ static void it6263_bridge_atomic_enable(struct dr=
m_bridge *bridge,
> >       struct drm_connector *connector;
> >       bool is_stable =3D false;
> >       struct drm_crtc *crtc;
> > +     struct drm_connector_state *conn_state;
> >       unsigned int val;
> >       bool pclk_high;
> >       int i, ret;
> >
> >       connector =3D drm_atomic_get_new_connector_for_encoder(state,
> >                                                            bridge->enco=
der);
> > -     crtc =3D drm_atomic_get_new_connector_state(state, connector)->cr=
tc;
> > +     if (WARN_ON(!connector))
> > +             return;
> > +
> > +     conn_state =3D drm_atomic_get_new_connector_state(state, connecto=
r);
> > +     if (WARN_ON(!conn_state))
> > +             return;
> > +
> > +     crtc =3D conn_state->crtc;
> >       crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> > +     if (WARN_ON(!crtc_state))
> > +             return;
> > +
> >       mode =3D &crtc_state->adjusted_mode;
> > +     if (WARN_ON(!mode))
> > +             return;
>
> And that condition can never be true.
>
> Maxime

