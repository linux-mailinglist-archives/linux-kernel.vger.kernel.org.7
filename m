Return-Path: <linux-kernel+bounces-859090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A1BECC24
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 093354E6F55
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC62EBB88;
	Sat, 18 Oct 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Qss6wc"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C152EB861
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778836; cv=none; b=oIQzhiEMhPAjZpbf9z/GH3YUjaIjQghqGgR42QHzyA6GLz3dn0cOorxDbCYl32DxX9O12zM5Ea2+dx+3HWbzzCNVFO4lUCAuEVZDRxRESfByuD/MlKhbl95BlxjZNNEhL27YTgAFnKHg35jDhNl0R+2uxGxHQcwj4ecd5wZI280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778836; c=relaxed/simple;
	bh=Wp6pA2ijV72XmoO9lCOYRgiZJPPCan0nmj6ebicN3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtJF6JFbIpjHJCz7Y8ri6hMeBAIA7EuX3DHy3puHCM2nAOzQaXrzkKwPSArW+K6rDxfS8oCRPwuCVy4VS6nyzpNt6evI+OdpReHr+wjoNZzruoTcaUpmYjKd7fHzG2BjfbgknS9HGnzUG5tsQZhAhrw6s3XVEp8/exyBdc586mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1Qss6wc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2199208f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778833; x=1761383633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blLwC/EvjjsUuF6PMdGCDWzJWZs5gZEWamFiXY0Ipag=;
        b=H1Qss6wc7wpRbYySvN4W2R/NzIbSyONkhWkIsQVhDEgVj+kdRKtYKklLl3kn0DmtTL
         WoL5mh10qfFAC5qY5ZWyX+nIVRjDksM/ldIMlWWQbjvk+krKnSzuoUl8K+8dxxLLV1vZ
         34O62s7ORAwo7atK6hDLMJssxNC9ZjwpTBytuNmPf0bR0PlqXgNxRzzQOOFqOhB2Behb
         qxk2qRsTojSSXY1hLu9wF2wVVEAroorQdGlRsFPcUkwtpao4IM11ZI7rHM7NlVHlQ1Kf
         sEXIltycDSFNEG0Ves8pNBu5lLZARz4/ooPi2RGLHYorwS73S++7hXI2DJ7Wsq9dyL4g
         s4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778833; x=1761383633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blLwC/EvjjsUuF6PMdGCDWzJWZs5gZEWamFiXY0Ipag=;
        b=I7QL2DIlEVJ3m34U5AsXpIMYF6vJpQ6Qgfi6/Xn37oY4HLfGRcziFxzrzdtlfOJUuS
         fEEFwD1E45rI4rw7CJgChO8fzhk6tkkCoFiyzSTbWZhZEI9VZbBztTgezfI4uvS1rx7H
         Pb3tWs2mMKE1jj6mP4s60+LtMZCYZPdpcn5qJCy15U2bKD3qXHBps8+gLQTT8IxCj2H9
         l289nTWMIoCF+goypmni3xKaWi9WgS4a4f3YdmIYYY0t/EZd5nR7u5WYKF/nPQ/aMe6u
         K+CtaZJfR+Xc9nDmRG/9qr40oCJg9XRDZUNAfr+P5n4pGuHTsN7q7BX921H8+aIBbnvN
         KlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVysK40rKY0P3bfxbEdW8KXJ60l6bU1WYdwe3iSbspMv1bvqCUmyS7PdR9Exm2/36uz6nm1tq/H7xBMgrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykl8v4B1AmINJ7CWvCLquCIUdFDCyJbdjxor6k3Dz1RZ9cv9os
	jsdXaK9DuHTtPjee7qf4B2NOcydDAxE7QoGlkvCOrvTqJ/6ebM+M8Zr8
X-Gm-Gg: ASbGncs/p6VhlEjC9rQASbSzinGrpodb9rn3+FLj+93wsRXrLzEdhtJ5rubbXVg8nm0
	6c3wlL8Dmiu76Cv5hm3rFlx43cEr1PQ4hWwZ4vMbixbpgzZ9AmFV9bRDd2Lv5ETZkr3hQjXH9gT
	BbkIdv+NoiFVIOdW7Hru+TTo36Upyl8xTPMbE0elMclIxkKZFeEgX136zoZOBSzoUxm2icnRFdD
	FjjjX151uH5peIyWe4OXycpNBK/0xBUV31qBP3uuHJw3scmDF9eIJPpXagKUJLeGF/X9oAYe+k+
	HNgfJe8NccWHlKAElkVyQ2BntPY77PZUeR5P129kCFSP/WtEULtrKkUU6zeOX3ni4L//i2+wlHb
	Jm8P2Ql7oYsU648kOEn/DvbZsGMFV9HShHNLEZOzF1cr5jnjKDCXuw/rPwGifEB5gTW0hRNHtgq
	vk
X-Google-Smtp-Source: AGHT+IElXdxTpHivdHDGA/bS1moJZtG7kL7FPB73M2FQi4YQX9DDbcWVaiOgDyqqlMab7mC/uUqFtA==
X-Received: by 2002:a05:600c:1907:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4711791c3b0mr56406565e9.28.1760778832610;
        Sat, 18 Oct 2025 02:13:52 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm121034215e9.18.2025.10.18.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:13:52 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v7 1/3] i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
Date: Sat, 18 Oct 2025 12:12:56 +0300
Message-ID: <20251018091258.5266-2-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251018091258.5266-1-chiru.cezar.89@gmail.com>
References: <20251018091258.5266-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove debug macros and printk and dev_dbg function calls from file
as no change was done for long time.
Remove i2c_debug module parameter also as its implementation, the debug
macros, has been removed.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 59 --------------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index fd563e845d4b..7e2d8ff33d75 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -23,17 +23,8 @@
 #include "i2c-algo-pcf.h"
 
 
-#define DEB2(x) if (i2c_debug >= 2) x
-#define DEB3(x) if (i2c_debug >= 3) x /* print several statistical values */
-#define DEBPROTO(x) if (i2c_debug >= 9) x;
-	/* debug the protocol by showing transferred bits */
 #define DEF_TIMEOUT 16
 
-/*
- * module parameters:
- */
-static int i2c_debug;
-
 /* setting states on the bus with the right timing: */
 
 #define set_pcf(adap, ctl, val) adap->setpcf(adap->data, ctl, val)
@@ -47,27 +38,21 @@ static int i2c_debug;
 
 static void i2c_start(struct i2c_algo_pcf_data *adap)
 {
-	DEBPROTO(printk(KERN_DEBUG "S "));
 	set_pcf(adap, 1, I2C_PCF_START);
 }
 
 static void i2c_repstart(struct i2c_algo_pcf_data *adap)
 {
-	DEBPROTO(printk(" Sr "));
 	set_pcf(adap, 1, I2C_PCF_REPSTART);
 }
 
 static void i2c_stop(struct i2c_algo_pcf_data *adap)
 {
-	DEBPROTO(printk("P\n"));
 	set_pcf(adap, 1, I2C_PCF_STOP);
 }
 
 static void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
 {
-	DEB2(printk(KERN_INFO
-		"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
-		*status));
 	/*
 	 * Cleanup from LAB -- reset and enable ESO.
 	 * This resets the PCF8584; since we've lost the bus, no
@@ -88,9 +73,6 @@ static void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
 	if (adap->lab_mdelay)
 		mdelay(adap->lab_mdelay);
 
-	DEB2(printk(KERN_INFO
-		"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n",
-		get_pcf(adap, 1)));
 }
 
 static int wait_for_bb(struct i2c_algo_pcf_data *adap)
@@ -151,9 +133,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 {
 	unsigned char temp;
 
-	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n",
-				get_pcf(adap, 1)));
-
 	/* S1=0x80: S0 selected, serial interface off */
 	set_pcf(adap, 1, I2C_PCF_PIN);
 	/*
@@ -161,7 +140,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	 * PCF8584 does that when ESO is zero
 	 */
 	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definitely not PCF8584 */
 	}
 
@@ -169,7 +147,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	i2c_outb(adap, get_own(adap));
 	/* check it's really written */
 	if ((temp = i2c_inb(adap)) != get_own(adap)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -177,7 +154,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
 	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -185,7 +161,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	i2c_outb(adap, get_clock(adap));
 	/* check it's really written, the only 5 lowest bits does matter */
 	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -194,7 +169,6 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 
 	/* check to see PCF is really idled and we can access status register */
 	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -210,8 +184,6 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	int wrcount, status, timeout;
 
 	for (wrcount=0; wrcount<count; ++wrcount) {
-		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
-				buf[wrcount] & 0xff));
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
@@ -307,8 +279,6 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	/* Check for bus busy */
 	timeout = wait_for_bb(adap);
 	if (timeout) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
-			    "Timeout waiting for BB in pcf_xfer\n");)
 		i = -EIO;
 		goto out;
 	}
@@ -316,10 +286,6 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	for (i = 0;ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
-		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
-		     str_read_write(pmsg->flags & I2C_M_RD),
-		     pmsg->len, pmsg->addr, i + 1, num);)
-
 		ret = pcf_doAddress(adap, pmsg);
 
 		/* Send START */
@@ -335,8 +301,6 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 				goto out;
 			}
 			i2c_stop(adap);
-			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
-				    "for PIN(1) in pcf_xfer\n");)
 			i = -EREMOTEIO;
 			goto out;
 		}
@@ -344,34 +308,17 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		/* Check LRB (last rcvd bit - slave ack) */
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
 			i = -EREMOTEIO;
 			goto out;
 		}
 
-		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
-			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
 
 		if (pmsg->flags & I2C_M_RD) {
 			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
 					    (i + 1 == num));
-
-			if (ret != pmsg->len) {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only read %d bytes.\n",ret));
-			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
-			}
 		} else {
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
 					    (i + 1 == num));
-
-			if (ret != pmsg->len) {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only wrote %d bytes.\n",ret));
-			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
-			}
 		}
 	}
 
@@ -401,8 +348,6 @@ int i2c_pcf_add_bus(struct i2c_adapter *adap)
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 	int rval;
 
-	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
-
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
 
@@ -418,7 +363,3 @@ EXPORT_SYMBOL(i2c_pcf_add_bus);
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 MODULE_LICENSE("GPL");
-
-module_param(i2c_debug, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(i2c_debug,
-	"debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
-- 
2.43.0


