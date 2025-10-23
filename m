Return-Path: <linux-kernel+bounces-866310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C49BFF703
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6303AAEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AFC2BE7B6;
	Thu, 23 Oct 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GHf+lrBm"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55D1B7F4;
	Thu, 23 Oct 2025 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202654; cv=none; b=iNodIYKcKRx9aGYnEa0+cK6IELiy/eFonsD01eT3XDhcs+FFJibk1S/N5qYtRpSCZjdBjoSiNfwGkpoG1EYReBJCdAc+ByVcR0SrLg7yY2n+4PexvG9x0fxr/uw7QGQ/ahVLCucSP2vOM1jfhzSCxzn8Fp9LJJCMo52DSSCCJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202654; c=relaxed/simple;
	bh=KIrjlZ+uFHcYR/eeD7n/cY3o2g6NRumxDpyB7s4yf8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DlwNbxccyrcpD6e+i1eEIRj4Xrb3Qm0xxTq03d0zDyPU2kX3+HELgnUWMBxinDX9S2ojoPxU5loGGhGNl8k3STdgiWzFe15V8rpjlACB2vCMu7BqUqa5eyExAo0Pzi8mbz6pQCnMMQXXjR50zCIJrSwyRUVYnBst9tbewuZDBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GHf+lrBm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 224A31A160F;
	Thu, 23 Oct 2025 06:57:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD1096062C;
	Thu, 23 Oct 2025 06:57:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D715E102F2408;
	Thu, 23 Oct 2025 08:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761202649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dLoS84sI3WPajohaQC0KpHU4wyA5Vb0hbn/MruTGk+s=;
	b=GHf+lrBmpBmgVdtkZP91sFj0DpTN9geFzGA8ihLfWcHmArhd6VWJst+JG8qh1FxhuQHEfq
	/FqHEo7Fy+mAH5T1VBkCdCLtyXBbu+FE0Ou5cvPTdGwIW7tRjKG6AusfdfwAzCRjMm6aVa
	q2lmsxG3Ofyg6wfl+uQFbV/VAE6G9fswgMhd35cGSUWwwkemjHH0VzhJzaMG0WAHC/wCxD
	ZtJviPDLQyk0ZO4/QxwkXgjpalb7AyfA6mLfuVK/0kuy+tX5KoSpixXiYG70OMsRXiPT0n
	91zS7OrSUgqFJsSkBq7XvGK/ZDBg8VEU/R2dZdwlNphzin27YN9luDeR0LVD8A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,  Gregory Clement
 <gregory.clement@bootlin.com>,  Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>,  Richard Cochran
 <richardcochran@gmail.com>,  linux-arm-kernel@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-clk@vger.kernel.org,  linux-gpio@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm: Convert Marvell CP110 System
 Controller to DT schema
In-Reply-To: <20251022165509.3917655-2-robh@kernel.org> (Rob Herring's message
	of "Wed, 22 Oct 2025 11:55:08 -0500")
References: <20251022165509.3917655-2-robh@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 23 Oct 2025 08:57:20 +0200
Message-ID: <87ms5iqf5b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Rob,

> Convert the Marvell CP110 System Controller binding to DT schema
> format.
>
> There's not any specific compatible for the whole block which is a
> separate problem, so just the child nodes are documented. Only the
> pinctrl and clock child nodes need to be converted as the GPIO node
> already has a schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

[...]

> +  "#clock-cells":
> +    const: 2
> +    description: >

I am surprised you prefer a description to a constraint expressed with
yaml. Yet, I am totally fine with it.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

