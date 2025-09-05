Return-Path: <linux-kernel+bounces-803320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93BB45D73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26301B2420C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1202FB090;
	Fri,  5 Sep 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmcujBvX"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17E21FF33
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088411; cv=none; b=KqGmhkkJKJOSgBU5znct9BFOdhOnoGL/QTOcptJJE01dVzAfvcOZG3zzghlCThllLLGFDtapa/QcC7efqjaUIPwLeVZ9DunMGxZ3wgMypgNUdehyNzQ925XOw6kO2G+5LMVVniavBlpiadgf8dIVEoaaXZhgw5xqhoxgYCAxgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088411; c=relaxed/simple;
	bh=ClfJgGm0ZHlT43O7h7yKdO9Jubp0yM6dGUSGHvj5W3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qnv8WNrrUaPMwdlKzzOLUsQtu6H+JVapRTkb1tHNghyuSveQ9TY1LFcbFBFRYoab7bABqVEYP3Juiy1lGoyt57cALD5ikAC+yRHrHpSwFH+Bxt1ogWxdLm+THUvHJQGw8meRndp0lXt6ANb0ww0rU6Cdr/NpiV8xC8HHEkb2AAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmcujBvX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4717543ed9so1443978a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757088410; x=1757693210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PMKLz2tr4GWLZkyBuXzZGJiC8GdpZHGXoC7euUUmHg=;
        b=CmcujBvXJwT3tSjPm7njmK3+KLRl8dbH0laqLzMTgkHIRvFR65iEOOPAzJxQ/l3yY1
         /sfGh4u0smmrSq0AIImLpvQMs/nKpOnWh+ScFrDC1iSpancK+J2kbBXQxwF/zm45bq7g
         /mIlh5+if4+qhvzL1wYR21f1P5uXVkGeGb34jPCnTclK47Y6PAwSGeiki/6IzSJLOp7m
         Lc4JTaIyfUqCpISRUmut4IF4lVrjYVcKCS3Ij4CAUFWUWmQ4okJL+TuozzYPtMx8oizf
         0Wl30J9sd1EreMXcPxd7johdxnRurr2JiTjYOWjOQJ2ulaRTlFBF3s89rEp8XKOGe3RJ
         LTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757088410; x=1757693210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PMKLz2tr4GWLZkyBuXzZGJiC8GdpZHGXoC7euUUmHg=;
        b=OMU/y7siSdMCEkAlbKEmpTMjBSjYJsG4EPCVy0RmIfas+0cW/rzWnhH9CNphWNxsz8
         iRjE2iSlXdr8bvf1y4CBkwloRM9aY91sOHc0iPwTbs6NcND/fbuzD/2G+Qak5ul3onvD
         I5zFECE2Sfd0ryXnIE6SfPJbaMWBmaZhYcgwdrklZpC7o5UrL8dCXcbIXALGsW12yonV
         MPzOifoX7xwlfbT471YJ5XUk7FRWQadwqu2iZAzL7dPVI7qRhdxDc2j2YRrSnoAxtao3
         kxws04S4+5/kdKyhY6NJXVRqb+1XqMyPphPIFwiqRhLA3h2LIkRXVVsbwe80A7OARI5c
         Jnpg==
X-Gm-Message-State: AOJu0Yxy9QA5CpdCWWCph3nJC9GI14qELMfaQd+kbq6At+BNzF47li32
	FQbRG7saFmaR8Rs06ZsrhozAkz3IjrM84w+vQJs1jGQD4lgJfNBb0Q47
X-Gm-Gg: ASbGncu1q7NIOz/Dw3OKycHjm3lAveofLhQkfbv7h3P65dRqVh/u8PeR9TA6LljGepq
	8O0Rv3HvS3hasuwzoyWSGkkOVFyghHv9MbuxzyYrZZcRzRdLQwQIEOjF6q83RYnVufsaSoh5TcK
	70jhWW2XGFjwG5eoa8L9KvNwU8IJ8W2UFF1eE9xyqKB6Vv5XKmFdlhkBuYq8CEPVnfmBFQWSFwk
	egEerA2H9rX7jXqewntMqOh+zPW9E2BIO4kXg+nLZ1+4dlk7u4hw3P9TsUO/AX6ZirXxtcqZ4rA
	T9E1II8e5IyWuccA0Q3Gvv0Djf4DHsvqhPOdsQ0WPgAr1EsHo0V9YU/lV3azP1Lw1DEiRPFW+9/
	Oqe7gqhtp9Nj+nbmwb2lBzPNFSeKMFTZR5MLYAzYa14KuCYp8lA==
X-Google-Smtp-Source: AGHT+IHlw8XsCA7McJJodECCNjaPSoYRjmOVmBGdbJbLEJhrD0MXBXFEGaSvsqVswSikpaqlJjMEZQ==
X-Received: by 2002:a17:902:d4cb:b0:249:2318:7a2d with SMTP id d9443c01a7336-249448f6e79mr293667805ad.19.1757088409619;
        Fri, 05 Sep 2025 09:06:49 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cc01352b0sm50793915ad.80.2025.09.05.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:06:49 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 01:06:45 +0900
Message-Id: <20250905160645.4152096-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6805a24c.050a0220.4e547.000b.GAE@google.com>
References: <6805a24c.050a0220.4e547.000b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/media/usb/dvb-usb-v2/az6007.c | 70 +++++++++++++++------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..af750840503e 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -97,13 +97,19 @@ static struct mt2063_config az6007_mt2063_config = {
 	.refclock = 36125000,
 };
 
-static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
-			    u16 index, u8 *b, int blen)
+static int __az6007_read(struct dvb_usb_device *d, struct az6007_device_state *st,
+			    u8 req, u16 value, u16 index, u8 *b, int blen)
 {
 	int ret;
 
-	ret = usb_control_msg(udev,
-			      usb_rcvctrlpipe(udev, 0),
+	if (blen > sizeof(st->data)) {
+		pr_err("az6007: tried to read %d bytes, but I2C max size is %lu bytes\n",
+		       blen, sizeof(st->data));
+		return -EOPNOTSUPP;
+	}
+
+	ret = usb_control_msg(d->udev,
+			      usb_rcvctrlpipe(d->udev, 0),
 			      req,
 			      USB_TYPE_VENDOR | USB_DIR_IN,
 			      value, index, b, blen, 5000);
@@ -125,24 +131,30 @@ static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
 static int az6007_read(struct dvb_usb_device *d, u8 req, u16 value,
 			    u16 index, u8 *b, int blen)
 {
-	struct az6007_device_state *st = d->priv;
+	struct az6007_device_state *st = d_to_priv(d);
 	int ret;
 
 	if (mutex_lock_interruptible(&st->mutex) < 0)
 		return -EAGAIN;
 
-	ret = __az6007_read(d->udev, req, value, index, b, blen);
+	ret = __az6007_read(d, st, req, value, index, b, blen);
 
 	mutex_unlock(&st->mutex);
 
 	return ret;
 }
 
-static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
-			     u16 index, u8 *b, int blen)
+static int __az6007_write(struct dvb_usb_device *d, struct az6007_device_state *st,
+			    u8 req, u16 value, u16 index, u8 *b, int blen)
 {
 	int ret;
 
+	if (blen > sizeof(st->data)) {
+		pr_err("az6007: tried to write %d bytes, but I2C max size is %lu bytes\n",
+		       blen, sizeof(st->data));
+		return -EOPNOTSUPP;
+	}
+
 	if (az6007_xfer_debug) {
 		printk(KERN_DEBUG "az6007: OUT req: %02x, value: %04x, index: %04x\n",
 		       req, value, index);
@@ -150,14 +162,8 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
 				     DUMP_PREFIX_NONE, b, blen);
 	}
 
-	if (blen > 64) {
-		pr_err("az6007: tried to write %d bytes, but I2C max size is 64 bytes\n",
-		       blen);
-		return -EOPNOTSUPP;
-	}
-
-	ret = usb_control_msg(udev,
-			      usb_sndctrlpipe(udev, 0),
+	ret = usb_control_msg(d->udev,
+			      usb_sndctrlpipe(d->udev, 0),
 			      req,
 			      USB_TYPE_VENDOR | USB_DIR_OUT,
 			      value, index, b, blen, 5000);
@@ -172,13 +178,13 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
 static int az6007_write(struct dvb_usb_device *d, u8 req, u16 value,
 			    u16 index, u8 *b, int blen)
 {
-	struct az6007_device_state *st = d->priv;
+	struct az6007_device_state *st = d_to_priv(d);
 	int ret;
 
 	if (mutex_lock_interruptible(&st->mutex) < 0)
 		return -EAGAIN;
 
-	ret = __az6007_write(d->udev, req, value, index, b, blen);
+	ret = __az6007_write(d, st, req, value, index, b, blen);
 
 	mutex_unlock(&st->mutex);
 
@@ -775,13 +781,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = 6 + msgs[i + 1].len;
 			len = msgs[i + 1].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
 			if (ret >= len) {
 				for (j = 0; j < len; j++)
 					msgs[i + 1].buf[j] = st->data[j + 5];
-			} else
-				ret = -EIO;
+			}
 			i++;
 		} else if (!(msgs[i].flags & I2C_M_RD)) {
 			/* write bytes */
@@ -797,10 +802,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = msgs[i].len - 1;
 			len = msgs[i].len - 1;
-			for (j = 0; j < len; j++)
-				st->data[j] = msgs[i].buf[j + 1];
-			ret =  __az6007_write(d->udev, req, value, index,
-					      st->data, length);
+			ret = __az6007_write(d, st, req, value, index,
+					      &msgs[i].buf[1], length);
 		} else {
 			/* read bytes */
 			if (az6007_xfer_debug)
@@ -815,10 +818,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr;
 			length = msgs[i].len + 6;
 			len = msgs[i].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
-			for (j = 0; j < len; j++)
-				msgs[i].buf[j] = st->data[j + 5];
+			if (ret >= len) {
+				for (j = 0; j < len; j++)
+					msgs[i].buf[j] = st->data[j + 5];
+			}
 		}
 		if (ret < 0)
 			goto err;
@@ -845,6 +850,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +861,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +870,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 	kfree(mac);
 
 	if (ret == COLD) {
-		__az6007_write(d->udev, 0x09, 1, 0, NULL, 0);
-		__az6007_write(d->udev, 0x00, 0, 0, NULL, 0);
-		__az6007_write(d->udev, 0x00, 0, 0, NULL, 0);
+		__az6007_write(d, state, 0x09, 1, 0, NULL, 0);
+		__az6007_write(d, state, 0x00, 0, 0, NULL, 0);
+		__az6007_write(d, state, 0x00, 0, 0, NULL, 0);
 	}
 
 	pr_debug("Device is on %s state\n",
--

