Return-Path: <linux-kernel+bounces-751131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65BBB16593
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC221AA42ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23302DECDD;
	Wed, 30 Jul 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mLh+QGl+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8A2DECBF;
	Wed, 30 Jul 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896874; cv=none; b=MV9RwV1WYqqOy/38pz4bRJpYGNw4G4otD3vAmH4pxxXkP5Xh90VZ3CvZIwUc+bdvI8o8gSzP83dNwJKqXnwTp4VZ7MYnNa7LHVviTQYzJ+bNGnDM6BdDIYirupFOA+Wgk4sxmOp5KrtBai0Wt+R/rK2loswLzm8gEm1g0T5RaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896874; c=relaxed/simple;
	bh=bVJAaoH0JuSUNRcQ9w2QzqofFieTylYOqtHj9nm5FRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fETy5htQvHTCUvyVdD5cjnO+CWgP14HU7xsxd9qRFao4RhmWqDDjcKWp7IP5T5VsxMzOSz9PeiR2NHpxIar2afI7tx0tSwkSPvVOMIFrTeKCd7ZTbayQDUYaviARoLzhzMzqEvSdzQHdOgD1qZG629iUzvoZSO5PmIsJL6u3nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mLh+QGl+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=0CsIczNHXvl6MadOAV4Zan8Vnxl/zMq2dEBmkW03FDU=; b=mLh+QGl+oOQhA1UFeVGGptg5hj
	xOwtU14mTje7EorDhLMlKQWoqKgf02h3UcMlETzEQqV17NwRlFFP5ZtK8MzlCxeypp3OjaHZws3Dw
	JSJLbDe1q8Mw+KPvbJhtoF1Sr0AO7HAcANwqobKTAGtwctky9fkpFlxmlKaQ2eJ/K2WPZoSFBj66S
	YRIPJQjYV8nEW2l2GBiEU3es+qkfAn6eGPV+HV01K/VRnZofRBVR8LzWM8n1Qor/Y+0nc4iJPfPzn
	5H9DWAyiUP57Gek+oWqUAo77b3X1ijw59ZrPnJPQziyyNpVzOEFcETt3T01Zh/0w08JuGrr8yPWMB
	W4ptW9ug==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAhC-0001cx-Pf; Wed, 30 Jul 2025 19:34:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: qnap-mcu: add driver data for ts233 variant
Date: Wed, 30 Jul 2025 19:34:23 +0200
Message-ID: <20250730173423.1878599-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730173423.1878599-1-heiko@sntech.de>
References: <20250730173423.1878599-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the TS233 compatible and affiliated driver data to qnap-mcu.
The TS233 is mostly similar to the TS433, except not having any of the
PCIe components, so there are only 2 drives.

The fan pwm-limits from the vendor-configuration also are the same
as for the ts433 variant.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 223156b98b79..6ed020206e55 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -329,6 +329,14 @@ static int qnap_mcu_power_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
+static const struct qnap_mcu_variant qnap_ts233_mcu = {
+	.baud_rate = 115200,
+	.num_drives = 2,
+	.fan_pwm_min = 51,  /* Specified in original model.conf */
+	.fan_pwm_max = 255,
+	.usb_led = true,
+};
+
 static const struct qnap_mcu_variant qnap_ts433_mcu = {
 	.baud_rate = 115200,
 	.num_drives = 4,
@@ -405,6 +413,7 @@ static int qnap_mcu_probe(struct serdev_device *serdev)
 }
 
 static const struct of_device_id qnap_mcu_dt_ids[] = {
+	{ .compatible = "qnap,ts233-mcu", .data = &qnap_ts233_mcu },
 	{ .compatible = "qnap,ts433-mcu", .data = &qnap_ts433_mcu },
 	{ /* sentinel */ }
 };
-- 
2.47.2


