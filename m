Return-Path: <linux-kernel+bounces-828401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62265B948C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AA518A2755
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55330F81F;
	Tue, 23 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAeGrsMX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B230F547
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608599; cv=none; b=qJJZHUsJKCpoSg/m9jFpJPgPZOfz4HXyO69syPv6bosVJT7CrpOzKf9gd5GVe4NCTylxMvfJMW+MF2jpJMQ8kQdJomSsRa/nZRmILby/AN6aQ+9bHcOlcZ6zv/jIA319iisLM7EM978li8AO3bPHGMShwjLDiOv09xpHcfuyxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608599; c=relaxed/simple;
	bh=cWnQGLilBBjKI7djoZVI5Gg96hkxeT4tcLnwx4uRXx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kD9F6jb9hmHQQq2nLvpyDl+AEZFIQ3eyr3bxL9d/Ud8SM/CiMUZpZxSyZ76m4Dn9YDZVw2+/62EUuzMXx4wtXzlZSUR8UMP8J14z5kyfLFCVn55LgMoymr9GNL+z242kn7l8fkCDobjiYzWOoX+P36AmNtc4oyYtas8tBZzPsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAeGrsMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A71C116C6;
	Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758608599;
	bh=cWnQGLilBBjKI7djoZVI5Gg96hkxeT4tcLnwx4uRXx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EAeGrsMXHhz79Qp/w9ZqHVg5CI00AnbMrpKh2+CsvUZhbD3frXpHZy/B4gFK4kZ3O
	 LW4m3jFmZYRXg8AhsFbm6luwSYIMfymoh/f//UXhkfFGYY2VsBNQ/pLNcuTQBqaAey
	 JMSx0mTR4ianCGZB2z4Rv7RBcqsMcAjcOD13UXbM3kb66KqLIk3JoEWmA+RHEetAui
	 zDJLPIlhSCYCGySKxlpOMylHJeZHqVSAjRlRHm6fSERn55qnYzOt/KZiy7vsaZ7pBg
	 +HiBhsyrYSePdmipXUOUC4/FN7YhYnmkCbuJRavbpjMiesogluo5JN4ePI80zuNOFa
	 H1PVrKroqV6yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FBCAC5B3;
	Tue, 23 Sep 2025 06:23:19 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 23 Sep 2025 14:23:44 +0800
Subject: [PATCH v4 4/4] drm/bridge: it6505: skip auto training when
 previous try fail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-fix-link-training-v4-4-7c18f5d3891e@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758608643; l=2348;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=J5b5WPJ7hvbZmjjTr9M8fRPj8438cxaJVtGe5HFZY60=;
 b=Sx8vlMWf/s/oSkfadrua/DXzQHvxStMg/UTBAmsB3GzAyYR5hPbUBZCFhQJ7U7BzNBUyZ/hLg
 HlTbYt489+nADZqnk5Kc7FeJBqtMDgDF/TLeQO6VucCu4qcYBTTLjvd
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When connect to device that can only training done by step training,
skip auto training when link training restart before unplug device.

The driver performs a full cycle of attempting auto link training and
then manual link training on each modeset. Save time by skipping the
auto training if it failed previously for this monitor

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index bff5f18fb5ae7192242308f034b60af9807c192c..20eae23cb46a4cb3fc18dd2ed3b764f2265262ca 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -467,6 +467,7 @@ struct it6505 {
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
 	struct completion extcon_completion;
+	u8 step_train_only;
 	bool hdcp_desired;
 	bool is_repeater;
 	u8 hdcp_down_stream_count;
@@ -2452,11 +2453,13 @@ static void it6505_link_step_train_process(struct it6505 *it6505)
 				     ret ? "pass" : "failed", i + 1);
 		if (ret) {
 			it6505_link_train_ok(it6505);
+			it6505->step_train_only = true;
 			return;
 		}
 	}
 
 	DRM_DEV_DEBUG_DRIVER(dev, "training fail");
+	it6505->step_train_only = false;
 	it6505->link_state = LINK_IDLE;
 	it6505_video_reset(it6505);
 }
@@ -2473,14 +2476,14 @@ static void it6505_link_training_work(struct work_struct *work)
 	if (!it6505_get_sink_hpd_status(it6505))
 		return;
 
-	for (retry = AUTO_TRAIN_RETRY; retry > 0; retry--) {
+	for (retry = AUTO_TRAIN_RETRY; retry > 0 && !it6505->step_train_only; retry--) {
 		it6505_link_training_setup(it6505);
 		it6505_reset_hdcp(it6505);
 		it6505_aux_reset(it6505);
 
 		ret = it6505_link_start_auto_train(it6505);
 		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s,",
-				     ret ? "pass" : "failed");
+					ret ? "pass" : "failed");
 		if (ret) {
 			it6505_link_train_ok(it6505);
 			return;
@@ -2594,6 +2597,7 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_variable_config(it6505);
 			it6505_parse_link_capabilities(it6505);
 		}
+		it6505->step_train_only = false;
 
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);

-- 
2.34.1



