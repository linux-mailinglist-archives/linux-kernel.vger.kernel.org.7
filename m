Return-Path: <linux-kernel+bounces-766445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D3B246A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7893E3A8318
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1102E9EDB;
	Wed, 13 Aug 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNwN8S33"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B012C159E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079414; cv=none; b=kEBgQCFQcSGXMSpQccW6X0iA0Ce2Mw3hEsWmx8d94xQcgvoYXkE15+qerNR3iiowj1D1VtlioAMsg9wPsfHpVfA/RvaCpo2rLOI8D7XTG+Gxc+MsEYZ1jGmIOb50N80EKtIBkpmdqs/2kWuCDNDqksjEPdau9MasrNwDMVCPsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079414; c=relaxed/simple;
	bh=XJ18+y6IN20URNsWOGtZC0DCI/fLtzEWGfVrzsaSDwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN6fXXf57HT4hd/Rdm6rNuXbDAbuHCkAd0SSRJf6OHT0QQhd0FkYGnMb75iCgB5ECKDU/T+Wviy/gmrqy7JlXk75jI+3yb9kFh20ippq9WZuJIWCcZIjrn4fUHCVKxnEqxC7CF0Inoca/m/yjkkd5nFlhuUjLTRMYAUKkwGGoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BNwN8S33; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5392ba07940so4329451e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755079411; x=1755684211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpOqTr/H8i5iWZL4dLpviHUqjl+PiTBlvfyP9LcDKi4=;
        b=BNwN8S332Tz3rJyCoPUjkAaBdSocFVYsC5CMP1c/cRkir38iIYc+N1Kun6y9V2yCLJ
         MEARBqotFvSLoAwSvuXSpwi2A/TwMOVjjyjw7SLUqOHebkST5b0PoRem4Gm1zQFk26LX
         4YcDTLrdUDAVk3iWQr1sS3LiRGyFQysc1gmx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079411; x=1755684211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpOqTr/H8i5iWZL4dLpviHUqjl+PiTBlvfyP9LcDKi4=;
        b=Q61ndC9e3v8NOteNv/q1aEU4nh2odun2aAUW+G/0zjzEaWJeF0u4/HkYDzMWm5/lNd
         HkSghUkXdaQ/ddAGHHregwWbnS6ztqM8bgqZq9OQpHhOH8TkoSRco7hGNbFMzGUIyfVv
         69ZnmFDs5kIgdPx7u1am30KoZkXz8wyDZ3EfyuCqFhwr3MLOk67n0PuEE/NaT1sg+M87
         lTwZfBpb2y6G+3BDVtPxJksWJWfCEYWvyjw9kwORridsmVqHLq6/ZDI/R72nufO9/yLB
         +f7/T1M7BMh3pzJWbMN4lRqsJc5muTpkWGfHuiGdZJuxR8w9Ot11fDA5+YSqj2IUpw6w
         O5vA==
X-Forwarded-Encrypted: i=1; AJvYcCWegdi0XEt5UFfk5slT/Dx/kIWfzZ3VEpe8eZCshRYAnFxfCqeCOihx9D0lqcxl3btkvVJyq71W7guDaaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAh7Ktts1ah6DBuEPb/Q6kdFg23ZpOH7lW1zqfIZ1UR76o9Dc
	dqFuzKHvLRtwj7EGyHhfLI0BArqoKAt+/OV9o2MutIrSaeRa1yQZ47OUos4g1MsKZjVYGXTo+RN
	tJGw=
X-Gm-Gg: ASbGnctl9yy2AJdg8nkQpoXgQJm8uaEatJ44FUGz0iBxWi7rcEt8hiLUyYzqYSNHXTG
	a5SK/2BAR37Uc/AJiqBH2k4yzlXC5tOVLIonZ277MVwQBM5sSxBqPuSLNiu0LPSG3+9j5lx+ehs
	AHgVTgPFIMsIAlZMrz7lllBh+73i5p1BgEFmeRbi82heWyBoky5y1XoswDkhiVyxww6WJHBkbth
	gi94bVMIQtFU5yuC+vLfYVqAsMJJzufdMihBOX2RM7C2/jihbWxkKEodP+yPMefNdP5iBr4fUxK
	SpaWqWSKCRZTHRzQeM1pSistPue2djsf1H4wnC0bruc/Jk/iCxQrgxXzmyuEoP0HTPX3Ikpr1iC
	OcSn3xAuneC0Lrri/aMs2D30wErAynPcgq/yNtT9FfDRxHcDzUlcuKQ1dkw==
X-Google-Smtp-Source: AGHT+IE0CiNlGL0/XNGTefet+knKsTRR3JzNNCOHj1ndnjhG8OZbHIIIFojqhJC9O9emqO6UKt+9lw==
X-Received: by 2002:a05:6122:1acf:b0:539:5717:ecff with SMTP id 71dfb90a1353d-53b0b534218mr720495e0c.6.1755079411301;
        Wed, 13 Aug 2025 03:03:31 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b0189b3bsm3798078e0c.2.2025.08.13.03.03.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:03:30 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-88bc0cec30fso2915073241.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:03:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR/d0HPS+7KENDVwKPE/UttPUOwwTZiFLMJT/gJUBpGlBfYwzB1Lm0h4yAtWk9eurbqlJG/e8xph2+68I=@vger.kernel.org
X-Received: by 2002:a05:6102:580f:b0:4e5:c51b:ace4 with SMTP id
 ada2fe7eead31-50e5069ec3dmr831455137.20.1755079409916; Wed, 13 Aug 2025
 03:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812085902.3309160-1-wenst@chromium.org>
In-Reply-To: <20250812085902.3309160-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 13 Aug 2025 18:02:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhG_ExACJRpJoqmO7nn+P24uiaha21SFEyR3aoKL-Pjgw@mail.gmail.com>
X-Gm-Features: Ac12FXxcH53--yUF4XiZyOJVA9MjGchb9U9zLHe6JnSsrI_-dNHmZMaj3Vdi_pE
Message-ID: <CAC=S1nhG_ExACJRpJoqmO7nn+P24uiaha21SFEyR3aoKL-Pjgw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188-geralt: Enable first SCP core
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:39=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The first SCP core is used to drive the video decoder and encoders.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8188-geralt.dtsi
> index c5254ae0bb99..10764786bc21 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> @@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
>                 #size-cells =3D <2>;
>                 ranges;
>
> +               scp_mem_reserved: memory@50000000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0 0x50000000 0 0x800000>;
> +                       no-map;
> +               };
> +
>                 apu_mem: memory@55000000 {
>                         compatible =3D "shared-dma-pool";
>                         reg =3D <0 0x55000000 0 0x1400000>;
> @@ -1146,6 +1152,16 @@ &postmask0_out {
>         remote-endpoint =3D <&dither0_in>;
>  };
>
> +&scp_cluster {
> +       status =3D "okay";
> +};
> +
> +&scp_c0 {
> +       firmware-name =3D "mediatek/mt8188/scp.img";
> +       memory-region =3D <&scp_mem_reserved>;

It looks like a pinctrl for SCP_VREQ_VAO (GPIO 98) is missing?
Datasheet says it's for "SCP to PMIC normal voltage request", and
MT8195 and MT8192 also have that configured.

Regards,
Fei

> +       status =3D "okay";
> +};
> +
>  &sound {
>         pinctrl-names =3D "aud_etdm_hp_on", "aud_etdm_hp_off",
>                         "aud_etdm_spk_on", "aud_etdm_spk_off",
> --
> 2.51.0.rc0.215.g125493bb4a-goog
>
>

