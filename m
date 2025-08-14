Return-Path: <linux-kernel+bounces-768603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51535B26320
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908085E0DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2452E9EC1;
	Thu, 14 Aug 2025 10:43:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426212264CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168195; cv=none; b=AOAiU+z6iLDi/yOUopJyY5NDKuC5SsJJ5mihZKnfGTYksGTJKkTNxt4Ta6vpwp173rllkptUgtMGl2aouvU0D8EHqd1wXmMiObzOmzLfbrS+Ljxqto/bN6cDst5BDKJOXYLQX0EY8eDyEDGFR60nEad+OLB877LRJkl43hOchQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168195; c=relaxed/simple;
	bh=x2ApPy1qF/YIfHHw1JmVw7RXJiwWvxw7Xr6gXJ4k/1Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKkeCRJRetz8gAyBhFkrQ3M/zvA4rHi9xXkc9E7t2C6w6y7Dpuz+uBZkVTCPVKKyVugkuU8AZjK7nCX8E4KorOh0Cb9DnUwVU+P0xw60L7LMiwo3h984E4WF2AHaYnFYsT0qHxshn2s3s068WxnMTPKFbMsSl11J2g4qNshkVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVPp-0008Iy-NQ; Thu, 14 Aug 2025 12:42:37 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVPl-000EwX-2f;
	Thu, 14 Aug 2025 12:42:33 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVPl-000GxG-2N;
	Thu, 14 Aug 2025 12:42:33 +0200
Message-ID: <bf5a4aa0fc1a324a17c25e8ed5acbfd94d240251.camel@pengutronix.de>
Subject: Re: [PATCH v17 2/3] i2c: ast2600: Add controller driver for new
 register layout
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, benh@kernel.crashing.org, 
 joel@jms.id.au, andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
  conor+dt@kernel.org, andrew@codeconstruct.com.au, 
 andriy.shevchenko@linux.intel.com, naresh.solanki@9elements.com, 
 linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 12:42:33 +0200
In-Reply-To: <20250814084156.1650432-3-ryan_chen@aspeedtech.com>
References: <20250814084156.1650432-1-ryan_chen@aspeedtech.com>
	 <20250814084156.1650432-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Do, 2025-08-14 at 16:41 +0800, Ryan Chen wrote:
> Add i2c-ast2600 new register mode driver to support AST2600
> i2c new register mode. This i2c-ast2600 new driver and the
> legacy i2c-aspeed driver both match the same compatible string
> "aspeed,ast2600-i2c-bus" because they target the same I2C
> controller IP on AST2600. However, AST2600 SoCs may configure
> the controller instances to operate either in the legacy
> register layout or the new layout (via global register).
> The new register mode support following.
>=20
> - Add new clock divider option for more flexible and accurate
>  clock rate generation
> - Add tCKHighMin timing to guarantee SCL high pulse width.
> - Add support dual pool buffer mode, split 32 bytes pool buffer
>  of each device into 2 x 16 bytes for Tx and Rx individually.
> - Increase DMA buffer size to 4096 bytes and support byte alignment.
> - Re-define the base address of BUS1 ~ BUS16 and Pool buffer.
> - Re-define registers for separating controller and target
>  mode control.
> - Support 4 individual DMA buffers for controller Tx and Rx,
>  target Tx and Rx.
>=20
> And following is new register set for package transfer sequence.
> - New Master operation mode:
>   S -> Aw -> P
>   S -> Aw -> TxD -> P
>   S -> Ar -> RxD -> P
>   S -> Aw -> TxD -> Sr -> Ar -> RxD -> P
> - Bus SDA lock auto-release capability for new controller DMA
>  command mode.
> - Bus auto timeout for new controller/target DMA mode.
>=20
> Since the register layout is selected via a global register at
> runtime and both drivers bind to the same compatible string,
> this patch defines the driver selection at build-time using
> Kconfig, ensuring that only one driver is compiled into the
> kernel. This approach avoids ambiguity and ensures consistent
> behavior for each platform configuration.
>=20
> The following is two versus register layout.
> Old register mode:
> {I2CD00}: Function Control Register
> {I2CD04}: Clock and AC Timing Control Register
> {I2CD08}: Clock and AC Timing Control Register
> {I2CD0C}: Interrupt Control Register
> {I2CD10}: Interrupt Status Register
> {I2CD14}: Command/Status Register
> {I2CD18}: Slave Device Address Register
> {I2CD1C}: Pool Buffer Control Register
> {I2CD20}: Transmit/Receive Byte Buffer Register
> {I2CD24}: DMA Mode Buffer Address Register
> {I2CD28}: DMA Transfer Length Register
> {I2CD2C}: Original DMA Mode Buffer Address Setting
> {I2CD30}: Original DMA Transfer Length Setting and Final Status
>=20
> New Register mode
> {I2CC00}: Master/Slave Function Control Register
> {I2CC04}: Master/Slave Clock and AC Timing Control Register
> {I2CC08}: Master/Slave Transmit/Receive Byte Buffer Register
> {I2CC0C}: Master/Slave Pool Buffer Control Register
> {I2CM10}: Master Interrupt Control Register
> {I2CM14}: Master Interrupt Status Register
> {I2CM18}: Master Command/Status Register
> {I2CM1C}: Master DMA Buffer Length Register
> {I2CS20}: Slave~ Interrupt Control Register
> {I2CS24}: Slave~ Interrupt Status Register
> {I2CS28}: Slave~ Command/Status Register
> {I2CS2C}: Slave~ DMA Buffer Length Register
> {I2CM30}: Master DMA Mode Tx Buffer Base Address
> {I2CM34}: Master DMA Mode Rx Buffer Base Address
> {I2CS38}: Slave~ DMA Mode Tx Buffer Base Address
> {I2CS3C}: Slave~ DMA Mode Rx Buffer Base Address
> {I2CS40}: Slave Device Address Register
> {I2CM48}: Master DMA Length Status Register
> {I2CS4C}: Slave  DMA Length Status Register
> {I2CC50}: Current DMA Operating Address Status
> {I2CC54}: Current DMA Operating Length  Status
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/i2c/busses/Kconfig       |   23 +-
>  drivers/i2c/busses/Makefile      |    1 +
>  drivers/i2c/busses/i2c-ast2600.c | 1038 ++++++++++++++++++++++++++++++
>  3 files changed, 1054 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-ast2600.c
>=20
[...]
> diff --git a/drivers/i2c/busses/i2c-ast2600.c b/drivers/i2c/busses/i2c-as=
t2600.c
> new file mode 100644
> index 000000000000..15e600ff50ec
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-ast2600.c
> @@ -0,0 +1,1038 @@
[...]
> +static int ast2600_i2c_probe(struct platform_device *pdev)
> +{
>=20
[...]
> +	i2c_bus->rst =3D devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(i2c_bus->rst))
> +		return dev_err_probe(dev, PTR_ERR(i2c_bus->rst), "Missing reset ctrl\n=
");

What ...

> +	i2c_bus->rst =3D devm_reset_control_get_shared_deasserted(dev, NULL);
> +	if (IS_ERR(i2c_bus->rst))
> +		return dev_err_probe(dev, PTR_ERR(i2c_bus->rst), "Missing reset ctrl\n=
");

... is this?

Choose one. If you use 1), call reset_control_deassert() somewhere. If
you use 2), remove reset_control_assert() below.

[...]
> +static void ast2600_i2c_remove(struct platform_device *pdev)
> +{
> +	struct ast2600_i2c_bus *i2c_bus =3D platform_get_drvdata(pdev);
> +
> +	/* Disable everything. */
> +	writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> +	writel(0, i2c_bus->reg_base + AST2600_I2CM_IER);
> +	reset_control_assert(i2c_bus->rst);

Drop if using devm_reset_control_get_shared_deasserted()

regards
Philipp

