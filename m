Return-Path: <linux-kernel+bounces-820848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2BB7F7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993EF1884A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC032E722;
	Wed, 17 Sep 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSXkvAxL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227D1A9F9F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116197; cv=none; b=cSEXNXCVHBSU3Acnx6n1RpLGADLa4lWGSRIvKoso5OoSV6F2eYD1S4X4/hmDFCKb9Okr0JBtQ47b7wJ/Z4zEkl//87nct0YbR200OcQsQafkGEYWQdo0sQUvkCKyz/iNyMN/HL4wjOT7LudJgZ8mK1xM+8cIr6l/2erk0fwM9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116197; c=relaxed/simple;
	bh=weuJ2MwlJxBeJO+3XDOOSJC+wXIGaL1+YZNafT+N/Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omgQXiJRoXTEE4154NRKnF1m7l67nZn0aBX4AOON1S7CKgQ/HzX62phNVP1EZ82v4bXwJJlVXWr5yLym98FfMGzX6NdIDGgVDNgzMz9swlkqikYHrXd2JqaXAWwoFEF6gTpeJmYZW8joZW3ZzC9OI6cymd+zgfcw4yY9QSLx+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSXkvAxL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45e03730f83so32219885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116194; x=1758720994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+llRWMjZnfsGeESVFG4qICneYksOTb64WbcBHPF4Fo=;
        b=bSXkvAxL3sOye9sHUhR/L07JqaUoXTRp0X803v7fle/Ilzd7oFMxw2Q9K777tMS0RV
         s/kr8cOwsAO4cnI/81tWE4kzSDhoTFmmWZk/PT+ygm1dj88Uw+JXJbKjS7uTee7Fxke1
         RlOhg0lRJnpcIhDIBCfakEyqKyWp78U5nPOebBC60tVWmeOx438klGFdWZcEjZ7FlQPD
         za/rHte7ZpNXtR2oYYJsGbaNbdxdNdONysTaWNDAHrAdtFS6s04J9glINJT6v4dJjEx8
         ujxsLfnPMhk7hPxsCNH8avoE0ujB9bXI+IxnYR7P2aaVT0pwYtZJM6WFPlxbAekI/2O/
         yFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116194; x=1758720994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+llRWMjZnfsGeESVFG4qICneYksOTb64WbcBHPF4Fo=;
        b=g8KHtdnpRYn4A1J2vQ/qx1RDGsHsNLlhSXceDLtoK/Nq+L6CLvaJH6zME3Jjn5Cj8I
         z/hxTAMpMl0pHrmP8WpgIkd9dVHFXoUsXpWMxKdpB0lKgCRL1wRH5AVyErJps5QNCHKz
         wSJCPoSOScBQOSb5XfQMcSg+4D0c4vKgNzpMzOp61Z+IGTmZu+Wy0ymJiiDWDEqRH26D
         /mN5cbBj1+ceo+zHJl2tCptEYV+dUqNPMJthNs9MSi+LXasB6HO7WXKbkbT0W1MUiLa1
         LY9etS3tQIHO76A/qvuFVeZ1KUIOArUDN7pNdTINtYVEr0+6dPpCs3rRwbi0B6CszPPV
         ZeKA==
X-Forwarded-Encrypted: i=1; AJvYcCVpH38vfy5wQ1QqgBszsUPBje5I9+wNpeb9fz9wbavtysiODu2WDCxcnfmqPnf8jFtn1rUpXQC2osm6QaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzNbthtOeO6v5gYrOBvTSVGlB56V19tq5nJTjjcXdfl3SmsrZ
	6IWlSbE3/tt+cuZdF52gsze2xOly85s0qGvvIaa/C+FTZ86sdqpJhd0V0cGVbg==
X-Gm-Gg: ASbGnctWp3jYax9Cg1vegGIiU2a0NUDhq6eAqg89wLTf0E6X9SnKCRR615YbU8B9+U7
	p8TBKuAGcyRcglk2G69rCioy1sWs4Uxj879ilmo8QvN/yNcGKhZDzOfpnEIMpBIWvapSZUbdpgD
	b5BSiCp86yjSlBzMrM7igP059ltayBuQjZ8emFAPDm8abNmROlzwsyNC4suefAnn9VCVm3Uk11e
	ZOXS7HR4ZMpr5t4BlqqGBNajJXC/OdkZWJCAxRRVMk6Uu7ytMTOj+hEAVcHgd9MkDqdyBMZ84N0
	Q9hZjAkpoHrlWlxrdDAt6+FrNqlG1d0Ug3V139uzUr4ompBZZDSwaNOKigebQESaRWubd6tHUOv
	TlFH1pqY3HCnU1/dRqMRdbwlQzePz+A==
X-Google-Smtp-Source: AGHT+IFJI8G7cdnWUw/QiXu4qHdTrxEzX22AW0w1LeHd0HI1xhxL8mn88vmRE381tEEksdN7lr43VA==
X-Received: by 2002:a05:600c:4690:b0:45b:8b51:b1dd with SMTP id 5b1f17b1804b1-462072d6e38mr21707515e9.32.1758116193979;
        Wed, 17 Sep 2025 06:36:33 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139ab391bsm38198075e9.21.2025.09.17.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:36:33 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v4 2/3] i2c: pcf8584: Fix do not use assignment inside if conditional
Date: Wed, 17 Sep 2025 16:35:23 +0300
Message-ID: <20250917133524.85063-3-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917133524.85063-1-chiru.cezar.89@gmail.com>
References: <20250907114557.15453-1-chiru.cezar.89@gmail.com>
 <20250917133524.85063-1-chiru.cezar.89@gmail.com>
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
 drivers/i2c/algos/i2c-algo-pcf.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 3fc4b5080a32..598bf000bf4a 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -169,7 +169,8 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	 * check to see S1 now used as R/W ctrl -
 	 * PCF8584 does that when ESO is zero
 	 */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
+	temp = get_pcf(adap, 1);
+	if ((temp & 0x7f) != (0)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definitely not PCF8584 */
 	}
@@ -177,7 +178,8 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	/* load own address in S0, effective address is (own << 1) */
 	i2c_outb(adap, get_own(adap));
 	/* check it's really written */
-	if ((temp = i2c_inb(adap)) != get_own(adap)) {
+	temp = i2c_inb(adap);
+	if (temp != get_own(adap)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
@@ -185,7 +187,8 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	/* S1=0xA0, next byte in S2 */
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
+	temp = get_pcf(adap, 1);
+	if ((temp & 0x7f) != I2C_PCF_ES1) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
@@ -193,7 +196,8 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	/* load clock register S2 */
 	i2c_outb(adap, get_clock(adap));
 	/* check it's really written, the only 5 lowest bits does matter */
-	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
+	temp = i2c_inb(adap);
+	if ((temp & 0x1f) != get_clock(adap)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
@@ -202,7 +206,8 @@ static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 	set_pcf(adap, 1, I2C_PCF_IDLE);
 
 	/* check to see PCF is really idled and we can access status register */
-	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
+	temp = get_pcf(adap, 1);
+	if (temp != (I2C_PCF_PIN | I2C_PCF_BB)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
 		return -ENXIO;
 	}
@@ -255,7 +260,8 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 	/* increment number of bytes to read by one -- read dummy byte */
 	for (i = 0; i <= count; i++) {
 
-		if ((wfp = wait_for_pin(adap, &status))) {
+		wfp = wait_for_pin(adap, &status);
+		if (wfp) {
 			if (wfp == -EINTR)
 				return -EINTR; /* arbitration lost */
 
@@ -415,7 +421,8 @@ int i2c_pcf_add_bus(struct i2c_adapter *adap)
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
 
-	if ((rval = pcf_init_8584(pcf_adap)))
+	rval = pcf_init_8584(pcf_adap);
+	if (rval)
 		return rval;
 
 	rval = i2c_add_adapter(adap);
-- 
2.43.0


