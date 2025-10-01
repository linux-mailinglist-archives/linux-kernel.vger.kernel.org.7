Return-Path: <linux-kernel+bounces-838971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AFBB08BB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD41926453
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F62EE5F5;
	Wed,  1 Oct 2025 13:43:10 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFF2ED853
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326189; cv=none; b=fCXBqwxq/WmX6Bd6OWAg+Pp8u03n6c1qPYTpwV/2dXpTL6TBx6z+GXV7hHKlKikigfDIm2xLxHjYN2s3WFnIfqqla8TOUfvcs40idPUdQWKemmIIh6sbQR7rnqS4kYi4KmqxehgDl8kFPWpL4J/H9lU7n5YuGsU9cyqg0+JeOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326189; c=relaxed/simple;
	bh=cCOspOg10LPIcpADaHReTKiZQPz1A+QQStO+5J4q0Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giBiPkr2E2JlH66gtbgGTHZYRdsSPolq16AWTh0+LZgY+szfeni/lVXzQ2vqMZIeDclo7BydvloPdJ715yCgZdRnJkSfGEOByJj+otlQ6zZmbuCwR+YyCinamVlGC8+b0uF36UBwa/Hl72mss0S3sfn8Iqr4Xr2I2i6f/IcjBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso654990439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326187; x=1759930987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTnvOCbceGyglohEUcee1/fNsyqLgTdEhUXaZIqhQic=;
        b=Kx357nUQlt/10NpKPBrTp48qNdivBHngjexk44yqDE3Wu1SdIC0RSWacLHohfAdrRj
         jcREIad/AUOX0a8i74zFmSYje54ThO3P81q4MOkO/tnm3t7kXD8DLF0YNBd+i3ZeX7sk
         BVeQ2JLh7bTMvPZ8qhlAa3YrHg9li/0ar22lWSS5eG6IF3ktjpvn54aVnUAtuKRWTBtG
         4RGsvm6dYpJBWEIf8yVgMILEFI3R0KdFz1vF1hMBzlovKtsakIzFDvSWx1YQCCVH3E3t
         7MVq/BZWQ54CJI1JlX6s+Ef5bOclWDtJfDRBQecHHKiu4w7ElvPN4IYP/tSxe9xjwPgG
         5COA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FM//C1Sb/GPeFkpXJ9PhfRn/id5Stx68H9gisih7O2K1LoCp7YQ7x3CWWA8yQsexrpdSa7WJ4+eCsMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OxnS6iCJQcMK3n9Q6XZxCptKy3wIocso+3DiBj2bbBTfSSy6
	uq4a2N1pPmFW68K6DWK6q00famz0w+FKCaAzSTk+Kd1S+ine5RziZHcNtOdxSZgx
X-Gm-Gg: ASbGncsW6fDjJHO+N5SvriUbRwCA2bgzAZL0n7v/yJweMJexkBiYbNh3DXrFVdzVA2/
	Y7gbX66dVdW6t+JRiPcIHvRURm5wdbpBWqFWRsG/BvATLA+m+vqAquynE1j+1sE5K4YR2nFRBjq
	/JCEWhdNBx+UbUOOxjvewftqq5G8Ammpb+FNfETBArdM4LFqGyLXFU0KJt5BYAEla2rb97t3Ed2
	Lhyf8+RmCBDgPBzfGsC6qFfkZatyZmuEqn9xrc54zsKQyxzYNwwTMynZ2xxC5iloJjazJAUp1/f
	Ri1pvtOQa7e4/LXPHekeF5QfqNSNnX6pCptqBXNIYDYy3iwHJxzNlc19GEzCdLIxFx0cdXQi+8V
	UrmgxqzRm+kopPGkibBPovNZduteH3G48Mj9piBgNL1TygKC16xN8HMESihAl01MdeoUE7SCnhP
	vVQ5LsDGE4xGsN4Qlq0h8=
X-Google-Smtp-Source: AGHT+IGNFmgEw4szVqH3H40lNVoxm/4PpK+mV0Gm2uYBZTGhUJ6n6d3Z8WbhTZcidb7fekCIhd3/Vw==
X-Received: by 2002:a05:6e02:190a:b0:42d:7e74:2fac with SMTP id e9e14a558f8ab-42d814daae4mr46395275ab.0.1759326186936;
        Wed, 01 Oct 2025 06:43:06 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-575a6f73703sm2473256173.21.2025.10.01.06.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:43:06 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-917be46c59bso487097839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:43:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWImXmdmBEwszK32lWRwKhkmx4uNx1NargurbnWnrNXe37jmvec91ll6k2KT8fOX85x7mvRfbCKCBIJcos=@vger.kernel.org
X-Received: by 2002:a05:6102:d86:b0:522:255d:4d19 with SMTP id
 ada2fe7eead31-5d3fe747011mr1261198137.23.1759325764988; Wed, 01 Oct 2025
 06:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 15:35:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
X-Gm-Features: AS18NWDLqgedMT7ALXpq29QgD05-Zz5HL5W7UgCB9wanWY8rYAtz-4hGklmKwbI
Message-ID: <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] clk: renesas: r9a09g077: Add ADC modules clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three 12bit
> ADC peripherals, each with its own peripheral clock.
>
> For conversion, they use the PCLKL clock.
>
> Add their clocks to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for your patch!

As I have already queued v1 in renesas-clk-for-v6.19, there is no
need to resend it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

