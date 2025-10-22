Return-Path: <linux-kernel+bounces-863986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A113EBF9A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB93AB5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1A20CCCC;
	Wed, 22 Oct 2025 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViEbdo5k"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A3201113
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098009; cv=none; b=nwAVOfaQXNAlqPebNFa5gYBQFlGk6ebaKwiTqC74Eh8x0LKa1dCGUr6U5ps4EVsBtF0VYXLRzUcTd9bOnGbPkPKiZqgCU+iJC+nmpnMnKg51kRU+QYdHysZCD6lDmksLtnc+2msxsfZDbXe0P9BaVKNIIDjISqEx5EKE0OOdvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098009; c=relaxed/simple;
	bh=B1bHhmf+wV5gJ93JsBXBKg3bVlLXpgUEv6CQ7duz82A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0W7RSR7wM+CQb3jLMlL3OMppPgFGe9EnUc1UxjqcK9jjvR+n6ViXWU3F29yLdCuFC9dYVzuBmrk3un3o/TXzGe1wGQhnROsLDUkCEOY+GCbKSirOFDnex6JSzbM8Q7ZtHKQnuifYXPzyJGevd35iBla1/naDY/AYdsZNhbzAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViEbdo5k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so29639765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098006; x=1761702806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7bIeWPyB6N2/Vx1az8bXwr5x8Js5h7Lo5yfkBnc+lo=;
        b=ViEbdo5kwfVASid0aWjo+Fyg1YE1YQHkIIPKcTryoKQd/Wfom2S0NpKkUuQsqqF/dY
         9gjV/6Cc5Nlzre9J3B8Cz25RHld05xRhypGVqlKl1E/foj0V38vTBIBJzWR5x2ZsynKw
         TuHqFIGvcjIPbGckLlhLWjxj2H4OfuabTFSvbiTsw7epZyKsfT6+DCrYFEVngWeRFdzQ
         mrz7Pi3lA/vRo/7VrXNhIWFE5fNmJtB4nu+pfOTHIYlBnZTZ32RcgMyTK5ByMSUpa6At
         UrmQ4W/zchk1hLHC1LKiCU71MaPptHfFRsrYAwbFAveDNi0BQpVVqRhQgvDyEpYBdvhk
         ABvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098006; x=1761702806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7bIeWPyB6N2/Vx1az8bXwr5x8Js5h7Lo5yfkBnc+lo=;
        b=H2p4ktp1mWrW/Q713VABmodknIu5FEK5t8UDo+7aGzdtQ7fEH37R/g4cAxzabA+G5G
         qcxOMP/g6MmVaRykv/yY5FsEzcnoY670//ECFhl4EkSvpA2QramyXcyQUoUUoOtZsUKW
         976rQFgNO/TujX9AxKUUkJZLvx5MGzBnYltNMYKmAqwTFe/s7rIYQoB264xcKslQP41z
         0Nv3xB65GRKXZnBur2MnyWmGuWUmMro39JDP97j0+L/DUqwecxlvn28Ab+T1g064++s2
         DbfM/O7WxNkuWzRWUG7F94OyTFTU9akIX2agXRcNneBTX1t+at1tbdJcPvhCMYU8AWu/
         vQZg==
X-Forwarded-Encrypted: i=1; AJvYcCUX/7hHo/ekSJg6kmm7mfrLcMSx+QiY3VGuZjQN2ChT5xAFC6RIfyQy0Sx/tjNQiX4pQRuCM+0Y/9gQcI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Jls3euHXN0v2INjp2pQAy4D8Xq2HUmEZ4jdY9evUNE2C9sTa
	dqSs3TvYstxrLIIQ7ueK66GH8fq6ZUeoFFtcs3WBh7XCDf2dbqyzCQeUOYW7Rceo
X-Gm-Gg: ASbGncsl5eDHDLaLbwFRj6U1o7vLQp8cF9Akp1opwvj4iF00n7gSNXOKnzoWKvtoxgC
	gP4B51HG97K/53xN/0tTFdWynpGx/9Km5eSNWWqSyLhdfBvJs/kDrvI/E/aAYqgesVGyqGUuDSC
	jmYrltO6jBJxwdluJrqhiCw2KdaZm6NzJo1fDS3jBmDY0Sx7X4y2XwznVwqsBase/vuGwp5yb4O
	rwS+Op8t0mwWOFyv6DvsKP0Li8CJiiagIhmFD+6kThlyeSKlx/57YQZiGCuDtMmUjQJIzIXK3Sa
	sFtuJUA7d4GSG8ZeDsYATEufpvdq0Wk3qnJrmLEOnPOPIzkwcuh3BJ9YyF7gKQcFw7aVmSRGBjF
	1345G0qCa2RkgKLSzNP+X40OGg+xwlLo6fDAldvFerYXbvAIuSEjtbJ8gcjy4wsT/sF4IHLd/k1
	howNXme3FBEuhnk3k=
X-Google-Smtp-Source: AGHT+IG9WDGOUicPjGB2rfzPZQ3/TTKt77LQvHjsO3zBzUiXL+ku8609E0n9vIdJ6VbyW6js3sP5UQ==
X-Received: by 2002:a05:600c:4748:b0:471:12c2:201b with SMTP id 5b1f17b1804b1-4711791c503mr126967895e9.27.1761098006305;
        Tue, 21 Oct 2025 18:53:26 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm18557345e9.6.2025.10.21.18.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 18:53:25 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v8 1/1] i2c: pcf8584: Move 'ret' variable inside for loop, break if ret < 0.
Date: Wed, 22 Oct 2025 04:52:13 +0300
Message-ID: <20251022015213.6988-2-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022015213.6988-1-chiru.cezar.89@gmail.com>
References: <20251022015213.6988-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require spaces around '=' and '<'. Add spaces around binary operators.
Enforce error fixing based on checkpatch.pl output on file.
Move 'ret' variable inside for loop. Then check if (ret < 0) break. This
improves usage of ret variable.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 41a81d37e880..d1b0e55fd871 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -183,7 +183,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;
 
-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
@@ -272,7 +272,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -284,9 +284,10 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
-		pmsg = &msgs[i];
+	for (i = 0; i < num; i++) {
+		int ret;
 
+		pmsg = &msgs[i];
 		ret = pcf_doAddress(adap, pmsg);
 
 		/* Send START */
@@ -321,6 +322,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
 					    (i + 1 == num));
 		}
+
+		if (ret < 0)
+			break;
 	}
 
 out:
-- 
2.43.0


