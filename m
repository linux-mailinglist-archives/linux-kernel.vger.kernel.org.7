Return-Path: <linux-kernel+bounces-750353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC6EB15A82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D1617AFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE35325DB1A;
	Wed, 30 Jul 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iAHVEGI5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1023255F2F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863824; cv=none; b=oh9FSPqfoMx1WxlcVXQfqJYQkkRTDximQubgS63TxMyAZlXY0NAhrrgJ59jJPN55tREPTJ+YrHkyEnhAAYgE3eYiQ8wr6AmiEOJ/ZbqPOn63psoItTJPo2PRq3bmEANHTBw0jsLQDtJ4ogpolgLQ8/yHZ0IsY/hOgAazaiHL4co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863824; c=relaxed/simple;
	bh=k0n3laGySUj8A81/FGX/9rlSYF4U3v2+KxowMb3vRYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qErbDfe+R/DJwsfnKQixD9f++tRYKvAhCZgShQAY++h5QCQ2q4rfIrdu0sFxkTep5yg1EtQ27KVdHbLwzOC3MlP0RSrNMAA33Q25nDkSI8emRl+fD5NWN49nFVOj171GVfcf7c4eHKm0+qk9Z5yd5/Hgt7RRprrr9IrpYDX4hW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iAHVEGI5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55a25635385so7112595e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753863821; x=1754468621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1r2R6OONrqy2phTDjM24jkvudNKHdg6QD1pSz1RSbE=;
        b=iAHVEGI5T+Vg4X9WePWAFyZNJudEsM/U61+3V2HQE4on3oUfPNjXqtP6MGs6lA7Y9S
         bdaAricCtJ5f7iPXDPNZycAS4SgvaNvSjjgdgVITTBwDjaN6E6xD6myvazovIKFqC9C9
         h7bq/Kkez3MGYV7GsjOP/Ra/MSyIQXAuFRJG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753863821; x=1754468621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1r2R6OONrqy2phTDjM24jkvudNKHdg6QD1pSz1RSbE=;
        b=wuIsbh8ObEoqWDCtYXgn3LseQMf2boTwWrCvA61hyjqsq+LsX6RejILaQNjr4xKo8q
         eygPiaY79pBgCRgN6DVbLOoSwC6QcsznoJSPA6b86T7U5lEa1b/mrxa/IokbFpCarlme
         c5EtzEh2oq7TkZqIg6BaPlGTgfuLqGo7jmT4qLb0zTpV9Ppn0ep4ELh+MSHcc8xiOcPO
         5EWYSxam5/HxurMa8GXVbwnPAfZIIE30VjpGymK/PFq4/BhAiIE8U6gkXZtkLJEjjXw2
         Cd8kI4kimHJbsnshyWPloB4jPSIgd0F6RyefBGgCknq1o+MZ12EGZRA+7dTMwrTQE7Te
         tcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXxRUdu4Fz82+mVWzaOqcOEQ4UKzSjZ8T9UCt0+pDrt9FjBe/dnZETYW2SFjBvqCB8SUMARPrP2JvCn4ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9G7yk4nKdUJ09L20cvi/OdSbGAr58U0/TfVKX6ddaGLvbxrkh
	ZY9SLy0LHNhF9zLm3AxTTlhlhP9sxDf/W+UmpmFsM9aX2FGzYC/FoIfrOSbcvTFZ8fQKcWYfEsJ
	zwCywEcY1pEk2K4tVU6aM1R0Av2SBW+j3YlmXAEeT
X-Gm-Gg: ASbGncsQY0aA+1AzTk4s7BI1oX7qH4bVR7kJcEiQCMmSpTnd2rYsFvcgz7Tg+FfKqKL
	Y1Pt/Xa2T60LMHt3160c86/EkVybDhEksRsOJ5uaWDVgrXnfwy5PLO9COMstZ8gf7r7bvraY7x1
	9FFtPhwAjTYdG3kc3w0ZgcZylooaVKX2ms1kAFCQI9F91JtV2ISZMYV33AxbwqS887SBpVwMy+/
	tXkYg6sZACH3kLOlG2gLavP2CRl6W1ZztE=
X-Google-Smtp-Source: AGHT+IFNNgGe2N+Najma2XgK1xBeO1Tq5z4VdOwxsWj1JkHm5nTTq++sDH5npr//Xe7MrxeLpTLuyirVohv+SG9hXog=
X-Received: by 2002:a05:6512:3a81:b0:553:65bc:4232 with SMTP id
 2adb3069b0e04-55b7c06cb83mr858483e87.31.1753863820791; Wed, 30 Jul 2025
 01:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708111806.3992-1-darren.ye@mediatek.com> <20250708111806.3992-3-darren.ye@mediatek.com>
In-Reply-To: <20250708111806.3992-3-darren.ye@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 30 Jul 2025 16:23:29 +0800
X-Gm-Features: Ac12FXziz9m63a9IuaHiHsS0x7hGxpkPqvcMpJ0GxNVtaytZnTnRhyBsZaU2UF8
Message-ID: <CAGXv+5FiZJqymDfvGO05SNgzSUYAdOwtFCqE0WPGwC5Dwg7OEA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] ASoC: mediatek: mt8196: add common header
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

On Tue, Jul 8, 2025 at 7:34=E2=80=AFPM Darren.Ye <darren.ye@mediatek.com> w=
rote:
>
> From: Darren Ye <darren.ye@mediatek.com>
>
> Add header files for register definitions and structures.
>
> Signed-off-by: Darren Ye <darren.ye@mediatek.com>
> ---
>  sound/soc/mediatek/mt8196/mt8196-afe-common.h |   213 +
>  .../mediatek/mt8196/mt8196-interconnection.h  |   121 +
>  sound/soc/mediatek/mt8196/mt8196-reg.h        | 12068 ++++++++++++++++
>  3 files changed, 12402 insertions(+)
>  create mode 100644 sound/soc/mediatek/mt8196/mt8196-afe-common.h
>  create mode 100644 sound/soc/mediatek/mt8196/mt8196-interconnection.h
>  create mode 100644 sound/soc/mediatek/mt8196/mt8196-reg.h
>
> diff --git a/sound/soc/mediatek/mt8196/mt8196-afe-common.h b/sound/soc/me=
diatek/mt8196/mt8196-afe-common.h
> new file mode 100644
> index 000000000000..574003a8a2e4
> --- /dev/null
> +++ b/sound/soc/mediatek/mt8196/mt8196-afe-common.h
> @@ -0,0 +1,213 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * mt8196-afe-common.h  --  Mediatek 8196 audio driver definitions
> + *
> + * Copyright (c) 2024 MediaTek Inc.
> + *  Author: Darren Ye <darren.ye@mediatek.com>
> + */
> +
> +#ifndef _MT_8196_AFE_COMMON_H_
> +#define _MT_8196_AFE_COMMON_H_

Add an empty line here for separation.

> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <linux/clk.h>
> +#include <linux/list.h>
> +#include <linux/regmap.h>
> +#include "mt8196-reg.h"
> +#include "mtk-base-afe.h"

Please add empty lines between each group of headers. Headers are grouped
by path prefix.

Moreover, the contents of these header files are not required in this
header file. Please push these include statements to the files that
actually need them.

For the pointer to struct types, you can just forward declare the struct
types instead of including the whole header file:

    struct clk;
    struct mtk_base_afe;

[...]

> +struct mt8196_afe_private {
> +       struct clk **clk;

> +       struct clk_lookup **lookup;

This doesn't seem to be used.

> +       struct regmap *vlp_ck;

IIRC this will get removed since the tuner values will be moved to the
clk driver.

> +       int irq_cnt[MT8196_MEMIF_NUM];

> +       int dram_resource_counter;

This seems unused. Please remove.

> +
> +       /* xrun assert */
> +       int xrun_assert[MT8196_MEMIF_NUM];

This doesn't seem to do anything. It is initialized to zero and then
never used.

> +
> +       /* dai */
> +       void *dai_priv[MT8196_DAI_NUM];
> +
> +       /* mck */
> +       int mck_rate[MT8196_MCK_NUM];
> +
> +       /* channel merge */
> +       unsigned int cm_rate[CM_NUM];
> +       unsigned int cm_channels;
> +};
> +
> +int mt8196_dai_adda_register(struct mtk_base_afe *afe);
> +int mt8196_dai_i2s_register(struct mtk_base_afe *afe);
> +int mt8196_dai_tdm_register(struct mtk_base_afe *afe);
> +int mt8196_dai_set_priv(struct mtk_base_afe *afe, int id,
> +                       int priv_size, const void *priv_data);

Please add an empty line here.

> +#endif

[...]


ChenYu

