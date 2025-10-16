Return-Path: <linux-kernel+bounces-856569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D85BE47FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791951A6777B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBD23EA8B;
	Thu, 16 Oct 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EICEMrVV"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5B23EABC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631309; cv=none; b=ekmSgncUuPmUnpBBsoEufXiXR1RYtJaqpmLKEoh1u9aDdfv36Z/yunudzP8UwRvpSZVIbLIuv03bZ+2gFLIUsfugM1vbdvEy3vfmFO898H+9vATp3a3xOd8yOBiBvb+HvK5i/L6s9NQpJR/wR7cNl+xVOfeSZQzgRGQakFWHIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631309; c=relaxed/simple;
	bh=LHZjH2UMXa92SxXhNcHHvMGpkdxmO+gWMcsE10ROlWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5SFScDI+IGIm3OiZOAjQlX/YqYJIxUmrMovnXFkgcdgrld7bRpHriF1G+/s9k4DBx6D/LiyLpwvpMSSVLNPsyXsyxOOvi9eUT9MwzBYP70xqp+3EbWWLRNhFJZ3HTCgnTpyij08PPMDGGAXZn/WXtnZSstg8et7qS2Iupt/OBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EICEMrVV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47114a40161so8033055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760631306; x=1761236106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=EICEMrVVqwZijQMAW2fbczanNC5lCvGCBwU1YjZqYr196Hrc3ejTd1dKfJ9xhev1hd
         ElmtGDTyhrL+y5LZnW4ld0tLEjDXVDNknyI69fLXDkUYpGeafUUsU5j5YF0PF77Spd/W
         SqwQOYYNYGF9VqpPvmqakUuXbGfg1iWfEr65bxFwwi572RkADTEhvjRdTINq8RR1ah5m
         +itsH0X1eMSqA6xCjFHWEuRwke2CNr7BHZTd7/qd0/7RStJnnjg0keTJ2eZMfFLiU0V0
         dDw3ib05GgRhmUXQS9Y4tkFpugBV7GmMDugzj7di3zQ8J3/YD0qltc762bkt7nmi8sKF
         RfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631306; x=1761236106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH2k5qkD7Z3u1A48Y16IYSnGNDzLTVrlHvL80g4n3eU=;
        b=tp6ZD6CcSn4xJle5irXwi6RBRev5I2E1ZtXbWrEm/eZHYO/KQHYL6SlKNEV/pqTpuG
         SrvjVbFLftO+cRr6rQVPzZAvuEdTBA9Ibj7l4hVd+H/TwTOmj/qUQdLaHfEDxgqxXfTk
         SWHH3/56aWyEdXWB6bFgp6b7ZK25wxM8TWfMOJSxMFSs4ogRZH4Ripu/mJXFjPA2Lnai
         1DP417JAEdu4D/+3P9aLPsegElXQDxCcMTnImyb/2JpcepVjRII86qB3TeInm8R3Dl6v
         tNIt2aGnPecVCDGt+fabrv54rm8JJwqNUbtT1AQmJX66lETPltTN2CpzANS1TB4Verp0
         jQWA==
X-Forwarded-Encrypted: i=1; AJvYcCUTSbyGIVL37bizo/bIARP/4rDnXs1Cw47A+VBm5ZqxxBiWVKYFyLLF2mf2eyj9JQ5InSRr74jNXHwoZJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTe1zSmVGbmBbhwEUM/RmZUr7tGnGqHNV+1Mjgjuq1HivVVdL
	JZsI52CCQDHcTpZg3eWGtmOqNyBV7kcz9Wxe9nXwK03CXF/w3nYW97eftTlsKA==
X-Gm-Gg: ASbGncszUoGk7aEC8xfsdh4OyAhceSso5IGzqFoTOdf1fnMSrlYHCSlCMXG6ShEMSWP
	mETyg7sDOtwf5D3NDAH+d8mJPgOtlgbevrIEKzMJvldo4qMjgd5LCbSX9TX34b+iPkyCLIplRJs
	4eenTolnHQpZZKsfHHSmVXPznD90dDwbCLg1uRUf4VhNStWM9/N07cA+xzUyjGPXNcoRRcrkkGq
	/aJUj1HUsTXidd3ZdAaqTuIn8bU45xu8ibL4DGey6dOEuvSu4AaIWE3s6npSRyR80TCl4pGLT9A
	/xkexIVBnFQPXhHxNocLA1LYpldiTH12zpLUzDKKtWzEdhkiQ+G45POHiWId6SB56ROlO8Di0H+
	I9IYDuclE21792mSkGkinazqjbUiywgApVkW4/FOBxQ5zfgYfJjx3cPIFggJcIlh/2qdKX2gf6C
	isXZuhqg==
X-Google-Smtp-Source: AGHT+IG3rVGmDp5olNfg9dU57+0wldzU8oxoJTE26xYya7QDoKqMwVqjPrv0UHx0OszQgqPF83LVow==
X-Received: by 2002:a05:600c:19d4:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47117903e2amr4046915e9.26.1760631305709;
        Thu, 16 Oct 2025 09:15:05 -0700 (PDT)
Received: from hangmanPC.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471143663afsm35654025e9.0.2025.10.16.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:15:05 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 2/3] i2c: pcf8584: Fix do not use assignment inside if conditional
Date: Thu, 16 Oct 2025 19:14:16 +0300
Message-ID: <20251016161417.15545-3-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016161417.15545-1-chiru.cezar.89@gmail.com>
References: <20250926154520.40583-1-chiru.cezar.89@gmail.com>
 <20251016161417.15545-1-chiru.cezar.89@gmail.com>
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


