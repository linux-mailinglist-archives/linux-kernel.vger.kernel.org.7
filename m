Return-Path: <linux-kernel+bounces-790689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34698B3ABC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4161BA871C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D32BE7C0;
	Thu, 28 Aug 2025 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dc2xECbD"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E328A3FA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413506; cv=none; b=rWdCZDqGgl/n87OIljDA9/CIZXankbxYofBI+z4x+6S9BvO3JWm446pGM4nCdi5BhNYEvTVhBWV3gQbGGv/r10MUkR7kl3BYCq+XUdFpOgQhuj3BGJHDmZ+i1pB/xpGJdFUoIkrZl0T7xAlWOOmxEL6lK90+7tZBdOyVLR75ASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413506; c=relaxed/simple;
	bh=oW06lVNEVHDH08IVfPjhIMr807RG24V4E9Stxt2ZLtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYsucSnJoQos3TL3HayX8Zs7kNZgI6Thyp7aBL/Knv5R1EpswhIGc5972/qze7K2ymze6PV4/TbRJhMwRdWzI5qATz2fcX/Zul4IlkMHlru7AuZRAyjKCxpYvt1l3/Q0/Ag5SK3blHvY53YEesynQsTqGaWy02z+DCZBxXcMXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dc2xECbD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f5cd36347so1395301e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756413502; x=1757018302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW06lVNEVHDH08IVfPjhIMr807RG24V4E9Stxt2ZLtI=;
        b=Dc2xECbDcTboIS16COoMnjBEqakz+vuaQgoiB5B5viIRROncmTnZ5dm6tlEKox+ue1
         pWkK2hBuoANm2HwlGRBZ99vhIlMAIN+guphyYqztT50DQdJ0s/chmAWX7v5kqFJD+I6A
         Xhc9ObjL33hD0BAZfs2zF5HOhNBDuufqsWdB3s95KCj4Cwdeb+RQxMWjZoVI4Lt5oGO8
         IOZr+LxHIqQMeCuM1OMN7tYg6vtbvICMMdI24Kf5ZmRuSzU5LZReoky2rKo28EEPml8f
         s++e8Zj88OIUAjenHrrW7VPezpB71y/CQJiOEa2JIgDwV0lqI6f5BHhokolQe1cLELp5
         VKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413502; x=1757018302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW06lVNEVHDH08IVfPjhIMr807RG24V4E9Stxt2ZLtI=;
        b=oUh6XbtL1dWeoXx4cLEYJZPE0G4xMr0pvCJu9tPRmkTZ8kHiM6bkcUwU6LuOfhgzbQ
         FeTtmrjb7BN8RqEWH76jbOFAAR7qJl3L1pT3ykcwISuuNjx366R+bdc9bP6ECorGQlHR
         6Qc7gDGzuuocuk5iGIk52+L1KYP0I5MuNZkEJZrUJ/5pQXHdoPyHz+PGuwc61eUlTJKR
         zVYvbiNIrT9+yGKN+DGfv8gyVPka5t/7npx91aMS8aG8C9uBUWYNCkeEoI7CFlgs0aUx
         /sOapMYnzDAZfcvKOFWw0JE6LyaQLxdJ/nlBAKBmCvo8JJ1SSD5+XdqJwHLMyUxyGvpu
         gWeg==
X-Forwarded-Encrypted: i=1; AJvYcCXyGcKxTWqwghkqg9du2iWkhallIhF1pVMvvRLug1ly7QGnrnuZIlWFtjJ0GdFSe6/TvqVVEY+/22CFslg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JyPy+lrxzxc/jCaK8MMGO4hBRsi2eUBtSgOseNPp5+efjWFC
	sQJ5RwTyD/54oF6G6KznsPQJM6wC5FNSg0nF8FI4mYNitGb00pGlPEuHnjJ1sbVh5m9T8wzaDmq
	EhSMrV7fWAGkrkSgCH/aIpn3qLLqPUCzH0shOiCTI3Q==
X-Gm-Gg: ASbGncsRCM+ankzBnplM1JuU0eVqf1dLZp8ef0iC24Y99OBZRBgzrHMX7xLb3MOcgQw
	HIXekpCDLG0PRdJKH8xk7NqvBqI+QQmj8kXYKPgXlnjKqHeYmf6ntqb77rGfJy3GQ07L6Yj7mqV
	0RZVv/ZdHLno6kw8Ph0L/+3Y4U2U+noJ15uBgAiqMQd2eDsmJrX9C8Il1fEZayknTmx3yJTlid5
	1EJ5bWbFssTQnM19g==
X-Google-Smtp-Source: AGHT+IGFctSS9xIvuPsDh46p14WQZ80AJsz61TeaeY863j+AA+52SQqM5uWJISSdTvREAPPmDBfGMmRKqf/htgUE6Y0=
X-Received: by 2002:a05:651c:1508:b0:336:b4d1:a304 with SMTP id
 38308e7fff4ca-336b4d1be3bmr1583191fa.44.1756413502286; Thu, 28 Aug 2025
 13:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:38:09 +0200
X-Gm-Features: Ac12FXy-IwjUULMJvRyUzt8VKPtHqknlXLB_SFxBVFF1kcuFfQ2Q2i3x0YxAaf4
Message-ID: <CACRpkdbcWiq0xCVUwh9VZ+_JU9XOu=SgVKHr2YMSuv3Bnee+tw@mail.gmail.com>
Subject: Re: [PATCH 00/12] gpio: replace legacy bgpio_init() with its
 modernized alternative - part 2
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Yang Shen <shenyang39@huawei.com>, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> Here's another round of patches converting GPIO drivers to the
> modernized generic GPIO chip API.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All patches look good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

