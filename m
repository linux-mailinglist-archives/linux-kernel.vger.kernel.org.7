Return-Path: <linux-kernel+bounces-797768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE166B41526
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C24173F18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC772D5934;
	Wed,  3 Sep 2025 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E9G3saOg"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DFF33991;
	Wed,  3 Sep 2025 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880733; cv=none; b=HlFgN9/ZIPL7eV451ZXdMwPckDRRUK43MjjE2QRK5/59Q1gSofJxW7dEu+qFhxmM0CYsk2SuNWGcpRjhsT4bZ92bEYLkTmVRMzGfitIXYKpK9B9Qf7kykP4bocNJRvgguAiP+DEZYyyj25eUPyCKMyTf136eHJtqeLwcICJHwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880733; c=relaxed/simple;
	bh=i6LCcIRSvAuT7iUlLN37HnrnlPGfEuzO4Rr9CeIQdxE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fudbuVFEReTJP0vUna88d+qIuISOQB5+AISU/jN/W2gNU49onEph3MSHxsbEKkx5lE4XzmKDx+AiHTI0SkOUmzf2bEjGCn1yt3lndXh1AE5qlNm6HRQX3BNaxrgJDl7VPt20AfXp68EAFUrXDKn1VznKYx7hyTiaZMoA2aF+4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E9G3saOg; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5836PIXg2766070;
	Wed, 3 Sep 2025 01:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756880718;
	bh=FLLuPDMDoXGdW5biy5c1UWsZe2pTqclSdI7bjGJ1gJE=;
	h=From:To:CC:Subject:Date;
	b=E9G3saOgStPL2LW0i9/Yi8ddwJffVLrFjeBARLv4RpcEn9bo+JQ6JIF04rM90xAyy
	 00Uv83g6zMhyJ/cPc/mtHPYtR2yEBKEaRlJRg9nD2sTeev/Y5jpM+JCv3VmMlPHLMR
	 WPk4nRCtSpXVLsdUBg8l3huJJIACZFo+VCSQirhA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5836PIJj4066360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 01:25:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 01:25:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 01:25:18 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5836PH7d829213;
	Wed, 3 Sep 2025 01:25:17 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/2] Add USB support for AM62D2
Date: Wed, 3 Sep 2025 11:55:11 +0530
Message-ID: <20250903062513.813925-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series introduces following changes:

* Patch 1 fixes the main pad length in main_pmx/padconfig for AM62D
 and AM62A. This also fixes "i2c 0-003f: deferred probe pending".

* Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
 tree nodes.

Change Log:

	v2->v3:
		- Update commit description for first patch.

	v1->v2:
		- Added fixes and Cc tag for Patch 1.
		- Dropped two patches for OPP (applied).

v2-https://lore.kernel.org/all/20250823032304.1085775-1-p-bhagat@ti.com/
v1-https://lore.kernel.org/all/20250820083331.3412378-1-p-bhagat@ti.com/

Boot Logs-
https://gist.github.com/paresh-bhagat12/e29d33c3fd92ff17580edf1441ece9f9

Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
Schematics Link-https://www.ti.com/lit/zip/sprcal5

Paresh Bhagat (1):
  arm64: dts: ti: k3-am62d2-evm: Enable USB support

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62a-main: Fix main padcfg length

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts  | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.34.1


