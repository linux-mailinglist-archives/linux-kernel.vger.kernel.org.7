Return-Path: <linux-kernel+bounces-834154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E000BA40CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834F11C00AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2E2F83A1;
	Fri, 26 Sep 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqSNXsCb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7234BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895787; cv=none; b=IlsWt+gAKAGAw1b4AvlJic1JeAM+oMsnWn0pIwKjFuzw1rPZdOikLIuCmxAMbWEDHYEJbZP2htBYke7ffQrzCKN3M0z28tVEyDJBOkedFDWLgh6rmdwAATMUchbSHcNGVn8UHQ5X+wlr6NhTGcUuoE+x/qrTp1PGkhq5CZae9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895787; c=relaxed/simple;
	bh=I6/9jdTp8/1MngmdCZph5ifXgKWMK/EdqCPinxqQuNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGzGz7GkJoiOs4D02SsVaVW3nzFQ4gjkahxiE2L21NJ5w8I9aytOLair0oM3pCNP7XDbI+P/6XQrH+aWrczNblfr9kx+1NR7A6p0vY7qpGGG4YrdHpImA+QagiulwVtuxi61vvKtmyFtspXFo/ALf9RVwz+Y+HDLnZ1P/jeOMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqSNXsCb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27edcbcd158so19164175ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758895784; x=1759500584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKdZW0ftr/OUszuEc5uNz8JRSH+vp4e+yPjDngAenyY=;
        b=AqSNXsCbxdbLkfIyg3MOP0DlOw3VUic+0NBNnTWjvQbMICHqWbpdiwRwlmOE/cRLCw
         VTDL8Q+ies44se3+wr20Rk++TEgZeht9sP4Yl0Y9x3R2Uwjn4MN47HRHbQO56vu3Xfz6
         a6uZaGm7DiBC5w3CXxSpH0pa2EeVJFAeP6i1pqrTY/v9vAtY1tUyXHlL3LOLTE7zLYZJ
         QZzfbDR8C00c73Wh/kFroNhSdG+mlVhtLUwQ5JyAai6NVEpJBnLCQP1k1BFBxydyeOLX
         a8tJN5mNJkC63qB4lU0P7lAhJlPzRqSx4sglSzaAdKCyFY+WC8s4jp3HH0Ls2UQn3RU6
         g88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895784; x=1759500584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKdZW0ftr/OUszuEc5uNz8JRSH+vp4e+yPjDngAenyY=;
        b=dIIpAqJTpcd/wulDQhb6T3Xd+crTWQVEmhjhC+THA75vhDUUc7jkkNrBaqpki1W+xj
         VQbHpfQcLdB75MioGqA45Q4R5tcVhYCSeKPzOavKbagI+pHwWGi2uBrcSXkgMByrTdn9
         szr1QcVlxRQXgg0C3gsg7SMrdXmlx+eQRJO2D7mmaZUO/qV8nEaAz34dYPsafTiQ1Ek6
         WZYnWiVdtE4UJn47K4nlFVfEYE2gNAVvg2HUjUqozMm9hXPd7moSNkjKyXENWKZWBfnb
         PMBXWfoKXbsD7iuIYsJOOrR7PsZ9as5r3ltkS6nnL8IHOCXPuKFnn6U8qwodpZJT/1yC
         MgWg==
X-Forwarded-Encrypted: i=1; AJvYcCWBHibnwkCwYcFcvDPAb1xdK0LVieEvF1HNN+sBdoiAgpoLoq/tzyxKtvG4S2zF4arAdnO7Ppr4yEsk36M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfyldmVHXuolWgnPOUJDBk1linfK8wQM62Rjo4PL3w4+jjxsz
	DnuuNLI3EIyW830H1HfD7tWs5ByxegbnvrTkHXqfItUYQIRuK8jU1+XD
X-Gm-Gg: ASbGncuG4LkBMo1FoTSXldfFk/0O2nX80JrDrzKqqxgXg0ocoBzc/UOfY5gK2a6PDlV
	1I/K5ZBGmntZeYZWmKbHIsd1rSU8zOzmu/gY10ZNJ17bkV07ScecxTF4kz9m4oaa8RKLdOH53sA
	Tv7dL6BaWy92hQlWqpFB163gzCET7QGAcPc5xX5/GhkoqS961fuDvH0rgu29+99JX43DbfS9a9P
	wgiJ9L6hTpSJ29jbwP8uIJQnaUsR6ooFMdgqZ5FN36CezvKTwlMnJpUFdThMwhh1XGldF6pvBwE
	iNgevdvBIHfyBkXCu2EYNbl6i+CW5un+Z0TY/r+tKVXYMQ0jNEESYJmJZRDDVd7rX7m+zOeG/ZS
	mEfQRfnmkV1OMeFRPyq40UwKEHSTdOj+3MGQn5LiZYGqa9nz16bH8/8P8Ddby
X-Google-Smtp-Source: AGHT+IFkJc22u8I/AG9PpYdgB1qjcf+eKead7izUDftEMVWslMjY/E8jHFiu8jtsc2e7QyFDi6xRHg==
X-Received: by 2002:a17:903:1a2d:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-27ed4a4bbaamr80629225ad.45.1758895783883;
        Fri, 26 Sep 2025 07:09:43 -0700 (PDT)
Received: from cortexauth ([2401:4900:889b:7045:558:5033:2b7a:fd84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac94ffsm54797165ad.136.2025.09.26.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:09:43 -0700 (PDT)
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
Subject: [PATCH RESEND v2] HID: cp2112: Add parameter validation to data length
Date: Fri, 26 Sep 2025 19:37:29 +0530
Message-ID: <20250926140729.267766-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 for the earlier patch, where a few bounds check were
unnecessarily strict. This patch also removes the use of magic numbers

Syzkaller reported a stack OOB access in cp2112_write_req caused by lack
of parameter validation for the user input in I2C SMBUS ioctl codeflow
in the report

I2C device drivers are "responsible for checking all the parameters that
come from user-space for validity" as specified at Documentation/i2c/dev-interface

Add the parameter validation for the data->block[0] to be bounded by
I2C_SMBUS_BLOCK_MAX + the additional compatibility padding

Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
Tested-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
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


