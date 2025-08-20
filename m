Return-Path: <linux-kernel+bounces-776944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F9B2D34D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34945A307D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EAC283153;
	Wed, 20 Aug 2025 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJo4aGMT"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775B35336E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666959; cv=none; b=XM7yZc5PgjxB6fO+JkXZdOoTqKmGVCd862XDZi/WIxezHBKg7KxNhIjjCSGe5TBfdKk4PX1GXVlwTS2ibjHQOtVqpxFXV/MtlVIfBU7TO0VSVIe/kZnaIG+QS3gniVGZxeYmHqxiSEVpgRiaQvgPZ3pqyCYXFnnBRUsfKpV2jz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666959; c=relaxed/simple;
	bh=gmB0hK4PnEhQzKkPj/vuuOgut+a03Fj//iRvNLatQEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPtXpFhIXoFibCvkXWk9FXHOsNy0HRIhhnVenC7BTnQMVwoNCKIyVzCl9g7qaJkmbrKl0hfpzHS8MJ9t7nTpfkfsp2z9EdQNAFAG5rQjWwDq3yj3LQWtTagUbvUdW7lcpTKydgMjKZDBk8khKRBeZXoVWMxoGelIZv9jtisPwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XJo4aGMT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70d7c7e9731so593816d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755666956; x=1756271756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMOc0zAG5IHElycDwN0z3G1Bp9v6la9CFRr7DqTKuhw=;
        b=XJo4aGMTKN3jOvzFBbPrJHi+gEmku1jeLYLbZM0B6HfwLHdc2pNhHnTOroJ4STAHqj
         5Ng8n491T7qUu/G0aR5HgMdE/alwhxHbdFdqSpcWyR5OUzBm+XsHKgGMQPA4iTt419su
         zsxFVuoDWWcrBzqLrCVLHBT8ZnJheqG09hXEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755666956; x=1756271756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMOc0zAG5IHElycDwN0z3G1Bp9v6la9CFRr7DqTKuhw=;
        b=AC25S4Txh1ZBhy7P0kUQvVe5L1hpFsZ/R1iluoqV6gB/S/no+XDt31beROK2hSuLQU
         H+yCT6hec8n2jd497IFGsjJkE2NnskmzviV3pP8N0ikURreFrEavyP6FnHq5QEtNJJ8l
         wHZIal5k6vB6BnT1cWXRSuSfkUKnviP9pDv74xJxic8FDUUxNUcV+zDeetMyOvKK4Kdm
         rUXV/1Oufyyr4JdabomRoHae0t8p5mcA4Dzeco9XO9KrKAHInDXism9MUme23WIXA/j2
         hraOlAAnzDTCvda1rwBcpRIwVm6spwRlqlvAClTGHCdU8cYZRaZGgMpQNXHcpJ6Zc3V1
         XQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyxS2I+Iya3MHi4rip9ZLgJNyP/NplW0cjwvi7KeTMEF2mOTw+2/HwQCyYzd3FyP8srgG78P8OAVK97Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy781kNwMA9zPkVK+/J5Z+A3pMP77sjMrdAybDURjdk5AFERIul
	NmO2K43K0OgKuk7XaMKQ3iDIF6FIlRwfmAcW6H8GaXiBLMvpJJFICrfHVqnhU/sFPJFbBKr1i1l
	g/bkWpQ==
X-Gm-Gg: ASbGncvrd3yoD9bf6Yb7ud8FdmrfzWusjP3SnmyyNTdCQBGaq7RE4QUrO8do2izLIqR
	k1jqNCek4Syvfw8ZY1mrzC/pTifBZgbhAK+vohTkN/TRF+fm8/GSwdr24aKI+n6NBrLrJVXKwkd
	jDlH/UJJUTaypS9PimOSprzxEn8aOqUvb5hhueA+bxm0llTeJ8ue3/28ztCWWQjUYF2VyQzN7CM
	+Cf+nctP7cNnIO/ZBg13ekH9AdUoN6WZwvZ23z6FhggOGt6yQwNZk+9qt/bFvdm0RfMly+jOUTi
	khApCT0C6uhl/lTu/DzbQAYP0pR+cy1JPEvY2bVWjuT+ZEXYqr9CwhLbPjp4I7t7+XiR7IZG8Vf
	wAEnNXErXtCoEdyGiAEwV8xHYx3jb8q1GjsvNiBgp1Yt39r8a2O8wSEOWVmG5cg==
X-Google-Smtp-Source: AGHT+IHaTpj6duXWE2L8KZAqnv1qdM798Fil0kLeYC6/Syiwt2Xmx0TZwCB0cSwPzLZxT4tHuRuNOQ==
X-Received: by 2002:a05:6214:226b:b0:709:9991:158a with SMTP id 6a1803df08f44-70d770bd3e7mr15769276d6.43.1755666955888;
        Tue, 19 Aug 2025 22:15:55 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92fa157sm83152796d6.47.2025.08.19.22.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 22:15:54 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0bf08551cso140441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:15:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXElO1gRwCrmMw+A1sG9QCfrbcv2ZrgXTZGYhfLMfaw2vYTH02bT94l9u6HZ0LrG17P4DZOqsqYE2zwnVs=@vger.kernel.org
X-Received: by 2002:ac8:7d0c:0:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4b292f95907mr2439661cf.9.1755666954079; Tue, 19 Aug 2025
 22:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814083144.191554-1-wenst@chromium.org> <CAC=S1nhz_ESY4VrgWs=dVinLtdOamh6to3EgD1w1Kx=4YBOD9A@mail.gmail.com>
 <CAGXv+5Hke6aEYdyc096_aeS9KHiOzcNqirB-rFT2odepaYhayQ@mail.gmail.com> <CAC=S1nheT46K+jkmtq4EJxOVO=nwasan0LCJwv-HTEK6P6DgxA@mail.gmail.com>
In-Reply-To: <CAC=S1nheT46K+jkmtq4EJxOVO=nwasan0LCJwv-HTEK6P6DgxA@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Aug 2025 14:15:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CRZaCvaw5fQxgWBgBjnK6Y05p6kHJ2hrHGtLY47Ymsog@mail.gmail.com>
X-Gm-Features: Ac12FXy8CAi4s4o72NAJVVqc3RW7R9QsaD5heHRhqLT1YoNyBEvsC2eFaSQEZVc
Message-ID: <CAAFQd5CRZaCvaw5fQxgWBgBjnK6Y05p6kHJ2hrHGtLY47Ymsog@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Fei Shao <fshao@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:52=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Thu, Aug 14, 2025 at 5:06=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Thu, Aug 14, 2025 at 4:59=E2=80=AFPM Fei Shao <fshao@chromium.org> w=
rote:
> > >
> > > On Thu, Aug 14, 2025 at 4:38=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> > > >
> > > > Previously a mutex was added to protect the encoder and decoder con=
text
> > > > lists from unexpected changes originating from the SCP IP block, ca=
using
> > > > the context pointer to go invalid, resulting in a NULL pointer
> > > > dereference in the IPI handler.
> > > >
> > > > Turns out on the MT8173, the VPU IPI handler is called from hard IR=
Q
> > > > context. This causes a big warning from the scheduler. This was fir=
st
> > > > reported downstream on the ChromeOS kernels, but is also reproducib=
le
> > > > on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even th=
ough
> > > > the actual capture format is not supported, the affected code paths
> > > > are triggered.
> > > >
> > > > Since this lock just protects the context list and operations on it=
 are
> > > > very fast, it should be OK to switch to a spinlock.
> > > >
> > > > Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to prote=
ct decoder context list")
> > > > Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to prote=
ct encoder context list")
> > > > Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++--=
--
> > > >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-=
----
> > > >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
> > > >  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  4 ++--
> > > >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-=
----
> > > >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
> > > >  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  4 ++--
> > > >  7 files changed, 26 insertions(+), 20 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vp=
u_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > index 145958206e38..e9b5cac9c63b 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > @@ -77,14 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vc=
odec_dec_dev *dec_dev, struct vde
> > > >         struct mtk_vcodec_dec_ctx *ctx;
> > > >         int ret =3D false;
> > > >
> > > > -       mutex_lock(&dec_dev->dev_ctx_lock);
> > > > +       spin_lock(&dec_dev->dev_ctx_lock);
> > >
> > > Do you mean spin_lock_irqsave()?
> >
> > This function is only called from the handler below (outside the diff
> > context), which itself is called from hard IRQ context. This is mention=
ed
> > in the comment above the handler.
>
> I see. I only searched here but didn't check the full source.
> Leaving a comment would be clearer if a revision is made, but it's not
> worth resending just for that alone.

Hmm, I feel like this could make it easy to introduce further locking
bugs in the future, because someone may just decide to call this
function from a different context. Also having the _irqsave variants
consistently used for the lock make it clear that it's used to
synchronize with an IRQ handler regardless of which place in the code
one looks at.

My recommendation would be to still amend the patch to do that.

>
> Reviewed-by: Fei Shao <fshao@chromium.org>
>
>
> On Thu, Aug 14, 2025 at 5:06=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > On Thu, Aug 14, 2025 at 4:59=E2=80=AFPM Fei Shao <fshao@chromium.org> w=
rote:
> > >
> > > On Thu, Aug 14, 2025 at 4:38=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.=
org> wrote:
> > > >
> > > > Previously a mutex was added to protect the encoder and decoder con=
text
> > > > lists from unexpected changes originating from the SCP IP block, ca=
using
> > > > the context pointer to go invalid, resulting in a NULL pointer
> > > > dereference in the IPI handler.
> > > >
> > > > Turns out on the MT8173, the VPU IPI handler is called from hard IR=
Q
> > > > context. This causes a big warning from the scheduler. This was fir=
st
> > > > reported downstream on the ChromeOS kernels, but is also reproducib=
le
> > > > on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even th=
ough
> > > > the actual capture format is not supported, the affected code paths
> > > > are triggered.
> > > >
> > > > Since this lock just protects the context list and operations on it=
 are
> > > > very fast, it should be OK to switch to a spinlock.
> > > >
> > > > Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to prote=
ct decoder context list")
> > > > Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to prote=
ct encoder context list")
> > > > Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++--=
--
> > > >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-=
----
> > > >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
> > > >  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  4 ++--
> > > >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-=
----
> > > >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
> > > >  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  4 ++--
> > > >  7 files changed, 26 insertions(+), 20 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vp=
u_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > index 145958206e38..e9b5cac9c63b 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > > > @@ -77,14 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vc=
odec_dec_dev *dec_dev, struct vde
> > > >         struct mtk_vcodec_dec_ctx *ctx;
> > > >         int ret =3D false;
> > > >
> > > > -       mutex_lock(&dec_dev->dev_ctx_lock);
> > > > +       spin_lock(&dec_dev->dev_ctx_lock);
> > >
> > > Do you mean spin_lock_irqsave()?
> >
> > This function is only called from the handler below (outside the diff
> > context), which itself is called from hard IRQ context. This is mention=
ed
> > in the comment above the handler.
> >
> > > >         list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
> > > >                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vp=
u) {
> > > >                         ret =3D true;
> > > >                         break;
> > > >                 }
> > > >         }
> > > > -       mutex_unlock(&dec_dev->dev_ctx_lock);
> > > > +       spin_unlock(&dec_dev->dev_ctx_lock);
> > > >
> > > >         return ret;
> > > >  }
> > >
> > > [...]
> > >
> > > > diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vp=
u_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > > > index 51bb7ee141b9..79a91283da78 100644
> > > > --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > > > +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > > > @@ -47,14 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vc=
odec_enc_dev *enc_dev, struct ven
> > > >         struct mtk_vcodec_enc_ctx *ctx;
> > > >         int ret =3D false;
> > > >
> > > > -       mutex_lock(&enc_dev->dev_ctx_lock);
> > > > +       spin_lock(&enc_dev->dev_ctx_lock);
> > >
> > > Also here.
> >
> > Same reasoning applies here as well.
> >
> > ChenYu
> >
> > > Regards,
> > > Fei
> > >
> > > >         list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
> > > >                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vp=
u) {
> > > >                         ret =3D true;
> > > >                         break;
> > > >                 }
> > > >         }
> > > > -       mutex_unlock(&enc_dev->dev_ctx_lock);
> > > > +       spin_unlock(&enc_dev->dev_ctx_lock);
> > > >
> > > >         return ret;
> > > >  }
> > > > --
> > > > 2.51.0.rc1.163.g2494970778-goog
> > > >
> > > >
>

