Return-Path: <linux-kernel+bounces-845855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B749BC6501
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0823B34C678
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC182BD5B4;
	Wed,  8 Oct 2025 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqAB52VY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148127B50F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948594; cv=none; b=nP4pKK5hAh4H2WIT2ty9iY8puHLMplwDLUyTOxHHFMEIHYWl7KpFqK8GJyI+wGh5XWytrMunwBmPw7mdkacFlo3L346QyC2vRYFNBHZKmKhfpcGneW7S7S8LZH+HHJ6rD1urPz/VNqEfqzKW16Tq/wipf24qJkxupz3U/+RRgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948594; c=relaxed/simple;
	bh=TbhdRPExR52xBVb5XUSrHLPhu33n97/eTTgshWJPXH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4MEWnykRnAERD9F4O6uckSHa3MrrLaVRWhGcDTn2GkOXni7G6kZu9VZFgCww2SqsYalWDvzPidis8vBsAdtBdZ7bT23nxiXRb++sF3WA9ROMB9Ft9Q3FrYhc8Cozaav9KGm/jCPu3GRBtW6YO1OV8TowuxmkqRHmfto8CNqj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqAB52VY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso1002465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759948591; x=1760553391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXl25NV/bCKQtXQE+8UoQ32n8mgGUsnabyuLmYWSLFM=;
        b=OqAB52VYLzFAl3wTIKxU1mmcD5YGezU9o8+CUA7SqbidnyDiJZ3FkTRthSgsnL3ohZ
         KmEt7j09N5ZCYdPBSfCLCB4s1sIox5xWGNun1a1BU4t/HhaR+IDi6YrtXrC2+V4uwQWh
         gx7SKq4KDF5JQuKxgvnesqexbdFCxChKeyXv4SpyiVX5NwFt8r5irFRKmfGsjfYmRGIq
         gE3kQ/zqkEMZCA9JJixnsJX0WN49RzNIIIZeBErbx/ynABy1NoT9EhopcKb3BgewrRY6
         fzv4eEtFgcXcE2z0hBsNvvIhtacE4jEJmMMHpzfSP0djDubon+JWpeV5MWSGSXX1HR8x
         7zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948591; x=1760553391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXl25NV/bCKQtXQE+8UoQ32n8mgGUsnabyuLmYWSLFM=;
        b=buvccZhV37Ho7kH8xhKhOzOP+mpsVM8OCEsPoPhp8YvrV4BTzNi4f/pDfPEpJ4hpwh
         Ps9erf940I5suuv9blYEfPQCuwAIxS02TP2PjFkAUfIx8GAw75d1D4yegcJ4coXtT78t
         3p/LHI+qTQ4oohA88tNlFazTMs0RW10xrfvQ9CQATAq0fGWe3maKQ9buOFRRpmsLcytv
         P0+bmXOwXefWeRu252Fv8KbHoz6eSU7uA5GsGm7aQPKeEBw60bJpGtC1jIIL6KZccOHu
         RkRc2r8CwTLRFtsQEINygW2O11lQyzg7xTJvMsvCLH8s8ytKUWkVHHprPD2T/xEppnpc
         2e+w==
X-Forwarded-Encrypted: i=1; AJvYcCV+RKoidhYMXbu228TqwsXkiQ+YBLR+HYSS3/6N+HVfU9qSak0sbDjzs2jZ+uAb7FjZha6p7zrWbUoslcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEvAYqAjV8yvpINnVDsAWuh3Ju59/djNRmbKYorW9+EqcG6qM
	3wQr56kKc+d+vSmAjpm7sTX0GDcaBjTi63PL5fWgftsZj3Oqc5IKoppZ
X-Gm-Gg: ASbGncudiKMCEMlOz+YvlR/QGJZzjijmm5/ctIxDZ84H/mZn+KEZT9XZLw2ca1RH+SV
	8G/4pjcJd3LNYjWuWZKA4TKZZmRqRQzE6iJbvhNQZy8kMJzROyWF8ug7EHbc2ulIdSlPauhW1zE
	TGTdoM3FZGRaiTMmbrfWQJcONsTD1MQcmXihkveJVzOWFdKj5rPnmT9hH+gBFSIdRQkDFp++fHG
	pWrzb2T03m5I97S5V9D1LesT7wHoHdwcUI4QAHsxmuhyHXudG3cO6EIb4c1H4kvggO9a4TFXlhs
	yIWnyp8mGOl/75o3MP3xg+JIyBl8XXHyLReS6y0UFuCkBQfFh8LNlLr05zsPGIJ9rms9ioanFpt
	aDER8ixKKf22rrgz9poODQEisNW5Do+2aJ+bqahHBmp422uxZrrdZEvOnMjUTyDp+/Fn46Grlao
	EJxXE=
X-Google-Smtp-Source: AGHT+IHMaf049Vy0bK5HqZ7v24YZjjYWkYmfKtcVF11hqH5XCAA615OXjCUg7WY+wO3hElGgf+q6Og==
X-Received: by 2002:a05:600c:1e87:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-46fa9a22e8cmr29602565e9.0.1759948590639;
        Wed, 08 Oct 2025 11:36:30 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab5250ddsm18839465e9.6.2025.10.08.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:36:30 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	tzimmermann@suse.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v3] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Date: Wed,  8 Oct 2025 20:36:27 +0200
Message-ID: <20251008183627.1279115-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251006164143.1187434-1-rampxxxx@gmail.com>
References: <20251006164143.1187434-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch wraps the relevant code blocks with `IS_ENABLED(CONFIG_FB_DEVICE)`.

Allows the driver to be used for framebuffer text console, even if
support for the /dev/fb device isn't compiled-in (CONFIG_FB_DEVICE=n).

This align with Documentation/drm/todo.rst
"Remove driver dependencies on FB_DEVICE"

I've not the card so I was not able to test it.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v2 -> v3:
      * Change commit msg , thanks Helge Deller.
      * Delete not used include , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251006164143.1187434-1-rampxxxx@gmail.com/
v1 -> v2:
      * Fix error and improvement , thanks Uwe Kleine-Koenig.
      * v1 https://lore.kernel.org/lkml/20251005173812.1169436-1-rampxxxx@gmail.com

 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index ade88e7bc760..3f79dfc27a53 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -759,7 +759,7 @@ static int of_platform_mb862xx_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 	return 0;
 
@@ -801,7 +801,8 @@ static void of_platform_mb862xx_remove(struct platform_device *ofdev)
 	free_irq(par->irq, (void *)par);
 	irq_dispose_mapping(par->irq);
 
-	device_remove_file(&ofdev->dev, &dev_attr_dispregs);
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&ofdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
@@ -1101,7 +1102,7 @@ static int mb862xx_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, info);
 
-	if (device_create_file(dev, &dev_attr_dispregs))
+	if (IS_ENABLED(CONFIG_FB_DEVICE) && device_create_file(dev, &dev_attr_dispregs))
 		dev_err(dev, "Can't create sysfs regdump file\n");
 
 	if (par->type == BT_CARMINE)
@@ -1151,7 +1152,8 @@ static void mb862xx_pci_remove(struct pci_dev *pdev)
 
 	mb862xx_i2c_exit(par);
 
-	device_remove_file(&pdev->dev, &dev_attr_dispregs);
+	if (IS_ENABLED(CONFIG_FB_DEVICE))
+		device_remove_file(&pdev->dev, &dev_attr_dispregs);
 
 	unregister_framebuffer(fbi);
 	fb_dealloc_cmap(&fbi->cmap);
-- 
2.50.1


