Return-Path: <linux-kernel+bounces-834337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F087FBA47AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143021C06852
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C338223DFB;
	Fri, 26 Sep 2025 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fytdoeUE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540122B5A3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901610; cv=none; b=od4JyUZxqTwT3xgR7QvW7EDdEPB3+NPdb/xPWc+3ynPz329PfykygPvX/PhWI6Cr5F6n0g86/i2GOgfwE9DiN+Yt1HAR372OEBKckLo1Ads1WiIww7Ry+4aGQ9lucjDMCh8/y1mXeGmAhGiNme/+d1+9CafTow6/eXNf6DBNVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901610; c=relaxed/simple;
	bh=WqFWle31hBLkKv2QftvcEgFosu5gxLiADdg1aI61w3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu4PKMD/wdhiR4oQn3PklVNBmLzZpucxMC0TTKD01JVlqJ4P7bwB3pqYs8o8pCw3OSoAMU/Z5OaqrAxOrMbyCjJT0PUyRXc3NP8nPRsXCJqtVbPmC0i/Res5tGU1K7ZzvHBye/k5Vx5wSm0F9bSP+QxAlzS2g4R03vkZTOUr0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fytdoeUE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso17709495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901608; x=1759506408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/EQ7xD3PN8A2TUdrKeEw4dzE8F5BLQWtv40TOLd2H4=;
        b=fytdoeUEePi8WDCcScYZTpGXNNgKzNKQYQ3U/k1bApbsucXc2mxwaFHPV7w0kyN7sg
         2mkKcoug21RJOKjxT3gybWSRa+Os9s8NBjNJwHzWbB0RyL1NNCMtwTzlSg9Gf4qKAg+A
         PvkcpC1Hthi6gbzNLrbSDXlzKSA70aZJ9RvcR12kRorG3VyPeWiVWSTSkY+Z/D/Gnc6T
         kf7WCRYqRIbNCNMkxuz6kMWxezVUCwvz2hGSqjc1CHm/GMPGWkRknX7nYHuj9A0u2MqF
         4oc9YY/5KqpgUxOcw+J+Asj+r04Un5fFtMDbWtFf1iPcgTxlOJI4x4MoODZ/y3wZPoYV
         +TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901608; x=1759506408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/EQ7xD3PN8A2TUdrKeEw4dzE8F5BLQWtv40TOLd2H4=;
        b=t11JmG0H9o251wVWFq8V1eI4SCnoi1A0sQMSsxY+DrZ+VX88mziXO3uGtZIecAyLj5
         3zG9JM5jjVctdmm8FYpfImccVqAcI7qO8VT0Q29f3oEEiFWbu6FI2cPEW9jW31ILSept
         W8/EvRxFkv7a+B1VM9aFOx7JDmbMkcM7zNVTv+FTXwGudC63xYQYYY5+HF5atjaIF1cY
         INQYlCFxvj7APpe1p2LRPbZ1oPbVgToXHlfjVpXsLLWe1Xfn3Ked3D6v99lS1+opBnNp
         qMaAL6iC08ExrzhnnJOR1NO92rdRBap6x+rZU34ohC1KFENEJMskfLYoK62nwdPcJQS4
         e9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2EYjlQJwgYArcIOigA7jEdJvXogOZWBX49F86r+ctLOW4Ijf6mX6UoNgSlAuJQQXG0QV2f/P2kXinX4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXg9ZWYF9l5AlmjeBs33e5IXHpzWQjAsjDbbDqKc2mH8Egjif
	I6Ta1kRtCsoQZv4aIFx+Zx8em1B3TG10QeG5O5UgzqGZC3LUOPHStWXZ
X-Gm-Gg: ASbGnct09QLf/YVntjcrfwvjq29Xtme/2w3YYXmh0shE5sCd//W5q6xXvy3Q7eDFAFY
	XWlbb2xMYJXJxnZfe/u6cRyzHostoQeOVoqPaTwJzmpB4olnzmISnSQNfQvT7yFBehQXzxQaJPE
	4xB6jziRKHf+OPNsbk+ft9TdYmVeS0LMrxw3juN5ZgG6Cg08tx2Wj2FPDPGChFC4frxuTw0dWmM
	2g0ZwXXOxp3qO1YxJ2XHM3pEUAaIzFNOHaXHksNdavYRe+IYWT96i6Mon7ggxXvB7NCKK5lpZa0
	z8aiuhDarfTuovTfBeUd+KWjAZ+gM/vEKWfrxT8jIYu6w8S9hEnnv4zV0RU6KvC3SEkehQ1rqcm
	O3PuNrPLVt+pCH61vVeTNIAFlcueEIleRYDMISd14
X-Google-Smtp-Source: AGHT+IGmRrUsID/iMYO7L+HhZanavQv5O4am0JMpzo//A4tQNmtSyeXyqAUk+hX/oDh/sCWPF8+cTg==
X-Received: by 2002:a05:600c:608e:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-46e392534e7mr50482665e9.10.1758901607613;
        Fri, 26 Sep 2025 08:46:47 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32bcd016sm41680005e9.1.2025.09.26.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:46:47 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v5 3/3] i2c: pcf8584: Fix space(s) required before or after different operators
Date: Fri, 26 Sep 2025 18:45:20 +0300
Message-ID: <20250926154520.40583-4-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926154520.40583-1-chiru.cezar.89@gmail.com>
References: <aNUa-9HcQzyjZkvE@shikoro>
 <20250926154520.40583-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require spaces around or before or after '=', ';', '<' and ','.
Add space(s) around or before or after binary and ternary operators and
punctuation signs. Enforce errors fixing based on checkpatch.pl output on
file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index c856f4c8e3de..8f7421794a7f 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -202,7 +202,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;
 
-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
 				buf[wrcount] & 0xff);
 		i2c_outb(adap, buf[wrcount]);
@@ -293,7 +293,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int ret = 0, timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -307,7 +307,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
+	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
@@ -352,9 +352,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 
 			if (ret != pmsg->len) {
 				printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only read %d bytes.\n",ret);
+					    "only read %d bytes.\n", ret);
 			} else {
-				printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret);
+				printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n", ret);
 			}
 		} else {
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
@@ -362,9 +362,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 
 			if (ret != pmsg->len) {
 				printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only wrote %d bytes.\n",ret);
+					    "only wrote %d bytes.\n", ret);
 			} else {
-				printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret);
+				printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n", ret);
 			}
 		}
 	}
-- 
2.43.0


