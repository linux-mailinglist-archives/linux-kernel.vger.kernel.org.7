Return-Path: <linux-kernel+bounces-740399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28DB0D3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D83169104
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6B2DA765;
	Tue, 22 Jul 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B79FXuzW"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B522E611F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169901; cv=none; b=hpW4+jivOwNSJdRo3NMJ+ca3nQazNm6BiMw7Nx9VRnwryAvQjYG8IklDGd/4CTJ6k7I/w6ehJAQUcsA2r/Qoc/8mqoQPiRjILCufxqdU7bSrb2o6QC2a1Is5Nw3MUcrYww7u1epRl7MANJDYpaFRx4VqdGXZ+q/iMzfx+NXn6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169901; c=relaxed/simple;
	bh=GCED/hlCsBSaeWbx6CONP03k4BitQzfwd38u+tep5bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/+/TC0WePQty/99AMMWZOKZS/rI1LmY9C2ztfMN491RER7e5ViryEQT9jTYdRs0iN9626sQaFXHluZxraz4HkyayDYi+4xjbM3zZoNec8IHYuE4JWw00sp5YXHTnP9C6T5jCRia655XZH+Mv4gcWL1rh9tOZqkMH2BEROl7cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B79FXuzW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso55894541fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753169897; x=1753774697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1N+wgj9qJtb+bRk0/YzXSA+bhNFySP+cY66IIckDgM=;
        b=B79FXuzWRFyukO7ROF0wuBa1bIfITECa+33OFDXA8OdaAlIDbHvLn1mhnWGIzRBOni
         FDx3gqAa5fQtiUd8gi3blCz+PECxLQd4dxIOQ3CSMQoj1jo5GUsAnd8kcUOBvY6bzvA6
         ePEE6EJMm6orGKU4XXVGMkmcQIHZmGWRN8yro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169897; x=1753774697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1N+wgj9qJtb+bRk0/YzXSA+bhNFySP+cY66IIckDgM=;
        b=EzpogyHNJlaNKUswDcVKyDICxMRodUw7O72ayc7k5hBRorqeWnqRpGkiZuhxJp079/
         oL4DpM696oBQjIb9jC8oU5inhiNbEOpZrBEK5hX4OZ55aUZYbhmE7IAdvF02lJQHlcWo
         4C+TzxriGLmEeC6T4ym8rBllpUCd2oddAXJ65ovOBFgVe/WmzXO+KVHOV44LVlKs4qJe
         YppIkhTQIt1GMgkWzEgbdd4d89eOjag2G1662z42x0D23lTUnthzbmogXZnZbU5kJ9WC
         PWsu8OWF+jnsopKYhTH7RrdvKnIBByOQILOytfglS14dneYNz5tIZw/0XsJQzIVNyWxx
         eofw==
X-Forwarded-Encrypted: i=1; AJvYcCW3VVk9qJVTVInxxFdKZLgrSk2chb82wOK8mSu4XuZekhjt+/0+zttgr53CDDs1kirIyhESt83+ZvGvfxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOjJENlUhhkBEZv9X6ljBRkAfEGEXOZOPLhzF3aeYx1bLC4ea
	1JaSnKT6SO0BRJiKXdE7G7WXFz9GK16UXRCjlRyf9nqdN4g1dBcmcDVPw9acXgO5sFDal9FUs2A
	/7RsdYmVzVPrjIQMY4F9WupZBZ8rLOEILq825zBxo
X-Gm-Gg: ASbGncvERhbbQENx0+AZTlZIyzG2G8M1fWrTlhTTQk5KfSJNvWfG1Ds5IWdfcOQQo7N
	6f8Qi4OmvemjgGFcRVt/eolNhO0Mplh5Qflp6aHBjc0b4Nbw2NlD0VGAZ4age4iQ0PtsJxDGl6c
	X8yr8mjtIEUMPvIMHr1BeUXASio2OVfQRx8Z8y/Q6ASNWGGD3pBkmNuKbtIJcmFeR0JvrMx2MjZ
	0EQRAbC/MihlIXLgmOitgf5j5j3UvIoKGQ=
X-Google-Smtp-Source: AGHT+IHIEXGhSQKNLTR3joj0qjwcB1T77Dp8iSOMV7/+3N11OuF7i8eFvD4xY1tQQW+z6w+ni2WlHZTcDNTAtH00llM=
X-Received: by 2002:a2e:b8d1:0:b0:32a:e7b9:1dc9 with SMTP id
 38308e7fff4ca-330d24f7ef4mr6438751fa.3.1753169896490; Tue, 22 Jul 2025
 00:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708111806.3992-1-darren.ye@mediatek.com> <20250708111806.3992-2-darren.ye@mediatek.com>
In-Reply-To: <20250708111806.3992-2-darren.ye@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Jul 2025 15:38:05 +0800
X-Gm-Features: Ac12FXx-ybyxFVMO-dZm2uMvhIKao-9eybKP9nlbQtMW_02h967WNikXB-wqqjk
Message-ID: <CAGXv+5HQcGiUnsaOxHz86Y8JxUHh6e0ypusFEBLKchNx3fqKBA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] ASoC: mediatek: common: modify mtk afe platform
 driver for mt8196
To: "Darren.Ye" <darren.ye@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 8, 2025 at 7:33=E2=80=AFPM Darren.Ye <darren.ye@mediatek.com> w=
rote:
>
> From: Darren Ye <darren.ye@mediatek.com>
>
> Mofify the pcm pointer interface to support 64-bit address access.

  ^ Modify

And the subject should say the same, or shorter:

    Support 64-bit addresses in PCM pointer callback

> Signed-off-by: Darren Ye <darren.ye@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../mediatek/common/mtk-afe-platform-driver.c | 47 ++++++++++++-------
>  .../mediatek/common/mtk-afe-platform-driver.h |  2 +
>  2 files changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/=
soc/mediatek/common/mtk-afe-platform-driver.c
> index 70fd05d5ff48..cab4ef035199 100644
> --- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
> +++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
> @@ -86,29 +86,44 @@ snd_pcm_uframes_t mtk_afe_pcm_pointer(struct snd_soc_=
component *component,
>         const struct mtk_base_memif_data *memif_data =3D memif->data;
>         struct regmap *regmap =3D afe->regmap;
>         struct device *dev =3D afe->dev;
> -       int reg_ofs_base =3D memif_data->reg_ofs_base;
> -       int reg_ofs_cur =3D memif_data->reg_ofs_cur;
> -       unsigned int hw_ptr =3D 0, hw_base =3D 0;
> -       int ret, pcm_ptr_bytes;
> -
> -       ret =3D regmap_read(regmap, reg_ofs_cur, &hw_ptr);
> -       if (ret || hw_ptr =3D=3D 0) {
> -               dev_err(dev, "%s hw_ptr err\n", __func__);
> -               pcm_ptr_bytes =3D 0;
> +       unsigned int hw_ptr_lower32 =3D 0, hw_ptr_upper32 =3D 0;
> +       unsigned int hw_base_lower32 =3D 0, hw_base_upper32 =3D 0;
> +       unsigned long long hw_ptr =3D 0, hw_base =3D 0;
> +       int ret;
> +       unsigned long long pcm_ptr_bytes =3D 0;
> +
> +       ret =3D regmap_read(regmap, memif_data->reg_ofs_cur, &hw_ptr_lowe=
r32);
> +       if (ret || hw_ptr_lower32 =3D=3D 0) {

I'm not sure how the hardware is, but I think hw_ptr_lower32 =3D=3D 0
should no longer be a failure, since it could be 0x100000000 or
some other address with the lower 32-bits all zero. Instead the
check should be done once the addresses are put together.

> +               dev_err(dev, "%s hw_ptr_lower32 err\n", __func__);
>                 goto POINTER_RETURN_FRAMES;

This is out of scope, but maybe this should just return zero directly
to simplify reading.

>         }
>
> -       ret =3D regmap_read(regmap, reg_ofs_base, &hw_base);
> -       if (ret || hw_base =3D=3D 0) {
> -               dev_err(dev, "%s hw_ptr err\n", __func__);
> -               pcm_ptr_bytes =3D 0;
> -               goto POINTER_RETURN_FRAMES;
> +       if (memif_data->reg_ofs_cur_msb) {
> +               ret =3D regmap_read(regmap, memif_data->reg_ofs_cur_msb, =
&hw_ptr_upper32);
> +               if (ret) {
> +                       dev_err(dev, "%s hw_ptr_upper32 err\n", __func__)=
;
> +                       goto POINTER_RETURN_FRAMES;
> +               }
>         }
>
> -       pcm_ptr_bytes =3D hw_ptr - hw_base;
> +       ret =3D regmap_read(regmap, memif_data->reg_ofs_base, &hw_base_lo=
wer32);
> +       if (ret || hw_base_lower32 =3D=3D 0) {

Same here.

> +               dev_err(dev, "%s hw_base_lower32 err\n", __func__);
> +               goto POINTER_RETURN_FRAMES;
> +       }
> +       if (memif_data->reg_ofs_base_msb) {
> +               ret =3D regmap_read(regmap, memif_data->reg_ofs_base_msb,=
 &hw_base_upper32);
> +               if (ret) {
> +                       dev_err(dev, "%s hw_base_upper32 err\n", __func__=
);
> +                       goto POINTER_RETURN_FRAMES;
> +               }
> +       }
> +       hw_ptr =3D ((unsigned long long)hw_ptr_upper32 << 32) + hw_ptr_lo=
wer32;
> +       hw_base =3D ((unsigned long long)hw_base_upper32 << 32) + hw_base=
_lower32;

Instead the check should be here. And to follow the original logic,
if either pointer value is zero, the function should return zero here
directly.


ChenYu

>  POINTER_RETURN_FRAMES:
> -       return bytes_to_frames(substream->runtime, pcm_ptr_bytes);
> +       pcm_ptr_bytes =3D MTK_ALIGN_16BYTES(hw_ptr - hw_base);
> +       return bytes_to_frames(substream->runtime, (ssize_t)pcm_ptr_bytes=
);
>  }
>  EXPORT_SYMBOL_GPL(mtk_afe_pcm_pointer);
>
> diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.h b/sound/=
soc/mediatek/common/mtk-afe-platform-driver.h
> index fcc923b88f12..71070b26f8f8 100644
> --- a/sound/soc/mediatek/common/mtk-afe-platform-driver.h
> +++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.h
> @@ -12,6 +12,8 @@
>  #define AFE_PCM_NAME "mtk-afe-pcm"
>  extern const struct snd_soc_component_driver mtk_afe_pcm_platform;
>
> +#define MTK_ALIGN_16BYTES(x) ((x) & GENMASK_ULL(39, 4))
> +
>  struct mtk_base_afe;
>  struct snd_pcm;
>  struct snd_soc_component;
> --
> 2.45.2
>
>

