Return-Path: <linux-kernel+bounces-768373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EFFB26076
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9306A20ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FF2F0673;
	Thu, 14 Aug 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YLO/8KVW"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4F2EE61B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162376; cv=none; b=fTCANx4yzKXpy+FiK3h+eSCybYJ0gpS4s7GDGU0Tw60nYbJl2oin8009NtjrWyki+m1f2zklUbgGz6Ej8e9ZpM/9cM91Kx/lQp3aMpbHqWWyLIq3qJO3jkgMKurgECn31eypnCXp42JRJS2uD6gBg9lCxHHRNgJMRuDxAcMNtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162376; c=relaxed/simple;
	bh=gSNVIBdadQgcywxi9MYDP36qEK0ZNFmDF+sU8utwJG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4jJzNbNH4DsPJv7mH+ENMm6Jozg5O0gX84rw6kbr26w94wonwDKkix2BcvYtOtRYRHa8hU1WfWp2XAHAfyaXLj/YtEJiDn9heT8BsXHBlX/eK+Z9I5rELUs1H4GYisywmDhCLI6ADEUW8Nfk4ereoUF7mKTejOuaP7ghvlayPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YLO/8KVW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55cdfcc0ceaso1706391e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755162373; x=1755767173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdQWt9Kme6F2JRMMWpXobiCrHf8Uzy/gSybqJMT791c=;
        b=YLO/8KVWSlNQJtljtVq/icJVVPvIftEsVZBWMIhrLhNNXmrASww9TLn5L4D31QVE9m
         t+FXjgCeZMiQx0slz0eJR0j4Bx4gZUxCdNSJaZKnECQ7IcnlZOm7nBZzfSuFpN6MzyJ2
         dWvydv5gcZhElCyBvVZLdurBXmNqaLW8B6f+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162373; x=1755767173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdQWt9Kme6F2JRMMWpXobiCrHf8Uzy/gSybqJMT791c=;
        b=SGbR0M8dZKHiZXsv5/BTKG2ydsn2ehJB9HZr1zChjkp/BSgtHjvWn3c/LrxO3MyhUA
         fvxBK3dzVS4Gk9lGPU8Iy5csvqV5yRemurvAFmMa+qcznk9HOqaI0JjtGnjsSKCvt6vz
         QGMfKV9O5R6FBG8vnyA1oYStb22A7mQU0A1YpLVN31xnbaK6fMcGWgmMQke7p5fRR5GN
         NYoQDEOvqyU2Uab3lNhYqoWr9PWG9kYrNrPikn84AouGvTfX26cucO5JUUXMvhodmZq1
         bAZlb7srDDRAIvgroIrjdLhkr2813iom8oZfNa669iwi2Ue7QC1KxGR89TId+gX79d1t
         F9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVipRFWzUuuEwAJp+IEFApH2mAvBERvgTCOg2lbX+xcmyAzb9f+wqOIqODBmmfpyrQwFZbrK0KLj76xjlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDDZdLcuC3y7Tm3BKU12/7OqzX2tFvXu4mMfpKof3krt5/nbU
	Qm0VpkBT0JYr+VqWSEj7yZmZJ94bEs6xlN5lcm4jpZ4Ee7UjcMR/fiIjIcAcx1It8EAYamTSLk/
	Q0tHznFoYSsracDax/gMX2Jc7KvtZjZR2PyDklnSE
X-Gm-Gg: ASbGncvjSF98X4KwQ5IHJpK95eGUOtAh0phZphSH0A9bGcJTmGhaMsFJxaQS76sL6Qt
	nVrOIPHFqOpIOWm3vZVYRWYxNfGo1J4zahISThJxwMdLVbLTFNyb8D+QmmGfvkpPpDN1SGnDQXN
	6GrAbKuRaukCyhITrS5ldule81+TWDYAyY/Nk4pNsC5UDWrU/rprITYhLzpdqMdnFDiAJF7KOoC
	w1f21EA7Eeg5Rf65BgiikLtsa3357GSheE=
X-Google-Smtp-Source: AGHT+IGU9GnphCG6HSBtyUKLlXUpoZ2Yg6vOrNiRQ7pS1lm8OOaCvT+3b+1fL4SVXK6wQQu9nnSh1xn95CGSvALWb8c=
X-Received: by 2002:a05:6512:36c4:b0:550:e8b6:6996 with SMTP id
 2adb3069b0e04-55ce62621ffmr411660e87.2.1755162372342; Thu, 14 Aug 2025
 02:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814083144.191554-1-wenst@chromium.org> <CAC=S1nhz_ESY4VrgWs=dVinLtdOamh6to3EgD1w1Kx=4YBOD9A@mail.gmail.com>
In-Reply-To: <CAC=S1nhz_ESY4VrgWs=dVinLtdOamh6to3EgD1w1Kx=4YBOD9A@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 17:06:01 +0800
X-Gm-Features: Ac12FXy4zkwvr3Zx8Pq_FLpV4JVPqltCgSdUQmuTTkGxHam842ZxAUktUDXeYyQ
Message-ID: <CAGXv+5Hke6aEYdyc096_aeS9KHiOzcNqirB-rFT2odepaYhayQ@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Fei Shao <fshao@chromium.org>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:59=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Thu, Aug 14, 2025 at 4:38=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > Previously a mutex was added to protect the encoder and decoder context
> > lists from unexpected changes originating from the SCP IP block, causin=
g
> > the context pointer to go invalid, resulting in a NULL pointer
> > dereference in the IPI handler.
> >
> > Turns out on the MT8173, the VPU IPI handler is called from hard IRQ
> > context. This causes a big warning from the scheduler. This was first
> > reported downstream on the ChromeOS kernels, but is also reproducible
> > on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even though
> > the actual capture format is not supported, the affected code paths
> > are triggered.
> >
> > Since this lock just protects the context list and operations on it are
> > very fast, it should be OK to switch to a spinlock.
> >
> > Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to protect d=
ecoder context list")
> > Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect e=
ncoder context list")
> > Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++----
> >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-----
> >  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
> >  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  4 ++--
> >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-----
> >  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
> >  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  4 ++--
> >  7 files changed, 26 insertions(+), 20 deletions(-)
> >
>
> [...]
>
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if=
.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > index 145958206e38..e9b5cac9c63b 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> > @@ -77,14 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec=
_dec_dev *dec_dev, struct vde
> >         struct mtk_vcodec_dec_ctx *ctx;
> >         int ret =3D false;
> >
> > -       mutex_lock(&dec_dev->dev_ctx_lock);
> > +       spin_lock(&dec_dev->dev_ctx_lock);
>
> Do you mean spin_lock_irqsave()?

This function is only called from the handler below (outside the diff
context), which itself is called from hard IRQ context. This is mentioned
in the comment above the handler.

> >         list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
> >                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
> >                         ret =3D true;
> >                         break;
> >                 }
> >         }
> > -       mutex_unlock(&dec_dev->dev_ctx_lock);
> > +       spin_unlock(&dec_dev->dev_ctx_lock);
> >
> >         return ret;
> >  }
>
> [...]
>
> > diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if=
.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > index 51bb7ee141b9..79a91283da78 100644
> > --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> > @@ -47,14 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec=
_enc_dev *enc_dev, struct ven
> >         struct mtk_vcodec_enc_ctx *ctx;
> >         int ret =3D false;
> >
> > -       mutex_lock(&enc_dev->dev_ctx_lock);
> > +       spin_lock(&enc_dev->dev_ctx_lock);
>
> Also here.

Same reasoning applies here as well.

ChenYu

> Regards,
> Fei
>
> >         list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
> >                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
> >                         ret =3D true;
> >                         break;
> >                 }
> >         }
> > -       mutex_unlock(&enc_dev->dev_ctx_lock);
> > +       spin_unlock(&enc_dev->dev_ctx_lock);
> >
> >         return ret;
> >  }
> > --
> > 2.51.0.rc1.163.g2494970778-goog
> >
> >

