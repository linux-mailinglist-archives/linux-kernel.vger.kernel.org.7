Return-Path: <linux-kernel+bounces-745748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6BB11DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724FCAE246B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3492417E6;
	Fri, 25 Jul 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ArIiDxKJ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249D2417C6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444000; cv=none; b=sFeLeFATaLnga3KtqXKfdIM3Ox4K/0gZqYtregweWM662hOolSObuHtJUpeIeLJvxBW4AydYijciQloORItqtz5kHhxORYez/Rrmg93c6OCXvRaMLR0BdJwJNaa2wYLJodi3DKHLWJsucAl40UvB4BKg/we5N+g5+xnrGWkWutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444000; c=relaxed/simple;
	bh=KqH01V/ZQOGZhBJpHb3zgphhQB1Sh25Ttt4gkVmURXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE2fMMyp5SJ3ZVDrbkR2JjlezIQ6S3eE2LQx50EezioS2bpVleAVaytMZh+1+yo7gF753WQjA55avSEyDFJ6nflp656r8ZgTzGb3q7oe0dDbbH6I2kg813iyD8sVpleE6qewzb68KEwUi/duEZXTbsnYUMeu+Qb9F0aVI+IjH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ArIiDxKJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e82d2ec21so1003530a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753443994; x=1754048794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfE909p8Iq119G3J/2SxiBSXlMMdz4SFa3hpgANK2k8=;
        b=ArIiDxKJR7F3WaRrvmTvsU+xuImfji49eiMuRDMoteDrgrRAZiBfuf39F9+CCSS6OY
         t4hHbRNqwbD8xXont9TGhX18OYWZmBH1zWvqbnBL9/td5XL9K0deZ3AaVZaBgnUL7xFB
         Pi9zy2oNdQgDLHUHwOxaUmDeoqss8LRxrtb4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443994; x=1754048794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfE909p8Iq119G3J/2SxiBSXlMMdz4SFa3hpgANK2k8=;
        b=SkVNB2TUuZSHFup03IYirDQGqKR5VJgE3/ryU8uUN9oqUw6OU5t8LCmbrT8AurzRPb
         p6Ntm2CLOWggGEgK8Yv1gY/gE4ypwtPptUoRO8++Yn0sGYQUgMtMd46etfzHzXEiIYYa
         P2BHaZAMw+K1GmLAezTDbHZn9mdhrmf9T7/yI8z8gHBk4N+J5GVffQIEOB0BYLarMtKb
         QwXDuhTG1S3Zn09yH1brk4nKtQxZEWUqhl/wSS7ghO2ykvm8qw1/EOxxMQbI6+X4TXN8
         jaeKMMps2Lg/pdberp50x80Fcl/Gxpmog8tmY8AgiJ2ZfQx6Tw43WsLEiUeElgwIpQa9
         HIsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0DcRCQPIilqQjiSXhLT7uZnJrLt/MpZCEbtCvt0d9+1amiyeV1FWlYP7jCQb5EUEWaEyBVMOZ6RPfhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7CNlWFFK54kK72TDUBCVsVHQkCCtGD3dCCuR+S63pJK50t49
	Mg9ATVol7CXySpwir8vvuuqsQibq9zDTkHJe9mfxIst7fs4ZjUUNrQ4iDpp/P2u2GD+67mqg6gx
	2WhAccg==
X-Gm-Gg: ASbGncuVTpHpXv8Hdny56e5vNhIStdq99NdelR8X4/rfHY/ylbQp28F2PUWqXWefOBI
	e3j5ZdwYE9L24iZQCCjR70Ez1Pgg+czUUlQGBxB3HJ9nWRP0pe6+0LR/H/sIa0HGYK3OzhWd8+2
	GPHYwLFqX88347kyh7gkjmgUmHMnpYIYdVeTkE2fnuCdus61zRUmYqweqxBfEzLSx7qWwBU3BEL
	koj43cpEEoV2je/hD2UMWYEU5vg6ZyQMBeWji+pcR2O4jSFE1hvlHQacrTBwmVva2e0nqi9Ckux
	gSpW57p+0QFfnfm4DytNSJ3a1ZmQaqFbWNEdCEcz5Zsz7S/CwVVzafJwqbHMJ0OzkLOoFWFA1vM
	Y8nEdBltXVtlvf/bOMHDw6eGM10id40wFPD5xwVtLtJSSxsU6wtXjORfNSCPhZQ==
X-Google-Smtp-Source: AGHT+IEtZ7cQ7af6nimfaJF6LokyHRkjEiludINsLNH/u1fURZP3dGQFJmypJZH/wGrZ7LJJw3bsCA==
X-Received: by 2002:a05:6830:700c:b0:73e:8b47:a3c3 with SMTP id 46e09a7af769-7413dd76494mr985900a34.24.1753443993644;
        Fri, 25 Jul 2025 04:46:33 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412d1a1ef7sm647345a34.24.2025.07.25.04.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:46:33 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41b7d124016so1032136b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtEYxDASPkZaC5SAoWaAizUr8+/0jvrI1wuCoGL+MzkjNrNMoNQY9WDnEaQihzxb/KRHWEHWydXSjT9pQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3713:b0:4e9:b7e3:bdcd with SMTP id
 ada2fe7eead31-4fa3fad468amr285963137.12.1753440273293; Fri, 25 Jul 2025
 03:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-24-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-24-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:43:57 +0800
X-Gmail-Original-Message-ID: <CAC=S1njhu11nHpyMULbK6PE-BLrBMq+d397pDU6gBzgo7xivXg@mail.gmail.com>
X-Gm-Features: Ac12FXyc7RkTIKa4HnSlf_SM-GYdwIREUn6AcAkOBKhNuekdCdvFzy29o7Ufs68
Message-ID: <CAC=S1njhu11nHpyMULbK6PE-BLrBMq+d397pDU6gBzgo7xivXg@mail.gmail.com>
Subject: Re: [PATCH 23/38] arm64: dts: mediatek: mt7986a: Fix PCI-Express
 T-PHY node address
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	daniel.lezcano@linaro.org, mwalle@kernel.org, devicetree@vger.kernel.org, 
	linus.walleij@linaro.org, linux-remoteproc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	olivia.wen@mediatek.com, shane.chien@mediatek.com, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org, airlied@gmail.com, simona@ffwll.ch, 
	herbert@gondor.apana.org.au, jassisinghbrar@gmail.com, jiaxin.yu@mediatek.com, 
	andy.teng@mediatek.com, chunfeng.yun@mediatek.com, jieyy.yang@mediatek.com, 
	chunkuang.hu@kernel.org, conor+dt@kernel.org, jitao.shi@mediatek.com, 
	p.zabel@pengutronix.de, arnd@arndb.de, kishon@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, maarten.lankhorst@linux.intel.com, 
	tinghan.shen@mediatek.com, mripard@kernel.org, ck.hu@mediatek.com, 
	broonie@kernel.org, eugen.hristev@linaro.org, houlong.wei@mediatek.com, 
	matthias.bgg@gmail.com, tglx@linutronix.de, mchehab@kernel.org, 
	linux-arm-kernel@lists.infradead.org, granquet@baylibre.com, 
	sam.shih@mediatek.com, mathieu.poirier@linaro.org, fparent@baylibre.com, 
	andersson@kernel.org, sean.wang@kernel.org, linux-sound@vger.kernel.org, 
	lgirdwood@gmail.com, vkoul@kernel.org, linux-crypto@vger.kernel.org, 
	tzimmermann@suse.de, atenart@kernel.org, krzk+dt@kernel.org, 
	linux-media@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:49=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The PCIe TPHY is under the soc bus, which provides MMIO, and all
> nodes under that must use the bus, otherwise those would clearly
> be out of place.
>
> Add ranges to the PCIe tphy and assign the address to the main
> node to silence a dtbs_check warning, and fix the children to
> use the MMIO range of t-phy.
>
> Fixes: 963c3b0c47ec ("arm64: dts: mediatek: fix t-phy unit name")
> Fixes: 918aed7abd2d ("arm64: dts: mt7986: add pcie related device nodes")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/=
dts/mediatek/mt7986a.dtsi
> index 559990dcd1d1..3211905b6f86 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -428,16 +428,16 @@ pcie_intc: interrupt-controller {
>                         };
>                 };
>
> -               pcie_phy: t-phy {
> +               pcie_phy: t-phy@11c00000 {
>                         compatible =3D "mediatek,mt7986-tphy",
>                                      "mediatek,generic-tphy-v2";
> -                       ranges;
> -                       #address-cells =3D <2>;
> -                       #size-cells =3D <2>;
> +                       ranges =3D <0 0 0x11c00000 0x20000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
>                         status =3D "disabled";
>
> -                       pcie_port: pcie-phy@11c00000 {
> -                               reg =3D <0 0x11c00000 0 0x20000>;
> +                       pcie_port: pcie-phy@0 {
> +                               reg =3D <0 0x20000>;
>                                 clocks =3D <&clk40m>;
>                                 clock-names =3D "ref";
>                                 #phy-cells =3D <1>;
> --
> 2.50.1
>
>

