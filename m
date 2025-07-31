Return-Path: <linux-kernel+bounces-752413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60769B17542
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC4518C2737
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08F23DEAD;
	Thu, 31 Jul 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvI/b5aF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09FA921;
	Thu, 31 Jul 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980631; cv=none; b=iX8W3SGMVETNM6h17XP9tZg6LxyiD8neezZ/z793EZ7ucht96qIikpBBHki3PRYzTFYFEJ1SdqLxU/gaB8Y2r9IkywV3o9qm/z1BbzZYNhGE0nK2CMoiImuyAQHzhH9+XODRyWPUMl8yvcy9QvbsLpDvE3iCr1iptP7yAznXVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980631; c=relaxed/simple;
	bh=TnKnojD8pZKJi4gCb3oaHc/q/bUH6sldEJl1RFC71Ic=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EqZjcoY6gcfPSc/qTDSXWoxR6h4XVQ1UkWF+Id3bu6/YwPrXv7GvhS1NyD5mXcPmuEquhEdBLQzERxugn8DkF5QIPH75Q1VJxLIU9IWfC9burxY71E7/eZkUe5zkuS+8b9eZyjNSgQFFl6uYSqHPfbHE80iuxupBPYwY+bbLpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvI/b5aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6497EC4CEEF;
	Thu, 31 Jul 2025 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980630;
	bh=TnKnojD8pZKJi4gCb3oaHc/q/bUH6sldEJl1RFC71Ic=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pvI/b5aF6F/b4g9tlhY8oUo1Ig1H8yGtRHeHW3f/o1UWV40cD4BBGkAcOsk+fUUkq
	 t5915J68JfcApQqbtP7tR0W/6pfx7X2brVDHan+cFlUMGlGYS1EDpW1vHH86KCcVNI
	 0W8HHYbOqwrdqKMpEuVecdsMfGxlnMH5glU+li8srCZvckxSP59NreNrdTZIp57S+L
	 P6Vc+XQgYK/sdnIXSOx+3agXDHQFeVTAMeQhUQC5YUUhRbhWZvD3cBtWK8t6rsGeko
	 ETHFk6uY0xrNO8dYQmayv5GVyh9xR+LLrVXeJFmHcWxOpv6/pIRrccu90K0pK7GsCN
	 2pSj/vtBWAgvQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK9=C2WRVHZ4FdoW0fKRRFg6qAC5asn03dHj_NXkMKfBXKkXdA@mail.gmail.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704070356.1683992-9-apatel@ventanamicro.com> <175341132347.3513.7184287611040628050@lazor> <CAK9=C2UDV3xCpKxZmT4NsRvN=hCcQrcx0fr-QFD2fuOrqmXmHA@mail.gmail.com> <175359739515.3513.8664828076215459722@lazor> <CAK9=C2WRVHZ4FdoW0fKRRFg6qAC5asn03dHj_NXkMKfBXKkXdA@mail.gmail.com>
Subject: Re: [PATCH v8 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-acp
  <i@vger.kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
To: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 31 Jul 2025 09:50:29 -0700
Message-ID: <175398062959.3513.15195554063633980579@lazor>
User-Agent: alot/0.11

Quoting Anup Patel (2025-07-28 02:19:23)
> On Sun, Jul 27, 2025 at 11:53=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> =
wrote:
> >
> > It's not providing clks? The SBI firmware is not discoverable? Do you
> > have a pointer to the DTS for this node and the clock controller node in
> > the next patch? I'd like to understand why this is named a clock
> > controller when it doesn't provide clks.
>=20
> The firmware driver is not providing clks. Also, the SBI firmware and
> various SBI extensions are indeed discoverable from supervisor software.

If SBI extensions are discoverable from software why do we need a DT
binding?

