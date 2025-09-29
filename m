Return-Path: <linux-kernel+bounces-836221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37910BA9087
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0897189F8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CC2FBDFB;
	Mon, 29 Sep 2025 11:34:33 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4629D289
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145672; cv=none; b=mjUOdwLH24UfijJL9DbP+NhWuFAHOolFHlLuMRUYYrqSxZanFKu0KAL1i7/SjC5ue2Kkh1XwD6hQZkZPeWPBiezPUTFimyC4js1IIqyXqUURLGAOm2o8BDO76QE8UiOEpJNSm3731knCus3xaqsga2NzAOt3BcoUuUvOB06Kxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145672; c=relaxed/simple;
	bh=CyqsEr2YH2CBCrRlLUbTkQtjycgfh1uAGWvQeIO2INY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJGuuB3+6k+xVnlX10Wlk2ye45qCqi8a6ijjeV3AKX+BbTgf+0ny17Z46+b3DHIIDYir7Y44GUlQLSiuwWaNpXC9xZLLcOt1yNHziiz0o36yrDCb+9wbKoSrDbqzNkSC7QvNRMUzYEpB9LIoiqQmpELZWQ+CzD3dHfMUwcMhl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-58de3ab1831so3878754137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145670; x=1759750470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxW5mXe/+NcsYxkIwV9fCeaWAATP0wBLi6jwkn7jUaI=;
        b=k9fT7P8DTfye6X+zAWk4c8JdgGpW3omZnI9PFvgOxPKZBx/+03AOWf4O7MTv3avq+9
         fmE4gU25aqLurao5YAX5HA2OYbpZCl0SA3x/yv9v71fng3N1QrutNqxmWTit84sCU/38
         EwoqGMIo3fN0I02T9T8l8y+hBG7qy6JblobeisYxWht4g/eno6yl+akevHYvOxou+x5f
         W/Y7NgFsGtLHciU/1aJJ3CxeUrlppZjkzlqXczLtsPMLUVkw1oeQWTcbYZc3au8djK9N
         Etm0zbMWjsfui50poOi+mX0fK39eHL2o1vlx+h2rRdW1ZbanXrJrvPd6mtquGua9C+X0
         0Trw==
X-Forwarded-Encrypted: i=1; AJvYcCW5WT6YxxhX4jPLR0nRv0DRFu8cdfTrkQd5V9sz4v0o8iacFOhhCONeqWnwi2B/l59vTRIIX//06zHizEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGYFqqIAs325oSfYY4k0WPLzx10OG0mVznjCt2U8ZHmd2PTbP
	bUi4nLxg3r0WgvLWPXP3qPXmh9pY1I6K/ETAE0Bctw7fSD5z8Wie7fhXT4XykvUI
X-Gm-Gg: ASbGncsFhL9VcMtZpOmwYllGY9csHeK9glABkZ8MmVv2b+ghEyXG+TYn40aaEdOKKHS
	NosvqA28r7iv76cw2KMgtVOwWY6Cl2YdGTo9wqOuekAtXIvYKyxleY0b4NMEKhqtIspX5G31XKr
	ot3WKKhULb+p3rYuGe+kuVQayhzQSgzD82Y48bJmq4deKSBWSYbBo7o2cTx9NqZjNj+gPBvdVGE
	uYG8Sgyssl7k2pu6PEoRZFQ1OR82qN5yGVgAy6di0NLZXdjq9Ny175n0POJSX5PFn8hif8WcMJd
	6hnxIUqate4f5G3jYv0ba5ua7/79GAbieOHzBlmhcapJIwfSwj0U8AEZqF8ljpHB8IuVZ4kWYue
	BU3FGOe95wllIoX2cwkyuA/oNmvlYjU7GRlMXVzZBuHjNmPJWs4hqSE3smT+H
X-Google-Smtp-Source: AGHT+IFiM8ZujprfH51r36J3SNd8NhLgrkCnLW/i8i3+W1f/jLqXTkdltC+6aSPuZ0lL25OPhfIfQg==
X-Received: by 2002:a05:6102:390d:b0:52b:563:9c8a with SMTP id ada2fe7eead31-5acd15c4e1amr6198882137.24.1759145669829;
        Mon, 29 Sep 2025 04:34:29 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae389da765sm3291190137.11.2025.09.29.04.34.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:34:28 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5a265e0ec25so3677367137.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc+gKWPIjLqhKvyCw2P/d3Z6q0xzLCZbrmRU489diNWm++w14E+r9Ar5y04yGulWFpD+f32lmf2a8RS00=@vger.kernel.org
X-Received: by 2002:a05:6102:3a11:b0:59e:a2d5:2945 with SMTP id
 ada2fe7eead31-5acc8e94d9fmr6861602137.8.1759145668352; Mon, 29 Sep 2025
 04:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
 <20250909113840.122785-4-john.madieu.xa@bp.renesas.com> <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
In-Reply-To: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:34:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUt86L1Pcui8LD=i6hyqPQYnx=Apse8_h=YyFHAeCta9Q@mail.gmail.com>
X-Gm-Features: AS18NWAfMK9KQyXLWhPAcgQzNt-Bd1yk2_D_oAV-tjfTbvXk5XD0wBN0Yq448N4
Message-ID: <CAMuHMdUt86L1Pcui8LD=i6hyqPQYnx=Apse8_h=YyFHAeCta9Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: catalin.marinas@arm.com, conor+dt@kernel.org, daniel.lezcano@linaro.org, 
	krzk+dt@kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, 
	rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:04, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 9 Sept 2025 at 13:39, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

