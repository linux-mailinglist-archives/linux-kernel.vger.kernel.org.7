Return-Path: <linux-kernel+bounces-615872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF400A98380
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47796189780D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83E289358;
	Wed, 23 Apr 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4NijQWT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B72289351
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396641; cv=none; b=JboMV9phU1/w0liPCQcOIUzsI45lv7GxdhZYdCvejMIsAJVdsihTWGy9sxC4V5XqjmgBPCdPWkOG5Tq45zXPMKNtcTCJuICHs8TA/wSdZiDGKDe3LtsXiP5G6As2R+wZz3CyYk0hKKmdniXGRXFK0E6WV7EoWMoZkcD5yta/fpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396641; c=relaxed/simple;
	bh=9AoM/AIPb3N4elSC5sH2DHMkFgmxak1AJlaKm7usVmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AjEJODZClq0+Paxldg5KtAFXp+uoW0XfhYVeSSUWA0FbhFVIuEm9dWwOoyxw4f1SSECC0M2qi1yE+gffZu9OfIZG+0aGUvbvnMsSu6gh4dTdIP9kQQPIpv57vuKJJosyRp1J1yWCMm5i1CZ/NOaK/8Kx9H8SbY45HscAwRtIXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j4NijQWT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso29233735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 01:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745396638; x=1746001438; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y01SW2UsKHrmSkBJiFRdXdGr5Bt5eDkwEO8sgbkacPw=;
        b=j4NijQWT3Gg1tDJocMoFEem4SPvLpQNMi3fnLglvwIhwRm06Ip/qae0ZxWvzzh55Gh
         EhYRxQzZj90KqHQ4+Ae07w+kCu0BAZEj4+VdXZg35PXNGRzV3miI6t6OIRWnbU+bQkJR
         ABNtMCpXYSdB6g1bEQdzWBJTbSXW0Q+xtlxCSDaegFVTC+d6rN6N3xopJEBu25/7tveI
         UMfl4ksJpz5FTbqR9+UfCqTlGh4Oey1A8XHo5/EwBCV3XJ8gLgYwvS0mRs6OfWJUZJei
         TdfG8elIZnZswCnnVM0OCBXUrxPZCwnLHWHFO8qdoJ+Oe0CqXcMi8tYdW8luSz5OLmSK
         vhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396638; x=1746001438;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y01SW2UsKHrmSkBJiFRdXdGr5Bt5eDkwEO8sgbkacPw=;
        b=hl9kDiRqAGL610y2JQ6iSMz2zU7uBNgIBuyL6zSB0MYz1O3QvNKa2U0jCQok1D+RgF
         hz+D4zM1HsIYuvFbYgzp2kw42OOHaNA/ZafCvsf9x0cc3Vggiov/cxFyXaIRUIkf6pHH
         8Pz/ajU0egL+jO2uw7vJXmY/G/1h7ah4H3koRsY90cAmh2jNnadLHkYhckuwsNK21d+e
         8yQW7ZQzCCN6eNmTRaILHo2+1+7aHCANrJOt/6IgzSSLlTUjXquJ+hHSIRTLpS27MJ/m
         ES4sPMvAyh/nhvyKbxSHQJU3t+VYFmpnTtP7qBfhj+s0+ke04qjmayiDzjOw8ikUZa8S
         E4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUDGK6fQfl3RCjpMBhOyNeMw1lWw6Nr88rWw6H/5uYVcA/lHatoenR8z5ng6JK8icTsV7xO4juYqQU7gWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JJOZDzGs6atcWFY6KvTYpizqXe8Ivf1JIfhs4uQrBjkav0wN
	3at7CzPFKH5qJ271jHOb2w3z7yy6p5kZOw5fHsckUW5B0o4mSFxsE5zP/l1nBYE=
X-Gm-Gg: ASbGncu0Z9UUyqLpjIJyq+sYmXJDhAlodvbTqHv6265JtxQ2vPcj0mtUzMzuQ/MX6/y
	1kUV+PGUX2PC8A3bDJBWSyQGNQQRCXao6C+69atKBqvcigwvDormfJRKq5rs6Io1djvxrHOfsji
	8jOKdmC3CbmoR9exfiGCZ0b6roCpn8bmoOIs+mbTK47Fvo5KRICmp3QnndpHbexfm40BXCQI5fk
	MUXj1sC5VgmU2nweW0mvQeWJVmypXzvfQ7JEuzKIK0KNBzXXr8CqYrhl53rRAoUtDzPS2/fd8Gq
	SQzgbiybAWF3sktBPzDi2upeq1UxyMmCH5dkDlhjvkYJLMbtaZlkguOc
X-Google-Smtp-Source: AGHT+IECPr27/stUCSI1PWk+UsjbUIKYWkA1fnIwKTwVRmawMohMG5diVeFjOVyCEZb5VbXMG1aMDA==
X-Received: by 2002:a05:600c:4e52:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-4408efbaebemr33514505e9.26.1745396637683;
        Wed, 23 Apr 2025 01:23:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092b0a52asm17463555e9.0.2025.04.23.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:23:57 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:23:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] usb: dwc3: qcom: Fix error handling in probe
Message-ID: <aAijmfAph0FlTqg6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two issues:
1) Return -EINVAL if platform_get_resource() fails.  Don't return
   success.
2) The devm_ioremap() function doesn't return error pointers, it returns
   NULL.  Update the check.

Fixes: 1881a32fe14d ("usb: dwc3: qcom: Transition to flattened model")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index d512002e1e88..b63fcaf823aa 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -740,15 +740,17 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
+	if (!r) {
+		ret = -EINVAL;
 		goto clk_disable;
+	}
 	res = *r;
 	res.end = res.start + SDM845_QSCRATCH_BASE_OFFSET;
 
 	qcom->qscratch_base = devm_ioremap(dev, res.end, SDM845_QSCRATCH_SIZE);
-	if (IS_ERR(qcom->qscratch_base)) {
-		dev_err(dev, "failed to map qscratch region: %pe\n", qcom->qscratch_base);
-		ret = PTR_ERR(qcom->qscratch_base);
+	if (!qcom->qscratch_base) {
+		dev_err(dev, "failed to map qscratch region\n");
+		ret = -ENOMEM;
 		goto clk_disable;
 	}
 
-- 
2.47.2


