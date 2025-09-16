Return-Path: <linux-kernel+bounces-818128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC28B58D00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 721E04E225F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377A242D76;
	Tue, 16 Sep 2025 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbmqKM+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F022E3F0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998064; cv=none; b=Oc4OL0LTgyleBcC+TqFkR1/Nfw1BTGel6C9bfacFt6sXOsv7r/bNmxjGQUU0cet73V0PObd07eSmHn8ZZJmjAHXKzGyH+2HjNgobiL/SKC7D2yTY8leYfAFB1evYC4OGnq2rT57sJodtUT8qHT2uchrp6H/xipT10j3qlSUS8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998064; c=relaxed/simple;
	bh=vT4jRgNOKJGO9pduYqW5rUZpbUZTqMnVAbx3caTHA90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdOxUp909PXZ3O3W6FChQANP4yTgZiCsTOSoiUBT9GCQHegTrPij0hvD7N/z293yDPWUmcqdpBxNygBNhTytm7yPcDfGVJZ59xq4W5L/PRLJbFCbZk44B4nlGnoTmzfYmdW55tWlC+J0Ytl2d3ZXOrENUWvCEcfhiiDAvEJA4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbmqKM+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F08E7C4CEF9;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998064;
	bh=vT4jRgNOKJGO9pduYqW5rUZpbUZTqMnVAbx3caTHA90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YbmqKM+aJFiPL/CEkd9DKxwMtH57EeTk3TkqlPvcFOhmMjRQJ77IvAsJ/Nn7UeIG9
	 R55ZvXf7GQC5fIj6QHz3/EctXKdAnMDadTJwzoltTgeRigr3P3Q44IS8NoC5xjdol5
	 iIKmxg6OGvW/k5h5+DfXGRl16c+dbVQanItA1z/jjNtvPyuBo1rc2Ywk+Z7agi1Flp
	 aDYR0EXiDujCt8mGx8unxtdzUQt9/kFhL0SYZ4e6TVLXCzu+iUyAGfGXkoGI3IipMj
	 EDzjYtASKvBG+/aiR5HLwem5oOmZ1Z2Kim5TjvrH6vYf0a/LJ2qqQzKTC05AJV/tcx
	 ysLGeJiZbxcmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9441CAC599;
	Tue, 16 Sep 2025 04:47:43 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 16 Sep 2025 12:47:45 +0800
Subject: [PATCH RESEND v3 5/5] drm/bridge: it6505: skip auto training when
 previous try fail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-fix-link-training-v3-5-0f55bfdb272a@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998107; l=2181;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=pLytI76dbGjTNwcbsSYeds6mdd5OwXNWVjluMga6s9U=;
 b=JY8tgX+eYXvPeTbxNaV7UrIwPK91wF7/U5zi8MM9ecEKoV2Bl2728E4KvmmBeAPdGcyAZrKS7
 PS+CLxRC/6jDOShl424eq7Mu0xWPm6aPsdfVu2xsvX2W6xKc5+B/AcH
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When connect to device which can only training done by
step training, skip auto training when link training restart,
usually happen when display resolution is changed.

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



