Return-Path: <linux-kernel+bounces-742006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD457B0EBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF061C27959
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2525BEE6;
	Wed, 23 Jul 2025 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="SCQUmifx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641A271464
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255523; cv=none; b=eqQFC5nDZf9qtcGNPpFhYu3YEqi7mk7ZpOnbxD/3KIOhrA7L1My/5Rb7b/2to8UAblokPfrXJI0NlYDuHehz0tBsZztA8mGW+b4GrDcnyKWLH3xbUmh/Po46+MCdnP1Zo1/0Af0YWbOgr1dsKYuqDVylmL7RRmMrd4N8E1YvZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255523; c=relaxed/simple;
	bh=Bz3fnGgRTSh+h37ZxFuPm9pcKB3hBr2riuDs+u54/Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exTGqCme6/fMjHKRaNnYaZgd94Iv2iB6Ywv0ZRgkKjayjFwgBlGcUbbkVHIjyD2vMRAL9yZQZRciDNsXOHER+wpW+0s9g/+obaiF8IY4UrX2XVr44ec5BJICq2n+z2VJ6GLhC1x8VEbJn9n9tdY5L/GAOYtCF8hRCjSNPvwyDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=SCQUmifx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2350fc2591dso6539095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1753255521; x=1753860321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbVvJ/dl2UFKOk7clhbTp0K7aqaTWpr5zaoIRguIYZA=;
        b=SCQUmifxsuW0Opumkk5aeJAaJf8TvneniG1hjQ6217FwhkuqHvgt9hjo1w8WJu28cj
         5L+9HoWK9tzqjHYNqJkvYOStJKktL9VMYHCsm4UJcPpl0N/TKzz4bD0v7asl46Yi/Zxg
         uZ0yQe+0JK4iwr/lvZx+NytRScKXNxFXUAf4yo1W+m9E0Ro2LmvmAC37gOEwJYmtFMJF
         pHLgq1HVxerKSdfF0tnoD+snj1dYa9mKb7yrzgcTNB+nfLk1br/70cNKo2pTczvyZa2Y
         lVHAednHaR3/xP3VAaa0c5Yp92p573MSWdweR9a/reTt+EllHqmdOBKVheYPB/Lx8z7v
         q3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255521; x=1753860321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbVvJ/dl2UFKOk7clhbTp0K7aqaTWpr5zaoIRguIYZA=;
        b=oPiCnWJkJRfy0x/EJ2DokAYLUADe5rCGwWBBCc4CTvmJyBNu3KSYXLkrjZOKqL/dBd
         mUqsL53iH9EXm0YziAd2X//HMk3MzIoQ/TpxM+J1Nmq5amcL6wS99uih3L54IF9VdR5w
         IHHVn4Bk8L39WmkVBDAL8GxeIiuBLWU0/AC3RxpKYpYAwm8spTsGWuX9YJTiw4X5s0Kx
         mDpRdeXYYsuL63sgcu3/LeS3gTd15KokuirODBXlABNBrjYiaa2VKUPEnRBpU3+fPFU2
         9XZIX9qE0hAXatQQGG3yNO7wcuDhNgbaxTMlrhSSx703wLbHFyrFP2tedxDVbfETtili
         uj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7tRWK1nuBvZgXQA+8B2/Crd3WGdx+zcyL7nRjWegRjJAvDmWe0GA58VElqdFuXE6at0+uQoC/DZ1yDUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58kCkPsQkWxD25aE1yNTfRqDi9pO40eCIy9TwM64MxPBG1gdT
	kAbWl6x35X/8iOpjJC1wfjgY9yX0x3cEoGinCXpg7UKe9bsAZh9cc6vwatZMwCudXp0=
X-Gm-Gg: ASbGncuzIgezR7bywsnsYi/2X4YiJXeDLKXjHsfSjgHHWdrFqjDaKywQPk8BbqiFIKI
	aQQ0MZQoUn/I+xAfkfPAw4ZgqRwg6QuOVbmuoqRkEOTxGv0lrYdKVEGeS+rgGXo4KikC0Eqfq7o
	WCWEcugM2yNlGXf5ydZO0hBgEGLFdkWGJ8Tnw4Oek3GJdpeh9jsDYainS1OavyJtIxVCXKvOAUj
	+Lo15Wyg4j9+DA9xVuf8W6FHHPg0iL/+4O8igHTA8SYnmCcmYfQdzVX7cce+nDSwTrpEuHsQ2Gb
	h3W1PLH7wmwxOhiy/7O5lZTQo1wLRy+OvhXlBTGoX7Il+wM4D8cvSHC/aNzLFY7j0IlOyNChNlF
	KqLsHJp6p373g8nktH331JgJiivximpaDRd61zJZyTP53a8R6QxqJEQEuC3y3PxVRfMuj2AocIj
	E16K3Q
X-Google-Smtp-Source: AGHT+IFINmSfyMA860ygGntKNOpi4Ot+pzj3Tn4lpfMlC1W1Ze9XP6Rd+l9jS1YOTv/Ti5UF8dwxxQ==
X-Received: by 2002:a17:902:d4d1:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-23f8ace63afmr92233655ad.24.1753255521187;
        Wed, 23 Jul 2025 00:25:21 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b491bsm89749575ad.126.2025.07.23.00.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 00:25:20 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v2] drm/panel-edp: Add 50ms disable delay for four panels
Date: Wed, 23 Jul 2025 15:25:13 +0800
Message-Id: <20250723072513.2880369-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 50ms disable delay for NV116WHM-N49, NV122WUM-N41, and MNC207QS1-1
to satisfy T9+T10 timing. Add 50ms disable delay for MNE007JA1-2
as well, since MNE007JA1-2 copies the timing of MNC207QS1-1.

Specifically, it should be noted that the MNE007JA1-2 panel was added
by someone who did not have the panel documentation, so they simply
copied the timing from the MNC207QS1-1 panel. Adding an extra 50 ms
of delay should be safe.

Fixes: 0547692ac146 ("drm/panel-edp: Add several generic edp panels")
Fixes: 50625eab3972 ("drm/edp-panel: Add panel used by T14s Gen6 Snapdragon")
Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
v2:
  - Deleted "delay_200_500_e50_d50_p2e200" structure and renamed/replaced "delay_200_500_e50_p2e200"
  - Link to v1: https://lore.kernel.org/all/20250722024512.983313-1-yelangyan@huaqin.corp-partner.google.com/
---
---
 drivers/gpu/drm/panel/panel-edp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 09170470b3ef..d0aa602ecc9d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1736,10 +1736,11 @@ static const struct panel_delay delay_200_500_e50 = {
 	.enable = 50,
 };
 
-static const struct panel_delay delay_200_500_e50_p2e200 = {
+static const struct panel_delay delay_200_500_e50_d50_p2e200 = {
 	.hpd_absent = 200,
 	.unprepare = 500,
 	.enable = 50,
+	.disable = 50,
 	.prepare_to_enable = 200,
 };
 
@@ -1941,13 +1942,13 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a1b, &delay_200_500_e50, "NV133WUM-N63"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
-	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116WHM-N49"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80_d50, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ae8, &delay_200_500_e50_p2e80, "NV140WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b09, &delay_200_500_e50_po2e200, "NV140FHM-NZ"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b1e, &delay_200_500_e80, "NE140QDM-N6A"),
-	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80_d50, "NV122WUM-N41"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140FHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b66, &delay_200_500_e80, "NE140WUM-N6G"),
@@ -1986,8 +1987,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x162b, &delay_200_500_e80_d50, "N160JCE-ELL"),
 
-	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_p2e200, "MNC207QS1-1"),
-	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_p2e200, "MNE007JA1-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50_d50_p2e200, "MNC207QS1-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1413, &delay_200_500_e50_d50_p2e200, "MNE007JA1-2"),
 
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1100, &delay_200_500_e80_d50, "MNB601LS1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
-- 
2.34.1


