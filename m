Return-Path: <linux-kernel+bounces-799633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C7B42E58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35171BC6DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5B71411DE;
	Thu,  4 Sep 2025 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NqkeGt2F"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785983BBF2;
	Thu,  4 Sep 2025 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946851; cv=none; b=NMVqyirCJHmfRmbntHZw+j2ae7M2yTmuHJ4BBZpHmVSeVx3kxA7jyQSSwB7G8S1pG3oEtWZkS5ecAiAcHrSadGoI/cSqRYVo8uTBuRfD8YbX9BRG+4B7RgkowcT3r1eFHOvt/tGFZTCD1gBRxB0XGbXhblsVplNLL4FDkAe1lwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946851; c=relaxed/simple;
	bh=qvSpe4TUjYTr730NBizaVQAbkgIUwfRSU+ng/VZrur4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sgqUnbJBFR+/n4xfkE+ZcUFf1VuDVZ6r3NIbm4B6ek87L/XcNRZ2xmRzzwQjnPIjOHXhHFP8QD1dMx0RbW0Cgh4Kj2c7nuukHE3l5njkcGFz6RTIH6lt/9qCINRnjlOue0zOHJG8TwnfowukJxgTa6xCtaWX2MkujRiZVvI98kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NqkeGt2F; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5840lONU2954654;
	Wed, 3 Sep 2025 19:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756946844;
	bh=t3YkA8eYz2VV/WwTvgxjsOxH7cEoaIYkMf2TA6+TZ0k=;
	h=From:To:CC:Subject:Date;
	b=NqkeGt2FcG2MYAxjfWL3evN30KyalWRdBrSdxkBdlOidcIe7sO7vSk2xUyGI/8M9h
	 Z7Ttm54aXMcIC5BNAaGq8vun/4s8IoKTJG6tRkci9pi6q3+WirYZtNjedfy7pPDrIk
	 zSx8rOa3TOZYxv57+BFUxyF7vTzRTMmMf4AQtyMU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5840lOF1476630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 19:47:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 19:47:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 19:47:23 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5840lNZJ2425599;
	Wed, 3 Sep 2025 19:47:23 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Move sdhci0 from common & update sdhci0
Date: Wed, 3 Sep 2025 19:47:21 -0500
Message-ID: <20250904004723.2856005-1-jm@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
and is supported for am62p SR1.2 device, remove sdhci0 node from
common-main.dtsi and include instead in each device's main.dtsi
appropriately.

Also, update the tap settings and STRB for am62p eMMC sdhci0 node.

Tested on am62p SK board.

Judith Mendez (2):
  arm64: dts: ti: k3-am62p/j722s: Move sdhci0 from common
  arm64: dts: ti: k3-am62p: Update eMMC tap setting & STRB

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 25 -------------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 22 ++++++++++++++++
 3 files changed, 47 insertions(+), 25 deletions(-)

-- 
2.51.0


