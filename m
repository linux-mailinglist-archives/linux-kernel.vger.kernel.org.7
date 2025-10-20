Return-Path: <linux-kernel+bounces-860505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D1BF046C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D21A18A015F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8082F5306;
	Mon, 20 Oct 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IcO943AZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A02F6591
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953329; cv=none; b=aog1W1IDO0meKD4YNGLXHT3HsLZSWaaTGoY8+YPiTYE30ejTrW0Rb9oqoLmLENoEo0jykkJchO1xJrRyokrU3Op/xDS9RJwdNn0Mlsa5n0Lr+NDUR99tDKCRAUJ7LieGkdZfwCRDb5/wkCDQ85EmptTktxzoD9mhUs/ZJlUqZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953329; c=relaxed/simple;
	bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSv8jzKLYksjAT0KlnJT1PuQNeK3BVqQJFIkgmLp3jGdpLLm58bzdXcPW1GkPrWcAYK9EC8PnKi4W8kEC6AN/uQKsPtrkmaimGvLOEzV1mMfIHN3n6bCX3D1ZmCutw68efUR6CUj3RNCU5B3cWU6DgDrBfTx3ECEXNeeIZ2IFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IcO943AZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso3816027e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760953326; x=1761558126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
        b=IcO943AZ4slbeY23j1wnDAiVcwPBPLOz6p7nwR3LnKZ0EWyuxZ1NV7vh4gmJ/DIdyO
         6NBnVnJLgA6olIiUyrFMdxASrH1QtEFiA7r/E1llGQVLoET/fsgSRnAyAnwR8NcWStjO
         FuT2KFRZGMEzwuOaEhqAI6OZQRNQgcs9YKKrdrTKxlFK2oJm2XQIc6nDLunQhkol1mbb
         d70GOBwY51A3Hb51gRUwQxAzlPvGos30Z0gp/Sy15aqIdUTTrOReoH1dy+wfcjOsfgCW
         7aj159DIeTlPLFh0St4Zk1tpfonVqFPLXNmWZp8b1j/WnRZHVRVzd4hwU/lmZADNgoht
         oLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953326; x=1761558126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
        b=HLj2IOyFPb4QZHCJeLHoY+/14F66wHP+JelTgfoj2uu6fDEg3hDtVkyZFUuS6ZV4RC
         mXimLWdBe+lUC4dVKPv3Xr6iZr2TVm/RrbR0j3mi8MNKKASguCasAPd9/EUz5MrVziCQ
         NF+JmJFVzMF5LFQxsqGTbgg4m4frJdloZxtyZrYTrRJsGV927Q4D1406sidEVNgZi1g0
         XOZFaPW8JArJBFtdmfYrADq7MeMidN2hYdF8yCg3z9546w2+/AXaLgm2yax1tbMvye6W
         XyqAx3mX3vEQ7IifjujIS0f9TMo4CPNHviPxI8Gw3rov+fgF7Sk83qrUjf6s87alLK4t
         c2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVHksmVOLAe3GwG161HCKaC8KyPPz6uKvcSPf+mhrvGf862VY9oWdA1JOkh/S4iZ9VVT0/VW0FY4zaEqnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tkLg8jydHhWJRj+DgPXvXR5LEJlHDstuvNgxHiTLSuQeoxVD
	KtauWmzZEvmO02Ujgx7qvB/OLZKXsziZr7LfTmfykabEVuxqYXzIfjDCHiDoVAcO+W9bgcLl+ZR
	HWHuFedEfbQqBj8CDT7Q29UY3WNWwIYH4bvb7NgOW0g==
X-Gm-Gg: ASbGncuM8LsYZdD45X/dnt4bWV/uGJ0TyeXwgHMl/XFAU+UI2TXU62F1hMTPntF192h
	Drg2hMUv4qsUis9BM+R79eGXIQTE5lS5uLw7JPzTKpJPPfp8kF7GgnplqOrTwN2OIXV8aXeHExA
	taCB/ESsI/6vW+SeckRy8PMLY7Q+Xf7qZrOy2EG7s4gCAiWwi7GPlhmKwp3OPu5lNlc6oiaCrL2
	5f6JrHp9LCx8ovEdqW43whQ4vODqC0A5MYwJ75yUnPN3bUqZ3InK4CnsC5B7WpH/OjETiUbSZcd
	/6c6uGdvzQslvr/3
X-Google-Smtp-Source: AGHT+IHY1EdCIXYngUyFFwGvzEW0znpDl77em9pEnOCmJRoroDyoIZB7DiA520ogK1u8lsISe3niq2HVycioLER4ci8=
X-Received: by 2002:a05:6512:1052:b0:578:ed03:7b70 with SMTP id
 2adb3069b0e04-591d8589aedmr3757333e87.28.1760953326040; Mon, 20 Oct 2025
 02:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <CAMRc=Me4Fh5pDOF8Z2XY4MG_DYqPRN+UJh_BzKvmULL96wciYw@mail.gmail.com> <81bda56c-f18b-4bd9-abf9-9da7c2251f42@sirena.org.uk>
In-Reply-To: <81bda56c-f18b-4bd9-abf9-9da7c2251f42@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 11:41:52 +0200
X-Gm-Features: AS18NWCTv8z2cF08OaIclAyR6BuSf6xIu18qyroHsfySyW-sq8vo6xUHsWKQB4s
Message-ID: <CAMRc=MdOCHJEyPxN+-g71ux68=Mt_Q5P9611QO7Q8J9e8UJv_A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Catalin Marinas <catalin.marinas@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:32=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Oct 17, 2025 at 07:26:51PM +0200, Bartosz Golaszewski wrote:
>
> > Upon a closer inspection it turns out that this is not the case - the
> > ENABLE/DISABLE events are emitted when the *logical* regulator is
> > enabled/disabled even if this does not involve a change in the state
> > of the shared pin.
>
> It really should be the actual physical state change that triggers the
> event.

I guess so, but this would require some non-trivial rework of the
regulator core. We'd need some list of deferred notifications stored
in memory for when the physical state actually changes.

Bartosz

