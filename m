Return-Path: <linux-kernel+bounces-751913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D1B16F42
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3A61AA6CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E72BD028;
	Thu, 31 Jul 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8FeTuc/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286C19066D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956832; cv=none; b=ZmNuHcZbLS9Q4RFlNC1HleKNSe8QkGnB5moN1/qxqmuyG2PGxPblNAiE7U4+HpaV0b26BubhE9a8NUFjvvg/wN2X56CbPMmQrcK4yEsIyDYDa1jpOMlGdpZxJMJR7qEOQIo9oHcc+Kf1tQfDgU63/Jrpr9kr1lm4EaFjDvea5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956832; c=relaxed/simple;
	bh=FnmfPNbVNSQFPhdxV9B7rJzmlGCSDcTpQmOmxfgDpxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZGegRxXuZIat75ygm0TC7KmMaRtieamgeVf6FsePeRGdNMQNIYwahcQnFjM6F74BhvmaQX8iyOe7JCY0S3RN763MYPR4NKyJcqkwm1iE66blFrhhnqMBq9/CA9XPQQzoMWpQHPc/wfEaTgbjlKrMqHn4DRWXoCM5u2kdJI+Ra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8FeTuc/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so252655b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753956830; x=1754561630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUEg3xcJ3jba8hnyoRSpTU/LFqclls7jlqdJpvyla9c=;
        b=S8FeTuc/HZZtFC+IU7ufAZ5rFK1NZJuejDtSfJEe7B/cWAkeT+DoW6BLJkEE+FYFKc
         ymHSWDszF8ngexBExRqp12+PUZG1tgR0JBSvt+bBkdv4IYHhIYaHmSMaMSpndv9RQblG
         q3/+Uos3SZx5CCnvAanSqls16tEqpL/6wd3NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956830; x=1754561630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUEg3xcJ3jba8hnyoRSpTU/LFqclls7jlqdJpvyla9c=;
        b=DxmuF85ZT0jY51V6ucFxR3j6i+KR6sjbRi4It+89BxDmbvBJHThUn7XI3z0nmhlha0
         9HcHjl2VXzup/jmqADIi/wIt3DrKNxJ3mZKISElmHJre0aYn5zkB9bm+TNO5gJirmbyB
         1dbRo8INwtQ8j7dytz/hKOp06zpzN7D/nDjSB8cDUZ86tz3z9JFXV+/LmM9eIXwbivfX
         N4ekfooZESiquqU+8Gsamm+1nJtLcv9oediOQDbeV/niKAUlUJ4/gP08e2pV1bDMVL0q
         rMHK5pidQXC7H4eVMurp1W9e1j4suL2HM9noqMK8gx6/xrcC+Mo+T/HiQfrKk41ru9Rk
         QFLg==
X-Gm-Message-State: AOJu0YwWVD++skBKHqIXUrPXThbQsJW9bdYIIumUqbDYr92E4C8Ky5hJ
	tzVqVLvgusNiDFQNffBlPXEJiwxaTmtnfIM2xRneLaW++O7Sz93YtMx9Rx1kmH/cqw==
X-Gm-Gg: ASbGnctRbr8r+lz8J1HYjVKxobtentHt0EMmktLWG5SuZk7wW/R2Pm+7GR7kyJXlU56
	3LkoKw1vyCrCGQKe8q017BwQpqLzPWIzqhkkBtKJPEcrQ1B7JZ7a+9fcZuD56JRd1fjQCb6CtL0
	B9cD28GjNfM94ChYxEUZe7lIYDEk32jWdt37Gs1pKnw98RGXYtoCHaxl17yfs/yQB5+0Kd3GKTd
	KubvNnZ4XxZm8wBrBWs8YPf/xHaywLLOG2sisuaCluv5nHY5S6pgNChXEfB04RNOP7XzzSSyKgC
	Wh4bsGpTmMgQOgXwr7mJfVAsSD3n8dpwJYepszay657RXh67Io5ueRb+79Jbbc82bl9l4wfaMub
	QEmencWEyXXOyfRqBw6jxgnmj+yng9H7o2Oap53PLAMc=
X-Google-Smtp-Source: AGHT+IFZAlHN/nIouijHXQyWsOYKKyTBnU+4hjJh++C618HZ1kK7LQSmICyL09/nAo527xH1aNU/Dw==
X-Received: by 2002:a05:6a20:7d9a:b0:238:3f54:78ec with SMTP id adf61e73a8af0-23dc0f6348emr10936788637.46.1753956830368;
        Thu, 31 Jul 2025 03:13:50 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8177:f5a7:88a1:4ed9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f5f5sm1229265b3a.10.2025.07.31.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:13:50 -0700 (PDT)
From: Pin-Yen Lin <treapking@chromium.org>
X-Google-Original-From: Pin-Yen Lin <treapking@google.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Pin-Yen Lin <treapking@google.com>
Subject: [PATCH 1/2] drm/panel: Allow powering on panel follower after panel is enabled
Date: Thu, 31 Jul 2025 18:13:14 +0800
Message-ID: <20250731101344.2761757-1-treapking@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some touch controllers have to be powered on after the panel's backlight
is enabled. To support these controllers, introduce after_panel_enabled
flag to the panel follower and power on the device after the panel and
its backlight are enabled.

Signed-off-by: Pin-Yen Lin <treapking@google.com>
---

 drivers/gpu/drm/drm_panel.c | 47 +++++++++++++++++++++++++++++++++----
 include/drm/drm_panel.h     |  8 +++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 650de4da08537..58125f8418f37 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -133,6 +133,9 @@ void drm_panel_prepare(struct drm_panel *panel)
 	panel->prepared = true;
 
 	list_for_each_entry(follower, &panel->followers, list) {
+		if (follower->after_panel_enabled)
+			continue;
+
 		ret = follower->funcs->panel_prepared(follower);
 		if (ret < 0)
 			dev_info(panel->dev, "%ps failed: %d\n",
@@ -178,6 +181,9 @@ void drm_panel_unprepare(struct drm_panel *panel)
 	mutex_lock(&panel->follower_lock);
 
 	list_for_each_entry(follower, &panel->followers, list) {
+		if (follower->after_panel_enabled)
+			continue;
+
 		ret = follower->funcs->panel_unpreparing(follower);
 		if (ret < 0)
 			dev_info(panel->dev, "%ps failed: %d\n",
@@ -208,6 +214,7 @@ EXPORT_SYMBOL(drm_panel_unprepare);
  */
 void drm_panel_enable(struct drm_panel *panel)
 {
+	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -218,10 +225,12 @@ void drm_panel_enable(struct drm_panel *panel)
 		return;
 	}
 
+	mutex_lock(&panel->follower_lock);
+
 	if (panel->funcs && panel->funcs->enable) {
 		ret = panel->funcs->enable(panel);
 		if (ret < 0)
-			return;
+			goto exit;
 	}
 	panel->enabled = true;
 
@@ -229,6 +238,18 @@ void drm_panel_enable(struct drm_panel *panel)
 	if (ret < 0)
 		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
 			     ret);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->after_panel_enabled)
+			continue;
+
+		ret = follower->funcs->panel_prepared(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_prepared, ret);
+	}
+exit:
+	mutex_unlock(&panel->follower_lock);
 }
 EXPORT_SYMBOL(drm_panel_enable);
 
@@ -242,6 +263,7 @@ EXPORT_SYMBOL(drm_panel_enable);
  */
 void drm_panel_disable(struct drm_panel *panel)
 {
+	struct drm_panel_follower *follower;
 	int ret;
 
 	if (!panel)
@@ -261,6 +283,18 @@ void drm_panel_disable(struct drm_panel *panel)
 		return;
 	}
 
+	mutex_lock(&panel->follower_lock);
+
+	list_for_each_entry(follower, &panel->followers, list) {
+		if (!follower->after_panel_enabled)
+			continue;
+
+		ret = follower->funcs->panel_unpreparing(follower);
+		if (ret < 0)
+			dev_info(panel->dev, "%ps failed: %d\n",
+				 follower->funcs->panel_unpreparing, ret);
+	}
+
 	ret = backlight_disable(panel->backlight);
 	if (ret < 0)
 		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
@@ -269,9 +303,12 @@ void drm_panel_disable(struct drm_panel *panel)
 	if (panel->funcs && panel->funcs->disable) {
 		ret = panel->funcs->disable(panel);
 		if (ret < 0)
-			return;
+			goto exit;
 	}
 	panel->enabled = false;
+
+exit:
+	mutex_unlock(&panel->follower_lock);
 }
 EXPORT_SYMBOL(drm_panel_disable);
 
@@ -537,7 +574,8 @@ int drm_panel_add_follower(struct device *follower_dev,
 	mutex_lock(&panel->follower_lock);
 
 	list_add_tail(&follower->list, &panel->followers);
-	if (panel->prepared) {
+	if ((panel->prepared && !follower->after_panel_enabled) ||
+	    (panel->enabled && follower->after_panel_enabled)) {
 		ret = follower->funcs->panel_prepared(follower);
 		if (ret < 0)
 			dev_info(panel->dev, "%ps failed: %d\n",
@@ -566,7 +604,8 @@ void drm_panel_remove_follower(struct drm_panel_follower *follower)
 
 	mutex_lock(&panel->follower_lock);
 
-	if (panel->prepared) {
+	if ((panel->prepared && !follower->after_panel_enabled) ||
+	    (panel->enabled && follower->after_panel_enabled)) {
 		ret = follower->funcs->panel_unpreparing(follower);
 		if (ret < 0)
 			dev_info(panel->dev, "%ps failed: %d\n",
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 843fb756a2950..aa9b6218702fd 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -183,6 +183,14 @@ struct drm_panel_follower {
 	 * The panel we're dependent on; set by drm_panel_add_follower().
 	 */
 	struct drm_panel *panel;
+
+	/**
+	 * @after_panel_enabled
+	 *
+	 * If true then this panel follower should be powered after the panel
+	 * and the backlight are enabled, instead of after panel is prepared.
+	 */
+	bool after_panel_enabled;
 };
 
 /**
-- 
2.50.1.552.g942d659e1b-goog


