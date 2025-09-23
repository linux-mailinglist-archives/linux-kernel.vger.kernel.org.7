Return-Path: <linux-kernel+bounces-828402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8DAB948C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A03C18A2B76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB830F922;
	Tue, 23 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRLpyUmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282D30F549
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608599; cv=none; b=OwHGZgOshTQOQoPZY/0dOy2aZw/5ksZTD6JwAXzATf4PO3+kwM/FgoivlzmvOV7Z4eTcsNieq1rkN/nYzM3seG/Cgkhn83gjKxZZoGXs3D2spBv//DCsBmx3x/LKIxtKvW6moBcZLAODodXoXFFh12NddFE3LQzbtBVvru1sUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608599; c=relaxed/simple;
	bh=3T0yczr8TB2m6N5nAkwbEWrdKvje7HKixCcAVKSkNIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJRcSIeJYTtWFri8QXE9ZnAcPiYsCrh8ZdCGWXqMtGyyV9IUWCwKfdLDaDbSsXF6sQSifflZWbd5Xn0dXSQrFHUH2z3CMV11nsE19EOEEk7/k85HRv04IPCXwRa1WWgF1outRSzsnfW8ftLKSAauQ0uU03caNSX9mo6hnB8jgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRLpyUmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2122C4CEF7;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758608599;
	bh=3T0yczr8TB2m6N5nAkwbEWrdKvje7HKixCcAVKSkNIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SRLpyUmJfbFEdJQu2EdCKiIaSKV5WaYmnmHgGHXkZDEfoGLx+mlo4GGTCfxMVOhHk
	 XwvlmlLx13lcxeUacbSklXVhwGrS8J9XNJ6i+YcRXMJkWJAYsfDKFR8n3E3lwa5BTp
	 1dJCYzs5O9DAr9udNycHCswGrhPETXDgmzAk2G4GEbja5mXK1CsO8z1SHwoNVXeYdk
	 BMvWFTR9Mo3kwiVHsvoQdR9Kmh82n6IEWBF91IC9EhAGc2phQm+DanuPMnSINo7axR
	 qL5ZyJx/ugBQWyfV22JpZCh/ji9lPjT69q+7RUpui+36QYM6IWP4seC/4i8c+RqwtO
	 4IvFs2oNOxkNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2572CAC5B1;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 23 Sep 2025 14:23:42 +0800
Subject: [PATCH v4 2/4] drm/bridge: it6505: add INT status check while link
 auto training
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-fix-link-training-v4-2-7c18f5d3891e@ite.com.tw>
References: <20250923-fix-link-training-v4-0-7c18f5d3891e@ite.com.tw>
In-Reply-To: <20250923-fix-link-training-v4-0-7c18f5d3891e@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758608643; l=4260;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=rwRZdmFdmrU1FhWpEwDA7kOBSoYE4/nfSqSQTPeMCi0=;
 b=poEtWQy7mhu+Z/LCibk4wk/XwpT46+hYyVohtyt7gXykgRDGyxHCH7RoU8Uf6WtyHklIdvt5K
 F6fC4MKcmWcD+4Zn/NZR567H3L+Qq4Zyn0kYTfI+213JaVCue4FDU6L
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When start link training, interrupt status INT_LINK_TRAIN_FAIL can use to
check link training fail and no need to wait until timeout.

it6505_irq_link_train_fail() remove from interrupt and no longer used.

IT6505 HW auto link training which will write DPCD and check training
status automatically.

In the case that driver set link rate at 2.7G and HW fail to training,
it will change link configuration and try 1.65G. And this will cause
INT_VID_FIFO_ERROR triggered when link clock is changed.

When video error occurs, video logic is reset and link training restart,
this will cause endless auto link training.

when start  link auto training, disable INT_VID_FIFO_ERROR to avoid loop
and check INT_LINK_TRAIN_FAIL event to abort wait training done.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 38 ++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index b47042dc06bb1e1dfd92bc0dc6d69dc918a140ba..f9b99c70789eea6beb3c6513155c9a4ca103d219 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -821,8 +821,8 @@ static void it6505_int_mask_enable(struct it6505 *it6505)
 	it6505_write(it6505, INT_MASK_02, BIT(INT_AUX_CMD_FAIL) |
 		     BIT(INT_HDCP_KSV_CHECK) | BIT(INT_AUDIO_FIFO_ERROR));
 
-	it6505_write(it6505, INT_MASK_03, BIT(INT_LINK_TRAIN_FAIL) |
-		     BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LATCH_FIFO_OVERFLOW));
+	it6505_write(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR) |
+		     BIT(INT_IO_LATCH_FIFO_OVERFLOW));
 }
 
 static void it6505_int_mask_disable(struct it6505 *it6505)
@@ -1802,8 +1802,17 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 {
 	int timeout = 500, link_training_state;
 	bool state = false;
+	int int03;
+	struct device *dev = it6505->dev;
 
 	mutex_lock(&it6505->aux_lock);
+
+	/* Disable FIFO error interrupt trigger  */
+	/* to prevent training fail loop issue   */
+	it6505_set_bits(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR), 0);
+
+	it6505_write(it6505, INT_STATUS_03,
+		     BIT(INT_LINK_TRAIN_FAIL) | BIT(INT_VID_FIFO_ERROR));
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
 			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
 	/* reset link state machine and re start training*/
@@ -1814,6 +1823,19 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 	while (timeout > 0) {
 		usleep_range(1000, 2000);
 		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
+		int03 = it6505_read(it6505, INT_STATUS_03);
+		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
+			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
+			it6505_write(it6505, INT_STATUS_03,
+				     BIT(INT_LINK_TRAIN_FAIL) |
+				     BIT(INT_VID_FIFO_ERROR));
+
+			DRM_DEV_DEBUG_DRIVER(dev,
+					     "INT_LINK_TRAIN_FAIL(%x)!",
+					      int03);
+
+			break;
+		}
 
 		if (link_training_state > 0 &&
 		    (link_training_state & LINK_STATE_NORP)) {
@@ -1824,6 +1846,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 		timeout--;
 	}
 unlock:
+	/* recover interrupt trigger*/
+	it6505_set_bits(it6505, INT_MASK_03,
+			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
 	mutex_unlock(&it6505->aux_lock);
 
 	return state;
@@ -2693,14 +2718,6 @@ static void it6505_irq_audio_fifo_error(struct it6505 *it6505)
 		it6505_enable_audio(it6505);
 }
 
-static void it6505_irq_link_train_fail(struct it6505 *it6505)
-{
-	struct device *dev = it6505->dev;
-
-	DRM_DEV_DEBUG_DRIVER(dev, "link training fail interrupt");
-	schedule_work(&it6505->link_works);
-}
-
 static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
 {
 	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
@@ -2765,7 +2782,6 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 		{ BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
 		{ BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
 		{ BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error },
-		{ BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
 	};
 	int int_status[3], i;
 

-- 
2.34.1



