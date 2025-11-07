Return-Path: <linux-kernel+bounces-890286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF1C3FB59
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A62DC34CA19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BA322559;
	Fri,  7 Nov 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="L0zzpVP4"
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CC321420;
	Fri,  7 Nov 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514509; cv=none; b=iP7AaZcGXEMCU4EcWAgIF/Hu1llClagNtTje6/PdYpUuZQatGguvZJiNb2prF1ZMgWvm7h8dlIrCp/t/EhLNwEcUQP6nQoO61Spvf6xFW/wNFYfnlzaJTiLS6dvmGARsZIrWMizHNWJbW6DxygWdxdkkhLXiK37xWmI+HUPWZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514509; c=relaxed/simple;
	bh=cwfXVQLfUYng/XGx9fuht2aqUV3fMBEEk3D8ZI1SS3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHT6yvFBrMBB6XIxgF95btNsGn4W6i1tQRS4T5jx+OxRDnOaaeoZFB99jIWQU2h457fYDZlO/pJpauImZ+5mYZiVsiNRcadbTCXRCKu8qibyMO/fieA3LhMPeXzabKcjNoyDHnM4k5vr0sfYzuaxlG/dgdYGsw/QFtPO/dMEPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=L0zzpVP4; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1762513876;
	bh=Q3oEb6f1YkDfh3C3JNra6qEKnoR5mi2zvj3WcAJ7AnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L0zzpVP4F2DO09o2xtnb1xnjoDDCXP/bVU25NfhXPiSFYh7gac8v6QqokhX0ws7Rn
	 8w9pNWajTUZkTvxYDnPohlOtJNR96N3sQjkmz5J6d1cGmf5a4e1AIy9jj/i2M1A4is
	 hy8ms81vqvlgXkBcY3WDbqtMDx+jXIxk76gGcvZU6xIE5Sdm0CK80q25pJMDOV+1k9
	 YOM4nyOBMB/ZmK1kQRXdd03txIPGRUZe5vH0TWzB1itVQtjOqgyWU4MK/H8txZD/xg
	 Wx8c6zlhKgma+NHDV1jlTH1ycAXTKIkNjO9SYsOJ5VnNe8HswNP5Qp1s2/s89ltVCf
	 ixU8NLWdraw5g==
Received: from [192.168.2.54] (unknown [143.105.119.212])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id A6F36B2201EE;
	Fri,  7 Nov 2025 12:11:12 +0100 (CET)
Message-ID: <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
Date: Fri, 7 Nov 2025 03:11:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251107095530.114775-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 01:55, Hal Feng wrote:
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
> 
> Board features:
> - JH7110S SoC
> - 4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
> 
> Changes since v1:
> - Drop patch 1 because it is applied.
> - Rename jh7110.dtsi to jh711x.dtsi.
> - Move the content of jh7110-common.dtsi to the new file
>   jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
> patch 4:
> - Move the uncommon nodes to jh7110-common.dtsi instead of board dts.
> patch 5:
> - Add jh7110s-common.dtsi and include it in jh7110s-starfive-visionfive-2-lite.dtsi.
> 
> Changes since RFC:
> - Add jh7110s compatible to the generic cpufreq driver.
> - Fix the dtbs_check error by adding the missing "enable-gpios" property
>   in jh7110 pcie dt-bindings.
> - Rebase on the latest mainline.
> - Add VisionFive 2 Lite eMMC board device tree and add a common board dtsi
>   for VisionFive 2 Lite variants.
> - Add usb switch pin configuration (GPIO62).
> - Improve the commit messages.
> 
> History:
> v1: https://lore.kernel.org/all/20251016080054.12484-1-hal.feng@starfivetech.com/
> RFC: https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
> 
> Hal Feng (8):
>   dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
>   dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite
>     board
>   riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
>   riscv: dts: starfive: Split jh7110-common.dtsi and move opp table to
>     it
>   riscv: dts: starfive: jh711x-common: Move out some nodes to jh7110
>     common dtsi
>   riscv: dts: starfive: Add common board dtsi for JH7110s and VisionFive
>     2 Lite variants
>   riscv: dts: starfive: Add VisionFive 2 Lite board device tree
>   riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
> 
>  .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
>  .../devicetree/bindings/riscv/starfive.yaml   |   6 +
>  arch/riscv/boot/dts/starfive/Makefile         |   3 +
>  .../boot/dts/starfive/jh7110-common.dtsi      | 653 +----------------
>  .../boot/dts/starfive/jh7110s-common.dtsi     |  27 +
>  ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +
>  .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +
>  .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++
>  .../boot/dts/starfive/jh711x-common.dtsi      | 656 ++++++++++++++++++
>  .../dts/starfive/{jh7110.dtsi => jh711x.dtsi} |  16 -
>  10 files changed, 879 insertions(+), 654 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
>  create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi
>  rename arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} (99%)
> 
> 
> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c

Small nit that "lite-emmc" is confusing together. In patches to U-Boot
dev mailing list the EEPROM product id is demonstrated to be with "SL"
suffix when compared to VisionFive 2 (JH7110) so I suggest avoid
confusion in upstream and use for VisionFive 2 Lite (JH7110S) these
compatible names:

starfive,visionfive-2sl-lite
starfive,visionfive-2sl-emmc

Also filenames:

jh7110s-starfive-visionfive-2sl-lite.dts
jh7110s-starfive-visionfive-2sl.dtsi
jh7110s-starfive-visionfive-2sl-emmc.dts

What do you think?

-E

