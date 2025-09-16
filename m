Return-Path: <linux-kernel+bounces-817967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE6B58A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FACB2A6153
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96D519EEC2;
	Tue, 16 Sep 2025 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ5isoPc"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9F2BB13
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984210; cv=none; b=UqvrxBHWUF2F2fHj0HzM81yDiqNG89KmnLW/Tjf4cLRpbLczNERhi3+mIN5Df2kzZqG6RzWDbkcSBcCl86+LG9jYSxjj4ApaqYzJa+e8OQeVIehuGBDu/Nbkt4EIxCa7LDFvubWiHfwsqPuCTPxCTiz241UzzVTJshO9Dwa0VrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984210; c=relaxed/simple;
	bh=Qy71Ms5YFMmHBNBNOUjSdAy0OrAHc4jC5Kj1qyilACU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/L/A1g8FfuxXKOxb0sNnlv3gMLRQrDwU14gFuCtkAWG+BBQ+3nkcvzogJWKIOtqbCIUArBy22sUD0/Un1zfyNfqt969jJOtG4n7/oSdTHZj+AyuDWH3265b5Nn3Pac0Yr0VBgR6qxpAcRzmJ8ZPmTyQD7T2TA949YrKsKBdfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ5isoPc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5229007f31so3237015a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984208; x=1758589008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeqZlInGPp3SGFJdjB62EJO8F13RY/cKYxhUSIsMLkk=;
        b=cJ5isoPcANlYKlvWzR31Fs2Psy0B7Xog+os6vGPtYS1cDylkbduXb6tGRjipGgfT2N
         mXRn/9+30bvQ9RPtLU8aY2QJmUcOJGY0cZY6bCwNzQ9cMwhwahzencI7QjVdcsCJLk2D
         bLNUUJNjPTsS0tZIXRz1RRA8/ubnnIdX5ZmTrUb2NrMCi6lW3gnHUbKxQj0ZLjsV/SmU
         r1iHursjSt0DIwXG2kurdXbDEKzMjj9dy6RC7rP2EGIN5roB+3eBQsNioEkO/jUAH/CT
         IhBQofsfUDEfEpRqq9t398JJc82jVWqCojiBCb39iRb1WxK6rzD+nYwnhZlVnEiZPcxy
         fxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984208; x=1758589008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeqZlInGPp3SGFJdjB62EJO8F13RY/cKYxhUSIsMLkk=;
        b=RWmyK8l/POXR+pYFJ0Zu65D4A8odZ1MD93knT4IysIfNCwe4h9Q5760rG5aoUG1hMU
         mP21lo20OvFxtTkNFIaGnz2jOvoL+OCeV19+9oX5fx07qLdm05/TL/BVtjMNNi7v9pR+
         +EkkvcBpez1RiSxBoy9qrqIRMyhKI7oIKPU9UqofpcY2kJa56JZBgw372PcDTx44nSPr
         d6yj7rPNhUrM5f7pOCXUl3u8Y+gIopERFQuHOxW3BVgMkJ7le+0fQ+trWFOM00UQvvy7
         FJqKgnL4wyJQvMYjZVhE8mXt0UyJRS/uQhowx6Q5YDzcdQrj4pbAjA/P1CAgKHjZwK1V
         Yy0g==
X-Forwarded-Encrypted: i=1; AJvYcCUvckui/ZoyUr7Pmx6VOOg4oXGbXYZ+ugxPgLe7b/sjxwAooUwa6LEtgfxPNXvDPlxprHpTQfulYvU434c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+pms8F1eLcOhuvMIngi/ZSGcGeN2DqzbJuzeQCNzTIwpu79x
	nSCDIbneFsfxFGsD/vVVCa9LgDdN62X2+5Nw2tYWv01yQCsqcdBlVuE1
X-Gm-Gg: ASbGncu0lsOxAddgK1yJRh1wY6PeXl0FJqXSKA8XKMRei+s9l17MQ+h6ExsESS7todn
	qejs4IoSTsx1u777wU9lvyQrK8tzRz0mz7BnjE/yfhuste2PEP6c3N00rIFBMgXC5RAW4ZhPJmM
	+y96XhiGw48/iz3UFnhT0RmLHcIF2cjhjeu5u154x/xSby8xOWvBh9JgxrUNm2ckWluE7OSvLYK
	qWWoGYUKXutK6mDAKqqyfs+23xrlC2Y5ODdfgii/Ef84CPiidm4fJhzKWINpKSOomIbHbcPlIME
	g88QbzGhLf6qWV1y58qcXjwrmkLUNmlGaXHMTAhV33UXfA44UeqrSntdFQk4cBkBhzQT3WS8+MT
	dS0kgcy5fUPebCiPFFIVLeBBAUejSU+qnzDMBvXUw
X-Google-Smtp-Source: AGHT+IG8hhTJUBQOJBQwfVlneT/Gr2URBGX24fPocs1cx/+EfgjCvVldYUoFdG5SzWtoUpwFLFSGRQ==
X-Received: by 2002:a17:90b:1dce:b0:32d:d714:b3eb with SMTP id 98e67ed59e1d1-32de4e63c46mr18038247a91.4.1757984207847;
        Mon, 15 Sep 2025 17:56:47 -0700 (PDT)
Received: from cortexauth ([2401:4900:1c7b:db3a:1c7b:a123:6d26:f0bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b3603asm14142918b3a.84.2025.09.15.17.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:56:47 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Subject: [PATCH] HID: cp2112: Add parameter validation to data length
Date: Tue, 16 Sep 2025 06:24:51 +0530
Message-ID: <20250916005451.303072-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a stack OOB access in cp2112_write_req caused by lack
of parameter validation for the user input in I2C SMBUS ioctl codeflow
in the report

I2C device drivers are "responsible for checking all the parameters that
come from user-space for validity" as specified at Documentation/i2c/dev-interface

Add the parameter validation for the data->block[0] to be bounded by 32
or return EINVAL

Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 drivers/hid/hid-cp2112.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 482f62a78c41..90292ce3d363 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -689,7 +689,10 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 			count = cp2112_write_read_req(buf, addr, read_length,
 						      command, NULL, 0);
 		} else {
-			count = cp2112_write_req(buf, addr, command,
+			if (data->block[0] > 32)
+				count = -EINVAL;
+			else
+				count = cp2112_write_req(buf, addr, command,
 						 data->block + 1,
 						 data->block[0]);
 		}
@@ -700,7 +703,10 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 						      I2C_SMBUS_BLOCK_MAX,
 						      command, NULL, 0);
 		} else {
-			count = cp2112_write_req(buf, addr, command,
+			if (data->block[0] > 32)
+				count = -EINVAL;
+			else
+				count = cp2112_write_req(buf, addr, command,
 						 data->block,
 						 data->block[0] + 1);
 		}
@@ -709,7 +715,10 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
 		size = I2C_SMBUS_BLOCK_DATA;
 		read_write = I2C_SMBUS_READ;
 
-		count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
+		if (data->block[0] > 32)
+			count = -EINVAL;
+		else
+			count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
 					      command, data->block,
 					      data->block[0] + 1);
 		break;
-- 
2.51.0


