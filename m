Return-Path: <linux-kernel+bounces-745656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1CB11CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE98B189EEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9C32E2EF7;
	Fri, 25 Jul 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kw/XKkDH"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAC2E040A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439963; cv=none; b=QRk7D5WNX3J/9GMdRIEuxc5MFRA4Kiu2NnxKx4T7wIpMiQswaUl7kUKTJB9FdsduFRaZ4UCb0+qp0ZwozFVM0uWbra9F14orMqLwEndwUmYvZWQA2tOC2Tf9X/F+fOhrprTA9Xn21eqxApRmubzMU/8ZrzvkH8HhjIjZNR2uh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439963; c=relaxed/simple;
	bh=DZf8o481vjpJ7QSUoolpwJajFBT1Vwo8xHyfUgSq//c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpeqtJ1E5CGHPW2FhvTyXfb5crNRtrgvfLx7fRsrvD13XuF+9hdlmIYVbjlbuTnRIggJj701PsldJgv/YMPmrJivZxYeqDRGlr0d9zGglpOxfedB+k5LS2SBWqE1zZaz1Fve5R6hBIscLJ5Jqa6F3HJey/AoxH91gWY4+nULjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kw/XKkDH; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e9b26a5e45so771574137.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753439960; x=1754044760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlkE41QL6s4x1GqYESsGC6jimQ+2xKl71+VqMJsnR/Q=;
        b=Kw/XKkDHCzTvNyIeGqVVim1ICFK5l9l15+EcwNLtsZHKjM1/dNZ+LdQIP8QjPkD9KA
         CZ2Wzl9NQvQkvopxbkHXOdn6Bun5hbuOkeK7wjIZhEbMiYRUHZgCT/KeAmeYF1EY9WJ9
         LaSio4wCYmhLDMaML2rWsO7Epr0cPqepBCF8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753439960; x=1754044760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlkE41QL6s4x1GqYESsGC6jimQ+2xKl71+VqMJsnR/Q=;
        b=GK9zUxWwtZ4DU8xeCmi5OA0tWDicx+yYP/WCKcAnfMLnKmICVpJfOXGJN9Q8G/dGzZ
         v+BPX8buDaPebnsTLovDDLzBFTDardTloNWje8/KRzs3n+qZF58mWvz4ja9mCPQLWR08
         sbWt1cjkGuUrTTqnhy4WfRnLYNQVJ8Oc4UzkW1Fe/e8YU13qp3BZqT3n1J2FqISNlVg8
         Dl/h5qJ5irs7iaSpJrn/E5eRkxFLLyCF+f729N72AEdOLd7dZLbH1dqjWH03XVCSWx7W
         4tUgHFX6NExeGGgoTh1tyHbSF9Wjq+5FV6IUiQwbzOrfs5omv8SJTlboczTMio/gxYmx
         fQLA==
X-Forwarded-Encrypted: i=1; AJvYcCUr/Zwq39KQ+nex1cHhXHF1rfaM2TgskdHbktYvhdLD5KVIy3cRZckA8g09FhR8d2s6A3De+8qv0bVP53o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+c1LvbZOQkegFTH17C2LxSbaNO1mxrZhGSN9tKp3t4pJLt5Sr
	03pmnVTjoZPmLUPGN0Xzr1pktGTmhYSAJPM8mIJgGP9NPcsaEItMeHSQ82V91I8hypB6kffNp2P
	9vbhTNA==
X-Gm-Gg: ASbGnctLQWGOSncCudsQ4Fk6yZcQeJQtSB0ehHJkq6m+Pd1Uo1+STXh2YU/4qrcFpvu
	V+CRHR47TKTps0DxhPeB/ImmMNKn6oUA/fijxMDKdehINkjIcKoBtJps2mIzxiBdrYjz2nuAgL4
	uLeXsLdET5heboQH/ZvPqIaO5CgX/gJy1FosvQ5t+eUeCNOZJ1KpRizUCkKnif98SJ8x4nGNAw0
	sv8c2zcIsZcdSx8NDzQPNwso1amYK9hGX8SrZlpFAjIzTjK7t49qdqMY3XDAl6bEzZTtKam/3lj
	hTne1+EkjmmEhbC/9xhWvnI+G8LC/W5GwXM6IFE22LnRhuW27EMxzyBg0aRfNs4ddS9fnWc9/wm
	cDFsp1A4t+3f5zh3MQAG+Z48b00LdzTj8r5jXVkOdY4VrTYaTdmvcQNOWjTU17w==
X-Google-Smtp-Source: AGHT+IH3czHvXfDLRZr8txSzXBc6qktdwwrCuUi4eQexS2OaaOYnOrJ9LxiiVApTTQAkLXiTUtYQdw==
X-Received: by 2002:a05:6102:fa0:b0:4e5:a398:b6fa with SMTP id ada2fe7eead31-4fa3fc4d2efmr335664137.3.1753439959633;
        Fri, 25 Jul 2025 03:39:19 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b6fbb5554sm683458241.28.2025.07.25.03.39.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 03:39:19 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-537a0d384b2so667311e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:39:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFzFFDLbTkP5/4vyye18l0xQsMZugzHsRXMq9J88nXeYQ0toC0rPOx7fDKU2VvrDXS4BKVaOUbD0TceCY=@vger.kernel.org
X-Received: by 2002:a05:6102:4a8f:b0:4e9:a2bd:b456 with SMTP id
 ada2fe7eead31-4fa3feb1976mr334393137.12.1753439957846; Fri, 25 Jul 2025
 03:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-39-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-39-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:38:40 +0800
X-Gmail-Original-Message-ID: <CAC=S1njc7_+EhDA_HrVsPfhYsrFEmeb5TQ55X+YOKE=NrpoCaA@mail.gmail.com>
X-Gm-Features: Ac12FXzORC58mPF_B982fHDjnhtiL_-5O2nAq5PI4bkUJDNwvq8vw0VlaVEnRW8
Message-ID: <CAC=S1njc7_+EhDA_HrVsPfhYsrFEmeb5TQ55X+YOKE=NrpoCaA@mail.gmail.com>
Subject: Re: [PATCH 38/38] arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible
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

On Thu, Jul 24, 2025 at 5:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This devicetree contained only the SoC compatible but lacked the
> machine specific one: add a "mediatek,mt8516-pumpkin" compatible
> to the list to fix dtbs_check warnings.
>
> Fixes: 9983822c8cf9 ("arm64: dts: mediatek: add pumpkin board dts")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64=
/boot/dts/mediatek/mt8516-pumpkin.dts
> index cce642c53812..3d3db33a64dc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
> @@ -11,7 +11,7 @@
>
>  / {
>         model =3D "Pumpkin MT8516";
> -       compatible =3D "mediatek,mt8516";
> +       compatible =3D "mediatek,mt8516-pumpkin", "mediatek,mt8516";
>
>         memory@40000000 {
>                 device_type =3D "memory";
> --
> 2.50.1
>
>

