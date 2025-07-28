Return-Path: <linux-kernel+bounces-747506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB505B1349C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0661897D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890722068F;
	Mon, 28 Jul 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSWzq1Cl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912619F40A;
	Mon, 28 Jul 2025 06:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682726; cv=none; b=aow5OSYgC1i9FtrdHwtK0lHQDKAQSKnxdKb7YErxQqsDDAr4a8r61ha4mE3+G1jTMdaQpbFSIeS9KWtS0w9cdBE262OpG4BaCTdytbLlFjSLnVFhucl6ApOdaAP8m96f72xApnec7bgLtyHSvoTqj0jesN5sFR5f/QpZ6tYUZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682726; c=relaxed/simple;
	bh=6Bl6t0D6Smny3lA5QBgsKsojEFjKp+6fv2oc5TrWVks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYaqHBlakJ537kCFGP0XLxjC3vhp4pby/8As5gqBt5MrSqoxiTNVratBNzq18g3RUa/XdiFWMbejno7QLsmqZIhyT4YXnNie2Esyd7apyPZOTKJuoENLOin0Za4dQD7IRgHUT6Ix2C1+BCu4D8XGoiS3lUMoq46VxA15PxG8nH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSWzq1Cl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b002833bso14808365e9.0;
        Sun, 27 Jul 2025 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682723; x=1754287523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQXF3uhUpKed79enyV2WSAsZRiLGa5m0jySlxIYlh2M=;
        b=DSWzq1CleEFv7S9StERg8eDGdowO1+E/XBHrdbfDRiRlSrVYCgPEjI+xl9Hd+0JQpo
         pIwjBB6oQ4JdIIGRqydArTlbrVAgqA6fho/Lfw8gY5NV3/VbNmKHZj1dQADBKU6bFInb
         nZXtTl51k0zeyZOsV7VL3hxxDB5OMPHztlAqsrFDM4nAocYmPAOn5ws34haGzUsI3wsc
         47iZryxQOCdVB+iv3xj3US0Y/PesEWgfxLPKMTjcXwYcEnImfa+uNmEdS9q2M9l31rSL
         jeraQyHovJJf5uKCBaCtNyeTyWAPEfskl71IufT6qqo/ktg8JxccNmn37lbhZNO4Bp5S
         UflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682723; x=1754287523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQXF3uhUpKed79enyV2WSAsZRiLGa5m0jySlxIYlh2M=;
        b=huxX6k/gZoy80TOLDuCX7sJtqgs6hBDWuk8P7XkJt+6kX2mZBYiESexCdEvWFH/v0x
         3+lBClNzg7P+IvqvtGxWQ+qBPIy2ltqoukoSNmNeNWD/u0LmmnksE7jRZ70XyeUL9bqY
         yQvQDY7cuz0ywGVxfO0aPM7+GtL8EQiocOG0It0PeZLrL8DdqOdabuTjvEA4bHNDZgNP
         k6NCb/rQoVORPALVecS1fb28QZoKHRmsPh9lqQhNJ0Z3a8XMOgX+cdSvQ63L16kH9wVc
         uMLHP14c3DR7yUFP7WYbnGOR86M5UV/ov1qJAZQqDdAwXlWQhOcqDbNnp8a83Yf34LfV
         nrlw==
X-Forwarded-Encrypted: i=1; AJvYcCU8rxWVLFOXtBQ1eRihbTILyUSkSoViXn6jFx5PiDGoxo1WIAuxQNueAU68Cnuz6Eb5j7mpg3moHUFF@vger.kernel.org, AJvYcCWuoqCb21eHl33Ez+07xKoiVXOQ7bouW5gmXdAakGRAKO8wnipyatd8LzZHn6kE6DDT7D582fXyWK0SGQYl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZbMsbbDw7vOqBHi1HYB7LC4bnu5mobrvfdDD7KuCfe+mrvWM
	byB7NyoDuT/o+7tKPjJzK8Qq5lHKtJDODUx+hJUZMQf0BKm7/UZw1CrKABX4iu9yJV7njYdwpZF
	9n3ZLQcgu74x8oPotaiqNtYwEqDZH3ZE=
X-Gm-Gg: ASbGncvb6EsKzAFku7QAbONA8pi7maft5e+FzDDofGChiPpD4TbyjsT/UH9GiqSmwTY
	HfisRMM8KaU8MVKWDAoKpNfvcldukomztWr/wun7BbcUVacGlDV+oKW62RpR3D+1G/IL8ZKOHpV
	xTfPquALnqR5E2QyEgX5tR5zJTzw5eTusenDPUZS8yRAJwnz29BPAWIycDsi72KzE8y9cxBcdUN
	8d9fCBr
X-Google-Smtp-Source: AGHT+IGbQly/khf35EnzlRO7ObYBo3BJlziBpv1lPzLbWO+xhKZeTjbakTyAb7qcQM/u3YZ/g+3x0BcnqrQrhaC7WKs=
X-Received: by 2002:a05:600c:6748:b0:456:eab:633e with SMTP id
 5b1f17b1804b1-4587dd0db72mr59731935e9.17.1753682722442; Sun, 27 Jul 2025
 23:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623081504.58622-1-clamor95@gmail.com> <CAPVz0n38N32HobYshtS9cLBJqWGPA1MZjMr0HH3C4UqGcFaFVA@mail.gmail.com>
In-Reply-To: <CAPVz0n38N32HobYshtS9cLBJqWGPA1MZjMr0HH3C4UqGcFaFVA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 28 Jul 2025 09:05:11 +0300
X-Gm-Features: Ac12FXx4CN1mT0Dh6FdAxwgNHcr1BsYAY3RYhstMmFIeWt6bQ2yxBdsgzEZ5FqU
Message-ID: <CAPVz0n0nwnVyVP2V4Oswhhrz=gwMpv_-f2xJfBO2N44GRNjaKQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 19:38 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D0=BD, 23 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 11=
:15 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P880
> > and LG Optimus Vu P895
> >
> > ---
> > Changes on switching from v6 to v7:
> > - removed enabled checks
> > - configuration complete quirk moved from host_transfer to
> >   atomic_enable
> > - switched to devm_drm_bridge_alloc
> > - removed redundant dev_set_drvdata use
> >
> > Changes on switching from v5 to v6:
> > - set correct module name in Kconfig help
> > - return error if spi sync failed for reading
> >
> > Changes on switching from v4 to v5:
> > - rebased on top of drm-misc-next with adjustments to fit
> >
> > Changes on switching from v3 to v4:
> > - no changes, resend
> >
> > Changes on switching from v2 to v3:
> > - added mutex guard
> > - configuration register flags parametrized using panel flags
> > - removed unneded debug messages
> > - removed unimplemented modes checks
> > - added check for maximum pixel row length
> > - use types header
> > - remove ssd2825_to_ns
> > - shift bridge setup into atomic pre-enable
> > - cleaned default values of hzd and hpd
> >
> > Changes on switching from v1 to v2:
> > - added description for clock
> > - removed clock-names
> > - added boundries for hs-zero-delay-ns and hs-prep-delay-ns
> > - added mutex lock for host transfers
> > - converted to atomic ops
> > - get drm_display_mode mode with atomic helpers
> > - parameterized INTERFACE_CTRL_REG_6 configuration
> > - added video mode validation and fixup
> > - removed clock name
> > - switched to devm_regulator_bulk_get_const
> > - added default timings
> > ---
> >
> > Svyatoslav Ryhel (2):
> >   dt-bindings: display: bridge: Document Solomon SSD2825
> >   drm: bridge: Add support for Solomon SSD2825 RGB/DSI bridge
> >
> >  .../display/bridge/solomon,ssd2825.yaml       | 141 ++++
> >  drivers/gpu/drm/bridge/Kconfig                |  13 +
> >  drivers/gpu/drm/bridge/Makefile               |   1 +
> >  drivers/gpu/drm/bridge/ssd2825.c              | 775 ++++++++++++++++++
> >  4 files changed, 930 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/so=
lomon,ssd2825.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> >
> > --
> > 2.48.1
> >
>
> Greetings!
>
> These patches had no activity/feedback from maintainers for almost a
> month, so, in case they got lost in the depths of email box, this is a
> friendly reminder that they are still relevant and I would like them
> to move on.
>
> Best regards,
> Svyatoslav R.

Hello there!

This is a friendly reminder that they are still relevant and I would
like them to move on. Should I resent them?

Best regards,
Svyatoslav R.

