Return-Path: <linux-kernel+bounces-803997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A7B46886
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACEE14E1307
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 02:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C221D590;
	Sat,  6 Sep 2025 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8XhccfG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE234219319
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757127527; cv=none; b=AmOVbmtiXJythWRE/noa3hUQ106liL8RKf0p620fFuQ8pPixa62PPS5llvti++Iqnvmn8fk6ZdSoRlTOvUxs9G/yDsD3OvidShuWBBhf7iobQacA3PhJe9TRijvD7JsXNnMdxbpI4sBo5XV5C1YrBvQUMQC7qWNXyLCJv93cPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757127527; c=relaxed/simple;
	bh=Hl9NQC/66bQJOXLOAPc5OoBlo/Dv+7HkYaNfCrO7pEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfRmsj/fwTyuI2pVNWffk8sDJFNV4jB6a1546jTbKP79rLzQn80tAIZ7evR/2EPowgsMG4U2c7qgjH8hPX6QSh5BooOfyagQWaQ1T+94Ebb0DpQsKjNxh1wbsl4n99CKVbdcng9YoiH5RdFTGlvuni0vFdMrKAIW0GW4Y0/kweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8XhccfG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c786130feso25273855ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757127525; x=1757732325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB62UIofw386Ye3wboJLaeupc8QVHXDvYKqES7Q4TFg=;
        b=b8XhccfGRszF83GmEj7RX4go99a9Oqr4+D7k8FSU+2UjTtu7PKKyr8xbKRB8Dz6cMR
         mZpgO76lgpash4FFIuxLG829P3NDtEgH0MS15YwHnMUsUZwaWN/29OIX67XrrV8ZT7Ns
         q7AjLDDqA2Ua6kJQ4upH7FYWdmGIqv++I/vdv+Lr49WJqVrIlFxWE4UIPEQPPhep+BR9
         j3C4ZVbQsXyCC/tigbzakgoxWA16lyPFTNaRdK+yv9RP8LSx2uuZoj5tpMoBnhuRBj37
         7+Co/c9z8HSer0KYp7OmUKqknyqcMKfM4zvsNWIBC8RAS3cHvqMm1SoiHBkExTU6dQYd
         O5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757127525; x=1757732325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB62UIofw386Ye3wboJLaeupc8QVHXDvYKqES7Q4TFg=;
        b=Gg5Me71oznVSPIgPjr23swibEn5N4mKlj74rPo5vdPTFXe3mdLTUdYwPgPD3emApZo
         aNxhc4ki+vfVZN/Go3G35iTCznoI4z7sz+lVtDfyPcePhWgdPAHLqKWTyoj9STe9efND
         Q6Dn/xdDXcJpDlLvfwXwl2fu1jn//DrqjFpaMPA/9ZuvdNg+Vu06pHchu10ZwXeAb0Tl
         tdTQ2wHIgGBWZ1JxZIFtzVZMbEFxC3pZY+EeXHtXVi0TH7UjXzzAdw17VNWMiNEJns4H
         zQCZJ4SdzJoO+23JsdzYHXOu2w7qjhj5DQZaipXDdIlQKvvoy83yBEOOGJapKmKvG3nu
         V0sw==
X-Gm-Message-State: AOJu0Yygmv8QorfkZoZBpD60kj7QzCUlOVpSpeaSoG4gd0sVZKRDA/8u
	r6HwlRqru/p2wM3i4BBok/pjm7wu4TMml4WRkor9WriG/Is7j5LOxUiopg/wLVB6
X-Gm-Gg: ASbGnctk+AP5Fxlbm7IsnA3fJp1GkByWs/EVg9/4y6Bkixk4137l9Ijmcs/pDvR/tz7
	PY7i5FgizzeoKsmsFazVW1x8zgteyQozuWNy7Afa819wVpph6jpNScNAQWjlXGT/kAodcsOOgRC
	c1yEiopmJxOX+FjDzt5ZiX0T1V4i4jXK5pfZzF0L0y0Q4non4gcRd8mCTZMRtQS+FGtgJj0n5GR
	2GJVqObu6z/J0y9qjmWpOF6D7ajaHvGypNcF+c4fJ7NzHhXPc79JkVMVKZwg3eIWSkIsHqvHq8N
	SbV1jbngOxB9daP+vBdvupmobF8XFpSf1wOej8/7AqHdrBZWvxjb4NVSyIExPD3iXoS4KlCX/ir
	Jqa3aKBMn4Dq6Ni5U8VE3ndp521qw37QCpe+XjbJBZR4TClRklf77uEAKkWVL
X-Google-Smtp-Source: AGHT+IH6YGSpdPGL8s9B5cF10oy3pTwwEr1m1KjrG7dle3jACaD1SD8vP9T00SW+LV+353QzEZhC1Q==
X-Received: by 2002:a17:903:2b05:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-2517493a0bfmr7923905ad.61.1757127524947;
        Fri, 05 Sep 2025 19:58:44 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm228744225ad.14.2025.09.05.19.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 19:58:44 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Sat,  6 Sep 2025 11:58:40 +0900
Message-Id: <20250906025840.28498-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 72 +++++++++++++++------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..5de511ffd210 100644
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
 
@@ -775,13 +781,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
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
+			if (ret >= len + 5) {
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

