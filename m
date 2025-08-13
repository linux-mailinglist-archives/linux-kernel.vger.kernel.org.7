Return-Path: <linux-kernel+bounces-766870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC1B24C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F099A0129
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C692FABFE;
	Wed, 13 Aug 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yiSwiktx"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7382BAF4;
	Wed, 13 Aug 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095624; cv=none; b=HYRxH2fPr7Mo9RWLvRbq/wkaODzAS0jPUss56vyLWqmbJ4p2RtzZpQpt8x+PHaEs19BOBdq5SOu47m+O6h/H3VjL3E6328k03EdGkVo/FGFUjHuHx9L24orIelS+cm0JHwgPKT56tQ5xkDGfxQU3lVmqnUYGOV2US1RzUdUe+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095624; c=relaxed/simple;
	bh=qJmXiFL7v1a6UM6K51XwqWRh2Z1J23PwiutgQ6s5CWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsRvbo+/7La6Dev1t+1Ibwho6Fq1UA4KguflIsFIGyypG8+22P1JyVH4qOs5HsA4Q3nhTHhYl5RlemglT8N7EJxkCHJ/4mymmvHEedjzYA9dlBLCT6lxnF/MwrmY2srUp8RX9p+BXrRAbIo3mwbKYuljOasl0P0IbTfexH8i+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yiSwiktx; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DEXZAD2167127;
	Wed, 13 Aug 2025 09:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755095615;
	bh=KGklE0oOttbbG4y1Ct8hcFq72Z83Cf2egeNakYpGEpU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yiSwiktxZpo5H+GfDyZ335qN6fWOBGcfymhpcRnL3lQGjRg5VUc32VVQTGNdCTrIg
	 O3chRC5xpbMuPY0v//t1OBH83MJofwkSkdUkodUtxnifBXgY++ZPiHcN1HsMJtCq4t
	 ScYU0v9lu/jtyd/UE4BhxTmjU7DWZ6DAZKJCu52k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DEXZG1456604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:33:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:33:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:33:35 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DEXZ2C2441722;
	Wed, 13 Aug 2025 09:33:35 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
CC: Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH V2 0/7] Add Interrupts property for CDNS CSI2RX
Date: Wed, 13 Aug 2025 09:33:33 -0500
Message-ID: <175509558118.158553.18446597481463221079.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250808095804.544298-1-y-abhilashchandra@ti.com>
References: <20250808095804.544298-1-y-abhilashchandra@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Yemike Abhilash Chandra,

On Fri, 08 Aug 2025 15:27:57 +0530, Yemike Abhilash Chandra wrote:
> The driver patch that adds support for error detection on the
> Cadence CSI2RX by enabling its interrupt lines was recently
> picked up [0].
> 
> Accordingly, this patch adds the required interrupts property
> to the Cadence CSI2RX device tree nodes.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].

I did minor edits for the $subject to indicate it is CSI2.

Thank you!

[1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts property
      commit: 94801d4bf1ed9277462ebe1afaf8323664fd6a85
[2/7] arm64: dts: ti: k3-j721e-main: Add interrupts property
      commit: 33b34bfa4f22216845f5fd738d320e78d75cf1ff
[3/7] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
      commit: 84ba1f67c6169e4533aa109888accbbccef25705
[4/7] arm64: dts: ti: k3-am62p-j722s-common-main: Add interrupts property
      commit: 347866a21ff447e868305426c294395b2cee68a7
[5/7] arm64: dts: ti: k3-j722s-main: Add interrupts property
      commit: 772cc597174486b85585ed02a74cc332ba25de01
[6/7] arm64: dts: ti: k3-am62-main: Add interrupts property
      commit: 96ba5ce55ec192ca28446d4045dfd501270769b3
[7/7] arm64: dts: ti: k3-am62a-main: Add interrupts property
      commit: 9307cad31efcfe3446847ee34effaaa5c4930fa8

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


