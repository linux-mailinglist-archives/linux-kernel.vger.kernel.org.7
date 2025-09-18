Return-Path: <linux-kernel+bounces-822796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F5B84B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E681C216B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A43043C6;
	Thu, 18 Sep 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuhjaPrb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E9303A31
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200144; cv=none; b=gW2wqaysyx8KIoUKs9m6WOCFClUsoDnV/K2coapS21XDd8YffGE/Q+Dd7uWm4yA3705L+SETJ1EzREDO3a1eAinUYeMWV12s6h9dii9NayEwmJDdaTeyPsuIJIu6J6TBCHuq8FM4TlC41AFHiBpVoEAOkZX4iAoIwRcThE9gE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200144; c=relaxed/simple;
	bh=SId3DB5hqfnfahVT0z34tvWymLGz7H03e4wdeT2fwQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNZlKQkinG56aCGr1HAfIc0t5PVC2iv93C5T8EuXLSN5/J8NwL3paAieHTCV5ZuygVXQz9d3okXP3E/NqYbOTM5wWRC6mcjYbLLE7fsLQEOCxlLrAAkYpwWpmqPzwNJiUzBQoT8rqbO/ADK//fM/74U8k2PbmJUqVbzGUyJwGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuhjaPrb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267fac63459so8431715ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200142; x=1758804942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PMaQk64QLYvKLuvrIkNRq4RT2wpYqM3eFsm/MQrmOQ=;
        b=fuhjaPrbuoIv45XY64mm9g32pBv/ambHaaS5mOj+rNyjBG3dRHCuS+peMpVtcHwaST
         SLZCqefArI120NYYln/AEzKiQACWkN6OwINyPYQr8QT+WeLvldNHmDFPkXkPl564bCud
         jzSugu0a3EXhNMpAIZs1aDvProQQftvS/qE86jzuQEAgd2bKwfkqROH6MDxYE6ajH08S
         34o9fqu1StPte21yqKQnni1dGoRcAAeEGDwqwrJ0626APmOkujdIbh8/NNdegW9rcMP9
         u7Tg096Izi40mw4GG7jDEAOasxiVAM488zgNUsoFu1dVVh0lYYB5MEzrRjdOrgmj/Gz9
         y/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200142; x=1758804942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PMaQk64QLYvKLuvrIkNRq4RT2wpYqM3eFsm/MQrmOQ=;
        b=rhBF0lqWFEq3KUbrNtOquAKnZkBOvdljYLqHnMrSjssMo2C8vZbx6QcP6/koqxJuYC
         xFwQ9LZa8cQoH+QwZjCIal25/O5J48PP1pO1pnHYOB3jCi7pd/hHUqx+yd6wbxxX9z6i
         ZlsgFDaGaEZgIz4COqgtuSZRCQKbcr4nHmMKZPrdPMDL/z+vusjzDeNaUyTQkdGclubz
         nLkl0uMboFUhY5KBEvUpzMLGAXRKIlREzTeaPP+BloA4gO+AaOI+dfbUGp+tr27l05Qq
         JxW/1IQ/iBRwxhc0XUa3KfQFsGbZx2mtZzhD0Y+MGAtb7GGpGIE+sRk0IbWBPB/2poWF
         jd/w==
X-Forwarded-Encrypted: i=1; AJvYcCWHeyZGaLALC3TguQUMbyZw/6Twok+LnZaz9FRv5a7IXvHpoQn+R9QL121FX0D7LHTu8Mp5sjIgHNihJsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQk/vNYPILkId+GALqz5NmbUrAG+ZnIB7XQ4+p8g0Cro7ANjb
	2YiVd6iq6s1OmNA7HEOATNglXR7y5ZrdMrwYq70NqKlj2Xc0GiFpYh5e
X-Gm-Gg: ASbGncuvzBC4BVkQd2qLT8vLy4x21nPHuaWY4zvWY2R1zBAHefBxeqQ7CKqQ2edI+Gw
	uK8jy7fkAMula1hq9Ql6qN/YyU6NEkc8pKHHGznRoVC9MEX9WpegfhYVTaOl8l2t3boGEgdwjQH
	74tSSsI7CFeP/6aUviGa2PaYvExurij82RtRV85TZwj2aoox22wlZZa6HOkrKmTlFqeayUZHN0T
	jup8E940+4dnc0SM2bW9QBmMnRpIhBpaSPKE0LaldLukbw9b9JP/HO4u9EFNaKI/yvwAlsudd3J
	u/o9uJk8YWfjW0fQ3pxQ3mZrjU0dfTvDma28sZlcVLQipKNST/nmjKXHrQypZmhUC3xnT5rJryd
	ztgdf9L+GyduT4rPXRRgucgtoriPoO3xMkVbKe8Eu7XM=
X-Google-Smtp-Source: AGHT+IE4Evwn4n7oEvkfL06fZNeaCExpJfqe2hcm3yPgDmXEurhEs6dJZklynFlriLWZbAPRGw8rVg==
X-Received: by 2002:a17:902:d4cd:b0:246:d70e:ea82 with SMTP id d9443c01a7336-268119b2be6mr84670615ad.5.1758200142591;
        Thu, 18 Sep 2025 05:55:42 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c076sm25939065ad.42.2025.09.18.05.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:55:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Dan Douglass <dan.douglass@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: caam: Add check for kcalloc() in test_len()
Date: Thu, 18 Sep 2025 20:55:21 +0800
Message-ID: <20250918125521.3539255-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing the buffer to rng->read() and
print_hex_dump_debug().

Fixes: 2be0d806e25e ("crypto: caam - add a test for the RNG")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/caam/caamrng.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..003c5e37acbe 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -181,7 +181,8 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	struct device *dev = ctx->ctrldev;
 
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
-
+	if (!buf)
+		return;
 	while (len > 0) {
 		read_len = rng->read(rng, buf, len, wait);
 
-- 
2.43.0


