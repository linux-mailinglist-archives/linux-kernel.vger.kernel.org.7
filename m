Return-Path: <linux-kernel+bounces-821045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FBBB803BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A411892606
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD19323400;
	Wed, 17 Sep 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IR7cGS7r"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6831A7E6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120339; cv=none; b=ff06NuSe+CuIr/L2ZANQrqDBU09W0CkSPRqCnhuV4GDp2Z1zcQkLoWeGvTI4oCtulHyTb0xjOXrt3smeh14lB9SRg0srBkRrhf0+76w7gSh26g4dKwXjmGBwjEBmckaebG9h5RuNKBHe0HI9oMe5NgS0wijjeLr7+i0TKeYSviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120339; c=relaxed/simple;
	bh=G4Zd1WyhXg3bKcpAvb10uLtyjHK4cnc7x1qp7ggDnGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txLaRdBffL58fNVKOSAmoZNU8pDbHEib+ikBqfYHyJe/CH2NcCIdVdia3s9kMWlu5JRWMGaFxC+fSiCKCQiSU/nNZEqMOAx1reNv5WlCYHCl9v5bq8vHamUhFE9wEZZ7Kcee+JP9+ZNd4valHhKRI1jhLdmcGHrvXUwtQSlw2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IR7cGS7r; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f330eeb86so5990152a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758120335; x=1758725135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd805cz0CPvWNZKSd9xPGg5rAj3EJ2zME72oqmiIKWU=;
        b=IR7cGS7rhfU7nI19JgUSOj4WNZMhSjsuDAvv8SNOWV3O32aIYhuGktw6/ecEJRyNit
         uCOtq0NxVTOen5es2rDk2XzQ7s6Jhh7Z5wF3/El+GTmVOxjuGSfW+hcVlwJ5nxkl2B2e
         9D8ebV1huHJi+LRpSxOgISXCxnPeQqyrHjlb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120335; x=1758725135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd805cz0CPvWNZKSd9xPGg5rAj3EJ2zME72oqmiIKWU=;
        b=ama8bDFLPsLTHF9qhgdMGegjfeQkSQ3AIVxVM7TNpw04alB6nYPLvlJskjR5fyIzSR
         qlYac9mcz7XH83kj7FLcl5zoi5omnTE4dehd9op2CY9frXKSVOt9Iz2uQHgMN+YnaQjB
         0VRbUp0WJG+g9hGaw9hQ+J2/VmQFEBhsiPR0zge+pNqTs5xMPUXgF7APutM2pSL54lRu
         q34k12sdZXvCUe2w1HWG/QJ48rdv3Pl37Eq7Dhaz5tcV9V77xpK+DrPFtxZsFLFAj8Sv
         Rs4GfPHydX/OVK0Wa10EBldvAPm9VgnI01U0uHtZWXRft1+m5Ys9QUiOW96XJjZ2W5Sp
         iutw==
X-Forwarded-Encrypted: i=1; AJvYcCXrV/fkKhBhbcyeWfLVEtG50sj8s9uMuVyxIHkQM9hyIP7dNpgUMMJg5QyygzT6K5ap+mF5kbDREFABcyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88mrz2tbtijS1e/S8qpDph4vuRrmQpHAC02pb9f1XULB9Yjp2
	GcndtBGdlWgJUZ2IVj1P9oVgik4evvp2FFqFThtJ0UxsCxPMowVAA6h+DzhfYrWwhMhECH9LtZY
	QnTyFOQ==
X-Gm-Gg: ASbGncvOZUlF/oMau9elBrEhvohwzK+JGopNtCdnqZCmYm1Rrk5vAwAdxP5TNMKSnhs
	5xwJy93YPmyPFD8n1ZCJhAY3a8hZh3a/lQHsbYWkXq1beRbWvkm9bHPVUZJPZlyQ29ziABG59GJ
	ThQFeBNO2B9S1IKwtxlfzCRJ+tjeHTX7M1NiE6JeNumNopQTaKpq3liFoXlajRbtxMhUh6rwUFv
	vK9w4ebMzwdzpj0hh756T6fjuihy3SFFfq3dBwg3BbZoC70OBeJkquOkQuOsFBoN91CTxxM7dY6
	4EVXB/p2rLvnug0bWsXlxGY31Ku/hi7ts+Ydc6WczX9s35Hj72w8/+u6skqOYHzS7E93F4j0O8m
	eBunrpN1mw79S/bnRAy4Qkr+3f4Gj59NIYbS5OWDC8XTcL6B2gDAbbNZaCNrFtw==
X-Google-Smtp-Source: AGHT+IHG3090jLQvgg0fzpTvmf8gS5Fvq3NmOmv9Iax8VuVu66nVTg02Gs3jVsGwU2+TsdAN0HnXdQ==
X-Received: by 2002:a17:907:d8b:b0:b0c:d9c2:25eb with SMTP id a640c23a62f3a-b1bb2d108b8mr283753366b.15.1758120334771;
        Wed, 17 Sep 2025 07:45:34 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f35cdsm1357236366b.92.2025.09.17.07.45.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:45:34 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0aaa7ea90fso440824366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:45:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXM6p1K7T0UG5JT7ATLXNWZ/VhEKDddAUFJL60S/3CSig0WpfCpVogK/KYo/Xt8TYQtr1jdjsMDsHhVD4U=@vger.kernel.org
X-Received: by 2002:a17:906:4fca:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b1bb17c9028mr325843366b.12.1758119932480; Wed, 17 Sep 2025
 07:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916142047.3582018-1-ghidoliemanuele@gmail.com>
 <CAD=FV=Uftrv=x6CuG7edLCSAi16Kv=ka7qxPViuLM=BEG8pC3Q@mail.gmail.com> <6e886700-24a8-4127-9324-7245b6cbf6b7@gmail.com>
In-Reply-To: <6e886700-24a8-4127-9324-7245b6cbf6b7@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Sep 2025 07:38:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMT=2UJjtcEk4DDAtFn9KhJ=UX3Vyzabk_shBChbvNuA@mail.gmail.com>
X-Gm-Features: AS18NWCoryMhc5P9VWrIshFnDVMCRDJYhqTFSvF-LnyYKCutmzxh7MsynQqObSo
Message-ID: <CAD=FV=XMT=2UJjtcEk4DDAtFn9KhJ=UX3Vyzabk_shBChbvNuA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Transition to LP mode on
 every video line
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jayesh Choudhary <j-choudhary@ti.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 16, 2025 at 8:28=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> On 16/09/2025 16:45, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 16, 2025 at 7:22=E2=80=AFAM Emanuele Ghidoli
> > <ghidoliemanuele@gmail.com> wrote:
> >>
> >> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >>
> >> The component datasheet recommends, to reduce power consumption,
> >> transitioning to LP mode on every video line.
> >>
> >> Enable the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
> >> flags so that the bridge can enter LP mode during the horizontal front
> >> porch and back porch periods.
> >>
> >> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >> ---
> >> Cc: Douglas Anderson <dianders@chromium.org>
> >> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> >> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >> Cc: Robert Foss <rfoss@kernel.org>
> >> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> >> Cc: Jonas Karlman <jonas@kwiboo.se>
> >> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> Cc: Maxime Ripard <mripard@kernel.org>
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: Jayesh Choudhary <j-choudhary@ti.com>
> >> Cc: <dri-devel@lists.freedesktop.org>
> >> Cc: <linux-kernel@vger.kernel.org>
> >> ---
> >>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > I put this on a sc7180-trogdor based Chromebook and the display no
> > longer comes up. I don't personally know the MIPI side of the spec too
> > well so I have no idea why that would be.
> >
> > -Doug
>
> Hi Doug,
> thanks for the test.
> According to the datasheet, LP is recommended for the front porch and opt=
ional
> for the back porch.
> Could you please run another test by keeping only MIPI_DSI_MODE_VIDEO_NO_=
HFP
> and removing MIPI_DSI_MODE_VIDEO_NO_HBP?
>
> dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HFP;

With just MIPI_DSI_MODE_VIDEO_NO_HFP:
-> Display doesn't work

With just MIPI_DSI_MODE_VIDEO_NO_HBP:
-> Display doesn't work

So if I set _either_ flag (or both) then the display doesn't work (it
just comes up black). If I set neither flag then things are still OK.

...and, if it helps, when the screen isn't working I can still force
the color bars to show up with:

i2cset -f -y 2 0x2d 0x3c 0x10

...so I know that the device has probed OK and the eDP side of things is OK=
.

-Doug

