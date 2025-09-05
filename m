Return-Path: <linux-kernel+bounces-803087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F66B45A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFA53A7580
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C453705AD;
	Fri,  5 Sep 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKJbNuf+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0335FC12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082342; cv=none; b=QA3Od6LVWgXqljJItk8vpdH0jHybb9dd9eVVUmYg2HJ5oBR/WIIvvKPc4YSFukTn0h9QGG0S6oguo0jJaohWsZM+U1B4pvdRmmRQz1tpTJeYn6R8wdqJ7n9TcGEtaasauP9plgWBzFA6bnjuOoTxKnaVN9ZtYnJMKf+/p76+UxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082342; c=relaxed/simple;
	bh=WmBs+EidangIYMkmFQiqjKtLVuY5UWIcP3zPVMUxIqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utBXkIspMBEOvfhdvaQOSJaF3n8g6tXIHtsyXXJpFtY6aJuwlTX0JTpnJI4kdHAxY/beufWjf+I6sFzRTuIVxV7kfqkc5B0ggXbYKB8xV7lfjH93rHVBzyjHruXbU+uleMr3Wg2Mqlx8gMkSQc8IxA5SmKfGJ5ZRs5D+aSKRjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKJbNuf+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cdbeca71eso10675285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082340; x=1757687140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbiAfcpfMVm+eN9xH3F2tDTGO+C5t2EW86B9z9aG7r8=;
        b=AKJbNuf++duyCA4opzAwEvkZnzR+yOpLHyTlDuZDbSVUQlMMDgG683KpEGMJHegF64
         pPDDhp1DH3t7wUJYW/AgZ+4oJ3/nNtjXJMDEmyY4Np/Or9Y3gBkjDowwaEy9GMnzl4VG
         0x8JsKtJgCiXC2NTxsIlwMhpbhV60KnU2vP4Q7xrGjWqqT/xU7nqnBIAw+YRWb4o7fBx
         XugOJ4snt0K54+2XknYXOQ41JD/gVbe7gnjNEBIn4tnqCKJIiugcP+2A76jvtocgPylr
         TFmbCzeiTFBA3LFliRedjiXUSh60nd+f3o6aeWsO0CB8QuN32sfSJrIloXRjYtUYt0Xv
         EyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082340; x=1757687140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbiAfcpfMVm+eN9xH3F2tDTGO+C5t2EW86B9z9aG7r8=;
        b=N4gglCxjVMO69UYQ4cKFzRluQBwFBIJ2e8qpzTHgIVEuMHEXlOffIwMOIozJELUcmO
         4ISnhBBSeknlNVuKfhuZHymMY4c0TrQ56bgnc5yK/p2LJPanCYmX0BfclijYIloyDa2T
         ozSQNhwAhpBnpna6Fm4yTOvTYy0E/rprkVS5/At4BGPhBPU+X265j2FKfQg8LkFgbQ8I
         m1yyC9PMlgXGBl2Qa8aOWjs0vRuOg2ixTkf4d1778Fr6hzHi87/xV9wr1yKaQiqEieuR
         LHATWd3jsYbHnfC9LLiC4dQbPWbErAzfxxbqwR1VX4v6UyI1iJWtYpmMZ5sMERdTyccb
         90RA==
X-Forwarded-Encrypted: i=1; AJvYcCXEg4vMJJ1rH2hlJrX0R65TUy8nb1Wy6dA/5PtImulfO8rb4gAQ/bUujmCSwNWwpwmuzz+5pFx3M1jW5Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHl2OTX7VzwykKk8HCnbVntBAOjgsvW4OjcmYElew/Mtmb1L6U
	YygGel4q463sG/O9suHZx6su9QpUJ6bI/If6tfYIWM7zgKmOrBriMrW4
X-Gm-Gg: ASbGnctpCma5EPX7U7efw2ZtiU+vzPEHchngGqaaoSUt0OsWz9Ll8kdNkcz/iYcN9CJ
	6bpJImMyK8qlQ4DmD3l1zUysWw45ltHy8W/tR+Pfahvdy46delGx3MfS+fpwa08pFTXpTUXTufu
	qt0VvUbb2Va34ogO92KYWD49CN4O9DsMZ7a5wqpNVbFswSS1FWH8reOWHasthHbQCaZhwkKc2uj
	MNp0zTmheFFDRXU+0nHcbAfX4pyQtTsdTf4cXrmXnQGqFtIlljQdJiKmzvqp5Aokk/D2fTMG4Aw
	oOHDdMerjxiF7GZmytIRwAOXsr0ipP3/47Rl//Hiy/4QjLM6lT1fZqYbrgTK95YBokkDIZMQpkL
	JIjiq3GL7SFAWLBdWX1MgKaIVF9k92JCp8zBdI0LaUHMaAaubdWJXFg34NCYQ
X-Google-Smtp-Source: AGHT+IEmE5wp2syhWNo1e30I+r2MQ4Q3rcSQPScac9EfIJnaqXb/jXJuwqbCHwELeSq5v2EsuKBp5w==
X-Received: by 2002:a17:903:41cf:b0:235:e8da:8d1 with SMTP id d9443c01a7336-249448f9c03mr277206375ad.8.1757082340370;
        Fri, 05 Sep 2025 07:25:40 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1b5e5902sm100056215ad.49.2025.09.05.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:25:40 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	aha310510@gmail.com
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
Date: Fri,  5 Sep 2025 23:25:35 +0900
Message-Id: <20250905142535.4117869-1-aha310510@gmail.com>
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
 drivers/media/usb/dvb-usb-v2/az6007.c | 67 +++++++++++++++------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..34d28daf4679 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -97,13 +97,20 @@ static struct mt2063_config az6007_mt2063_config = {
 	.refclock = 36125000,
 };
 
-static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
+static int __az6007_read(struct dvb_usb_device *d, u8 req, u16 value,
 			    u16 index, u8 *b, int blen)
 {
+	struct az6007_device_state *st = d_to_priv(d);
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
@@ -125,24 +132,31 @@ static int __az6007_read(struct usb_device *udev, u8 req, u16 value,
 static int az6007_read(struct dvb_usb_device *d, u8 req, u16 value,
 			    u16 index, u8 *b, int blen)
 {
-	struct az6007_device_state *st = d->priv;
+	struct az6007_device_state *st = d_to_priv(d);
 	int ret;
 
 	if (mutex_lock_interruptible(&st->mutex) < 0)
 		return -EAGAIN;
 
-	ret = __az6007_read(d->udev, req, value, index, b, blen);
+	ret = __az6007_read(d, req, value, index, b, blen);
 
 	mutex_unlock(&st->mutex);
 
 	return ret;
 }
 
-static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
+static int __az6007_write(struct dvb_usb_device *d, u8 req, u16 value,
 			     u16 index, u8 *b, int blen)
 {
+	struct az6007_device_state *st = d_to_priv(d);
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
@@ -150,14 +164,8 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
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
@@ -172,13 +180,13 @@ static int __az6007_write(struct usb_device *udev, u8 req, u16 value,
 static int az6007_write(struct dvb_usb_device *d, u8 req, u16 value,
 			    u16 index, u8 *b, int blen)
 {
-	struct az6007_device_state *st = d->priv;
+	struct az6007_device_state *st = d_to_priv(d);
 	int ret;
 
 	if (mutex_lock_interruptible(&st->mutex) < 0)
 		return -EAGAIN;
 
-	ret = __az6007_write(d->udev, req, value, index, b, blen);
+	ret = __az6007_write(d, req, value, index, b, blen);
 
 	mutex_unlock(&st->mutex);
 
@@ -775,13 +783,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = 6 + msgs[i + 1].len;
 			len = msgs[i + 1].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, req, value, index,
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
@@ -797,10 +804,8 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr | (1 << 8);
 			length = msgs[i].len - 1;
 			len = msgs[i].len - 1;
-			for (j = 0; j < len; j++)
-				st->data[j] = msgs[i].buf[j + 1];
-			ret =  __az6007_write(d->udev, req, value, index,
-					      st->data, length);
+			ret = __az6007_write(d, req, value, index,
+					      &msgs[i].buf[1], length);
 		} else {
 			/* read bytes */
 			if (az6007_xfer_debug)
@@ -815,10 +820,12 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			value = addr;
 			length = msgs[i].len + 6;
 			len = msgs[i].len;
-			ret = __az6007_read(d->udev, req, value, index,
+			ret = __az6007_read(d, req, value, index,
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
@@ -855,7 +862,7 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 		return -ENOMEM;
 
 	/* Try to read the mac address */
-	ret = __az6007_read(d->udev, AZ6007_READ_DATA, 6, 0, mac, 6);
+	ret = az6007_read(d, AZ6007_READ_DATA, 6, 0, mac, 6);
 	if (ret == 6)
 		ret = WARM;
 	else
@@ -864,9 +871,9 @@ static int az6007_identify_state(struct dvb_usb_device *d, const char **name)
 	kfree(mac);
 
 	if (ret == COLD) {
-		__az6007_write(d->udev, 0x09, 1, 0, NULL, 0);
-		__az6007_write(d->udev, 0x00, 0, 0, NULL, 0);
-		__az6007_write(d->udev, 0x00, 0, 0, NULL, 0);
+		az6007_write(d, 0x09, 1, 0, NULL, 0);
+		az6007_write(d, 0x00, 0, 0, NULL, 0);
+		az6007_write(d, 0x00, 0, 0, NULL, 0);
 	}
 
 	pr_debug("Device is on %s state\n",
--

