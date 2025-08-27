Return-Path: <linux-kernel+bounces-788084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC9B37F88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873731B26B40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873BB279324;
	Wed, 27 Aug 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qwkqNK0C"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D99346A16
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289451; cv=none; b=GsGNh+9AbMkUob5JppZ2eyAlDkafjO7yd89ld/XFZskY9djI1csAuX7kAzjIltrnc8fLo4w4m6R/2kIkZTXVtqs9LkbfPYSJngcrQVQg3IbLJ5woZlDdIVxBzYHcsp7zBlZdh813vVSsOmPG8lZ2OYU1k7XmFSxeVAxsyu0WovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289451; c=relaxed/simple;
	bh=b5ipVQxirQj5gbkgpSFwLTpHWhEQ1wqtWZ0y9AiGGTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGWLh72hr5ixOprWltO3Wx/kR1FlaaXe+DaZ2MtuMWmEIzKevH3upuy3d23KP2pqxP3omwCvAvn20708NqoGLjVeYvO3oM92cRfv4nrfBcyisaS1/oAJUUdzuixOMsi3ZD9Gl4Gk0XV+L+b2JXbJ0CgJmCyxNOtXerT6odCcpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qwkqNK0C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b5c12dd87so31577145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289447; x=1756894247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TixQBgvEKkMQhE5xKVPB13TcCphpl84uFDbTL0vLvUw=;
        b=qwkqNK0CGVHu5LJ6HmobzJPrLwyDepRPvHxGHEz+vZcNXz1ns4diuGwvwOAuGQuHLo
         V2B16wMdj6owhnmv8X/n2pWX4ro5fUfdNlzD8wmwR9+oO2Rpz9l6tXXFw/CD4SUY3N0c
         qeroIlNTUeWZklENJzTObL4izmjBkEc8SnBkCtMJTSPG+NkNp38DiyhXCgkbXOqKW9KI
         G/6HvSOtYoXZPkMT0Zt2d7P2YFi6tj8P/JCxGsHb//yQhtPTD9adY46UJaBjLLoZMf71
         pTpH62eMCYQa5TdA+E3SFWdYWtr+bWROI7gezktWL32VdN5qZdmlPB+nToYg7U3oYJlB
         rj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289447; x=1756894247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TixQBgvEKkMQhE5xKVPB13TcCphpl84uFDbTL0vLvUw=;
        b=oYHrDNb8Zs+Vw3ZFIYY+RpF3PODzOMod7COxBIavw+aH7EWZYeCIAkN2ZwEDrDtzJD
         yEPRUJ4IChd3OMRT3clDdhfvDf7qs+ui8yEQo/wwRH5jOxXtfToaTdLzB7yEiVlsjKDi
         561bGscgZe9WXqhZLeg1szP0j4WIqUiHHpgjYSnh/EmoC+spAN+7VEZzG3asKSzRJuuK
         m39k1K5k76+KCou5EGhFCXeYXIgww/CBoQepnz/UTTHU5FU3T/ibU3ojffGIVWx5wuR6
         hmtg98FKWqAxV7vQnUi8oKMo3UyBpi/NbDTa049jLBp6bSXpd4KEFFCinalvKbkPCfdx
         rIVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCJ42RR8tMT4TfrZXHsENT4/mfXvgIlXA0ph/W8d4tEtjQFM2Phmlnt1vDA+IcG9vkJBQVHZ3u8sCMlAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wU89SEAWzJYfm5b3JOmiWfqDCa0zUgoImqU9wc8y/zh40K3f
	/JFnrcTLlVsc6zCvyNqAZJhh2Z9Ft75I9LYu1JoPGDg4+k5ONfHKaPYsVwztUDf7hsU=
X-Gm-Gg: ASbGncueJECuJ9omI1oLVJdeU+13eJ5bjBR1aheLbGFOJ5BsgwvrdgI3oMHJUMeJiBy
	zMiaHSpo3SuNTa4mjBHTBDcuRC7quH+ip3sa4y2g/4PK/7a5Nu2hHddJZmtZ5YAYhroRq9sFAvu
	JkGXuJrjsMiOUz3V6XvNQZNMdmaSrxl4PYrQRg95BnhNN8gKfZfb1+iYcINhwSBo1AY19F+ibpd
	fP9pahTAUB60iIb+BLBsdCPEIFtocu+5P8kqJ2G0In687qiQ54/POG6EKzXQCTI6yWkjssqLaRA
	L/bhPWAbGLHRnWt2ocmp/K3ALogiDoHm6U1TVZaGYxptBuICuGcONuhPSDV1kpLf+CAilH79gpJ
	H6ZuCPDqU89wMBOFE9xv4iMXEDUTiUp4Lq4h4J0dagoZhPV041/DKGgY5fzeQrEfoZelIpJOzcC
	kiNNNZt+MaIhST38vV
X-Google-Smtp-Source: AGHT+IETY/no0Ga/lWTRqVqc1LC0xGTolfQ/830wBvuN1CYFKv7YIKqdD72VfxqDZ91vijfk3xVUFA==
X-Received: by 2002:a05:600c:4f09:b0:45b:6163:c031 with SMTP id 5b1f17b1804b1-45b627826c3mr94650675e9.24.1756289447382;
        Wed, 27 Aug 2025 03:10:47 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f2ebc62sm24589465e9.24.2025.08.27.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:10:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] i2c: core: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:10:42 +0300
Message-ID: <20250827101042.927030-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ecca8c006b02..ae7e9c8b65a6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -573,7 +573,8 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
+				      (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -581,7 +582,7 @@ static int i2c_device_probe(struct device *dev)
 						    GFP_KERNEL);
 	if (!client->devres_group_id) {
 		status = -ENOMEM;
-		goto err_detach_pm_domain;
+		goto err_clear_wakeup_irq;
 	}
 
 	client->debugfs = debugfs_create_dir(dev_name(&client->dev),
@@ -608,8 +609,6 @@ static int i2c_device_probe(struct device *dev)
 err_release_driver_resources:
 	debugfs_remove_recursive(client->debugfs);
 	devres_release_group(&client->dev, client->devres_group_id);
-err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, do_power_on);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -636,8 +635,6 @@ static void i2c_device_remove(struct device *dev)
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
-	dev_pm_domain_detach(&client->dev, true);
-
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-- 
2.43.0


