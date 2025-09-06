Return-Path: <linux-kernel+bounces-804158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64156B46AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94C61677CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F626A0AF;
	Sat,  6 Sep 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6KxD/Dj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721512B9B9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757156178; cv=none; b=R+445YUUAJn8qdEck9qLxWt/ludoD1/SCbCFVlKx0rvwR55VN24nnHVN8cpycH3yIg02D+QdQ3dnr6ZeoYz0L1jXWoCSkjpplxTU0H9VDaM48QEGEm8Jf76k9ZilzgmiFiKJtCNRQI8MwRBcUENzWDPZLmpCSdyMrpnemsrvRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757156178; c=relaxed/simple;
	bh=5SjlYNdl+0tSKZFXhO0/pR18VicBI1gjcxH8kaRfgvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InvIVMduvtr1Vj7Ba/V25zEUX7y2ydYrFHrOpzrGBFwRJgwE+DwzkkIFwbh+ASnITzahGVNdsSgmGFd/9k7W61UeljLECC82pUR+qnsVCGnn2hDlZHNGIsBdNrio12X+maiJJAgQcQqfDUeIw8Vy0KbLgpDSUFcVLDRVC7Lx7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6KxD/Dj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cdd95c422so15002345ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757156176; x=1757760976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYe061BUxpFYknIBIJf8C8RnLsbg6WJdAC59pR3CEDo=;
        b=O6KxD/DjRZxnq+0BfMAuxgCw2oQV1ae/BL+gDyd95yEQ21/38sIYHPvwjj1zxoOeQT
         W8fcxx6XMuywmV1St4I9XPxbpEHoFUJrTd8Hkp1pGkRzGCYC4845R8RA1xnKTOXx/aXa
         tLwyr3E6d84C3DsgHgfL0wkvCIUWhO+DW1xI834Zqip76MuPS7Z+l/BdPlj+PBkhTqjb
         LTDuU7t8EEZSJCIbuZ+sx7xnfi/E+6R0z9ghpj3sZyXJt9yBmWjmmpLAZWHANNlMr8Rn
         Xzfhyzcz1rceIkbjzdg4m09KLGeSIvqPKohAYwWWmqxCuXOcKH44A/AhYViGM1zMVMei
         5XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757156176; x=1757760976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYe061BUxpFYknIBIJf8C8RnLsbg6WJdAC59pR3CEDo=;
        b=XMMGUtLAopfxZ6/6+C/UNFM+AD7QlDrqKFj+iV3rIDaCAA5lhK2ogGLP/8u6WSIAP0
         Vy5IBo8vQihw6f5dSdr5fByf+oo4Y1WP0KEC11aGedcaotVmfyT5YIoRpHT/KejwxpRW
         j7DyozVW2+AcUlo70rWP0RAR+ZN08bF07Dn4TEYxwrWs1ueY2CMpIJ6DcKxAO+aNsGL5
         RYW9pA6jHiK83uX43g9fuSKwUn5//PEyj1iL8FrZcwx+m5ESyEtCkbzNgEpAScnUUwMM
         Vk45fJSPkWTztMx0+5u+a42N1sXYCuHsQdbSs3Uiawlu4lqJo0am8t+eftaKuLZa5vIA
         OJzw==
X-Gm-Message-State: AOJu0Yz3wgiP3nxw2ISxeuJifFCXSwDmXYnnNxO8dgVNI16oIaBBbM6d
	0GCK/EfYqfNMzuau69KaFSe+dzJwMP0nj6Iu9LxbgC22y679N16HinHQ
X-Gm-Gg: ASbGncvAFLlD3PKlHPNFavZGfgvLDmM3/Gcmx2Py+HmlQ/tAYKOtt1lkJzGNGN5MICv
	hNB/3AYid7CMlG1AexgRTsH18snlc+xc8rlXq+97WB3RHNT5PufUNO2WeLbkjUmPP8dD7b9wNbN
	b3RPga8yhPsefyfzJLR5i+GhjsKaiJLIwepIDEn96JAiGECIxv0CFi7kTNfJHKbuXoknF9YqPjd
	Zpwh/StmXZxtUk4md9H8LBiuPLqCc760pfAodjc+A/eG5jcAl5XCkg8ZohLWTY9aHwkxZV7X5t6
	BWJr2SNxXkRqllfg2PbZ7llNt0MsY94wzcM/XWftC28W7c/q5qeQ5j/VliaNtACxOYgocDw9XBY
	phFKlSQA7pzZ/4W4DUAoROzJ908Ex9KsbgPSSQsxU7ItuB9VR/2jbvndBSakP
X-Google-Smtp-Source: AGHT+IE9A1pGot18MceZR7nrxsYZikNBg7fzRMAkQnvs8oI6KaVW2Xms3Y+VoEpm1kqjUpIttb+Dhg==
X-Received: by 2002:a17:903:1a70:b0:24c:ac4d:d857 with SMTP id d9443c01a7336-251722922b6mr28699595ad.30.1757156175608;
        Sat, 06 Sep 2025 03:56:15 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e480sm119408235ad.130.2025.09.06.03.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 03:56:15 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 19:56:11 +0900
Message-Id: <20250906105611.103868-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 108 +++++++++++++++++---------
 1 file changed, 71 insertions(+), 37 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..72ce96e1418b 100644
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
 
@@ -752,8 +773,13 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int length;
 	u8 req, addr;
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
+	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
+		return -EAGAIN;
+	if (mutex_lock_interruptible(&st->mutex) < 0) {
+		mutex_unlock(&d->i2c_mutex);
 		return -EAGAIN;
+	}
+	printk(KERN_INFO "az6007_i2c_xfer 1 : %lx", atomic_long_read(&st->mutex.owner));
 
 	for (i = 0; i < num; i++) {
 		addr = msgs[i].addr << 1;
@@ -775,13 +801,14 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = 6 + msgs[i + 1].len;
 			len = msgs[i + 1].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			printk(KERN_INFO "az6007_i2c_xfer 2 : %lx", atomic_long_read(&st->mutex.owner));
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
-			if (ret >= len) {
+			printk(KERN_INFO "az6007_i2c_xfer 3 : %lx", atomic_long_read(&st->mutex.owner));
+			if (ret >= len + 5) {
 				for (j = 0; j < len; j++)
 					msgs[i + 1].buf[j] = st->data[j + 5];
-			} else
-				ret = -EIO;
+			}
 			i++;
 		} else if (!(msgs[i].flags & I2C_M_RD)) {
 			/* write bytes */
@@ -797,10 +824,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = msgs[i].len - 1;
 			len = msgs[i].len - 1;
-			for (j = 0; j < len; j++)
-				st->data[j] = msgs[i].buf[j + 1];
-			ret =  __az6007_write(d->udev, req, value, index,
-					      st->data, length);
+			printk(KERN_INFO "az6007_i2c_xfer 4 : %lx", atomic_long_read(&st->mutex.owner));
+			ret = __az6007_write(d, st, req, value, index,
+					      &msgs[i].buf[1], length);
+			printk(KERN_INFO "az6007_i2c_xfer 5 : %lx", atomic_long_read(&st->mutex.owner));
 		} else {
 			/* read bytes */
 			if (az6007_xfer_debug)
@@ -815,16 +842,22 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr;
 			length = msgs[i].len + 6;
 			len = msgs[i].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			printk(KERN_INFO "az6007_i2c_xfer 6 : %lx", atomic_long_read(&st->mutex.owner));
+			ret = __az6007_read(d, st, req, value, index,
 					    st->data, length);
-			for (j = 0; j < len; j++)
-				msgs[i].buf[j] = st->data[j + 5];
+			printk(KERN_INFO "az6007_i2c_xfer 7 : %lx", atomic_long_read(&st->mutex.owner));
+			if (ret >= len + 5) {
+				for (j = 0; j < len; j++)
+					msgs[i].buf[j] = st->data[j + 5];
+			}
 		}
 		if (ret < 0)
 			goto err;
 	}
 err:
+	printk(KERN_INFO "az6007_i2c_xfer 8 : %lx", atomic_long_read(&st->mutex.owner));
 	mutex_unlock(&st->mutex);
+	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0) {
 		pr_info("%s ERROR: %i\n", __func__, ret);
@@ -845,6 +878,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +889,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +898,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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

