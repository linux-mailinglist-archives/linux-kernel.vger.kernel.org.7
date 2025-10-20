Return-Path: <linux-kernel+bounces-861837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C4CBF3C53
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D072E4E86C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1821ABD7;
	Mon, 20 Oct 2025 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PE7buZHj"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E82E5400
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996126; cv=none; b=sGVnizQ4LUM3vJCjKbwU5jkIEpX7eHEB50XEcrKsaZQKzJcxkYAXPQxbtdkUF33VL4ue1dUAPLQUN1xspXqONPTZ6L8TfviVaBxZ+RljF0XbNCBkV4KcV4VgTyqPRBL4gNs2hwsKHY0inCrzXQrp8Rx6MW6Gx0hiM6fnRjnYF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996126; c=relaxed/simple;
	bh=p+3sYnwm/zVmUqqbZ6Lan1Fe/EeeP/Xr5dbG7CHwG7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFrchrl/qfe2wBNl9ZiqtIa+FKN0QrDOv1Z0c9vP0rqxdgnl4qVVhVMwdYeVZ/Lo8NzOvWI/F/Mbe0/CqzFC3aIOzw/RYuWpI+gcAfWrDJQtMSBdBG93akyVC1KBSew5qfElG4qQ7WbcN5WiyYfzp1YhZgbrAPtoPL4CK/sxUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PE7buZHj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-783fa3aa582so39418987b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760996123; x=1761600923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+3sYnwm/zVmUqqbZ6Lan1Fe/EeeP/Xr5dbG7CHwG7Y=;
        b=PE7buZHjoYUMImtbfQNuaX+nnmlXX0XVVE4OhOMIKupSEDMANMsRMetsBK08uqy9At
         1ukTlNhpTEXQrM8BahxXobWCEbiHW7aWVf1NWaIFS3gablTeWO93iMG4LU1l9+cCvhYH
         7tPLZf8TCIvYEugcAzJA5ee8dZgQLC2ZY6qu12KFYAw022n6+w2D/bEPPh8qiOB6GmHy
         nGo9fDaU0220t0tuLMv4f2WWl0fLIrDUMy5DWw2lnePBzMljbpA7pzYa5Ni8uDXxb7Yb
         +Yn+cMf8PyBX6KFf1okxtiAiwDvRW9AVz1yHmzxK4J9XtSee1T7ifpwWG2hxFnDKzp2Y
         EPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996123; x=1761600923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+3sYnwm/zVmUqqbZ6Lan1Fe/EeeP/Xr5dbG7CHwG7Y=;
        b=r7JNU9fPSYt0HlJUOFR1rx/JNcfYzZjnsSRuzxS2uVk/Cc5gsyQDr01lFGz5X9KE1b
         f9itkLbEOlXl0fFVbhevARBzh+1saPJ9uOHxEcG4hQtTLO3WVwWczYPqTBBAgdeZnTHl
         rJ+54AayV1ihhww66kxYD9eeM7qvMNo18upcwLwk5MZ2TpaBAvj6tZ1Xnfpui/Cs1RoL
         Nuxm5iJGUulV6BSYNsYJqpfPjCt/MaMTKDmGUkTt15E74rbrhc45GVKseWLZpLOHGhxB
         iGrMn+3yq4zWRcidQrqqRMU0WxlB+WvcezhKJ/dyJLeC0OrQGxPX4ZVGNznN1l408c4t
         14iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2pDiNj1QV05SCUD/Ns1TGBx3YM+xxHSdccme5q850YnWuGFXFON5vPuuPNDHUf+XIs9fRQQE+6T3A7eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzTV+VzT+//9WJpZRpcE66OYOIpHotFAUVK7zMI2JP9r8vp91
	b0TfMZ9N65XMVkj2aZbnlKudyEYGamhdJb6+LlfCBSCEwlz0kccXmftLNMn5rNniGAi/Qxpm/0o
	BbmadDZeAKzWQXJdTY8eav3ZHgBXr8GWorN16WoS3QQ==
X-Gm-Gg: ASbGnctTLHFMU4RPTk+RMRJcIugYfgtlZsS6SH4zfY3ImxF1j8qb1KKbA5Qm4NdsbDN
	F4SIuYsFquIU/hipx76y2bxnhxolIBcfDRMomM2hhUa6IAe8xZzC8ySeL+AJj38sdR5yxLdipxu
	/28j1M4QQtqKukk2BGnpRRszjCszjPS5YPTC9CT/Fr02nnF7WVwCTt12yFEMaxmnKV/qWy6U+sJ
	KErW/HYsgb+WvkomK7r8LXr6c8FDX5Zwz67KKEIFD3wV7u2ctaVVqt4YJvjFa77D2EV9gA=
X-Google-Smtp-Source: AGHT+IHcbLV8sjcTUSW/kYKLFIDfgxSVgbG/hCotLfs+E1Yurw11PQwO89zUraRAtmdIvysGYrHzIqa+Gk+I+qbLfMk=
X-Received: by 2002:a05:690e:408b:b0:63e:221e:bd38 with SMTP id
 956f58d0204a3-63e221ebe30mr9755360d50.64.1760996123201; Mon, 20 Oct 2025
 14:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:35:10 +0200
X-Gm-Features: AS18NWBAzh5HU2QEiT3WGw7lWd7_MVL73oGUD23tlLIja0Rs_422Nhq3kpTmHsU
Message-ID: <CACRpkdZFXxBY2AopX2bgFGE_nhXmV3YirfRwuo4L6qWzzAC4rg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 1:20=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

