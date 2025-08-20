Return-Path: <linux-kernel+bounces-777146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58852B2D5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8282B584E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA42D94A1;
	Wed, 20 Aug 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mv83KNJ2"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A512D837E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677655; cv=none; b=ShqlPwTQkaRdwJ0RRJAQ4a2N5AFhcaLfn7X6HR001fi2mrD+AWKSt4nQzlYk3d6iSNIOEa5Jg4v5/uponuDp8SgVkGihuwMouEJMYA4SVSWDQ6vRfpTfVGEXeLBi+EFzcF+PhkmLCTe9UF8ATMrVPUjFfQpUKNqRHDfD88diUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677655; c=relaxed/simple;
	bh=k+Bby+5DCIUpcxGPTLUxrvu7M8wlPPVfJ+nXiXlLi+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSAxjNekZoBXBIZGv08DnL5Xr7GQn3l7+vxeNx/6MozXSFlUhHtn+KASD74uQNtg3FLmrSZE5TieHQ/gyDuVMxY/IoCz6Pv6TjlLAq2XJ+OzFSWdKCvgmVPKjt7DahQOr+/CPsR5IEaH+cGfJJMH5FljKfbKZ7t/k7YxtKJweTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mv83KNJ2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e87061a6d5so665313085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755677652; x=1756282452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUGdpiEBvij3QABk3TeXAVu9+edp1QZJrsLkuXoDk+M=;
        b=Mv83KNJ2kHH/73x8YrUicIbCYbTMn8Krd98fx2tt28fFiCa6IqY4psyw+VWEmLm7Zu
         51iBXFgH9Bh+OidYFHq2NoSUpz04Vxd11DvC7ADK2TuSRQft63htK9FCYM1ansh9QaaC
         lxGU2RqQuu1K2ywt5vC7F/A4rd07i+YEghtps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677652; x=1756282452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUGdpiEBvij3QABk3TeXAVu9+edp1QZJrsLkuXoDk+M=;
        b=mtumkorwfTZhSArLP36XQA4ju0PMhViUx9J+YlNK879AgzMBJ/KmVvWhSCNEDxIIsJ
         7cHiaMBmie3uJjEBdoO+XCntscd3Fe0kKOWf6dpgJty5Fy3EkRUvWljDoRmF7w1JPp3d
         Jqo/Ufrhx+3QjRp42n2QxsMbkT70UFG+Rm0RfVIBPH9VmVzEn73DZXexxtosjU70vLB6
         5mAl72TmFfM11zQTsFqRgSmK0+aEtmcnG8NkSq5fLPbRc4kWgoyS09IajRLYNsNT2HAU
         mBWAfGp5U9L5XxoqDarhRyvD0UhSy84xOF7DWy8I49Iy+EJcaiE3M6WhQskNwhtATwh9
         3gtw==
X-Forwarded-Encrypted: i=1; AJvYcCXX85OpkOBLvLuYgUwJDOD2fY48VKL3zP0SjZe/FKqhTLSKAlIygouhmhhnswmgJRGvjfhWReFbWtga4Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1o13t0I9XtTeQale+mQM6LAd9yR6zrh7v/ELJZAEj7B5yEx06
	KO2nivGb66qrUB9DRtX8Lmjmi0lK/3/cMZeGT7eGPNf1dZel8dLIbOOexPhl2jEnOO3wc5G6JwO
	RPfxAeQ==
X-Gm-Gg: ASbGnctFgNYR+OWbRVO3XIBbjG1sK28D5cNxKkZV3r73lm4+husCbFsIYnTRKVEZFBj
	pU+0TwQgZYFS+Goisj+6k0og8wceOT6hLxVzH07pq+h/1cPiJQRyj/Wy1+Xe+R0OcvMxFg+jFhE
	meYYxGeFSHc5f8bDYqwwjumJkA6PonQcJeK/WGwwfouoVnPubU+uCoGqaRxb+O1LDKbXHoSSdRL
	fsbZMaPfsP5Bku09hxHQ9rsklbvZQU6TxB6DFUe7l/aeSjgOpGsj6TZorUDM8BaiIYemg2mg92D
	xaonENGAsUlfp67fRfWYKregEooaiisv5aKwAFzS3tK64yQOnNmdlPFzD7jKjA7buUeBwkbLyxh
	0b7hOEhPzSbKr+GfSDhjZzjNU1I5sj2tCM5zxp+0jFNoaBmNy0qvpMRH7KnmYgQ==
X-Google-Smtp-Source: AGHT+IFOSr75mfYHCqZfDqy4nJAKzOg22mn5TzaIXDaBno9v+wUSxobbXQJ30bOXTQRS7dHWXU14sA==
X-Received: by 2002:a05:620a:191a:b0:7e8:18d5:4b8d with SMTP id af79cd13be357-7e9fcb0a001mr204973785a.42.1755677651677;
        Wed, 20 Aug 2025 01:14:11 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e054246sm901135285a.21.2025.08.20.01.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:14:11 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0bf08551cso181261cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzOq8X0xTQaoifwApY7nj+RF4To1OKI3vJweVjnvvrIPfykSULjitJ+XC4+BQgIDH80x0XHV7FVZicw1Q=@vger.kernel.org
X-Received: by 2002:ac8:580f:0:b0:4b0:8318:a95 with SMTP id
 d75a77b69052e-4b291917518mr3343931cf.8.1755677650289; Wed, 20 Aug 2025
 01:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075405.1041838-1-wenst@chromium.org>
In-Reply-To: <20250820075405.1041838-1-wenst@chromium.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Aug 2025 17:13:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DTOJ2=ibyykpCxDnUhUM8EXm4-MShKxBbH02FA8fzQGw@mail.gmail.com>
X-Gm-Features: Ac12FXz1tD17T4pJyJ5nYaNhIcW7uWOQMmG3q0C-wH7bBxp3Zu-B_gudXTVL_ek
Message-ID: <CAAFQd5DTOJ2=ibyykpCxDnUhUM8EXm4-MShKxBbH02FA8fzQGw@mail.gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:54=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
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
> Changes since v1:
> - Switched to _irqsave / _irqrestore variants even in helper only called
>   by IRQ handler (Tomasz)
>
>  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  5 +++--
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  5 +++--
>  7 files changed, 28 insertions(+), 20 deletions(-)

Thanks!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best,
Tomasz

>
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index d7027d600208..223fb2294894 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -47,30 +47,32 @@ static void mtk_vcodec_vpu_reset_dec_handler(void *pr=
iv)
>  {
>         struct mtk_vcodec_dec_dev *dev =3D priv;
>         struct mtk_vcodec_dec_ctx *ctx;
> +       unsigned long flags;
>
>         dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
>
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_for_each_entry(ctx, &dev->ctx_list, list) {
>                 ctx->state =3D MTK_STATE_ABORT;
>                 mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE=
_ABORT", ctx->id);
>         }
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>  }
>
>  static void mtk_vcodec_vpu_reset_enc_handler(void *priv)
>  {
>         struct mtk_vcodec_enc_dev *dev =3D priv;
>         struct mtk_vcodec_enc_ctx *ctx;
> +       unsigned long flags;
>
>         dev_err(&dev->plat_dev->dev, "Watchdog timeout!!");
>
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_for_each_entry(ctx, &dev->ctx_list, list) {
>                 ctx->state =3D MTK_STATE_ABORT;
>                 mtk_v4l2_vdec_dbg(0, ctx, "[%d] Change to state MTK_STATE=
_ABORT", ctx->id);
>         }
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>  }
>
>  static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg =3D {
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.c
> index 46d176e6de63..3b81fae9f913 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
> @@ -198,6 +198,7 @@ static int fops_vcodec_open(struct file *file)
>         struct mtk_vcodec_dec_ctx *ctx =3D NULL;
>         int ret =3D 0, i, hw_count;
>         struct vb2_queue *src_vq;
> +       unsigned long flags;
>
>         ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>         if (!ctx)
> @@ -267,9 +268,9 @@ static int fops_vcodec_open(struct file *file)
>
>         ctx->dev->vdec_pdata->init_vdec_params(ctx);
>
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_add(&ctx->list, &dev->ctx_list);
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>         mtk_vcodec_dbgfs_create(ctx);
>
>         mutex_unlock(&dev->dev_mutex);
> @@ -294,6 +295,7 @@ static int fops_vcodec_release(struct file *file)
>  {
>         struct mtk_vcodec_dec_dev *dev =3D video_drvdata(file);
>         struct mtk_vcodec_dec_ctx *ctx =3D file_to_dec_ctx(file);
> +       unsigned long flags;
>
>         mtk_v4l2_vdec_dbg(0, ctx, "[%d] decoder", ctx->id);
>         mutex_lock(&dev->dev_mutex);
> @@ -312,9 +314,9 @@ static int fops_vcodec_release(struct file *file)
>         v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
>
>         mtk_vcodec_dbgfs_remove(dev, ctx->id);
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_del_init(&ctx->list);
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>         kfree(ctx);
>         mutex_unlock(&dev->dev_mutex);
>         return 0;
> @@ -407,7 +409,7 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
>         for (i =3D 0; i < MTK_VDEC_HW_MAX; i++)
>                 mutex_init(&dev->dec_mutex[i]);
>         mutex_init(&dev->dev_mutex);
> -       mutex_init(&dev->dev_ctx_lock);
> +       spin_lock_init(&dev->dev_ctx_lock);
>         spin_lock_init(&dev->irqlock);
>
>         snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
.h
> index d047d7c580fb..9d68808e8f9c 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
> @@ -285,7 +285,7 @@ struct mtk_vcodec_dec_dev {
>         /* decoder hardware mutex lock */
>         struct mutex dec_mutex[MTK_VDEC_HW_MAX];
>         struct mutex dev_mutex;
> -       struct mutex dev_ctx_lock;
> +       spinlock_t dev_ctx_lock;
>         struct workqueue_struct *decode_workqueue;
>
>         spinlock_t irqlock;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 145958206e38..40b97f114cf6 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -75,16 +75,17 @@ static void handle_get_param_msg_ack(const struct vde=
c_vpu_ipi_get_param_ack *ms
>  static bool vpu_dec_check_ap_inst(struct mtk_vcodec_dec_dev *dec_dev, st=
ruct vdec_vpu_inst *vpu)
>  {
>         struct mtk_vcodec_dec_ctx *ctx;
> +       unsigned long flags;
>         int ret =3D false;
>
> -       mutex_lock(&dec_dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dec_dev->dev_ctx_lock, flags);
>         list_for_each_entry(ctx, &dec_dev->ctx_list, list) {
>                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
>                         ret =3D true;
>                         break;
>                 }
>         }
> -       mutex_unlock(&dec_dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dec_dev->dev_ctx_lock, flags);
>
>         return ret;
>  }
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_en=
c_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv=
.c
> index fb1c3bdc2dae..82b8ff38e8f1 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
> @@ -117,6 +117,7 @@ static int fops_vcodec_open(struct file *file)
>         struct mtk_vcodec_enc_ctx *ctx =3D NULL;
>         int ret =3D 0;
>         struct vb2_queue *src_vq;
> +       unsigned long flags;
>
>         ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
>         if (!ctx)
> @@ -176,9 +177,9 @@ static int fops_vcodec_open(struct file *file)
>         mtk_v4l2_venc_dbg(2, ctx, "Create instance [%d]@%p m2m_ctx=3D%p "=
,
>                           ctx->id, ctx, ctx->m2m_ctx);
>
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_add(&ctx->list, &dev->ctx_list);
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>
>         mutex_unlock(&dev->dev_mutex);
>         mtk_v4l2_venc_dbg(0, ctx, "%s encoder [%d]", dev_name(&dev->plat_=
dev->dev),
> @@ -203,6 +204,7 @@ static int fops_vcodec_release(struct file *file)
>  {
>         struct mtk_vcodec_enc_dev *dev =3D video_drvdata(file);
>         struct mtk_vcodec_enc_ctx *ctx =3D file_to_enc_ctx(file);
> +       unsigned long flags;
>
>         mtk_v4l2_venc_dbg(1, ctx, "[%d] encoder", ctx->id);
>         mutex_lock(&dev->dev_mutex);
> @@ -213,9 +215,9 @@ static int fops_vcodec_release(struct file *file)
>         v4l2_fh_exit(&ctx->fh);
>         v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
>
> -       mutex_lock(&dev->dev_ctx_lock);
> +       spin_lock_irqsave(&dev->dev_ctx_lock, flags);
>         list_del_init(&ctx->list);
> -       mutex_unlock(&dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
>         kfree(ctx);
>         mutex_unlock(&dev->dev_mutex);
>         return 0;
> @@ -297,7 +299,7 @@ static int mtk_vcodec_probe(struct platform_device *p=
dev)
>
>         mutex_init(&dev->enc_mutex);
>         mutex_init(&dev->dev_mutex);
> -       mutex_init(&dev->dev_ctx_lock);
> +       spin_lock_init(&dev->dev_ctx_lock);
>         spin_lock_init(&dev->irqlock);
>
>         snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name), "%s",
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_en=
c_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv=
.h
> index 5b304a551236..0cddfa13594f 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
> @@ -206,7 +206,7 @@ struct mtk_vcodec_enc_dev {
>         /* encoder hardware mutex lock */
>         struct mutex enc_mutex;
>         struct mutex dev_mutex;
> -       struct mutex dev_ctx_lock;
> +       spinlock_t dev_ctx_lock;
>         struct workqueue_struct *encode_workqueue;
>
>         int enc_irq;
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c=
 b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> index 51bb7ee141b9..3c229b1f6b21 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
> @@ -45,16 +45,17 @@ static void handle_enc_encode_msg(struct venc_vpu_ins=
t *vpu, const void *data)
>  static bool vpu_enc_check_ap_inst(struct mtk_vcodec_enc_dev *enc_dev, st=
ruct venc_vpu_inst *vpu)
>  {
>         struct mtk_vcodec_enc_ctx *ctx;
> +       unsigned long flags;
>         int ret =3D false;
>
> -       mutex_lock(&enc_dev->dev_ctx_lock);
> +       spin_lock_irqsave(&enc_dev->dev_ctx_lock, flags);
>         list_for_each_entry(ctx, &enc_dev->ctx_list, list) {
>                 if (!IS_ERR_OR_NULL(ctx) && ctx->vpu_inst =3D=3D vpu) {
>                         ret =3D true;
>                         break;
>                 }
>         }
> -       mutex_unlock(&enc_dev->dev_ctx_lock);
> +       spin_unlock_irqrestore(&enc_dev->dev_ctx_lock, flags);
>
>         return ret;
>  }
> --
> 2.51.0.rc1.167.g924127e9c0-goog
>

