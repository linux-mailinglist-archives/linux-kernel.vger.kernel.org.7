Return-Path: <linux-kernel+bounces-896570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4135C50B34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2899A34A3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912252DC32B;
	Wed, 12 Nov 2025 06:27:13 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4252D5A14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928833; cv=none; b=UQF2SAwYu2DnSh6pKpidbNT6mS/hpAW4/kuw4vjS0Rvht5QmVNDR/R1ho4zu8jibU7y92GPr2IQ6SlB0z7VJPjayuSAP36gYYyK2YG2XlGRsFUDtzkUqFmdpPZwMpH8L+2Psi9pndR8QfAvRD2Be7ztRL4Op0gb4I/xCBC3wTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928833; c=relaxed/simple;
	bh=q0x9863NyZPznVGgtSlgo5WmBVe+9hU1zEgg1WnKurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcrPOgowEBXm6Lr2nxYKXjCnti1ubwM0y9WS4KvTpWWzn8gVEUi61iB/Bi890/wwwx3s6+I11STaNDXoKpxCoyLjkMFNLohmvsgO5Vt5hrs5NdxRkCBW2B6wnislRIkB0Ma4O+QDMUnWUwQLJO4aLhFt7gRe254H5472E/kh6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAHoM+uKBRpZD1wAA--.849S2;
	Wed, 12 Nov 2025 14:26:55 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: vkoul@kernel.org,
	kishon@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] phy: hisilicon: Fix OF node reference leak
Date: Wed, 12 Nov 2025 14:22:46 +0800
Message-ID: <20251112062246.852-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHoM+uKBRpZD1wAA--.849S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryfJFW3tF18JFykArW5Wrg_yoW8Xr47pF
	4YkFWakF4UW3yF9F40vF1UWFyY9an8Ca43A34Ikw4FvFnYyryDXayUXFy0v3ZIyFWkZFWU
	KFWUtF1UJF4UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUILvNUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREEA2kUFx1CbgAAsE

hi3670_pcie_get_resources_from_pcie() leaks an OF node reference
obtained by of_get_child_by_name(). The reference is not released
on any of the error paths or on successful return, causing a
reference count leak.

Fix this by declaring the device node with the __free(device_node)
cleanup construct to ensure the reference is automatically released.

Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index dbc7dcce682b..fc4f50aa31cd 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -558,11 +558,10 @@ static int hi3670_pcie_noc_power(struct hi3670_pcie_phy *phy, bool enable)
 
 static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 {
-	struct device_node *pcie_port;
 	struct device *dev = phy->dev;
 	struct device *pcie_dev;
-
-	pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
+	struct device_node *pcie_port __free(device_node) =
+		of_get_child_by_name(dev->parent->of_node, "pcie");
 	if (!pcie_port) {
 		dev_err(dev, "no pcie node found in %s\n",
 			dev->parent->of_node->full_name);
-- 
2.50.1.windows.1


