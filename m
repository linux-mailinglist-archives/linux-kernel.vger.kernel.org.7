Return-Path: <linux-kernel+bounces-771162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D743BB283B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A35E50F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D7308F3A;
	Fri, 15 Aug 2025 16:18:08 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1519E975;
	Fri, 15 Aug 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274688; cv=none; b=ukaX0hngLnJgQfTBn47QYm50aXKnPFe+IZoEFe21gLuu6oJ1SjEdyzLM1owV7z3ERdeZYBp3APUdtEPsndZ8+qHglmhs5hnIH8UU1c1/6084lFZp7WV/tFNfuoc9MDwOB+HtrNS22y0REFQ3U1B9LeBuKMzEYKFDdaW6QPJJlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274688; c=relaxed/simple;
	bh=xbqTyvSPkEuvDzNX/1t6hcJqItiLiUukHeU+s0WMXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRC9RJH5HDjJ9G80lYL8RywrGDCbF352EKFMaX5/KlmbqHekUGw5IAv/csnMejIelPXYAr/jHNnMkDa78GuKiI1GvNRh30W3wuhcSUJ3SFUDk7R9B403JKugNEWB7ZDiojl1AgJFmflV2Fn8OT4fAKkRl9TNJbKZMd4krSjcjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (8)
X-Spam-Flag: NO
X-Spam-Score: -0.637
X-Spam-Level: 
Received: from mateusz.grinndev.ovh (79.163.192.75.ipv4.supernova.orange.pl [79.163.192.75])
	by server220076.nazwa.pl (Postfix) with ESMTP id 839F81BCF12;
	Fri, 15 Aug 2025 18:10:26 +0200 (CEST)
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
	Mateusz Koza <mateusz.koza@grinn-global.com>
Subject: [PATCH 0/4] Add support for Grinn GenioSBC-510/700 boards
Date: Fri, 15 Aug 2025 18:08:33 +0200
Message-ID: <20250815160837.371592-1-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.50
X-NA-AI-Is-Spam: no

This patch series adds support for Grinn GenioSBC-510 and GenioSBC-700
boards based on MediaTek MT8370 and MT8390 SoCs, respectively. It
includes device tree files for both boards, updates to the device tree
bindings, and necessary modifications to the Makefile.

As far as I know, <angelogioacchino.delregno@collabora.com> has access
to the schematics for these boards, as we've shared them under NDA with
Collabora.

Bartosz Bilas (1):
  arch: dts: mediatek: mt8370: add Grinn GenioSBC-510

Mateusz Koza (3):
  arch: dts: mediatek: mt8390: add Grinn GenioSBC-700
  dt-bindings: arm: mediatek: Add grinn,genio-700-sbc as a valid
    platform
  dt-bindings: arm: mediatek: Add grinn,genio-510-sbc as a valid
    platform

 .../devicetree/bindings/arm/mediatek.yaml     |   2 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8370-grinn-genio-510-sbc.dts   |  19 +
 .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  19 +
 .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 673 ++++++++++++++++++
 .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 208 ++++++
 6 files changed, 923 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi

Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
-- 
2.43.0


