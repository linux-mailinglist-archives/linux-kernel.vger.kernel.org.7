Return-Path: <linux-kernel+bounces-829101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6CB96498
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2203BB2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15C23AB94;
	Tue, 23 Sep 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHxBtCsi"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598321B9CD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637493; cv=none; b=IKwzeKP6cmEXpv3vdTsVj6+wdowhaQRRDwRqIlU01ITqHFyvQOwQktJSikfPjcOQDluPPXmsHI0mhF6DSU1qA4KZUYDO7FCRUDzXjAHnZAmbGIYRUbIryYtR/ufYa2YxIlg2oyNgXtxMsygjyFe1Tw7QuzxnuS2gxKvWszp4Lsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637493; c=relaxed/simple;
	bh=eWihz0z0JIQWHYGwcOUGrAJbU4ImufZBgs86/4aLMoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrQUbLmzvTfJDDaibXjZBLrouv87IwgxbM6QV5X4vrQAaqNI5jRgWPAoq4AJzZf4K+PAChPd0J6zDadNdaJEEPuEbMn2z1Ul1zDRaaeJ7PyVjLNlIUWJoyJFveR7YsgalBziV5Dr2BRRpNmXXkhNx0TrwNxtqYLcA6ppstiNNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHxBtCsi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so49198647b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758637489; x=1759242289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=pHxBtCsiBu6wl15vhgceu5NmjwRm+WSuT4nmlU5xbJbgXM1CC+V7h0looIg2TWOXi2
         OWbJKH1lsLgMoGVbgtowHpn3x5VR9zXRAapC47D4/fspdZm2gIhOVgcI6ZKlS8M8k9X3
         VB/82nY+g6zZu6cl7Th7tFTxCw5fq8fUZbrG9PdIl1xYFyWTVyijyjYlo0AMV4OQvmXM
         a60l/I7BMwPBgKOdDQTAhP7YZi42jfEgLQ/xbu1cWGA5vEWDiwl3n+reIX5MbaB8Re/k
         kzPhghDlKOruwJvtm0xM4q5U8imEjK+Mq7gpxqKfmnNG6ugZJrJ8zItWjQFI38DShext
         h+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637489; x=1759242289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tUpBb6qulXCWAadHVOQRFgdDFu6TKGouRDpRCguBiA=;
        b=otxcYzQu4g+L4KFZgJ/sy6wGz6xD4TlXiibWruUVpbPd7BYEAPLUPcGcWDjQevM85l
         FbFPOrgHGJ2m2OpHG356EphEBzlJTUCqjf/HKs1Q0DyHnEatDlMaKL8BCpOoT/4N20Pz
         kaDzJLJEcWlyky/kaMHlVT9ligN/KlX5jOl0vlnkHR5+IOqT7d7gltQ0cz3rwd+9NRa8
         ZAZRScjB0R+gq0HtnXNi+3cFbr6ySVyzV9sKcL4ZhujITwxqHgVY6j/3ewj1PDBLkIsD
         5d2KiAND7PFO3E0EA4YNsl5FA123Ao4K87ihyn7PpLZgMqHiSSiVfVoKEhiYNwvItv5g
         sxyw==
X-Forwarded-Encrypted: i=1; AJvYcCURBs3lxje6TqsJMX+WvLV/p9aAkHv/RZQFyPvjLsA6kAwHJXsypNqFk5aocGZDA1S2lJVWzJpGqwP0aQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7Ew6WrNqLtaMQQRIHGD8LdQ6Vs2he5T/XKbgEsVN6p+r9JJ6
	PO8+cm05C+jaZCrjUvvVrNrNLV0VxdcLka2Eg0P7gABGyGeZTfJOjisVLp+8ACF/VI7epyPFY9+
	05YhT0k9yScstelivO25e2Q6r4QPJsmfazlXv6iPLjQ==
X-Gm-Gg: ASbGnctpnb1OpTOVpOBo4WqEQyFCFUOE/Cjvv7RbI7QrtlkCP+37OWLUnChlpj3xZR4
	6OliHmAW6gVV7in0PxEyipfh10eniJhpsU8fDpoHi+3hDFIZVefcrffCKw6ttgpG5DpLLocw7D1
	leZ9muvmWdLauRvHxsm3zZkI4SONeTNUAyJH7NYbQoebLChsILuIgDMSzBQr3XD/LsP+CXjsfOj
	OzXAkBdKTaIdzjP2S4=
X-Google-Smtp-Source: AGHT+IF1FCtcjMSOAGh57xMvLkahzg1nEGPiVoAht6L/S8rmvuZxjp7LQD0zrTATTe5JO0aUrJTq9dOrEPI1k3shK8c=
X-Received: by 2002:a05:690c:5511:20b0:720:5fbc:20c2 with SMTP id
 00721157ae682-758a5393f77mr18808297b3.36.1758637489554; Tue, 23 Sep 2025
 07:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com> <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
In-Reply-To: <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 16:24:13 +0200
X-Gm-Features: AS18NWC-sVzrTkGqH5gpcO5QSqPC0ul4k36msuT8kehXNT5ngXXnGDzn6xEf6ew
Message-ID: <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 13:41, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Various MediaTek SoCs use GPU integration silicon named "MFlexGraphics"
> by MediaTek. On the MT8196 and MT6991 SoCs, interacting with this
> integration silicon is required to power on the GPU.
>
> This glue silicon is in the form of an embedded microcontroller running
> special-purpose firmware, which autonomously adjusts clocks and
> regulators.
>
> Implement a driver, modelled as a pmdomain driver with a
> set_performance_state operation, to support these SoCs.
>
> The driver also exposes the actual achieved clock rate, as read back
> from the MCU, as common clock framework clocks, by acting as a clock
> provider as well.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/mediatek/Kconfig            |  16 +
>  drivers/pmdomain/mediatek/Makefile           |   1 +
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 928 +++++++++++++++++++++++++++
>  3 files changed, 945 insertions(+)

[...]

> +
> +static int mtk_mfg_set_performance(struct generic_pm_domain *pd,
> +                                  unsigned int state)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +
> +       /*
> +        * Occasionally, we're asked to set OPPs when we're off. This will fail,
> +        * so don't do it at all. We do foo != GENPD_STATE_ON instead of !foo
> +        * as to not depend on the actual value of the enum.
> +        */
> +       if (mfg->pd.status != GENPD_STATE_ON)
> +               return 0;

Returning 0 here, means that we may end up never restoring the
performance state for a device and its genpd, when the device is
getting runtime resumed. In genpd_runtime_resume() we are calling
genpd_restore_performance_state() before calling genpd_power_on().
This is deliberate, see commit ae8ac19655e0.

That said, I think we need to manage the restore in the ->power_on()
callback. In principle, it means we should call
mtk_mfg_set_oppidx(mfg, genpd->performance_state) from there.

> +
> +       return mtk_mfg_set_oppidx(mfg, state);
> +}
> +
> +static int mtk_mfg_power_on(struct generic_pm_domain *pd)
> +{
> +       struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
> +       int ret;
> +
> +       ret = regulator_bulk_enable(mfg->variant->num_regulators,
> +                                   mfg->gpu_regs);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(mfg->clk_eb);
> +       if (ret)
> +               goto err_disable_regulators;
> +
> +       ret = clk_bulk_prepare_enable(mfg->variant->num_clks, mfg->gpu_clks);
> +       if (ret)
> +               goto err_disable_eb_clk;
> +
> +       ret = mtk_mfg_eb_on(mfg);
> +       if (ret)
> +               goto err_disable_clks;
> +
> +       ret = mtk_mfg_power_control(mfg, true);
> +       if (ret)
> +               goto err_eb_off;
> +
> +       return 0;
> +
> +err_eb_off:
> +       mtk_mfg_eb_off(mfg);
> +err_disable_clks:
> +       clk_bulk_disable_unprepare(mfg->variant->num_clks, mfg->gpu_clks);
> +err_disable_eb_clk:
> +       clk_disable_unprepare(mfg->clk_eb);
> +err_disable_regulators:
> +       regulator_bulk_disable(mfg->variant->num_regulators, mfg->gpu_regs);
> +
> +       return ret;
> +}

[...]

Note, I intend to have a bit closer look at this soon, but I just
observed the issue I pointed out above from my first quick look.

Kind regards
Uffe

