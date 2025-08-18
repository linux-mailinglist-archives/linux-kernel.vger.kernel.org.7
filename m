Return-Path: <linux-kernel+bounces-772861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628BB2989B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E23AE291
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D3262FD7;
	Mon, 18 Aug 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eM6+EA3G"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A714262FF8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492155; cv=none; b=BD9JQChSNFXxnbXQ7a8Ns2lZJCOoQlGrBDYCtPWnAU6z8sT+Wb7IwAqg/O6msKq/mgguJW8iCWyedsUx61v70Eee4Lda/SU1CGWzxv+J1D6QoFtZ7g4ym/rjLAYvDuFWuskHJvhs4rooUnWnpCpveRPTM4LIrJxIrOINmlAVYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492155; c=relaxed/simple;
	bh=BfsQWtM9zlBkMaLNEqnp5wSBhlrCP40LK6Q9xsKtZy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt79Zdc1kuvIvcapkAeyYZ8U8YE3d9rocIgmeGqx9dkcH+7PsbnL+O0rnBSrY1I0HuSRRTs2yb0V/7P07edqn/WFla+151oHLcY317ANZ+DGgxptZe4I/Ja/cfAcKlVbF+zvuwIpZ0w+NqcdoWVC0htdoACAHOTBnA55Nxi07RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eM6+EA3G; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74382027898so1907309a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755492152; x=1756096952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfsQWtM9zlBkMaLNEqnp5wSBhlrCP40LK6Q9xsKtZy4=;
        b=eM6+EA3GjhCDVyMB0bzaOLX1gaEt2ylNOthcb5n0LwHg3eYHGimPSfkBkhXjBLQNlY
         bzaxcfDpzzJt3iBIcZOtD7AATu0aTd0hTQl3edZ65enHk0pZn34D32FP9J3U0i7HFAkv
         EnwmACTMVwN5Xi2QN+GdtSVFZhkwuBzKaDhaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755492152; x=1756096952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfsQWtM9zlBkMaLNEqnp5wSBhlrCP40LK6Q9xsKtZy4=;
        b=nXJy3VNNVeHx7sWR2dqk22R79zcIvP+63VMorvAcsNqk5Ib0S3hK/Iza8HNsJPqBEd
         8qWddMA8s8MGPL1bk80e8PWQs0yQbgMBUzsKT53lbW0U40kcK/7I3tpiWINWQ+5Zpxld
         9G1pctszyryV4aU/FpJ09fiJplzvyyLtiJuy4/l2Em/OjzBnfmM5iNyFkvIev9B7l8gX
         9p77qvEYHB58jfK10aKcjnyDB0taaG6kByZ+JQBpWX2IxXkZFQTJPv6HuMnEStC/vx24
         WCLudUMazp1Yl8n5ICDypRP7VXk0MNElT4OSi8n605XrwGWNy1TH7YaZ/gJZyEEEnEcC
         kpOw==
X-Forwarded-Encrypted: i=1; AJvYcCXvj3Cb61Re2bqW5h/pVoNMBjp2vD7Kdf2askZqzG5K3xig8rwJHxLMbPkre56ZF8+lzc3IlJiPX88c3Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg48cgz9rFUAiBkVZGT4wm9RKF1sRNOi2tkTOTOL5HyEkqgkvp
	hudyRn13s1q4jPmc3VIAwFDIIeJDCk4UYqyiyJV3SJf80/ptEGBL14j7vO6s0IS5hxkQch/0mdW
	XM2Wmxh3z1z7SFjNOeYLc3N3miUUKt3lL/rxW15nvj5TXy2kTRAE=
X-Gm-Gg: ASbGncu5/agc5YkjsM8FflMUaB6FgL/8Q+ZQf6Qv3YwapqMf585e3cq2fFoimJFNQvV
	y1IqH4+RO2uZxlMGvcswStvChNZfh4kOjwQh1uv2Bul2OaRZNtJeMxlBUlDCfPrpqH0bfQ8PyGz
	bcV6D5rwyyIJszWgZH77yGiTKmXMrVvG6Pg6kT6fk9MWZqukXbtnEpxLdshSU9U+oa1s+jrnHqr
	pApkbeCq0k0WyPlf0usX53BFAGieQESJYk=
X-Google-Smtp-Source: AGHT+IF/RhLz2fIw1VbTnK6kOfNHtaBYI/Gt5l9e8XL0REmA8tvh4RTpWjRQOCaWMMFqwIexvepYVZNLyvLCWG85f6w=
X-Received: by 2002:a05:6830:3148:b0:727:3439:5bdf with SMTP id
 46e09a7af769-7439bab7241mr4262682a34.13.1755492152672; Sun, 17 Aug 2025
 21:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8a64686-f1a2-44f1-9d13-fd5b4f923e0f@molgen.mpg.de> <CAAOTY_8vLqU30L3+ijYJPLrioRsUwVwJAeumtVYfRJ9e5tjp4A@mail.gmail.com>
In-Reply-To: <CAAOTY_8vLqU30L3+ijYJPLrioRsUwVwJAeumtVYfRJ9e5tjp4A@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Mon, 18 Aug 2025 12:42:21 +0800
X-Gm-Features: Ac12FXz5rMxf27QySQIDZc7iDa9NZ942iMQjso7rsmfG9duoC6kvEJjFLzERuyU
Message-ID: <CAEXTbpd=-mB-n1EVb4Y7RDxkJ86b-HrFWyErgTE_FYoViZRdpw@mail.gmail.com>
Subject: Re: MT8183: Only maximum resolution 1280x720?
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi CK and Paul,

On Mon, Aug 18, 2025 at 12:39=E2=80=AFPM Chun-Kuang Hu <chunkuang.hu@kernel=
.org> wrote:
>
> Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2025=E5=B9=B45=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=882:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Dear Linux folks,
> >
> >
> > On the older MT8183 device Lenovo IdeaPad Duet Chromebook, running
> > ChromeOS with their Linux 5.10.x, connecting a 1920x1080 Dell monitor t=
o
> > a USB-C adapter using HDMI, only the resolution of 1280x720 is
> > configured, although the adapter also support 1920x1080. It happens wit=
h
> > all adapters, for example, LMP USB-C mini Dock [1].
> >
> > I reported it to the Chromium OS issue tracker [1], and the last commen=
t is:
> >
> > > It seems the display pipeline for the internal display (DSI) has
> > > higher clock rate. Also, the resolution support depends on the
> > > refresh rate as well, so the claimed 2400x1080 might only work on
> > > lower refresh rate.
> > >
> > > For the external display, the display modes are mostly rejected by
> > > the pre-defined max_clock_khz in mtk_dpi.c:
> > > https://elixir.bootlin.com/linux/v6.11.4/source/drivers/gpu/drm/media=
tek/mtk_dpi.c#L940
> >
> > Can you confirm this? The font rendering seems not so good in the lower
> > resolution, and strangely, playing movies these seem to be rendered in
> > higher resolution (or the monitor or hardware does a good job in
> > up-scaling).
>
> 8183 max_clock_khz is defined in patch [3] by Rex, but this is a
> prepare patch for mt8192 [4].
> I'm not sure that Rex has test it for mt8183.
> Maybe you could try to enlarge 8183 max_clock_khz and see.

I found the internal discussion about this (back in 2018), and the
owner had confirmed MT8183 DPI only supports up to 100Mhz. They also
clearly stated that 1080p@60 is not supported by MT8183.
>
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/drivers/gpu/drm/mediatek/mtk_dpi.c?h=3Dv6.17-rc1&id=3D44b07120291c4b7a=
6722ccb7149f6b9d938cf5a2
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/drivers/gpu/drm/mediatek/mtk_dpi.c?h=3Dv6.17-rc1&id=3D38eaef2dca4ec8df=
b9ea84d9dde0f76da5c8caaa
>
> Regards,
> CK
>
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > [1]: https://lmp-adapter.com/product/lmp-usb-c-mini-dock/
> > [2]: https://issuetracker.google.com/issues/295666708

Regards,
Pin-yen

