Return-Path: <linux-kernel+bounces-748653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E8B1444B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC67A2196
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4824234984;
	Mon, 28 Jul 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g98zP0yb"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAC2356C0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741121; cv=none; b=Fhp0UXbqlmCuu2WUFSsfrhEwBQpBYoyd8s8g8oyLHcCmvK1sCPYthWveQnks0klzdvsXPMZttMiTKETbWijbHUPVUoXghn8arO31OniXKCqSjJ2ikpAc3BWnLueWRtmUbmsl5sT/dJ19cs7yOxU1YUcRJnXos1PLMNwDxn9lEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741121; c=relaxed/simple;
	bh=PSdCfwvuYNDkLsvpDTX/+fRr02wYzFlfT+kwaFn11do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CoPNzv/XcUUTSavSBVE6X71jx1LVCU7tjOx+hZWONaWN3oTdhi8yivKe1UTnnDwNtX/MkG+u1MJ8TA1dLeMBieJH+c7UVI8+P/dLyQmpdFOssRzaycPtGahWBHrMIbTZACgszDKdPy+JW5Al4hw4kKKcCbiryr5is3CIYVA0Fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g98zP0yb; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753741115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOXG56ON/OYMfwTBNtCeAQzfV8BAU8WbBn8TalhqNho=;
	b=g98zP0ybmtfdWwaqcx7JLqCEF8I8SkTztnMareSSKNVq9gW7o6q9lV03SQjbMSqGvCdApf
	fzfHdcrdWVxqlJ9F6vzoYlki83XqxY/phWzzTQfUflCyWtN/haSb8zHFvne4s+DQ1tGkZO
	Lqo1X3VtExpVhi07p4W+WlDgIhBygjw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 2/7] net: axienet: Use ioread32/iowrite32 directly
Date: Mon, 28 Jul 2025 18:18:18 -0400
Message-Id: <20250728221823.11968-3-sean.anderson@linux.dev>
In-Reply-To: <20250728221823.11968-1-sean.anderson@linux.dev>
References: <20250728221823.11968-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In preparation for splitting the MDIO bus into a separate driver,
convert all register reads/writes to use ioread32/iowrite32 directly
instead of using the axienet_ior/iow helpers. While we're at it, clean
up the register calculations a bit.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 43 +++++++++----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 9ca2643c921e..16f3581390dd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -32,7 +32,7 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	u32 val;
 
-	return readx_poll_timeout(axinet_ior_read_mcr, lp,
+	return readx_poll_timeout(ioread32, lp->regs + XAE_MDIO_MCR_OFFSET,
 				  val, val & XAE_MDIO_MCR_READY_MASK,
 				  1, 20000);
 }
@@ -45,8 +45,8 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
  */
 static void axienet_mdio_mdc_enable(struct axienet_local *lp)
 {
-	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
-		    ((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK));
+	iowrite32((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK,
+		  lp->regs + XAE_MDIO_MC_OFFSET);
 }
 
 /**
@@ -59,9 +59,9 @@ static void axienet_mdio_mdc_disable(struct axienet_local *lp)
 {
 	u32 mc_reg;
 
-	mc_reg = axienet_ior(lp, XAE_MDIO_MC_OFFSET);
-	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
-		    (mc_reg & ~XAE_MDIO_MC_MDIOEN_MASK));
+	mc_reg = ioread32(lp->regs + XAE_MDIO_MC_OFFSET);
+	iowrite32(mc_reg & ~XAE_MDIO_MC_MDIOEN_MASK,
+		  lp->regs + XAE_MDIO_MC_OFFSET);
 }
 
 /**
@@ -90,13 +90,11 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 		return ret;
 	}
 
-	axienet_iow(lp, XAE_MDIO_MCR_OFFSET,
-		    (((phy_id << XAE_MDIO_MCR_PHYAD_SHIFT) &
-		      XAE_MDIO_MCR_PHYAD_MASK) |
-		     ((reg << XAE_MDIO_MCR_REGAD_SHIFT) &
-		      XAE_MDIO_MCR_REGAD_MASK) |
-		     XAE_MDIO_MCR_INITIATE_MASK |
-		     XAE_MDIO_MCR_OP_READ_MASK));
+	rc = FIELD_PREP(XAE_MDIO_MCR_PHYAD_MASK, phy_id) |
+	     FIELD_PREP(XAE_MDIO_MCR_REGAD_MASK, reg) |
+	     XAE_MDIO_MCR_INITIATE_MASK |
+	     XAE_MDIO_MCR_OP_READ_MASK;
+	iowrite32(rc, lp->regs + XAE_MDIO_MCR_OFFSET);
 
 	ret = axienet_mdio_wait_until_ready(lp);
 	if (ret < 0) {
@@ -104,7 +102,7 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 		return ret;
 	}
 
-	rc = axienet_ior(lp, XAE_MDIO_MRD_OFFSET) & 0x0000FFFF;
+	rc = ioread32(lp->regs + XAE_MDIO_MRD_OFFSET) & 0x0000FFFF;
 
 	dev_dbg(lp->dev, "axienet_mdio_read(phy_id=%i, reg=%x) == %x\n",
 		phy_id, reg, rc);
@@ -129,8 +127,9 @@ static int axienet_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 			      u16 val)
 {
-	int ret;
 	struct axienet_local *lp = bus->priv;
+	int ret;
+	u32 mcr;
 
 	dev_dbg(lp->dev, "axienet_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
 		phy_id, reg, val);
@@ -143,14 +142,12 @@ static int axienet_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 		return ret;
 	}
 
-	axienet_iow(lp, XAE_MDIO_MWD_OFFSET, (u32)val);
-	axienet_iow(lp, XAE_MDIO_MCR_OFFSET,
-		    (((phy_id << XAE_MDIO_MCR_PHYAD_SHIFT) &
-		      XAE_MDIO_MCR_PHYAD_MASK) |
-		     ((reg << XAE_MDIO_MCR_REGAD_SHIFT) &
-		      XAE_MDIO_MCR_REGAD_MASK) |
-		     XAE_MDIO_MCR_INITIATE_MASK |
-		     XAE_MDIO_MCR_OP_WRITE_MASK));
+	iowrite32(val, lp->regs + XAE_MDIO_MWD_OFFSET);
+	mcr = FIELD_PREP(XAE_MDIO_MCR_PHYAD_MASK, phy_id) |
+	      FIELD_PREP(XAE_MDIO_MCR_REGAD_MASK, reg) |
+	      XAE_MDIO_MCR_INITIATE_MASK |
+	      XAE_MDIO_MCR_OP_WRITE_MASK;
+	iowrite32(mcr, lp->regs + XAE_MDIO_MCR_OFFSET);
 
 	ret = axienet_mdio_wait_until_ready(lp);
 	if (ret < 0) {
-- 
2.35.1.1320.gc452695387.dirty


