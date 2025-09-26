Return-Path: <linux-kernel+bounces-834279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F8BA4530
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56244A6124
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315D1F4198;
	Fri, 26 Sep 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEw7wFL8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E051F0995
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898828; cv=none; b=r/sjQq86ssYv551ro9q1lTRPEv0B6geomz3q41rClPaLQeJ/IkFVWu2R2CinVna54MH+KiFvgtjS0Pc9v7KAAwJowEeQUnKs8ycCT0SxZabsXxjHrllPi9UXLTw2grj3a6Vw0aCUtnOgCtCLdkaqYC1jPsLEJP6ljds44rglxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898828; c=relaxed/simple;
	bh=9H4Iy5ZQioUbGAt3cq2QPsffBJRpfU6SmMhpX/U27b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAHB4eR8CyVOksLK6WYDpBaWpFQzAH3zQ8jOdnpQFAq+nTSQX5Cai1TUUgNslPXU/yLijJh8AGegJr+G4a+mMV0H/B2BTu2UJ0v356dZM14HcCDncuI2YXzGIt6eSS25eiVO35ZIu1/Mcgt07q9jbju/LFogVKGx6SGQApkZ69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEw7wFL8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761b83fd01so2314439b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898825; x=1759503625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6D/jsLcW0Gr7inyVqcSEs7jW1/FD06YYHLSEbTVz1zU=;
        b=cEw7wFL8+2j4xMfQ+E1CC3IDiOrfisilPHMZqnPAPxqD69kmWohV/If8RXAzMF5QgA
         2Rpt1p+A2ikL5Bs3BpRongP0FYAY+106iaJ3FjU2IzXtamS9o7qOet2I4q7+21YLsocr
         0nxcORBC0op0p/k5dBphwLg9PNFQ8I/kodwKZohlNoWz4GWiDgZBPH3jxejfGN78QBvH
         +BLgs3opXYD9qi9CBpI+W25pF9aVyFTDnkP3cIxCayBFi3m9SQuWmkdU1ukgBkFLF2ns
         MWSkS3kcJTRJDz+fDeZ3cYPD+61xIRAaODYkYM7EPodNvMctxxw2stVitD83aRt/sQdU
         UgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898825; x=1759503625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D/jsLcW0Gr7inyVqcSEs7jW1/FD06YYHLSEbTVz1zU=;
        b=m5KDcAOdCrWOe1sGNnzgUwOakiSp66Tna2Oe3vVJd4tkez6RwqHKUMNjdSIZJ3Q9tQ
         31CLnK+rUrnr8ZbTJp0/z0g2pbni+1E0zMqqkWTaxHgA+Rts2/kL2u0KoXUh2MZmT/sD
         DIVznOHIxllwBwm1G/iTQKouZHeXS3aCAG5OM9PCPBv8dtXit6HesxMIhVxLpJINZwxX
         K2GaET5l1uP41nmRu/jildNEnegSckzAsznRdrfa5V8HxIX0O1IyELVHtO7ZYM0Zs6/P
         1lwmVl+FwqNJaTyAJNiBo7/tSJdi0zSDLcs1+5OxDFVFUBKodsLIrPpyXoQgnfxeD9Ak
         hOQw==
X-Forwarded-Encrypted: i=1; AJvYcCUWJjjsyo+7z7B43BL5/83tJZNz9e1FBD1Kka8oXG/Ah2Q+TvfP41IqAWwoyjZRxzSWgxecp9hw4kiX0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTdL88uYvihqLbrkwsGJu7THeqGi8tMFWFhDNrphV6o/0+/3I
	rZSPE4piyNvhhBpAkdJxvAQm3hIvCWtC+qsbYv90f4SWsTXHYbcWHGff
X-Gm-Gg: ASbGncsIysh7p5yzwvjwoVTjEcpLWFHpfY28pauJUxlhmnWCSon8t+Jp11D9WC5rSp6
	6bxt1oD0l34c2XPuaBtBcYCXpPoKQMQrpKxr7krFRnj9Dz5JWMYGBg4WOvm+z56ThosDsvH2AsC
	l5IkUWMVhdVYVn6LUuC00sSOpr8fK/JYoycd2g03OboEW2G1pfyulLRsuhq+dcp5x/6kwGTw0Mp
	ovhNcGPQYKPh01WAT81PQHCNhyxe+Dtdq8HHMoN78vowSg7UhK/+FT2R+bBeCZ4yLr1ZJAHeCkl
	mzzSl0ox4sdQhdugWNvz8eyB//btewRNU58ve1K+5giBP7Bo4ZeclkdzrjKKzJy46wqVyJDnW6s
	Q2YCpW/thWf4mwn16mlovJPPKnSv971cKE/bJVSo=
X-Google-Smtp-Source: AGHT+IE+iWzUhddIAroqnNSYAnKwkrlMRDpTbw935pYA9Du0mnB7k0yS2TSf6oe63ECHy0yPKHl+DA==
X-Received: by 2002:a05:6a00:2d06:b0:772:301a:fbb6 with SMTP id d2e1a72fcca58-780fcea2dc8mr7639643b3a.19.1758898824647;
        Fri, 26 Sep 2025 08:00:24 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06af6sm4586044b3a.88.2025.09.26.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:00:23 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Subject: [PATCH v3] HID: cp2112: Add parameter validation to data length
Date: Fri, 26 Sep 2025 20:28:11 +0530
Message-ID: <20250926145811.273174-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a stack OOB access in cp2112_write_req caused by lack
of parameter validation for the user input in I2C SMBUS ioctl in cp2112
driver

Add the parameter validation for the data->block[0] to be bounded by
I2C_SMBUS_BLOCK_MAX + the additional compatibility padding

Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
Tested-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
v3:
 - Fix the commit message to not include the changelog

v2:
 - Get rid of magic numbers
 - Improve the bounds check

v1:
 - Add bound checks on the input parameters at the driver

 drivers/hid/hid-cp2112.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 482f62a78c41..13dcd2470d92 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -689,7 +689,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 			count = cp2112_write_read_req(buf, addr, read_length,
 						      command, NULL, 0);
 		} else {
-			count = cp2112_write_req(buf, addr, command,
+			/* Copy starts from data->block[1] so the length can
+			 * be at max I2C_SMBUS_CLOCK_MAX + 1
+			 */
+			
+			if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
+				count = -EINVAL;
+			else
+				count = cp2112_write_req(buf, addr, command,
 						 data->block + 1,
 						 data->block[0]);
 		}
@@ -700,7 +707,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 						      I2C_SMBUS_BLOCK_MAX,
 						      command, NULL, 0);
 		} else {
-			count = cp2112_write_req(buf, addr, command,
+			/* data_length here is data->block[0] + 1
+			 * so make sure that the data->block[0] is
+			 * less than or equals I2C_SMBUS_BLOCK_MAX + 1
+			*/
+			if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
+				count = -EINVAL;
+			else
+				count = cp2112_write_req(buf, addr, command,
 						 data->block,
 						 data->block[0] + 1);
 		}
@@ -709,7 +723,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		size = I2C_SMBUS_BLOCK_DATA;
 		read_write = I2C_SMBUS_READ;
 
-		count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
+		/* data_length is data->block[0] + 1, so 
+		 * so data->block[0] should be less than or
+		 * equal to the I2C_SMBUS_BLOCK_MAX + 1
+		*/
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
+			count = -EINVAL;
+		else
+			count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
 					      command, data->block,
 					      data->block[0] + 1);
 		break;
-- 
2.51.0


