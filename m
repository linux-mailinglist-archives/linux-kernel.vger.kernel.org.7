Return-Path: <linux-kernel+bounces-768408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E67B260CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F199316CB79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037D2EA142;
	Thu, 14 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i3rnlNuF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988962E7BB7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163409; cv=none; b=aq4xUOBLnDGk2msSMr5jdvUL+2/UzFEp9Vhx9pPf6fe7mhfSUS23AqxPvIWcGkZ4GN/hmSA9Nrk0YY3N0j1X6j7BzAEFHt5bIGD5VM1lQ7or7ftdUCzgcaAzOpFvWinBl2CxdPSOhkAW8WT55Rv3kom9Pv9lrUOuSYQ/ZJIyNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163409; c=relaxed/simple;
	bh=1p31ORQ0LGAdIkX4tlRR4sW7uMHgmXUc2XnTrS78Yfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSebDKAfxYxOQEfedZO8Sncn96bk0YICYnk6Ymue5qxQ2iWtrv37q1vu6uKSFUU7XHEIb62JmLdw0okkwvpyUeeTb5Q+XsnVBKk9lFwRp63KpnjUkrI/Dqsu3/XV2vXTfYGXl5xRpiY0SLNIzxMli/CSYtYmQhd/GCagjQxUdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i3rnlNuF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce5268cb8so664011e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755163406; x=1755768206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpEu3YjSYoh7r4VO0s5m1PdSv0aUP+n6hdz3pBdusjA=;
        b=i3rnlNuFoF5iWgIiZYlsHJPEzg+eLsWgp5Q4XZ4Ahw2EuaIca1VwE44t5Pg86lzDq6
         C2w40v/WB5sQfExBCHYih1xeuRR3Q1eLtCCwMzHkggAJsLiGzwfkAFwzJ7ln96WBIOj4
         CCEZoq8QdJlzbbPq8xnoocC01cyVrlLZ60jJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163406; x=1755768206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpEu3YjSYoh7r4VO0s5m1PdSv0aUP+n6hdz3pBdusjA=;
        b=IWgUcPU2yXlt7vIaE7APBdSyobMCy8Oyw2AVHB4v/hSs78WuUzF72L9bmXrgwU1Ucy
         KNwQvzWeh/rgl0ZqkqAsun+2EWG7rdB8xMtjwHP+iHibcUlvZy20mfP9jwrW7TiuKm61
         IvGpi87th1XY+zoRqYd/pGhCfnGtNG+UbWkSuUCNIXM4x/eWn8NgxIK28MpE5tDhr6dP
         GRk4BFAT6/GbQKenGBYiUqARo1R5Z4qst5akcs9+CoyBHya9qQlZFWeuyPRXHqy4s5e7
         EMHvM+eT1nN2ktTPc/VcMRFTM48/g2dWY0D+ioDyjear0u5WCPJlkrv/mG9kGIRBhMgP
         6wKw==
X-Forwarded-Encrypted: i=1; AJvYcCXVOix6tn071OuIP8ZpfJnIphB3fyVC8I/sO9Ah3mMtGjwwn3EWpa14cKWVIACX6HiQVaZFHZ6zOeIRaAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1k1CEMkKz3lbDKThGZinHhXjnAH+oUHWALahTG66m5rmrgFZD
	vEgc15Noqf2vcspn8n/woNUIzJujo6nuYZEa5BxyDOWq3Wx4gJ4PBGrPfBM4TRTPxhXVZNtpr+j
	OYsXmCjE24GJfpUEwAPtQOCvWtz39oNHdCWr1u3Cb
X-Gm-Gg: ASbGncub6krXxm163hKfsHKOsXiHZhtn1kKRd8IHGUTYeN5LUcsL/ZdFO5/FRID3vid
	hWXpjB4oTHMIFYH97RnCE3NQh15USH2hJ8G6bfcfG9IJ/9xAb4aRMq9uLOBt0lNx7XpcELq59bo
	2CvIcaJ5MhJLOZlrJ8G+nuQiJ0fasfctPAK/pIBpzgTa0iMPYh/zfCjseMr08YbP5MGZAticQo0
	ayeLpXbyV9dYRl8uSWTDNmq/syJ5cSq1Ak=
X-Google-Smtp-Source: AGHT+IGpKciwODEZc1IhhzYqeOLMaszqjmQ++VhTEo22Iom9UGzpsRrcz90fbohkGI5byeGYbxmvyFlt9Y3WLL1B2b0=
X-Received: by 2002:a05:6512:6d3:b0:55b:8f02:c9e1 with SMTP id
 2adb3069b0e04-55ce50739efmr676632e87.27.1755163405566; Thu, 14 Aug 2025
 02:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812085902.3309160-1-wenst@chromium.org> <CAC=S1nhG_ExACJRpJoqmO7nn+P24uiaha21SFEyR3aoKL-Pjgw@mail.gmail.com>
In-Reply-To: <CAC=S1nhG_ExACJRpJoqmO7nn+P24uiaha21SFEyR3aoKL-Pjgw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 17:23:14 +0800
X-Gm-Features: Ac12FXxQGyeanDOqLQ_pP2in2SjWgkqtc8UcLGeK7yro90D1xizR-yjtyHCuvWc
Message-ID: <CAGXv+5FF5ZfOVP1qQh7s0sw9z4SXY6Rh8kS+8HcTxNY1gQ_kJg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
To: Fei Shao <fshao@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:03=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Tue, Aug 12, 2025 at 8:39=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > The first SCP core is used to drive the video decoder and encoders.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8188-geralt.dtsi
> > index c5254ae0bb99..10764786bc21 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> > @@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
> >                 #size-cells =3D <2>;
> >                 ranges;
> >
> > +               scp_mem_reserved: memory@50000000 {
> > +                       compatible =3D "shared-dma-pool";
> > +                       reg =3D <0 0x50000000 0 0x800000>;
> > +                       no-map;
> > +               };
> > +
> >                 apu_mem: memory@55000000 {
> >                         compatible =3D "shared-dma-pool";
> >                         reg =3D <0 0x55000000 0 0x1400000>;
> > @@ -1146,6 +1152,16 @@ &postmask0_out {
> >         remote-endpoint =3D <&dither0_in>;
> >  };
> >
> > +&scp_cluster {
> > +       status =3D "okay";
> > +};
> > +
> > +&scp_c0 {
> > +       firmware-name =3D "mediatek/mt8188/scp.img";
> > +       memory-region =3D <&scp_mem_reserved>;
>
> It looks like a pinctrl for SCP_VREQ_VAO (GPIO 98) is missing?
> Datasheet says it's for "SCP to PMIC normal voltage request", and
> MT8195 and MT8192 also have that configured.

You are right. Will send v2.

> Regards,
> Fei
>
> > +       status =3D "okay";
> > +};
> > +
> >  &sound {
> >         pinctrl-names =3D "aud_etdm_hp_on", "aud_etdm_hp_off",
> >                         "aud_etdm_spk_on", "aud_etdm_spk_off",
> > --
> > 2.51.0.rc0.215.g125493bb4a-goog
> >
> >

