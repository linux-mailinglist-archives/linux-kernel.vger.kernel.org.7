Return-Path: <linux-kernel+bounces-870267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13BC0A534
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 782F54E286C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB028851F;
	Sun, 26 Oct 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNoXStkk"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625B24C06A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469757; cv=none; b=OuGe0yANnNGalSb5GB42Tics5PgK9WhM+sX4kZdCSzhjbQqgCvAmjr7yUYd+8gKNpRfdObrpl/fcgAGM8JOuh7NQY1YYqHge4lQjCHBOR9FA1kUVQGKxc8n0o1w/RI9taZkLoG6IQVe1HUoKCFCLLquSwzl2dbKfustKkzijB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469757; c=relaxed/simple;
	bh=rhvUQQ1aDLIgY9l5Xbthj+I3M2mzo0BNAfDOxjdvxS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owr3ZZWeqTTTCvh0dzVBSyNAC6hRnU0uE2Ti2jHe5c7JtoY2aWRJ8pBvlLO4KJnRwyMpQMEuv8KLDPaI7FVEIUbrnth/lIMIfiS8lcDnSZ5gsVyZE03ILnujE23RwBORkVL6C8JTEXCGJKFETO4iCW3YEhFzc9vTc4QTfnef+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNoXStkk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b553412a19bso2284913a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469755; x=1762074555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDgBxVdEbTdr5iOqBlPvDWxYT4j0U5j6kRWBLPDFwas=;
        b=QNoXStkkgsY4pho1HMXuuLiPrtSIgXcbhdyz+4isjbnNhpi5t9B5RgxKgvbfRYNeVM
         LDsLBzSblXbY/Dsu5nC+ZMubDVj0T7Qb+lGWBDYQ5PI85GTkmMUbDxriWiXzNhXNqgRh
         A5uBA6fRENpD1Mg1zVGCnXnC2lJJzNvFVxFhv7d7TdY5O9pTWhLM94XH0UvmNXSgYk9E
         OYIDgstyJAQTy+ydE+0X5mqTyPad65KYyWdS37oZ6AVLlACSGfXfbjc0qa7a2SB0b4DH
         OFeAz5pCLGs5Yhf72nv/y3A3qFXbEYzCEJiVi0XaBGXnEWIUHPrHburyyAmstanfLOt+
         Ircw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469755; x=1762074555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDgBxVdEbTdr5iOqBlPvDWxYT4j0U5j6kRWBLPDFwas=;
        b=RRdBijAmFNdEt6PyBR9nLGyQ4KZIqM11ivZAZdBrO+8Rrptq84bPf7Qpc4JU80rY4k
         E8fQlJ1uLcT7iiKbxdiMlkHrYVkjznt6X8yhGQULDpY0c07LUu9TDdDpgyBvBUCDZzFR
         yOYkW3WBAHSDB0UGbl+bj04Hf5reJX8u6NUqWv7K5xU2sPlFGC4/U/5pZYTbCBuIoAK+
         toVv78HJ6ol5HWwzwZIARFmx0GEwEM7Udm0kSpEromZeVwOIy6oI5AiCaPtCTxHBZaka
         vRpDuUUXjqzEpmV9Kz60pYI58uyVswq2Y6k6Ul/RZirX7K2h87iNf0lFGOgvDnfjUWNq
         yYRA==
X-Forwarded-Encrypted: i=1; AJvYcCXD+SxKqasbF+CCFkehimCF1LfkVmcLiib1X7XQy5tArJyCkHv+znHVOgbDAWSl3JMIOpR137+5PyX71vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbVKVQUdpL1C5P5HZEnNEpvAN8GBk8VTQuAmWf88AELh64dJx
	ohP10yJK3GnyY+qhpJDpUe3riEsdH9wbpL1OrOMP1gC0u3bsHMggYCVk
X-Gm-Gg: ASbGnctMd3ct9YJKiN8hyjvenMOLNb4H16IF7p8FtYYqO1IbWIuOpTwkKyuvgCbGeu2
	u/tGmp06BADLOUvrAsMqx8RvSCAjJISZp6i9lLCBdWV5jw73puf6gMnZ5Z9+AsEgiYNwOwpGV8q
	psFxom3mVzlucjXdcJLknGImpRfgFEqA+RU4WZvtqq4OHuYlDMBNIYWoTcTnwWLP9qZ/N7FsHZ5
	zMYNoFRdGj6h8lxbbn4rw0TNfYDM4c/Wje3hFfsVk7ho9as6vgXqvF+RVNuN/0WEqjw3fir5PGv
	1icyAE4+Vo209Xvi6+JKUgx0ZeG0SahrypkMzizHaSofDbSq7xaTPGL8cMluAHt5AO64c5HtOLc
	vHmyhbhFwkT+Mj3y+HMw9JkQLHM3LpuVsviMHOsq6ef4FAimJjFozKhXLzfOdR8vJB2nzIn+0SJ
	pSe1IrVy9TgitUOtfB0S5Cew==
X-Google-Smtp-Source: AGHT+IHoQyB3vduskRb0VU1yRtEZxt+TCgaYNmvXlhRvC3wwf/9MqRK9WnjLi1uyYkvh8yX+068xAw==
X-Received: by 2002:a17:902:d512:b0:290:9ebf:211b with SMTP id d9443c01a7336-2948ba3d94emr87342155ad.40.1761469755256;
        Sun, 26 Oct 2025 02:09:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d230basm45238555ad.46.2025.10.26.02.09.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:09:14 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: Fix double resource release in cdns3_pci_probe
Date: Sun, 26 Oct 2025 17:08:59 +0800
Message-Id: <20251026090859.33107-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses pcim_enable_device() to enable the PCI device,
the device will be automatically disabled on driver detach through
the managed device framework. The manual pci_disable_device() calls
in the error paths are therefore redundant and should be removed.

Found via static anlaysis and this is similar to commit 99ca0b57e49f
("thermal: intel: int340x: processor: Fix warning during module unload").

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 3b3b3dc75f35..57f57c24c663 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -98,10 +98,8 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		wrap = pci_get_drvdata(func);
 	} else {
 		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
-		if (!wrap) {
-			pci_disable_device(pdev);
+		if (!wrap)
 			return -ENOMEM;
-		}
 	}
 
 	res = wrap->dev_res;
@@ -160,7 +158,6 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		/* register platform device */
 		wrap->plat_dev = platform_device_register_full(&plat_info);
 		if (IS_ERR(wrap->plat_dev)) {
-			pci_disable_device(pdev);
 			err = PTR_ERR(wrap->plat_dev);
 			kfree(wrap);
 			return err;
-- 
2.39.5 (Apple Git-154)


