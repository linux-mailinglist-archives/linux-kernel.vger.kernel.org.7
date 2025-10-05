Return-Path: <linux-kernel+bounces-842375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC7BB9A16
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564024E1232
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EC19D065;
	Sun,  5 Oct 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wKNXeH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF714AD20
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759685912; cv=none; b=VodJqN9mFBJE12HhjGwKkOAFPNKjwU8GyGaVWTP4OHLxNLsC1ymwmBLyBQrjFbk72e3uZ68gYW22JKm0Q1ffMw5cNbgbEXFKNtFE/Dt9WfDucUK9PDZzgUmnkvtC5LvAvyQJKKEAIgfbhbg1e6FnZqLZ/O9Yp14rZ5+i/8yLETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759685912; c=relaxed/simple;
	bh=0MbqLBIFY7Qxfx66wlp479sDcS2Y4WJEK2gNMBGL5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX/x52Zev++tA79gVdHtzrxshf+KjW9b7bJlRN9KbFJIbhivOr/nVS3tKhXtpEmxIE4VSl2+R2UnOXuYZogI91xvV0rcoOLpOGdwBJ/OC8GYNr7tVEZ1zHuILH35uuaDDmcp6iGjsoLZwV5vYx3gp/5/Rs7XfB2WZDZ6fwL02Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0wKNXeH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46f53f88e0bso3114545e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759685909; x=1760290709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLqw9GQUx0cKuTKkHqUH8puvEr9wdfKsNFqEgyMKdRs=;
        b=E0wKNXeHyTptrzlkZHM8ziFueYpZRuZgj1qe/ErYBazlmDiHch6kh9pvznjbGGP0IQ
         c8uVR+uT1aJVI48b04h/AWMunjBIf+zgjNEXic7wOb/CWeInyvSJdQkDNYx+UONs+KUA
         N+eKM7jps20WeU0Po52q9wjp2BidKkFN0JPesagfGbQgcgFxM7dFnRhUqUhIxpvfyPe4
         vRuQHNhaqhKOssjrjgi0XEkuQHuG8tPVMBhNs0D3+pVfncMvh+jfSN7bVBEs10gJUuMH
         NokeY2HzOM725qo7nBu4krGL0Lj7NAft4uKOEydNGoUjSN/GMS9ZKAGI2LLGUQO3mrNg
         GOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759685909; x=1760290709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLqw9GQUx0cKuTKkHqUH8puvEr9wdfKsNFqEgyMKdRs=;
        b=iCG+T064zJlp2erJ3B6exvvHqCrtsdNzo9reNCbgcg4mvyON1fnKaklLsPvyiog1qI
         fKuZjXiCihjU20wrDVrOVEBRLZHYOkb9duiJygh4RduAumSTLJPFlNqcytEAlE8PfEOi
         6bSn7IiHSBWhnJjBA6Fcw/Tz98H5RlXSJlBPl7j/5/IJBzfI478kxOk9pZS5LGoPe6xn
         OhMbDKyNaucGQ5l2XifPqCiN2qYXnVExZDoN3cDGc6qtlp0EDtumkgLQmYTAxfVMLTaT
         jbJyFBAdOnnWXCwwAitVPAcULm0mt9Cd0k38RxH5RN/Ula+ho6nsVBqRTJ12M/30uKs3
         pplA==
X-Forwarded-Encrypted: i=1; AJvYcCXc3rYWYu+lb19i/Jiqop6xYT9rsWIYzE+E8lJCTnbJdMg1aM4G1RLopBHH+UQNAYVPkTPjf5p0+VztJAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujMtRxCGLojBxbud+xV8K+0qnh98j4maNsQl1Ej4+XReP0Pey
	gKXBDWyeNItQub1aoHV4NZnQuTIm7bfR6GjZhjfoV6yKoeN/ll+OuEIh
X-Gm-Gg: ASbGnctYHxMcknK+Cz2zAllp2iboYiXp3wOH3byOtVPwuYJZ4kAhsDau9HZ94RfwKWD
	vU8WzNO4ZuiDGwn6L40O6CBp++lggjjNolGCIiFCt/6nL4WY2akE25oTDRmK1JSNjmkEWgSX9Ak
	A9/egqAndLNuanrLoZBp9gDRa9eu9GBzXiY+im9mFTLsicibNVjZ4sM+j1gvcu/WHedayQCmiaY
	nk0J/IZfQVYxRHa8f3Ac6VN1BtdPflRyIK/7a5Tvqsuht7qC2ge+Mdzo3zMMHH+AiHIQiV2AcDZ
	REXrHsAVeNot8Pm827kWu5X5eeolKFtVBPzBXWXZtdiUhxjBvhB8+qJCM/qto2QX05rQgqaZWTD
	C+IpmEv/j5+DrCJQTTx2/IgbpJfYNf+pQXwDbu4iAMhvMxzm5JJaIbflSWWRG9XDfHtFsKPO21y
	sY2p+nBC9NXE50bg==
X-Google-Smtp-Source: AGHT+IEaKsxZHPdAaOgp5BYREYT6BZzg4XKffxkJUb2CuHtMDt5MPcCAPn47vcTvw2YbfoQe/z3Ccw==
X-Received: by 2002:a05:600c:c162:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-46e711440bemr64476335e9.23.1759685908971;
        Sun, 05 Oct 2025 10:38:28 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46f9c8873f1sm19335655e9.8.2025.10.05.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 10:38:28 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Date: Sun,  5 Oct 2025 19:38:12 +0200
Message-ID: <20251005173812.1169436-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch wraps the relevant code blocks with #ifdef CONFIG_FB_DEVICE,
allowing the driver to be built and used even if CONFIG_FB_DEVICE is not selected.

The sysfs only give access to show some controller and cursor registers so
it's not needed to allow driver works correctly.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index ade88e7bc760..a691a5fefb25 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -530,6 +530,7 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
 	return 0;
 }
 
+#ifdef CONFIG_FB_DEVICE
 /*
  * show some display controller and cursor registers
  */
@@ -569,6 +570,7 @@ static ssize_t dispregs_show(struct device *dev,
 }
 
 static DEVICE_ATTR_RO(dispregs);
+#endif
 
 static irqreturn_t mb862xx_intr(int irq, void *dev_id)
 {
@@ -759,9 +761,11 @@ static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, info);
 
+#ifdef CONFIG_FB_DEVICE
 	if (device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
+#endif
 
 rel_cmap:
 	fb_dealloc_cmap(&info->cmap);
@@ -801,7 +805,9 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
 
+#ifdef CONFIG_FB_DEVICE
 	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
+#endif
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1101,8 +1107,10 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
+#ifdef CONFIG_FB_DEVICE
 	if (device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
+#endif
 
 	if (par->type == BT_CARMINE)
 		outreg(ctrl, GC_CTRL_INT_MASK, GC_CARMINE_INT_EN);
@@ -1151,7 +1159,9 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	mb862xx_i2c_exit(par);
 
+#ifdef CONFIG_FB_DEVICE
 	device_remove_file(&pdev->dev, &dev_attr_dispregs);
+#endif
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
-- 
2.50.1


