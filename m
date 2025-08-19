Return-Path: <linux-kernel+bounces-775677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292ACB2C35F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815777AF835
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EFB340D80;
	Tue, 19 Aug 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF6QWanc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB233A03E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605955; cv=none; b=eisbHJYogr8LK5vAkBZMrT9R/mN8hGT9OToq8DIVM4CgIdI5yc78PeZfHf5nWb6ozx0UfXpmwvu/OiUlFwuNngpd1PYobIXLxX2enupUCAgDk8bfARz8mH1PaFpriwQaTl46KYiI4Sj5tRoFTtDp1IjDhJGzxmVR9+VjZIWpgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605955; c=relaxed/simple;
	bh=u2Y/gfnxlc437mpb6PhnysrCJ1QgGq/sgZI77ejaYT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPw9mqlA32YqAHK8zUJVqo0ZVUDbCutifhXr4tAIm6v6dCJYbDiYxgCjGbFMEDS4H9emvFgkfbFcRr1iZ2qWqK99OwCcx3xlhel1ReybRsP0arjmdu+71zn0O/glOwLTb6YtWsuTD2fEoqZRekSo/GFp/Azpbx6dvEQbgo3Rf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MF6QWanc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f917a67aso36905181fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755605952; x=1756210752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2Y/gfnxlc437mpb6PhnysrCJ1QgGq/sgZI77ejaYT0=;
        b=MF6QWancNVDnFcIzKm+4rAQAkk52B9JC8H019EHqPTT39Mw6rnfV9hkusKUOckHQ2C
         HtS4v95VOcAM+wAK52qhdHSttQeS64HTOkxnappQA+lDaDyNxa8NvOcEjqqNCnXCN66B
         VgGweEPDx9lTUC2NgYdvSIXR2/Q2l8nu6r5xUqS1mqbmw1sV4SEReyjkmp9gxBy0BwgN
         CAHaijAMoczdoC5Jgg68Eil0PcCXnaJwibNQpgfkaOmkIaYah3UYwvrZ7KwoM4zFV3EJ
         RkAtRdbPDNxU4W+9PHJWBTE48qHVr7gwrynzFHLrUL6wVAaQ9kvHNYPYvlYiI2mumdpl
         Hbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605952; x=1756210752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2Y/gfnxlc437mpb6PhnysrCJ1QgGq/sgZI77ejaYT0=;
        b=w59zLl9KyWXRQCYfH6ib3IAnBtAZx/n8ZMmKBvsU/dPMLqzNsNw8mYE+9hnxOiUGXY
         ZCz02FhprDdD80D9mVWx9gdwm/D00BkoN4c3kc0I1j89RHJui5GX26QEG5WBuL96q65W
         MQLzwW/sKCcVdsNnW1tdnLP82cpyjQG96TAyYRebo7USMetEWTzb7bGsR18twlBtSHSN
         f8tc0TlC+LSc9dYlDgGOacrRMS3lJNiLLyNplFVfmx07m9EiXQobkzip/bYbUuoYdeTJ
         gaxtMOvWB/oi9nUaH0Z2I6J7tC0s6+t63lHvyRfYeH9+Ef8l+ASsbqynS4xD4rOx87Mu
         Bixg==
X-Forwarded-Encrypted: i=1; AJvYcCU1qz9vtgDHzGN01OwyJfZWaI7rvCwebujcTQyPADQ0qqAm99QjlVIpIjuUWxwTEzT9x2ijdEGwrr561ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBP8r9CrMWPCIpjb0V8JB7pC3EnvuL/CCWQ4e6AybLkeG2pimZ
	Y+l9XGyIXzWXFvdTXzEyhSC3xNLCCDTZxvV4H7D91wIiU2KKQzOlXa+I94V6mRdZDo0aDJIYEqn
	8RXDxgo/qCdPb+UJ7Nh5Bp+oGjyrwxIauxprK+97ZdQ==
X-Gm-Gg: ASbGnctdWsVZVf+pXQ+21W8Tficqa12Agb2qGR0hY258kOQ3kgHHkgWoThGsC2XQTJ4
	20DcRcaUc3k1VOVORC0VZQr7EzRzR6QKmKG7vGFWoTX/OYAMixhoX2PRnnia63P5IlCy+2uu0Sb
	6ePZUrRwudv+b2pzP/+Q2XwRwFqW4Y/+jzU6y7ToxMb/xr/eC7pzynO675ZjPrEGfKrJF1xPvCY
	3KaNs4A2f+j
X-Google-Smtp-Source: AGHT+IHsaqPH9hjr7u54X1LUFS04SWJNAP7LPz98uFiQfhrqMU6MDbmAcQVfPn//Z7iM44rJEqEQbl5npay+fB7TPz8=
X-Received: by 2002:a05:651c:1503:b0:32f:45e5:df46 with SMTP id
 38308e7fff4ca-3353073c91dmr5858371fa.37.1755605952075; Tue, 19 Aug 2025
 05:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814181236.1956731-1-da@libre.computer>
In-Reply-To: <20250814181236.1956731-1-da@libre.computer>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:19:00 +0200
X-Gm-Features: Ac12FXyeObfcMrouhnaGZFteU5KOKCRkIGy1hUn_EywbJRo053Gro_IOs7It1sg
Message-ID: <CACRpkdb=OTwGyz0ArKPDdcBWU3nzrBF5d6LMHgNRgVsb9zH=bw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson-g12a: add GPIOC_7 pcie_clkreqn pinmux
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:12=E2=80=AFPM Da Xue <da@libre.computer> wrote:

> Amlogic G12 exposes PCIe clock request signal on GPIOC_7 pinmux func 1
>
> Add the relevant pinmux and pin groups
>
> Signed-off-by: Da Xue <da@libre.computer>

Patch applied.

Yours,
Linus Walleij

