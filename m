Return-Path: <linux-kernel+bounces-834803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C05BA58DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7E3ACF1F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863E8F54;
	Sat, 27 Sep 2025 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFOMOzfl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1D223DE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758946528; cv=none; b=fWozA/W1eIh3yHI/yiNgWLrVQ67/7hODGNI5rsT2KHDp8o/2gBvCkxPQxF8NN5sncKnM4DPB1Of5oRBgpFWAQ804WOg5vx+/4fPEPkp9N33Lw7tjgOztwN7ZoRO31NPMAoh2JqtogvHB7FkmNxsft4FFCuQpMLD67u9CPzZW6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758946528; c=relaxed/simple;
	bh=LHZjH2UMXa92SxXhNcHHvMGpkdxmO+gWMcsE10ROlWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRYP+XKS2dSYThkWUcHxMY9enIVmGoNko3H/1TK84Fn4yY64s8k9vPWMydZ5uhIb2QyhyMawS2WhPKGtO4y3CtqHNgRZ5fPd0kTpgwxIDeGoXZpRj+F6uiMA1nj7BWlELRjnJQF0w0KznfOZuK6Zio6iNw0kvPZusM0uLD7A7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFOMOzfl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso21431855e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758946523; x=1759551323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=DFOMOzflpOL2I9f9ydLSwBOWHMIPZIQ2lRdiy7KYaV8p2cK/Zd+LFde4dofzfV3DEa
         PXnP+OI6Wv464/c6Ir4S03DEtfMvOn6tX3VwowqC73vBArm6mnXXhbpe7rVCauNwr6GD
         bU5lBjNtgCJulKvxPJhg/WkTKwMKXfeH+z9nK1wtGwwmbU4PGn29bKQvonorwJ8cUJ23
         rEiiqvj8SlP1zweDsFUNVIUPk43UanFdaPhEWCcWQE2XNULFgqWlLbs+5ECDDJPn0aIl
         s7zajiR4s9gTFRYRIG1I7sJ+wNW3v53BB7UGWHcKUO+5KuMO0mrCt+36+/Tq5LH5Jrlj
         fdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758946523; x=1759551323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=RsLOgNXPWgfeu00cgd/jwJf6GPVuJAyn91d1ee6qk43Sx0BKN0qWMbuZILrrt9U/kW
         wf6BA2OL17VVO9DNwkusUh+sEhcbQKnaQLf/R0xwLPz6VDKOnTQaujaSnrGTbWO0733H
         ITzBpUwluQaEehSqpNasNuAJwOe7l7OhG8M0WvhbYUKMKbe/4yNwTCLfu06MvvDzgPXF
         uIPUvmK5zXx3thYMZ4RvVOF21pXUdi/ihV8AVYizCLr/joKyNIBEEnhoOciXiP26wOuG
         AHnYBH6VA0pIKDQZALuS6iwVXEPeX9yKozvCBLSIG0viNs23FJl2K2K9VPhnPdQz6MjM
         XWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0fl7nEA+C3hPxN0ZOyMwQL3fuhUhqj6yLI5lzQjU1GF4Cd9DA9quHfezC3iTw8uCeuve/Z+mPLDUClog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTtdksbRXhwwTi4hWnq6Nc7YhwvLvJYCoLA/WzOmvn7qLUSZZ
	KztkRlRBjO3wTqpWzKHv2RkjhLy096O1lhpZcQ9kTb3S2Un1tT6MADiY
X-Gm-Gg: ASbGncuVQMY3rYnmF/dwHJbcE+2ah//q76iT2p3xHUVT47V0EJ0SnCOF2v8fiwmJ03E
	yFiqiath8/hYaVwCvsjEfTxdQTbYuKkAaJgbhq0djUzuyBWHITZfMmv+ksHIihHqtfsmIDUX6mX
	Dhvp96UBAsIxFXv5uKmluaAzR715+kUme+PjWMZ4nnweq4X+3ilwKX8DQOKxNo0G82OVEVO0d9a
	RWjxdFxP2RMTaK5fWWD7sk1lSdOndYfY+ktd/L8nD7lEGZ0PdKbUFFmCbFpU7Z2ZkBuK3PlBJ9W
	s1KGuJLxXwj8SdW6IWjJ7BL6ZP9i3K0WKzE4j9UHKIwo00ZuQquchzVIEBxlgM0iWLSbAUb7JS2
	SbPT2u01+vLSQ5CAWEET8vD9ktKakxQ==
X-Google-Smtp-Source: AGHT+IGpgauRDhsn4t5aFPP/pywj6JmzreFMpe4unJ8Z4K0kyhGOeKDXwdcaIKv1nQ+6SGVgZR2YTg==
X-Received: by 2002:a05:600c:3e86:b0:46e:4784:cdf5 with SMTP id 5b1f17b1804b1-46e4784d03cmr2607185e9.15.1758946523514;
        Fri, 26 Sep 2025 21:15:23 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm50386665e9.5.2025.09.26.21.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:15:22 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 2/3] i2c: pcf8584: Fix do not use assignment inside if conditional
Date: Sat, 27 Sep 2025 07:13:59 +0300
Message-ID: <20250927041400.172949-3-chiru.cezar.89@gmail.com>
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

Assign inside of 'if' conditional is not allowed. Move assignment from
inside 'if' conditional, to one line before each 'if'conditional statement
that caused errors.
Enforce errors fixing based on checkpatch.pl output on file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 7e2d8ff33d75..41a81d37e880 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -129,7 +129,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
  *
  * vdovikin: added detect code for PCF8584
  */
-static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
+static int pcf_init_8584(struct i2c_algo_pcf_data *adap)
 {
 	unsigned char temp;
 
@@ -139,38 +139,38 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	 * check to see S1 now used as R/W ctrl -
 	 * PCF8584 does that when ESO is zero
 	 */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
+	temp = get_pcf(adap, 1);
+	if ((temp & 0x7f) != 0)
 		return -ENXIO; /* definitely not PCF8584 */
-	}
 
 	/* load own address in S0, effective address is (own << 1) */
 	i2c_outb(adap, get_own(adap));
 	/* check it's really written */
-	if ((temp = i2c_inb(adap)) != get_own(adap)) {
+	temp = i2c_inb(adap);
+	if (temp != get_own(adap))
 		return -ENXIO;
-	}
 
 	/* S1=0xA0, next byte in S2 */
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
+	temp = get_pcf(adap, 1);
+	if ((temp & 0x7f) != I2C_PCF_ES1)
 		return -ENXIO;
-	}
 
 	/* load clock register S2 */
 	i2c_outb(adap, get_clock(adap));
 	/* check it's really written, the only 5 lowest bits does matter */
-	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
+	temp = i2c_inb(adap);
+	if ((temp & 0x1f) != get_clock(adap))
 		return -ENXIO;
-	}
 
 	/* Enable serial interface, idle, S0 selected */
 	set_pcf(adap, 1, I2C_PCF_IDLE);
 
 	/* check to see PCF is really idled and we can access status register */
-	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
+	temp = get_pcf(adap, 1);
+	if (temp != (I2C_PCF_PIN | I2C_PCF_BB))
 		return -ENXIO;
-	}
 
 	printk(KERN_DEBUG "i2c-algo-pcf.o: detected and initialized PCF8584.\n");
 
@@ -218,7 +218,8 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 	/* increment number of bytes to read by one -- read dummy byte */
 	for (i = 0; i <= count; i++) {
 
-		if ((wfp = wait_for_pin(adap, &status))) {
+		wfp = wait_for_pin(adap, &status);
+		if (wfp) {
 			if (wfp == -EINTR)
 				return -EINTR; /* arbitration lost */
 
@@ -351,7 +352,8 @@ int i2c_pcf_add_bus(struct i2c_adapter *adap)
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
 
-	if ((rval = pcf_init_8584(pcf_adap)))
+	rval = pcf_init_8584(pcf_adap);
+	if (rval)
 		return rval;
 
 	rval = i2c_add_adapter(adap);
-- 
2.43.0


