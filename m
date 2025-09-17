Return-Path: <linux-kernel+bounces-820849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC35B7F727
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167237BCBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7531A7EB;
	Wed, 17 Sep 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICoWZToB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4532E75B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116200; cv=none; b=lb6MR8edK2DzzXMPdQpZB/l4rEG8t+d2wL64T52PoFbmjWd+qwJ+ZSFzAxd5JhQ5xgQsypOsm6GzQ/xKk62XfI7PyuKZ584cBxHVLgnJIGuC0Wb3IkBa8ho6L9RZebcEfbAVpdf2LYl4zDaXdgJmJqTA0fQ3RpGKcxvJAt/lpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116200; c=relaxed/simple;
	bh=Zz0IopogDoMvhYvB0P75k7TloLTRPPBtZlmYSUPEptE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo1JHE4czflUU5Dz7wtWushrOxD9X+KTnIevGWkIo+X/UrGMXgs729dBTyJoJnof3GyLyw2wqmewwFrz5xIiC6yQVzaie6La9Rm0HgP0EiO8izkpkz/tKjnGRLvOATNyyBwCNn/Hqa5aQ4VCWkNGYbTDPiRpmjbu7PiC56zTqm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICoWZToB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2c4c3853so18842815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116197; x=1758720997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze5DP8lBOEWJ8GFCJ1XOs6/oD1a6usgeVZS8cBMdDlE=;
        b=ICoWZToBYDCAl+zMhnOt/WiH8CL3oiK+Qfx/kS2WrLK83RWBUchroX7CMXddFIYmI/
         JkHWCc7dFUi+ULftShy229CzGZWrS+ubP5/KHFqY1nNxqmyBw7wHHwHvnoEoFDGrxho8
         imfB4ZDC+ARdLlq+tJtXHFeoH4fMYC54Q/Lki/RUfqvi84YKY/Uz5LuLJ6QRoDBwoGIn
         +K7SdOt4gAYjab/d10fYFfLlgC4InLlBFw8fzScFcV4nuTSU9qbvJyxzmoZ0tD8zvNob
         p9rbokNQlL3U9RfwvgWoWgw6itSJ4qcoPjEOrMWTBiNxZsik1CJptFsdD1olTG3XVMUI
         CISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116197; x=1758720997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze5DP8lBOEWJ8GFCJ1XOs6/oD1a6usgeVZS8cBMdDlE=;
        b=xBWVmMyqc5ymc5Z37sz/5c9kE1RGX4cpjadYnW6tUm10U8j+WN7MwhkOJiq3ViXCOZ
         MHF4r4koy8R+38s/LjlYkDQuKPEg4FWxhhu9lJAdt8beyxT4RQYYe5JXaKxMLBZuuIr1
         opiubV66eSYTDsBwZNmdx3nYYgydM/j8Rp3KI6zL2W78GOr2aTNlwlGK/vUDVabQZxjy
         fcqDHFtJNzdsu+LM7epQj9L4Rl9sjhnqIUv79MvekDvcic/2FK6y8iE04OLN9XSDOK1o
         nuSJ9JZwWJkn1J6DK4shAxDiwokDpsXJ1wvWru6KazYISrJw4bzVnsL17SUctTxSkuRF
         nPUg==
X-Forwarded-Encrypted: i=1; AJvYcCVqihYhIPm+AQplpoJj1k94pMpibs0x4CRTlyebiXZiRTH15u3JUsp/TOD5QEBfgFEib773ph2Bz0JH4I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXW/p8if4D2VDkz6LwDSJB6FxHCBvKbNb0Sq01SVKC82VHZVE
	iVw6YozjkQFgJw6Aro2NIjfUVXynRmXhaLtY7OupLVt0IT/T9nEC+FzJ
X-Gm-Gg: ASbGncuTBgeOKkcmvWcat0M5f1Er0v6QiyRDlD3Np74UbrY7/V5hhHXH0f1Ws3b1UCp
	WHPTP3xkO3edaEysxHdr/yJbTjYXuhUVi2Q3qn6k/BD83wQepzZV5sAnVcjPgHPqI8nJM/rbbst
	MxP491ywFngAQloTkI5otvKBJuzndFP9We/+WcrJczdoM5HH1T+i7/L4tDvpzIIdkrkQ+9v6/SO
	76TCq3dB6B5VtIWVQUWav7EDVbcwJaw1k3ar2Gy5UwdtxJ3vzBB0gYxPd4SOlWF5X7slQLTtP68
	jDlrT/QRyZc1uT9bj1Xm5bQQkBXZuazdI2ARYY0rFAC8ZmtngIZRL1ggEMDTwY/T6XD563dqpB+
	UbnvOWzwc3XCKB69HQdJxLl665916dA==
X-Google-Smtp-Source: AGHT+IEgHr69wasYUN/vjySljN+1+rUxqFqFWAPOwJ+y4oYduihftX6FWrGrruJItBCX9veOlg7bpw==
X-Received: by 2002:a05:600c:1d12:b0:45d:d291:5dc1 with SMTP id 5b1f17b1804b1-46202a0e8dbmr22930955e9.15.1758116196764;
        Wed, 17 Sep 2025 06:36:36 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139ab391bsm38198075e9.21.2025.09.17.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:36:36 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v4 3/3] i2c: pcf8584: Fix space(s) required before or after different operators
Date: Wed, 17 Sep 2025 16:35:24 +0300
Message-ID: <20250917133524.85063-4-chiru.cezar.89@gmail.com>
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

Require spaces around or before or after '=', ';', '<' and ','.
Add space(s) around or before or after binary and ternary operators and
punctuation marks. Enforce errors fixing based on checkpatch.pl output on
file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 598bf000bf4a..3439b7387a54 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -223,7 +223,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;
 
-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
 				buf[wrcount] & 0xff));
 		i2c_outb(adap, buf[wrcount]);
@@ -314,7 +314,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int ret = 0, timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -328,7 +328,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
+	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
@@ -373,9 +373,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 
 			if (ret != pmsg->len) {
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only read %d bytes.\n",ret));
+					    "only read %d bytes.\n", ret));
 			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n", ret));
 			}
 		} else {
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
@@ -383,9 +383,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 
 			if (ret != pmsg->len) {
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only wrote %d bytes.\n",ret));
+					    "only wrote %d bytes.\n", ret));
 			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n", ret));
 			}
 		}
 	}
-- 
2.43.0


