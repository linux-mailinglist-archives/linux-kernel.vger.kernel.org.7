Return-Path: <linux-kernel+bounces-804319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92E6B47204
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA951BC65D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878C220F2A;
	Sat,  6 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWlDNMy7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2A1E376C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172266; cv=none; b=LUsMs7hDHxGi6udosre9rxtGt5MzDXBvwWRi6Vuc/VcdzKwEeGI1M3b5uuFvaTVzViHNCzqDHhvVbf0PSEYZnt8M2UM4zZbuGDsvM0lvHZOBEzAX8oVz1fGVE8KD0sS11wxI86DrsBOYxp3Jq6XFwdNI+Oe0acRMCF/Pc4nN+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172266; c=relaxed/simple;
	bh=PCKM938jrsJGCfm0+OSh65DaQKjbaMs7iEVHEilCfDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J931qMo6eMJQ3cvoj4OGIigosrX5ZiPYjfAXb+47hOBP6cFjwwORMLsXEc9WFVbY76vSLUHRJqnHip6sQlTk3i+fft/3QzhhfnMos244ZwB8XEyMtWQDziIK3PKQLNReuj1FEWVfU7LQNvggR9NP/6MYQKs+DXgWi8fjgAhk7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWlDNMy7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772488c78bcso3021645b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757172264; x=1757777064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ6k/i+iIWRU7K4HjEPXOOzSQFkXLEXGR/6JUAXaNxY=;
        b=eWlDNMy7T+CF+VzDtX50qD2JDfULOAuo5wHFz2r2gMYDjd0R60nhOZy743w73hrNer
         Vduc/Zwln60K+sBr8mZfbrGJQrU9ZaDjUva7RY1sY6q/wSwR8Ko8y6P+Ikzkn1ZQxKbm
         IYsPBR+YpMVItEpNmFc+huEFPdRM7ryiEWxYJ1m2gShwu1IxjUUyT7yFpbfI7Fuxr57v
         ZVQuXHT1rZ1ffZ9B9MfLMjMU3TAvnwkx9PVB0SEA796mZpY2cN/pGZ5l9yaOiDST6e1i
         rJ6XZ1EM43p9JirY8yUU2/sTXPqpgrBIsomlOBoX3hi4t10GJ5aD084faVfq3a62Xat2
         NyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757172264; x=1757777064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ6k/i+iIWRU7K4HjEPXOOzSQFkXLEXGR/6JUAXaNxY=;
        b=NeodcXJ9fiNekfj1Gxv+Ues/G2bIVk2zG9Awn+1oNFW6rVUXS3ITvWddyeiJEvT8J1
         xWb7iCQz+qcRVKDnoE/0hs4dmkSLLFWU21qRhWY3EmpunWxc/sj4CHPRrRgM/o+QMMaG
         GxL3iUq7vY+6iwge+mA2arP7RYtmlvrjtoKws4iXHaR7aJ/8csLAFHZSsOpAX1RJ0vpZ
         mGckN6o6cqMpPFnY67Zg4oGZLxY+M0AMac0VQpO6ugzq1iJY4Qg6B0KSNXUBpysA3bAv
         RG7tG09H5sl1U61K181FFRZvF74Qlq2eKchMDlmSPtmydOwVBb+PcMqR3tBRnZYqDXDB
         Gsdw==
X-Gm-Message-State: AOJu0YybukxToW5Ofa7Qe6V18MfLUoOl22v1yt2eRkx9pZUbInQ5E9Yy
	sRm+15wGYye1fOgIfwjEzhhAmbccQZgtWweHlLDlNaB24T4JqO6aAtAEy8oF0n9l
X-Gm-Gg: ASbGncvSeQsH25rOzGmMY2QAffkRldLp/wKkZaeDEmhrkVTjYhXBPIi+AhD+W+R7Yyv
	lRzOE/uSgQSBJ1hQUMT5yPh4yzV0jJJl5Z7vg2/Q0NRJRStMVN8GFGFNWhD38cGtduAOKGrjJKI
	7f+rF3V1DIij/pGw3VXj8sMGOJCc+Z+5eLdijKadoZIVLsyePuqWH7vBAbJKNAIC9RL2pHRzdch
	CoXQ9nbHYrXAMyc4E2A4MHt94JdhAa8ZV8JR+1R+trq5ZDE3fEe2yIjxFcu5fldYnjQxCYk4bZb
	P88p9VWD6uCOPgkavYS/YwTzgg/xEoTyU+YmW1dWnSa8fAO5C9KMmZGqRd4s97c4f5I1zk3On7Q
	1qSJsC0L1yZOMNyrW2b7dyDRxctgrFqgD1GwJ30N4nGil0896Aw==
X-Google-Smtp-Source: AGHT+IFOZziW5x/OD0CEHgylY69NyOlbcqAntFXOiVdLs5yPYSs5qFpiVqML78gVoUXVBnb/VnPx7g==
X-Received: by 2002:a05:6a20:3c90:b0:251:7f83:11d0 with SMTP id adf61e73a8af0-2533e5732e2mr3858737637.5.1757172263825;
        Sat, 06 Sep 2025 08:24:23 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d6cde2f0fsm21173540a12.13.2025.09.06.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 08:24:23 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sun,  7 Sep 2025 00:24:20 +0900
Message-Id: <20250906152420.141374-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 184 ++++++++++++++------------
 1 file changed, 103 insertions(+), 81 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..69489cd3a0c4 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -43,6 +43,7 @@ struct az6007_device_state {
 	struct mutex		ca_mutex;
 	struct dvb_ca_en50221	ca;
 	unsigned		warm:1;
+	unsigned		ci_attached:1;
 	int			(*gate_ctrl) (struct dvb_frontend *, int);
 	unsigned char		data[4096];
 };
@@ -97,19 +98,30 @@ static struct mt2063_config az6007_mt2063_config = {
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
@@ -119,30 +131,42 @@ static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
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
@@ -150,35 +174,33 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
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
 
@@ -574,10 +596,9 @@ static void az6007_ci_uninit(struct dvb_usb_device *d)
 }
 
 
-static int az6007_ci_init(struct dvb_usb_adapter *adap)
+static int az6007_ci_init(struct dvb_usb_device *d)
 {
-	struct dvb_usb_device *d = adap_to_d(adap);
-	struct az6007_device_state *state = adap_to_priv(adap);
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 
 	pr_debug("%s()\n", __func__);
@@ -594,7 +615,7 @@ static int az6007_ci_init(struct dvb_usb_adapter *adap)
 	state->ca.poll_slot_status	= az6007_ci_poll_slot_status;
 	state->ca.data			= d;
 
-	ret = dvb_ca_en50221_init(&adap->dvb_adap,
+	ret = dvb_ca_en50221_init(&d->adapter[0].dvb_adap,
 				  &state->ca,
 				  0, /* flags */
 				  1);/* n_slots */
@@ -604,6 +625,8 @@ static int az6007_ci_init(struct dvb_usb_adapter *adap)
 		return ret;
 	}
 
+	state->ci_attached = true;
+
 	pr_debug("CI initialized.\n");
 
 	return 0;
@@ -640,8 +663,6 @@ static int az6007_frontend_attach(struct dvb_usb_adapter *adap)
 	st->gate_ctrl = adap->fe[0]->ops.i2c_gate_ctrl;
 	adap->fe[0]->ops.i2c_gate_ctrl = drxk_gate_ctrl;
 
-	az6007_ci_init(adap);
-
 	return 0;
 }
 
@@ -661,8 +682,6 @@ static int az6007_cablestar_hdci_frontend_attach(struct dvb_usb_adapter *adap)
 	st->gate_ctrl = adap->fe[0]->ops.i2c_gate_ctrl;
 	adap->fe[0]->ops.i2c_gate_ctrl = drxk_gate_ctrl;
 
-	az6007_ci_init(adap);
-
 	return 0;
 }
 
@@ -752,8 +771,13 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -775,13 +799,14 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -797,10 +822,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -815,16 +840,22 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
@@ -845,6 +876,7 @@ static const struct i2c_algorithm az6007_i2c_algo = {
 
 static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 {
+	struct az6007_device_state *state = d_to_priv(d);
 	int ret;
 	u8 *mac;
 
@@ -855,7 +887,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = __az6007_read(d, state, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +896,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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
@@ -874,13 +906,6 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
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
@@ -889,6 +914,19 @@ static int az6007_download_firmware(struct dvb_usb_device *d,
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
@@ -906,6 +944,8 @@ static struct dvb_usb_device_properties az6007_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -929,6 +969,8 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.init                = az6007_init,
+	.exit                = az6007_exit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -949,37 +991,17 @@ static const struct usb_device_id az6007_usb_table[] = {
 
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

