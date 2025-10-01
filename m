Return-Path: <linux-kernel+bounces-838927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999EBB070D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D72919466BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10A2EC562;
	Wed,  1 Oct 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBSpN/gT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129F12C544
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324468; cv=none; b=mgdtKX5/jvwDwJB+0ZVZ4F37WPtbYyuJGM5bt4dw2Jjt9ihAR+f1cqGvN3E5eU4jldDltOthOnY5I6DG2nCb+znGNfFRrnRA/P8iFlFpPWKQ006Jv2OZeQ66RyrkU2jFMAHlByjcjB8mmeTpmscMCHiEZkglkpWQ/H27QQSk0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324468; c=relaxed/simple;
	bh=5o423ZijRvd8zuSTV5jup258SDTngq09c6GvYer2C1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWSHaT3HQ+rEwTOj//dG/BVA9JRuq2Ix09htSuzQUo/IMRJqCWj9618/oRQb7G7NRoEvXVjZEeZHa/AgSgvu+ZfqHAOrCMZ0aUgYhZO71/4UEYTz+m9tSXjhAInsT30X2WrI9wd/c7mSmIRglrXeG9rTRypnuioVkBBt59/tJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBSpN/gT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af9ebe337so369187b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759324465; x=1759929265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCTEJhugcYnaoj/BbhJFZS8Yru0sn+mS/h4vRBTxOWU=;
        b=ZBSpN/gTcUNQzuoRLQM2ZWMU5eEII2WEGyVZYx37w4F578Zc/2UuQ3ehmZjwcjbGad
         0d60oiOJTQOVgAmFZT84oFqRhuDbwHUTwU/rsPB+NzqHZQ8Em8r0WFCbJu911liZ9sOl
         bgU31V/KjOz6571B3RhiciyPpfqdlzS6LU06DOgHrqkcqYNANKrxM+aodu7qlqB1/btq
         Oy+AMA+RpQFPcqOUI5ElWxyI8nVo742m/GxMsijimNbtoBrx2r67AUTWq87c+6WC/Fbb
         h9W7Rd3xk84k5LN0Orm0bbDVQO0VFjccD7ndHztnaPHAi/rFzr2fLS83XHD/P9WdPbZr
         h12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324465; x=1759929265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCTEJhugcYnaoj/BbhJFZS8Yru0sn+mS/h4vRBTxOWU=;
        b=CzMvB0PFDSLI5LQ0fWlcLYUwh8+Fy2xOlXKcZiVzIx6KyCXPQShahVIhUkF3w982ZG
         pgHMvBFeVh1z+c17f9UVEtBt4odKdPeUj8IPrlpZJVXJrPJPnro00kjp2cw3KY5MUNvH
         HKXQ7mA79vVlBD+USasSzJVzNQIa+Ka4y2X0f2NNj944547YOS68kjvNfkx00Rpg8TxU
         SVZlryWhbSdVEU0JWN6/A613WOY4vebG2iWgzSP1cnBj56iq3Y3IdjcjpV4JsHi3bSQq
         dgWbogPyz2kZRRsaXH5Kb5P32PXaiZdy7bBEDOelSfseVPjb2A4HqNo455apaZm4kL6t
         Ru9A==
X-Forwarded-Encrypted: i=1; AJvYcCV27Fk3cbzdmiUkI7kfq2pH7a31ho08gXecpxmezCamUvHSC/l8fLfTZ+En9ARq8taHIeYFsFktW2un2W4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxavj5u9/KMp0b/RQM0d4rsi+Gq7Wxqj7VpFQWVzc/nvKKJA9jt
	m8XSNx/l5b/e2ZxhMoWaxtOVwWJOjNBJn+fEHhTOor2yRjqvtYRAoiek
X-Gm-Gg: ASbGncuFUqQXIzogeG1WK3q+YGtOxdrX6OQLaoCz0gKY9HY48jcg1z/8iGtvKvaOd7t
	2AohXwFejkFEUWxMu0KNX5kXFQKQbq9gBeV/0r8xSxIshwyLcLgZUJyxXoakMaajHHzky3GASys
	a/lAQUiVReyxIYOIm27kYexHNk5YrlSsj8AovAYwy+z6xDwP6+fS03NjMeHTQPwYaTDXdraEvq7
	taccVsZyb+knWBSBoTjhpPC1O+EKl8eFkQSUtq9sBlBGvN2FrFiyEbl0Z9jirZzyGvQryfECbBe
	5vGKQFJ/dFHD0WK2tLV9jasIUD4iA1Fsr2y6HHJQw7PIeu0pN2W1WhXttb8qH+iiJuwMDiKgljK
	7VEf0nTta7lh0n2zHnLmmEtR2XDvBQfoOTitAzdimgZwxhNk60F22WbFNRw02kj7OYv6lLgwE1E
	pqTQwJvW2kiW4bLRbSHMa1TSKX2m9HIRJopTAFzZdKvkNvCpY=
X-Google-Smtp-Source: AGHT+IEmzoGxhoPxh6/P3t6DmI1zkLDTL0S0tBdY+wi8AVFx9T7GOFm/8D8Q0FXSalhenNgGW0DD0A==
X-Received: by 2002:a05:6a00:98f:b0:781:1a9f:2abb with SMTP id d2e1a72fcca58-78af422e5admr4501627b3a.24.1759324464584;
        Wed, 01 Oct 2025 06:14:24 -0700 (PDT)
Received: from debian.domain.name ([223.185.128.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b231ebsm16308139b3a.52.2025.10.01.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:14:23 -0700 (PDT)
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
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net] net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset
Date: Wed,  1 Oct 2025 18:44:09 +0530
Message-ID: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
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

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
KMSAN didn't detect this issue because dev->chipid is zero
initialized from alloc_etherdev

 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1ff25f57329a..f3831ecaaec1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3238,10 +3238,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	ret = lan78xx_init_mac_address(dev);
-	if (ret < 0)
-		return ret;
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -3250,6 +3246,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
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


