Return-Path: <linux-kernel+bounces-818126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD3B58CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3825224D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA75323E354;
	Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+mmapbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1A21B9DB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998064; cv=none; b=kR2ER4IRZqnH3QXbdq4LQm5yB8KtPEoEeGwY2T7D/tYkb8KCDgFvg2UGhbHx+KKKQUnL5xKDoGcFq6uPlUX1g7t16491KtpeEPzXanqVBWeY2ZhZDHQpd+thFAd/dQWoODOQdnjbpNRHu01JIvhE7RBWF8KcThXW+Uwij5emV+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998064; c=relaxed/simple;
	bh=zEgF7zl+qaVDn5TiUTBaHD0fanWnAVJNnO4sgNc2+7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAM2nMNvUBgtcTpRlo3ow7LsqKpvPBrJhFokdymGfztB4grnMELXmltyEFEIca5ZR713+sdPs8Htze7DJI7+bJgzuby/H7lS28uaQFZ+/Gbnuf9735FOvmGqVo2etH1xa+37YVx7yYLGTxpTpJZcn6UR9hYbRV+UHq/Mc3y8lIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+mmapbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFE75C4CEF7;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998063;
	bh=zEgF7zl+qaVDn5TiUTBaHD0fanWnAVJNnO4sgNc2+7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h+mmapbNiV0c6avSZsCWxHHzQglVJcd8Un5UG9q1kIXggnsYq+CpA0c7q4WrXy6CY
	 +EKjnXdn9Q525Fgu/vpPXAWQHeQvbQSV5uFN5+rp6hfebTlCVCMowjXGno43FYRTZE
	 6r4lTSSfMTMm6AfIHkNWG0B0jNwXuYjdgq6N8ydRN3UWQTT+3+9wlxppBbnQ5vjXs9
	 JFAeuxWSUSyjXRGVJ44D8AMhcZI17HB5kUOE50pNgai3fDdLyRuqbtc0zzKJYW+gYL
	 qNzFnd2Cf8nLkKE6zTjU9mtH0wKRzmbXYkuGKDsWrgoncQHqMQDVGmaQ7Q5s2CFSF8
	 hG6Q4+7IHYx1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0CCAC592;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 16 Sep 2025 12:47:41 +0800
Subject: [PATCH RESEND v3 1/5] drm/bridge: it6505: fix link training state
 HW register reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-fix-link-training-v3-1-0f55bfdb272a@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998107; l=1768;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=L0iJ7cK8igir/+LkaX0VG1u/Z4JkZspdyQ1kUW040to=;
 b=qiDOEQ6FjWuN8gXvTTOIszAJR4zUYvTqBqa/Xyxjd2g2r8MStb5O8B50VGA64jiyuABeZpYil
 /XJvzLR8TFyD/Db5cwHhe4L/F2nmvnRyMYmyvf1R6aODzv8Wk0xX88P
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When connect to a DP-to-HDMI device which does not connect
to HDMI sink, it will report DPCD 00200h with SINK_COUNT = "0",
and issue HPD_IRQ when SINK_COUNT change to "1".

IT6505 can not recive HPD_IRQ before training done and driver will
force HW enter training done state when connect to such devices.

When HW is force to training done state and restart link training,
bits FORCE_RETRAIN and MANUAL_TRAIN at REG_TRAIN_CTRL1 must be set
at the same time to reset HW state.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 88ef76a37fe6accacdd343839ff2569b31b18ceb..b47042dc06bb1e1dfd92bc0dc6d69dc918a140ba 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1806,7 +1806,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 	mutex_lock(&it6505->aux_lock);
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
 			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
-	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
+	/* reset link state machine and re start training*/
+	it6505_write(it6505, REG_TRAIN_CTRL1,
+		     FORCE_RETRAIN | MANUAL_TRAIN);
 	it6505_write(it6505, REG_TRAIN_CTRL1, AUTO_TRAIN);
 
 	while (timeout > 0) {
@@ -2377,7 +2379,7 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 {
 	it6505->link_state = LINK_IDLE;
 	cancel_work_sync(&it6505->link_works);
-	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
+	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN | MANUAL_TRAIN);
 }
 
 static void it6505_link_train_ok(struct it6505 *it6505)

-- 
2.34.1



