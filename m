Return-Path: <linux-kernel+bounces-767889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56FB25A23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F5C7BA02E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F711DE892;
	Thu, 14 Aug 2025 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvInC0dP"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715A188A0C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143767; cv=none; b=hSNDqc1pqlajwTB0QnUzO+Qn7/YwiwfEMMkdptCK2XC0FJ8bnlHVvSRfHhqYNJdMWWCALOsOdWi/ff8pPubAyRMLVZYaxoXyC+5baUWjvR1tYBx31mYvmYXIkTioTJaTHbTCLHwi873cLb/V8qaGM8ef+kJl4mVIuWH65lqHikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143767; c=relaxed/simple;
	bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5Fj3TBv8XnKLwHDotovM1MMkrvIuiOPdmU/r6AxWqQ7WkozkDwQBz6beh/Ceu2HGCpbr6BySyVvUqB/QW9DqpqHVg8NHge+G6skV3YnsV7cKwiBykXppNCdpk89lIupZyt8n7L7dhl+9kwnVLNjgzcDA3naIyDvUnEJjmUXIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvInC0dP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce510b4ceso534306e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143762; x=1755748562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
        b=EvInC0dPxLsxOgrcXaABeghM/4bT5PLVmE6f2aI+gEfPRh5bcJCK3IFSzB//2toRIW
         qsHUSOgJq+PQj9Yw8ZwlWorNd/cPgDsXGTxs3D1Q4OZCWZN3kL9Xhmrk8WyxYsHAGyHm
         e/jNSSc8EsiSs9zykXjkkGMzt/KMzDxyZTVOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143762; x=1755748562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPXgL5JA1NadViWzO3at4LaILf4SB9CfhgF57NmFOj0=;
        b=qWR50jlcj9k7wXwEtwlscClvV1jZ/ANFjWlUM7NXGCwAIRkgave/lu96IinEIO5ovA
         RmkJ9GpJkneihZVr5MPm4Aak0V7iZzK1QhriX22CCNlEXEmagPcp0K+BgUMn9bKPW14K
         E4mG+ndqV5Az0f2sguawdiBmSRd8kzEuXucr1x9vmeFk7qbrOgN/eslhQSLBNLduVccT
         M4ahyvAUnC6zcVWOhahl2ZnKJuUSa5vgWa6xRx8xPZbuOTbbW5MsvRRy1y0UXfmX2lt4
         HvGwWS34JyAil3Dl7K1xfGkIGMR7IfCqq4GBWuRI8+/aOJfifGjM4ir80Pt6aWMYA5Lo
         TF2A==
X-Forwarded-Encrypted: i=1; AJvYcCUoGxHNDo0BLrvJBYGWTLipiZyYLl0c3HnW+dCYoz7RUwwrR1mRhWkoQp2jnn2vY9UOO2otjrvPSRpMTZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVaLbkH2/ESi+MJczCsd+gL10e2q77pLbo85kUlfVefvw1B4J
	UT/CBc1VN3cb5kB/82ph7VyvQOSdBs8SnLiIHxV8HIt1QEnZz026ajKwJfbJ6B0tcZaxiAszaju
	1bG9euzGAF8llmBeYE+sArWgze82NIncxyEoIPIpb
X-Gm-Gg: ASbGncstytXA+1rjBhX9kRt/yjD8xg9IwehPqWpJNkzWkmvwJQ0AreoQLZDWmLtD6qM
	Z7zF8II0dRtOC2J2933rNdV4BEzVRXPWJ0odYj3sBWHj49n7Y+YwmA8f1u91AVfdJUy2OXNuH1m
	UmdyZw9/m4IvIvFaz/CZyTCE0Nzq1Bq7JcwwuwWBWQavNHOQuVKfRLWirxYs4iicSebQqU9SpGp
	rXtPECFMGz6q9FF08NPPNRF3BBltIZP7n/lY77Cm9EpFQ==
X-Google-Smtp-Source: AGHT+IHQMv69+04AP9otNVcxhwI8uWKlLmUkdvXFQ1PCUQkCenB9LDrLy/Vl+cHfeBSUvo7zV0jpH3UAnLNxpErRIuE=
X-Received: by 2002:a05:6512:4406:b0:553:2868:6355 with SMTP id
 2adb3069b0e04-55ce4ffa5f7mr485589e87.18.1755143762579; Wed, 13 Aug 2025
 20:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org> <20250812-pinctrl-gpio-pinfuncs-v4-5-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-5-bb3906c55e64@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 11:55:50 +0800
X-Gm-Features: Ac12FXwQl-cvQ51JsCsvzfEY1EzqeHLXUhAtiyz4lnmgFYbrRneNtPbyaTw1wc8
Message-ID: <CAGXv+5GE4eUjMhewRm9oa+GbJWt8tMC0RXvT0R5FEfVOAsJ3fQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] pinctrl: mediatek: moore: replace struct
 function_desc with struct pinfunction
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct function_desc is a wrapper around struct pinfunction with an
> additional void *data pointer. This driver doesn't use the data pointer.
> We're also working towards reducing the usage of struct function_desc in
> pinctrl drivers - they should only be created by pinmux core and
> accessed by drivers using pinmux_generic_get_function(). Replace the
> struct function_desc objects in this driver with smaller struct
> pinfunction instances.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

