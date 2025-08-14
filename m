Return-Path: <linux-kernel+bounces-768353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E48B26040
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BA11C821FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387C2F83BC;
	Thu, 14 Aug 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ik6EipQO"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AB2E975B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161942; cv=none; b=hmSkaZmC8caD6MJa9LNmsL1J/8L06CuiPac/XHFjCX+0UjY5o7Gmbfnxa3TRimWmT3BKfrtwz7vLLCejCNjzQ6bMQHNn7QcKk67ySpU1G1puMGQrinsJMmQUehEAVBrsmVZOVYeX14V2ZJCkqs+NP0PJcaTjiTndd9zrxhz9Qg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161942; c=relaxed/simple;
	bh=QTIXtveDTMoEdRMxbTNvNq78eOmhb3+4Ay3C4Fd4UmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT3S6nLz1c4EBFAxx5X9ohT+wTeGLthY8yjESnc5SRV2/3wCq6L+Id0YCaylJ9UD+eT/h4QTfSHOTTo1WdqH78wGzQINyW8gUqwOOksqcNirZq/yuobKM2UkLQXdAjFuiAqxBl9n0Fwe/mHCL7okPqdeeE8c1mEoDA7/YYsuInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ik6EipQO; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-890184a05a0so451265241.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755161939; x=1755766739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7uH31UN91+fljH+roDUJZnayXqB6OvkipUsIFV6Wzs=;
        b=Ik6EipQOM0NLDPPMxn4PP9DPO7k235PFnJxMG3tq3c3PxNbXTHOicsbq9Xa3Sm4Dtd
         cF/Q3CXuOaFzCPiZ+gIK3pwNq0x7gqHd+kJPxPxGpWBSnhX+fhWr5gZOiXDafQBC/i+r
         lMuVH5MdnOfanJFIxmxd/7jZnYkRup4ZGEfJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161939; x=1755766739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7uH31UN91+fljH+roDUJZnayXqB6OvkipUsIFV6Wzs=;
        b=j64Tnru7Gil0qq2IJK2Pb5avwNsoRPEhU1YV2M1uWCHJsG+c0LIIkDpv6qhpa00XAf
         2vSVf2szJbASfjZDQpHTPvEfkWDCK/Xdfzr3ZamTOTwJh4XB9Rqksl/s7hrTjO3v/zGN
         hFcRXdnqnMhL426tPaNR9+jgBBeKGmR8LmyUq6pItCWRpEwVo35HCVVQ+pGuywKUk8bn
         7zzMq+MJHBmWtdCXg5N0Sg/bTYLViUyTUahfGTcEJ32zCTpo0/m5HfroA6iByfhH+E9d
         Xe4KSUSmq6MgI58JusfVxr5cRw2xMY7s9gBnYvvVZZogLcGuYKSv7n6ZB6V/yynRFifv
         wT9w==
X-Forwarded-Encrypted: i=1; AJvYcCX4TcQBbOgTihW3Flz1FvVkbR34FokHOz2w2OlIgkzd6icuLtB87j6bPjda7zQKHM2kPeCpk0fzQ5tYhV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1f9Wgeb0ladPAeJ19TK9YYdTTcT7pc3p1zt+eI4+uRW6nVsw
	JciS8UYb/H3EhILwB68OnxgIj6q85FUXqjK9blg87dfgHprBWQ0mCY7ESWwJGU92483JQErCfwR
	63nI=
X-Gm-Gg: ASbGncvPlR1D8zrkmkqeTjgUKU9qy7u/mYCTZf210y9KobylFhp3lz5N2wfWoA7tkdi
	MrRjNs8AjbsIdvQK3keZ7osgo1KgSI6rbIR74INGOuIylnVO9kMbh8ft3zSLH/lN0Fi+mAFWX1m
	RngwDHLVVFbrvoxEVWlUoqM37icX5QX19FSGb++rH/2ZwfvAUGB1iKkBJD55OSJoxedba+LaU2y
	UhOyMLtdfoTjBev9Cm0OrDPlSBZDe6djtEIhK4Up0E+NZtQDXclImfVKcRhukY/yPHUlWc1GQdp
	vHVZk7HhiGPtEYwEdrpHEPuxwHgqbQbqhvD1ME1/ncjoWlkHTr+Ld6fR+Cntx+EY0Y2+NHP/AX3
	JoqK2qO023Ij7yqnl1VHOAG736sALLMsw9LnTbtSXytDd+PK2YbxkwLtZXLGjqK11BoXn
X-Google-Smtp-Source: AGHT+IEXqjeWkOydqsKuzFydyfJ3uaWhcOztnnJ03YwaPedAnubZbjwKLs+OQSqGKTZw6CtwkwygLg==
X-Received: by 2002:a05:6102:5d7:b0:4e9:963a:a42b with SMTP id ada2fe7eead31-5104c1ddc16mr432184137.8.1755161939124;
        Thu, 14 Aug 2025 01:58:59 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e0247160esm3020963241.0.2025.08.14.01.58.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 01:58:58 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50e29b4fd2cso780204137.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:58:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgScHjeqy6RoENP1/9FdKUtQxXT0+UuG6JWlksXeDJzGPIbbN5LpZ+fTgvrM/mVwle6s64hmiN8Bwp1QY=@vger.kernel.org
X-Received: by 2002:a05:6102:8083:b0:4e5:5c14:5937 with SMTP id
 ada2fe7eead31-51058a87196mr673671137.1.1755161937736; Thu, 14 Aug 2025
 01:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814083144.191554-1-wenst@chromium.org>
In-Reply-To: <20250814083144.191554-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 14 Aug 2025 16:58:21 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhz_ESY4VrgWs=dVinLtdOamh6to3EgD1w1Kx=4YBOD9A@mail.gmail.com>
X-Gm-Features: Ac12FXyjQIDoUSwiVtyIticCvke0x3M57lwGIL10ez0LU-OLgFrmxrQr_qqqlnA
Message-ID: <CAC=S1nhz_ESY4VrgWs=dVinLtdOamh6to3EgD1w1Kx=4YBOD9A@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 4:38=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Previously a mutex was added to protect the encoder and decoder context
> lists from unexpected changes originating from the SCP IP block, causing
> the context pointer to go invalid, resulting in a NULL pointer
> dereference in the IPI handler.
>
> Turns out on the MT8173, the VPU IPI handler is called from hard IRQ
> context. This causes a big warning from the scheduler. This was first
> reported downstream on the ChromeOS kernels, but is also reproducible
> on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even though
> the actual capture format is not supported, the affected code paths
> are triggered.
>
> Since this lock just protects the context list and operations on it are
> very fast, it should be OK to switch to a spinlock.
>
> Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to protect dec=
oder context list")
> Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect enc=
oder context list")
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  4 ++--
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  4 ++--
>  7 files changed, 26 insertions(+), 20 deletions(-)
>

[...]

> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 145958206e38..e9b5cac9c63b 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -77,14 +77,14 @@ static bool vpu_dec_check_ap_inst(struct mtk_vcodec_d=
ec_dev *dec_dev, struct vde
>         struct mtk_vcodec_dec_ctx *ctx;
>         int ret =3D false;
>
> -       mutex_lock(&dec_dev->dev_ctx_lock);
> +       spin_lock(&dec_dev->dev_ctx_lock);

Do you mean spin_lock_irqsave()?

>         list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
>                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
>                         ret =3D true;
>                         break;
>                 }
>         }
> -       mutex_unlock(&dec_dev->dev_ctx_lock);
> +       spin_unlock(&dec_dev->dev_ctx_lock);
>
>         return ret;
>  }

[...]

> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> index 51bb7ee141b9..79a91283da78 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> @@ -47,14 +47,14 @@ static bool vpu_enc_check_ap_inst(struct mtk_vcodec_e=
nc_dev *enc_dev, struct ven
>         struct mtk_vcodec_enc_ctx *ctx;
>         int ret =3D false;
>
> -       mutex_lock(&enc_dev->dev_ctx_lock);
> +       spin_lock(&enc_dev->dev_ctx_lock);

Also here.

Regards,
Fei

>         list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
>                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
>                         ret =3D true;
>                         break;
>                 }
>         }
> -       mutex_unlock(&enc_dev->dev_ctx_lock);
> +       spin_unlock(&enc_dev->dev_ctx_lock);
>
>         return ret;
>  }
> --
> 2.51.0.rc1.163.g2494970778-goog
>
>

