Return-Path: <linux-kernel+bounces-867905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D4C03E04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C76C4EAC92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08672E22BF;
	Thu, 23 Oct 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb6DK5Bv"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2192E1C63
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263098; cv=none; b=Zk6HzaXDrMWdOGmEoxGtc30dGVQw8g6Az7zNgvQiqH/I7A7Y1n+EMreGugukWrPwFt8lNFCadrUR+2ddsDO+bO4ScWwPzGJWLxFT/zsPJXKefgymzCuDBT5Z/Qv+hY1Hqf/T1JtKki1lYho2cpJGvJzy6sQzGj2SXKAHBSFP65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263098; c=relaxed/simple;
	bh=ofon3zRhL7g5DEfj7LACmcneRju3vqklLAunt9FWqfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPP0wdItUrONfCalDITJTVkfF3a/sIJ9eN7LtpIJ9RalWA7f/VeejgeURECgf3IdVFkso3GJEkUkYfiUAhjsu/GhWDZekQRzdztiFcHPNsKYemufydWrRakLx/Yl/SYAjJYmsaGEPh8XfcowV3tgIDH5kUX2bmAsochKvkM2luU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb6DK5Bv; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92790f12293so64018339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761263095; x=1761867895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA9DnYHnL0FjnmMgHP+rM1jzEwbK34syKt1KByA1wig=;
        b=mb6DK5BvrGLxuifam7lzli/qaNo/Rkikqyr8PvcLkdCe5fM2wxHMUbQ0ANThEcAHHS
         aO2OT4XEx9sN3pOIxHyWVCfTz801fgj9W/3638zcQ5MJDRmLJad8J17EWNls4mNeKGKn
         4YLUKtki4xISZ+YBOSsGBsceQvdOY/Gyekw3TaNfT6NB9w/lx2e0vUNPQZ0tdNoEQcve
         ZqwznQyeDGRVaUZaE1XSeQQ75f405ZDObVX3SeXcfmKGu8FiCLafhY1dfXJ1RS+Og1xc
         qUopMfqCfIlDe4iP4IS5Jo2HDZz6uodyc1jfRPNiViQtymvuF+5L1a14LOH3Ur5u4rF1
         bs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263095; x=1761867895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AA9DnYHnL0FjnmMgHP+rM1jzEwbK34syKt1KByA1wig=;
        b=WfPndJo+/X9J8jfbYKvW2jZljwHIK4c8Tka7QPBGnC1lwPO3ib4DfpQQA9c13DB2MK
         rOTyboWGKQJ/oxIg4xd2qTGLCMozMFyHKPoozftnJdNax9eLprmaRDZ0N04TXVpXUCkE
         ar8pOKF00CktachW7RZUf/5oRJZ2qQ+3nzq1IQ+uUOEueu0Kz0cRIGVeMXj6OeVyi1O8
         I9WpzvqXRxnUgyviH1bpt2zbGEpcNJxSdTEGIorOZYYwNZparXFzQRElewnlZazB0vxf
         fm60KZ58ul5tTV1dF6eynumJK6jkqR3GZlkQkWikRT9SeIwOaC0K4HeYXQDErfhQvQuQ
         slbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4HJbSg27G2CkvtgoXK04A6NfOy1Dl3BK7dB2oLqhKgErfXjUZKm/M/lzrYW/3x0cB/wNG9jS6cd+uvpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMHpaJIVM72aW4bJIYeJbMajK/a4l7KFiaT2agzSJ55r75XC9
	eMO/u4Ove/ukDAMOCCq5tI55EewleOXA1kp1g7me8MqnZ2wBGayxQADr
X-Gm-Gg: ASbGnct/h6qpgXjL7+77c1rWCfyXYc7+TVmhM9c5Qghqjz2xRKxDqRhj8nc1yc9/pyI
	LGKR8/EGywqhZTEW74FMi0H9pu/ctygV/ItRSj+oogCIAYya9+ZgR+KICBlXhypZpr9lPG6U/UT
	PvYS85hIX3IO9herNk8hOBTMv1oD4aIgRJ7a60Hmhh6q2tLqOFuSyy/d0/4hHqEDlYt+7NtEgKy
	SqRXg4HAe/CkWcO/2zEHGQhqCSSLD+MhF2jKf8MwtM4rZSQTtfJQBq+BxWF09dduDC4Ihvm6WiP
	HLuuxpNpRkmlv/Fm21782ENtMfN8Z3697nKvtHElPc9Dp4OmF9PQF9hQ+j3stnuvB7eqXQVXoVc
	53Zgr2kTxVW9BPB2W+CWnu9z4iqZHrmVg1dHucVklcnlekoR3NlOjuQlDjyCr/6HAWUvDz/9otN
	fkxPwMx+w=
X-Google-Smtp-Source: AGHT+IGaw0oK77+a5zH60SDSV4zBNjek6pSZSQhHAvv/0a1tUdsXy8diawp15QZPvbJ2zky1dbp0ig==
X-Received: by 2002:a05:6e02:248d:b0:431:d3c9:66a2 with SMTP id e9e14a558f8ab-431ebdf1645mr8086785ab.2.1761263095610;
        Thu, 23 Oct 2025 16:44:55 -0700 (PDT)
Received: from aperture.tree.net ([2601:40a:8000:28d9::f29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb4e4c958sm1474517173.3.2025.10.23.16.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 16:44:55 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH] platform/chrome: cros_ec_lightbar: Check if ec supports suspend commands
Date: Thu, 23 Oct 2025 19:42:40 -0400
Message-ID: <20251023234239.23882-2-bradynorander@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Chromebook Pixel 2013 (Link)'s ec does not support the lightbar manual suspend commands.
As a result, attempting to suspend the device fails and prints the following error:

    cros-ec-lightbar cros-ec-lightbar.3.auto: PM: dpm_run_callback(): platform_pm_suspend returns -22
    cros-ec-lightbar cros-ec-lightbar.3.auto: PM: failed to suspend: error -22
    PM: Some devices failed to suspend, or early wake event detected

Check the return value of lb_manual_suspend_ctrl in cros_ec_lightbar_probe and disable manual
suspend control if an error is returned.

Signed-off-by: Brady Norander <bradynorander@gmail.com>

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 87634f6921b7..1b7e4c4e18bc 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -30,6 +30,13 @@ static unsigned long lb_interval_jiffies = 50 * HZ / 1000;
  */
 static bool userspace_control;
 
+/*
+ * Whether or not the lightbar supports the manual suspend commands.
+ * The Pixel 2013 (Link) does not while all other devices with a
+ * lightbar do.
+*/
+static bool has_manual_suspend;
+
 static ssize_t interval_msec_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -550,7 +557,7 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
 		return -ENODEV;
 
 	/* Take control of the lightbar from the EC. */
-	lb_manual_suspend_ctrl(ec_dev, 1);
+	has_manual_suspend = (lb_manual_suspend_ctrl(ec_dev, 1) >= 0);
 
 	ret = sysfs_create_group(&ec_dev->class_dev.kobj,
 				 &cros_ec_lightbar_attr_group);
@@ -569,14 +576,15 @@ static void cros_ec_lightbar_remove(struct platform_device *pd)
 			   &cros_ec_lightbar_attr_group);
 
 	/* Let the EC take over the lightbar again. */
-	lb_manual_suspend_ctrl(ec_dev, 0);
+	if (has_manual_suspend)
+		lb_manual_suspend_ctrl(ec_dev, 0);
 }
 
 static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
-	if (userspace_control)
+	if (userspace_control || !has_manual_suspend)
 		return 0;
 
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
@@ -586,7 +594,7 @@ static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
 {
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
 
-	if (userspace_control)
+	if (userspace_control || !has_manual_suspend)
 		return 0;
 
 	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
-- 
2.51.0


