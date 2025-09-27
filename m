Return-Path: <linux-kernel+bounces-834802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA45BA58D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C20F3A5F17
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA82222AC;
	Sat, 27 Sep 2025 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4/paOX1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D9158545
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758946521; cv=none; b=s0n/jY4Gkq6TiV0Mc1LkWdjZDqXBTH2cnXKjyjPUs4nRHP4PpwvrklVu3jZ7Xck3osS3NgfXiuKrwX435nGxV19ONEATmjjCqHXEEqEm2ainnWqJkmDadq7t+qjqU0IPUorpBH1hJ7gWeD4R2iPCLBEFfESGcs13v6j+tTwv9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758946521; c=relaxed/simple;
	bh=CAhmlVpNgjfXOj8lSkUQjgUpSSdRvC/yRyLgyFGBUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcZwWy2AgYZIhMxrIVns+jyK8d5xvZvbjmNzZt1JcPUJQYwZyozYoRKT8QkI8UVnM7F93qVfI5IyWXUHykU6WC+nSrGVEsZVSB2l39t8VLY4OKUacn2DwHMQQlpUXiA6wM6fl+v3+/T1luCf3kYtPrLjJxGGZtL+QNnEQhhPnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4/paOX1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so25935025e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758946517; x=1759551317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsjCaRuVjABsOrX7YYvRpKJqzHL0cubRF6Hom6jKdNU=;
        b=I4/paOX193anl4+objMT7p7JjIvynp8etVhg33dnK363NdfAONY9qnMoCY2AAFVYQM
         jg/MvPyNgNIM8CgJWsZyfwhtsCuNqoLjcXXtLBAEOuZGR6xJ4oY/CjinJDwW56Hi0H7a
         yZS+SzPj6pDhuGhXcuu61pUGGnunFB4dBAcVG0RyLx4SxX4RjDI/p171UQDgLv+AJ7f+
         qAj2/TNdnBct9fhMwKscQfsiGckTODsSNMASK4rfV4i3xJH3YbHRbH+npMc4yJMRhWnu
         eAM9AkcxnqDXWXLXHMmEewJc3gsq/ktUHEnX7lQ18AcMUZaOaMUw5LpuEunjB+Duc4/m
         l19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758946517; x=1759551317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsjCaRuVjABsOrX7YYvRpKJqzHL0cubRF6Hom6jKdNU=;
        b=VeRkoqIswE/bMADi0pcRf/fBjdEbfj3BZwv6BXvaITOwlGwiBD1thBCdI1YMj4MuNo
         S9n4fUJgD6ze8R7mQQQ37rz4J5X8wMPfhfg9rTABaDhwIjfrsWIxsJkDxjn1N7YKQUMA
         fUMbsJJydSJcXjdmiFvc8ZjngtTWepFhGlRk51Loj8ndBnfDt8/pPGaoenSdvT+HxX0R
         i8eLMjHV0LO7Ev0E3v2IoeZa2GH91H9HJ505BT6ECHezNCb8YZpDohcWjbyULebTjW+y
         Y5SaHN3/hpm7xoVMbvy5qtE8GLYZgK+mbsSsu6ih+fdiEPgA7dSZLuqqHtQqJo+o/SZf
         2F6g==
X-Forwarded-Encrypted: i=1; AJvYcCXz2kYcUg6kvXv5Ay8No1attUYRqG2S7o8KE9jQlnpc7xJjeieiDe1kRHfewTmWgKNPYxBxbc3TD40on7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCIlDFzUMd1hDLJdmRNWLBwyCO8RtVIXXOmEnXuvw31xSebavG
	brZ43HceflV5euEdDIrZNMdM6foVgOAHkyDQt8Kzl05z9uBvC5DL++pv
X-Gm-Gg: ASbGncvtq4uonLi9sZdIwrQxqEVyE3wuu7Qp/MShXWvGHnNyRdXvhbVd4ldcEVRSA7j
	y750UjVpOucFooO7EWkz5u6Md5A+vCDuK4vdjOmyjA5cjNdOrXWiV0dmdwJ4rn43h2AAC2ms08m
	MmdIa3id4nC8pV1nyiZWWMEoQY7Jo5deCy/yJTeC0xjxlGIfMy92cygCUy0heqZj+JsD+MmVYSx
	VcysJaYFehHwBtEBBXAUl1xbJANb11Gner7lA7nfsrC2uEOpw5ejY2NCgfi/gr8yUeYawPyOt0K
	0E7L3S9UZ4odqpGGhPZiNxK9eIYZppMHlBk4Zk3iT149MRQFJtNpn7JUYpwS92YtHXbshZyAIUO
	Xtbh9ZvTTHBxyNbUp1bwyXZppwIRBgg==
X-Google-Smtp-Source: AGHT+IEPcTCyqVHiaP3/xNF/dla38CK58yAcvJfn7hE3rAnPGiZrQiLP4KgDRmqBXjwsRnQ8sbA6PQ==
X-Received: by 2002:a05:600c:4508:b0:46e:3e72:a56 with SMTP id 5b1f17b1804b1-46e3e720b94mr37653005e9.1.1758946517224;
        Fri, 26 Sep 2025 21:15:17 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm50386665e9.5.2025.09.26.21.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:15:16 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 1/3] i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
Date: Sat, 27 Sep 2025 07:13:58 +0300
Message-ID: <20250927041400.172949-2-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250927041400.172949-1-chiru.cezar.89@gmail.com>
References: <aNbWejNZLYGuNvCI@ninjato>
 <20250927041400.172949-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove debug macros and printk and dev_debg function calls from file
as no change was done for 16 years.
Request by I2C SUBSYSTEM maintainer Wolfram Sang.

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


