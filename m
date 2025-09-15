Return-Path: <linux-kernel+bounces-816883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA2B579F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862B21890DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88D303A00;
	Mon, 15 Sep 2025 12:08:00 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9362303C88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938080; cv=none; b=DqUlfF9V9c7J3lll+1N377V9HssGU1C1MXBXpwQCsTJ3EowWD5I5DltUWtB+7cwgjbLugG+m2GDW7s/LUfg9YYiFtPN9wre4RYJnb/y2D0HBh+P9b2ufBISwnBGHx9g/mGCPjb4tFJBqPzjp8xMSsVjBO/y1toA7a+9N4udLCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938080; c=relaxed/simple;
	bh=w1EtHwW9I0RFjXogMFDEDAFVqUSNz6KiSixf/4aXXzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFXfnnDWxjmprb7USvb+IuKaLKcuJhfoUwjvOfGec+z2P9R45itRJDWYAN9QT0+nWR4UJSX9u4qTmtB8Zju0HJy5N3qsIfUtFpc9nDZUe6Z8DU6F0dRhspmEUqp6YarlYnk28XNHtpoS/xmlc90wKTiBo5oV3jimypsrvBPb1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5299769c79cso2995345137.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938077; x=1758542877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBfi4uhS2B+Eniv5scVBhoF8y69qK9fhF+0G1ZdygDE=;
        b=wWtFXV59zv9iVeXT8DgaR2qRl3NYyxlELDZpw76VYHgHOnFx8sSZk+A7VGEM3bMO6C
         kpnPeSQhiEN4zWLh17JZnOp5heXPy64HrVLnMJ7/PoyBhplXZ4fgVjxcpBP8Wv5S3yHB
         gW0XqJACcX9tQIqEcA9eWzGzMOhKrEqojcs50q9KEvdezOKb4xVHmQXagBpTdZ9e2TlD
         m3mrylvk0113uKkDWf29gtxQAgM9GZbrbE+Xbe6CgyGZqboBTkff84PAQgXeghIXE9jS
         5rXy9E1RNjrBJc36RMYqhLi+kWb8p5wXWgureDhPwwViacLwRuTOYlj4sOQU2EzHseIj
         9nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNPkUEuG7yTjBCM6iOaq7IPTL3Xw1fTV6rKiQWKB6LwteKCBByYsAAlmcwgoNjQf9oOiW5LBFuCK5928=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTlSTZR3BrS5+KNbAG5tmZAJlmOAyKYBX8o6NJChML8RA9XoX
	4vyUH4ntzwF2jaJi2xlzo2cUL84ywfd5Xguo98MWsO5gp10SCUTcNlSIMCI9S+/g
X-Gm-Gg: ASbGncuZ3Kpv5SIEkIExjsE36REbwQ31aNqVPEKCT50/MPRZfgTkoyZedTSLPXPQde/
	SVGiZiEh8eJenT7rNmPbgxd9nZtXqP3M7eymDfY4fXZqBcAHOoN08AF6lu1eTtx1jcxcBEQY1q8
	aEvjLByXh/y4GRMHm/t8EBbiaPSYCjppwI4GOouIIVCxUJKAhKVXAEcFHxudN/dTzADBSuBtIJR
	78RLo3VZl2xxUomYCIN+evDQ1GuKwGMQIPQgSKAGOLfXYeS8WMW3wAt6g1+h8WxpTEg80YWxaJw
	/R2oTw7+Km7VQesnV4WzPkmyez8BdN0GiFeOgSaF8jQvUNDfshSFayAOkUNeJ26kB0fpFkFRo7d
	siDwvyIJGDMXV9LDQX4bilAOvQTn9EMQamjLzKHoMyzUZ2YcUNbLjLIwbbvOJ
X-Google-Smtp-Source: AGHT+IESnavXs+AXkIJ3vp/ZeSKZeeHMKNOEzRaiZfsu0Dwr//2i+AOMvDZ3If9f7E6dkqzKjxVZuw==
X-Received: by 2002:a67:e716:0:b0:4fa:8327:703d with SMTP id ada2fe7eead31-5560e7df819mr3892461137.19.1757938077283;
        Mon, 15 Sep 2025 05:07:57 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccd38f8d83sm2288319241.11.2025.09.15.05.07.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:07:57 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-556f7e21432so2217354137.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8shC1LqudxYrpDdW1KcSovBNVPldGLoySV11v2T3FV4ggh53arEaDkHNjdawDNoFhgXr5ylrPGphpgsY=@vger.kernel.org
X-Received: by 2002:a05:6102:3589:b0:533:44d4:d624 with SMTP id
 ada2fe7eead31-55609c313b4mr5030595137.8.1757938076242; Mon, 15 Sep 2025
 05:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 14:07:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
X-Gm-Features: AS18NWCFmQom8EOHzoQl-rBXwlbJequ1oD-bXcXBziRkWkdhHqMf1HNZ0ce-n8w
Message-ID: <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add suspend/resume support
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 12 Sept 2025 at 12:47, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> This patch series adds proper suspend/resume support to the Renesas
> R-Car CAN-FD controller driver, after the customary cleanuops and fixes.
> It aims to fix CAN-FD operation after resume from s2ram on systems where
> PSCI powers down the SoC.
>
> This patch series has been tested on RZ/G3E SMARC EVK, Ebisu-4D (R-Car E3)
> and White Hawk (R-Car V4H).
>
> v1->v2:
>  * Added logs from RZ/G3E
>  * Collected tags.
>  * Moved enabling of RAM clk from probe().
>  * Added RAM clk handling in rcar_canfd_global_{,de}init().
>  * Fixed the typo in error path of rcar_canfd_resume().

Thanks for updating!

This series behaves the same as v1 on Ebisu-4D (R-Car E3) and White
Hawk (R-Car V4H).  However, that means the small regression I mentioned
before [1] is still present:

   "While this fixes CAN-FD after resume from s2ram on R-Car E3 (Ebisu-4D),
    it does introduce a regression on R-Car V4H (White Hawk): after resume
    from s2idle (White Hawk does not support s2ram), CAN frames sent by
    other devices are no longer received, and the other side sometimes
    reports a "bus-off"."

Note that I did my testing between CAN-FD channel 0 on Ebisu, and
CAN-FD channel 3 on White-Hawk.

I retried with wiring between CAN-FD channel 0 and 1 on White-Hawk,
and with that configuration, CAN-FD still works after s2idle.

   "However, the underlying issue is pre-existing, and can be reproduced
    without this patch: the CAN-FD controller fails in the same way after
    driver unbind/rebind.  So something must be missing in the
    (de)initialization sequence for the R-Car Gen4 CAN-FD register layout.
    Note that it keeps on working after ifdown/ifup, which does not
    reinitialize the full controller."

Same here: CAN-FD channel 0 and 1 on White-Hawk keep on working after
unbind/rebind, unlike channel 3.  So it looks like we have an issue
again with handling channels 2 and higher...

[1] https://lore.kernel.org/all/f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

