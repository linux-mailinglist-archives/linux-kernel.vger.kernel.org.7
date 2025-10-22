Return-Path: <linux-kernel+bounces-864394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD9BFAB02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDF9B503145
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E192FD667;
	Wed, 22 Oct 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yjWbfvaj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062402FD1C6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119520; cv=none; b=nD8RUngusH/54QOOkfUYDBNO7h4wNduWcGH/yfPpJSXxU6ZaDY+PW16UHQWdSiEUqzcZh71HoY5x94nnhkR2NliruakJRLXCdzCppWNk+izGmTZAbZugWh4ur+V5oGTdqyYlqaEqAbFMIGLCfBC5YeZGDTZkbbMiBX1hdv61ArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119520; c=relaxed/simple;
	bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUUim55EXPUM1+NvVSMcMDA3UVlKdEZm4bZeURth6hBPf+bIJKC6sytyJ/NrnbqoiovBXq/MF0ua6ONy9H5dEfTmNCiE3Ls/uXXZ9r8aJVDSkXPmMwoalR2PThcsRttBpK0SAb6/ODTP52BFs3T1JgjIE/mclTwglaxBdIHgIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yjWbfvaj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27c369f898fso93317295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761119518; x=1761724318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
        b=yjWbfvajw+hA9aow1wD23NpHUk5dI37pFdAvivig09R1y7pfB+HLCO49zxw4OjjGaQ
         Zv+sj8PjmDwLVLTWL9MDiytkaPIfCQc041Naa1iFf3wWLdC24yiyQGl9d8khyd4ir31M
         tHuZxlYxBJh8PXRAUv22IQMwlxwQW6jNIF00Dn0jsb/twHx07c8PLedazrTGmbrO4a/2
         arGmvTU8DQWJhrCpiMk8oAnwb9I48EcGdSakm8pWNg3DrPYqVFzb1hzu5dq9FtQJpVl2
         KbQ9feIE07+Gomw1oLQkBbVfKj8G+rygSgF7XZ+Tec59VwxKIl40D721DkUBpiLaARxU
         99fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119518; x=1761724318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwgDGkmgLQAiIFCHURTu7rDtJYWYbIsEW6+BIX2eiRE=;
        b=ks/C1Dr+fyzEZJxOTUyQxe+N/wdm52yCMzG/nTFjo0e/ZmPF13Z4astaJXNsdXS1+v
         UhGNT0i0dWdbQ6fOXEkZcnQzxTrboprRlWiRRIzI/R7VxYGecWTYcHpzmLlearnqWF7k
         nGySJX/Aa2nyXpW4rLAW5kuqPHZnu44Axq2DmZ42W8HhYkkiZenshddl1imYZ5CumR9q
         Xb5er4NJNZir1djXlVAAs+E9rFtu9xe46qucs1OmBTHKYsYREJWan0AdGbhrwvg9dQlk
         Um79ZdwGOxyaR2PrF33anLZzZRyKjp0hcAfzlbbeFz1nq3CH7x6X8U3IY/yVfQfPP4VQ
         0w0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMPd4QKzwnB9t/nCqy8MvOKruQBVIUG7rsKweoBT5Ll6+GmT8eyCNNDTQoCaQih9kcwJxPfhnGReBfxkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8wY5XxfaLLZys4qoZ2BI+XxiqVESZ4Ye9wJHolQaWzvfYnoP
	zaSeM7FPLDcvTkNoSwO3GkJ/W9TYa8QhkcKaPs4r1CcgNyTWtGS7jqYrsQEAN9TWW8Fye71D/R/
	OCvYJIhi42rNLniazQJA+rEKScJb8oxHwLP3kGMeOGQ==
X-Gm-Gg: ASbGnct70QCn6zw9TSPF7kyAO/LjYKfayi62nS0sSghbc+7ySb2VzN+o22pEOZIIqC2
	AoKMySUb4IlQSEbjbIcdUg4RKHoz46aQrtO1wmDwJJ3/1w+wItB+7HJvw7J6I6fyKTx+w4n17iF
	5wxKDC5uYZmagc15/MQv7WyurEoiU5oZlWHZkpPvdbXEVdE31/toWDysIaWamELVketl+mfmF+s
	6BLqBg8yMuBf5gLDSaVg90iSnkA76g0dNkd2DeArHkNwTWng+0ne/TyfNK39m1HtASOoEJIoWoN
	e0PP9tLamrBYrD1X
X-Google-Smtp-Source: AGHT+IGg/bOFoiaG13MoDLh0wQPdpvQnjVjhF+kcamSsNZoWBjRpsyoZ2RCg+wNCw4VMdWeYvSdn0noK4cFimUz6as4=
X-Received: by 2002:a17:90b:2e04:b0:32b:94a2:b0d5 with SMTP id
 98e67ed59e1d1-33bcf923730mr24000792a91.37.1761119518374; Wed, 22 Oct 2025
 00:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org> <aO1bkraNrvHeTQxE@smile.fi.intel.com>
In-Reply-To: <aO1bkraNrvHeTQxE@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 09:51:44 +0200
X-Gm-Features: AS18NWAQSvR-Wj30Uglkmq34ZykFQDBTW9oa-LbZ-o-h0Yn2Kyd_r6Aqydksz8c
Message-ID: <CAMRc=Mc0E33JTettxsCEPf+K5FZ4-JOUX6tF1xq2QGr2gD0vLw@mail.gmail.com>
Subject: Re: [PATCH 1/9] software node: read the reference args via the fwnode API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 7:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Once we allow software nodes to reference all kinds of firmware nodes,
> > the refnode here will no longer necessarily be a software node so read
> > its proprties going through its fwnode implementation.
>
> This needs a comment in the code.
>

Honestly after a second glance, I disagree. Literally a few lines before we=
 do:

refnode =3D software_node_fwnode(ref->node);

We know very well what refnode is here and why we should use fwnode
API. If anything, the previous use of direct property routines was
unusual. A comment would be redundant as the code is self-describing,
what do you even want me to write there?

Bartosz

