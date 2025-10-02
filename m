Return-Path: <linux-kernel+bounces-840485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81078BB4877
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467C07B6916
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFF25F994;
	Thu,  2 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrtQrtZo"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF92580E2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422317; cv=none; b=s3VdxDQ+dUH/j2TnR/M6qpCBUNFsLErAyN4ksUF3CODyvnnTlDXrGnvU2ZQSdAKfCOBLhZ3ZXjRwlLp0pWC7P5eCTQDu8dQj1TCTh3e/5kQE2gcB4xQURuxAkkAJIfxiLQdhNDOZUkBIyqm08UcBsxBLL95qlokHEnXQZ8z1cVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422317; c=relaxed/simple;
	bh=Dye5xG6ZBlkFS8UnTaxhmHjl4qw3h7OPv8XQMDNn3/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abEjTLOwBLMCUy3WaIPGIUOYjj9sBVgrLOCsVyiENGfF1ZlDPKrDMF6+J+S9A6a+MLjcdwPAfR9rAbhHX6DE3LBQcw395l2JdtAh3SxCppxnaIj1amdMQTzA9gnSNbwvJyqPgkWsQJvml17oGfhEq35xuOWXxCqUbQRy80Q1igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrtQrtZo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7841da939deso1233429b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422315; x=1760027115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b4jK+m/8RWobuO0NphPEVc1dDtXHYNNnhWnKlc2Ffk=;
        b=KrtQrtZopp5TgSs97FnKYffUrlLK6trfIlDj0zUSiMIJPEZsCWGvMQ8OW+DrWurZvs
         tZi+BNnHABWOH6hDccKKsu12U2aOGhLKfb3Dbnmu0X1A5TNxUvbLBpVisK6XyQHra5ol
         uQq55jk3YMhADvoQBmj6FfYyHWGfkXyisOgwn+1NVw1PCQ7y2X7QMHJ8mB3CcQSd8Gc6
         6SZ/B+JIcoWemc/N31qDc43UR7Vz9gDOkzCSBkwww0vTyG3D/1IyF/URvKplNMUOBVVm
         LDoH0BkfomkaxSf2CGti5uE6/Kvof4diFiDPz2F8arWZNqXjUp00sEW0fWPQpbPDJJfR
         8Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422315; x=1760027115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b4jK+m/8RWobuO0NphPEVc1dDtXHYNNnhWnKlc2Ffk=;
        b=IyW7QVUO0tfN7ggciq2ns4KyPWlU1A02FvVdumvsln/zZHUze5iPFAGme22YaMH6Df
         S4aDs2B5AHo6VtK+lK272Efo7TxujYryTjpZUoQz3YDAsZS3SeFf3HWm5aD8k/UU9bm+
         WrVam1g+pFLVISGGRDnZecpaVhe9yNqlxfRTulv/O0UyHwroUu1a/gIqQD7mOQ5PLZF5
         ZCjeqWnRQMUYlxRsu2a2vj5TCCgLIBhdweA/33yjgoSgcirHd7mg4Hn4POwNTRlWd3yI
         Ku8PY/hOlLTqRBGJm0WJ1TWW9oQBr8Eyq6xZOFdxQ4ETQW8gzcY4Ny6fI6VNc90pUydz
         lRpw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ELYUUtAww+h8w1GyqJu9SFqrwoM6FpuXFdge33fsMU9pY/JrNW1cE49Wr6U83N2e0eOkr6B7WaKqqFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMVKBofM7oB+Ms4NHo9XLXSyLwCl9vVDF/70NJyZ8uZpS7iHG
	rz8zJwKKsXywr0yuZxz/3yoLdG88ZBhFKFt6PsML/I/HurgRBAyTJjjzEnlCqulXQTUUryftmGv
	fUtX7V6LHn3jx42P2dBN6PL9RmRz0syI=
X-Gm-Gg: ASbGncvgBmDVV6H3a4V/WDE5ly6uYNiplodjDsOHpYMFhlrFMEfDlO4oghV2tRH0xyY
	aFmUdnkQgsxei0DF5mPlu/Kor+ak3/+Wll3wwIMrzyrXLzbhgVauFN0dj+Lpb0f4AhvsHTT8UQr
	0lJU6YQreO46LBeXZP2c9AAhWYPoW7F9X+aIARLpVf4uA0HR3jQ+w6uuLNRo5VKNSj8lubi2Kd0
	5n4HgWWUj/nPYX1b8jZyxjUKMH1tPw=
X-Google-Smtp-Source: AGHT+IHE/zk/UTkg8cQuQgjzmknU1P4NQ77O2Frb3S1sd6aKc/XPDhOrrz+zfZ4f19CBYGkA2+apVfUO9bhD8Hpgsxo=
X-Received: by 2002:a17:90b:4d08:b0:335:2b86:f319 with SMTP id
 98e67ed59e1d1-339a6f76fdcmr9571286a91.35.1759422315195; Thu, 02 Oct 2025
 09:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-imx8_isi-v1-1-e9cfe994c435@gocontroll.com>
 <20250820140154.GB6190@pendragon.ideasonboard.com> <a9283349-c58d-47e6-ac33-77b5a6b893fe@gocontroll.com>
 <20250820141439.GA10547@pendragon.ideasonboard.com>
In-Reply-To: <20250820141439.GA10547@pendragon.ideasonboard.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:30:12 -0400
X-Gm-Features: AS18NWDGHOBDrSguIYms66P-zFEY8uoL7wGfB2jgVSBuHpouvKYa_JLzhedGeUA
Message-ID: <CALC8CXf2RTYz2YjbFHsbdjDSSAt3Jdv1NBbBQs4jRPmwkuUuXA@mail.gmail.com>
Subject: Re: [PATCH] media: nxp: imx8-isi: Check whether pad is non-NULL
 before access
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maud Spierings <maudspierings@gocontroll.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Stefan Riedmueller <s.riedmueller@phytec.de>, 
	Jacopo Mondi <jacopo@jmondi.org>, Christian Hemp <c.hemp@phytec.de>, Guoniu Zhou <guoniu.zhou@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maud... Laurent
Yea you a Mad Lad.

On Wed, Aug 20, 2025 at 10:19=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Aug 20, 2025 at 04:07:55PM +0200, Maud Spierings wrote:
> > On 8/20/25 16:01, Laurent Pinchart wrote:
> > > On Mon, Aug 18, 2025 at 02:31:43PM +0200, Maud Spierings via B4 Relay=
 wrote:
> > >> From: Maud Spierings <maudspierings@gocontroll.com>
> > >>
> > >> media_pad_remote_pad_first() can return NULL if no valid link is fou=
nd.
> > >> Check for this possibility before dereferencing it in the next line.
> > >>
> > >> Reported/investigated in [1]:
> > >>
> > >> Link: https://lore.kernel.org/all/1536a61b-b405-4762-9fb4-7e257f95e4=
9e@gocontroll.com/ [1]
> > >> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> > >> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> > >> ---
> > >> I'm not sure if this should be a dev_dbg(), just following the patte=
rn
> > >> around it for now, also not sure if EPIPE is the correct error.
> > >
> > > I've submitted
> > > https://lore.kernel.org/linux-media/20250820140021.8026-1-laurent.pin=
chart@ideasonboard.com,
> > > which should fix this issue in a more generic way.
> >
> > Saw it, but I think my patch technically is still correct as the
> > function documentation states it can potentially return NULL right? [1]
>
> The function documentation states
>
> "returns a pointer to the pad at the remote end of the first found
> enabled link, or NULL if no enabled link has been found."
>
> The MUST_CONNECT flag ensures that there is an enabled link, so the
> function can't return NULL.
>
> > Link:
> > https://www.kernel.org/doc/html/latest/driver-api/media/mc-core.html [1=
]
> >
> > I will test you patches tomorrow.
> >
> > >> ---
> > >>   drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 7 ++++++=
+
> > >>   1 file changed, 7 insertions(+)
> > >>
> > >> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c=
 b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> > >> index ede6cc74c0234049fa225ad82aaddaad64aa53d7..1ed8b031178b7d934b04=
a8752747f556bd1fc5a9 100644
> > >> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> > >> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
> > >> @@ -160,6 +160,13 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_c=
rossbar *xbar,
> > >>    }
> > >>
> > >>    pad =3D media_pad_remote_pad_first(&xbar->pads[sink_pad]);
> > >> +
> > >> +  if (pad =3D=3D NULL) {
> > >> +          dev_dbg(xbar->isi->dev, "no valid link found to pad %u\n"=
,
> > >> +                  sink_pad);
> > >> +          return ERR_PTR(-EPIPE);
> > >> +  }
> > >> +
> > >>    sd =3D media_entity_to_v4l2_subdev(pad->entity);
> > >>    if (!sd) {
> > >>            dev_dbg(xbar->isi->dev,
> > >>
> > >> ---
> > >> base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> > >> change-id: 20250818-imx8_isi-954898628bb6
>
> --
> Regards,
>
> Laurent Pinchart
>

