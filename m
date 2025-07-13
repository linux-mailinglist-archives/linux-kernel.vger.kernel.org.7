Return-Path: <linux-kernel+bounces-728995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C34B0304A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644371A61844
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901AB259CB2;
	Sun, 13 Jul 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AY6/d0kE"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB8221F37
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396499; cv=none; b=UWBASjVfd6ELQtez8sGkchaOUoGuwMQt5OrfKL1SA7hmYdyQhkSXsSrHajViA2N9ykIScGe4GtmPulxwD1dg62/VVRWunPYpf3GkELP3+BJ9MXZhzsARZI4mEktP+VOqCWBw2fO9BMEhokgO6RezC7nGMZjMik3oKx1+nbkUR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396499; c=relaxed/simple;
	bh=4b1RzhGLocyTqgEGos+nou0Ocqh95hmhG4E0aXCsinw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxNYrfk92drR/MGhngRNWax/YdKeC+QvhjyO14yGJlZ9SjHF/ni/g9gx604hst99N4iRkSOfQEsYvqGlzVxNx/beZ2p8SS3MyqACewl4sJQWPNoA7uED7iH8NHaPvD7YMkvov3d08gmua/Gi8bQVPh/EGKbB1L0xidiFcnIsEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AY6/d0kE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso30047631fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752396495; x=1753001295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b1RzhGLocyTqgEGos+nou0Ocqh95hmhG4E0aXCsinw=;
        b=AY6/d0kEFQloBrh3Cm8qZkMyoe97p2cj9FwQjAUlQY2aY/w58ROLPNnfb9kX1bAp4a
         i800kJtLMbXaY4QOKQyQJYgP+bX0LBxt8GY2kUfE+YAbZHT9nvJte6+rx/CSlCkQoE3B
         HdlIOCVai7WNW9eX/pmKc9suQlUKzGBY1gL15seqDf1ZTuHEHJ4B2I6/+AMV/CWP4Y/O
         q48sal1g0AZ5O7ipHH/kg7ilw3q/6u5sHExZHZ+r4TbEyoGzvkIajcOc/NtDB8fnCr6Q
         VuGMt9r09yX8I6pP1QAnq/juxhNOLi/HvSW98Gr8LchRuPpvKUqKYGZvpuAAfZJgMN4S
         u1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752396495; x=1753001295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b1RzhGLocyTqgEGos+nou0Ocqh95hmhG4E0aXCsinw=;
        b=YJ9I9dl5qfgozESA5hZbdX7wwG+SAGnoCfT4L0Ejyol7is0nt8WNTV+1nmOn3QKDDH
         hps6+3Mdh7DV2CHUVsppy36thoyxGZQahRTTlF6D8tuE+dXG0K4iP51bn5tp1JZjK7gy
         x9cdsCVCTGIKT8uFSnmCEP97CY2ihPAcJHJ5pyKeL7jLLAH/Qz7YqgpqSGv/Qie+6yrr
         is5TtSEnoO8JpmqsBGpZ0eybVGfC09MLGX0yfTzQyI3CzN4rdGuuYoIQahQeizENWmS8
         Ffv31BPUL64yc+4EQ0Cl090TWbuFvkgdYX9S68EqSWHgxtXw8zU4tvBO8oLg3J9sDIaJ
         9QJA==
X-Forwarded-Encrypted: i=1; AJvYcCVmnEYjoAoBpZBkP6Vzzj2+NtCYlHtbuGEwgCITo6yfpeKKQgRpjSSaYLlpXpUVLVEau9oKadpZFIu300Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYj89f8Q2j1mNypXfu3wspcZVLxA+rsbbgIkkPd+B0y/g2mgh
	vwhVQzv/wrDQ0Jp5sRPtPZWSjXxUNti2CLCKhyjrK46WxRKO6bDBIyc9L9SlgjSJUCrwgN0jh13
	sDxCqfZBXRQQ0EofRuxdiJzCfQpNF+ec7JhaYb/qHeA==
X-Gm-Gg: ASbGncukrvXQeph9fbrkrITJpEjaaRMPv6/HW/9k429x7c2wW+JSd8mgV4om2mQZI6S
	UHXkypfzBvt5YfidzkOuDULFDcqEkz/t11T5Brfd2vu98vkwZ5vjUJv/5rtEix3TnUHrV+cukxD
	e2P+HJuOj7Z0gbKf7ksCwyKVQWfECAB73x0ARDpVAzYaes00NNx7b+TtBCxN16u1sObvweNtft2
	oYssbg22Wtwngh6p5N0E+E+36jJ1JoeMTk+cDA=
X-Google-Smtp-Source: AGHT+IEMQ8qvsT0gD49ppygPji2wl8zH8MMB5P85cSeLdyT6vPgvgA6klNb2G5Uxgqr1+aVCiAF1x3H8jZNhdEI4lwg=
X-Received: by 2002:a2e:8e6b:0:b0:32f:1f1b:1e68 with SMTP id
 38308e7fff4ca-3305335d25fmr17946411fa.18.1752396495454; Sun, 13 Jul 2025
 01:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-gpio-sysfs-chip-export-v4-0-9289d8758243@linaro.org>
In-Reply-To: <20250704-gpio-sysfs-chip-export-v4-0-9289d8758243@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 13 Jul 2025 10:48:03 +0200
X-Gm-Features: Ac12FXyOzkUIwK5gHvio0xjvAL6VpwaDhTwgxCU_kNCh0r_CV4jxSET5k5vQkuQ
Message-ID: <CAMRc=Mc7HaVjchDWN_oWUuqgVZbj3ZVYvU-bwiA+ZUH+0gEXSQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: sysfs: add a per-chip export/unexport
 attribute pair
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Kent Gibson <warthog618@gmail.com>, 
	=?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Marek Vasut <marex@denx.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> Following our discussion[1], here's a proposal for extending the sysfs
> interface with attributes not referring to GPIO lines by their global
> numbers in a backward compatible way.
>
> Long story short: there is now a new class device for each GPIO chip.
> It's called chipX where X is the ID of the device as per the driver
> model and it lives next to the old gpiochipABC where ABC is the GPIO
> base. Each new chip class device has a pair of export/unexport
> attributes which work similarly to the global ones under /sys/class/gpio
> but take hardware offsets within the chip as input, instead of the
> global numbers. Finally, each exported line appears at the same time as
> the global /sys/class/gpio/gpioABC as well as per-chip
> /sys/class/gpio/chipX/gpioY sysfs group except that the latter only
> implements a minimal subset of the functionality of the former, namely:
> only the 'direction' and 'value' attributes and it doesn't support event
> polling.
>
> The series contains the implementation of a parallel GPIO chip entry not
> containing the base GPIO number in the name and the corresponding sysfs
> attribute group for each exported line that lives under the new chip
> class device as well as a way to allow to compile out the legacy parts
> leaving only the new elements of the sysfs ABI.
>
> This series passes the compatibility tests I wrote while working on the
> user-space compatibility layer for sysfs[2].
>
> [1] https://lore.kernel.org/all/CAMRc=3DMcUCeZcU6co1aN54rTudo+JfPjjForu4i=
KQ5npwXk6GXA@mail.gmail.com/
> [2] https://github.com/brgl/gpio-sysfs-compat-tests
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Alright, so what are we doing about this? Should I queue these patches
for v6.17? Kent, any additional comments? Geert, Jan: did you have the
chance to test it?

Bart

