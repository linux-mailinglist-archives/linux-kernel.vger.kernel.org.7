Return-Path: <linux-kernel+bounces-866995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B5C014E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE19B507572
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9940314B94;
	Thu, 23 Oct 2025 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTmywmVu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6031AF0E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225249; cv=none; b=YjDa33jiAVB4hNihPUGRkyuONSz4jGe/aVRaHzP6RS8x5H+BsCJofncR7dE9vK59VUisdelUUUCYOcSFGFmHGFiSjjXKgotSB23D2MsRn7ILuUO+DG1P0FaWaXV+yV8LGgBwTp4ROFYFk9hPLDh62N7rDZmWQlOY3YJhCDZKAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225249; c=relaxed/simple;
	bh=rCgZQMvhqpJkSPW5CDm4P/9du6BfJf0oWn2sB/mg4js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sR+ra9psjU0yc8/bNfpTUOCFKW8XMPUfQyaVIlXnTh78IuVllio4b1T6+yZSCaFy2AYgbBVK3GtHZo7m/cZnjfPGZ/bC9s6YV2P3771l2N/xsAkzn+CvP9Vm4qLHteLzBokhpBBeY7qMeVjixsdfsKS/bDNbJpj09UOEzOz+toQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yTmywmVu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-373a56498b9so24652501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761225245; x=1761830045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjHHHhlIwMyUNtV6qNO7lwTmbrTzq58N0AEeJA3rSmU=;
        b=yTmywmVuSScFS3RdPhtSge+WVKsWGnYEWKzlgM+s4T+Yit0f5qQBbmAO9UXkS0su9U
         /H2o1saHBzIL46cu+b0sNPguAdFS03ESxICuggmb5ZVHWUSxkF7NjOw0Dtge6n40J2wP
         y9UpToZ40YDelfX4etnFsgxIoULooQTRrMXzwSOKltzJ1uL058/I193olPJ0QPgo1YYY
         PiFBd4C+gHuBzEKYJQo7mHD73fdSTLV3NA/qNbQgEBL03MoS3Kj7RCDIqJzhqt+5BhBM
         obJYHHJQoQia1yjJfC+Y8tfuc9jEYFOqVpbLJ8ra2fqhlv6COfsOIVVXnyYIvk+H1BHT
         QP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225245; x=1761830045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjHHHhlIwMyUNtV6qNO7lwTmbrTzq58N0AEeJA3rSmU=;
        b=lR990IhCT+YH360BoYxjnZf9xmA/GphRv6u35kvwXmh+ahjEsMfCe5zeK3rAXCq54e
         L+03nd2PWlCAKXLgJ5CsYGfSQdyCpG8huQ2Z4Yz3LW3rT5k/gLbuuq8VQUljudj4DmrU
         2s2H2XDj2zS8q/tS1JF5dUq9CazVfZTv242KCEZoob+c2KuhMeTt6uuTEqBO5WxTxJBH
         wa7pYwwW0mwH30sev947YXTFi2My1DTpE96Mz7+79UqBFpficWDH1UAZdPb/kcm40Gqp
         mL7VfsiFrRzCBooOGanp35EqTiQuWNb45X5zSk3dR+8ALUmqHMryzkQuN+9Jih8Hpfy9
         lx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk7WphrM5cxN+AsHMg/gg09gwScwhjNdWO+PJoj7ij8/rJEMpRvCV/gjjFUfy5ZNJ5w8WcS21TM7tVldA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9cgFNzqhjWYlXVwIt2DbG6S8ocmeCuJIZJsUk6F3zZXYntIU
	txvp49vFn/fRwh4FNe4+sLhEgUup9av40tyHuuYWzIRlP10cTSrUQdDpoMVJaKyvmzcobbs4ITZ
	rNG6P4ltjJZ1dd1crm4b7biC/KzNfJoxwIYiplnd/Fg==
X-Gm-Gg: ASbGncuqiTGV2omzS7QdnNmNjnFDyonZZQJlVeFsBaZSMrF8b2rMlJotC2i97ObqQUE
	O4oZYe+DC5C48suH8LjaD7rPoRPzblOJtSW1L0NynmAIN2QDDfJdEb3QTXp8ODf/QKvse+sAIz0
	Gj31EhnbZP6gY30TZCcOPLJNu43bAidZF/UWiYI7vHztjNc4joD3eOD5bJoonHcNn9aQ4OUWmUb
	0AgYi3fKe2U78VMVaPdrCyymBk8E1LwvlZtsb3221n49atW5qCkVV7UUWkk
X-Google-Smtp-Source: AGHT+IG6Lx7X4nwjjCbscanhtEBxXyR+h33EgNAu+2QCvEvhHwb326NmDGLUdbF/Vt5osp1coGpMRs1m4S+7/7joI7g=
X-Received: by 2002:a2e:be03:0:b0:377:d151:c090 with SMTP id
 38308e7fff4ca-378cf8633c5mr16810071fa.1.1761225245249; Thu, 23 Oct 2025
 06:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Oct 2025 15:13:53 +0200
X-Gm-Features: AS18NWDfHk0wnb9yCffDQKbucYaZNvR_wj0zVimsSTgrxikTdx8n5aED-luAQ8o
Message-ID: <CACRpkdZnmMHMWihudwYYuzCm9H_jN_0ZU5+mmS5G4R5m9XkV=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: toshiba,visconti: Fix number of
 items in groups
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Punit Agrawal <punit1.agrawal@toshiba.co.jp>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The "groups" property can hold multiple entries (e.g.
> toshiba/tmpv7708-rm-mbrc.dts file), so allow that by dropping incorrect
> type (pinmux-node.yaml schema already defines that as string-array) and
> adding constraints for items.  This fixes dtbs_check warnings like:
>
>   toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctr=
l):
>     pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_=
grp', 'pwm3_gpio19_grp'] is too long
>
> Fixes: 1825c1fe0057 ("pinctrl: Add DT bindings for Toshiba Visconti TMPV7=
700 SoC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied for fixes.

Yours,
Linus Walleij

