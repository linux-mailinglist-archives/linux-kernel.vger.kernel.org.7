Return-Path: <linux-kernel+bounces-742028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E371B0EC20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AFC3AC726
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734D27702F;
	Wed, 23 Jul 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X49dDmRL"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352C191493;
	Wed, 23 Jul 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256467; cv=none; b=K4WBbvuShgEimNKx0bZNY3isSm1HEKUBrQRqn19YMZikWlbICU3fMoTpybEKHsUJbSKVv8peu8BobXIu56j+fHRLs0MnrI6NnKfGNjXBvjmlfrBP64AHeVJxyQUii5zs5NFaCDkiRAL245xEm1ZrcNMlIe6lUPEsQC6Eaw/vVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256467; c=relaxed/simple;
	bh=KfP1ywzLLeyAW58cpJqwY6sGIJRR7/qC8x/PsTBeZe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q92Xx7fk7MAouWBrvCO3yIlznIWLTwc+yUSLB6MYSchtbnfn1eiedO3HCILdkVlccNKxHpHdrgcwpDhcxnqCkgl/dtmhRGQTqC96W+FP0qDmNugVyQo9oBwiYMRk1LhLQUxMQmKNo4u25eGqvGWQ+FcohA6067noZFkLr1OjDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X49dDmRL; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e292dcc066so48715735ab.1;
        Wed, 23 Jul 2025 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753256466; x=1753861266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81Y9fywoqF7EeyNEvfPWdoet0imEzVFFJD69wE8Ijuo=;
        b=X49dDmRLMduqnHJ8Pzj4hzns46F4bnezpdotUOV1hLBzyf7V4940cuv6aZ/sGxeb4B
         UXsqYnwOmzEngMXbgm1AZgq/5kWHeY2hT5MAydOVOoq8ozwIKRB2MAHUkFgbIWVL0nqg
         4uFZH1mxrlbRYGP/bUdWFDkYFcpGpIDoypJTQU7Ojn18obiQdP/DpVNJBGpLUQZ0ev0J
         g9u1O7bRaOP8PB571ES1K1E+XYd46r3cS83/+P5NRm4Wfh/V9Utm6RUOxnWFvwIIvmyB
         58Cf1+epLxwshguJFCu3ryIRC3ICE3jusShnx8knVkVf2C3iZ95DCpAgqZU/fWwqW5q2
         8mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753256466; x=1753861266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81Y9fywoqF7EeyNEvfPWdoet0imEzVFFJD69wE8Ijuo=;
        b=GbLf2r3m1IzN+HHKI5jALNKYZbaTBIsquObrawnq1eldP6qptqq+nuy+JZB4DTEpsr
         i4cNfLxL4xD7BFWHVKcN8LXQ8od3/K3Jml2XoUHZXloyheqX0OXi0Ry1BCBjBqGagpWt
         RJ2mb+JgPq8wp7dkkqm3/JWiF5jbie4DwX65s/VaNotis5wHdNDiU3NEJx7z5n31j1V2
         E1q/oRViNztyFRdHUCLSAuy8hOouRszlMAL5Bfv8RUhtX/RcYAkq5W5ViMznMaPSgGdJ
         +bKCMO/at1+VZZ6iR5Dv4CQ5G87+dhEuv42jvZpceVoKO5yQVvbLwlWw5nBaNuISIkQ3
         Demw==
X-Forwarded-Encrypted: i=1; AJvYcCVhOMNgq8lyJAlNo4UALAtM6YNr9MpasQ9OX5hTswEGLXdmKJdeQlJ6H2pbvUcM4touBFbBHpNfAxVk@vger.kernel.org, AJvYcCVninq6Hx4lIdzoXeGixnJvgq3m+hajmeCMHb2irTnb7f4+wRYvgmwBpcUE0ccEopOGMjTHEVsntArSWuwP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xkGu6SkIyp2HK0UxnI34IB9IqPO8XAMNntjTDAO/a0NTRS9V
	7+N7bh6TC0GLQzmmO5rWR5V3D/L2ZKf3M+sxdg1lheNgYcJ3TDLfcA8ow/T6EjXOk/wAykz4qB0
	wa28ZQhZQHdUzUi9xxpkzmBFE1rnLuP8=
X-Gm-Gg: ASbGncvy6RZYNwVJxSmU6F61xJttSa5jNLF5tWZVWseFbnkILW+hQTWtEy3Iq3Bpb90
	cWMlhPSe8PQi3a9lVvWbfSz5Jj41+VPWCePraJl317f3wtAkpquFGSHY9YinHG1CmBTCC2ydTGS
	hGLEwmrT5pvwq85LfTyYK61vseaW7Gcb3MKv0XhWFa3yQcc9h5riw/MuR2RYWu8USB0x5v9tekn
	mv0IPg=
X-Google-Smtp-Source: AGHT+IFxfL3iPUA5T5lDVBBDYyqD7VIFaDA3fQJ5O2oa4O2dCluRKQiYM4kl1jFwdLxNmmpTIZDHo7HQtauQmGufUFM=
X-Received: by 2002:a05:6e02:2384:b0:3e2:c212:6164 with SMTP id
 e9e14a558f8ab-3e3354dfeb9mr37438145ab.12.1753256465669; Wed, 23 Jul 2025
 00:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718101150.3681002-1-shengjiu.wang@nxp.com>
 <20250718101150.3681002-3-shengjiu.wang@nxp.com> <4668607.LvFx2qVVIh@steina-w>
 <CAA+D8ANQdOuEiHrOWAbqVN2oFAAop2agBzKB2_YsoQ3_SFYYNw@mail.gmail.com> <85f1b9f3-0134-4385-9ac6-f3c6c2eb546f@nxp.com>
In-Reply-To: <85f1b9f3-0134-4385-9ac6-f3c6c2eb546f@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 23 Jul 2025 15:40:52 +0800
X-Gm-Features: Ac12FXwt3CFjI2gmqrSV6-EQJlh4rFyR_XU_vqi0YUQRGTQLoRTFr6d47NZAQO4
Message-ID: <CAA+D8AN6HSTwByHvqfkLnZ=UFPo8W48N5oRf2CtF6pXdCwSXag@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge: imx: add driver for HDMI TX Parallel
 Audio Interface
To: Liu Ying <victor.liu@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 3:50=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> Hi Shengjiu,
>
> On 07/21/2025, Shengjiu Wang wrote:
> > On Fri, Jul 18, 2025 at 7:51=E2=80=AFPM Alexander Stein
> > <alexander.stein@ew.tq-group.com> wrote:
>
> [...]
>
> >> Am Freitag, 18. Juli 2025, 12:11:48 CEST schrieb Shengjiu Wang:
>
> [...]
>
> >>> +     /* IEC60958 format */
> >>> +     val =3D 31 << FIELD_CTRL_P_SEL_SHIFT;
> >>> +     val |=3D 30 << FIELD_CTRL_C_SEL_SHIFT;
> >>> +     val |=3D 29 << FIELD_CTRL_U_SEL_SHIFT;
> >>> +     val |=3D 28 << FIELD_CTRL_V_SEL_SHIFT;
> >>> +     val |=3D 4 << FIELD_CTRL_D_SEL_SHIFT;
> >>> +     val |=3D 0 << FIELD_CTRL_PRE_SEL_SHIFT;
>
> [...]
>
> >> But where do these numbers come from? I can see that downstream kernel
> >> sets these bits depending on audio config being passed.
> >
> > These numbers are defined in standard IEC958 spec.
>
> Can these be defined by macros, even in a certain common header file,
> include/sound/asoundef.h?

yes, then will include ALSA maintainer for the change.

>
> --
> Regards,
> Liu Ying

