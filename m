Return-Path: <linux-kernel+bounces-869105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF6C06F76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C24156620D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FB326D68;
	Fri, 24 Oct 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yCrc+9CP"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919921A447
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319647; cv=none; b=qfVkpXCAoXROVNLwbdKUxmrSUk1HogBJ8yvy3fkUJ2tmazsvFdCUIGzIzHZjVnfOEDmRoGSMPiXYkhOPm8YJi9naDx8L8nIlOtEqpTOGYtbsPch+OAgoUt0YYLNvuyQL9z8WM7WfmaVNcQvoMPcsD0dhbPj2Vt82mAoR28lscps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319647; c=relaxed/simple;
	bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfnJ5tck9n3pZScsV0n2dkrVLLAcYBOGLeXSISbrPj8t7IA2EGwIgOq9tq/2KxL9RqfCemGSQafddwBX8xCSUFPHLGynFccSXqMQjnqJzAHTAJ8pN9WOjeWDw59pYsceyZkD60Hj0PIV8KeWxtYt9TubIIpAjJajEEsE3wbKAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yCrc+9CP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27ee41e074dso22218495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761319645; x=1761924445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
        b=yCrc+9CPuRj3S0VDiKd0dyZY1VMg0zxkUWkqw1mCRDAqCJekFepfvc6pmg70rLZFPY
         BrtVNavTpbrqza8uII7vb2FtTekv8ow24SiYIuMc4qN1Cb7rOwfnyvwsCOlWDsaONSOl
         B00tnCJTA3p/1OXS4/m8KCQzQKlkoRHbyQkN67ik2rSLedSarnB4PHqbOgwcuVXcXZ3U
         0hQLGZxLK7InjHaGAA3izbDwxgckmjVdJkP6Nj0pwbCeNXJjuyiX+XnyrWNLO58slFnn
         aXpk4LKiQZzP7m0NlkEnL0uur2eXvxFPmX/5WdHZ3XNSHahJLBC6IkMnpSvYFIHHBtiK
         yX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319645; x=1761924445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XYvDvnbFF/TszPFi0vSCsxsrGAF0jNL5hclvwK3V4w=;
        b=QREtoKefeB3L+0kMO/82jkOgcs1xiceAosjEt+k5m3uOboj0woZnC2ZvxEo/1KSAfo
         kzbt9qRloU7mtf7cDfkgr4hxIF1wIq4auzzKl3E0K2C0JuxVi0OR0VFcoeNDwX4CDL66
         LXWyRz7It7E4rQ+pBEO1ZKKlBytQ5j3JDO7LjQDQihuE5+iRf56SluaJCLel+EFeFmO9
         qPjRu7H2V+tyOhew/1BWOzkzz4vsXj/L6g9AZTa6MlJB+3tyZ5vjxjupmj4FVzBvkzv1
         +tmdpayTJFxITT2sx+OhLA02Fubfsc4h7g3NiE4PNVJcZUNm+c6fYKVhLmEP/moLKsWR
         JwSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbcm4VRbqSWAoSWCpeJ8Zoee/bgDcL/m/FRap3SmgQHiMnC03SBM+p5RpTsvPjndCtLZWoIwKYsHt0Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8D9qryOuMYEHsJBEABurByMz4kNtAw9YjRYW4flQCcmYWRtX
	iQVjplR2Uvvb8nT+5dGieaEg6z1ClguUb0E0O0FEjLGvcKGCsH/WUcctgbTThbUu2+vRLf61HYF
	RO2yniGqv0p5enTNg+r4C8xRZHe9/QfpxoHIEC5p6jsrRT3fcVqqMBkapUA==
X-Gm-Gg: ASbGncvRaBu1AObzf95fq+xte+fUzb1vFZGut5FRyuZPkQwTN8+M0VWh7vJQA+/wC6y
	lfHQdRPTu/DAkdze7h+axM4qs3ehD3zJwAsW9Zb83Prf66bjDpL4jegh1kX18ZTxtA/c573h+l/
	wIONHwTmOIIOzJHmsfrBx9f5jiQLk9OfNiVi4uqeBOzRHLemhLQV1n5ZxsfuUB6+3Knd6OYQLqF
	+LZCuponJoNybgWwYk8izgviylrurbhYXLlAnTpWE680BGqrfKLsuH8kSsHtDOxMjBhMvdQizz8
	ri+ZPYo4jC08CVg=
X-Google-Smtp-Source: AGHT+IE3ievDsUOrEWWRlev3EL7B/5BDY1VDgl+stdkjFTeQQMz83r5xV0GQ4imramVbO2gEuzsY0GzOsNiz+9le5Qg=
X-Received: by 2002:a17:903:3bc4:b0:290:b131:31dd with SMTP id
 d9443c01a7336-290c99aa9a0mr353473585ad.0.1761319644954; Fri, 24 Oct 2025
 08:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-3-69088530291b@linaro.org> <aPuYg0ws8Q2sp7Wv@kekkonen.localdomain>
In-Reply-To: <aPuYg0ws8Q2sp7Wv@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 17:27:08 +0200
X-Gm-Features: AS18NWD66neXy4pA0EykICaxP-IPYvUIs5btM5R7nrvoWotj1uaZi7dUGJ0akYg
Message-ID: <CAMRc=MfgGSExksz6ZwGEhv3yiL+Kfg+YKX-p2Ox4m66nYor4hg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] software node: allow referencing firmware nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:17=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Oct 22, 2025 at 03:41:02PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > At the moment software nodes can only reference other software nodes.
> > This is a limitation for devices created, for instance, on the auxiliar=
y
> > bus with a dynamic software node attached which cannot reference device=
s
> > the firmware node of which is "real" (as an OF node or otherwise).
>
> That's not entirely true: you can add a software node as a secondary to a=
n
> existing OF or ACPI fwnode. This has not been used widely and it's not ve=
ry
> convenient to set up.

First: set_secondary_fwnode() API seems to require a struct device,
what if we don't have one yet? Unless you're talking about a different
interface.

Second: are we even allowed to modify an existing fwnode from a random
place in the kernel? I mean: I'm module X and there's an fwnode Y, I
don't know what it is. Can I just arbitrarily add a secondary node to
it?

>
> Additional properties in ACPI or OF nodes will still need the secondary
> node, after these patches.
>

That's not the goal of this series. Being able to create software
nodes that reference real devices. In this particular case: a software
node for the reset-gpio device that will allow it to resolve the
reference to the physical GPIO provider.

Bart

