Return-Path: <linux-kernel+bounces-892734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11264C45B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD8534EB1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216B301021;
	Mon, 10 Nov 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p2CMFFxd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB00234964
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767970; cv=none; b=NtIzQ0geHpehPWVAjekJDNqO7dKOL76iHxLPRLvNMYCdiIILT7DZCSfLPqoq9UPIENgRy17eFrgnh3ISfflwyFrY43mEPn3CFpwAMTkAYNRgkSN4VljrTNBtMyRyzSAQntzExb9/qyxLvIrl2dvMJOwjIyzsnPSVrBh6qBYwOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767970; c=relaxed/simple;
	bh=S1wGfyaVdsxk2Z9k/75oWbkAnuDI8szZ8sPaIPGsbg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYkQCdk4Z1Wfh8X60mihr9EmRjHUZSUxC8kckJy8m2NroAFgaV8A2fdrd5ff75jdfOVN4A629nwl3p9SZZaJhGUsAOETKd06hM0t36AM9M0P+Xq/FOtlzoU41f0kQxwekeOSzXjZJi85pAGUqM71pDd7cQOS4/YFXXrFzNlazZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p2CMFFxd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso29820341fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762767964; x=1763372764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1wGfyaVdsxk2Z9k/75oWbkAnuDI8szZ8sPaIPGsbg4=;
        b=p2CMFFxdz/LXcki8b/9cQ63b1+vPg6eVxWnP6h8Fjc08dAAs/BibvCUlORK3rO9SGk
         CSbG4iXmZbM5+KC11hm2SEnV7BgdtMZrMONK36sbkrF69f+5rh4z0sn7Mmp6pHn/fvVw
         nkEaB075udlFLU3IKgs7tEIFG4/PQzkf9sAA028wJG6pl0m2fM1zYA4SxOJsA4IYpJhy
         2v1K8l20JvcJ56iLY690oB2e6BJJG8HFdInZrVobJB+4S6AGntT2Nu1O1dqcDXYuc94u
         qY1sIi9BJndrjtIUG5d/T/SyH31lEBEh+NTt/qMqaJDKOQ5X9HEkqzpHDCSR1tsfieBp
         eV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767964; x=1763372764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1wGfyaVdsxk2Z9k/75oWbkAnuDI8szZ8sPaIPGsbg4=;
        b=EG3Emtlsba/6ts/H0x6LGxAwvVOxyoeQj96Ghfw2kKEH5AhIzY0fKvclRhwZe2RoU5
         3ArNUIAsIhTW9JUxfxWWIQAVBt9/vvZpGv94CO1rHRMntGwmv2J3E5Ov8zjvQHe+aCpm
         wnKIWQ166OlRad4iTfKiV+gbiAO5J//2wjwxZM0S7VAEbYaZJ7WMyMGUH7/bmZGppcTb
         wc+dgjox0MqxWGf43ILK7IHL4f33nlKjAdVji0+ue9m7hJi0K6VTxliHMU+FLSzFVSUE
         ClBlcRds2YQHuhH//+6X8sH4bUC5PNbUSkJF38bDZkRF8M20JyTcMbk4SGoWYVnPlcJ3
         Jpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVuAeo/q1JcbB5Z50L/+Lc7B9YLdKL+9z10NRSlMdt7zZs/EFNnP8X9T24AaoXISTwObES3WEg5e7JMH1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlV3iS5LnAdR5fFhtSGoYGeZBiq9nPwsmMSIWdNQQmq/Jlh2tD
	kxoiguq/IFHWC0D3RWlp5I7nzMj58XuEm/MMJ4FhyhDuvH6mE5XkzMrCay0GKxKBHJibITPG/4D
	08AqxERcyxC9Xbtc8ugjLscWS1AfFJq+nJ8466yODmg==
X-Gm-Gg: ASbGncvpcQlXAfOzjN8Fe6kZiS3+NxkdvYxaK3lcTvo0V7ZqmE+i7h0fE8ZgkbL3BQ1
	WgxV8Ir4BjMeBoeSkJ3lmLaeitPGZXd1YG+xBWDyrMgF5hfpaK25tGBU0VUQIqoU5zhPovEOJBw
	6HhTDv8Y5sGa2FJfEUP2F+OFCHD6ECYGAhIe5UMGWAyej0dFyHzYJAeyP7cL5FCax9YUX1W5fVL
	eE2F9Qkz1e1PKrH6Yr6bZUBcbAautw1DwuydQCdXztm8v/5b/lPeMKKmqTWvYP583y3EpzMn3iK
	hoKh5lFf0S5Qe2LE+trMIG+FHH0=
X-Google-Smtp-Source: AGHT+IEapDIVTd3K1bAU32YeDgJ+hfEUFZ75bdtJQQ2tm2wsLYYaIB9HdEFBH57etQ4VQO2ruXk7jNm7rMa1KIXieBs=
X-Received: by 2002:a05:6512:108a:b0:594:4b3e:2815 with SMTP id
 2adb3069b0e04-5945f1867a2mr1922781e87.2.1762767964507; Mon, 10 Nov 2025
 01:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 10 Nov 2025 10:45:53 +0100
X-Gm-Features: AWmQ_bmNaGfRXrBGj05YeySBEfqaBzH8jnH775-U4Qey4HBlXtV5VLim7kMBPJg
Message-ID: <CAMRc=Md4X-GWpeRgun6zv6dddKFqqrjUSveq3fNOe5AboLAcXg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpio: improve support for shared GPIOs
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> Problem statement: GPIOs are implemented as a strictly exclusive
> resource in the kernel but there are lots of platforms on which single
> pin is shared by multiple devices which don't communicate so need some
> way of properly sharing access to a GPIO. What we have now is the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> doesn't do any locking or arbitration of access - it literally just hand
> the same GPIO descriptor to all interested users.
>
> The proposed solution is composed of three major parts: the high-level,
> shared GPIO proxy driver that arbitrates access to the shared pin and
> exposes a regular GPIO chip interface to consumers, a low-level shared
> GPIOLIB module that scans firmware nodes and creates auxiliary devices
> that attach to the proxy driver and finally a set of core GPIOLIB
> changes that plug the former into the GPIO lookup path.
>
> The changes are implemented in a way that allows to seamlessly compile
> out any code related to sharing GPIOs for systems that don't need it.
>
> The practical use-case for this are the powerdown GPIOs shared by
> speakers on Qualcomm db845c platform, however I have also extensively
> tested it using gpio-virtuser on arm64 qemu with various DT
> configurations.
>
> I'm Cc'ing some people that may help with reviewing/be interested in
> this: OF maintainers (because the main target are OF systems initially),
> Mark Brown because most users of GPIOD_FLAGS_BIT_NONEXCLUSIVE live
> in audio or regulator drivers and one of the goals of this series is
> dropping the hand-crafted GPIO enable counting via struct
> regulator_enable_gpio in regulator core), Andy and Mika because I'd like
> to also cover ACPI (even though I don't know about any ACPI platform that
> would need this at the moment, I think it makes sense to make the
> solution complete), Dmitry (same thing but for software nodes), Mani
> (because you have a somewhat related use-case for the PERST# signal and
> I'd like to hear your input on whether this is something you can use or
> maybe it needs a separate, implicit gpio-perst driver similar to what
> Krzysztof did for reset-gpios) and Greg (because I mentioned this to you
> last week in person and I also use the auxiliary bus for the proxy
> devices).
>
> Merging strategy: patches 1-6 should go through the GPIO tree and then
> ARM-SoC, ASoC and regulator trees can pull these changes from an
> immutable branch and apply the remaining patches.
>

Can I get some Reviewed-bys under the GPIO patches if there are no
other open issues? I would like for this to start making its way
upstream if there are no strong objections to the concept. After a
release or two, I'd like to start enabling it on more platforms.

Bart

