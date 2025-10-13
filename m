Return-Path: <linux-kernel+bounces-851171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4EDBD5AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 159C14F1B01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD22D7DEE;
	Mon, 13 Oct 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6+FqQVN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32822D73BE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379451; cv=none; b=PEHv9iBpBagkbXifX7l107A9kVrkCM3lG616EcH9FXhhc593VyjeHOEailv2Z7f+10xzAYKLVOVuTk3mwOxVX+Qy2oOzyugvZEmj2qvU72REqUuwoESswDUvRMuOBTxGhdIKMi/aNuKK/pjoOQXDE3UfmmnVhocvAHLbqZh84oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379451; c=relaxed/simple;
	bh=lTRDsCs/D5gFRcFqRPKy43626K0S1gYzb3FNCfR30zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dzmi0PDe83Dz61DpbF2H0VrvLnZmJulh/dkAvd9aYJq5zG33rTXQAo3THqIsv/kY7+bqZKdB6EdRSMeT0LaMFzmdgv8RFg+ViEUUiSsORjBHhrCQACY1QfPLsBnY2wBdde9A4dTSnpPdv63zs2PL75T8acFsxmPFa0jj6sCR0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6+FqQVN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eec33b737so67937215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760379449; x=1760984249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DINigu/lDIdPD/xwaJPV5YAdp8XbvaeBDX23woL7nKQ=;
        b=L6+FqQVNS0oFT9ozdBBWP7pdTaj4G3KCHy18nimmIHLGNnxTmdeVG22/16kkjGCIu8
         K+TGQgR+rrAY9MhTjFXTFjgzIPipWHMEeKMqCicF+RgbrP6gSRygqknUyj4XbIgtjBKD
         QlxjlLCQQxrqfjnjF8GJ3tYYg7NrLzQw55Vft1qQkb/Ez095yVQVGu56x1WSdWlbwsLF
         3WMfb6niwP18M4t3ZMNEY4ntCHEeELqiX7Z7oTzhgOsMCbiuIDxXYzJzJOrScK9Bijsv
         TJjKjaa952davfP+32aqougTHZBT6IlZf1gQWA9qizI9fPwU+JtVvuUKyumbryw6FKhl
         IsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379449; x=1760984249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DINigu/lDIdPD/xwaJPV5YAdp8XbvaeBDX23woL7nKQ=;
        b=ZhFwVVsDR4+9IPwbSe1e6hGV7WPL3R1tUV1bhSFwS+fMLQwsMAVFWtEEmuKkv+IFNp
         Kr7JQvIp0zb+5qqmfTeHpFhqH9FUjQr4L6bJl4LRJf0PBcc2bKYtvCEO3/VwaCchJZ20
         BLHLDk3wCLXIRKP8b9dOSxoo+2N57KPZnvvTv4abmKoO9F2qzGaMUFKxnayEE7ccLLba
         xZNHxpBTgvnIpwD/yRyQMbAiqkIF/IzifeALwG/OtBY+4C12FplnIC4zttktePV3Os6+
         01fIfdAoljZ+sLrAnD9zInaco1eTzi4anr1/vLb2VZccr0cZULLY5QbGVWXOfxhTmq0E
         dasg==
X-Forwarded-Encrypted: i=1; AJvYcCXuDOa30frCijJyWQ5P+qJ0NAHMi7LPUX4gRu+HoWwr9yfj/nasnx9lb6EfcsmSPM6eiuj0Vq6YZ9DCGC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrk567wkY2uECrGDBh9yurN4j1mxTgd0fD0BXoGIa7RD/Cg8tv
	kAEmG/udXSwuED1D178Kc7R/kPpHiB1nANUqd4jU5OLbBuT6pxHThl3G
X-Gm-Gg: ASbGncuAXjUXKlxfw/B3PLn3cCcAG8ISQTby4bb8cPqJ/MLTlJGklQqIShSlu0FDlXr
	ly8lmMXcYgJM60mPYqTG+NxJBZj0zv9I9F9O3GMxFx2GFtslHFJTGqNV8z2TGvLQYSN1EzjVpon
	jDFsk+VkxzgNnDLI2vPXcD+HgipsPeDafaMpe1ccSj3atVPpDTE54LQ9NH6WwIKXSEmLxdpwCmE
	Nue0s6X/HCLpE5N2w4Mr2Pkz7HU+hansBzdPUfcVJHN2Ah1PTPT0VBb+1BMBph0iAvmdhxO80iL
	QEhW87SlzF/x+rYUVXmOeZnqqvvbFQdTC6B2Ed+3DpFkqVlf0C9twvS8W8CnT3eHar9CgZYyWDA
	dHO0guNRgnoF5uKlBGDL7CTzD7afE6HtLwsjtpaKqWgOaigJrYY+XmUCw/oMJMdGV4T6kzdjWVm
	DnPARvZgAtjL+mcNJhQDWHG/DZFtfUdE68
X-Google-Smtp-Source: AGHT+IG7x5vmQvO6Mjl28H+yolG/h8BvghF5Ba98451r81jzZMgiuy0qWbUXeKg4Zw+kpWpfF0h6HQ==
X-Received: by 2002:a17:903:2343:b0:25c:b543:2da7 with SMTP id d9443c01a7336-290272159e7mr227818555ad.9.1760379448997;
        Mon, 13 Oct 2025 11:17:28 -0700 (PDT)
Received: from debian.domain.name ([223.185.134.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm140182275ad.114.2025.10.13.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:17:28 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net v2] net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset
Date: Mon, 13 Oct 2025 23:46:48 +0530
Message-ID: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->chipid is used in lan78xx_init_mac_address before it's initialized:

lan78xx_reset() {
    lan78xx_init_mac_address()
        lan78xx_read_eeprom()
            lan78xx_read_raw_eeprom() <- dev->chipid is used here

    dev->chipid = ... <- dev->chipid is initialized correctly here
}

Reorder initialization so that dev->chipid is set before calling
lan78xx_init_mac_address().

Fixes: a0db7d10b76e ("lan78xx: Add to handle mux control per chip id")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
v1:
Link: https://lore.kernel.org/netdev/20251001131409.155650-1-viswanathiyyappan@gmail.com/

v2:
- Add Fixes tag

 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 42d35cc6b421..b4b086f86ed8 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3247,10 +3247,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	ret = lan78xx_init_mac_address(dev);
-	if (ret < 0)
-		return ret;
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -3259,6 +3255,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
+
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (ret < 0)
-- 
2.47.3


