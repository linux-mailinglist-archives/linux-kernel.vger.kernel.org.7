Return-Path: <linux-kernel+bounces-811057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4587B52381
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD0A051CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49BF3112A0;
	Wed, 10 Sep 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFwj/L7x"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58852308F32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539961; cv=none; b=U+mY9wcGxedA8NfnfKX2YbniM23UnIfCUUVjPlW6ihq+vXJw7HAnSn9+s9blMIJDH//8ezpAuR8dzzETVaBPfNVQWpODVbLgnKCduiWPhbU07YABxndhD5yq3/S2OOSxcuUP2y2YlJErRdR3E+hpRY5ElbLEVLlnqIUhSYO8AT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539961; c=relaxed/simple;
	bh=tDgFFo1KURd80WOddqneN0YLx5E89K1CqsHmGyLdaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc1fEsJcEfnCaOvUltVOaDjbm/vmM93pesCRM5MF9Mn1m1vS0tBZytZ6XlDLkqapQPLb4XSk5xrnbNE9VGM3rPlsQyR60XbgOBGBYiqO06IEuSQWQjk8NYWLm5GPRk79AcRWXN2hS0RXnPmSRKICZ2eVhY5g24oiU6XXRre7Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFwj/L7x; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so7939656e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757539957; x=1758144757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDgFFo1KURd80WOddqneN0YLx5E89K1CqsHmGyLdaRg=;
        b=fFwj/L7xMVLXbrafsiUBxoD7MAxOhttI7KRIebIj5TOl47/6pHUwstG+oyhVRiQKiH
         buogzFmlUB5f2PQDjgejothGY0K4DlSLuyCsKaBhZ0tYy4lRUpzbyL08aFN1uSKZ1bDG
         SwaDZh5OI7T4EXyuLarVGg7+a6/LkS9bvhR6We4NQQQm9ACEpOD1JoyqZFNVG0pMxHyT
         OnmyyfB8iOnrNVa4+KqMOsaWig6syyIUVmE81K0XpMJikbhDfgBXGfer5BF+4pI3T2Bv
         edIUKPC/nO4m6z21NHco09MtuTcljb4aeAAEChVIS3lO2OjtwTogOrriBFrM20qnVhOD
         xiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757539957; x=1758144757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDgFFo1KURd80WOddqneN0YLx5E89K1CqsHmGyLdaRg=;
        b=I57wjQXRkf6KXjaH9sOZHl+IlrAcfqBGCRiddFN5zI/yQV1qL9DZuka3lUI/2k2Ggt
         PDbXSyY7N5GwIW1zBJoc2nlDCZ34Obx3D21QSIeG6cDmvlUyZy0R8+d6qPU+E/qtW9RV
         SkS2RA8hl8t7Gyv/BddZd1PGFFZYJr0bRqXVsRDT7z1pk1GYq5D/DqRNxnYoasYhPToh
         V6uWwA4w3teHGuA08m+GbdNjov13iYv7H9NWjL0RpMCxplKDJEHsrP+gKxbWi18/5Cl6
         9IxUg9aZFHbOHJYdY8wDu51hoKqR/7pMuBKAg3JyBHTkv5RcRdZhp5E3TXeu+FVcBKKd
         w65Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTkH/OSKYSZumNlqZKKeHSccOvFpcVfCfJO1Utk8xM7PAYZsGb1dwnnSsttdaFqZgVEsAjNfOUPvTjzbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPRjyAPghL1RgvFIBhp3ozC3r0nnb7zeadooXxojoQ99D1zk0
	arHP+axMapz/WD6yjngV6yogRJ/w5qOCyF1B9HIedc+JrKfK1m2xf0H/c/RfAUhjjRH6TfWpH3m
	N0kW49y/1O9TtrDcNqg5Y0mU0T5Yeh+LjBLdmz/kp1Q==
X-Gm-Gg: ASbGncsUNUlsJCWEb7sCFPbGeodQa9XAPsoQSBKOwZN+dX5zEe5pGl+eWkfv2NPKtTV
	poGb+Y5SpduMcdk2JChloaUs4+jOY3n4hhWAV+5mzfaDDLX8ZnJNnjQ9YvMzamqk7KKF0E2yaYm
	2sK1PamRRYZf/9y6mu5QKE28LO0LekSr6GQgHwfWHy8W/z0BG8VHxGQFpN08QgZtUGQEGuf8EOK
	i3I5fCI/Ve1QVisMw==
X-Google-Smtp-Source: AGHT+IEDFgI45XU5cTVW9FtG8gM2JjDzoZENa8d1uC1g5vQQ+iix+RIzuYFh88VfTx91WSF4c7ZJi4duHEmeM7k85Mw=
X-Received: by 2002:a05:6512:6404:b0:55f:595f:9a31 with SMTP id
 2adb3069b0e04-56262f11dd2mr5910272e87.51.1757539957420; Wed, 10 Sep 2025
 14:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
In-Reply-To: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 23:32:26 +0200
X-Gm-Features: Ac12FXzHQO4QoWSTSppUbrZutew2n-HjqWu5POboMsRGiUcu6mJnWXdH0E38Eq0
Message-ID: <CACRpkdb=J+hiC5cu+g0Z-gqzpG8PgX01CXc4P98FfSSAf7PZEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 4
To: Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Sep 10, 2025 at 9:12=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Here's the final part of the generic GPIO chip conversions. Once all the
> existing users are switched to the new API, the final patch in the
> series removes bgpio_init(), moves the gpio-mmio fields out of struct
> gpio_chip and into struct gpio_generic_chip and adjusts gpio-mmio.c to
> the new situation.
>
> Down the line we could probably improve gpio-mmio.c by using lock guards
> and replacing the - now obsolete - "bgpio" prefix with "gpio_generic" or
> something similar but this series is already big as is so I'm leaving
> that for the future.
>
> Tested in qemu on vexpress-a9.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The patch set is a beauty, hands down.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I especially like where you caught local spinlocks being
(ab)used instead of the generic irqchip ones.

I don't know about merging patch 15/15 into just the GPIO
tree, that can make things fail in other subsystems depending
on merge order into Torvalds tree or linux-next if your tree is
merged first.

I would merge the first 14 and keep the last for the later part
of the merge window when all other trees with conversions
are merged.

(You probably already thought of this.)

Yours,
Linus Walleij

