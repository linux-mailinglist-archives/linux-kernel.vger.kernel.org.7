Return-Path: <linux-kernel+bounces-878331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09125C204CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C67560261
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C0247DE1;
	Thu, 30 Oct 2025 13:40:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C79244664
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831651; cv=none; b=WkkgJqPyGtjtbNF2cJLsrSP9AO2WUj4ETYJHc6WYiC0CfuCPnYZERQqVvCZfc9IuropFnLKz9JwSWx2sihTuqovivTL8Wqn8mIlmbZejBSxY+q3sKqng3fylzHH9ArFC6fRZYeXZCxQdAB7aGfSck9rjppVkkhX4QP7uhTq05j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831651; c=relaxed/simple;
	bh=isL6VAbzP+Fzay1Fnne65npENcp69zfoG4XwP/FfAdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uy/y1y+V38bUAxPf9Idq+G3LKNbz4gt21ivS3uVUG2LkvPkBI4a09crtv6q0l/fWFC04+GABoQWfMR7n9F8RLe+EuA9C2QXHy+gR4UzKzUFatkh7ZC+qLTHZoM2DUuBaei6uQriCavRMbHm6Osj+vziY4D+17fE4dbNQ+lLdcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEStC-0002QT-NZ; Thu, 30 Oct 2025 14:40:30 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEStC-006DiW-0z;
	Thu, 30 Oct 2025 14:40:30 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vEStC-00000000AGH-0uQV;
	Thu, 30 Oct 2025 14:40:30 +0100
Message-ID: <4e3c3c3d6c1a0d2905a90e5f1c0b2cb8f67bc43b.camel@pengutronix.de>
Subject: Re: [PATCH v6 1/7] reset: mpfs: add non-auxiliary bus probing
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Conor Dooley <conor@kernel.org>, claudiu.beznea@tuxon.dev
Cc: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
	 <daire.mcnamara@microchip.com>, pierre-henry.moussay@microchip.com, 
	valentina.fernandezalanis@microchip.com, Michael Turquette
	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 14:40:30 +0100
In-Reply-To: <20251029-macarena-neglector-318431fec367@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
	 <20251029-macarena-neglector-318431fec367@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Mi, 2025-10-29 at 16:11 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> While the auxiliary bus was a nice bandaid, and meant that re-writing
> the representation of the clock regions in devicetree was not required,
> it has run its course. The "mss_top_sysreg" region that contains the
> clock and reset regions, also contains pinctrl and an interrupt
> controller, so the time has come rewrite the devicetree and probe the
> reset controller from an mfd devicetree node, rather than implement
> those drivers using the auxiliary bus. Wanting to avoid propagating this
> naive/incorrect description of the hardware to the new pic64gx SoC is a
> major motivating factor here.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v6:
> - depend on MFD_SYSCON
> - return regmap_update_bits() result directly instead of an additional
>   return 0
>=20
> v4:
> - Only use driver specific lock for non-regmap writes
>=20
> v2:
> - Implement the request to use regmap_update_bits(). I found that I then
>   hated the read/write helpers since they were just bloat, so I ripped
>   them out. I replaced the regular spin_lock_irqsave() stuff with a
>   guard(spinlock_irqsave), since that's a simpler way of handling the two
>   different paths through such a trivial pair of functions.
> ---
>  drivers/reset/Kconfig      |  1 +
>  drivers/reset/reset-mpfs.c | 79 ++++++++++++++++++++++++++++++--------
>  2 files changed, 63 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 78b7078478d4..0ec4b7cd08d6 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -200,6 +200,7 @@ config RESET_PISTACHIO
>  config RESET_POLARFIRE_SOC
>  	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
>  	depends on MCHP_CLK_MPFS
> +	depends on MFD_SYSCON
>  	select AUXILIARY_BUS
>  	default MCHP_CLK_MPFS
>  	help
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index f6fa10e03ea8..25de7df55301 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -7,13 +7,16 @@
>   *
>   */
>  #include <linux/auxiliary_bus.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> +#include <linux/slab.h>
>  #include <dt-bindings/clock/microchip,mpfs-clock.h>
>  #include <soc/microchip/mpfs.h>
> =20
> @@ -27,11 +30,14 @@
>  #define MPFS_SLEEP_MIN_US	100
>  #define MPFS_SLEEP_MAX_US	200
> =20
> +#define REG_SUBBLK_RESET_CR	0x88u
> +
>  /* block concurrent access to the soft reset register */
>  static DEFINE_SPINLOCK(mpfs_reset_lock);
> =20
>  struct mpfs_reset {
>  	void __iomem *base;
> +	struct regmap *regmap;
>  	struct reset_controller_dev rcdev;
>  };
> =20
> @@ -46,41 +52,46 @@ static inline struct mpfs_reset *to_mpfs_reset(struct=
 reset_controller_dev *rcde
>  static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long=
 id)
>  {
>  	struct mpfs_reset *rst =3D to_mpfs_reset(rcdev);
> -	unsigned long flags;
>  	u32 reg;
> =20
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap)
> +		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), B=
IT(id));

This could use regmap_set_bits().

> +
> +	guard(spinlock_irqsave)(&mpfs_reset_lock);
> =20
>  	reg =3D readl(rst->base);
>  	reg |=3D BIT(id);
>  	writel(reg, rst->base);

Since I've just seen this in the i.MX8ULP series [1], it would be
cleaner to convert the aux driver to regmap as well. The readl/writel()
code paths could be dropped then.

[1] https://lore.kernel.org/lkml/20251029135229.890-1-laurentiumihalcea111@=
gmail.com/

[...]
>  static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned lo=
ng id)
>  {
>  	struct mpfs_reset *rst =3D to_mpfs_reset(rcdev);
> -	unsigned long flags;
>  	u32 reg;
> =20
> -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> +	if (rst->regmap)
> +		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id), 0=
);

And this could use regmap_clear_bits().

regards
Philipp

