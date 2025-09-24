Return-Path: <linux-kernel+bounces-830620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E669B9A226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB51164763
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39695303C88;
	Wed, 24 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12717B418
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722329; cv=none; b=iHqtDzHONDnNXatVlsC/FGIokRUWxBILezq9yRJ1nF8fO4lwxkLMM/4ros4NRVka2gSBEi3RrUuF1hWRenZwc60nMqtllOwNVO1TIS5PvFFfLJSlFKXqew2CSSN342vxbHm7CW1Gpu5NPpjHaVLowEQy+FKvSYhJZWAX0lVVUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722329; c=relaxed/simple;
	bh=z9AOKPs04tBQ4HuQHD5qLwqf6qq8m12qH0VEjcOwE/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt+cTrF6JQTCGZ8h38V7w59DFSixVgbhn8FPzrsXf2lBleNWy96+gV9bgDf6ApZhf0g5eJ6Ftz+IV6ki2H8wgVrCr1VOd1uXRn9/BitNIAgex7eqInseC7hXaDCk8JgSa/qzYWMenyZc6zXpMI0YJriRGmvOAK88feRUjh7JMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9000129f2bcso2335671241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758722327; x=1759327127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsHa4BTdlxzG8oL6cTUTw8znwap/WVMmft0DoAQSEiM=;
        b=MTo/eMFVc8a55m1D2h97iGaiMZ6+qV34sCDImSITXvGlJioQ7qKYrd/NhrTrKT1/Rm
         NElvEBKF1S+2SSYegYDfpNfqXhdz6MhZcnv/RQTQ14p0Z7NXtxqb7gKhFHTEvVHS6YN9
         bu6iTWNyrtJOoaF07jpvkJOGtdLCrVNgph1mmKk6EpDmZrg35/GzwfQgWOLQR4bSccFL
         3DX6Pi+rHt/hGLQImM/yNIBcLOO1CG49whNpy3kuxLSr/vSwwRpdbVUezXKwpoXmrYBC
         L56g0djnsH4x8p2w1FLC/e+3alVYz8465iPI2bSuYO55m5yS0fyCQ7AfxXqQCHVm251r
         Ob5w==
X-Forwarded-Encrypted: i=1; AJvYcCUKALyXWVNXV5R880b5HAZXdLxsKxU4LFKJhRZaB4QIn1eVN0/xJ0PGTi4vsOTdYM1LDwW0HCRzYCx8DXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoD17yEyP7dwIyGIjttaiDKxVK8Xt8IRxZjPs7lfbdVV9Eu+ka
	RkEoqbI7YUBpy/pm+by6RPcUls9afCq8Dmc6DMseu5i2kAEDD+d3wL88ah5s3I1A
X-Gm-Gg: ASbGncs4o5w7FXU66RpajxHsYMem26bceEdCqylK15E0GtjNKRkym6e7ZIZ9tafTqUk
	zHdGIEtO67eHa2quVyYdAjQfZvtBhYj1RIw4ycf0l6Mqf1LvcVmJ6ICz5cvJu6z63cNQDvpWsGu
	Ul+l+w+Iftkb6e8eBzThDUC65gY/wiW8ENIfxHWKzxud7XKBpkJlfl6cgDJ2hp+FDSU6AdaKv76
	nKrcCmMxKjehoGRP+sEQ3rTZHIcX2Vug+ql6mzOZVWqXULm4UMM75D64O8VgpX98Nu6rhCRzpgM
	jeIZ0ZjGLlimZ42c+kgBccSeRGSv3sDmOxPL8lfu4jxdGiQ/8A5mbVYC9UrRv3OBmCsaMV8qTAV
	qie/g7n+XgurI4Ethlw9N2VeAQiL7geKCuuq6Venel3rVAjmnuek5TNuLwbxI
X-Google-Smtp-Source: AGHT+IEE2fpeZDxP9YK4cgBnvAP9cPEQ3Lcw9cKhrC+VvaikcsACivXS5/b/harzpcmSAzC/m7AegQ==
X-Received: by 2002:a05:6102:26ce:b0:525:42d2:78f8 with SMTP id ada2fe7eead31-5a57d4e6117mr2827998137.11.1758722326984;
        Wed, 24 Sep 2025 06:58:46 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e5dc22cdsm3098348241.6.2025.09.24.06.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:58:46 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9000129f2bcso2335655241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGnlEaVqTMv795XtfUarHHQG4PRqPKSdQLV3VZW1DsnM6R+f+wF+1aZXGG5RbtjgXc5okSuV/vyp13LGk=@vger.kernel.org
X-Received: by 2002:a05:6122:3115:b0:54a:96ce:786e with SMTP id
 71dfb90a1353d-54bcb0b6125mr2198963e0c.8.1758722326099; Wed, 24 Sep 2025
 06:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com> <20250910140305.541961-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250910140305.541961-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 15:58:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrGbRHXa+13nGTf-S_cgHvDASvDTUSqhiC8updddJUFA@mail.gmail.com>
X-Gm-Features: AS18NWAg1I_dL3GYezwY1MvHo4wl2EuUyKfvLAv7l_tUzF74SJUhWeo0uWlshA8
Message-ID: <CAMuHMdVrGbRHXa+13nGTf-S_cgHvDASvDTUSqhiC8updddJUFA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] arm64: dts: renesas: r9a08g045: Add USB support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 16:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add USB nodes for the Renesas RZ/G3S SoC. This consists of PHY reset,
> host and device support.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

