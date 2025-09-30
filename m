Return-Path: <linux-kernel+bounces-837361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884DBAC217
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BCA1920665
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE462F49F8;
	Tue, 30 Sep 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRyzqPCL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829382D7DDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222155; cv=none; b=GgTr5jwFhqk6NCj8eJZrdRVzxhKsn8Ria7wkVDVaZLTno2w1m+w8U3mGM+PliZu91I27JygxF+j5XKUm4khijLq+JO7m9+lX3b7vMfHnR5ohBhJfoz9wcALaNri+JyxcDVaZePf94lhRnUq77nHJ8HY6vPKtbw3otuVeNs8stXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222155; c=relaxed/simple;
	bh=FaBjq+b096JR3LdKULnMiCshllEkboYo4jX4SHLBShU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QUigyTyoncSxTGpZHjdt4Pz9D2gxu5Fjv0PFFJVb/YkxizLAypDevNWmSo97YfQm0XuHF2qJFTtR0WN2j52bk6XPzi4ZeSOSoIVKbfLy/hY5MBX4wCqTp4I8GlRexae+OoRHFQw8O6e1VxXnK9nzYaJuUAFUtP1WGcukbEyA9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRyzqPCL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78125ed4052so3954014b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222152; x=1759826952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNx5UNuWQA/zkctg0q6HtsfqKmsRWnVIXyFIJxaX1Ro=;
        b=SRyzqPCLlVX2tnaEhDXJj8j0zBSe8aj4cQBz/RiyhFhgQTZmSnAeYkAIN5YQdXgJCd
         tONuV7VDGke9GRE16Dy1WGhEs3q470nEG14QDtoQJhQU0WDue6K0INWT/31Ec98CA0ki
         1MV1rKSAUpqCMgW45ftOG6uyzPIWUatN3STKG7GAxOdRMkjsaXfkov+U4xNYEUPM0jeC
         GSodKLX+FOOOGnHOEfMyVPMxMrXvmYBRN9jndQzqmP6ZJEWVX9CeoM+u2+v/ITNeoYxW
         +FrrTJe4O6gEdZd3xh+y4e/pNjdf+G4J1JAoQmsCjRLXJFEk52prSiKfw8+VmiUnHi/3
         V/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222152; x=1759826952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNx5UNuWQA/zkctg0q6HtsfqKmsRWnVIXyFIJxaX1Ro=;
        b=ljaFtXER0bIlbJ3qQgWjVQgxoulxcx4GViRunU8Ru1l16UuHgjhQ7HPKs0B1bjJPhh
         8bCTaS6M5NioStzcT+fCjbep/ZoLN7f6WttoZlqxopE2rRBWgJbLo3BMEz4dYIZQd94J
         nRZFNq76t2GRte7pYfbNjTTbmwV1T4vZopXoFohF1wXR0eeCzgYQRFZxVjfY26i+mTiL
         QMmmG/cxlDRMtBCgwUD3sLYKkalxjmbfevUs4qVlpvmlC/OhTsAU9wThHcDO5ZxR6pgm
         9zsuaVl9G3ARzSGxkLTHPL6W82+tBmAy2MH745alTZHHSkZRvVdH34+bmkI4ujSsXKG+
         8HhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Y9yVhJOwtYuVfBuan14ekC7rDZEXf50OFBf/Ejq+Z4WK52f49gg0HUlgwH3Pak4j5TwWPVxJ0VLUM78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNw+kmLT2jEQlVGds8vfOemy5tY4f8k21rzeVL/+UL1IPF07t
	MKCp/OWtrwIXbdHkOXRRx/1/oq5RNbs6xw0pg8iOhuU6piTVnAuAei5E
X-Gm-Gg: ASbGncvYqHqkqyZRq6rs1Kk03s6kosaT52li7AoNAtZKPXbBL2JqwAKuIp7G4Pv0Z88
	QgeK9LVpuOSdkPCLt4T3HvqRafJa1gqoOjY6zSfbRy6QDH5RR/9qNCF3hhsAechngNhaZ5wto2G
	iVXafrJW4yqj83nX40V4DfJguN9/VaTsACPJKV/VsNI+QKLthS5j0uwIM0IQW2upOe+2VGaToVl
	eJhRl1sEAef1nSXkbxLRBOVXEedJlCP4f1C3tUQt775UHdkLqjM51SjYo9IVVdwBI08WUFf+HN4
	TdI5+0eTWO6V7lKXvWaaD3LN2e1h7XZxgvebtUN4SaplBpwd3V68xJBZVD6EaB65P7/Jq7od9N4
	4wc+iavZpuzxGGazgugf3+mumIJV/CO3jy5tdzcEEMnxyDOy7DWWe6lJqUh+61Cs2iJEu1zA/97
	9Dx4GRTAITEA==
X-Google-Smtp-Source: AGHT+IE30L2/jMrX7//iknNI4i/8WYK8VmjjjICdaX47Vb7tDhZeTRtCGU+Y0joFglyA+Qss2C08tQ==
X-Received: by 2002:a05:6a00:4fcb:b0:781:2271:50df with SMTP id d2e1a72fcca58-781227153f2mr13698060b3a.19.1759222151659;
        Tue, 30 Sep 2025 01:49:11 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.102.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06e72sm12894187b3a.83.2025.09.30.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:49:11 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhanuseshukumar@gmail.com,
	syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Date: Tue, 30 Sep 2025 14:19:02 +0530
Message-Id: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported read of uninitialized variable BUG with following call stack.

lan78xx 8-1:1.0 (unnamed net_device) (uninitialized): EEPROM read operation timeout
=====================================================
BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
 lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707

Local variable sig.i.i created at:
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1092 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x77e/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766

The function lan78xx_read_raw_eeprom failed to properly propagate EEPROM
read timeout errors (-ETIMEDOUT). In the fallthrough path, it first
attempted to restore the pin configuration for LED outputs and then
returned only the status of that restore operation, discarding the
original timeout error.

As a result, callers could mistakenly treat the data buffer as valid
even though the EEPROM read had actually timed out with no data or partial
data.

To fix this, handle errors in restoring the LED pin configuration separately.
If the restore succeeds, return any prior EEPROM timeout error correctly
to the caller.

Reported-by: syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9
Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: The patch is compiled and tested using EVB-LAN7800LC.
 The Sysbot doesn't have C reproducer to get the patch tested by sysbot.

 drivers/net/usb/lan78xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1ff25f57329a..d75502ebbc0d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1079,10 +1079,13 @@ static int lan78xx_read_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	}
 
 read_raw_eeprom_done:
-	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		return lan78xx_write_reg(dev, HW_CFG, saved);
-
-	return 0;
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
+		/* If USB fails, there is nothing to do */
+		if (rc < 0)
+			return rc;
+	}
+	return ret;
 }
 
 static int lan78xx_read_eeprom(struct lan78xx_net *dev, u32 offset,
-- 
2.34.1


