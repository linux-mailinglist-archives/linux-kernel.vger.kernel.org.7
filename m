Return-Path: <linux-kernel+bounces-833722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB3BA2D78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A4962444E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AC287269;
	Fri, 26 Sep 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ooBcemBw"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECD289376
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872438; cv=none; b=e6QiR/OAOImxuLgWADDZSBKkLribz8pl8/a6WXC+JfdKAe76WerCnIe67qreiCU1CVnjAYog27D4R7usE2ZJ7Ur8CCdiIdgN8hRWAcZ8kANgqTaqElFRc4LxwjMnUTKzRMuIClYukRO8C0RxtqH98B/S/H5iRIO9U6HUPobWk/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872438; c=relaxed/simple;
	bh=RMTdSl1EReIsDbu7gTRVqEIhBEgJjesg9JQOWQIRlcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=X5Aj/tVgDvfe3eSZH0Zx9Tej/yzzZMSmjhieBScmXDg3NU9mOri1beGKVYZTkaYHqewrzI33058gKik4NXrkSslOPVRi1AoL71LKVrnrfcgPY2f3E1vXI94xGBCXJpmk83HQCJNBHffYId+9GsKPIU4KTiLKq4Tx1/MO/2Bvdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ooBcemBw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250926074035epoutp03ddf0e04aed08b8cae477792138d93053~oxSkzIFHN1458414584epoutp03M
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:40:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250926074035epoutp03ddf0e04aed08b8cae477792138d93053~oxSkzIFHN1458414584epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758872435;
	bh=Ed+5kxoNWx3Jwxxg6b5MJ/fr9ca6CEUeMaFTMyUKs7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooBcemBwJFZTI1CGR//6gGzFHvHxARnloqJ618aRTs036fyD+m3cJDd/qUy3pU8f8
	 4sUDV8YHBp7HiHXl8HkOYlKMF/G19QNMALGyOWh9pEQf6NDbXmGHgaDoMXgSXgSUqI
	 0aVhLKBHX84JL5wDVY7HLgogx1It5osgyVHQicKw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250926074034epcas2p43be6732f342e5bec135b40966271129b~oxSkPl-K33226632266epcas2p4e;
	Fri, 26 Sep 2025 07:40:34 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.68]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cY2Yt0VLsz6B9mF; Fri, 26 Sep
	2025 07:40:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250926074033epcas2p371d57850f46c9ecb307f3ea8c6d4a57f~oxSi8tEpt1589115891epcas2p3A;
	Fri, 26 Sep 2025 07:40:33 +0000 (GMT)
Received: from asswp146.dsn.sec.samsung.com (unknown [10.229.19.146]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250926074033epsmtip29387fe8aacfb676855f5efede978805c~oxSi3pQiI1189511895epsmtip22;
	Fri, 26 Sep 2025 07:40:33 +0000 (GMT)
From: Sanghoon Bae <sh86.bae@samsung.com>
To: robh@kernel.org, krzk@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	alim.akhtar@samsung.com, kishon@kernel.org, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, shradha.t@samsung.com
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	sh86.bae@samsung.com
Subject: [PATCH 0/4] Add support for ExynosAutov920 PCIe PHY
Date: Fri, 26 Sep 2025 16:39:20 +0900
Message-ID: <20250926073921.1000866-6-sh86.bae@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250926073921.1000866-1-sh86.bae@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250926074033epcas2p371d57850f46c9ecb307f3ea8c6d4a57f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250926074033epcas2p371d57850f46c9ecb307f3ea8c6d4a57f
References: <20250926073921.1000866-1-sh86.bae@samsung.com>
	<CGME20250926074033epcas2p371d57850f46c9ecb307f3ea8c6d4a57f@epcas2p3.samsung.com>

The ExynosAutov920 SoC has two instances of DesignWare-based PCIe PHY IP.
Each PHY has a different lane specification: one is a 4-lane PHY and
the other is a 2-lane PHY.

Each PHY can be used by separate controllers through the bifurcation
option. Therefore, from 2 up to 4 PCIe controllers can be supported
and connected with this PHY driver.

Most of the PHY structure and registers are identical, but some aspects
need to be distinguished. For this, PCIe lane number added for each PHY
properties only in ExynosAutov920.

This patchset includes:
- DT bindings for ExynosAutov920 FSYS0 sysreg
- DT bindings for ExynosAutov920 PCIe PHY
- PCIe PHY properties for ExynosAutov920 in the device tree
- PHY driver for ExynosAutov920 PCIe

Note that this patchset does not enable PCIe0 and PCIe2.
Enabling them requires additional patches for the ExynosAutov920 PCIe
RC driver, which will be applied later.

Please note that these patch set depends on the Shradha Todi's patchset
https://lore.kernel.org/lkml/20250811154638.95732-1-shradha.t@samsung.com/
so need to apply on top of that series, because that adds
the patches to make Exynos PHY common for all.

Sanghoon Bae (4):
  dt-bindings: soc: samsung: exynos-sysreg: add hsi0 for ExynosAutov920
  dt-bindings: phy: Add PCIe PHY support for ExynosAutov920 SoC
  arm64: dts: ExynosAutov920: add PCIe PHY DT nodes
  phy: exynos: Add PCIe PHY support for ExynosAutov920 SoC

 .../bindings/phy/samsung,exynos-pcie-phy.yaml |  14 ++
 .../soc/samsung/samsung,exynos-sysreg.yaml    |   1 +
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |  28 +++
 drivers/phy/samsung/phy-exynos-pcie.c         | 231 ++++++++++++++++++
 4 files changed, 274 insertions(+)

-- 
2.45.2


