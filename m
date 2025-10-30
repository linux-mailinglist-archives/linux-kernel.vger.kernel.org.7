Return-Path: <linux-kernel+bounces-879039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F1C221B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82653B0CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6B6333440;
	Thu, 30 Oct 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEL35Zdr"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C932E136
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854400; cv=none; b=KWyptgvVMoUKMk3evzbZz/sW+2crsH0MVOCx1k0h2tVPIktKhwZzHMKwZVlTeFMFZe+DiGISZLfwOjJnXRTHVmp8ZOilCkZrJ62/Ihlw3C2d19uXv/gs5ehhr+gF8vg/6LFbIWncIBvjj2P8AshuoP74stl8BEEOchwB4/i1EjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854400; c=relaxed/simple;
	bh=0/Ay5xIMjaO6H9CAGlnV5wtZpnCbDWuIf9Vw4FRb8NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prYdiSL9zD5v0f+5JZ5P1WA/FPnCpRIbetItkxzN1Ig92KOq/4/qQI2u7rFrXPJuzLkVuy8/oE/G1Ba4ju9gyusus4SFuCIbMTUZlTdQDGOrU4yRwJokW1AkV8TGTAcMXh1jpXKajdEsQ5o/KvAt8gg0f+rOGmSU6egy3Au+euE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEL35Zdr; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-940d9772e28so62281039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761854398; x=1762459198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWc+qSCsaB++95Y0qEzQptO8LIk3YM0/Lnj21sNqRgI=;
        b=eEL35ZdrHx0R16piZdOMO2UFKs27gAecM9848HHnGzse1G2XgxIdTMBUuMV0lpECXe
         lV8OAw+V9lnd4uRJuO+bHFABskNnkyC8w73SnmAmQnb6HGqjt9nkd1lbFIjadvnG7DDh
         S2jK2sjoDDp9lFzjL5K94fByXDQ35C39UcNJ272e9Z4xoLwd5RvybQIcbRBDAl88JMbf
         3ACVWeVMZan3WRENMUJ58syNoIPnwyutw/faiYTIulcYyKQb2uGF1IyC5d48YuZDohnT
         ObYW2LXjCvZ18QIn0Tce6HRp6JPx/tUhuDKUGY01oiwyUJH3vulG62TvnZn6SiBhEgLh
         ZNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761854398; x=1762459198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWc+qSCsaB++95Y0qEzQptO8LIk3YM0/Lnj21sNqRgI=;
        b=T0OA3mMviDxJFpOt6Jr+IhAukLhorcMVlpbgbZJvm4MMBzG4DUlA+cc5Nbum17Sz45
         xv+oguAsThGThC6XOIlXzSM0VL+0GMZP7FTO9IyCmcdn4EBJWw37oMSaYxafTr+emFKx
         +4CljCG8zKJcqpq0m0JhBn4MG8/7c5QKEVBLjBeXZuBOw+xz5cwdWkm5mnotJlQdZxLk
         NJeCG85fLzjwWXl0xcCbNdz/QGZ8gW58ohJRo2u0ffj9TahBfz8ePUXdjAwEfGDIv3j5
         7DoCEbPYpEMiVaW6b000ZJNsrtM4ktjlKktHmG7HWSfR0X3zXMFrU/DELJsEpqEHYSpF
         wcEw==
X-Forwarded-Encrypted: i=1; AJvYcCWp63jEkSP+kZEsV3a0kkCLOPAW/xEK3jlb5LvYvzKuZ/SDTZouf63UyppRjuTdNIjlVo7nrv7UQ5yJnMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6m95FX4eUcthBR4Qoi3sLZdmwgeMGBVrq7RbKIxtNIEoI1ig
	Au4+Tzb/URaETReV2hgTxNSdHXGwwdHonjOSivZO8kr3Lj0DebLWlA/v
X-Gm-Gg: ASbGncul/lcHVuUt+0ef7XYYUbhCeRXJTJ7kBt64jTZvuBBNqPmWn2ji3IxMl6xfLA9
	sJoi2FoWyVAS9qn4DJJxHP2eLBIF5WPJmsB9oYhG30g2DADUb/Ym1rXRSamrl8eDdP2PjCGfdKB
	h6XD5b5yUvum4d6vwpzwcgNDgLgdqpkr+8/AP/As2ns4KAEmOhtoidSKRgGYc0fgdsn3cjjC+1s
	99r53QTalOY0pNfIKdCe8ZXdJjKoiA6Yc05QFyTOsWOkEwsTtb72I4UzEZ02uncAreGV0N//toS
	QvF+Qhe708mgPAoJEASBqC9In+Ctvt7Gf3Un41mJRkXT2JdJMDihTJvEUT8k/UK5gHcAuIcwb3G
	cSM8cyEmyy60iKrS0boyl+B5kbnKGJzUvJ1rhMlVx49Fj51LrbyDEyJsCOahd77taKu68+Q0w
X-Google-Smtp-Source: AGHT+IFf9MIiWLP3EO9J80LImBhp1n37tBGg7wCockg/FHC33/k9aal+Cr7NrJrymrQLn7+b2YAlYw==
X-Received: by 2002:a05:6e02:221a:b0:42f:9353:c7bc with SMTP id e9e14a558f8ab-4330d12c587mr16467125ab.6.1761854397804;
        Thu, 30 Oct 2025 12:59:57 -0700 (PDT)
Received: from aperture.tree.net ([2601:40a:8000:28d9::f29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d412sm7065972173.46.2025.10.30.12.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:59:57 -0700 (PDT)
From: Brady Norander <bradynorander@gmail.com>
To: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Brady Norander <bradynorander@gmail.com>
Subject: [PATCH v2] platform/chrome: cros_ec_lightbar: Check if ec supports suspend commands
Date: Thu, 30 Oct 2025 15:59:11 -0400
Message-ID: <20251030195910.8625-2-bradynorander@gmail.com>
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
suspend control if -EINVAL is returned.

Signed-off-by: Brady Norander <bradynorander@gmail.com>
---

v2:
- Only catch -EINVAL from lb_manual_suspend_ctrl()

 drivers/platform/chrome/cros_ec_lightbar.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 87634f6921b7..893d269f6384 100644
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
+	has_manual_suspend = (lb_manual_suspend_ctrl(ec_dev, 1) != -EINVAL);
 
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


