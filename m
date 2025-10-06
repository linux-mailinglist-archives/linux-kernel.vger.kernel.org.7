Return-Path: <linux-kernel+bounces-843228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF4FBBEAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAAB18946EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432E2DCF57;
	Mon,  6 Oct 2025 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmhvIIDj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5591E98F3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768923; cv=none; b=cDfBtVpji8PCZ6IyVUWR0wbSiFwS/m+koI69F2iQOpJJgasT6YaVXY4vgAbBp2+X0aO+qxiJX1eZLvFKaUlDNbPook5bxQYk3In0//CxACJG3nPg303OZV9xpvInCWBI15nYxhNx/RvuK4aoyOijE4zNLqkKwxGaidJtpVEv5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768923; c=relaxed/simple;
	bh=C7FdrotOExkG/5eyy10xgPUDVdT72B01GXJ62Fs4G10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc6acWvrZQjSAXi9gRAYHyI5phXiF3OfBQ1k9gvILfQsrkRHj1Nfd+PYVqjwOnnStwoR7bYjfLtP/jknDwIDcSeqvXiGcM63Y2fyYdvczHl3PmHlZqQ1HcXehq33pjK6M5m0y1p6OZXLB3ei4Fs7qafse2L/aNkxGMP2849ofF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmhvIIDj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so26296205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759768920; x=1760373720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1m3A2SK0UP4dwSyRm6Qf6w7bJhm1Ficb4+Tgp0EQaQ=;
        b=hmhvIIDj11XsG1lWO95MdMBx3Gx5I8dCOJXPraTTmvsRRrggmx8Z3cQ/2eEeK/dq6R
         dI086l4YLb11fuyHgc5mqYY7yLXSNRh1ugeLn672htOjDz//sGM2DZLm59miZqVqCztf
         AalJlg8l7zrGiTw75Bz4hlJTpRRddBmGQKR4k6VZTGeioMq5EFZKcMqeir/NVkNtvPTV
         ns2gKEdfcWfmRwV3BslWsl+WBMTvuxQ9lHPVoddTWtY8eZCE8G43rN3uNZhufw/kOZu5
         CyQExYDXDY63XzowI7GzXorjnhw93GZTX3HtJ+rFt18rIn6yP2LD9ivA4m1rIXVRIB8E
         Gf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759768920; x=1760373720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1m3A2SK0UP4dwSyRm6Qf6w7bJhm1Ficb4+Tgp0EQaQ=;
        b=pEouNy7jk7Qi0dijRFWpd3zjmafHkT3fjgHLuqN/9jX018h3+RZH+rssceZ+AuQRbH
         at7HwSsEHAuIwHBLUT3VjNqPy+VTVvIG0d5dGtrdMPuX44hEUraYNu1gZj6hEfj8BECM
         RJr+nM+5PdwdeMgg1H6VLl2URdl+EIVSn0Ynoo+Gs3kpWfZFx91f5D7iWD0vsWOp3eMA
         dz0oRWhiQT9efV9zXO1bmB8bgjJcHl92yhZeyyhFPgFzIVczY+OWZ4FtwK0keZ4p+fjS
         UeSl8ovO/6oVaFX6TIQl571hQHXvfetABsXJiZa5psnJq6f7OsKnmZvTun736XN5zd15
         QYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXOApd6ytgd7KeBsbb4Cv+kxn2DsK75bF8i+nwB/WOQ0jCxzIJqxSFYN+xDteTcPdvN5JGy7Yp0R8uzCNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNUBZ7+4xXA+UJrSLO1UGU8Gp1HOzLyllXNkg7bvIuWiKJwz4
	Bsj4Gkqacbh6wwImIwuOk/B1WriOoWmSm65SuWmR10s3YIboxqLzIoQj
X-Gm-Gg: ASbGncu0o36EAcO+9PKFmYPKRVwGWIWjLbN23hLMg9kcVConYMRASG+G0IRJsGK6WYj
	lznvnvKG0IESRO5Ikj7BjnD4/D9Ydv0OnuONS4vETxPfv7EU4tcJ138oLrR3QKeA9zgB744rq0p
	1eXs4NStg8WnHPI8OJv9cSEq07RMCkFDHKQOcug4fIzLUzUFImBKNhxe/1+f4/MU2290WzSxEM4
	jcuW6Mkt/JW2qxKCBkHR8m6v0sSynb+FdGNIoGXBXHR9J6ZXQ0LCIVRVq7WDnnG1R7nFmaZx/QF
	SKLYAWFUHs9UHAdVw8pyR3YmRqm1hXXUL9ppgfaJn/XrD+FaYWpcH0r/83T+WJ96GcE1HqKTAHY
	z4OtG2xtxOEyeNdQVcMzKPK49+CLPPEpLQSfx8cjlC8LdK45Aj5X06WjKnc4gQcA3gqUNWjCb05
	9sxUKO2GVMk6AAcReEUVUPztoG
X-Google-Smtp-Source: AGHT+IHm3Tu9iRyGiCt6V9SEZWDXWNqwJokz4bgw1HkknIkQ71kli9dOgCeRNWFNMzpZwV0p36UR6Q==
X-Received: by 2002:a05:600c:628b:b0:46e:456e:ada5 with SMTP id 5b1f17b1804b1-46e71146994mr75585645e9.28.1759768920064;
        Mon, 06 Oct 2025 09:42:00 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5f3015sm151246565e9.1.2025.10.06.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:41:59 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Date: Mon,  6 Oct 2025 18:41:43 +0200
Message-ID: <20251006164143.1187434-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch wraps the relevant code blocks with `IS_ENABLED(ifdef CONFIG_FB_DEVICE)`,
allowing the driver to be built and used even if CONFIG_FB_DEVICE is not selected.

The sysfs only give access to show some controller and cursor registers so
it's not needed to allow driver works correctly.

This align with Documentation/drm/todo.rst
"Remove driver dependencies on FB_DEVICE"

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Fix error and improvement , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251005173812.1169436-1-rampxxxx@gmail.com


 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index ade88e7bc760..dc99b8c9ff0f 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include "linux/kconfig.h"
 #include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -759,7 +760,7 @@ static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
 
@@ -801,7 +802,8 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
 
-	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
+	if(IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&ofdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1101,7 +1103,7 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 
 	if (par->type == BT_CARMINE)
@@ -1151,7 +1153,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	mb862xx_i2c_exit(par);
 
-	device_remove_file(&pdev->dev, &dev_attr_dispregs);
+	if(IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&pdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
-- 
2.50.1


