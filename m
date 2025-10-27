Return-Path: <linux-kernel+bounces-872175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CBAC0F773
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11143B3B61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B5313549;
	Mon, 27 Oct 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff/jTan1"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BA313E0B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583812; cv=none; b=Epk/Sa+LBxwit8gW4Fcx96PdiwIszqBzxXAD23CyjIj1ox/YDQBZIu80GsQYoYyujl7y3hAGgaQwoJKjLqH/zX1YHsb+8+vlPZ1mlAhWttbFGYt/j1cP7cJPDJO5IQx4juQDSxjmdpkDLxqD3/Y5tqo0BJ+1b0jQZZKDS8nJRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583812; c=relaxed/simple;
	bh=f9gyr+50VXCzFRqzh5h2Eocs+kwwPbsfidV5wgRt5Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thOVdm6Dyjtfs2QrdmSim3E8lEzN5Za2o0UTD55ZOjckO8+FKrFGip40ROevgYwN4QOWb7TzqjxFjaAipeo+fW6G8kHl5nOlsOj+dS3muJU2V9ekdp8hL9u3+nAQKK5C51cLDcEvr9dkZspdKGTermCgVBal8jcrmQHjqFzg3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff/jTan1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4270491e9easo4045165f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583809; x=1762188609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llXiWHJLf2syx3blZo0CXJGIyiry1LJYTByzcLi8/h0=;
        b=ff/jTan1lkgWUNpwMGoLzGON5a2N4mfXOajPZajkFvH4cHFDFH+FASZNEuimReQO6t
         h0XaH+V4MjEnkv28OfQ38Tvg38vlkJkkq4RD92MGqt/zQzWhEXU9Bnvg1i80vEXdEdfA
         cPku+D2MAL+xeB9+xGkOr3NIEkdA9WjcUHW/zNNC01W5n8bMhqxRohJO2bTq8sDwdKg/
         TP51AnWBRMZtN4dZo+3KFvGCIG8D3ae6YO8rH91kqj9XOGkFJFFhWjSakU6jYCOY5FpC
         zC7XbRmD/bv7A9azMVoI1YHeqMiVCcNUVfG5RDf6ZRtAqWq+FH1HTRInCvxfxnB2DpZy
         38FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583809; x=1762188609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llXiWHJLf2syx3blZo0CXJGIyiry1LJYTByzcLi8/h0=;
        b=Zhh/KoOe6+nWenG7s/pIUbW73xZxKP137im7vpD4n1Lk74+V7E5OyWj76Fqoj+dpQJ
         sN6IO+QZ9yKSyLkKoPn+KG7HmtDvlT5EeW1ChO1AkHeukZe7/GFtXjupRwVCfvrAltMW
         yfMzlS7Rpw6kcxcbPnOQcwA+wQ1bSXP3HFOlHyy7sLGyXBWQx6Un4Cj1gdj0bGQXqN7B
         A7o0vQdmZEbR8a/XbSvGqLoeBJnzNh5AnSyXdNnRchDibdyYskdu3iLmYUnRTNXxC3q8
         A5vJg5wKKVCLSuV4gKJwl3yiHY+4Pv/FOdusWRmUN4S0OFoiQzqcK/2M/RNCoQ7Ww1vA
         V7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVzXv2klR/5p7VynvU+wc3apECXhT4zO2yhhRrHRpVum24liM/MVfDoC8FIWfuB5/VyjwaOmSdLRxUeaX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkC5xtHNvbHPLX5ogvyZV3bvx9a3E/RgX1dyKwzco2HSX+zx73
	Km/m6faShE5s+fwc9CFUCmfPyXRtUw2TyrS0NW0xdCNaSd55UMso1pWalmsQt2y1Ejmj6NbzC1u
	o3NWqvjeIdW537Mh2P1qbcaXXskbPlYM=
X-Gm-Gg: ASbGncv/CUH+52/CsMkyvIh10X7tmBVIDjkxBf3n5hrXZ4QQdizyN98wMoR17wNZ9Yp
	I5ScA3JRmo7EKjZeArpoSwnJomCGv4blbZg+yPoEiUCfXMuNb9NtqYW642Ievlmrim254jOd8q/
	+csFvmixMZrnhKu8bOV0AcYjamtguHbbd568eGrFwB8SlsZ+/rd6G+/gAXUfkqomYgQGj6J+B2J
	kZDmOcw5ltGqMIIjnM6gKcwgSqkWHCkdj0GfTbGZlpeVkTVgASHF58csGb4Dg==
X-Google-Smtp-Source: AGHT+IH4XlaBzxcnNj5YFZ0kloDrzQaT1eJpLjTjeIpDU2XpK4VeABDkTozkzcR3WZnwD6TgVQ+f15BePNjDYvfetA4=
X-Received: by 2002:a05:6000:186e:b0:428:476e:e0ab with SMTP id
 ffacd0b85a97d-429a7e97661mr333005f8f.60.1761583808872; Mon, 27 Oct 2025
 09:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022142051.70400-1-clamor95@gmail.com> <20251022142051.70400-7-clamor95@gmail.com>
 <bd6262c6-a31c-43a6-8ec5-2735fb2fe0d2@kernel.org>
In-Reply-To: <bd6262c6-a31c-43a6-8ec5-2735fb2fe0d2@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Oct 2025 18:49:57 +0200
X-Gm-Features: AWmQ_blgGtMyE7YToN26_Q2JZoB8VDufuUc2Jv2Dui7Z-P7sPMVoiu7__HneWyw
Message-ID: <CAPVz0n277DZ8S5wX5n0gCaOpng64uEfx3VVue4Zp0n5bsDevqQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/23] staging: media: tegra-video: vi: adjust
 get_selection op check
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 17:4=
4 Hans Verkuil <hverkuil+cisco@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 22/10/2025 16:20, Svyatoslav Ryhel wrote:
> > Get_selection operation may be implemented only for sink pad and may
> > return error code. Set try_crop to 0 instead of returning error.
>
> Can you mention why try_crop is set to 0 instead of returning an error?
>
> That would be good to have in the commit log. And in fact, it's not
> clear to me either why you want this.
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/staging/media/tegra-video/vi.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/m=
edia/tegra-video/vi.c
> > index 7c44a3448588..856b7c18b551 100644
> > --- a/drivers/staging/media/tegra-video/vi.c
> > +++ b/drivers/staging/media/tegra-video/vi.c
> > @@ -476,15 +476,11 @@ static int __tegra_channel_try_format(struct tegr=
a_vi_channel *chan,
> >       fse.code =3D fmtinfo->code;
> >       ret =3D v4l2_subdev_call(subdev, pad, enum_frame_size, sd_state, =
&fse);
> >       if (ret) {
> > -             if (!v4l2_subdev_has_op(subdev, pad, get_selection)) {
> > +             if (!v4l2_subdev_has_op(subdev, pad, get_selection) ||
> > +                 v4l2_subdev_call(subdev, pad, get_selection, NULL, &s=
dsel)) {
> >                       try_crop->width =3D 0;
> >                       try_crop->height =3D 0;
>
> This looks all a bit magical. Which subdev is queried here? I.e. what is =
the corresponding
> subdev driver that implements get_selection?
>

Camera sensor subdev, Tegra VI driver directly interacts with camera sensor=
.

> >               } else {
> > -                     ret =3D v4l2_subdev_call(subdev, pad, get_selecti=
on,
> > -                                            NULL, &sdsel);
> > -                     if (ret)
> > -                             return -EINVAL;
> > -
> >                       try_crop->width =3D sdsel.r.width;
> >                       try_crop->height =3D sdsel.r.height;
> >               }
>
> It looks odd (esp. setting try_crop to 0), and I wonder if this code path=
 has been tested.
>

Yes it was tested.

Original code checked if the camera sensor has get_selection
implemented and if such operation is supported then it applies width
and height from get_selection, else zeroes. This works just fine with
most cameras and v4l2 compliance tests pass fine, with most but not
with mt9m114 which implements get_selection only for its ifp source
pad while sink pad always returns -EINVAL, hence VI driver fails with
-EINVAL too. To address drivers like mt9m114 instead of just fail with
-EINVAL if get_selection returns error try_crop width and height will
be set the same as get_selection is not implemented.

> Regards,
>
>         Hans

