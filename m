Return-Path: <linux-kernel+bounces-804604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD47B47A5B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D022C178F25
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D023ABA7;
	Sun,  7 Sep 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwweEJHB"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BC21A444
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239554; cv=none; b=nP39KOtI8k5Yw59HOqAWL9ZJR/D0DTpId/zAQOKxL1lKDLcllKytaykPvHE8fa8m9bF9HnhxSvhxVytyg7g9eZat+XcN/KbQlPnulBaSnV7+iav8b90D9EnrKdMpV1hnVdaa4q3dZzy3hx/1Ork21IcN48Hylwhui9b8MZTxWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239554; c=relaxed/simple;
	bh=3CYZCBpbOwJJr8S/A5ynnrPiosb07B5YKR5a3Fh3eiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbadEltj384ksyZhuZ7ID3rLTRLZPVbdIhSaJuClBDwd/sjgCfJ4nicO63eWPrXZQufiM6etZIfyo5kGFGroq2mssUISiwvYXtOIzeTPchY/Pra1H5t6JZMGRePkhghs1vQDRZG7Bo5BfiHwliNFeiIq2qOKJwM3bc4kvoOB9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwweEJHB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2355276a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757239552; x=1757844352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOxffB+yoRO236eU0NxghnWZeXnbOFQJfaY3DQEg3W4=;
        b=HwweEJHB+0ImU5l3NGQVvHb/bbnzlMuSsDdU8kSI7iZZWQthHI039kxmRYpLJ59YVJ
         4HatVzbrMKbWcRLTD9lzNdIXFIeIQ2SBnutuv3nCpqPIjU8C0tZujKDUhVBrfeL5iIB0
         82RbETQirlgl/b0FnY0Oq/xUH9HuUXi1J/x3K55jbz6BoW33CMXqwo62UUMf6xcW12uU
         TM75mKPvfWPazf470nMOSJ9fUPckcMcEI631i9C6TmbluIc73ZHbu74yuGJJ0w//llki
         O+4vehQ4ypSt8eoK/6HspwOETNe5wrtx+ueONdT6LzMJq8fOLAHYxJlJbUYvDN2uVkhD
         fHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239552; x=1757844352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOxffB+yoRO236eU0NxghnWZeXnbOFQJfaY3DQEg3W4=;
        b=begwGN2pHRCi9JkHd/7WVJdevIPH/+lbVw/MybEebI4hbWMPtFLPu+kJdwbRtnK/KR
         dvzH3z/T2XKsO3ula2HJy0guWPbxWRtdZshP67V2J0Tp1YsaHWj7kZqiJCpqz+n6b7db
         bQDyu+VhGLWvHV95eDlwLeW8wsShudY8gi0u1C3IF4oqWD8STAVKPFq6m88y+CbS6uE6
         KLyH7GUc3xTThDN8sqXFQrRGlJP0V72p/tu3yKbCH34sbko6FeXVjc3++282i4LTIANP
         O8J1b1IvxdbwaX9P7zqsQfEj92nXF34lxWW98aJsKSnsamtnMAjed8rjlZ/ECRnPi0Bq
         x2og==
X-Gm-Message-State: AOJu0YzOPhSE5OBnRckNPtk6qU6+/xK19B1ELJbTE6kr39LSe5C0IPgk
	QF4nV2iklhgcPcFGMk4cTarxxcC9DttU6dipRIKeqS3eciNaFUtd74gx
X-Gm-Gg: ASbGnct+MGcQFu6sIwDMgDHd3mNFY+mRjZhgKwcy/akGe8cUIzIbmDSu6bp2xqEeISN
	twF7GQpNeUpERCcUrz6O3JkXy2QIvmd+NQ3oLPfzFlEEEnJtkfvSHp7hR+N3op3vxdfTnGqeprY
	zaGaS5QBwhJD/W36lV3+LIVRHImHpA9pH3UEDd/Af93SWHqPVgEemBvx6GFyi7GaUergogxDyhy
	gLnQmLeqZSdYkMkGXsjo+TVY0h0yXAfJRIZeRELrKil6UjBIdBb8i12sq2FnGfR/3+Fd9WoN2El
	KWQtvRO7oV0twsvMWnqQStwL7r9wnXFnxv7mjnq7AF2Va2VZ1ZlnZizlMTCyjeNeC/3SMItWHqJ
	Zu2CI7lHVKD2ugs7TcvvTuXhKsZnFvMlBbHIZRyPhTLe/KbHW3w==
X-Google-Smtp-Source: AGHT+IH07wBRRL9bPa4vSkCE+Yz5uB4TzyD/XZ7j1i6qMaE7YzrO+irSG8hWK5lkUkXKh+QUHgcknQ==
X-Received: by 2002:a17:902:e812:b0:24b:1191:9864 with SMTP id d9443c01a7336-2516fdc95f2mr50800575ad.18.1757239552271;
        Sun, 07 Sep 2025 03:05:52 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1589e480sm140068475ad.130.2025.09.07.03.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 03:05:51 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sun,  7 Sep 2025 19:05:48 +0900
Message-Id: <20250907100548.281460-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 212 +++++++++++++-------------
 1 file changed, 107 insertions(+), 105 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..b73169f238d8 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -39,10 +39,10 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 #define AZ6007_READ_IR		0xb4
 
 struct az6007_device_state {
-	struct mutex		mutex;
 	struct mutex		ca_mutex;
 	struct dvb_ca_en50221	ca;
 	unsigned		warm:1;
+	unsigned		ci_attached:1;
 	int			(*gate_ctrl) (struct dvb_frontend *, int);
 	unsigned char		data[4096];
 };
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
@@ -119,30 +130,37 @@ static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
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
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
-		return -EAGAIN;
-
-	ret = __az6007_read(d->udev, req, value, index, b, blen);
-
-	mutex_unlock(&st->mutex);
+	ret = __az6007_read(d, st, req, value, index, b, blen);
 
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
+		       blen, sizeof(st->data) - 1);
+		ret = -EOPNOTSUPP;
+		goto end_unlock;
+	}
+
 	if (az6007_xfer_debug) {
 		printk(KERN_DEBUG "az6007: OUT req: %02x, value: %04x, index: %04x\n",
 		       req, value, index);
@@ -150,37 +168,30 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
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
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
-		return -EAGAIN;
-
-	ret = __az6007_write(d->udev, req, value, index, b, blen);
-
-	mutex_unlock(&st->mutex);
+	ret = __az6007_write(d, st, req, value, index, b, blen);
 
 	return ret;
 }
@@ -574,10 +585,9 @@ static void az6007_ci_uninit(struct dvb_usb_device *d)
 }
 
 
-static int az6007_ci_init(struct dvb_usb_adapter *adap)
+static int az6007_ci_init(struct dvb_usb_device *d)
 {
-	struct dvb_usb_device *d = adap_to_d(adap);
-	struct az6007_device_state *state = adap_to_priv(adap);
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 
 	pr_debug("%s()\n", __func__);
@@ -594,7 +604,7 @@ static int az6007_ci_init(struct dvb_usb_adapter *adap)
 	state->ca.poll_slot_status	= az6007_ci_poll_slot_status;
 	state->ca.data			= d;
 
-	ret = dvb_ca_en50221_init(&adap->dvb_adap,
+	ret = dvb_ca_en50221_init(&d->adapter[0].dvb_adap,
 				  &state->ca,
 				  0, /* flags */
 				  1);/* n_slots */
@@ -604,6 +614,8 @@ static int az6007_ci_init(struct dvb_usb_adapter *adap)
 		return ret;
 	}
 
+	state->ci_attached = true;
+
 	pr_debug("CI initialized.\n");
 
 	return 0;
@@ -640,8 +652,6 @@ static int az6007_frontend_attach(struct dvb_usb_adapter *adap)
 	st->gate_ctrl = adap->fe[0]->ops.i2c_gate_ctrl;
 	adap->fe[0]->ops.i2c_gate_ctrl = drxk_gate_ctrl;
 
-	az6007_ci_init(adap);
-
 	return 0;
 }
 
@@ -661,8 +671,6 @@ static int az6007_cablestar_hdci_frontend_attach(struct dvb_usb_adapter *adap)
 	st->gate_ctrl = adap->fe[0]->ops.i2c_gate_ctrl;
 	adap->fe[0]->ops.i2c_gate_ctrl = drxk_gate_ctrl;
 
-	az6007_ci_init(adap);
-
 	return 0;
 }
 
@@ -693,50 +701,55 @@ static int az6007_power_ctrl(struct dvb_usb_device *d, int onoff)
 
 	pr_debug("%s()\n", __func__);
 
-	if (!state->warm) {
-		mutex_init(&state->mutex);
+	mutex_lock(&d->i2c_mutex);
 
+	if (!state->warm) {
 		ret = az6007_write(d, AZ6007_POWER, 0, 2, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 		msleep(60);
 		ret = az6007_write(d, AZ6007_POWER, 1, 4, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 		msleep(100);
 		ret = az6007_write(d, AZ6007_POWER, 1, 3, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 		msleep(20);
 		ret = az6007_write(d, AZ6007_POWER, 1, 4, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 
 		msleep(400);
 		ret = az6007_write(d, FX2_SCON1, 0, 3, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 		msleep(150);
 		ret = az6007_write(d, FX2_SCON1, 1, 3, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 		msleep(430);
 		ret = az6007_write(d, AZ6007_POWER, 0, 0, NULL, 0);
 		if (ret < 0)
-			return ret;
+			goto end_unlock;
 
 		state->warm = true;
 
-		return 0;
+		ret = 0;
+		goto end_unlock;
 	}
 
+	ret = 0;
+
 	if (!onoff)
-		return 0;
+		goto end_unlock;
 
 	az6007_write(d, AZ6007_POWER, 0, 0, NULL, 0);
 	az6007_write(d, AZ6007_TS_THROUGH, 0, 0, NULL, 0);
 
-	return 0;
+end_unlock:
+	mutex_unlock(&d->i2c_mutex);
+	return ret;
 }
 
 /* I2C */
@@ -752,7 +765,7 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	int length;
 	u8 req, addr;
 
-	if (mutex_lock_interruptible(&st->mutex) < 0)
+	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
 
 	for (i = 0; i < num; i++) {
@@ -775,13 +788,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -796,11 +808,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
 			length = msgs[i].len - 1;
-			len = msgs[i].len - 1;
-			for (j = 0; j < len; j++)
-				st->data[j] = msgs[i].buf[j + 1];
-			ret =  __az6007_write(d->udev, req, value, index,
-					      st->data, length);
+			ret = __az6007_write(d, st, req, value, index,
+					      &msgs[i].buf[1], length);
 		} else {
 			/* read bytes */
 			if (az6007_xfer_debug)
@@ -815,16 +824,18 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
 	}
 err:
-	mutex_unlock(&st->mutex);
+	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0) {
 		pr_info("%s ERROR: %i\n", __func__, ret);
@@ -845,6 +856,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +867,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +876,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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
@@ -874,13 +886,6 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 	return ret;
 }
 
-static void az6007_usb_disconnect(struct usb_interface *intf)
-{
-	struct dvb_usb_device *d = usb_get_intfdata(intf);
-	az6007_ci_uninit(d);
-	dvb_usbv2_disconnect(intf);
-}
-
 static int az6007_download_firmware(struct dvb_usb_device *d,
 	const struct firmware *fw)
 {
@@ -889,6 +894,19 @@ static int az6007_download_firmware(struct dvb_usb_device *d,
 	return cypress_load_firmware(d->udev, fw, CYPRESS_FX2);
 }
 
+static int az6007_init(struct dvb_usb_device *d)
+{
+	return az6007_ci_init(d);
+}
+
+static void az6007_exit(struct dvb_usb_device *d)
+{
+	struct az6007_device_state *state = d_to_priv(d);
+
+	if (state->ci_attached)
+		az6007_ci_uninit(d);
+}
+
 /* DVB USB Driver stuff */
 static struct dvb_usb_device_properties az6007_props = {
 	.driver_name         = KBUILD_MODNAME,
@@ -906,6 +924,8 @@ static struct dvb_usb_device_properties az6007_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -929,6 +949,8 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -949,37 +971,17 @@ static const struct usb_device_id az6007_usb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, az6007_usb_table);
 
-static int az6007_suspend(struct usb_interface *intf, pm_message_t msg)
-{
-	struct dvb_usb_device *d = usb_get_intfdata(intf);
-
-	az6007_ci_uninit(d);
-	return dvb_usbv2_suspend(intf, msg);
-}
-
-static int az6007_resume(struct usb_interface *intf)
-{
-	struct dvb_usb_device *d = usb_get_intfdata(intf);
-	struct dvb_usb_adapter *adap = &d->adapter[0];
-
-	az6007_ci_init(adap);
-	return dvb_usbv2_resume(intf);
-}
-
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver az6007_usb_driver = {
-	.name		= KBUILD_MODNAME,
-	.id_table	= az6007_usb_table,
-	.probe		= dvb_usbv2_probe,
-	.disconnect	= az6007_usb_disconnect,
-	.no_dynamic_id	= 1,
-	.soft_unbind	= 1,
-	/*
-	 * FIXME: need to implement reset_resume, likely with
-	 * dvb-usb-v2 core support
-	 */
-	.suspend	= az6007_suspend,
-	.resume		= az6007_resume,
+	.name = KBUILD_MODNAME,
+	.id_table = az6007_usb_table,
+	.probe = dvb_usbv2_probe,
+	.disconnect = dvb_usbv2_disconnect,
+	.suspend = dvb_usbv2_suspend,
+	.resume = dvb_usbv2_resume,
+	.reset_resume = dvb_usbv2_reset_resume,
+	.no_dynamic_id = 1,
+	.soft_unbind = 1,
 };
 
 module_usb_driver(az6007_usb_driver);
--

