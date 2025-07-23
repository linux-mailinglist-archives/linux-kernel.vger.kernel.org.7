Return-Path: <linux-kernel+bounces-742143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD1B0EDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD561C80164
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A4284B3A;
	Wed, 23 Jul 2025 08:58:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01A277C90
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261119; cv=none; b=pvanZqRV7eVGIiKfSuVymA1cOwMb8KdfIp2kTvF+XfjpLtIAJMljufPur6AfyqhFcR9ElK6wrPDps82NWS5NUgJhxfQ9zFP+2Tw3vHUtrJXzzbEWsH+C/DweURhFgWlYGInlJX4nIhxyVL/z7bJTAP1TA5U/C18Z2UaJqY13/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261119; c=relaxed/simple;
	bh=mWeU+1DOAnqTfJUWnya4OXPc3E5CUg3Td3dpwglJP7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaPtDK9Wwg4RMuvhxd+DEJti/IHCGdfn/WfUXtBHnj8ClAe9POaTv5+WQtJi5bemTBd8b1tvz/feoQl4FtfTKErBd1YCleWH3KdJO5R5rIc4l5AsqGd7r00D5A/xKiHkptUJDzU1z6pBAdl4pwEG0/m6D5/TgyXn5B3gf1e6iLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1ueVJ0-0004xI-JX; Wed, 23 Jul 2025 10:58:30 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Date: Wed, 23 Jul 2025 10:58:30 +0200
Subject: [PATCH 2/2] media: v4l: fwnode: parse horizontal/vertical flip
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-fpf-media-dt-flip-v1-2-75b3a938b4be@pengutronix.de>
References: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
In-Reply-To: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, entwicklung@pengutronix.de, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There are cameras containing a mirror on their optical path e. g. when
mounted upside down.

Introduce two options to change the device's flip property via device tree.

As there is already support for the panel-common driver [1], add it for cameras as well.

[1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")

Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 3 +++
 include/media/v4l2-fwnode.h           | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index cb153ce42c45d..7fd0936fbda80 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -845,6 +845,9 @@ int v4l2_fwnode_device_parse(struct device *dev,
 		dev_dbg(dev, "device rotation: %u\n", val);
 	}
 
+	props->hflip = fwnode_property_read_bool(fwnode, "flip-horizontal");
+	props->vflip = fwnode_property_read_bool(fwnode, "flip-vertical");
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index f7c57c7765898..f8a51ab8317ae 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -75,10 +75,14 @@ enum v4l2_fwnode_orientation {
  * struct v4l2_fwnode_device_properties - fwnode device properties
  * @orientation: device orientation. See &enum v4l2_fwnode_orientation
  * @rotation: device rotation
+ * @hflip: device horizontal flip
+ * @vflip: device vertical flip
  */
 struct v4l2_fwnode_device_properties {
 	enum v4l2_fwnode_orientation orientation;
 	unsigned int rotation;
+	bool hflip;
+	bool vflip;
 };
 
 /**

-- 
2.39.5


