Return-Path: <linux-kernel+bounces-600156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7EA85C82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F631B83FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028529C32B;
	Fri, 11 Apr 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/yQARb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93629B23F;
	Fri, 11 Apr 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373379; cv=none; b=B9DrU0X3KWDt6Tl5kzWM7CAmR80XiSw0YxEtIFWUqVS7IJTpnDgadNfKhHFuh0Wr8VNxV4/cnkojWou/iaNBN2NRHaROcIsKpLyUlqsiVTvWRnyl9dX5fS3K9MWOM20tCFfE6M7PmRWaju7iS6PA1tZnjOGbcMJcfHdxkqT0kD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373379; c=relaxed/simple;
	bh=jeRL00Mqbx5WUbMpBpZN8+Z+cX2QUo+j5ig7bppnlKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7bPHiX4UuaouYfff3q1G7JkUsqrYdiA+sbNWPgQCYeKvCpn0gYj2tkioQ2M+A8hNd7FeZGrhb5B6n/wz8FnWz/Fb41q7lDdX8hHDmdQV8mCcd/1Z5RgCpv8DtjN1fEISeTUU5tatFOFWM3CEnPcZrZVBMoVdyrmbm+G32mBTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/yQARb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A6C4CEE2;
	Fri, 11 Apr 2025 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373378;
	bh=jeRL00Mqbx5WUbMpBpZN8+Z+cX2QUo+j5ig7bppnlKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm/yQARb0pPip08Q2lPuH5Sf0+9ACYeb0ee66Z7fWHExKsQrwZ3VK7VBEfXybJYGX
	 JD8gJhEOfyrm08tpQ29h273MsUaH9sHvPtBu0fDgxxhE+e+H8RIQn3cnmpgKy5ORnQ
	 LYvx7fMBHBr+cBAffVfNDPM7Ic3rviWfTkbC6cU8IkAeNeM13bvpPAhdbO1VmIxblv
	 4bjDUxy2FHsprEgvaIbasvwmH6MEcJQOuXofvBxqO+u9bOhAPS+cfRtV4PdS6wPQ18
	 IoVxNHo/rfGBe37ZFMP5BampC5KIOElWcjNFUkGiF3Gl/0hN2HGcONVgfBM5zhCzlQ
	 zDDkIUb/PsIjQ==
From: Michael Walle <mwalle@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER
Date: Fri, 11 Apr 2025 14:09:15 +0200
Message-Id: <20250411120915.3864437-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411120915.3864437-1-mwalle@kernel.org>
References: <20250411120915.3864437-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address() might fetch the MAC address from NVMEM and that
driver might not have been loaded. In that case, -EPROBE_DEFER is
returned. Right now, this will trigger an immediate fallback to
am65_cpsw_am654_get_efuse_macid() possibly resulting in a random MAC
address although the MAC address is stored in the referenced NVMEM.

Fix it by handling the -EPROBE_DEFER return code correctly. This also
means that the creation of the MDIO device has to be moved to a later
stage as -EPROBE_DEFER must not be returned after child devices are
created.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index af7d0f761597..0bf877e180bd 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2679,7 +2679,9 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 			goto of_node_put;
 
 		ret = of_get_mac_address(port_np, port->slave.mac_addr);
-		if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			goto of_node_put;
+		} else if (ret) {
 			am65_cpsw_am654_get_efuse_macid(port_np,
 							port->port_id,
 							port->slave.mac_addr);
@@ -3551,6 +3553,16 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	am65_cpsw_nuss_get_ver(common);
+
+	ret = am65_cpsw_nuss_init_host_p(common);
+	if (ret)
+		goto err_pm_clear;
+
+	ret = am65_cpsw_nuss_init_slave_ports(common);
+	if (ret)
+		goto err_pm_clear;
+
 	node = of_get_child_by_name(dev->of_node, "mdio");
 	if (!node) {
 		dev_warn(dev, "MDIO node not found\n");
@@ -3567,16 +3579,6 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	}
 	of_node_put(node);
 
-	am65_cpsw_nuss_get_ver(common);
-
-	ret = am65_cpsw_nuss_init_host_p(common);
-	if (ret)
-		goto err_of_clear;
-
-	ret = am65_cpsw_nuss_init_slave_ports(common);
-	if (ret)
-		goto err_of_clear;
-
 	/* init common data */
 	ale_params.dev = dev;
 	ale_params.ale_ageout = AM65_CPSW_ALE_AGEOUT_DEFAULT;
-- 
2.39.5


