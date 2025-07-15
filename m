Return-Path: <linux-kernel+bounces-731209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB69B050F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D60A560FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480D2D3A93;
	Tue, 15 Jul 2025 05:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xSs59wSt"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325552D3752;
	Tue, 15 Jul 2025 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557311; cv=none; b=FHxSDuOeLhDsJUieeHC5YhUju7nIr0rhDkLIL9b1Twy5mlFy2UCxgKoVuGcIo8s4gZavp8lSW4K0FurMCVw2LJz/GbBWe0qYWMsxXo/H8XESTvj0aI5xbIYXhCU+b7bqeQIrELQ1t8/ManCo3eQQWFjYztM/t4p4XosqpiBCfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557311; c=relaxed/simple;
	bh=P7pNd1eGtuAtZ9eFCFF6GrGWAGTSvg+Vd1jtr6YfosI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsUl5q5QUITIWuEGdKfRwUbihSVpLPXy1GwHueZ8r+6ksgF6CLTGXAZlEfmnNJAXKpDrTX3AmkGOp1QVNMMzrIW9n9R7dja47S/EaYYH53etgzDtuhbQx78eoCd6SbR5OS1ei3IENm7kHboZW4X2Iqar13F6LOwOSfEgLnMF20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xSs59wSt; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F5SEdI2771457;
	Tue, 15 Jul 2025 00:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752557295;
	bh=T+iQ6+zl2doArTLPWFq6p1O+ATbiiOq7k6rpexGFLxA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xSs59wStlzbddKFe07sDuzXgU8QhBrEVv8tFuLo/TojdayeTKHfTTPjff1AkKOqCe
	 5dbeLfwf/03jbPfI+mE3lZv/MB6iUikmNEDRz51ND7S3ILsa6273JRzX+3dxYxCSDR
	 d4oLtsyagWCQNvPQELg8EaIyUw/FX+MGS3QcSX5g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F5SE412480803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 00:28:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 00:28:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 00:28:14 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F5S8Ll2035754;
	Tue, 15 Jul 2025 00:28:09 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <praneeth@ti.com>, Paresh Bhagat <p-bhagat@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <devarsht@ti.com>, <s-vadapalli@ti.com>,
        <andrew@lunn.ch>
Subject: Re: [PATCH v7 0/4] Add support for AM62D2 SoC and EVM
Date: Tue, 15 Jul 2025 10:57:52 +0530
Message-ID: <175240652598.4073742.4266830155737293290.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708085839.1498505-1-p-bhagat@ti.com>
References: <20250708085839.1498505-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paresh Bhagat,

On Tue, 08 Jul 2025 14:28:35 +0530, Paresh Bhagat wrote:
> This patch series adds support for the AM62D SoC and its evaluation
> module (EVM) board, enable eMMC and firmware-name update for
> AM62D2-EVM board.
> 
> The AM62D SoC is a high-performance Digital Signal Processing (DSP)
> device with a quad-core Cortex-A53 cluster, dual Cortex-R5F cores,
> and a Cx7 DSP core with Matrix Multiplication Accelerator (MMA).
> It features a range of peripherals, including multichannel audio
> serial ports, Ethernet, UARTs, SPI, I2C, USB, and more.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: Add bootph property to nodes at source for am62a
      commit: 1704b0462220beabda1ddb4b386e1295defa39fd
[2/4] dt-bindings: arm: ti: Add AM62D2 SoC and Boards
      commit: 6f4b2a487352fa775bea4393d2455d334ccc97d4
[3/4] arm64: dts: ti: Add pinctrl entries for AM62D2 family of SoCs
      commit: 106f43ab41fa968c5ce3920e281870b99a519b13
[4/4] arm64: dts: ti: Add support for AM62D2-EVM
      commit: 1544bca2f188e47256b61ae5e24ea93a292bb559

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


