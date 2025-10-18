Return-Path: <linux-kernel+bounces-859091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05684BECC25
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C50E34E7E34
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F32EBB80;
	Sat, 18 Oct 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I71/UhTH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00652EBBA1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760778842; cv=none; b=mjWVRj4B+WPKEvp3QDQ7TVkC7ei2AHLY1kkhU92Tr+O0tnm1gJQH+UTiiFwBZ+CSf+Fz7tuiiKf0h79YPEIDtEuIXGOW15ADiXctS5e9BRiwG5Ca4VO3Vc9Io8cFlS7Ds0BVIiRxB2rCqcH1o3533NJLrVRtbgugTq5IgWyhQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760778842; c=relaxed/simple;
	bh=LHZjH2UMXa92SxXhNcHHvMGpkdxmO+gWMcsE10ROlWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekPS7hDNaXCM+f+I/a8gV7kL2dBwTFSYeFgdTsKVNrgCA0PMT//kiTXKskcuiybd9JND8csLE7TUF45FK0uUzqVH8i2SLskNWOXiQ974AldIe3GS5REYESf3EJBnRcGO2Z2Hs/aXS2kSrczSs6Ooig6+hWA52+uJlJBIH5KgSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I71/UhTH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471b80b994bso3420945e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760778839; x=1761383639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=I71/UhTHTGAWR2C9m7ZUGD0tEn4Iq9cwnPEgd1U/WC0qH++SWOV1pqnqP/VGlv74wM
         ztkUcPSCr88VhiNfM1yMqjui0DAoSoauG5R84oG0RYhzbt98l08FZemLbstyYb+dU3xW
         HSgQZHQ6imavfJ6dkBVtKeQahd8vR7ppJvNla1T3Y71r84BhcRcxkxwhb8apFuOFnKeO
         gmyVcgnErNjtEbr4pG8Oa2S3YirjvE8tMlTnqpV3u3+SntqjS8sI7jjPjSSFQkLEakdM
         jm/rGnugInVgYwnRgFzWvp8PjxnlyDmtrpFbVtrtLqY3U5HoR6oSHCphRwESsO36XtD5
         LYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760778839; x=1761383639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=L+Cbm7DgQr9eF69rXgXzXJKWaHLkRe2FusqV6mwE8t1cocPGEjDrB9cAaJghHmsz4D
         WCkhvgNO1KhOJKbkqXr2TacH783CNTcx8UiljZCj7N8KVkM5Wc6BMMaytOuPKK7Eur5T
         RHdwKK7SsNHINLp2lsgxqY3MH2xtCpy5BL1ln0HzoHEtY78jgbX2apYpEO4jAoGeSATG
         +WecD5nK4nSQvJcIfL3wK24f5WAYDiDpYbC/jEXsFX8p+5sa/Z2w1UoG9RXy7LLBrU0x
         +9YmmM+skph8PQCPVauL0zTqwLt9mKxZi8Sa0auCGnf8lSnM0THs6mvRJyarQLGtyk4n
         cm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCm+P/eHgsxnklTy84sjaR/enn6jucRoDuyYcDlgB+HhSo7SQ9odALrPh2sNhgHsxIL5N0GF1HFUJzPlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfDRv2a5t7WCH1bYICpJ8mBthf1uAxlaAmBlgBEVyS6fhLZIn
	6sW+5Cox9gjKuUaX2y2d9zyehAhed9v7fWQNmtecoBsN1HSALOsm5+MW
X-Gm-Gg: ASbGncuTNVLVHkk4ox65/YhrYocetla1lkArx6++wyLNWgmfKwBhzq6XVPXJwCU50AQ
	Z+aNC9BgRQjF2/eHKdinB50BEnTkJsue12mzVkpB06TJfEUFDDPUhk7D4qzimCP6TjfeWJ0aoxZ
	PcWxV6I6gjq/LUbQiE0kbzeDVdsqDy9M54Yr57lCX6CY8QoUZyzw0x7rBV2Oi0DIEqa8+UkOIoO
	pnwESmuV6p1HL03exTEoaR+7pZTzylYagRDI8rqrgdo7Vizzul9nGD6iKSNdGMtzyOf22tYesIe
	zF9xLNOxWasA8R2HeQ8A6sHuKBpb2pzHmD2ZOvzkM/2Fll6sezvyBw1LGeBCDakxI5Ped8yhKu0
	LbUvsZhAHhw+gNwPR+FEGFsw4SfuuzyFu/Ew+V9FzAhjwQLXg2mmbv33fKzGi3doBEiS4tKwpul
	tc5XNhk4Db/Br3+F07TJiV/A==
X-Google-Smtp-Source: AGHT+IEUzXUajWE7NWxCs+sl4jnxDCzewliCBfPohtrMWKyQzYPRrVvK+cmI6/ZdtUdp4Zf3OtHTMA==
X-Received: by 2002:a05:600c:8b0c:b0:471:15df:9fcd with SMTP id 5b1f17b1804b1-47117911c51mr48689275e9.25.1760778838813;
        Sat, 18 Oct 2025 02:13:58 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144d17cdsm121034215e9.18.2025.10.18.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:13:58 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v7 2/3] i2c: pcf8584: Fix do not use assignment inside if conditional
Date: Sat, 18 Oct 2025 12:12:57 +0300
Message-ID: <20251018091258.5266-3-chiru.cezar.89@gmail.com>
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


