Return-Path: <linux-kernel+bounces-729896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B88B03D28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAFE1896F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C0244696;
	Mon, 14 Jul 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwvzvRnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0B17C77
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491913; cv=none; b=cHhN0xV47K2XN1d+Y1nMzUVnM7D7KQwOXdzRjmf3Boid8Etc5AGyvpoZNZLbguQnzTbt1y/TvYmBBMW+PY22RnkKcINYFp/hxGKTHNWEOaELRagDcW4752r+mIiCSJShhNWndi0ftFjWI8rHfrcMLS0gfaGjqFGTOk+UiQiBU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491913; c=relaxed/simple;
	bh=6Ly3qJeJYAFCTaFHf5UQkroFT0+Y29UG+MGZis04kLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuuiT9XtntdFvM+fq5NOrHwTavtVhBeABPSmZtMsJgxWV3oEINkFP3oaUGClf5DtrN5va+EfB+ZLGFE8QxIxtWh1Gx0qdphPb+uThf3/+WBT0ZdakyF9NG8zkUT0uIfbN/NWp8DLiU+HDB85cUjcJDpYWj0Bni2PcF1+lW0eHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwvzvRnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAD8C4CEF8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491913;
	bh=6Ly3qJeJYAFCTaFHf5UQkroFT0+Y29UG+MGZis04kLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UwvzvRnjRk/uZNAL6j/iy14PlraexxzX2d2a9sRvJFb+1NIujjR3bAsH1eM0Cgpl/
	 VHZyPIGngG15gk5JN8A0zRli/Va4b1Omsmk7Vuwr75xR/YEMNNk9Q08VI0N+yHoVq1
	 1pf2/B+IzcTuBCUA6kCkVWZk1sLfSIjQdEYxWXHRHCsD/rT6AwksWrM7rxcSYUhO0D
	 rWCnOvmrZofgxU4hF+iqWx/VyjU4i90r+0qpXl/vj5o2y2qeM0qCLNtOEvGe9urC0F
	 JGXrBvWHOwJ6dRRejIBgZqnj7y3lo8R4Po52aNeUS928aJPR43ZM4lqiNx4gPKAyF+
	 IPkx0xDu/KVUA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60d6303a11eso1944717eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:18:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2F3ShnFKCMlnoOjo6cXNpgu9jW94N6dVEhJqvR+Bl1YKJ4MM7
	q4KhFkv5+0MbzBhvKDeVWttfYYcvF1DSRV4zEgALPu3mlrwGo2AyQAVgwzJcSYHtp6ZGHzfOUgS
	6xZXkLv0gkks/rk4DPiDQPGayR0JynXo=
X-Google-Smtp-Source: AGHT+IHh6G7mfGLXnPbRhjRa2YkeKB6JcqJk0BICfiWkTEpPAch4lJF5ljvRMHAX19odUgkEioqGk/77qamlS+OmNPs=
X-Received: by 2002:a05:6820:1795:b0:615:86a2:6cc5 with SMTP id
 006d021491bc7-61586a26da2mr1893184eaf.2.1752491912398; Mon, 14 Jul 2025
 04:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515234803.1385375-1-rdunlap@infradead.org>
In-Reply-To: <20250515234803.1385375-1-rdunlap@infradead.org>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Mon, 14 Jul 2025 20:17:55 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3fRxgqhu2tDzshRi5MkV7DJk4iCDYE=x_hecWtBYWUpQ@mail.gmail.com>
X-Gm-Features: Ac12FXyjaQ3RVvUhxDpdrbLZ2R59kFrOrv0pn8LwH2h-wS-IdbOAAfc7J994sAs
Message-ID: <CAGTfZH3fRxgqhu2tDzshRi5MkV7DJk4iCDYE=x_hecWtBYWUpQ@mail.gmail.com>
Subject: Re: [PATCH] extcon: max14526: depends on I2C to prevent build warning/errors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Fri, May 16, 2025 at 9:26=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Make EXTCON_MAX14526 depend on I2C to address a kconfig warning and
> subsequent build errors:
>
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [m]: I2C [=3Dm]
>   Selected by [y]:
>   - EXTCON_MAX14526 [=3Dy] && EXTCON [=3Dy]
>
> ld: vmlinux.o: in function `max14526_driver_init':
> extcon-max14526.c:(.init.text+0x77b0e): undefined reference to `i2c_regis=
ter_driver'
> ld: vmlinux.o: in function `max14526_driver_exit':
> extcon-max14526.c:(.exit.text+0x467c): undefined reference to `i2c_del_dr=
iver'
>
> Fixes: c2aeb8647e53 ("extcon: Add basic support for Maxim MAX14526 MUIC")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/extcon/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20250515.orig/drivers/extcon/Kconfig
> +++ linux-next-20250515/drivers/extcon/Kconfig
> @@ -136,6 +136,7 @@ config EXTCON_MAX8997
>
>  config EXTCON_MAX14526
>         tristate "Maxim MAX14526 EXTCON Support"
> +       depends on I2C
>         select IRQ_DOMAIN
>         select REGMAP_I2C
>         help
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

