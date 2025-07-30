Return-Path: <linux-kernel+bounces-751363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04FB16855
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CE44E4A25
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D2221561;
	Wed, 30 Jul 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBEzMEok"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E7D5383
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753911464; cv=none; b=bsJEJzsGDD3f5w1vb8cj1HQaqBxwcpuMJUvlC6FEUFSHG7djAetCDOgjHXXyLnYmtWKBMdalDEM3fRw+zUoDDneNAPItilJqeGUJYUki68MqjWy0hwWt6KTmvjnvO9GgYt0kmuYe14mlMMB2+tde83UOo0AZauc6pXarVnTZ8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753911464; c=relaxed/simple;
	bh=XEHQfaZ+VyuBttuZVhxIdZ5ta7icfQ0GCl/9iGlTYuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/rj6p+9hXoKkOW/aGHmrK9cToKNTwUoyQO012mIrtxeFJmiZLsY6GS4Kl2KUuYITU36IY0cOfnIVMrjeRXqUQGKiEI88i9xAXqiEjwyEoQ5t7LzOU0/TXorBkDeq0pDUEP5Arbvr5tPJIQ44+QLsE/gj5behGcuNLLF0SVFVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JBEzMEok; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so378055b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753911460; x=1754516260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trba2romfAqKA5pCTcTWA+7l/bmJjMmTIDHvknnQsLU=;
        b=JBEzMEokYa3wXOFLA50CfOdafPK0V4kO0vfuVG6X07Lztz4Dfm7ssDzYtoOxXKANRY
         pIyVBXYI7HJnujSytd0QjEwrQf/S4n429HTSqG53+XBM+QSLt7xekXV+kArW4rTJPawj
         3ge9kxVr2RpD6ptGtQCNXvJYIcwUGFaQPbpqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753911460; x=1754516260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trba2romfAqKA5pCTcTWA+7l/bmJjMmTIDHvknnQsLU=;
        b=xEidJSkcyHoyxIf5sHs0tMFzehDvtC98cbd5fKEnFqK12zCkrfE94FMIH48P3lbJGs
         REyTCowtwQ7rDKG6Eqjwc97jkLJPpmeb44/OgiRtgs4UCRhicKCVzAk1Y2vDbsr/x77j
         2ZhgbtnaWpAVnvqamPBkQXGullC4ByMwIIWPKpleNMqXb2C5O0ZjA3He1FUZqIZrQq1m
         TtwGNCB3F7EvUC/rW+eZeLfPMDnDH5myOEWX595c2IaVuYaRbymbeU38EwxP5v3rBzmG
         LRwN3VvYG6mzY7+L+4PXTwLj8BgY0fJbwjR+fmXqF4HLBexfALM/djS7S3Kt/xXhNXRu
         Jb4w==
X-Forwarded-Encrypted: i=1; AJvYcCVRzosZ0TF9p7X4aw1U89omn4T5oA7WLVBSROJuSCq/edKXQJocVg5H3/rtX8xy+qnc0Dn+y3vjoIUA/mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5rat5gQjDfX0OBnU+gFtlCHdrcswrcJ2Z+pI+CEBr0cD1N7z
	cpOcU/heRFWBw6DMn2/YCBZ5ebyUtz7RPdtpw185mH8eWMDwUCJDVwItXV/NduxOlLdZIble5Y7
	EvY0=
X-Gm-Gg: ASbGncsqhbL9rmKSLi0JBc8LOv0j5mxBoYP/pSAkJFWkv7Y7WceiFkIqe62lKbfp/p7
	xWMIbEaB02HMSlaxTLCc5FbNgqBjr2Mjy/onBz1QZ/G+Ts+dHwkzN6rsEP1O15y/6p0uTCXjiHB
	w3Yhm38S7X7R7YriHAj2F/r8NUsp1monibh6U0zk1FkBlyS//ZPqkKnibcKfaAbLVsyNIV6Hzuh
	PScefJs/DhJXAZWyq2ajeGgXVWBesRnczpCefIbv3LCmoTHTYYHsV2W32/8X9AhmovlJuVq2DX4
	O2CeMUZsGeb68GgFqsQyLWp5BPDgyDKHB9wgyncRUqhzqrqFBH/K7JEwQtxeMPn31CAJk+SDh+6
	QObPuCS8VUX6vPgXbHTGcMxVs08jJZC/4Xaf0O2/gj1i3wZAfClcTB36nWZ4ZyqhKpA==
X-Google-Smtp-Source: AGHT+IEN3359UQdwtZkYN8KpxcBA8K4CsvZQ8pZWh9Xjm3B/pgZ8T2DeCxKJmOF/FJx93xLUoe8QtQ==
X-Received: by 2002:a05:6a00:1248:b0:748:2fa4:14c0 with SMTP id d2e1a72fcca58-76aadc78598mr7198307b3a.0.1753911459952;
        Wed, 30 Jul 2025 14:37:39 -0700 (PDT)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76a794e7eebsm3666271b3a.123.2025.07.30.14.37.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 14:37:38 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-879d2e419b9so135847a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:37:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiabhw6nrOlcwevxjcVaFh7hsO1DshIORmUkih4Aq8w75K6s1+U9uFJZCg/RHJYAJlCTaUIM826A9YamU=@vger.kernel.org
X-Received: by 2002:a17:90b:2690:b0:31f:8723:d128 with SMTP id
 98e67ed59e1d1-31f8723d163mr1711464a91.34.1753911457424; Wed, 30 Jul 2025
 14:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
 <20250727165846.38186-4-alex.vinarskis@gmail.com> <CAD=FV=Xd_xL=PYvVNqQWFZGmqN+Q=SvvaBTfbv9k+fDb8QwUtQ@mail.gmail.com>
 <CAMcHhXp47zmpoNYLCVRWWBk4HcYepgWX=3kWWzW8c8+a=2kE6A@mail.gmail.com>
In-Reply-To: <CAMcHhXp47zmpoNYLCVRWWBk4HcYepgWX=3kWWzW8c8+a=2kE6A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Jul 2025 14:37:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XT-BBRDBHVh2KBpJydSje7_eUF19OMu9e3CcRvDf7ung@mail.gmail.com>
X-Gm-Features: Ac12FXxsWI-JqOTSi6Zqqs_uBhOIVlKslLHhjHruc_ljfiRzC80Syh2AMH_Yjow
Message-ID: <CAD=FV=XT-BBRDBHVh2KBpJydSje7_eUF19OMu9e3CcRvDf7ung@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel-edp: Add BOE NV140WUM-N64
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 30, 2025 at 1:38=E2=80=AFPM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> On Tue, 29 Jul 2025 at 17:50, Doug Anderson <dianders@chromium.org> wrote=
:
> >
> > Hi,
> >
> > On Sun, Jul 27, 2025 at 9:58=E2=80=AFAM Aleksandrs Vinarskis
> > <alex.vinarskis@gmail.com> wrote:
> > >
> > > Timings taken from NV140WUM-N41. It is found in some arm64 laptops,
> > > eg. Asus Zenbook A14 UX3407QA.
> > >
> > > The raw edid of the panel is:
> > > 00 ff ff ff ff ff ff 00 09 e5 f6 0c 00 00 00 00
> > > 10 22 01 04 a5 1e 13 78 07 8e 95 a6 52 4c 9d 26
> > > 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > > 01 01 01 01 01 01 5d 30 80 a0 70 b0 28 40 30 20
> > > 36 00 2e bc 10 00 00 1a 00 00 00 fd 00 28 3c 4a
> > > 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fe 00 3d
> > > 4c 33 30 20 20 20 20 20 20 20 20 ff 00 00 00 fc
> > > 00 4e 56 31 34 30 57 55 4d 2d 4e 36 34 0a 01 f8
> > >
> > > 70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
> > > 88 66 ea 51 cc 74 9d 66 52 0f 02 35 54 40 5e 40
> > > 5e 00 44 12 78 22 00 14 7f 5c 02 85 7f 07 9f 00
> > > 2f 00 1f 00 af 04 27 00 02 00 05 00 2b 00 0c 27
> > > 00 28 3b 00 00 27 00 28 2f 00 00 2e 00 06 00 44
> > > 40 5e 40 5e 81 00 1e 72 1a 00 00 03 71 28 3c 00
> > > 00 60 ff 60 ff 3c 00 00 00 00 e3 05 04 00 e6 06
> > > 01 01 60 60 ff 00 00 00 00 00 00 00 00 00 de 90
> > >
> > > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/pane=
l/panel-edp.c
> > > index 9a56e208cbdd..b334926e96ed 100644
> > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > @@ -1947,6 +1947,7 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "N=
T140FHM-N47"),
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "=
Unknown"),
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "=
NT116WHM-N44"),
> > > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cf6, &delay_200_500_e50_p2e=
80, "NV140WUM-N64"),
> >
> > Since this is a "guess" timing without any datasheet, I'd be more
> > comfortable picking the most conservative of the "cousin" timings. Can
> > you re-send with "delay_200_500_e200" instead?
>
> Sure.
>
> Do I understand correctly that more conservative delay_200_500_e200
> will for sure not make it worse, since its more conservative? In that
> case can re-spin right away. Otherwise I would prefer to re-test it
> first, may take a few days as I do not own the hardware so need to
> propagate the change and get some feedback.

Is anything really for sure? No. :-)

...but it's _highly_ likely to not make it worse. Presumably you
tested without ${SUBJECT} patch and things worked OK aside from the
big warning splat in your logs about using the conservative timings.
Those conservative timings basically give you:

desc->delay.enable =3D 200;

...so you probably already tested with an enable timing of 200 and
using 200 here will give you the same conservative number for
"enable", will avoid some other conservative timings, and will avoid
the warning splat.

...and the "p2e80" doesn't do anything useful when enable is 200.


-Doug

