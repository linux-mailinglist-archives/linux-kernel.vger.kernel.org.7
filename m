Return-Path: <linux-kernel+bounces-833926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950EBA358E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C8C1C04D24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA396299A82;
	Fri, 26 Sep 2025 10:30:38 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA52F39C4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882638; cv=none; b=OzngGjJAbepsbKl3nkuPf1XLv1DmEOdFLyd4qXptN8updJ9IjIF36122AsHExwaaSI93PNl1rtiQyON4iw8jQaCfCiQUyc2mXfJvB+jwOWkVWSFlRZJPCrD8sp2Cqs4N3pWmFOAzUewaeqPKQCiFm2VqvNw/M/Y/RFkAW28muHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882638; c=relaxed/simple;
	bh=meSxc8wrYtkbVLWzjZPTLzds/Hd25Wzn0pY931UcZts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqoPROiIjUv9/CkJNoREhR+mBAhPblf8SaGcHfWAX9cpEhTwXN0VAxAeA7hd6tw490B0Z4WiE7n6R/a+0iMFZ6eoiLOgnfnu5qv7O1m3BNogiM+x9JP2GfGy9nJVav9RxM4V5R+wyGHXlic6bXEgGR458p441XKNvipkf3IoBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-59c662bd660so825324137.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882635; x=1759487435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udD672uKdPtCim7NmlDurpPdZYBL+0mV4DdXmMjUq+o=;
        b=dl6wNJzBsWOAmEbMMQmIugQgwBODw12/l9zhc+JNBz+SkjsAwoVmbHn8PgPfIAkVIc
         78DWVC9zHF9XwosgoToXxox2HAkCguJXH5hrpeLwq7H0p2BBGKFuAvzlgd/oCNR0mMDz
         CTg0RYTvFT11d/pf0VgT4u9orT1E24KW/nZI1j0w0xCG1cTRFDqUHi3WQtEsyNUzCAS8
         n5SMlDO/PXd+MnaK13v+ALa6TWF2z7tYFt8FNDmHiXAqEJKxgPVC19EX7SF4JvFkdYxq
         SyGAkjb7xN6GJeew7vNQS1wbuiwBPJYeDUZZbT3tSUjdbXLO5B+IcPQNoqSLWsFL5iSG
         r6PA==
X-Forwarded-Encrypted: i=1; AJvYcCV9P9Iw4iCOPXVYH9SGtK+Go3vEwd42BI5Qlir8zF98GZJcB8c/5cMMOTuJmqszFgJuUIofpkiXMyNoyMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qJckbMD+x6K5rFp8/m8mA1DJ6S0OLi2i0RzetN89k7r6K89F
	xs75IbkDoUZGiEFg82rVInc8i3Xbml8zoQvfS30y4pcnSCX0eKdAppxq0Vp41DJd
X-Gm-Gg: ASbGncu/h7kl5CC1zggi0pigJ55Dl4SvoWj1yS/eeXojx7ZFRZ9GCyd2/QA7Yx8Tik9
	spbk6gw/8/z8B9L1IDVuoYnnrido3p0xh8V2D5bYJwyWtdNrLd4uK/3J0uJLpr73q8Zk0agpt/f
	ZJNYboIFBwB8U1m+DI8qE8ewLLkj0GkhFX/8jgbh+Y47X/60NmlGqaFof16SlGCntEeR4Khm+rB
	x4QIS/0EyXzhs3pFXANn9KJ7ImJVbHqYOAZ2HbpR+rIIIcEqYFTckhEoo/m6G2It1Ue+xdlZ97l
	HYle2yXtMEKTYDy86cN6cuN4shX4AqpWuRbx89W0ooqA19ZOEdmiYTs1Bhe1mAoHg4Ury9ZshyO
	aFACuRBMes04wre1I0muIDt6hfSstOA547MLisuA7JBEoNSsSckeHAwF4h0Wg+EseYRlhADQ=
X-Google-Smtp-Source: AGHT+IHE05KUr5MK4UVv9QzSJ00lpSvoPne+Iz5xVvB8bGkcyfp8mXo2P1fpxY0GA7CkImfph/uUOg==
X-Received: by 2002:a05:6102:3906:b0:4fb:f6ea:cf88 with SMTP id ada2fe7eead31-5acc6240067mr2655766137.10.1758882635069;
        Fri, 26 Sep 2025 03:30:35 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae241319b9sm1292834137.0.2025.09.26.03.30.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 03:30:34 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5838680e242so604890137.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:30:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbcKgm7Q0p+48y45Q2XhBYcDqJI7GeI15hJ7zFy4a5CINUfPpLUzy7UmdBXw110SBgw5rjysJpBDMwMq4=@vger.kernel.org
X-Received: by 2002:a05:6102:6d2:b0:538:f3d5:fc12 with SMTP id
 ada2fe7eead31-5acd0935270mr2716797137.32.1758882634619; Fri, 26 Sep 2025
 03:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com> <20250923144524.191892-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250923144524.191892-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 12:30:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXM+CBd0=dqG3DnfU5NAup5AH+T_w35MFi3B6T0iWAqQA@mail.gmail.com>
X-Gm-Features: AS18NWD7sjtTfJ_M9h0NGs84Fgd5nzj22GGL5o6mTQegvldoQrfGgdyuYCG0Z6c
Message-ID: <CAMuHMdXM+CBd0=dqG3DnfU5NAup5AH+T_w35MFi3B6T0iWAqQA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: renesas: r9a09g047: Add GPT nodes
To: Biju <biju.das.au@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 16:45, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/G3E SoC has 2 GPT's.  Add GPT nodes to RZ/G3E ("R9A09G047") SoC
> DTSI.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

