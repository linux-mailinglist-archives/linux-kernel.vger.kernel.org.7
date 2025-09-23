Return-Path: <linux-kernel+bounces-828399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36F1B948C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51DB3A6C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034CD30F80A;
	Tue, 23 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQo/YsiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225A30F546
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608599; cv=none; b=LWQT4T2Bn4OImk91BeAfWy0oCO1UG0mcoc3I+olCppOq+yKx7nUq+WW/c9PwvSw0ruTDZb4+4vKIcageqhQpPMuANWFxns8X7fzdqRTxApRdGwF5X6h+HMM5B3iCRJkrrySGPSvHLtn8RsErjHRvnIdb9Lb/4Jw6UB1c8ZGzs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608599; c=relaxed/simple;
	bh=2Phu2egmghoPfL6y1RTRkWn4vN4ATsYrUz9yWVyMvvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM2FxX++Cb/3Z5oqkFeVBw0+ELrBh9N4nmY9bT1KbY97dAq6ZVZEnVWayVEE4Ed7dRJOF8C4ml1RV0rElCVNinlNF3rgYXhEd3W0fXRZCteWmAv7pU1FGCGxdv7vTR3LhX5sKEM0H0wdn/ymxGmi8guk2pxqMSql8oTRgJkkzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQo/YsiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3D18C116B1;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758608599;
	bh=2Phu2egmghoPfL6y1RTRkWn4vN4ATsYrUz9yWVyMvvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cQo/YsiWa2tejcSwS7Zz45gLFdTuk/1yOJM1PDMTSsUje1cIg3q6JhLx30OUSqYGG
	 rwGMZTUNfP1+dmvcAH1L/dyzJ26HshKP+EEiYeAphYsEt+IhLVSKt9qxFQ16QYZDKK
	 DeGph1SWuhfJ5z6Qp7YgCUY7Ff0ET8y0r+W7F+iv6+1HcHyidryRBkcXDmRTto/XYr
	 dhTuOwkmhvmFmLXLFKi6y4WuVMIIQsdrQJQUjEGVKJe4RfmpSaCSELFwhYrtXYxDXR
	 93wyK0KPO9dKpjqS//9wiF9tszNky+GXNP/aBB2z560/E8R6+n+JXE0jgMyzPXvM7M
	 tJK0RS4/PVjlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A4CAC5A5;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 23 Sep 2025 14:23:41 +0800
Subject: [PATCH v4 1/4] drm/bridge: it6505: fix link training state HW
 register reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-fix-link-training-v4-1-7c18f5d3891e@ite.com.tw>
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
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758608643; l=1890;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=qgBUHkzuf4hAHpGTg2Rk6XpngHItzj84KgxjHfNDNYQ=;
 b=8MEYUYtNzt1UrC9NDCNt1Zln0R2+1n3rBKsdQP9iyuRSlQcL7uyzqyrcLP75cbwQ3y60gorEi
 ZNNZjxr6gyLCWsAupEuGiqORx9jEv3sE7XaVc2KrjymOi2BHUpZn5w0
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

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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



