Return-Path: <linux-kernel+bounces-841640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF9BB7E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA024A3B97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3872DCF43;
	Fri,  3 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byHNo2cj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2872D0619
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515878; cv=none; b=QauoyawatuXYC53UaIPKG2UhDa4JWh5cnY7JWX5bSmkLn3cxeCD5mOVINTTLrAoVU7uQuLCFn/gF7f8FP12rwgGelhYg0IQNo6FMgS9eDlm9PKxdjlzddkyOm7tefqIwHB80lpcuY6qiX0NHlzarvXL1VmZBKvXWPRU9rbqsIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515878; c=relaxed/simple;
	bh=JWi1dPRv3vJCqMXY79ZyUqMo2r9f6XEgGFQSh0PF4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLU6OPlf1cZsgdhmmJimIjwNYmsGa1FwSOpghjG5TfHrhvdg7r4RRKldvd3bjPYlVW218cwHkeH1cIEnLeHwzOY/kJnl11NT1UPZdmlCzqh4/zMx++JsVpx1dC/HOLgu2MnhrZkFMhzlB7NpiusogJPrUADYtpdRBwvaOt9G1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byHNo2cj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-279e2554b6fso17706445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515877; x=1760120677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU7VZ7vV5hwPE7SqFGuxKZUDC3/bfG6HT22JnaO2Ak4=;
        b=byHNo2cjEA3tYigtlp8Da67WikbVD9sxluPWW5uGwqXzNWb/UP2vWCm4rOiZ8leDhE
         y98aUQwFXwu/Oa/o6H3gQuHgIzcQtiR3XHv0BTKem+glpUbGhTkjNuor/tVRvGBKSX3z
         x242aaNf41AzwW5u+Cyt6guQDGrzBDaBRRGS88gIYNVmFTQeZyXUY2NhZdPEt0W8WjMF
         er9DCApnOLOkCIqd+42pt4Z4dz+3P71bhyCsXvkh8wQMYP6MF515PSQFC1TFKYgSbM6Y
         /JgOeHeBW38hPj8YUzVPA8t+9DT5T+3szQJp5gjTf2r4vVIh16x8mRsoL+PJmACXdq3w
         EmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515877; x=1760120677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU7VZ7vV5hwPE7SqFGuxKZUDC3/bfG6HT22JnaO2Ak4=;
        b=rC852yz+0V3hy3xsK0+q3/07Xzks/eWiI0hgzaBIc12lTLWzuPTFYu5eB3IyOmKSAu
         1fobjBKhoeHGdHQDZEC+Db3J8mCDrgoEFQs1w63e2ha5ajb2draiAvs/DZVcfJWdJciO
         FjJ41sWNfQ3aceQ61QxpKdXR76Goz+VPNVTVi+7vpnGhOb73pm1vx5or2n9nqQofxDFF
         0URuCJ/jz27tnFjP7qFv87GYstsoYIckeqARsxB2dgQZWRA9P+2Jy28knwjcifr/ySnJ
         i/MPSlnAiVCYamekmWAyTwiCbm3Yrl53L5MWMf+H7QFEa3PBbEyQMNylCooVTpuZbPCE
         xlYw==
X-Forwarded-Encrypted: i=1; AJvYcCWTb3H+6ZYdtmq4Np1WI4MwMDwlfn+BLf9U888jQpDXLt/wpUSYRsgcpOzuhQXoAb80oSOG0ulkpPi/26g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfC7remMJWMjztedAR3if2iEaxZSn+YDJDBJpLgcp/I2yFHolR
	9lMOievoedLkrB4FMQ6JZA8NU1+vxH/1AGXthlRkolQK9Tsb6yT7GPk=
X-Gm-Gg: ASbGncun/kVn1LMl9QNdsmi1nqGujxbO46jvMLRuAzQA6Bxe4XB3A0CvaIwSZZrxVhT
	PX1i1U6F84laQEgNMXn1d6bT/W7JTSI3Sh1cOcCeRLqEKfD2q3fPAsz1Pp0ELOcSY/zJJ7p0EK7
	El1iX5v259pwESciQyIe3ZKQRTNFq0lolY62ISAbSiIKa0g+ZQAxIHqTHddbuT8+7Y2xoo+iLG8
	SfL/aBUtQQVZMeBCeywjqGCWmygbDtDImxRkBzozPoS4d20ZM482gByYoO7c85Zwvxv6mLPG6iv
	1J79MlLtm6voiYMUhg1iZThOm7n8z9lGRxZRVyhcAmtb4jhMnj74B+4XKkjDpVxJreMOjgGipLT
	B1XqVDvKqFkGGy45nhN0COW13nJutgM7EL/f1KH1tGWnxSBtdfU0KkULCcU1NFLQgL68Ebq9op3
	3LRwdbR2os
X-Google-Smtp-Source: AGHT+IH5QhP47DXSnOQBBU7jylbK5b8cnwHLes24+MrTlxFkvQFuCftLsMOaQ91gvww1HCvpIhSTsw==
X-Received: by 2002:a17:903:1b25:b0:28e:756c:7082 with SMTP id d9443c01a7336-28e9a546d94mr46300255ad.15.1759515876493;
        Fri, 03 Oct 2025 11:24:36 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([2409:40c0:106a:c9b2:3d7a:7a89:eeb4:6f87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1233c1sm56773155ad.47.2025.10.03.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:24:36 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] iio: light: Fix typo in variable name
Date: Fri,  3 Oct 2025 23:14:25 +0530
Message-ID: <20251003174425.9135-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a spelling mistake in the ltr390 driver:
'recieve_buffer' was renamed to 'receive_buffer'.

This improves code readibility without changing functionality.

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 drivers/iio/light/ltr390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index df664f360903..277f40879932 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -121,16 +121,16 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 {
 	struct device *dev = &data->client->dev;
 	int ret;
-	u8 recieve_buffer[3];
+	u8 receive_buffer[3];
 
-	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
-			       sizeof(recieve_buffer));
+	ret = regmap_bulk_read(data->regmap, register_address, receive_buffer,
+			       sizeof(receive_buffer));
 	if (ret) {
 		dev_err(dev, "failed to read measurement data");
 		return ret;
 	}
 
-	return get_unaligned_le24(recieve_buffer);
+	return get_unaligned_le24(receive_buffer);
 }
 
 static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
-- 
2.43.0


