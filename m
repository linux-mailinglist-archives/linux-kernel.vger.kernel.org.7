Return-Path: <linux-kernel+bounces-850575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF9BD3336
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E26783422A2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F8306496;
	Mon, 13 Oct 2025 13:27:13 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BF253951
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362033; cv=none; b=gspyFPvj0ukQ+qhkif9OsJWcP5KbFJnxrDM7x7GnuKjqf+4pTx3tOUFXrd/VCA7DVtya1sOpN2AdWeyQFa5fC8r4+7UAQEaX3XNDxfF8Yj47QfxM7G3nZInhiHCEOiedN1NgfFNAHKz/c0im3j0Dx46UmAHBgtW0VOmsQ/7OCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362033; c=relaxed/simple;
	bh=D8LshH7ESvIrUy8j/Fk3D+rOEXIz/uWX4WWc2z3BEZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG301+E5P9+0kWjKG83BFj8UTH25numk7C6bsIBh8IxxpWrOsjpkKmhlydK37at2avt4XI3J+gBOvPs0TJr1WQdEoUDK1YgJvHcxHqTmlU/mZzXH18cEvPsX7KqUNFLE3gXBoQ6mfhwTJ4jRyiiUUewoxdfOu4sQgjvNSiyQMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-856701dc22aso580410385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362027; x=1760966827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oxdO3Bk5ecvpkV6jyd+S5AlG2i51w7h4MzlILSgBbo=;
        b=HeoXtVAp2IOOchlmKxn87YfNNsp5xxMQoNGMn+6yBLnLJS/Y0ZKTr3xA6Mb8PwEcbI
         heQsOpkl86uX5i1izO4fFmAFlx7qW7ILgxY6dxD14wqjFW+aJDF7VnoLG5J9+H6PE3ed
         lmii0GOsCPZR3S+PhhKt4oVav/6HCrOqhpAOXcnlv6mm/7S9yjAUK1Z+oHDgbTTxp+Bu
         rpyF1EHgsnbrUNVLWB2TiZuc4HK8D4N5SGIQpIkfl0570Z+SS618Wu8lJR5FGpVquw0f
         wmligR/VX2uxG+tdPLPVEp9lBH2AKFayPE2S7RJWR6Y/+RwfDZ+yPyL6qannNphmWPDZ
         11mA==
X-Forwarded-Encrypted: i=1; AJvYcCX7fG2gv3gL0akSXJS2UsEhHksSjAo6qny+hJShe0rjns3+thYrPeDbtri9WSibxiaoI+yB1Lh5lB8b+Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmB4n0QlmgQ5Tam/uyKdhBIA7+yoXmJnQ+jme8DM+rv5ahnC6d
	y/CiPelwLgw9Fmq67LmmcOfIBeXSFNnFNQWB5xbosbiEyRytclxZuTD6VuQImZ4b
X-Gm-Gg: ASbGncunGyJpffrupAz86FV2tvcHCaI7My+GRPsqR4/rrZvoljun2LytIRsKgbhkVUc
	LwhqZ26hWSlbP7nKYWzOnfMzOthjM2JDqn6n3f+EYb76hvzXNiI51b7AleGeLebWzo7MUnIE0Wx
	7J0ZGCu5pxsIsSCtLHdFXSYrImKOXD7r6tr5lIpBOiggrVqEhru1+rfRDRFwAQKUBUZyUzbTwZ2
	oyp0MzoKdr85y36VDwc2pR7R5F/FD6LQoe5P5KfHPgFEF2NiggP3CGZoMyzti5lfr1DZMqn9Iyg
	LgYixu0iogsQ54y06wJM24tnjdJo/XGLeHFQk1iinscd+hpPprGYIeAe8WoWjxi6nwqYG3jvzJw
	34UgB7GEH8w7ES9rtBJREPSJxSD1c2vrLDQbSrMBg4w/iAK81I8Z9IzP0/JvZ7G6brzrOHyUdCI
	EsAXEVnb0PXUs+KbbbY7JMiC6O
X-Google-Smtp-Source: AGHT+IFgbL8d9eQofkelg5ALPPJFc3YsKvArRdHaGQd1RyVAgOsXzCuXSePZLGBWNcMkB2BirbgIEQ==
X-Received: by 2002:ac8:4f54:0:b0:4e6:ebfd:5fde with SMTP id d75a77b69052e-4e6ebfd6015mr216387601cf.16.1760362027282;
        Mon, 13 Oct 2025 06:27:07 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706dd31cfsm76285061cf.38.2025.10.13.06.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:27:07 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78e4056623fso55027776d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:27:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiWR1spJrv4wpKawyDWUiZrKP7kvB0+dCPRCfFe1C/4qIxT3bb8pi07STqIwOT6a7zJvpyvXXGIrq8vjc=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr7355705137.30.1760361665957; Mon, 13 Oct 2025
 06:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013094611.11745-1-johan@kernel.org> <20251013094611.11745-11-johan@kernel.org>
In-Reply-To: <20251013094611.11745-11-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 15:20:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+PL2G=c-7JLiz7rT_KUAMr8Ex9NFEe6W6O1+VDkZcVA@mail.gmail.com>
X-Gm-Features: AS18NWD_aF0UuxNWNIiOAjn-Ljc_smuXpxWxgz_2AkuWdIehm9OKuTVhty61zGA
Message-ID: <CAMuHMdU+PL2G=c-7JLiz7rT_KUAMr8Ex9NFEe6W6O1+VDkZcVA@mail.gmail.com>
Subject: Re: [PATCH 10/11] irqchip: Drop leftover brackets
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 11:48, Johan Hovold <johan@kernel.org> wrote:
> Drop some unnecessary brackets in platform_irqchip_probe() mistakenly
> left by commit 9322d1915f9d ("irqchip: Plug a OF node reference leak in
> platform_irqchip_probe()").
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

