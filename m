Return-Path: <linux-kernel+bounces-763991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972DB21C97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9101A2718B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C32E610E;
	Tue, 12 Aug 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AXqzg9ag"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E22E6104
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974956; cv=none; b=PTApxNo5ljig1r8XH+kPNt4Z/7fCWP+1xT/RGfD44g0j26vxf/QM7v36Wc1HJubpJxQ74r2yeCe3htvn/Tg/QnMk5a0whqKPWSnXvXHcgRON8N1f7KW4G2CR5jKMd4qsOjsjuiORF489OBgAxL8OjQCaLVYdTGFr8eaUl6j4lj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974956; c=relaxed/simple;
	bh=DT1/peMJWRxOgPB4lUdF5idJuEMlr3CS1NJxp9SHq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=aNK6WeRebh31VU16iX+8j/2lBNxdBEtYjDxvVKLf6TMauhuuc0hcKdlS1l/crki1ZJOkvf7NojtzQMjLqgGSdJeYUxWTCCCu8WLYjpOfOWOKsQpdstkjzqMlqHAr1eodNQILbRZtRSabtx85VwtFrz8EZ4DyYCufGEez/Dk5WF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AXqzg9ag; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250812050231epoutp034f4d26e1a5623c40c014d83b462b5459~a7GujqVs80120501205epoutp03C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:02:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250812050231epoutp034f4d26e1a5623c40c014d83b462b5459~a7GujqVs80120501205epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974951;
	bh=MXLXIKo5So0tlOM8gotPp2y8u1WnPDpM5g1HMlGA5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXqzg9agqJixcJnCCjrQQW+tGXqqtQ2ImmtGivH0NOErQXd/jrrVwQ6nL1ZXkVIWF
	 PNCqmyvCP0+gxRAnVqNXrJeZijhehuIhN1FT4xRukbYqCZxT1dtkbc3GjBD90lFf80
	 7u8GbbLRH4+ncNIX9lmhlp7lE/os3vAb2rPNGds8=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250812050231epcas5p405b227c36b47aabd0fdea22919c782e0~a7GuCrd8Z0756607566epcas5p4c;
	Tue, 12 Aug 2025 05:02:31 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c1KBG117sz6B9mK; Tue, 12 Aug
	2025 05:02:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154734epcas5p1ed075fa71285a5c34c2d319bb01c98ac~awQofsCJE2229822298epcas5p1a;
	Mon, 11 Aug 2025 15:47:34 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154731epsmtip1b68ba070909f98d7886552b4f46faa74~awQl4H6BS2596225962epsmtip1H;
	Mon, 11 Aug 2025 15:47:31 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 09/12] phy: exynos: Add platform device private data
Date: Mon, 11 Aug 2025 21:16:35 +0530
Message-ID: <20250811154638.95732-10-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154734epcas5p1ed075fa71285a5c34c2d319bb01c98ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154734epcas5p1ed075fa71285a5c34c2d319bb01c98ac
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154734epcas5p1ed075fa71285a5c34c2d319bb01c98ac@epcas5p1.samsung.com>

Currently, the exynos PCIe PHY driver supports only single
phy ops making it unusable for other platforms. Add the phy_ops
as platform specific device data so as to extend this driver
to support all platforms using Samsung PHY.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/phy/samsung/phy-exynos-pcie.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 53c9230c2907..022222a0212a 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -136,6 +136,7 @@ static const struct phy_ops exynos5433_phy_ops = {
 static const struct of_device_id exynos_pcie_phy_match[] = {
 	{
 		.compatible = "samsung,exynos5433-pcie-phy",
+		.data = &exynos5433_phy_ops,
 	},
 	{},
 };
@@ -146,6 +147,11 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 	struct exynos_pcie_phy *exynos_phy;
 	struct phy *generic_phy;
 	struct phy_provider *phy_provider;
+	const struct phy_ops *drv_data;
+
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
 
 	exynos_phy = devm_kzalloc(dev, sizeof(*exynos_phy), GFP_KERNEL);
 	if (!exynos_phy)
@@ -169,7 +175,7 @@ static int exynos_pcie_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(exynos_phy->fsysreg);
 	}
 
-	generic_phy = devm_phy_create(dev, dev->of_node, &exynos5433_phy_ops);
+	generic_phy = devm_phy_create(dev, dev->of_node, drv_data);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create PHY\n");
 		return PTR_ERR(generic_phy);
-- 
2.49.0


