Return-Path: <linux-kernel+bounces-804145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BBB46ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD82A4543F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054D298CDE;
	Sat,  6 Sep 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb346XEE"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD51C8621
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153062; cv=none; b=ogKuLEexio6GdwIPWzRSLSFebXnzsjccVowp11+1Z7By+ghMduW5j1DfACTFmIJVBQ9BgY7faJZondU0nGBrfqJDHhgIbuOYFw83oAaP2ZInRlPhbr9+QGYrCYVs2FeCG0K9hF3UdFJW/Jx/8eca17qSMV4JeCdvZn1CDgCcHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153062; c=relaxed/simple;
	bh=gBKABOAA5Xl7h8XONQ+tnWpvhZjqyBF59f2ZafSr6fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgZIsdeZUGSukN92HetG5BXzc2H4gB5lMAft8+ax+mOrOgwmnpwff8Xb0Br5GXvDpMRxdQLdj176w3sHevRRoV9Hk7l03zdfuNj/PXdghMUQC6PEnQ0vhwmmjh/R5G4x0Tg4YrhzCfO1IcwR4Doo7BPZZSvc2rllYFApkaOF4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb346XEE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4e84a61055so2066402a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757153060; x=1757757860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKn2+UBZB3bdCWXVpP1/KyTWodbVyAvucNGaA6BDMIQ=;
        b=Eb346XEEioVugw1bFjDp2kFeR2ZPAjOgb/01Mhl5gElmJgAWnXxhQDwF8sJEDrJTw/
         Zshi6MLZaaEcM9e4laWVcIfh3H9VGCQd0fjIVlqNJnyyW7gv7fEaKaiXaByxxrQLSpBi
         08Nqr7emOtYRqjcaVeYOiq7f1DWrt2rnksEpAYrSDwcHO6E/fp2VxYk/G6umLGC085ZY
         EfyADwh2DXE1bqd63xwdmgcXBekKJ2RFPvm9XwOdRa77i2Qg0pFnrcyYwSgNBTcHzdMu
         j/dLi7UmGNcjl0m/lrZh/9T+Wxvqrx9IFawNXmQKVFz0q/ylZrWvE/UhBIPiwggW931e
         T56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757153060; x=1757757860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKn2+UBZB3bdCWXVpP1/KyTWodbVyAvucNGaA6BDMIQ=;
        b=IvVrpuyirN1RQZFQxYkx4AA6xzE5x4BAMC0AFMcYeB5bzti4MCGPNGnSoGQtSRnd3N
         TDQJ+hPStnl/YLa8UAHaMD6YohyiIQETdWclFwXD8X9yO7PIU/ham6WpzFMyXLd2pLxo
         N2Tv6aEVQ6B95gCxX2Nhl6YHuZf7TdyN+mRz4gfI9jcCSPqdRIa6pvxGm/aSINceVMJ2
         2NbBfe9Gar6eeLcafFWBWJ1VQ/oqqGgrfZBcwDXu+xs+ffLL8HUo6OX3h61dg8KcK4LO
         20yBmDrCSHIb8/8q4n4ILT5N8EZdWsl+vjdaHbgSDuWT4ET0N8G9tmYB2I4Gly0CI/xn
         fEyA==
X-Gm-Message-State: AOJu0YyFrZE+fIhVCFwV6RoQ0Xy5FWj6K3+Dwa63ORnmXTAY+Q/mvc+u
	Upq0c4I9iStsLl6TTYQIgKe0ehkO2dCRatKQRiMKSOQd97MIJxDMu3oVaEifXPS/
X-Gm-Gg: ASbGnctcno7IjjMoz08C4L9W4e/3/z3WhU97JUYd46UyqHn41MuNQm/ehdoFC4vnYCE
	f3PysDU7qW2uFr0GmARtxJLqShm0OuDefPUWhqHjwddPfxfD2E3s3F2w0Qaq9uKrcbItfglnyY6
	w4a2z7np5pEwg8tSYDBSPaIfcZ+Px6yZ8C6kQQP4IYC0VCSwVZOyIKTd7pQ39t5p/zbDmKF6hKC
	FRoVdPT6ywWtBNh/DvUoEfPsqAGd9G/9T3AmBtOorJaR+wn/SgS1ZYM+vFlJTK7alENozm+eF37
	UEG685+9tf+4zHSlVkaqcSb3iFUYUYDQK6l4dNmIzPfoWYqSuqTdcn3OnnQVFW9gIWqtyE98RUp
	rKBdztlDA01O084FENAmy1fw+sNj+goSeHZUhlWf9/Sipb7GuOQ==
X-Google-Smtp-Source: AGHT+IHd5yBvx4Dg2VPcBjjkdja/qGbEMYGo84uyy6oFE7t4hqZUXqEkRmF7UmFV80jL/RFiT3B1ug==
X-Received: by 2002:a17:903:1585:b0:24c:bd9f:2115 with SMTP id d9443c01a7336-25173da4103mr16369715ad.51.1757153060288;
        Sat, 06 Sep 2025 03:04:20 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c313csm73837715ad.113.2025.09.06.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 03:04:19 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 19:04:15 +0900
Message-Id: <20250906100415.80589-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 100 ++++++++++++++++----------
 1 file changed, 63 insertions(+), 37 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..86ee62fd5f4f 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -97,19 +97,30 @@ static struct mt2063_config az6007_mt2063_config = {
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
+	if (mutex_lock_interruptible(&d->usb_mutex) < 0)
+		return -EAGAIN;
+
+	if (blen > sizeof(st->data)) {
+		pr_err("az6007: tried to read %d bytes, but I2C max size is %lu bytes\n",
+		       blen, sizeof(st->data));
+		ret = -EOPNOTSUPP;
+		goto end_unlock;
+	}
+
+	ret = usb_control_msg(d->udev,
+			      usb_rcvctrlpipe(d->udev, 0),
 			      req,
 			      USB_TYPE_VENDOR | USB_DIR_IN,
 			      value, index, b, blen, 5000);
 	if (ret < 0) {
 		pr_warn("usb read operation failed. (%d)\n", ret);
-		return -EIO;
+		ret = -EIO;
+		goto end_unlock;
 	}
 
 	if (az6007_xfer_debug) {
@@ -119,30 +130,42 @@ static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
 				     DUMP_PREFIX_NONE, b, blen);
 	}
 
+end_unlock:
+	mutex_unlock(&d->usb_mutex);
 	return ret;
 }
 
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
 
+	if (mutex_lock_interruptible(&d->usb_mutex) < 0)
+		return -EAGAIN;
+
+	if (blen > sizeof(st->data) - 1) {
+		pr_err("az6007: tried to write %d bytes, but I2C max size is %lu bytes\n",
+		       blen, sizeof(st->data));
+		ret = -EOPNOTSUPP;
+		goto end_unlock;
+	}
+
 	if (az6007_xfer_debug) {
 		printk(KERN_DEBUG "az6007: OUT req: %02x, value: %04x, index: %04x\n",
 		       req, value, index);
@@ -150,35 +173,33 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
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
 	if (ret != blen) {
 		pr_err("usb write operation failed. (%d)\n", ret);
-		return -EIO;
+		ret = -EIO;
+		goto end_unlock;
 	}
 
-	return 0;
+	ret = 0;
+end_unlock:
+	mutex_unlock(&d->usb_mutex);
+	return ret;
 }
 
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
 
@@ -752,8 +773,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int length;
 	u8 req, addr;
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
+	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
+		return -EAGAIN;
+	if (mutex_lock_interruptible(&st->mutex) < 0) {
+		mutex_unlock(&d->i2c_mutex);
 		return -EAGAIN;
+	}
 
 	for (i = 0; i < num; i++) {
 		addr = msgs[i].addr << 1;
@@ -775,13 +800,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = 6 + msgs[i + 1].len;
 			len = msgs[i + 1].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
-			if (ret >= len) {
+			if (ret >= len + 5) {
 				for (j = 0; j < len; j++)
 					msgs[i + 1].buf[j] = st->data[j + 5];
-			} else
-				ret = -EIO;
+			}
 			i++;
 		} else if (!(msgs[i].flags & I2C_M_RD)) {
 			/* write bytes */
@@ -797,10 +821,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -815,16 +837,19 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr;
 			length = msgs[i].len + 6;
 			len = msgs[i].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
-			for (j = 0; j < len; j++)
-				msgs[i].buf[j] = st->data[j + 5];
+			if (ret >= len + 5) {
+				for (j = 0; j < len; j++)
+					msgs[i].buf[j] = st->data[j + 5];
+			}
 		}
 		if (ret < 0)
 			goto err;
 	}
 err:
 	mutex_unlock(&st->mutex);
+	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0) {
 		pr_info("%s ERROR: %i\n", __func__, ret);
@@ -845,6 +870,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +881,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +890,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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

