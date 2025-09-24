Return-Path: <linux-kernel+bounces-830280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CDB9948C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E464A1C86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32F2DA75A;
	Wed, 24 Sep 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arturia.com header.i=@arturia.com header.b="fxf5vF90"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00826CE0C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707960; cv=none; b=d0gbdnX1q4UrF54bdMUaFmi9N8b3GAJ3Ac00hO6N14Bw3tdhW0w/RTbhhOpwUwQpneNgUKU6LO24BsKVkQAi//kL/Mxl/NPkcgab3YAggxroEq99D97f3Jk/JG/BwB43AhpigQnnvLTu5P381MijQQxn0pJh0fTuPqxbJKfLAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707960; c=relaxed/simple;
	bh=jEwKVuZ8XeiBUFCwaXQPQ6MyH6BY6hB3fT87aLJHnuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcRmNOJt2hRz4JgREdY7zj5QqWK0rrYgigHfXlNjA/D8rgngPSrSPer5exS1ap2rhlh4Npvy1I8D+CNYqulseSfhI1jThe1jMp0ZVAF8sCH5d4Am3o9qFG5O/UA1whB8vMu9lBmyd/lAkJJqLYyxzuGzEzteIt7oNL6BWTCFPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arturia.com; spf=pass smtp.mailfrom=arturia.com; dkim=pass (2048-bit key) header.d=arturia.com header.i=@arturia.com header.b=fxf5vF90; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arturia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arturia.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so41208955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arturia.com; s=arturia; t=1758707953; x=1759312753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ym6707fq3Z/7taO/DrO5zucHsh4hcfX3oAy1NAejIM0=;
        b=fxf5vF90a1Ns9D5Ob0wTqKLkBD7GcyzVjV7NzAUYtaSd6BHOXIzeA9icFb+pB7abhK
         n9/e3zIaXBxrYlu3Ij9Ka4sJbiIjeZ0xc1Q7Z75JviJanKLU+VDXUuFMfz1DboA9jWIV
         NQG+gFBn2Maahkrx9CzpQlLpmaCozE/5BMG21z8PAH0ZQjWxjBTKlGfzLD68LZp5NUR8
         PsBgkP3OYgNVmv9nQk0c7ei2MvSyl0M4c4G7FRSxaTjNWkbMfggETXv3iHJHmoGAZWlK
         BqmJmyCT7Ymi0OJA+P9JjpP6lbzEp9luzbW9iA+PkZQVUaItpaltMIEpa1Bu9f6KaiRc
         rakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707953; x=1759312753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym6707fq3Z/7taO/DrO5zucHsh4hcfX3oAy1NAejIM0=;
        b=opa9ZS2Ab8zTewit4dPkdW2yNwQkS/2XzUh4A9tORHWGaf6uEbPXulphKq/11LAX5+
         5Q2+NKiTicF6czXn95XY8dSOVcITmsOkUeL2ScH25fp2QZKDizxWpwLiBvoHQbbqW+tv
         O9NBelASvrCGIwWC7YHIim0BRidKJ2R4wNBsIV5ciSxbbP47dl116QxpBnGVHjo3+Tlx
         0hW7QRfGMWwPAErAlWNB7Re9OGarUwu20lrh2tBsB27ArD6kL7ah81htaxqA9YmapuOZ
         bxb5I/Hg3LP8k69f4rBOfUlWhu5vnWHqNSd7jdNSyLyN14KRqmsVYa7mHjBH6weKnkpA
         AeVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHE+QSRnP+KLeoP2jD/mtxuy8wTPs+ATUMfj30gbZen/AvlJG0c2uZkI9sbMUp7g/52vqbS1pDYqx/BzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLeI1Uh4ToQ8WDEwYj41H3kLIIagqSBMU7DXZmDHXhQJBTrum
	SVg1UJwEnM2tyeKe3P3bPstxHHadQBhDCt9y/UHcYxMJD5kjfYCnpruvz9zxO5l75+k=
X-Gm-Gg: ASbGncvFpixaIxv0MUYX4Us9xThKlDq9ykCpgnQAnKVdniuXncM5bmnYRf/zkWqEpRC
	kCL1t3g5VZjC7lwTmerjQADx7QqGyiKGE+gb+EREm2JwK+mTrs83xzMZ7c74/1uH6HLKgYVRxQ4
	3dBjeLIDoHiPurxgLVtvz6L41Vre3TPxYqVAAZi5D+zcpzT5+AvA9NLMRv7wGiRahg6QWu+u6lg
	fSghpRkAeHCtyBH5m/KiiIcDhUUvc47DZdBCn4VPRWVoYj9cl953yJh6WeYokyn52C/yORAQKx7
	nCfqz6y9thAzDy7D+og6NuMxomM2NAA/hoxSEvhYiiGnv/sTz7v8ee937IlD+XRytMcR+RwUU0j
	Bl3p0xqHnrkDrwrwNsB1/pYI8Zg752aDGFEnoDivhZZlfOxJ/XpayQD1maE4=
X-Google-Smtp-Source: AGHT+IFw5ahu2jMrj2SZGLBmkUIeignINv/sQ0n0/PFoOuc9PlHmih4l5xsXSwxJhrQBfLFkFpSDyg==
X-Received: by 2002:a05:600c:1d20:b0:46d:9d28:fb78 with SMTP id 5b1f17b1804b1-46e1d9953cemr72776175e9.8.1758707952623;
        Wed, 24 Sep 2025 02:59:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb15:854c:e000:4c2c:f6a2:3825:3b1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9be58bsm25633335e9.12.2025.09.24.02.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:59:12 -0700 (PDT)
From: Victor Krawiec <victor.krawiec@arturia.com>
To: heiko@sntech.de,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Victor Krawiec <victor.krawiec@arturia.com>
Subject: [PATCH] phy: rockchip-inno-usb2: fix otg state machine when in USB-C DFP mode
Date: Wed, 24 Sep 2025 11:56:45 +0200
Message-ID: <20250924095644.79259-2-victor.krawiec@arturia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rockchip-inno-usb2 phy driver, we use a state machine called
'otg_sm_work' to dynamically manage power consumption for phy otg-port.
This state machine relies on EXTCON_USB_HOST state to manage host role.
The EXTCON_USB_HOST state is set depending on the OTG ID pin

On a device that does role switching with a USB-C connector (for example
using a fusb302 detection chip) the ID pin does not exists. Therefore the
EXTCON_USB_HOST state is never set. When in DFP mode this causes the state
machine to go in the DCP state instead of going in the A_HOST state. The
end result for the user is that the system does not enumerate connected
FS/HS devices.

This patch adds a 'set_mode' callback that allows the phy driver to be
notified when the role changes. The state machine can now check if the
device is in DFP state and do work accordingly"

Signed-off-by: Victor Krawiec <victor.krawiec@arturia.com>
---
This patch has been made by analyzing RK3399 TRM and Rockchip's vendor
tree which is based on a 6.6 Android kernel. The patch feels a bit like
hacking the state machine by bypassing the EXTCON_USB_HOST. I'm new to USB
driver development so it is very likely that I missed something. Please
see this patch as opening a new topic rather than as a clever solution.

Instead of using a boolean 'data_role_dfp' in the 'set_role' callback I
tried using 'extcon_set_state_sync' to set EXTCON_USB_HOST state.
Unfortunately since the drivers subscribes to the event it triggers two
concurrent executions of the state machine which makes the code very hard
to follow (see schema below)

Lastly the patch only works when using the same sequence as Rockchip's
vendor tree to put the phy in charger detection mode. This sequence is 
provided as a comment in their tree:
/* Set the PHY in charger detection mode.
 * The conditions for charger detection:
 * 1. Set the PHY in normal mode to keep the UTMI_CLK on.
 * 2. Set the utmi_opmode in non-driving mode.
 * 3. Set the utmi_xcvrselect to FS speed.
 * 4. Set the utmi_termselect to FS speed.
 * 5. Enable the DP/DM pulldown resistor.
 */
Thus the change in RK3399 registers.

bvalid_irq
    |
    |
otg_sm_work
    |            set_mode
    |               |
    |               |
    |        EXTCON_USB_HOST
    |               |
    |               |
    |       rockchip_otg_event
    |               |
    |               |
    |          otg_sm_work
    |               |
    |               |

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec30..e8d99f67086e 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -26,6 +26,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 
 #define BIT_WRITEABLE_SHIFT	16
 #define SCHEDULE_DELAY		(60 * HZ)
@@ -190,6 +191,7 @@ struct rockchip_usb2phy_cfg {
  * @suspended: phy suspended flag.
  * @vbus_attached: otg device vbus status.
  * @host_disconnect: usb host disconnect status.
+ * @data_role_dfp: dual role dfp/ufp status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @id_irq: IRQ number assigned for ID pin detection.
  * @ls_irq: IRQ number assigned for linestate detection.
@@ -210,6 +212,7 @@ struct rockchip_usb2phy_port {
 	bool		suspended;
 	bool		vbus_attached;
 	bool            host_disconnect;
+	bool		data_role_dfp;
 	int		bvalid_irq;
 	int		id_irq;
 	int		ls_irq;
@@ -648,11 +651,37 @@ static int rockchip_usb2phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int rockchip_usb2phy_set_mode(struct phy *phy,
+				     enum phy_mode mode, int submode)
+{
+	struct rockchip_usb2phy_port *rport = phy_get_drvdata(phy);
+
+	dev_dbg(&rport->phy->dev, "%s: mode=%d\n", __func__, (int)mode);
+
+	if (rport->port_id != USB2PHY_PORT_OTG)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		rport->data_role_dfp = false;
+		break;
+	case PHY_MODE_USB_HOST:
+		rport->data_role_dfp = true;
+		break;
+	default:
+		dev_info(&rport->phy->dev, "illegal mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct phy_ops rockchip_usb2phy_ops = {
 	.init		= rockchip_usb2phy_init,
 	.exit		= rockchip_usb2phy_exit,
 	.power_on	= rockchip_usb2phy_power_on,
 	.power_off	= rockchip_usb2phy_power_off,
+	.set_mode	= rockchip_usb2phy_set_mode,
 	.owner		= THIS_MODULE,
 };
 
@@ -682,9 +711,12 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			rockchip_usb2phy_power_off(rport->phy);
 		fallthrough;
 	case OTG_STATE_B_IDLE:
-		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0) {
+		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0 ||
+			rport->data_role_dfp) {
 			dev_dbg(&rport->phy->dev, "usb otg host connect\n");
 			rport->state = OTG_STATE_A_HOST;
+			rphy->chg_state = USB_CHG_STATE_UNDEFINED;
+			rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
 			rockchip_usb2phy_power_on(rport->phy);
 			return;
 		} else if (vbus_attach) {
@@ -729,6 +761,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 			notify_charger = true;
 			rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 			rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
+			rockchip_usb2phy_power_off(rport->phy);
 		}
 
 		if (rport->vbus_attached != vbus_attach) {
@@ -759,7 +792,7 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) == 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host disconnect\n");
 			rport->state = OTG_STATE_B_IDLE;
-			rockchip_usb2phy_power_off(rport->phy);
+			sch_work = true;
 		}
 		break;
 	default:
@@ -1294,6 +1327,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	 */
 	rport->suspended = true;
 	rport->vbus_attached = false;
+	rport->data_role_dfp = false;
 
 	mutex_init(&rport->mutex);
 
@@ -1878,7 +1912,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 			}
 		},
 		.chg_det = {
-			.opmode		= { 0xe454, 3, 0, 5, 1 },
+			.opmode		= { 0xe454, 8, 0, 0, 0x1d7 },
 			.cp_det		= { 0xe2ac, 2, 2, 0, 1 },
 			.dcp_det	= { 0xe2ac, 1, 1, 0, 1 },
 			.dp_det		= { 0xe2ac, 0, 0, 0, 1 },

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.43.0


