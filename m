Return-Path: <linux-kernel+bounces-854376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C146DBDE39B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD763AE1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62531CA7B;
	Wed, 15 Oct 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sstVKFXR"
Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406331C58D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526727; cv=pass; b=msZfrTEx2hYROd/Q2q7WnMuTCONLS415h/HTCz83AtvUwdpBd9WibSQ3OkLGV7zboDuhMARUp/JP5LH4M3OdbFI5gQd1qfCAtCUW62xwBYzGDe9zqxP0uJzLhQxLT/GxwC/1pTpi5wRg9+3tBdfORAWeTFUNh2i8F9beio/Qqy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526727; c=relaxed/simple;
	bh=IQLZi+o3p81sZ088oUxtYYhbU8oTpEeC/zcHNH6ZriI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NuGE2mb5kiMuZJIzLg4Lq07/XTJENgRMjTPXd2u9x/C+yvBjTo9jP2AwtMb+W4IZrcxBHiQJXpfCES26FE3zFz98do/prLUWXfAfCrqavvNJDzWWOgabhV1zqTyRH56Acin5FTXXbd7e8ogxKjgy/1hMj6xUVG8eOZw7WOyukB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sstVKFXR; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=E4w1GOq2PLzrOIcTzBnYR+wFf5SigSPjenPgG6rSFhc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760526710;
 b=D+dOPOTlQYp4RD2OzKYbQUFR7FsdeVHx9ij0iJ07W24dR29hZtg06fKWzaed2L/5fJmTDwXh
 HfkXEy3r6rAEG7KCtwPzX9rjZqyspQjxCxdMMBOwWJG8zZrEb+n4NQlMaRpFfjfuJ44otIGq5N2
 mZsRNtZiAghhzM7kh3hIzzaOxVuq6UhUz+wqL/6wilo3s3huRIz20xVNtVrGq9lVO4CB4STXjdw
 hg0N7A9nQneIu71N+6Lpp2KeSpY46dncfawuiHPn2yVyRvkWQ9hnUEvpWIcpmIrBBkuiL3RTC74
 AnoBCz2WOeSbyJ4AlkD/GoIZpfzIkMM/UW6pTSzNfOpwQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760526710;
 b=UQ5VTfF2gvQnr9AY555pp4gWHECb7HVl4D259R9lW/qaVXTLjwi8ldcCsDBAbvxKAs81G9nt
 fnympUw/SNa0wA59aWRQbkrG9DXtZ2DQncO7Yo/Ifg8m6BhSFyow1p9+bgfe3ZZTAmlnSORkMnt
 RVCv0y6uSSGbpBEpciyHTV5jp1HW5XX5/taSuzW48I0EvdMRJ08MrJaNJi4Hf5/P/YrfSd47Pkm
 SU7Tlk7MKxVlP891Clml4WB7F74n0zi429GxhAeyT7QKauXDD7+Eo5PYo/de70JUqUCeue8JYlM
 bjvPXxKCO/2jkA5gzqcMZy6TbmrL8uVw73tovEzNMFR1w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Wed, 15 Oct 2025 13:11:50 +0200
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 9E331A40F3A;
	Wed, 15 Oct 2025 13:11:39 +0200 (CEST)
Message-ID: <3a1f8a96421d4db0eeeed0460b9fdfb57643b137.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/4] mfd: tqmx86: refactor I2C setup
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com, Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 15 Oct 2025 13:11:39 +0200
In-Reply-To: <5723459873610c09c381b1d8755acf989252413e.1760525985.git.matthias.schiffer@ew.tq-group.com>
References: 
	<9e00b0ff4e90e4fb31c3012bd7a753d06ae21b45.1760525985.git.matthias.schiffer@ew.tq-group.com>
	 <5723459873610c09c381b1d8755acf989252413e.1760525985.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4cmpLh12DDz3ybk7
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:8637caed8ca88ec99787e69add264fea
X-cloud-security:scantime:2.042
DKIM-Signature: a=rsa-sha256;
 bh=E4w1GOq2PLzrOIcTzBnYR+wFf5SigSPjenPgG6rSFhc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760526709; v=1;
 b=sstVKFXRkMNaiRRMJvzezwUQnF6NvpgCCnqa5zagBR1sOuir571lmxp2DsOqVtZoSdn9nRyZ
 Z2UOyHpKYt1J2LehuF7A5dBCHAuNvVZ+HDpYyec35jR3Lux8Jw9jjGr8zTaM8qZFkCeZnFO++vG
 aWCrxwC2UPQ/L+1OFKgbLSS+GmlNDW2luD9ktTiwrnK43AAKhcW+dTlMeEWDaBaHeOinjgcZCWO
 B1TdbzsZovMfsvwO0jqdZr+lnvUfq/nX59L51OqNN8QBm2gRDgytTykDEsKtwq3jYn745hZy94B
 RF1ocSyriYTDZBX/Fgo2Mmn+uQKK2xMHaQPNBmuQNFDlA==

On Wed, 2025-10-15 at 13:03 +0200, Matthias Schiffer wrote:
> Preparation for supporting the second I2C controller, and detecting both
> ocores and machxo2 controllers.
>=20
> - Avoid the confusing "soft" I2C controller term - just call it the
>   ocores I2C
> - All non-const parts of the MFD cell are moved from global variables
>   into new functions tqmx86_setup_i2c_ocores() and tqmx86_setup_i2c()
> - Define TQMX86_REG_I2C_DETECT relative to I2C base register
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Ah, Lee Jones was missing in the recipients of this series for the MFD part=
s...
going to resend tomorrow.

Best,
Matthias



> ---
>  drivers/mfd/tqmx86.c | 130 ++++++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 1cba3b67b0fb9..3c6f158bf1a45 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -18,7 +18,7 @@
> =20
>  #define TQMX86_IOBASE	0x180
>  #define TQMX86_IOSIZE	0x20
> -#define TQMX86_IOBASE_I2C	0x1a0
> +#define TQMX86_IOBASE_I2C1	0x1a0
>  #define TQMX86_IOSIZE_I2C	0xa
>  #define TQMX86_IOBASE_WATCHDOG	0x18b
>  #define TQMX86_IOSIZE_WATCHDOG	0x2
> @@ -54,8 +54,8 @@
>  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
>  #define TQMX86_REG_SAUC		0x17
> =20
> -#define TQMX86_REG_I2C_DETECT	0x1a7
> -#define TQMX86_REG_I2C_DETECT_SOFT		0xa5
> +#define TQMX86_REG_I2C_DETECT	0x7
> +#define TQMX86_REG_I2C_DETECT_OCORES	0xa5
> =20
>  static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
> @@ -65,17 +65,6 @@ static uint i2c1_irq;
>  module_param(i2c1_irq, uint, 0);
>  MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)=
");
> =20
> -enum tqmx86_i2c1_resource_type {
> -	TQMX86_I2C1_IO,
> -	TQMX86_I2C1_IRQ,
> -};
> -
> -static struct resource tqmx_i2c_soft_resources[] =3D {
> -	[TQMX86_I2C1_IO] =3D DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C=
),
> -	/* Placeholder for IRQ resource */
> -	[TQMX86_I2C1_IRQ] =3D {},
> -};
> -
>  static const struct resource tqmx_watchdog_resources[] =3D {
>  	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
>  };
> @@ -91,28 +80,13 @@ static struct resource tqmx_gpio_resources[] =3D {
>  	[TQMX86_GPIO_IRQ] =3D {},
>  };
> =20
> -static struct i2c_board_info tqmx86_i2c_devices[] =3D {
> +static const struct i2c_board_info tqmx86_i2c1_devices[] =3D {
>  	{
>  		/* 4K EEPROM at 0x50 */
>  		I2C_BOARD_INFO("24c32", 0x50),
>  	},
>  };
> =20
> -static struct ocores_i2c_platform_data ocores_platform_data =3D {
> -	.num_devices =3D ARRAY_SIZE(tqmx86_i2c_devices),
> -	.devices =3D tqmx86_i2c_devices,
> -};
> -
> -static const struct mfd_cell tqmx86_i2c_soft_dev[] =3D {
> -	{
> -		.name =3D "ocores-i2c",
> -		.platform_data =3D &ocores_platform_data,
> -		.pdata_size =3D sizeof(ocores_platform_data),
> -		.resources =3D tqmx_i2c_soft_resources,
> -		.num_resources =3D ARRAY_SIZE(tqmx_i2c_soft_resources),
> -	},
> -};
> -
>  static const struct mfd_cell tqmx86_devs[] =3D {
>  	{
>  		.name =3D "tqmx86-wdt",
> @@ -238,13 +212,74 @@ static int tqmx86_setup_irq(struct device *dev, con=
st char *label, u8 irq,
>  	return 0;
>  }
> =20
> +static int tqmx86_setup_i2c(struct device *dev, const char *name,
> +			    unsigned long i2c_base, const void *platform_data,
> +			    size_t pdata_size, u8 irq)
> +{
> +	const struct resource resources[] =3D {
> +		DEFINE_RES_IO(i2c_base, TQMX86_IOSIZE_I2C),
> +		irq ? DEFINE_RES_IRQ(irq) : (struct resource) {},
> +	};
> +	const struct mfd_cell i2c_dev =3D {
> +		.name =3D name,
> +		.platform_data =3D platform_data,
> +		.pdata_size =3D pdata_size,
> +		.resources =3D resources,
> +		.num_resources =3D ARRAY_SIZE(resources),
> +	};
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, &i2c_dev, 1,
> +				    NULL, 0, NULL);
> +
> +}
> +
> +static int tqmx86_setup_i2c_ocores(struct device *dev, const char *label=
,
> +				   unsigned long i2c_base, int clock_khz, u8 irq,
> +				   const struct i2c_board_info *devices,
> +				   size_t num_devices)
> +{
> +	const struct ocores_i2c_platform_data platform_data =3D {
> +		.clock_khz =3D clock_khz,
> +		.num_devices =3D num_devices,
> +		.devices =3D devices,
> +	};
> +
> +	return tqmx86_setup_i2c(dev, "ocores-i2c", i2c_base, &platform_data,
> +				sizeof(platform_data), irq);
> +}
> +
> +static int tqmx86_detect_i2c(struct device *dev, const char *label,
> +			     unsigned long i2c_base, int clock_khz, u8 irq,
> +			     const struct i2c_board_info *devices,
> +			     size_t num_devices, void __iomem *io_base,
> +			     u8 irq_reg_shift)
> +{
> +	u8 i2c_det;
> +
> +	if (tqmx86_setup_irq(dev, label, irq, io_base, irq_reg_shift))
> +		irq =3D 0;
> +
> +	/*
> +	 * The I2C_DETECT register is in the range assigned to the I2C driver
> +	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
> +	 * access instead of ioport_map + unmap.
> +	 */
> +	i2c_det =3D inb(i2c_base + TQMX86_REG_I2C_DETECT);
> +
> +	if (i2c_det =3D=3D TQMX86_REG_I2C_DETECT_OCORES)
> +		return tqmx86_setup_i2c_ocores(dev, label, i2c_base, clock_khz,
> +					       irq, devices, num_devices);
> +
> +	return 0;
> +}
> +
>  static int tqmx86_probe(struct platform_device *pdev)
>  {
> -	u8 board_id, sauc, rev, i2c_det;
> +	u8 board_id, sauc, rev;
>  	struct device *dev =3D &pdev->dev;
>  	const char *board_name;
>  	void __iomem *io_base;
> -	int err;
> +	int err, clock_khz;
> =20
>  	io_base =3D devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
>  	if (!io_base)
> @@ -259,13 +294,6 @@ static int tqmx86_probe(struct platform_device *pdev=
)
>  		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
>  		 board_name, board_id, rev >> 4, rev & 0xf);
> =20
> -	/*
> -	 * The I2C_DETECT register is in the range assigned to the I2C driver
> -	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
> -	 * access instead of ioport_map + unmap.
> -	 */
> -	i2c_det =3D inb(TQMX86_REG_I2C_DETECT);
> -
>  	if (gpio_irq) {
>  		err =3D tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
>  				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
> @@ -273,23 +301,13 @@ static int tqmx86_probe(struct platform_device *pde=
v)
>  			tqmx_gpio_resources[TQMX86_GPIO_IRQ] =3D DEFINE_RES_IRQ(gpio_irq);
>  	}
> =20
> -	ocores_platform_data.clock_khz =3D tqmx86_board_id_to_clk_rate(dev, boa=
rd_id);
> -
> -	if (i2c_det =3D=3D TQMX86_REG_I2C_DETECT_SOFT) {
> -		if (i2c1_irq) {
> -			err =3D tqmx86_setup_irq(dev, "I2C1", i2c1_irq, io_base,
> -					       TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
> -			if (!err)
> -				tqmx_i2c_soft_resources[TQMX86_I2C1_IRQ] =3D DEFINE_RES_IRQ(i2c1_irq=
);
> -		}
> -
> -		err =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -					   tqmx86_i2c_soft_dev,
> -					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> -					   NULL, 0, NULL);
> -		if (err)
> -			return err;
> -	}
> +	clock_khz =3D tqmx86_board_id_to_clk_rate(dev, board_id);
> +
> +	err =3D tqmx86_detect_i2c(dev, "I2C1", TQMX86_IOBASE_I2C1, clock_khz, i=
2c1_irq,
> +				tqmx86_i2c1_devices, ARRAY_SIZE(tqmx86_i2c1_devices),
> +				io_base, TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
> +	if (err)
> +		return err;
> =20
>  	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  				    tqmx86_devs,

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

