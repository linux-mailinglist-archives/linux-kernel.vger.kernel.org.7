Return-Path: <linux-kernel+bounces-762496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79EB2078A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF332A3067
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81EA2D190C;
	Mon, 11 Aug 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ku4G02qJ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006372D1301
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911457; cv=none; b=ZJtmURv4n4QY1ss4aRSCvZ8e7VH4lKpqMrecx3SMK6bVU2LZ6QskAfsHmlfrDj9qSivkx3sN+OtPtepK4xx3OfhRc1zJjqgvo8p//wAlYrvoeTcCq6E7EV4LTofEFaHfe7M3ktwyz8rJRUidIRyywZXg90hw6XqX5TBvPqbIDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911457; c=relaxed/simple;
	bh=PHwsYqPMe5lmjxOn4zXFfhjopKhCTRNe5UyB8PxQlJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axSvyA6Paz8tch3m0Eayv69yedW/CYD0lZrQeU4gM2GaH+n2L25/v3DuMSng7OsxMg+zrVBWRiPqAQoNuxd6VFaJV/LLY3iJ7Ecs4jR0D9uNEsCfFLI7lSrNfdH9GHCYQq5qWEs0CeFpKohPaC2pN2G4t+hCnNJMDiS5VaQTXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ku4G02qJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333be1f3f46so10808791fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754911453; x=1755516253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5GmgDRwLzjGy8dLnCeLiuAfeTbFgGKNWM+nzJ45dpA=;
        b=Ku4G02qJvE0Yng5xsA1avFYKHXf/CtLhSrKSNXm7sbF+SmM9oFUhrNGkkV8kT+8nKR
         zJ8IKy2Hsl35Zuq1Jw9uDF/sjuowewFqtVQ7gd5JJoobTA8NhN3btBHlZb2rMWYB8AFw
         HErTyGmkmv61xrx/ufVqYkXhA5UwiVN2LbKzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911453; x=1755516253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5GmgDRwLzjGy8dLnCeLiuAfeTbFgGKNWM+nzJ45dpA=;
        b=r2Rog6x2CtyXTermJ13hMb25MAVn8ZTrL0V+S7Pj5DIDwtFOIyqDxJiHB3ATupBvwe
         JKNSO6ej6Zj1OYyNt+XEBdJIvUJAoenUFFxEJN72qi5qtp9YEcuoF3h1+qmsqPMHLNj0
         vQgrFY3EOnAc/HpF3+iLybo+JnwvaTRCvTs32rsZ5mf4A2L4YS9cPSKpATtjxez+mXOf
         9E0rM7f62yGwV4HAMPJUn7kP1F001WEW01F41aIcqodvHFQd/7Udp++8s5rSFliw726S
         QmdWFl5rjdL7KFj5dt37MlmHDKBQKoQwl7xZIhQS9kMiyR2vV2Or2q735cMnVS3WuDro
         rfDw==
X-Forwarded-Encrypted: i=1; AJvYcCWtq6leAIhLVEM4Ipy1PfayswEoVlOxPRRZwsUbY9q1S2keN+jm/FsYfZtS/WdU2B8MlsMMfRB+Tbyrd0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOrVhjO2KEAou53AtPNQ+wr9egCfSiDzA2Icl7K2TioRMX7PM
	f6FvE03ukgqLz0hWFRAmqmEwMwG7yKamhf3X1ViBifQhv+orN7d1tK84V70/rsQZRvl2CE/1xJh
	Lc6PUU7uDht4Z4EEIv1DEVN+B7WXFHjVS/wsclT57
X-Gm-Gg: ASbGncuQgdSeaMW4jaackswklm+9AnmZ9Hsm5zFpU4Nr5kqIfmXn69BWiNJ3xN2FGx9
	XmMdOv0bvsaFO1SISp83fqelc8/BUGeq0W+e48OHJ8OizKBrNkjxw9ohWLF6X2vhot0Hupl1f/s
	XpC2C9dmKOygGU6OiPdRiF8CV8E+7hylxv74aBT8+uAAJ3Q7moDITTxYJrP2iXqv/rGoMI+VS40
	2YOZwJo/2q0Ed181aIYxM+By8S2r0tjNLs=
X-Google-Smtp-Source: AGHT+IFH1xwZU4h8r7iEY3jgrVBtJGh2oYXazOzDlq78D9uq3Av2ACb1cuu5hjNFbP0gck6r2pgb1pAL9b77iA9N8VY=
X-Received: by 2002:a05:6512:3b27:b0:55b:7cc9:41ee with SMTP id
 2adb3069b0e04-55cc0102717mr3789564e87.38.1754911452958; Mon, 11 Aug 2025
 04:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708111806.3992-1-darren.ye@mediatek.com> <20250708111806.3992-6-darren.ye@mediatek.com>
In-Reply-To: <20250708111806.3992-6-darren.ye@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 11 Aug 2025 19:24:02 +0800
X-Gm-Features: Ac12FXxeNaT3MP9n4wih87uuXFKen5GCnd1-R8Ou24yHeRKyjqsVqSE_BwKFLpA
Message-ID: <CAGXv+5HW1-GByx6BEd46J_n50FxcHNukUWwREpoDne=CdAnSVQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] ASoC: mediatek: mt8196: support I2S in platform driver
To: "Darren.Ye" <darren.ye@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for another reply, but I lost some of the context I wanted to reply t=
o.

On Tue, Jul 8, 2025 at 7:34=E2=80=AFPM Darren.Ye <darren.ye@mediatek.com> w=
rote:
>
> From: Darren Ye <darren.ye@mediatek.com>
>
> Add mt8196 I2S DAI driver support.
>
> Signed-off-by: Darren Ye <darren.ye@mediatek.com>
> ---
>  sound/soc/mediatek/mt8196/mt8196-dai-i2s.c | 3944 ++++++++++++++++++++
>  1 file changed, 3944 insertions(+)
>  create mode 100644 sound/soc/mediatek/mt8196/mt8196-dai-i2s.c
>
> diff --git a/sound/soc/mediatek/mt8196/mt8196-dai-i2s.c b/sound/soc/media=
tek/mt8196/mt8196-dai-i2s.c
> new file mode 100644
> index 000000000000..59f66ab8fa9f
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8196/mt8196-dai-i2s.c
> @@ -0,0 +1,3944 @@

[...]

> +static int mtk_afe_i2s_share_connect(struct snd_soc_dapm_widget *source,
> +                                    struct snd_soc_dapm_widget *sink)
> +{
> +       struct snd_soc_dapm_widget *w =3D sink;
> +       struct snd_soc_component *cmpnt =3D snd_soc_dapm_to_component(w->=
dapm);
> +       struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt)=
;
> +       struct mtk_afe_i2s_priv *i2s_priv;
> +       int ret =3D 0;
> +
> +       i2s_priv =3D get_i2s_priv_by_name(afe, sink->name);
> +

Drop empty line between assignment and check.

> +       if (!i2s_priv)
> +               return 0;
> +
> +       if (i2s_priv->share_i2s_id < 0)
> +               return 0;
> +
> +       ret =3D (i2s_priv->share_i2s_id =3D=3D get_i2s_id_by_name(afe, so=
urce->name)) ? 1 : 0;
> +
> +       return ret;

          return i2s_priv->share_i2s_id =3D=3D get_i2s_id_by_name(afe,
source->name);

bool casts to int implicitly in the same way you wrote explicitly.

> +}
> +
> +static int mtk_afe_i2s_hd_connect(struct snd_soc_dapm_widget *source,
> +                                 struct snd_soc_dapm_widget *sink)
> +{
> +       struct snd_soc_dapm_widget *w =3D sink;
> +       struct snd_soc_component *cmpnt =3D snd_soc_dapm_to_component(w->=
dapm);
> +       struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt)=
;
> +       struct mtk_afe_i2s_priv *i2s_priv;
> +       int i2s_num;

Rename to "src_i2s_num" to be explicit.

> +
> +       i2s_priv =3D get_i2s_priv_by_name(afe, sink->name);
> +

Drop empty line between assignment and check.

> +       if (!i2s_priv)
> +               return 0;
> +
> +       i2s_num =3D get_i2s_id_by_name(afe, source->name);
> +       if (get_i2s_id_by_name(afe, sink->name) =3D=3D i2s_num)

Use i2s_priv->id?

> +               return !mtk_is_i2s_low_power(i2s_num) ||
> +                      i2s_priv->low_jitter_en;
> +
> +       /* check if share i2s need hd en */
> +       if (i2s_priv->share_i2s_id < 0)
> +               return 0;
> +
> +       if (i2s_priv->share_i2s_id =3D=3D i2s_num)
> +               return !mtk_is_i2s_low_power(i2s_num) ||
> +                      i2s_priv->low_jitter_en;
> +
> +       return 0;
> +}
> +
> +static int mtk_afe_i2s_apll_connect(struct snd_soc_dapm_widget *source,
> +                                   struct snd_soc_dapm_widget *sink)
> +{
> +       struct snd_soc_dapm_widget *w =3D sink;
> +       struct snd_soc_component *cmpnt =3D snd_soc_dapm_to_component(w->=
dapm);
> +       struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt)=
;
> +       struct mtk_afe_i2s_priv *i2s_priv;
> +       int cur_apll;
> +       int i2s_need_apll;

Rename to needed_apll or desired_apll.

> +
> +       i2s_priv =3D get_i2s_priv_by_name(afe, w->name);
> +

Drop empty line between assignment and check.

> +       if (!i2s_priv)
> +               return 0;
> +
> +       /* which apll */
> +       cur_apll =3D mt8196_get_apll_by_name(afe, source->name);
> +
> +       /* choose APLL from i2s rate */
> +       i2s_need_apll =3D mt8196_get_apll_by_rate(afe, i2s_priv->rate);
> +
> +       return (i2s_need_apll =3D=3D cur_apll) ? 1 : 0;

          return i2s_need_apll =3D=3D cur_apll;

> +}
> +
> +static int mtk_afe_i2s_mclk_connect(struct snd_soc_dapm_widget *source,
> +                                   struct snd_soc_dapm_widget *sink)
> +{
> +       struct snd_soc_dapm_widget *w =3D sink;
> +       struct snd_soc_component *cmpnt =3D snd_soc_dapm_to_component(w->=
dapm);
> +       struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt)=
;
> +       struct mtk_afe_i2s_priv *i2s_priv;
> +
> +       i2s_priv =3D get_i2s_priv_by_name(afe, sink->name);
> +

Drop empty line between assignment and check.

> +       if (!i2s_priv)
> +               return 0;
> +
> +       if (get_i2s_id_by_name(afe, sink->name) =3D=3D

              i2s_priv->id =3D=3D ...

> +           get_i2s_id_by_name(afe, source->name))

Keep a copy of the result ...

> +               return (i2s_priv->mclk_rate > 0) ? 1 : 0;

                  return i2s_priv->mclk_rate > 0;

> +
> +       /* check if share i2s need mclk */
> +       if (i2s_priv->share_i2s_id < 0)
> +               return 0;
> +
> +       if (i2s_priv->share_i2s_id =3D=3D get_i2s_id_by_name(afe, source-=
>name))

and use it here, like in mtk_afe_i2s_hd_connect().

> +               return (i2s_priv->mclk_rate > 0) ? 1 : 0;

                  return i2s_priv->mclk_rate > 0;

> +       return 0;
> +}
> +
> +static int mtk_afe_mclk_apll_connect(struct snd_soc_dapm_widget *source,
> +                                    struct snd_soc_dapm_widget *sink)
> +{
> +       struct snd_soc_dapm_widget *w =3D sink;
> +       struct snd_soc_component *cmpnt =3D snd_soc_dapm_to_component(w->=
dapm);
> +       struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt)=
;
> +       struct mtk_afe_i2s_priv *i2s_priv;
> +       int cur_apll;
> +
> +       i2s_priv =3D get_i2s_priv_by_name(afe, w->name);
> +

Drop empty line between assignment and check.

> +       if (!i2s_priv)
> +               return 0;
> +
> +       /* which apll */
> +       cur_apll =3D mt8196_get_apll_by_name(afe, source->name);
> +
> +       return (i2s_priv->mclk_apll =3D=3D cur_apll) ? 1 : 0;

          return i2s_priv->mclk_apll =3D=3D cur_apll;

> +}

[...]

ChenYu

