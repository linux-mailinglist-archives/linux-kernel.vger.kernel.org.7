Return-Path: <linux-kernel+bounces-860815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25DBF1082
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944613B4DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1D30506F;
	Mon, 20 Oct 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RsZoBfFS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4431282A;
	Mon, 20 Oct 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962373; cv=none; b=ZlU6tQANKy179SehAMHcmpAsl4uOz4fryoZXRB+BwErryVVOg903wd+n4Nn0yLaI2MOqO1IeXDqofICB9JMn7uAA8dbTdh+xT38NHV1B42pPC74vuxDx5X29WLKFe5Fq2O96mlpdNruVrehWXOEoFbBHRt2IiZgwzNXAJ2RfHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962373; c=relaxed/simple;
	bh=MkKQdDsYP+tI7FujBY/HKFKDArIAcjnc8c//TsyZKBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcvTMNhOGbmPlfIFRxMt7Tpk6IMjbGpbCgZ4vfKiM7SMMEiHdXKtKeaStcE5Wu3XxoGA+dJ5Gpu9ZVZDbx6bWU1SW3BiKmOElE6ffeey9JwfkYNEdIFFhtR0F2P9CtFS7BXdoE/IdL194Y9D1I+viI7fWa+ZsjEDcPBSrc2Ke0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RsZoBfFS; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ltyj1FS4gis+7LWdtGx1ofBO64mHrGOTJDhLLZcoo1Q=;
	b=RsZoBfFSULMxuDGRzNdZ6yeAHhKdHnDbRwmQ720VL1Q3YexqnLILbCbWeQ5fw2
	DcwQfwwPOgPGAKXk0qK08aCrEBDlYK8cQgLd/2Oizde2Eqx08MMSjY8yPMF5BApb
	WmXpKm1i+c3YGrhWd5SxIVg/lJs1254wbQ88c25dvDAJw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD316EQJ_Zo4qRTAA--.26839S3;
	Mon, 20 Oct 2025 20:12:02 +0800 (CST)
Date: Mon, 20 Oct 2025 20:11:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de,
	Teresa Remmet <t.remmet@phytec.de>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 0/4] Add display overlays for imx8mp-phyboard-pollux
Message-ID: <aPYnD25ljde33_tq@dragon>
References: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
X-CM-TRANSID:Mc8vCgD316EQJ_Zo4qRTAA--.26839S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr15trW3JFy8Gr4fZFyUGFg_yoWxtryxpr
	y3CryUur4S9r1xArnxXwsagrWqyws8Aan5uw13C34kKr43uFyDA3W7Grna9rWUZF4xtw4f
	XF48Ary7Wr1UXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joeHDUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNBKlC2j2JxIThgAA32

On Mon, Oct 13, 2025 at 08:25:05AM +0200, Yannic Moog wrote:
> Yannic Moog (4):
>       arm64: dts: im8mp-phy{board,core}: update license
>       arm64: dts: imx8mp pollux: add display overlays
>       arm64: dts: imx8mp pollux: add expansion board overlay
>       arm64: dts: imx8mp pollux: add displays for expansion board
> 
>  arch/arm64/boot/dts/freescale/Makefile             |  15 ++
>  .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      |  44 +++++
>  ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso |  45 +++++
>  ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso |  45 +++++
>  .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 196 +++++++++++++++++++++
>  .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
>  .../imx8mp-phyboard-pollux-ph128800t006.dtso       |  45 +++++
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  52 ++----
>  .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |   3 +-
>  9 files changed, 411 insertions(+), 43 deletions(-)

Can we do something to avoid the warnings?

../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:102.3-16: Warning (reg_format): /fragment@1/__overlay__/codec@18:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:117.3-16: Warning (reg_format): /fragment@1/__overlay__/eeprom@57:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtbo: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtbo: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtbo: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtbo: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #size-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #size-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:102.3-16: Warning (reg_format): /fragment@1/__overlay__/codec@18:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:117.3-16: Warning (reg_format): /fragment@1/__overlay__/eeprom@57:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #size-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #size-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:102.3-16: Warning (reg_format): /fragment@1/__overlay__/codec@18:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:117.3-16: Warning (reg_format): /fragment@1/__overlay__/eeprom@57:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:100.18-113.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/codec@18: Relying on default #size-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi:115.12-120.4: Warning (avoid_default_addr_size): /fragment@1/__overlay__/eeprom@57: Relying on default #size-cells value

Shawn


