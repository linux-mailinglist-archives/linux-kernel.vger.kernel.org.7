Return-Path: <linux-kernel+bounces-827321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7FB916CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A0F3B68BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413230DD24;
	Mon, 22 Sep 2025 13:36:06 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E128853A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548165; cv=none; b=FrxFIr2xdoJSjvHWaEz5t70Cp0LrwQ49FNTBIVy8XJWtlJAjPd5wFmSe5s2EclWSM4THWRjCdkjqJLQC6YgRsIIMxCqaxMWmBOKRB6GwXGWFoBf1tx4gb4IQQtXP/e5su5njuF5d3ANTshQ0Js/q5NX98EmNDMOpID5e8NmKrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548165; c=relaxed/simple;
	bh=o3fokZId+Y6ExSrmVp4U54jGApx0aJHWTHEveHEApIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEooqY0kG9/Q5GCcliNlK4eaouLyjUp0Y3Fi1AlPZMx5dhByMFZGwZbWkEYPuFUm2w4UfbOCRBtNy05Qgzf5BCfLST1g2LKlS0qDFa8O7539knyUSpfioDVDlrQGui4a5NAEVrknDHkZhcxdeTEo/QIN7mdS0iBMmhCQfrTAyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so775523e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548163; x=1759152963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ot5mKBkVwUNvkCox+i1Ysazafolib0GaP8R7L+vKCs=;
        b=SxwwN+g1klI0+5MPtbe3N64VYZvuBKqtNftmHctyfNshlAwcuRck2A2SDj6cIHcrnR
         PBoov3rIFjDFfmbezpBXm56YSIUGRZ61Rknx9OXY+PMqa6af+QcNEM83D56B8P+3RooD
         5HN/HLKg40F7eJHTXk7aiYrySdqUFTwGWNJ4Bdsdd4K+osspcLW4/6Y95+7L+jZkACQM
         rvteIBh+E7MAFYRsGhKPoWgvLhqUNg6rSjLSwM+Gq3hidhP6f9HKVEOCiBApim51JxPm
         /BSO+OmD1d2hgqk3NiTsyRsEIOkveVt18jlfyFTDCvrmEqps1hGSITwRJQVYnZALcnwm
         6sRw==
X-Forwarded-Encrypted: i=1; AJvYcCWvPyme+bYwTRdQ4T42clJoAdPkQW5ykOj8ePcKirH/7Cl2FYauvyQjWSA407BG+Na5w6HBXazcPWDvBPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgEyJxLtSQma3kvec4lzdDRv20Obm+1LXzhSMbWJcUeh0EOK0
	GEZ4TMltB3dP/1NSHkHXtI17EKrnZu/zC+X5g2Hsh21dxl5omU/RW3zz0T50iwSW
X-Gm-Gg: ASbGncsljr9FV1/pcLoHzGNoScsT9esK3pl2p5+8v9Hmo5Ma4R0QwsTQdFtRQDjcFaN
	MHXhQQIOpz6ED7zHGx0d9E/Rgjg0+vZmRgGYALkbqY5GgEr5FX+NZXXk9ucgIi7fBVnB1I2jKYy
	qfgczoH58/3jWZUKVZ/iiTRyNWPH3d5t6zudyUFlhQ8oA4m3K4cdaSzrcVesCK+ZkFfRRbPTqlR
	AoTSKTmDjHxNnQKPk2Fu57sQUh+hgIg/kMMAoLWqT6k4gRk1mpLAeHAQbkWo6ZXGKIRAO59mBUD
	sIlLp/DLw16ZZ2CJBgFXAN+wh0teA/dfUFHainy6Dx0Kk0i7NXIw+nQjImhU6PS/Ox2MxxBZiey
	622gSJVqUU3TPCjisGeVF1+EukkaVJak2yTcTtxxcpWWshOjm2GWHSufKBNuvpfArgQwuzGY=
X-Google-Smtp-Source: AGHT+IHBiJwhw9b3XSpec1ogqpfXjR2W4NQOaSPP02WsddZAf5LaicZ/TrWtXuo3JsAw2boqajyAtA==
X-Received: by 2002:a05:6122:30ab:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-54a837847b3mr3844430e0c.5.1758548162940;
        Mon, 22 Sep 2025 06:36:02 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a7275991asm2707997e0c.9.2025.09.22.06.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:36:02 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-89018e9f902so2429956241.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoaBpBnkUNa+nkOUK4tWlaLQ2epiNcavrXcUGFQib9SVuhJdFOiRcPkVn6sgd/zJFhhl9zTPE89Ve4vGw=@vger.kernel.org
X-Received: by 2002:a05:6102:4426:b0:533:44d4:d624 with SMTP id
 ada2fe7eead31-588ddf8299fmr4350434137.8.1758548161616; Mon, 22 Sep 2025
 06:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909104247.3309-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250909104247.3309-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 15:35:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmQrOg5-fJ+NOmLyp3TCSRuoEtwNKSy4kw_zKuoTD-oA@mail.gmail.com>
X-Gm-Features: AS18NWDZCs0_Ui5sZv5S_MT6lcUUhGR9J4Vn0VBerunEKZYm2pd-7PEJiuRZBa8
Message-ID: <CAMuHMdVmQrOg5-fJ+NOmLyp3TCSRuoEtwNKSy4kw_zKuoTD-oA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: renesas: rzg2l: Drop the unnecessary pin configurations
To: Biju <biju.das.au@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 12:42, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> There is no need to reconfigure the pin if the pin's configuration values
> are same as the reset values. E.g.: PS0 pin configuration for NMI function
> is PMC = 1 and PFC = 0 and is same as that of reset values. Currently the
> code is first setting it to GPIO HI-Z state and then again reconfiguring
> to NMI function leading to spurious IRQ. Drop the unnecessary pin
> configurations from the driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Dropped extra space before the == operator.
>  * Moved spinlock acquire before reading pfc value.
>  * Make sure it is configured for function in PMC register for
>    skipping GPIO switch.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

