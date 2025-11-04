Return-Path: <linux-kernel+bounces-884035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E584C2F2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373263B56A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417B283CA3;
	Tue,  4 Nov 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYMTBaDx"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E334D3B6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762227081; cv=none; b=GjIn3alKbjbBRvc+qTk7KtGyZB/NbDH47CBEJKerGB71wJGCbGwlfDLAvhf8U6dpWdKab4br4p3PjXwH3rrPnWx3RuJxTwVci55QUvE+PocU0iAiQ0SdhiuxlWotnXYxiPxVuywb/q+LYSS+CEd3un5G1TJB+VqThMqnHo72970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762227081; c=relaxed/simple;
	bh=E5oPfom5n1Q1r5cLmav2D/FmZLVsT9ghG541RwhFAOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSdNuhDQZx2iXlH8HOkUl7DrnXaAQoXD1ohI3NIJW7RbQ0s6ju7u3psGDBHwOPwutolsPcEG1GFOViIO0ZTgTtw5FdTF/vMr/8TWUaSL6iOom5fRpt8Kw+oeziyRw38XnfoIauwRNaHBcmtAT0iWZsw58cTsHmwjD8mKMXK/6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YYMTBaDx; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559748bcf99so721323e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762227077; x=1762831877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52u3ce68a/2VewtwVxA8vPC3R1+VyiePk3LEPb1Gvvk=;
        b=YYMTBaDxm0ZBQMk5kOkwkueXTtiW0MlCCOg1QFNDn45ZXTpMhoAFcRovE470aB9gJc
         G24r6bz5dEdWk3IrdO29QLae3nnVydB/aza+v1o1XV6/XmnkzL0F5CZ2S98qK8hT0E9R
         WOBtHTUd3OJCmMrmN6te1m4Mw3z5A2bPP41uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762227077; x=1762831877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52u3ce68a/2VewtwVxA8vPC3R1+VyiePk3LEPb1Gvvk=;
        b=Ol6jXEA3xArVAqAvYdQH5P48kTzCdAPtADoziJBMLZZ1jy3gnPKAO2rZu7anpTrRby
         Gww/iltdjr+oF56dtYPhLgJqkXpgOXtw17wX6eg8f0+tQavOtk/fFzrqZKL7uJvYvaLF
         /OJkpaJmonpe3NF1f7yVH7WmmuvO8SOQnmHwKkJf2Xte23rVpNv8ogl6p9+v+xt/kQNJ
         fBIbOXjQdh5fUCsVehExYcownadtSHmUvmidNHH6bDI/PRx5IzGsbzSQriETvzh4vqfc
         YcXMesmyH3gDFGTyHU78BiWNCVC29OnUyidk+q4/QUmPZTITNcSUE95bPlW2FG7/o/iS
         u9CA==
X-Forwarded-Encrypted: i=1; AJvYcCUFH/E4Va8BuN+DoeWH9KWzlhi3g0l6PvHqrc6Y35BXi0tV6agVTksJ8lO6St+mpKOU/MuJRZm3nwZt64A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgERA7UxidLkskMr0O79cfEjLEPNsyzXGuWqzKJreJEWrFhMjz
	r4y3ksqyx2ejZrmWAj9WXG6vvVfzf30GhwqQvRiE7WUZF12hNr4YKcZTAK8UPY1MR4sclQiRUXe
	TfDI=
X-Gm-Gg: ASbGnctLc/tLb9NsnC/DHYdIXRioT0lADaGCRuqWsjbzOHPh7o/rOPUH85EoUP7MGNn
	3BlQFdOnGmJZfEhdSUTXC0B0NWwHLMLN6PiPyko6FkROsoDwJ0DM8NH1b359KEPVHzUBO/DigTg
	V3a0eGNIoQdZdXcVWpXzBoTQdpMeUaafivCXlnr+sHXgrafnUXzlBuJ2yCGTfdWKTJrHCvTi6Z7
	KghNxfs4aYbDxi6LMoSVhKn8CaaWUSgJfpfPR7QmB8pxsFOIg9s5kswNdO9Yfji19OFD0bn+R1y
	IjZZKwxAN93U/NOQCYijw/8C7clzXE0Pa/wKzAzo9QfdAUlCeathtCgNBtqNPYLo48LZnNT3ruo
	w/bj7lXizjg17fUY2UEpy8tXJxf+c/y29tgdCZqXPgFg44D3re3z/ZOeL+ddEGk7kRQ/3uMkdEo
	Pzq9LFDuuMPsHihcAPJ4AOxzzo2Pl6krDziG/r2sk=
X-Google-Smtp-Source: AGHT+IGYpojXcpnx61D0ykgKQgTYoA6YrqRop6CpHZHs7cjPbJsZmZaLbagtFrJ6/FlDUODstT8q/A==
X-Received: by 2002:a05:6102:94d:b0:5db:cf38:f4f4 with SMTP id ada2fe7eead31-5dbcf38fa6amr2885348137.33.1762227077641;
        Mon, 03 Nov 2025 19:31:17 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf3104252sm751482137.5.2025.11.03.19.31.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 19:31:17 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-559748bcf99so721309e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:31:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBL7Hg8TRE444xZZHxvUv8gJLJ8pTRlS/89jASfChK9lJo/2ufCZl2gBgea5vQ0frfdkp2c7347fpo6Dc=@vger.kernel.org
X-Received: by 2002:a05:6102:3592:b0:5db:cc25:dd7a with SMTP id
 ada2fe7eead31-5dbcc25e19emr3043231137.28.1762227076683; Mon, 03 Nov 2025
 19:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104031533.9419-1-Niklaus.Liu@mediatek.com> <20251104031533.9419-2-Niklaus.Liu@mediatek.com>
In-Reply-To: <20251104031533.9419-2-Niklaus.Liu@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 4 Nov 2025 11:30:40 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngxeeV9m+5Yv0YNGWdbD0eVQisSr7k+nsxieok_7jKp=A@mail.gmail.com>
X-Gm-Features: AWmQ_bmOhDmgmGrSBNtj0-kgZvqxGdX1GAYzQFFwyDNQ0HSH4haoGBpnhf8glsQ
Message-ID: <CAC=S1ngxeeV9m+5Yv0YNGWdbD0eVQisSr7k+nsxieok_7jKp=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] soc: mediatek: mtk-regulator-coupler: Add support for MT8189
To: "niklaus.liu" <Niklaus.Liu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com, 
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, zhigang.qin@mediatek.com, 
	sen.chu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:15=E2=80=AFAM niklaus.liu <Niklaus.Liu@mediatek.c=
om> wrote:
>
> From: Niklaus Liu <niklaus.liu@mediatek.com>
>
> Enhance the regulator coupler driver to support GPU power control on the
> MediaTek MT8189 platform. This update ensures proper coordination of
> multiple regulators required for GPU operation,improving power management
> and system stability.
>
> Signed-off-by: Niklaus Liu <niklaus.liu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-regulator-coupler.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/m=
ediatek/mtk-regulator-coupler.c
> index 0b6a2884145e..f6e3b2a3a5a8 100644
> --- a/drivers/soc/mediatek/mtk-regulator-coupler.c
> +++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
> @@ -42,6 +42,18 @@ static int mediatek_regulator_balance_voltage(struct r=
egulator_coupler *coupler,
>         int max_uV =3D INT_MAX;
>         int ret;
>
> +       /*
> +        * When vsram_gpu is enabled or disabled and the use_count of the
> +        * vsram_gpu regulator is zero, the regulator coupler driver will
> +        * execute regulator_do_balance_voltage, which adjusts the vsram_=
gpu
> +        * voltage to the minimum value. This may result in vsram_gpu bei=
ng
> +        * lower than vgpu. Therefore, when enabling or disabling vsram_g=
pu,
> +        * the 8189 temporarily skips the regulator coupler driver's modi=
fication
> +        * of the vsram_gpu voltage.
> +        */
> +       if (of_machine_is_compatible("mediatek,mt8189") && rdev =3D=3D mr=
c->vsram_rdev)
> +               return 0;
> +
>         /*
>          * If the target device is on, setting the SRAM voltage directly
>          * is not supported as it scales through its coupled supply volta=
ge.
> @@ -148,7 +160,8 @@ static int mediatek_regulator_coupler_init(void)
>         if (!of_machine_is_compatible("mediatek,mt8183") &&
>             !of_machine_is_compatible("mediatek,mt8186") &&
>             !of_machine_is_compatible("mediatek,mt8188") &&
> -           !of_machine_is_compatible("mediatek,mt8192"))
> +           !of_machine_is_compatible("mediatek,mt8192") &&
> +           !of_machine_is_compatible("mediatek,mt8189"))

Please add the new entry by alphabetical order.

Regards,
Fei

>                 return 0;
>
>         return regulator_coupler_register(&mediatek_coupler.coupler);
> --
> 2.46.0
>
>

