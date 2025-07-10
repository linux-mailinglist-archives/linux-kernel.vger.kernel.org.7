Return-Path: <linux-kernel+bounces-725024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2BAFF9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D348A1C4294B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3128725D;
	Thu, 10 Jul 2025 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kCwIMIX0"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276622CBC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129234; cv=none; b=UY0JiZTq/Q5v7JBy298/zCgmcG3pKIfyU6O0IdxTQUqCD1ImMjFYFrmmId/lGhk1eEh7Ytaf2VHpVK/szlI9B/+PudEm66EY8sbh7MKf2QDUXvyY/POInVExZnU65TBQUNyMoEUBPMiRFMQvFUc1IH11hY33qN5n9Wcx6B2kwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129234; c=relaxed/simple;
	bh=fj6W66sPr7Ji9329jAkLIL1CrVKPhluEPji8nUmmCag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekwIXghug0tQnQdcSjJemyED/hmLTC6XMMma9ryrADwy/JXqQWM7O274m1RuMz8S0VglxO/pd2pyQqSi33t0X8bD6B/4qlGXGTAxBBNhwl05Ycr2nCYU4uSycdQjADYllwod4uIjo6vXN1jEkd+fj7w26ZSMqUgyfXSXmzs2KJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kCwIMIX0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e87c86845d9so477076276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752129230; x=1752734030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOfKyTSrKEeE5mRVGbOkpddwy61Hvu8Xrql9GC0LhTY=;
        b=kCwIMIX0xI+FF4eyIrZKYmYLyUmzCNhlOe0IvNyklrooYhLtDrAxlbm5hlLdUagTrs
         szRok5kM5ROl3FWGYSBIQrA1CVZvKpqAMKvCeTKvm4bJ/qqAQWis9OT3yIu3cq68y+GS
         D3c6xDvvN/n5S8sAnEQZy4FGrNnKj1jWJVgfOKhpTJqa1qXM9gPcZhUi8aOcELee5LkM
         VnAHdnllVtJ8IEfO2FZ1fcqvV2oqgj/JvlrYbRPASCQcaMoH+zbbeQzYpBTmGaYl89uH
         0QCftfGvgIQvsA1Gt8eXf86EiqtIeVDeOxUXAqDmQcoBsqhLztsiVemdjl4o8PmyfOVB
         eXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752129230; x=1752734030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOfKyTSrKEeE5mRVGbOkpddwy61Hvu8Xrql9GC0LhTY=;
        b=ZSP0yIxgzPp2G1KLI9yzg7+UbTOif9il62tOxngLnZ2sBY9U2uDGkiR2FbJLGw60W/
         V1G+1eqhWYTuZunSmGR01YUGxjQNk/TDulMgJ6ZRS903bk475Pq351PDd2E3eUwgE4xo
         d6VBwE4BwNlEwczdTwM2ygpCkENuzppIzcuX2Qfr5PmnJApSYegQ+4u2n1CyZvwhOd18
         Ws6zXtE4yO1EGTFmTYo5qN3ZRV3R21/YPSb6mrHdIDA9N+BSUqdXf1IkorypliLuDsGj
         KA0V+SdrzPPWkYxJ3qi+Sp+iYk1Ge9q/gsT/yopTdcygFy4K16an2vNVwhalWdOYJ4hA
         TcYA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7UQLnP1JUSjQjpAjlLJzJgrpQNauv+4m8FdSpLIjauPxPLTgFJF63lYSC6G/QjtkBl0lxmEMu6ZNRsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQgxTfFQi8mMAhsWxY5EAWMcJI33XrClwa4FaIS/lBO9zdR1D
	VchRMgQ+hiVfqUT9GitzRTUnsOO7Luy9rJkX6E+7ZKa0G3ZQVWX4CjqJDzMM3lxApZhxhK0T35F
	7Iu65SjsjRScvGYQPvkoYBVYCaiDPo70M0GZZ+EU8/w==
X-Gm-Gg: ASbGnctS7FIJ6Y0EvCzo/3BCeVuGQa0PyB3AoHNceQvzwsKQDXlFvtgCcIlOXcJurMg
	RcL9jvHgQXdFQ3FwoI82cAUTleorWOIov8oZkH8Y52kaGmLffAOepwIKr0hUpFCmQ9OrLpu6Cl5
	P2YFgwbdnFaHqFkxHKQ0vJb+qDYI2M02XQlJf8oVfEF7WM7PIuaWsLw41o6GdzWEo0
X-Google-Smtp-Source: AGHT+IEUEuXYe+AiRoP9sKK+Q2LJ7hkbYYZRPRjU65Kj1Wu6nsLtbs1bxTc1Gn9tJMDj6XgH3uwUSmTRPbmjpClz12M=
X-Received: by 2002:a05:690c:7405:b0:708:16b0:59c3 with SMTP id
 00721157ae682-717b1a8aa20mr78370367b3.33.1752129229913; Wed, 09 Jul 2025
 23:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <175198458423.86859.5882458274157023095.b4-ty@gentoo.org> <20250709063738-GYA488894@gentoo>
In-Reply-To: <20250709063738-GYA488894@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 10 Jul 2025 14:33:37 +0800
X-Gm-Features: Ac12FXzWKaYp6y1oSJwNCeBf8VLK9_pLF6KbvY2LESuIM6jHvBvBU0Xdd6tceRA
Message-ID: <CAH1PCMaZYaRgUoaMfDLyqwTv3n3NUaUL8tHr8SoTq=4ayuvyhA@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
To: Yixun Lan <dlan@gentoo.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, 
	tglx@linutronix.de, hal.feng@starfivetech.com, unicorn_wang@outlook.com, 
	duje.mihanovic@skole.hr, heikki.krogerus@linux.intel.com, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:37=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 22:33 Tue 08 Jul     , Yixun Lan wrote:
> >
> > On Tue, 29 Apr 2025 16:50:42 +0800, Guodong Xu wrote:
> > > This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA dri=
ver
> > > and updates related device tree bindings. The changes enable PWM
> > > functionality on the K1 platform through driver enhancements,
> > > configuration updates, and device tree additions.
> > >
> > > Functionality has been verified on the Banana Pi BPI-F3 board using P=
WM14,
> > > configured as a pwm-backlight. Per community feedback, the actual
> > > pwm-backlight node is not included in this patchset but can be found =
in
> > > patch 7 of the v1 series, with modification of pwms property to 4-cel=
l
> > > format to match updated binding (#pwm-cells =3D <3>) since v3.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [3/6] riscv: dts: spacemit: add PWM support for K1 SoC
> >       https://github.com/spacemit-com/linux/commit/9aebdfc21f755e0d2766=
683aa251435fb656ea47
>
> found have to re-arrange the nodes according to ascending order of unit a=
ddress,
> so here is new version I've pushed, just FYI, please check (should have
> no functionality changes)
>        https://github.com/spacemit-com/linux/commit/66f56c7a6421394834152=
1b5310064586a05c80e

Looks good. Thanks Yixun.

>
> > [4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
> >       https://github.com/spacemit-com/linux/commit/8709d51024068d4c81dc=
785d63169d283d147cf3
>
> --
> Yixun Lan (dlan)

