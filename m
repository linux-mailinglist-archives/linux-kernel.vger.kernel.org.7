Return-Path: <linux-kernel+bounces-833858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A669CBA33BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D318F1C03532
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DB29D287;
	Fri, 26 Sep 2025 09:50:12 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34B265623
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880211; cv=none; b=rvcNoMieaZuESAw32bkC0sCVL1hYyGAS4xox3HJRue+aTMA3rhQNbgdRPiaY/UtYyz+UOEMhKq+ZFdvX1vyghn9pm8kRoYITW1xp0d2qZq1yBHayAGsis/83dWCNDu5UaJuxHLRfXKZbQCpkPYDdiKcacZr1xBJmIk9qaXl1BpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880211; c=relaxed/simple;
	bh=9MP05zHbL6Vtrf5lONjgCVq9CWhR1Q+9cXrMd2Yezk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG3t37Kx3Ss/zqPZPWnrWmTRsiY98Avw/M2VBlmeT6SnCMmDr2icj2+/t1VnnWq61WGzsn0kQx4JmwhELtT4WGlqRDH/gAw/im4Ne+fQbaSkZG6cEwxAgpT/FyNEMZVd+4eYE+pO6CgZk9ft7Xh4gzcjryXmgZynRTIZuMQIEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bc6356624so2102386e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880209; x=1759485009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcBsC1askobQesMf5dT3EOt6tZwDclh2s0/BCRcco7k=;
        b=GpnsRdTJAbNL2oACqoDzKjQBGnO0M80i7jtLOUh5rbuxzPKbrUBxcV6GRBPZQvEKuT
         BKezZVSIindLAxyHnOg/P91w0/+sbF43FPmooy2ZAuFN61iHf/w6jiiH9bFK66S/ugP0
         4m0XccLGegpZxYfUhlG7vgCD+xBp5Y5tzer7JZcR3r5C916lqlUJV6X4vlH+Ljoqo7C/
         m3JpAGSNekrCdtmNypcHXJCZSrYEGpBOTNyEhGGV+DiT/viAdQasSY8MOabL6As2OOc3
         hW0XHK+sDGsenah1RkB8gw4t9zENDkXIKNl02+xZdieFNVWW5ljUtgulbt/XlKK0OOaC
         0fow==
X-Forwarded-Encrypted: i=1; AJvYcCWfDFqBnVs87qYNK0ZS5ketC5v12mQDe3RXpqFA7PgBFUKSlBquH/wrdOUf0bfm4LI5I18nei0P+/EjOiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4M6gz+9rM8Ijb1Ur3kJPqmfgWL6fyZnbIyZnoE2HzED89V0O
	tW5bRWHT5Ggblo1UldafqsyaUrL3xMPqMEFB1yKzCKdY78snTodQP1gfeI4jdrMa
X-Gm-Gg: ASbGnctca1aMxQdb/St0J4LFNA1QiaPwbKDhi+I2FRowgmP8LWdTcBf+yu+ywU4H6+f
	UDyAPaEqZCs+ymjrJ/392gxngg6NhC1oAKGI3oFNMLmYVCiBEKzLE2ahpBeoXS0JY2umbSmMuUn
	z807LVO0fLlxYCsMHfQeHpBMSqrb+Fl+eCxqcLTYlfGxbQ6pDxHCK+CyemC4V1Y+T4F4aOO8nTf
	40vind0tUlcVPn+ZKQTvYSoCeW+8KdFTYcpWEmkJj/xMQiqnAuvCvwLBIHSEen8yQQSwSJsZ+KN
	34ByqSQQMwlCfjfslOSHl1oKOkJWUMlG/yO4xUbmRJqomNQTRAsQlxQtuMqoDFDYI5gd9yjb+PW
	9bAR2IPTH41GOswoNJGabcuRT2vMP7VGha2cBxdrO1AQGPuMYBi1Grr1syYSz
X-Google-Smtp-Source: AGHT+IGEttgMwfgD3+5dbFj/hP8mSC6ytQB5W+lL6sFn/6bZbSWG6cEhGabJcOM41tA8R9U815Zc5A==
X-Received: by 2002:a05:6122:5004:b0:54a:89a2:21ad with SMTP id 71dfb90a1353d-54bed253c0fmr2074436e0c.0.1758880209092;
        Fri, 26 Sep 2025 02:50:09 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed8a94a3sm837338e0c.9.2025.09.26.02.50.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:50:08 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so1409826241.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgfZDe4DMiIv/Nc+O0ASindPc5AtHmD9YwShvUfKWG0XjukWVKG8Az/G3p+CPbDgxK632+oCQPvCUWrW0=@vger.kernel.org
X-Received: by 2002:a67:e098:0:b0:59f:54cb:205a with SMTP id
 ada2fe7eead31-5ae1f222b9dmr1619909137.13.1758880208278; Fri, 26 Sep 2025
 02:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 11:49:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXn-sd7CXgxRzwfHQFUUxzboyYP-2eqSTaVgmh5hjT_xA@mail.gmail.com>
X-Gm-Features: AS18NWBXsS1FJ_qFsvTSOsChWy-NgmX0zNmCcExyFfSBImph2esks2SOJO6KK2A
Message-ID: <CAMuHMdXn-sd7CXgxRzwfHQFUUxzboyYP-2eqSTaVgmh5hjT_xA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
> support.
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

