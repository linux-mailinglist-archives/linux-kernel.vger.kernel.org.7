Return-Path: <linux-kernel+bounces-777640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23BB2DC20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BD1C23DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A672EB87E;
	Wed, 20 Aug 2025 12:10:29 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D12E7631;
	Wed, 20 Aug 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691829; cv=none; b=gncqtVay6TwkVTuueZyiioOC+jlF086XuxsZfRv1X7WhjhaLGMDuQsw0SmAJ3lNzkDv0ZaGe4RiaQ8SS3vaDtqUlzHx/vxCxUfisVEWosG0coQrgE62YA13oFj8y/uIqqQ3hBo1y9hf6jxQagoo8HdAbUsa+eEvDOqvYiYsbd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691829; c=relaxed/simple;
	bh=YKZ2cgNGCON+qIZE/zvznmLB76rF61sLS4TnX/N1wCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LM8/7mxENwMe6TXg4mMU4rvgXxOW9PGUa2ZGoZohAMdTC5Ghke3PytkJ0rgZgf3rwouXTTpctlmF8NgZi2/yadrNHo7NwnM3RRLVNjosBqV/1cp+7mV8bg7nl1MpKgWKOvgVDHnc0a0jRRZVfC37BsqVH5IId9nKtrvQI3sa1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (16)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id 03E711BDE50;
	Wed, 20 Aug 2025 14:10:21 +0200 (CEST)
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
Subject: [PATCH v3 0/4] Add support for Grinn GenioSBC-510/700 boards
Date: Wed, 20 Aug 2025 14:09:01 +0200
Message-ID: <20250820120905.993189-1-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.52
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
 .../mediatek/mt8370-grinn-genio-510-sbc.dts   |  19 +
 .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  19 +
 .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 674 ++++++++++++++++++
 .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 209 ++++++
 6 files changed, 925 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi

-- 
2.43.0


