Return-Path: <linux-kernel+bounces-873256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0984C1384F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A391B542A30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A972D8DB0;
	Tue, 28 Oct 2025 08:18:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1142D878C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639501; cv=none; b=FvRPxKCgPYEkD7Agv9tUhnmsoBUH0LGVHU8NprW1vQki4NbneR21WnwKY3J8/inzgo5pPL8Rx+XA6uq9wkCPPxw84Qi1Kgxzd0S1UVbPdpEHbR9em78YGHbke0Ohn+ho2/vHsZIIB4EVfqBbeAGbdqMMDeNZq2so/H5/RNWM09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639501; c=relaxed/simple;
	bh=4pr8j+vyLR4qOLCMAuSM0l2HxTbXCqaGmlHYbv487bk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOqqZ0QGhokxarEmCneGTUdi88/IF9mTawUe5LjqTyySYE4RePC2KutuIiqyhwWFan2N9FEJdqcw8iqH8H5XXL0UOW9GQezYhOx8C8ghszbJGTMrkMfZE5qBPQ+dtmAWKPZ9n8aWWHP7P6FBKVEKtntrlwexxFw1jYbFUvp2GVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vDeu0-000287-GT; Tue, 28 Oct 2025 09:18:00 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vDetx-005qNe-2y;
	Tue, 28 Oct 2025 09:17:57 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vDetx-000000002YE-3YQN;
	Tue, 28 Oct 2025 09:17:57 +0100
Message-ID: <36d28431c41ec9ed86487135d81e50b136ee0fae.camel@pengutronix.de>
Subject: Re: [PATCH v2 4/6] reset: anlogic: add support for Anlogic DR1V90
 resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Michael Turquette
	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	 <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Date: Tue, 28 Oct 2025 09:17:57 +0100
In-Reply-To: <20251026-dr1v90-cru-v2-4-43b67acd6ddd@pigmoral.tech>
References: <20251026-dr1v90-cru-v2-0-43b67acd6ddd@pigmoral.tech>
	 <20251026-dr1v90-cru-v2-4-43b67acd6ddd@pigmoral.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On So, 2025-10-26 at 22:00 +0800, Junhui Liu wrote:
> Add reset controller support for the Anlogic DR1V90 SoC, which is an
> auxiliary device associated with the Clock and Reset Unit (CRU). All
> resets are active-low.
>=20
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/reset/Kconfig        |   9 +++
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-dr1v90.c | 135 +++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 145 insertions(+)
>=20
[...]
> diff --git a/drivers/reset/reset-dr1v90.c b/drivers/reset/reset-dr1v90.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..eb9064e3ab454fb39adc1ad42=
6f458e39bb6169e
> --- /dev/null
> +++ b/drivers/reset/reset-dr1v90.c
> @@ -0,0 +1,135 @@
[...]
> +static const struct dr1v90_reset_map dr1v90_resets[] =3D {
> +	[RESET_OCM]		=3D { 0x74, BIT(4)},
[...]
> +	[RESET_NIC_HP0]		=3D { 0x78, BIT(0)},
[...]
> +	[RESET_USB0]		=3D { 0x7C, BIT(0)},

The registers 0x74, 0x78, and 0x7C are exclusively used for resets?

[...]
> +};
> +
> +static int dr1v90_reset_control_update(struct reset_controller_dev *rcde=
v,
> +				       unsigned long id, bool assert)
> +{
> +	struct dr1v90_reset_controller *rstc =3D to_dr1v90_reset_controller(rcd=
ev);
> +	u32 offset =3D dr1v90_resets[id].offset;
> +	u32 bit =3D dr1v90_resets[id].bit;
> +	u32 reg;
> +
> +	reg =3D readl(rstc->base + offset);
> +	if (assert)
> +		reg &=3D ~bit;
> +	else
> +		reg |=3D bit;
> +	writel(reg, rstc->base + offset);

There should be a lock around this read-modify-write access.

regards
Philipp

