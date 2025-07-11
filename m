Return-Path: <linux-kernel+bounces-726896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8454B01281
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C70A584D16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188901B4138;
	Fri, 11 Jul 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MmjP3W0v"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144319ABAC;
	Fri, 11 Jul 2025 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210300; cv=none; b=pVWUNMakrzmPiLybOPMtzu7ADzM4w5lO6lWdDnb9GPWx81NWay+An0oDzbmffAuLIghyh2MNxupv0dX24pgEmtxphoy14ZPCQuYuOom8AtqBXKvkJ6+U3G/4w0OUw5hjWCAn3QjKd46SgBWv97ZW/KwCQd5F5vxy94C2RAd08TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210300; c=relaxed/simple;
	bh=N7Gjd6TwWK3AWWdF1Z0TC4zxYBFJpLCT8tDqTCrPPW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdEmVuXxnrBUMi3/opNVuxKHi6fXZc+/IRpuMmcnkFmYEWHBf+qzrW6PmxV6IeTs/f5bAez7PVUxczu/3E2WEOxe238Z79hnauPNPR8MbaNTqftVJQo1b8VgHnbJQebrpAMtVzKm38z2br3toCnDZwxxX/c4wilBsx1cBTH4KNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MmjP3W0v; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B54sMM1345709;
	Fri, 11 Jul 2025 00:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752210294;
	bh=8Prv1+3e5hktoUSKslC/ScBA0UeUoQ2zCsspHwXxeyY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MmjP3W0v73nyLODneBFVfkseFUuwh8CH1IR8ff37iAkHOU6Wcz3upyJN3hpmDkaGS
	 UUaUgWnprpvrulmCryPwNFaVLqR0Kjukb8pP1G8N73R3r3lkkuaKtHlo04i1uG6CDd
	 h1fiZ2dFdkHoWDQvR0It+EWBd9CJ5RDcK2TbqFwg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B54smq4178199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 00:04:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:04:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:04:53 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B54ndi2876482;
	Fri, 11 Jul 2025 00:04:50 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Neha Malcom Francis <n-francis@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 0/2] Add support for K3 BIST
Date: Fri, 11 Jul 2025 10:34:35 +0530
Message-ID: <175205725858.918402.3771835070085533874.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605063506.2005637-1-n-francis@ti.com>
References: <20250605063506.2005637-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Neha Malcom Francis,

On Thu, 05 Jun 2025 12:05:04 +0530, Neha Malcom Francis wrote:
> BIST (Built-In Self Test) is an IP responsible for triggering hardware
> circuitry tests on both logic as well as memory blocks. This driver is
> currently being upstreamed in U-Boot [1] (on hold till the dt-binding
> is approved here) and triggers these tests on cores. This patch series
> adds the dt-binding as well as a node for BIST on J784S4 and J742S2.
> 
> Changes since v3:
> https://lore.kernel.org/all/20250514072056.639346-1-n-francis@ti.com/
> - Udit
> 	- add support for J742S2
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: soc: ti: bist: Add BIST for K3 devices
      commit: 04ee170b69749851c74666079ac8f64dba52a2f1
[2/2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add PBIST_14 node
      commit: 387727d7e5d9c2499aafbd04e22c9d39e8eec4c5

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


