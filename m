Return-Path: <linux-kernel+bounces-809673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73572B510AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA74656BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA526E71F;
	Wed, 10 Sep 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="b27TofHo"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E726F2B0;
	Wed, 10 Sep 2025 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491449; cv=none; b=M4yzmEUV7dOyRC3RezrdHbx2sojF0x16tki2fBqhk2NQYYpj7MbHW0fnRDvS1Pb4FsEQ7KuFB42F6EF0eVmN0ggCooCqMS1oFclBGpLYjX3wZJl714m75zZDB+JEUdubBW/ATX1cJx0TzM8jSQVhhlnN1cXauICFl69Ql+UUjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491449; c=relaxed/simple;
	bh=aT9/QxgsrdtzHfIkN7TCxu2ibMmhyuA0DfinT5mj1Q8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDJFyPSFszESKdCisu2X8ASHJFOjse7Xn6SKFVBLRYheDh5G3CiIo6UOGEJ6o/NWuB9Sp7AA8mDMl/T2foG2+/5teqCP3xO8MI1Plg/TLd1mfoVbizlARd8YuOy6UDfb6ephYmsQi00pHiH9Sw11ZaVohFE7pmHfFx8ay+hyN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=b27TofHo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757491444;
	bh=fzNTik6LdctRq+11rsbBa0F2ScxGWkODX58Sql9E4zs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b27TofHo5ULqqI+QmujnqYdlbdiWdz9DVokvkqTgkEFgsXFD448KpWaywZTTpWGtL
	 2dVSl0eTJbXGyFvVnR6OJhlbD6YXvqhwFdoMizybCTdoApRdlUy239gcRu5Dbaq6eO
	 e6cZ+4eEWnhhKDDm+ShwM/1FWZ4iipwqfoFMR5xJ+d2AQFp2yFhxlAjn1mJKrxCFkM
	 hPcrLXrYnCjvCgA/jVMODD0nOiJHfno5RPVKDZo/QS1GVsB0QMgyP0BJA0oV5o7/bx
	 ENjCKEQ8zDc4y1ZGEenKLP2KGv4BCjo9iRj0aooHQwS/tDd8JFB7sK4OLGKeWoblKz
	 mZVTfg+KWFpPQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C0D467672;
	Wed, 10 Sep 2025 16:04:02 +0800 (AWST)
Message-ID: <ba605a2fdcfbb265f260ba1cfcb30c80e1d62f7c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] arm64: dts: nuvoton: Add NPCM845 SoC and EVB
 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 avifishman70@gmail.com,  tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com,  benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 17:34:02 +0930
In-Reply-To: <20250908125938.3584927-1-tmaimon77@gmail.com>
References: <20250908125938.3584927-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tomer,

On Mon, 2025-09-08 at 15:59 +0300, Tomer Maimon wrote:
> This series adds device tree support for peripherals on the Nuvoton NPCM8=
45=20
> SoC and its Evaluation Board (EVB).
> The first patch introduces peripheral nodes for Ethernet, MMC, SPI, USB,
> RNG, ADC, PWM-FAN, I2C, and OP-TEE firmware in the NPCM845 SoC device tre=
e.
> The second patch enables these peripherals for the NPCM845-EVB, adding
> MDIO nodes, reserved memory, aliases, and board-specific configurations
> like PHY modes and SPI flash partitions.
>=20
> The NPCM8XX device tree tested on NPCM845 evaluation board.
>=20
> Addressed comments from:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Krzysztof Kozlowski: ht=
tps://lkml.indiana.edu/2507.3/05464.html
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 https://lkml.indiana.edu/2507.3/05465.html
> Changes since version 1:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Fix commit message
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Fix dtbs_check warnings=
.
>=20
> Tomer Maimon (2):
> =C2=A0 arm64: dts: nuvoton: npcm845: Add peripheral nodes
> =C2=A0 arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
>=20
> =C2=A0.../dts/nuvoton/nuvoton-common-npcm8xx.dtsi=C2=A0=C2=A0 | 702 +++++=
++++++++++++-
> =C2=A0.../boot/dts/nuvoton/nuvoton-npcm845-evb.dts=C2=A0 | 439 ++++++++++=
+
> =C2=A0.../boot/dts/nuvoton/nuvoton-npcm845.dtsi=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 7 +
> =C2=A03 files changed, 1147 insertions(+), 1 deletion(-)
>=20

Running `make CHECK_DTBS=3Dy nuvoton/nuvoton-npcm845-evb.dtb` after
applying the patches on next-20250908 I get the warnings below. Given

- https://docs.kernel.org/process/maintainer-soc.html#validating-devicetree=
-files

and

- https://docs.kernel.org/process/maintainer-soc-clean-dts.html

can you please tidy this up?

Thanks,

Andrew

[I] 0 andrew@heihei ~/s/k/l/o/build.arm64.default ((00e2ab2e))> make CHECK_=
DTBS=3Dy nuvoton/nuvoton-npcm845-evb.dtb
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC [C] arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: / (nuvoton,npcm845-evb): memory@0: '=
device_type' is a required property
        from schema $id: http://devicetree.org/schemas/memory.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: system-controller@f0800000 (nuvoton,=
npcm845-gcr): compatible: ['nuvoton,npcm845-gcr', 'syscon'] is too short
        from schema $id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,=
npcm-gcr.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: interrupt-controller@dfff9000 (arm,g=
ic-400): 'ppi-partitions' does not match any of the regexes: '^pinctrl-[0-9=
]+$', '^v2m@[0-9a-f]+$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller=
/arm,gic.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: mmc@f0842000 (nuvoton,npcm845-sdhci)=
: Unevaluated properties are not allowed ('clock-names' was unexpected)
        from schema $id: http://devicetree.org/schemas/mmc/npcm,sdhci.yaml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb000000: fai=
led to match any schema with compatible: ['nuvoton,npcm845-fiu']
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): $nodename=
:0: 'spi-nor@0' does not match '^(flash|.*sram|nand)(@.*)?$'
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): partition=
s: Unevaluated properties are not allowed ('spare1@D00000', 'spare2@F00000'=
 were unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): Unevaluat=
ed properties are not allowed ('partitions' was unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb002000: fai=
led to match any schema with compatible: ['nuvoton,npcm845-fiu']
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): $nodename=
:0: 'spi-nor@0' does not match '^(flash|.*sram|nand)(@.*)?$'
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): Unevaluat=
ed properties are not allowed ('partitions' was unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@c0000000: fai=
led to match any schema with compatible: ['nuvoton,npcm845-fiu']
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): $nodename=
:0: 'spi-nor@0' does not match '^(flash|.*sram|nand)(@.*)?$'
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: spi-nor@0 (jedec,spi-nor): Unevaluat=
ed properties are not allowed ('partitions' was unexpected)
        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.ya=
ml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/spi@fb001000: fai=
led to match any schema with compatible: ['nuvoton,npcm845-fiu']
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0830000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0830000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0831000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0831000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0832000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0832000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0833000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0833000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0834000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0834000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0835000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0835000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0836000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0836000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0837000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0837000 (nuvoton,npcm845-udc): =
Unevaluated properties are not allowed ('compatible' was unexpected)
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0838000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: usb@f0839000 (nuvoton,npcm845-udc): =
compatible: 'oneOf' conditional failed, one must be fixed:
        ['nuvoton,npcm845-udc'] is too short
        'nuvoton,npcm845-udc' is not one of ['chipidea,usb2', 'lsi,zevio-us=
b', 'nuvoton,npcm750-udc', 'nvidia,tegra20-ehci', 'nvidia,tegra20-udc', 'nv=
idia,tegra30-ehci', 'nvidia,tegra30-udc', 'nvidia,tegra114-udc', 'nvidia,te=
gra124-udc', 'nxp,s32g2-usb', 'qcom,ci-hdrc']
        'nuvoton,npcm845-udc' is not one of ['nvidia,tegra114-ehci', 'nvidi=
a,tegra124-ehci', 'nvidia,tegra210-ehci']
        'xlnx,zynq-usb-2.20a' was expected
        'nuvoton,npcm845-udc' is not one of ['nxp,s32g3-usb']
        from schema $id: http://devicetree.org/schemas/usb/ci-hdrc-usb2.yam=
l#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/spi@=
201000: failed to match any schema with compatible: ['nuvoton,npcm845-pspi'=
]
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: timer@8000 (nuvoton,npcm845-timer): =
'clock-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/timer/nuvoton,npcm7x=
x-timer.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: rng@b000 (nuvoton,npcm845-rng): 'clo=
cks' does not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/rng/nuvoton,npcm-rng=
.yaml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@801c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@901c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/watc=
hdog@a01c: failed to match any schema with compatible: ['nuvoton,npcm845-wd=
t', 'nuvoton,npcm750-wdt']
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/pwm-=
fan-controller@103000: failed to match any schema with compatible: ['nuvoto=
n,npcm845-pwm-fan']
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@0: fan-tach-ch: b'\x00\x01' is n=
ot of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@1: fan-tach-ch: b'\x02\x03' is n=
ot of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@2: fan-tach-ch: b'\x04\x05' is n=
ot of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@3: fan-tach-ch: b'\x06\x07' is n=
ot of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@4: fan-tach-ch: b'\x08\t' is not=
 of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@5: fan-tach-ch: b'\n\x0b' is not=
 of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@6: fan-tach-ch: b'\x0c\r' is not=
 of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
/home/andrew/src/kernel.org/linux/origin/build.arm64.default/arch/arm64/boo=
t/dts/nuvoton/nuvoton-npcm845-evb.dtb: fan@7: fan-tach-ch: b'\x0e\x0f' is n=
ot of type 'object', 'integer', 'array', 'boolean', 'null'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /ahb/bus@f0000000/i2c@=
86000/tmp100@48: failed to match any schema with compatible: ['tmp100']



