Return-Path: <linux-kernel+bounces-870794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC3C0BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDB764E4E65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6C2D23B9;
	Mon, 27 Oct 2025 02:45:09 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0829D269
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533109; cv=none; b=R6MDtUoazsvzZPuNsHbpQ4cSFnAl+LjzrGNDKwZs24Kb2gajpU3K9cnvwrMsVNKgDZjqW/Qq+W2rDjgP2KV9NMU70YEz1PmiaZeFYfKKwAHQnZOfx1jdUDPElfTSALbt7O0QYh8EsBhrZZE2BCoAqiSie+Kg3UzMj5jkof3nshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533109; c=relaxed/simple;
	bh=evQekrEcmyRdqKp1jJZClGlbzLxhN98LFdFpjeGdBkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJIhY1Be5l8VN0Mq/xSmjR/FHpRcfaNkscR68tJyPpw8dQJgbTS+kmjqRW9/sdnKQWl889RQ0MD4DbvS7QjMhFQnzhZTmNngdY9ARKDn7LXTHEbakqxXcbxKnV25qkmlSMs8V1Qk0/tBYRx47oSm8Q8/G0owE293YZZo7pk5lSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso541435166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761533105; x=1762137905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0xO3eccx9J1JFeRrYmbh54SIcFbkNO2ChisP5DHSmA=;
        b=dmUQn5HDb5/3Z5OcMXzoCIFxIWqbtBsszQqholU7kZJhSdZJqSQWwNYSz71J8FaqBZ
         Ld0mstT3ae0HQCXSw6tqQ769t2yAmr548O0/0S55pIifbsoODbOFNNSHnwMNx27hYAbf
         /4V2r7OneclyPQZuOOdQriFeZksdWwIHeUm4HOPkTxbz6aDymUpDiAAeV9HedQK09d+T
         X21aUoSeCTEiveyXnMSDIFNjYnzCC0lD+SfH+P8tP1gnDPnWpm42vBgceuKXrBJE6chF
         Xbs3BYqBskzE79jQ5ZPmYSCoxx48zQV4WnROf5d9j/JtIIOxgX8KtCUstzkCzXNpTHlK
         3YPA==
X-Forwarded-Encrypted: i=1; AJvYcCWUCKjsJnVmp8EyIYZ4YL8HlT5y7/evCbxxVFU1oMmjZhxjEWdEm/5HMxfCJ9M3yDGYg7IKY/MncGhbeCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH16JA1A0lsBzKbMk8TDkUyGTVC08GgZGAeVzeAAPhSAOKczfy
	Q7PEey8D+5lJ7eNW8taHDyfl8k7lRw2A+86Z70MI+4xmjcdG89ek0pTAcoQoF2nkN+0=
X-Gm-Gg: ASbGncsS4it8U4F/a40fh+e9DCDOcrjdtIs6BsunLO/aAc6VofiPvEIhuVdDXGAHL78
	9VdwSryk9/vvRwnU+I+4OjWPKunaQpApwD14ZofT7QMlOA1thCS+a/0GyyHhQ1XboMC+ZtzEm8U
	SCdA6R0uMCRyxxydvVyPdN7sgctIsWKtJ+LBHmhN404c/vfAsNn3H09Gj9x8k3l0WfjX9EHHGY1
	J+owiyRkfn6T7s9a2Nfbul6iTVHtilPZKYpPoKhOH9Uowh66+brMrt1TtT6GMaVIOVZoFfwcuXX
	HOzlzhOXZZnnevmAMU+/c9iLp/z1deoAew5FTOIZBP7nI2g3W0cGi3gPtEHDAEVGNn+gPLbkW+V
	OHlxAwhft3EM5tOsO15vQrsOoSJzlzdZzCKM8TsoVftiLGM0a8Imi+xT/jJpXm2Jn5gyhXOmJ1f
	5eThzMo0SLaWUMm8DO77T0v8MasxrM
X-Google-Smtp-Source: AGHT+IE3VUoW61iXn8pnb460XYYhphD8GasrzstJeoGmQw5E/ymzVAhhORTr+lMOQALPwCQBzX3DmA==
X-Received: by 2002:a17:907:9690:b0:b46:8bad:6970 with SMTP id a640c23a62f3a-b6d51c05e68mr1404917966b.36.1761533104444;
        Sun, 26 Oct 2025 19:45:04 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853d80ecsm616643166b.43.2025.10.26.19.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 19:45:04 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4539dddd99so885481966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:45:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQZD5VJ1d7rerYaILB5XzjtwsIXSiqdwUImjH3opOy2LQDgSNuaQbSBeKC1XD2RpROEPgqM9JaNkyc7EY=@vger.kernel.org
X-Received: by 2002:a05:651c:1509:b0:376:2802:84a8 with SMTP id
 38308e7fff4ca-378d6f87cf1mr39477651fa.46.1761532753914; Sun, 26 Oct 2025
 19:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025043129.160454-1-iuncuim@gmail.com> <20251025043129.160454-3-iuncuim@gmail.com>
In-Reply-To: <20251025043129.160454-3-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 27 Oct 2025 10:39:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v656qzX3YrcuTt++=-r5JCyDKgGB8NYTAM3TpyRtAwdibw@mail.gmail.com>
X-Gm-Features: AWmQ_bltF2M2RvHvljsl22XgW5kEnSwcYVFG9c-kdXV1SwRk_st0sy4RKS89u_w
Message-ID: <CAGb2v656qzX3YrcuTt++=-r5JCyDKgGB8NYTAM3TpyRtAwdibw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] thermal/drivers/sun8i: add gpadc clock
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andre Przywara <andre.przywara@arm.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 12:32=E2=80=AFPM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> Some processors (e.g. Allwinner A523) require GPADC clocking activation f=
or
> temperature sensors to work. So let's add support for enabling it.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/thermal/sun8i_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index 226747906..c02c398b0 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -66,6 +66,7 @@ struct tsensor {
>  };
>
>  struct ths_thermal_chip {
> +       bool            has_gpadc_clk;
>         bool            has_mod_clk;
>         bool            has_bus_clk_reset;
>         bool            needs_sram;

We could optimize this using bit fields instead. This can be done in a late=
r
patch if you want to do it.


ChenYu

> @@ -89,6 +90,7 @@ struct ths_device {
>         struct regmap_field                     *sram_regmap_field;
>         struct reset_control                    *reset;
>         struct clk                              *bus_clk;
> +       struct clk                              *gpadc_clk;
>         struct clk                              *mod_clk;
>         struct tsensor                          sensor[MAX_SENSOR_NUM];
>  };
> @@ -417,6 +419,12 @@ static int sun8i_ths_resource_init(struct ths_device=
 *tmdev)
>         if (ret)
>                 return ret;
>
> +       if (tmdev->chip->has_gpadc_clk) {
> +               tmdev->gpadc_clk =3D devm_clk_get_enabled(&pdev->dev, "gp=
adc");
> +               if (IS_ERR(tmdev->gpadc_clk))
> +                       return PTR_ERR(tmdev->gpadc_clk);
> +       }
> +
>         if (tmdev->chip->needs_sram) {
>                 struct regmap *regmap;
>
> --
> 2.51.0
>
>

