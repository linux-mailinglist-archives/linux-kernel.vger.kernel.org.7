Return-Path: <linux-kernel+bounces-856570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CABE4802
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31AC1A67795
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12B329C44;
	Thu, 16 Oct 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4dO/SMG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA02FABEE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631311; cv=none; b=pxqsPdlLZe4DwJaj2NVr6KtWEKDaRstiS2cy5NzyhwfdI47GT4dd7/0d18vBhFmqVGpOvzlW6JUNiB8P+zCqci8AWNYHKD4WtNQrqi/T2CcShua5ogOR8j3f8RCZ/u7Djl864X0QOnqvwzJ/RKBFD7iJHd/3olialhlgnMTyOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631311; c=relaxed/simple;
	bh=1S7qkacQtOJLn4B5dSDEdf4PQhZDBi/JrvSfER614yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyUxVvOCQf6xiv+9QJ2bqXJK8tglnSQFq8P5I3Qp/ivAybuJa6V34sXNfH7ObV56F2pAdOANNOvB6XP6e0F3U2T3hx4Z+BxaIcKa6dr3EAk4+HZVf8d9mtpV+W2BNB8UgXZI+P3LXuVWKNzWXz0xrdt9qAhqV+m5LUDMEcoS2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4dO/SMG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so5187495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760631308; x=1761236108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ5MmPkHxZioIeQfPFm5x4+gWD/pC2wMeHLaiRdBbYA=;
        b=h4dO/SMGUjf06sdezexgkxWFQaWEVWunlIje+Vp/9z2D3/TF6Ad37dk0PvbodLbXhI
         OwqnY/ef5ENb+790W/+folYpzhwAwyDVZPH7DDd3L401oSqPtymwBz5soDil2wLXxuip
         uUVX/7IZH1IRR4ct+/zzwVqyodAYuT5SFt1ct0Ol9E7weVf1yECOXQtiCWNBdycahseJ
         F0omWbtrj8O+YbBm4d77TNGf24kYj2fP2gg4slTFJs2F+9FVDhaG6mLmE6GAdxEXBcDo
         KSyB5c/hKkpDoFklq+gAUnUzWv9kIQ1nXltJ11QKpq+LH5mJnSKEh5P/UgepFw6SAHKk
         IHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631308; x=1761236108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ5MmPkHxZioIeQfPFm5x4+gWD/pC2wMeHLaiRdBbYA=;
        b=Eqr2YaWFkVcMzS1ZQdIfta/6+gno0/bHwxbAJzeGG0wALpB2+HUHLZUa4GEnAAarJ1
         ClQ7rKai+xNJ5alEexBPqwFTk2UQRdjJ6g8qxmL8TE63SbjlkYml+QDfhE1SIdVMVt+A
         sUhj8PSs5DVRiQV9cBddn12zHLqH4UfO6cDeku6/JFMGU8VprDhU0GVvdfHwjx9OTdf2
         XmFPhSVo98FfbBxOmhHpeddr7hqEhezAC2ZSHCeWgHjxtt1CNYsYjzhqNFfrk41NN6yA
         N4kMf0PawqZ48bxLWt4n09RzvThlJK3211Qn7HSZY7LDPT0E0E82RO/90BfWKFtmvgqJ
         CrqA==
X-Forwarded-Encrypted: i=1; AJvYcCUwSkBozfqIdlT0uOiwg4JjbDoNB9whrGWeh3SQtw6QwLEXdiw47CNNZrzSaRW+b/McZ2aso3j91Ny5OrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLnxQz6ZPcKIWK10NULPpvA2saIIrax1o8DoX4SoMoAAr130a
	y3ZPtNSPoURV+7VIPCfhKR1PbHwW8Rq8mgzOCtpdTfHx2wZk/QvISSvIGW/o4Q==
X-Gm-Gg: ASbGnctH98X1qrg++5gNLDzEakFSRgNYTVGjAneM+xZOyjZ9W0zPOyzdFDrI4BZ6ULZ
	f+RtXACIXUW+K8eCSeLNvYkoyOAA1bt8mQp96IRx2c3iP2fpyHBQ3WxsXc14dwvXy9OTGE62nj/
	AipT/a+ZNdTf7S14aWDLKYN4bv8LV0qsTsfMJAngH4pCLKAC1Qso5PgEvAavjvQ5A154DiRinR/
	dXOJa3hgo5CHM/H8xDIrSb3WsGvbTz7rtuQ7YR0pI7epBRh1rOCHU0qppUIvgcX3A0KD3sNbwIV
	633iZ5FBw14Nxh0UsLaXhrfHGzjLlXyN99ft3n1+kcBjOlLN1wBl9juipuD6H+G/Xh8BeKwvseL
	buM/CAUkoGtwiG8BW3bhOs4q9RlAbogXxmmPITnge+rZrR2qMARk46P9eBus/WQ8hQZpITAz8YK
	i9CPX6IQiYmTMtB8G1
X-Google-Smtp-Source: AGHT+IFze29dl8vMjJDBxLAzhOIyds7dSrfcHIK9v1xZIW8d3NBlF+kSTR7WBTP80GFdC7rAjNgDTA==
X-Received: by 2002:a05:600c:5287:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-47117874810mr4363165e9.3.1760631307981;
        Thu, 16 Oct 2025 09:15:07 -0700 (PDT)
Received: from hangmanPC.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471143663afsm35654025e9.0.2025.10.16.09.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:15:07 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 3/3] i2c: pcf8584: Fix space(s) required before or after different operators
Date: Thu, 16 Oct 2025 19:14:17 +0300
Message-ID: <20251016161417.15545-4-chiru.cezar.89@gmail.com>
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

Require spaces around '=', '>' and '<'. Add space(s) around binary
operators.
Enforce errors fixing based on checkpatch.pl output on file.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 41a81d37e880..d675d484fe66 100644
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
+	int ret = 0, timeout, status;
 
 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -284,7 +284,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 
-	for (i = 0;ret >= 0 && i < num; i++) {
+	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		ret = pcf_doAddress(adap, pmsg);
-- 
2.43.0


