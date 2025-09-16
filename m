Return-Path: <linux-kernel+bounces-818125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521DEB58CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6759321803
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBD323E35E;
	Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peU/3QfE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBA21770A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998064; cv=none; b=OR53bwYIX/8s9eJUR12K6O0dNAjoXiMv7QyXrBPrORFiShMwRVRSSj7F+iuJWU30gS0mY2OKLlTcyJGJexm9yW9aWrb9OFD2Wpjzd+BtGKzDXNDW9Lmog1QLwx+UeH4PgkK/Xh/YpZ/W3J02mfuDOropN9X8T1q4riDSda7LTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998064; c=relaxed/simple;
	bh=y9xM5x/9mDBXXIijOs8N9ZcgaLGefpK4A6S03ho3yEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4DFH5oyUV5FzzvqGgtbgH1FYGozM333FUtEjkE1SmhdExzzI5XJlWpawbih65KjIb/03C3ONxYMWmA+xwQYlNO7n+wehmBgMYWO65Z99NQgWP2FPVweGOjzSuQOT4a8CefSnODYTYGFCAMWTYfti0CYrga5Lz0J/k+Uh6Y8e8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peU/3QfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FB4C4CEFC;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998063;
	bh=y9xM5x/9mDBXXIijOs8N9ZcgaLGefpK4A6S03ho3yEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=peU/3QfEOma4QuTKDgqjflnMzRuHPg5l9jOG5qVjxlA2HU6fe7EJMDU1TsIjJFWJS
	 Vd85rpd/RdZH2oF0AQxiuzmOIn+EuALwP/pA+tF4GymbnA2DBZ4p/QlzuNenHizTJr
	 Dgs/JuhLwFLypfesxSPt8A/NZffInPAO6KRx8aMp0qBgmz0UAgWi7ifgRiDK9YkxU5
	 LqQajQZKC6hzgrtlayxFU3KK1VkDWFRSOxhGksa/itUEf/cU+LvtMVJ7sNpIWnc2z9
	 En1p+mqws/PxvTk+fj8GhzehOTyYitg1Y6HUe2u33lwKG9TKmfMWJD4UYocqF44Wg3
	 PiNDsxmWQmamA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4BCAC59E;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 16 Sep 2025 12:47:43 +0800
Subject: [PATCH RESEND v3 3/5] drm/bridge: it6505: modify DP link auto
 training
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-fix-link-training-v3-3-0f55bfdb272a@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998107; l=2426;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=w0mjd1b/vD9l754Z7HEk7/mi9+TqCrQ9as279Ea9bf8=;
 b=IO78MXtKw2LNi4+s8tj6sHGMURIF+yDdF7Kq8Xfe2p+lN6zAV80lQHrkBUlWaC/cDhdEkEomZ
 CRWoEaKbz+tAMASNTGDAmXuM794aJOBhgpLmeN0213Uduk+FTrY2j9u
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

IT6505 supports HW link training which will write DPCD and check
training status automatically.

In the case that driver set link rate at 2.7G and HW fail to training,
it will change link configuration and try 1.65G. And this will cause
INT_VID_FIFO_ERROR triggered when link clock is changed.

When video error occurs, video logic is reset and link training restart,
this will cause endless auto link training.

Modify link auto training with disable INT_VID_FIFO_ERROR to avoid loop
and check INT_LINK_TRAIN_FAIL event to abort wait training done.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7f6227c278a51358c70a3de93454aafeef64f2bb..f9b99c70789eea6beb3c6513155c9a4ca103d219 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1806,6 +1806,13 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 	struct device *dev = it6505->dev;
 
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
@@ -1818,8 +1825,10 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
 		int03 = it6505_read(it6505, INT_STATUS_03);
 		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
+			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
 			it6505_write(it6505, INT_STATUS_03,
-				     BIT(INT_LINK_TRAIN_FAIL));
+				     BIT(INT_LINK_TRAIN_FAIL) |
+				     BIT(INT_VID_FIFO_ERROR));
 
 			DRM_DEV_DEBUG_DRIVER(dev,
 					     "INT_LINK_TRAIN_FAIL(%x)!",
@@ -1837,6 +1846,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 		timeout--;
 	}
 unlock:
+	/* recover interrupt trigger*/
+	it6505_set_bits(it6505, INT_MASK_03,
+			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
 	mutex_unlock(&it6505->aux_lock);
 
 	return state;

-- 
2.34.1



