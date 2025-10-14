Return-Path: <linux-kernel+bounces-852901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1FDBDA300
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0F02351D59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1362FFFA0;
	Tue, 14 Oct 2025 14:59:14 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129B2FF67F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453954; cv=none; b=NxfJWq42A+K8SbgBqi++kuzmWCGVDRt78of5m5RaBBK41qkX2vHVvZZnJBX08kH9c4aXVWaJ1SNwmQn+SGt/YARn8RT85LjaGnaYjWSH9Dq/S2Ahr3ItMdelvgUDZ2VMM+7NUycXiEQv6YmBUObiHRJAaiNIsSEgHVJvLZHiqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453954; c=relaxed/simple;
	bh=8cdcfvLKZRVy5zVyqP8q5Amc6eLxZmc3401QZxpkFVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL8rF+cTleZthylfHBaAClKdj1Fz0gsWu/a73/RPy0eJt9RCuN5bKBW19mwiByzdDJQslSczJuRB8mNL5np+0vN0sT6Qs2JFnrMOTLma+C9+Cd0pO7U8NYmtECzOKcWw1a154lao6krfM/nkrnJt91Q9Z5il9XC+Zk0IJtIkoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e261568020so1035449241.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453951; x=1761058751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFM6fq+qPomTw5SLmg+mdn/T0EKmVQHgVT/LIsQW4L4=;
        b=iJn3JC2j7l4Jk/rqMlin12wPLKfx8FQi63KSXsq95Vyn44SnwCJDJpVfTgeB7Dm5+x
         sj4pCTYG4Ntlk84oBYRrpfhitNZRrSjlJsh36mQxOh/DrCqIaUfIF2xOlTTwrDjfuu8x
         YxufsZCAJ4Pb9bi35PyuaIbRP5GmG52yU92BBG7xRWFk3nW6ReHuvWq6RSV/OGL5LsJC
         QNhrZ+HR4YXD99swW3Isf+wku/cZcEZpBYrlCRX99x7VURChtrEmlc/6zKZNnXPpbBQz
         nPI6KKBoV4yBkiqZD1shRAtNCauo9Zmc91Mg9Fg3mwa3l+Z9z9tMfl1CcnpkJGy89JYP
         4JrA==
X-Forwarded-Encrypted: i=1; AJvYcCXJo+VeA5QsNhlkaZ7KlncvyKvEBlk9IDcsCtUtdmECheaTcza8jKAUSy/ZxSgNsluD/Jx5YChxMz4AzU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfnBLkW6KKU8XUHCaT32A+HLp7guMpbLT6HKIzOh7u/zfStUR
	WJFnN30n5JwPMbbZ0e/a26o6LvHcu3m76t+Wjqzlf2vRH2moLKRewvri4cuZx1Lz
X-Gm-Gg: ASbGnctsqHtfrQrIW8aoDaPy0wJdYUocxsUBjyex6i1chmVLPWHylx0nMNWxZs07ToL
	9MT3qs7lFGdh2DiJu5OpumyQrQ2AIU1CdD8ShNl8F3VxewXJtQ1ZRWIYTZpZrP8kpHYxYnymkfd
	mH8U7hnUtxnziBNcrzKJKvPvMh8LBxkBbPLBiTp+T9W5Ws/v8PQ1swOHYoPfuo5Zh/M6355SoES
	0WlTKzG6nTadMtO48ExcCj3fH0AFMPsn/JdtsEalJJEfhX6TIFerB23y93QZT4Kuath30XGU1+S
	Q6+19YeXOcOXunroFhzvZeFA2QLPdoeg+asym3j8udZVrHO4GkNEMRhhD5e0ce9qtvdQvn5Yr2O
	6BMNfAVe/H7yc0X8yl7dmH40nvIDcDs8Rc6NNl6eYfarYyltN+l+WH1aRic005GdPX/vFdJQ94c
	WUo/dRMGM=
X-Google-Smtp-Source: AGHT+IHwELxsyQu0gKW0bdQQEPAtd/Nxw2h06AGQn/ha1kOyQZS7mpOi3ambG6ZTCZ4dOLRY+c53RA==
X-Received: by 2002:a05:6102:4191:b0:4e7:f3d3:a283 with SMTP id ada2fe7eead31-5d5e2376e00mr8136632137.25.1760453950907;
        Tue, 14 Oct 2025 07:59:10 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8f17fdsm4432700137.14.2025.10.14.07.59.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:59:09 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso1463596241.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:59:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUInNi1emRGitXp2z8I9bvgg/LRw7/BaSuPlTxvZ7ZJJ7BJyAj52OR9sD70gj5NDAmH5bRXG+t1NXH8mqw=@vger.kernel.org
X-Received: by 2002:a05:6102:b0f:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-5d5e224f3f9mr7315982137.10.1760453949213; Tue, 14 Oct 2025
 07:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918104009.94754-1-herve.codina@bootlin.com>
 <20250918104009.94754-8-herve.codina@bootlin.com> <CAMuHMdWNErzjfqXXgJZOn2viPYmGeuJekY_WLDeK6vzYZzdJmA@mail.gmail.com>
 <aO5aIoCEL-XbpBTp@shikoro>
In-Reply-To: <aO5aIoCEL-XbpBTp@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 16:58:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkx+qQRDertFmW9nLzGJA+VETWLvaA_VoS17-WhJJvXQ@mail.gmail.com>
X-Gm-Features: AS18NWDaYL53l1nt58YG7qpvuDTebR9eFnGE4nr9xDBH40Jra_ZU6YkKi5yFUO8
Message-ID: <CAMuHMdUkx+qQRDertFmW9nLzGJA+VETWLvaA_VoS17-WhJJvXQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Tue, 14 Oct 2025 at 16:11, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > +static const struct of_device_id irqmux_of_match[] = {
> > > +       { .compatible = "renesas,rzn1-gpioirqmux", },
> > > +       { /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, irq_mux_of_match);
> >                            ^^^^^^^^^^^^^^^^
> >                            irqmux_of_match
> >
> > Interestingly, this built fine for me before, presumably until commit
> > 5ab23c7923a1d2ae ("modpost: Create modalias for builtin modules")
> > in v6.18-rc1.
>
> This should be fixed in v4 already as a side effect of my request for a
> better namespace prefix.

Thanks! Sorry, I really thought I had the latest version in my tree...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

