Return-Path: <linux-kernel+bounces-804048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BCB46922
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FA91CC7C23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6CC279907;
	Sat,  6 Sep 2025 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B62AmJAn"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8B18DB01
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757134573; cv=none; b=YO7loA6hxkqpYHhbRJO5g3hFmvXYwCR9NkuJe0EHPe3zDzeht0p7JoW1hIVusb7RakwQoT5oHvFHSX1xVXriJmUAUQE4EXIGFxwmZFsd9wPmFsXZh4PJgzkZDT9nVHu5H63Aewr4Q797R5JFAXrQiQMG7kD5Ax2oXp49ap5Uvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757134573; c=relaxed/simple;
	bh=ih7yZ9RBtpBxfRF5bKDxf0HGmlKbNrPYZ6OJsZo2rwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bb2v4c3mcgPa/y0LtG4vgLDx/2co2VHn3Cx1C2TAwDb8oc0c4P4/MK2gBjtmLTqgd4QFhi7vgOnKC6unrqf0uEd+wgTsDimMEwD933n9VTDyd3QlFvzsdD33dSjJUPFq9DarwJ4gOeU0i9Bjm8S/f7vm0BxvJmFMEtrF5WgG3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B62AmJAn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7728a8862ccso2641732b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757134572; x=1757739372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt3JAdeC6J6of2p+GFDOnZYX48DgR9acCWexedaO40U=;
        b=B62AmJAnrR4BKgnCOMPPI3V/bStSVa+cSTRDEMCOn6YbstkQkzhAgSErLPwl2rMphT
         xVMRLZ5YOUca+H4cqQK6vIp3fmA8v8O0+9aSvWA1w7F9rmvMS+dDqfEOHCKrpqYJbZ1/
         FOYxjSv4Ekf3A6/67/x+qvthbONTUkPgJ0p9s0SUk7A5gC5cw6Tls+8+jG0e6WzkWmDJ
         sKcVhZtAvHmHeGbyWCTnGjG7/yaCUGcnenTrskE7Wb2RY0FYJkwb2IVdBN0bUREo/1vW
         TAPHvkqFTiflbTwJ/S/CDop70ejsSr/JjAKoqY9T1HCtboEeXLwsgEpNgqw7T8L9TRvJ
         9O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757134572; x=1757739372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt3JAdeC6J6of2p+GFDOnZYX48DgR9acCWexedaO40U=;
        b=nbMI1hOfVo9157SEHmjyY4YA+HcbYoIsukluWxfK018EhDQWdpmyAgoENMxQiJpgNV
         BAolmQCJxfATP2BE9BEv2Icpm8hlrlKIkceN20IOg0j577BD8WY/lySue+vyLMdhWPnM
         8/oM98Vb5cevlBKpHcVnmsJf7QBYrCNHRvRdLcGFn5maPQSruVLZVfgnXgEmLyJtsxjg
         jmTNovII0FjGo9EgDR/JmUbuYsMnEtctEr642AkMFgTJv9LeXcA6r1CpFYV3TvndU+Mv
         +ygtb9jEj3bcefWBLHNlJ7pp9cLlu71jnCXuoE0K4b0f5q3MpedPIEhnlGq7NddeMkLG
         BpIw==
X-Gm-Message-State: AOJu0Yzgvrhm8AmjuEcy2LpkT9Xy13mkilMoF4XQvuxIvqLfidGtqWbP
	eSDisRojCZ4niV08NWjGZdeHFG5kkKUNvi80wSyI0R3CZG6DaxmhSgWw
X-Gm-Gg: ASbGncs+n4ikA+wmzHqkXmlVXk/Kmo9GCRtKthWJQN4zCbUtBNtcsqWr1lZGDOa6gkk
	JawHylJ4W61YDVWgZU/EhKj7jetzSglAvQ5lEJPNm2A7ZkXla3b/6SGIuMxZhgxPX+VFB3pZutP
	E3KdGKOlYUKsEG4gm9+itll49BNjJUJ6KyF6wZgIhM3D7nxHGWr1E1gu8USOEXygNn94mE/QBjH
	CKzem4XDRinR1hnWyiwVFdbEnvTfplLORpf1026da5NReaPtdk2vyT1AXD3XDRafj631LMiJ/Za
	LDO1P8o7bCnYhgZTWrkCYWscK4xVNeekmAkkHBUbLB7i6QelqfqQHspYRdKZJ1ur79sbHnYMxJD
	Q4hIXbCKUznVyBScda19YOb3IOO3E+Eyi/Eq1tUau4be2UmWbyj82P7NpHDmD
X-Google-Smtp-Source: AGHT+IF4xNWZ84JanbceRxaogrdI86Kush4lGgpqP2kYY8X/l7h49Bz93ORr5VSrR276Y8/9B4QymQ==
X-Received: by 2002:a05:6a21:339e:b0:24d:1b60:86d8 with SMTP id adf61e73a8af0-24e7f5acb7emr7892287637.11.1757134571579;
        Fri, 05 Sep 2025 21:56:11 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm20945547a12.23.2025.09.05.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 21:56:11 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 13:56:07 +0900
Message-Id: <20250906045607.41590-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 79 +++++++++++++++------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..f9273e3005ec 100644
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
 
+	if (blen > sizeof(st->data) - 1) {
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
 
@@ -752,8 +758,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int length;
 	u8 req, addr;
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
+	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
+	if (mutex_lock_interruptible(&st->mutex) < 0) {
+		mutex_unlock(&d->i2c_mutex);
+		return -EAGAIN;
+	}
 
 	for (i = 0; i < num; i++) {
 		addr = msgs[i].addr << 1;
@@ -775,13 +785,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -797,10 +806,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -815,16 +822,19 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -845,6 +855,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +866,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +875,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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

