Return-Path: <linux-kernel+bounces-804375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53AB474DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB7F7C3A92
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E57F2566FC;
	Sat,  6 Sep 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEEW8S18"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106643147
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176845; cv=none; b=APFzekLEv6EjuV4r6eh3HU9BjwylKK5MKJeWPNpn4WazySr47PNSZPvG9AmDu6kS15tQ7hG1EFDfpzNEu6LM8zlMWX1iI3mN7d5rfW39jTFfuYoWhWI9Tyf6srRef4WnKNiJJODvpcopJvD5nxIfcZba3CdSDQN2eZMsFhlROnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176845; c=relaxed/simple;
	bh=BrLdDH9vAgVDELc7r59jmzcUunTiqxg89qiqLQWkMJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bk63e8Y61pcmE938pFmgSYtq6lO9qF9mHD32x+fyToDtcUGtvjHLyiF8yRF9B2RfSfYZx3ypafDsZl13EtuqSU/RdU9jsq+ys8+eheePGQXU6p/EJ7MIwFnkIO0EE1Nz/hmt6M82kPEEB/dDbu5k/pEcQE21sjK3TmP4nrBTyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEEW8S18; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471737b347so2011047a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757176843; x=1757781643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe8M6ShX9Fe/cNKWLpntEUVn+CtxKTEb0F8kkIgoGgM=;
        b=JEEW8S18az6TroVMKYU2amWY+t/TkH4/d1Ikwhy6z2Eyd2PP709TYBSqICJAtRIbTv
         tNkWtbIyUrmt1GaiCBCesu1xaxSt4M94ws25Fqb7ReAx5lQtSUwKHkDhy1YdkU5m6TbH
         C06jiXg3q1UAVcTBgAfJIsHyHA9qamXFHtMcPirOJpUmi6bY2IsztdZPCHwJmszcqz/l
         +FW9GU0MNMvel5KgCKPA3HZzj6d4/1vY7yj2DXYwFhhjwjUADE4KD8vblryBAL9kwjPm
         Kp++VqyTJNPa3rLyo8Tc/iaucx6fc8kUkN/ilayALSHS1+vepCFfbGGDM1d6F7qfA7HO
         N8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757176843; x=1757781643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe8M6ShX9Fe/cNKWLpntEUVn+CtxKTEb0F8kkIgoGgM=;
        b=sCCJIem4//FEewsI20jz5eX6msMzzTUpWnruPWqSNkPfx2nSbxfM2t+f50lL/U3oWm
         EDwnVu70FIyeL1+nPKF2L5i9RUxbhPPuSZH5cA9nm0Tsgx6TIls+f6NjNpelNPblJF/d
         b813ZDM9M2wwtVvQ9bR2aZQATuNnHPftvasVv3iieu14GYR7waaYPeR6pZd8tyxYRxfF
         7jjdqc4HvpICVVBFcd/032nVS0zX5fyeUxpaG+bVtYoKJU5WSqRd/GnfkeVxn44TF30J
         WN4Qi1lyXideGM1J9i4P0q0hRNiByC/Olxgtv8myt5RgTODW8P6m8qDto4dRxHOWbGPj
         eyKg==
X-Gm-Message-State: AOJu0YxciLWBngxpN3J0gRBF0PwfDM61Tgezm2epC3OacqbjhGsmcdNj
	p9dLTujuwe9el9h6kGXUHaAcJKxmw1/tC9Snq1Gwva5j2khXdQpCwdFjywQG2emq
X-Gm-Gg: ASbGncvH+VEl+3IdPaOGCl0tUkrUhEnM1uS4sDe3T4s/k5a0VistiA7iPWn/s1fcpiu
	3dXzXL2j2jaQwM0t7U2hq/YEwJyK0aedeJT8GaQ8LLK1WmoDwTlVbQchFZphOTcCyvs/p2EFIPX
	fzy61T8t/p/qsmagFUTuZZQs1x2vQN85MkFJ24Wmdf1DF1Nn2gkuLRFVZfQTnQe/IEAwdAlMEwV
	NkU8pJXG9gfZtiAPk5Qs3CtzfMeXXTzu30PLEaCvvwYYY6zI3S0SLvLlsfYDdcq4p7Xe2b4QQI8
	0pUw335J4mQ0YduqfbDBz31DhWH6AKlSusU7PNiExEMy6pUdW/2j6MoN1YoauhYfZsk6gV3REEo
	BWl0ccYb/hf2n4gmnl0VSgeEr0BEwOEBWu5LB0jx06olKIlTVKKrjXWzFau3r
X-Google-Smtp-Source: AGHT+IH0f4+rfcMkQlA0RHRqhHBcD2W9AMP8shiuiaUStqRLbUi1e1cE/jGVnZmxTg+Eeck7WlaJTg==
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr33664185ad.29.1757176842971;
        Sat, 06 Sep 2025 09:40:42 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfb0sm119194495ad.139.2025.09.06.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 09:40:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sun,  7 Sep 2025 01:40:38 +0900
Message-Id: <20250906164038.153124-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 213 +++++++++++++-------------
 1 file changed, 108 insertions(+), 105 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..020ab4cb33b5 100644
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
+		       blen, sizeof(st->data));
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
@@ -797,10 +809,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -815,16 +825,18 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
-	mutex_unlock(&st->mutex);
+	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0) {
 		pr_info("%s ERROR: %i\n", __func__, ret);
@@ -845,6 +857,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +868,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +877,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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
@@ -874,13 +887,6 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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
@@ -889,6 +895,19 @@ static int az6007_download_firmware(struct dvb_usb_device *d,
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
@@ -906,6 +925,8 @@ static struct dvb_usb_device_properties az6007_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -929,6 +950,8 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -949,37 +972,17 @@ static const struct usb_device_id az6007_usb_table[] = {
 
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

