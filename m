Return-Path: <linux-kernel+bounces-850565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45643BD3300
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F8E189C24A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F33D30648B;
	Mon, 13 Oct 2025 13:25:42 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581A261B9C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361942; cv=none; b=ljGRKke7J4JfHq6BZl03p+4CfWxBIznMLx2ez7wxVHWwElVwiR/+AH5bhPS77Qua0OAYpfTEYnVhf5nxUbj+oNCQfqXKQGs+NnVzS2IHKXgRXsOuPQ3nx0xDARtPMM/kfChFVT69W8YPiwiLRRPDKkAE4YjVk2+Wb1mnNKPfYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361942; c=relaxed/simple;
	bh=j4q9qC+YQd+5UBmjspKgMnDAwhjR2/wlO9bB1nGMYoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg6j6M5AVAfdaclh8VGiYTL7FlCk9K1ZcsyPOiP+TZmszeTMqIbPhMHGdnnygeHJg9hmRmRSSlU0gg8IYt4N6+2uV1YEcZM7wc3ZLDIdb17/ZJGR8DSQ9HHIMpc6ttsNcga6Uv/sU8PORyDwlZ092rzvkjFyRizZ24HZ0cvpo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3c711b467b4so2489139fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361939; x=1760966739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf23vMU4t6wG2q1+VMdE661hrqDXASu+puJLhVspCjs=;
        b=a9wAtTwQP9FVrBOT5pkTDNO9TzbttuaO5G60f0o+bHb1mElB9oimcHgZEb+bCYNKhm
         p4UKwPUh2Se6mzojJGquBqyPykK6ooqyK/AOF2gmNVeA8vgxL2GrB5ruCcH7VQvj4NpN
         PO5VvxjI2pPnWJD45OPS2mW6qrfn6opMieKOuqOf5pZ9OsUgXf+/TubCb6FGg+h+yq+7
         nu3tgUIyxfc5MM/ieAa13aQd+C+5Z8ATisLTnxmQfVNvKOknXxATIHbnyRmUhe45Zkz5
         wnBKTyXLZhKscFCjcju6jfd3NquMjWEx+6vMjw74IH2poykAOLGnoOiKVwX1eiAhwDvC
         PJBg==
X-Forwarded-Encrypted: i=1; AJvYcCXWCnqpdmjJDGqPGK01OXnaBs/KEFccryFoPOJ5WVIL77wGAnu54JukWBaKY8DBZyvNoVsftNkkztiqCX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkM8GUE9Nl3+llH5Rbz8AtRQKbtBhwuRCFn+u5tZWOjVB2HbJ
	WSuioRCtGqgtIfRM4em8zjT6+TLelRQxY0UarNBkZbK5Bp1UZwC9dC8zzHBqPig/
X-Gm-Gg: ASbGncsv1l85K+11BKFh+RB8ox8K4kRCwRXcVvUWAd2plH2piS0OOgxazz1HHDXc3LC
	Gj6iqKqkYWnGsKgo+g/i23gGOEaovwJUt+j5lG5a2yoDWJ4FqLSLmk9VAN2cHKemcg4oRaGEZ4v
	Kp3eIzXgHfFpVaDcf1euDTxV3D9CNoDgn+928Idx4+WVRX/SNQyvBdJjSxPG4hsPs1fkhpNZJDM
	x9F6S9gG5BgqttGuB9Z3Q/hCMyxpNoZtqlAcGc7zPt0M+/3J/pwNx9gwh6zwXuTvmOunv9MJygW
	/VOqel7VcGp+b+iFjc2qalsmWLlGrfklkY8sTeCDkoLFRZbcpyn1AM2eI6ZO4Emh/8q3wojYbYw
	6w1L250c947Iz6SuQaKcg+KbKA1/3tmGNlOzs6pO+nmkz4NEN/vnf86thcIza7NARmrRYLr1P9A
	2M1rMHxVQ=
X-Google-Smtp-Source: AGHT+IFz+W+LOVkc/mvbRQzmf7URynKEjWPmWrJ1k+my0W8wuZsxu8KFB/utTHa5d4gcjMZOnaEaPw==
X-Received: by 2002:a05:6870:e253:b0:35a:3ead:c6e1 with SMTP id 586e51a60fabf-3c0fad4fc0amr10583084fac.49.1760361939246;
        Mon, 13 Oct 2025 06:25:39 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8ca2a8dadsm3485067fac.26.2025.10.13.06.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:25:39 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f554ed252so2365321b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDVUueKuIbTerXmsmpj5ZI6s6sewlP4VTivnZX8Z/l/QwH+ZHvKh77+S5yuR+ZuIovvxIVhZG6HKrlIRY=@vger.kernel.org
X-Received: by 2002:a05:6102:cce:b0:5a1:ea0:f56d with SMTP id
 ada2fe7eead31-5d5e23cfeeamr7652169137.32.1760361596979; Mon, 13 Oct 2025
 06:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013094611.11745-1-johan@kernel.org> <20251013094611.11745-8-johan@kernel.org>
In-Reply-To: <20251013094611.11745-8-johan@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 15:19:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUdCMa=J+b-V5HAj4PO4n5omQrBCnDvn50Tq9k51ms7w@mail.gmail.com>
X-Gm-Features: AS18NWDIOZWB931lytCn5d0Cwy8mTK5kbcgRvwhEnOg1TMJB2gkH-KifQAV8hzg
Message-ID: <CAMuHMdUUdCMa=J+b-V5HAj4PO4n5omQrBCnDvn50Tq9k51ms7w@mail.gmail.com>
Subject: Re: [PATCH 07/11] irqchip/renesas-rzg2l: Fix section mismatch
To: Johan Hovold <johan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Mon, 13 Oct 2025 at 11:48, Johan Hovold <johan@kernel.org> wrote:
> Platform drivers can be probed after their init sections have been
> discarded so the irqchip init callbacks must not live in init.

Thanks for your patch!

>
> Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")'

Unmatched trailing quote?
This tag points to the wrong commit, the correct one is:

    Fixes: d011c022efe27579 ("irqchip/renesas-rzg2l: Add support for
RZ/Five SoC")

> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

For the actual change:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

