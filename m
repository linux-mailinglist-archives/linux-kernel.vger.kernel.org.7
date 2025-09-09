Return-Path: <linux-kernel+bounces-808639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE58B502AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DF21C65129
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE14352FCB;
	Tue,  9 Sep 2025 16:31:23 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32759350D61;
	Tue,  9 Sep 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435483; cv=none; b=YxSDCvsiyQ1tP+SvcOPA6dR+UlI2/lksf9IRBvbSkYWvkjVoPdNaQ/Umm5UH6ofbwDaPcShhB1aYsN39kQhtd5iZV8oSAnr9mGz2cr31nGSsbU/4V3i/nRLDf+cedsQ3NbwgwypyxUulzFLXrnQ0joet3bZrllHpjpPJx00gp3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435483; c=relaxed/simple;
	bh=TCDnKd9DCiMLEbSdfqNQKUb6fm7P/YatrEwFLvPXHhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YB4gn2F7YmQ3FXA4l+BVxdyT1/TQv4yIgeReJ49k6DHJwkCxctNgwix443c54EdtSpmDo0Y0kvFgvFbPCd+uqwl9Rz5nMfO0UU0WUvvzdVRoAChjYTTt8VKR3H8C04Xc+qrsDAzXHQ/92h6IdOGslPnv5S9CKHQR9cygmRQfT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (10)
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id BDE451BC2C3;
	Tue, 09 Sep 2025 18:31:10 +0200 (CEST)
From: Mateusz Koza <mateusz.koza@grinn-global.com>
To: angelogioacchino.delregno@collabora.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com,
	b.bilas@grinn-global.com,
	mateusz.koza@grinn-global.com,
	andrew@lunn.ch
Subject: [PATCH v5 0/4] Add support for Grinn GenioSBC-510/700 boards
Date: Tue,  9 Sep 2025 18:30:46 +0200
Message-ID: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.47
X-NA-AI-Is-Spam: no

This patch series adds support for Grinn GenioSBC-510 and GenioSBC-700
boards based on MediaTek MT8370 and MT8390 SoCs, respectively. It
includes device tree files for both boards, updates to the device tree
bindings, and necessary modifications to the Makefile.

As far as I know, <angelogioacchino.delregno@collabora.com> has access
to the schematics for these boards, as we've shared them under NDA with
Collabora.

Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
---
v2:	Fixed the subject prefixes,
	Fixed alignment in dts files,
	Added missing SPDX-License-Identifier,
	Fixed the ordering in dt-bindings,
	Dropped redundant info from commit messages,
	Run checkpatch.pl on the patchset and fixed the issues,
	as suggested by Krzysztof Kozlowski <krzk@kernel.org>.

v3:	Changed eth phy-mode to 'rgmii-id',
	Changed eth mediatek,tx-delay-ps to 30,
	as suggested by Andrew Lunn <andrew@lunn.ch>.

v4:	Removed the nodes that are not present in upstream,
	as suggested by Louis-Alexis <angelogioacchino.delregno@collabora.com>.

	Added default pinctrl to ssusb0,
	Enabled the scp_cluster node,
	as suggested by Bartosz Biłas <b.bilas@grinn-global.com>.

v5:	Did NOT move the chasis-type - Error: Properties must precede subnodes,
	Swapped underscores to commas in regulator names,
	Reordered properties (generic -> vendor -> status),
	Dropped the firmware property from the scp_c0 node,
	Added interrupts-extended to the pmic node,
	Dropped the mt6359key handle,
	Added blank spaces before the memory nodes,
	as suggested by AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
---

Bartosz Bilas (1):
  arm64: dts: mediatek: mt8370-grinn-genio-510-sbc: Add Grinn
    GenioSBC-510

Mateusz Koza (3):
  arm64: dts: mediatek: mt8390-genio-700-evk: Add Grinn GenioSBC-700
  dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
  dt-bindings: arm: mediatek: Add grinn,genio-510-sbc

 .../devicetree/bindings/arm/mediatek.yaml     |   2 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8370-grinn-genio-510-sbc.dts   |  20 +
 .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  20 +
 .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 538 ++++++++++++++++++
 .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 210 +++++++
 6 files changed, 792 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi

-- 
2.43.0


