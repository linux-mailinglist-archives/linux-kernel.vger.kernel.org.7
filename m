Return-Path: <linux-kernel+bounces-828403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2361B948CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A1C18A2C71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C17F30F924;
	Tue, 23 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eysGKJ+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289E30F54A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608599; cv=none; b=ZkJWJ4xNfBoG7a0iFU3TW7hgI8o1Avcu3ofbRjGDpYbKt6bWsD/u1UoFCC9kEk1xcWwAjpHkWect2rIihdBH4RD5uCQrQtEY3klqsSvbNmz4itSZs1GDjFs6hBObeMaYV/DRbkZM1neiwM4xCDXmgP2UXReavB7GlEBfCKzBKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608599; c=relaxed/simple;
	bh=xyeGddU8HV7f9Dpf8HpwJptt9/1K5HGt8xU0CjdPxEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glsIUsEFUWqg41/AOe+a9yJXFbVVyrFuvnIjHBGg9VOivOYX7YDkEHgWmOGN1I7U87RTySxXbCZq/bDVuWMjT/CovG9lz/Wx0VgAAZyFjpZ57vwo/vAOYMpBJDhSrNZku1CAbg6YhrU+rXUHBR+QkM8Wnq2rmYdb28L5n6epSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eysGKJ+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07BBBC16AAE;
	Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758608599;
	bh=xyeGddU8HV7f9Dpf8HpwJptt9/1K5HGt8xU0CjdPxEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eysGKJ+Dif31eN5di0SzH+oLsEtzZB/QToH+b1p1N87ZED7fAfyLbIfXxSOLi/6Uk
	 dx/222siDfJKNgZFpSX5Pj+E02qQrIlLcjuGMWU2e2khysL5N/YVn6Uce1sEwGylAf
	 NJWXlgrZUd/3KHmS+fTN0wvBtaevF9AdpIbn51GP55Pm8YXwY0gEBjlg7dZd+9FJ0E
	 KGk4dlU6pmhghtIiclJAStLoTZG/koBAN+AyO+tXTcNOpQGH3WkpHMvkS+ilOW+woO
	 KB+L8TTJq/n9l07qonwMavHWfP/rRISP43HcS6+33G+2TVOcgn0VBrMvW0vn4I/9Rz
	 DtCFHfw8ucXmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155ACAC5A7;
	Tue, 23 Sep 2025 06:23:18 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 23 Sep 2025 14:23:43 +0800
Subject: [PATCH v4 3/4] drm/bridge: it6505: modify DP link training work
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-fix-link-training-v4-3-7c18f5d3891e@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758608643; l=4440;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=aNgX8ku/g4Npw+XBkXl6a6rbjnMD1KIDhBrcFoowf7Q=;
 b=6iVQ3WRxt+eduB8Aurtfy0iGusCK+mvOmhDQaMiHl/MtO2YAKGgPSj8I1Xfrg0QQIRtYvRosp
 WeeGBqdS13uAbsu1YcQsIhxQNFvqz072WTmbo1PAspPMggcV5L+6+e3
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The DP link training work start with auto training and after auto
training failed "AUTO_TRAIN_RETRY" times, it switch to step training
mode.

It will more efficiency that finish link tranining without re-schedule
train work when each training fail.

Drop auto_train_retry from it6505 structure, and it6505_dump() is remove
from link trainig work, it takes too much time to read all register area,
and is not necessary.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 40 ++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f9b99c70789eea6beb3c6513155c9a4ca103d219..bff5f18fb5ae7192242308f034b60af9807c192c 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -467,7 +467,6 @@ struct it6505 {
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
 	struct completion extcon_completion;
-	u8 auto_train_retry;
 	bool hdcp_desired;
 	bool is_repeater;
 	u8 hdcp_down_stream_count;
@@ -666,7 +665,7 @@ static int it6505_get_dpcd(struct it6505 *it6505, int offset, u8 *dpcd, int num)
 	return 0;
 }
 
-static void it6505_dump(struct it6505 *it6505)
+static void __maybe_unused it6505_dump(struct it6505 *it6505)
 {
 	unsigned int i, j;
 	u8 regs[16];
@@ -1399,7 +1398,6 @@ static void it6505_variable_config(struct it6505 *it6505)
 	it6505->lane_count = MAX_LANE_COUNT;
 	it6505->link_state = LINK_IDLE;
 	it6505->hdcp_desired = HDCP_DESIRED;
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 	it6505->audio.select = AUDIO_SELECT;
 	it6505->audio.sample_rate = AUDIO_SAMPLE_RATE;
 	it6505->audio.channel_count = AUDIO_CHANNEL_COUNT;
@@ -2467,7 +2465,7 @@ static void it6505_link_training_work(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505, link_works);
 	struct device *dev = it6505->dev;
-	int ret;
+	int ret, retry;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
 			     it6505->sink_count);
@@ -2475,27 +2473,22 @@ static void it6505_link_training_work(struct work_struct *work)
 	if (!it6505_get_sink_hpd_status(it6505))
 		return;
 
-	it6505_link_training_setup(it6505);
-	it6505_reset_hdcp(it6505);
-	it6505_aux_reset(it6505);
-
-	if (it6505->auto_train_retry < 1) {
-		it6505_link_step_train_process(it6505);
-		return;
-	}
-
-	ret = it6505_link_start_auto_train(it6505);
-	DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
-			     ret ? "pass" : "failed", it6505->auto_train_retry);
+	for (retry = AUTO_TRAIN_RETRY; retry > 0; retry--) {
+		it6505_link_training_setup(it6505);
+		it6505_reset_hdcp(it6505);
+		it6505_aux_reset(it6505);
 
-	if (ret) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-		it6505_link_train_ok(it6505);
-	} else {
-		it6505->auto_train_retry--;
-		it6505_dump(it6505);
+		ret = it6505_link_start_auto_train(it6505);
+		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s,",
+				     ret ? "pass" : "failed");
+		if (ret) {
+			it6505_link_train_ok(it6505);
+			return;
+		}
 	}
 
+	/*After HW auto training fail, try link training step by step*/
+	it6505_link_step_train_process(it6505);
 }
 
 static void it6505_plugged_status_to_codec(struct it6505 *it6505)
@@ -2576,7 +2569,6 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 			     (int)ARRAY_SIZE(link_status), link_status);
 
 	if (!drm_dp_channel_eq_ok(link_status, it6505->lane_count)) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		it6505_video_reset(it6505);
 	}
 
@@ -2602,7 +2594,6 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_variable_config(it6505);
 			it6505_parse_link_capabilities(it6505);
 		}
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);
@@ -2739,7 +2730,6 @@ static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_statu
 			     (unsigned int *)int_status)) ||
 	    (it6505_test_bit(BIT_INT_VID_FIFO_ERROR,
 			     (unsigned int *)int_status))) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		flush_work(&it6505->link_works);
 		it6505_stop_hdcp(it6505);
 		it6505_video_reset(it6505);

-- 
2.34.1



