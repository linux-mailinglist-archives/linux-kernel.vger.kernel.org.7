Return-Path: <linux-kernel+bounces-811518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 691EFB52A38
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B163B4E0ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D64272801;
	Thu, 11 Sep 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wCZbMyiZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84645273809
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576309; cv=none; b=VY9mVUwY3FTqqy5rbi090b1vWWL7PjvoNo8pkijri/dhAz+fQushhuqgVAaL/2/T8Fh20n0GWK63yXs11CH4gwpLGxUG8grh7Ev3bv5/4md91nAAJoPUWw3UrxrMqksox6xAEw/hdc5dj1GgXS4Yp1ng8DsDRHI8omaLIhjPIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576309; c=relaxed/simple;
	bh=jUK8rXo2J6tdIuNkdbMKBrXU6Rird8FTI89p+KzSTdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3Kf/5Cf84bnJ/+A8XSWx5K8I8QEzY4PbVSW7cLLzRZuE8bAROz0TAT5eWjZI1XzaRsJlaO+g43oT1Ag1cwdRuCQdue4q2Lecti8G5FjrKuW4ZU2qSOebJiYaZuytNgDkKos639kze3a1a0mBpAaPR9p6DPLEk2i+jFLx5p2rlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wCZbMyiZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-560880bb751so381860e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757576305; x=1758181105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUK8rXo2J6tdIuNkdbMKBrXU6Rird8FTI89p+KzSTdU=;
        b=wCZbMyiZTwJnq9pS7/KeUMs+A7K9WGJRXQ5wonRBAknPQ201tGoLXhinlxKm1zXhWe
         Xc31QrJO0CjLxC6AWuLfc50kiBT8sDV11mv9jWVsa6D00hYWx1riUdBmeEw0V/IREp9q
         5oQoBmP9Y4wnjXcls6gxP0vdNV/BHZHoDGTSQ2/Ie4x0iNplUTRE5wMUxgzrUw9vnGms
         9zof++aiF99/+XvbCkQGKJlYOvX657iPx2MDmQXOxI+lzfWWgtt4l/P4aHhnxAtjELej
         hMUpL8dYFM3uUIFTXerUetDPXV8pOfq3Bw3g+tQK5Rr17bLia0tbNU42Ol6IPqPLUeGL
         x71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757576305; x=1758181105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUK8rXo2J6tdIuNkdbMKBrXU6Rird8FTI89p+KzSTdU=;
        b=V5UZFz5dzeRXG5K4p8XmfLkNL00qtV0vHsVzRjfjo8l7kKKjaj+H1wZdINxPB8Z/mO
         Bn2BJXA79bk8vUlh52T32ws0oio1Grqr+MQydETjbYQDV9t9er/ng72HFEEPJyVPOPR3
         5uasSEc1sZwrCX5y+M/TdF7PC0cp/Xi8hK9/pwRvxzclcJ2wmm6fKbwi5F1sTj6dvoNe
         S4TAnoWUeWofKS74Nm/bbVOisQVvxuQThNm+iDNItkhC+45fUmxhNU0reXKLG+hbOf4r
         BYzkl7iWb0RkCPj+HBoDAELduPDNKTnOtmWIkzlJzHu3GBnoiqGdj6gi3k2ETJMQVBs3
         d5dA==
X-Forwarded-Encrypted: i=1; AJvYcCV6R7+P9uvqZERiyHbaIV/okAOl/PXhJGRRjLorNbaLcBlT1+53HiFRpFull0mN/SOJsC0v+UU+2DYqouw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZqU0CtQYsPzVmj/PGcgxO0kP/CghbKhHfBcYu3ArvaMOkL+/
	q7Uo3JkTAeV34ABd21Lw+xI7wvkH2CFKy0G/DyTJXARjNR3hagJ4EZi0EBu4fq7vsW3FFVw4SeN
	vdkweDgAyvQzPNo8MKbsioDINPO3K55y/gSEnnBxaxg==
X-Gm-Gg: ASbGncukvod2hnZ7LKL11Y/MVhM+O1KqcCNDg5OQsS8N6GaQ1nRTFAifMg0ORMo6wP4
	BDRuXtDzJMZU4OOWeiKl6HTQCE19W2MwYOTKOGKtRA7OuLRLpLIj73nOvvUexMGnvEszqwe2uSY
	95qYtWWU4ghgETfgmse4RDZZQZbYq9Zph2dfCiPJEeuOW4Xlq8jXQZKS26tQzTcUKhafJ5v2/3i
	4ZqzriXzdUDXIUlJV/cn8PIMCV2yfGFkRofp0U=
X-Google-Smtp-Source: AGHT+IGFKCUUrJkt+A6v+xuc1LQXhwUm4KpMBhnA0hSfXgMQG+z+UHy3svEwymKETUJXd9ilc9E5haoHU8vK2eJzapg=
X-Received: by 2002:a05:6512:b17:b0:55f:498f:f08e with SMTP id
 2adb3069b0e04-562614ff71emr7447870e87.24.1757576305171; Thu, 11 Sep 2025
 00:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org> <CACRpkdb=J+hiC5cu+g0Z-gqzpG8PgX01CXc4P98FfSSAf7PZEA@mail.gmail.com>
In-Reply-To: <CACRpkdb=J+hiC5cu+g0Z-gqzpG8PgX01CXc4P98FfSSAf7PZEA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Sep 2025 09:38:12 +0200
X-Gm-Features: Ac12FXwiBbcmTD8LlFccmOHZdwwoOfYFi61pHLgjut8Pxa8sFHcycGYwle9xiUk
Message-ID: <CAMRc=McbadZx1yK1jGeyUnXAFZgfA8YpLwacmqC0eMonS-c-9A@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 4
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, Alban Bedel <albeu@free.fr>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:32=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Wed, Sep 10, 2025 at 9:12=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > Here's the final part of the generic GPIO chip conversions. Once all th=
e
> > existing users are switched to the new API, the final patch in the
> > series removes bgpio_init(), moves the gpio-mmio fields out of struct
> > gpio_chip and into struct gpio_generic_chip and adjusts gpio-mmio.c to
> > the new situation.
> >
> > Down the line we could probably improve gpio-mmio.c by using lock guard=
s
> > and replacing the - now obsolete - "bgpio" prefix with "gpio_generic" o=
r
> > something similar but this series is already big as is so I'm leaving
> > that for the future.
> >
> > Tested in qemu on vexpress-a9.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The patch set is a beauty, hands down.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I especially like where you caught local spinlocks being
> (ab)used instead of the generic irqchip ones.
>
> I don't know about merging patch 15/15 into just the GPIO
> tree, that can make things fail in other subsystems depending
> on merge order into Torvalds tree or linux-next if your tree is
> merged first.
>
> I would merge the first 14 and keep the last for the later part
> of the merge window when all other trees with conversions
> are merged.
>
> (You probably already thought of this.)
>
> Yours,
> Linus Walleij

I already have both pinctrl and mfd changes in my tree from Lee's and
your immutable branches. I pushed this into gpio/devel and it built
just fine.

Bart

