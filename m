Return-Path: <linux-kernel+bounces-830435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E506B99A61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035FF4A086C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5772FE567;
	Wed, 24 Sep 2025 11:50:06 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DD1DA55
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714605; cv=none; b=YTZFO1ayZl871mW+cxLqAYl3xohbMZWAyxMMj9uvXh8A5I4xiV7hYVYywWaTW37ivcXZGgEk21+rzck7HVQztRw3odNLsb4yRL0+IPjXo7JVi0AtGvdurjoZrQQI5EzAFCFdHz0mkgSXn6dyQoIdHVVIvOp6RacyhoIrVMtholQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714605; c=relaxed/simple;
	bh=9tehMRz08WQLUJ/smHN3UjG/IZMKp1SRULcKii4ippo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOO2yd6NuHEZe7zJ9arcohVouRsnFMdK9T1fQu9iMURO3CWxN0Ic93B5TYPZ1QSY3p+VtV6esACzlq68DbtwoWm3CXFO4hHpKt3sYpLZTNUn2C+JKAlTDj36TwdUcyhqlaFp73FCaHtiPs4r/VX0xJqwR1WXTNTfa3Y+yIJqSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-574d36a8c11so1929158137.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714599; x=1759319399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UvM+/QBcNnuTK2u1snMXMO5HJEe0Z5rWe+7sqxETZ0=;
        b=LxqrgXBbrp+7RBAaVL9duZDCtghvqGWVumTOiNB/BDszp9ZGWnNcQKogEFVsHYAO8y
         n79v1CeHMiKWRDEpD3r+b0+iwC18oTEhT4x5SwkSD2zZe0Zi4uS5g5dxoWHqLfCmQrW8
         mPruYm7kqPl0dOGMByTE1fJXVnWLcG8rYQqRmOAyhiemMlLORbCospX85EmcfyZvH7F6
         yITnF+a2nVMUTVVU6ios0d5eWlFyp1nr8Ip9X18VEYs5zRJf8Ts8Ga//XXPwv9jx2LFc
         bAoLEMS+5LfnSXZQzodDZYGGsrZPkrBjSq4/yD61Nt70XnFYeldVsnrrhcjdCKZ40wMc
         T61A==
X-Forwarded-Encrypted: i=1; AJvYcCXIwn4dbpXi+lRmXnyuwOIX9XfnR3/sVKzhl1hWOq1sQ8xVMkdP0EcBr8MjR8vA1O/Z5E7OeGmgZnuGCbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaZcX3vgLNchjZBwlRXnrkAgAGRqEvkhRXXcK5cOKcFnUy950
	2OYoCgL2qGUBoBdSnk5HYsCcO6D18vqJhK1cU02qPkT8czlm5b0f9zaN5ZCNYkjV
X-Gm-Gg: ASbGncs9p6m9Dnm+fpcdGH+a1waDO12OgImT5Czk7z9Sn/6dMxv7j89G6SH8gqHrCK+
	9LsOvHl+dDdn0q0G+/zOKW60mGs5FgMVdd+M1yq+DPQQjqrfI4eISHowihr1DxaIAUTdmOhvc+l
	EuhgiFVdPznJPxh+dmIZEVjKYKQqWrsr+teUcS68ppBnmtcKDwlO8yYLnPFtYz86/kaOm5XK9w2
	omGgCUXyvm8wYcY/MHKH3rO1HXJe0RJ+sDV1aPnbSU5sKsxJmwVozRgk1MOeIkCX+7pHiXr8gUd
	mq67B4ylzUZkG9dFElZbPz2twQ7Tr3hqElBCflJ93Cwz+XStXPrr7SXt8791dUXYrPMxfUNn+u8
	+ptz/HcfV1GBn3kQoSCG3DIuyx/Vb3RxYl4K169+TKfzD03mkFYdt4qomGRKR
X-Google-Smtp-Source: AGHT+IHx9XF2HANw4kns58/tNChv+iLNtj23bLnzX58c/l+pHWb6MN25migpqgMNx7qXoJUMw1YGNg==
X-Received: by 2002:a67:e7c1:0:b0:555:6892:5725 with SMTP id ada2fe7eead31-5a5833f1213mr1879725137.30.1758714599234;
        Wed, 24 Sep 2025 04:49:59 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e58e736csm2984270241.1.2025.09.24.04.49.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:49:58 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1454615241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:49:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSqtq+48LMacno1yfDBooUrVBOJvqQG4MRm/YLzdz8oMtogyp02wSAN8bvRQ/bVp/rm02xc5ndRxXj0x4=@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5a57e77391fmr2023739137.2.1758714597528; Wed, 24 Sep 2025
 04:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250923160524.1096720-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923160524.1096720-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 13:49:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULfR3PZVdh4=2QQv5N3-J8kH=3--mPS5ckkd44Xf8miA@mail.gmail.com>
X-Gm-Features: AS18NWAd607zcV9Nbln-a-J8dRoED1AjG1taSvoUWP2QDMqIsRBLiGt34BtVpEo
Message-ID: <CAMuHMdULfR3PZVdh4=2QQv5N3-J8kH=3--mPS5ckkd44Xf8miA@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: renesas: r9a09g077: Add ADC modules clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three 12bit
> ADC peripherals, each with its own peripheral clock.
>
> For conversion, they use the PCLKL clock.
>
> Add their clocks to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

