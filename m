Return-Path: <linux-kernel+bounces-818124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42434B58CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757D4522664
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F723F421;
	Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2/PYgmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3C2135B8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998064; cv=none; b=YbVH6UKPDzCGotGRsizqvemYA5fScYERHVBsA6Pqt+BtBHyuoPQjZuBRGLJuROJBsxg74z0pCuDwIZRJ6UEbDA+9rnDsW8Un6k7NZYrQbER44jF7sHYwhVT2zfMXAECLSYCL531i4eVOvApDvT70Jp+E8SWnNWwbsAxsGYIcBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998064; c=relaxed/simple;
	bh=Sv32eWrLlAonnSTDakaOBa/sXD+tsT+ZOUml/oxxLoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gumJBiPRsy5BzmU8+rU0R3UbJq3/Tvo/OA/aSpQ2gm3ym/oC7b271FLXRZ5J1PmPZmcAZN9636gav/rBuHAzP1eYoTfZW5X4HN47PYhlPZD65Tj+JiIeA1v0HKMC/e3YiG4wRTFwNsDQE5MkQIZSBSYC4X3I3uZlr+7etmBQaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2/PYgmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD821C4CEFA;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998063;
	bh=Sv32eWrLlAonnSTDakaOBa/sXD+tsT+ZOUml/oxxLoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p2/PYgmoLWgpsGDdmwnzMt+vIocnncSEBJoOS7zy0Xm3lRCTSR6DOZSY/RJ0KiyKb
	 k7VbVNfS/pta8Qpwq/x6N3Qo8pMeWovULdpRF9+khpDOJ2aHlIZk57uQA4M7Y6cb9B
	 ejJR72oe47seF616hZd+WDzBhLpoICtbtZsI4M+dQ1AGyrqd0UxcaAp4nA3uI2pOJv
	 TVyuzOLOSccJ93BV6/p8jTelIDXTBpig79nN3Hv3jGRHzxPRlLSpLx7pOAAC7FzmL1
	 QleM4YrDogS1Om/teHRoj4HPN3ZxDMAeD10R04ZHReJPlLnJaFKBVvtyLwyqc5lNr1
	 sVczqKrEBec9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE51DCAC59B;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 16 Sep 2025 12:47:42 +0800
Subject: [PATCH RESEND v3 2/5] drm/bridge: it6505: check
 INT_LINK_TRAIN_FAIL while link auto training
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-fix-link-training-v3-2-0f55bfdb272a@ite.com.tw>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
In-Reply-To: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998107; l=2919;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=jMRBMAfZXvgPInoi2ZG2fBNx0MmsnJGVHvslLR/IkmI=;
 b=T9SmPE4rzwxkt7minVSirH2lNbREqXWJrFQAl1Rn6bq7YENYu6/UwsQdADRcRUZKdOVxSHi1o
 TWYfM6uA304Cj0nsS7HjhchJ1B5+V+Lzk8LJbU10lNvTor2h3z6mdXE
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When start link training, interrupt status INT_LINK_TRAIN_FAIL can
use to check link training fail and no need to wait until timeout.

it6505_irq_link_train_fail() remove from interrupt and no longer used.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index b47042dc06bb1e1dfd92bc0dc6d69dc918a140ba..7f6227c278a51358c70a3de93454aafeef64f2bb 100644
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
@@ -1802,6 +1802,8 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 {
 	int timeout = 500, link_training_state;
 	bool state = false;
+	int int03;
+	struct device *dev = it6505->dev;
 
 	mutex_lock(&it6505->aux_lock);
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
@@ -1814,6 +1816,17 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 	while (timeout > 0) {
 		usleep_range(1000, 2000);
 		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
+		int03 = it6505_read(it6505, INT_STATUS_03);
+		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
+			it6505_write(it6505, INT_STATUS_03,
+				     BIT(INT_LINK_TRAIN_FAIL));
+
+			DRM_DEV_DEBUG_DRIVER(dev,
+					     "INT_LINK_TRAIN_FAIL(%x)!",
+					      int03);
+
+			break;
+		}
 
 		if (link_training_state > 0 &&
 		    (link_training_state & LINK_STATE_NORP)) {
@@ -2693,14 +2706,6 @@ static void it6505_irq_audio_fifo_error(struct it6505 *it6505)
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
@@ -2765,7 +2770,6 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 		{ BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
 		{ BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
 		{ BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error },
-		{ BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
 	};
 	int int_status[3], i;
 

-- 
2.34.1



