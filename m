Return-Path: <linux-kernel+bounces-822503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D4B84077
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213BD3B1D93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB932F5A1A;
	Thu, 18 Sep 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRvvxQlM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7A2EFDB7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190545; cv=none; b=T/wcNk8KZddx+wboMTJEv0RgYxsX1kELsx9trt+Ij9GSGmI2FApyPqLfV/YzxMxhRDdLhurwhXZ534LCCgq23Ycl59tvT5Qrw4pxV9M4M3v77fcO+0mHipkqGZlW0tQJWkhWURcavP/j4ZfW6sXJxW5733UvL4aodzL4ShEOZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190545; c=relaxed/simple;
	bh=a5KnwUSk1PbWVS7mlC52gOqleynRC/2hkubAYqM6uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JIsifRbhKHeWMKF9xnK3caL6kzomsvx0p+KZwTS8BpaZfReO5l+PwadIKxzZz0WjBl47fdRKZQnaGXKVgAalemX++/HeekC5iM/eVua1/Sg05MJ5mvnS2ez19rnf8GtbtA6AvnSpBRCpkuDtxRHKW2OgioYU6ZZXJoCmYTsk2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRvvxQlM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7761b392d50so1054171b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758190543; x=1758795343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ul8ElkgeTFthD1gCeDvetsXA/BGz8nMUUjjJgS8RCvM=;
        b=QRvvxQlMTgmOQveuVYZR0m7E+KUESnOo2MdlzhZ+kFxcCd0k08SiZqj/BVge0KC0Gy
         Koep0aQP/rQTAjGtTMLcz0ppDXQbzBeLtAKoYA0mdhVsYYqffCVlXFGryfpDjBrv4jqC
         NqBLLa6rzzMXnMH6OGthoYkJvuxkmqi97+dimLq/7i1kfG10XaW59F8q99QWRTGm66sq
         Pr5dsTn0+O49ki69J1ZFWLhukiR2Er8z1e9CVeT2l7BQXSuRbyYd9le2EoAoLI2033SG
         18Ao/H8+Mucqaiz0ig3u7GEBhfDll3b0jN/PsfCsYHvxfVGKNw2s7/lF1Lp0m5cLHMRu
         FK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758190543; x=1758795343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ul8ElkgeTFthD1gCeDvetsXA/BGz8nMUUjjJgS8RCvM=;
        b=jKEnnW4Oa5RMy2ukm9pz9wGdikutkcR/CacT4DHGdSfGNNYnvCQ3w78Egs9vWFpVhj
         njW2wKVsRlR8W220m5TxsdKAQBtas77NNxgVKIJ8Q+8qb362b7C36zZL5s9C0ONdkSzS
         fMzHaKDfMuNVp3w7WT15zW0H6Yrq8ie/y7xs+i121gbXqfiLF6SDgOayQehqjkLc2MH5
         SIBmDqiyjepJ/WnB3IFg/P+fOcwDaWiTgqSrsQ7NFQT0KzJHsSV2p7kym2fYchJ552xn
         A71ZbXWGfh+YaAvX0aFqMit+py5YRKMPLaYCm1EfcUhLTdl6BfquWDeDq4T6QyLp7ta2
         3arw==
X-Forwarded-Encrypted: i=1; AJvYcCXuKf0Mv4p9kl8lEyAw/8m+B2jwpHZLwGF6Kqmor9M4IXRPpQYBsB/nJ6MpZGzHl+bOehWymqXO5Kg1bMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuo99RuSgwWvLFOmWPR938+tWSejGrbVgVWMLhdHUoayi14FCl
	Vqs2I4IoLP4PXZrYJqripHhY4JQgZsp0io2h4MR7kqdZycDcBaFW+P7V
X-Gm-Gg: ASbGnculxidrLn2mzyQgpnhvLhY9lUSZL/5iVquSGlM0ZsGDK2/bNMoaBxP3eSp7Iaz
	LRy4I2/UBFScHdmFYh0kJcaVqG2jAtYE0IBBbhPnB7MrC1qcps6vCKFETjkbvjBzkDtGH7NPOVe
	v7C0lAmLJ4UI5WLr/c5BV0gL9oRCLSGBUpzjIxeSfQyQM/TVO6BkYlmN2zQv6UjVb+Oa5Z64TMa
	yGknk66SOux+7xal3zDr7HYYc4yl+1Bp98Eyvn+jBPeygh4vMnOgWmPrb1w1sYgsiI4aR4Q5pPf
	twW8usUibwjc2XeWvuoCPenDgdhSjx8dFR33ZTOEPiP8AFQzTSgqY7pdzi0kguZsrtupHLEd3/P
	SJjNvh14ndYaUiaDSEwE7h90FuQFK4w8uI09+LZo=
X-Google-Smtp-Source: AGHT+IEh098LpUQZCcn5N0gPt1Pj74yLqq4l/+KzbDeFs5lavn9UHh3TfGQl7xx/Rwo1+Q0mJENLyg==
X-Received: by 2002:a05:6a20:12ca:b0:24f:f79d:6696 with SMTP id adf61e73a8af0-27a9a7e77eemr8131532637.2.1758190542727;
        Thu, 18 Sep 2025 03:15:42 -0700 (PDT)
Received: from lgs.. ([223.80.110.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32edd97fe58sm4740780a91.13.2025.09.18.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:15:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Douglass <dan.douglass@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: caam: Add check for kcalloc() in test_len()
Date: Thu, 18 Sep 2025 18:15:27 +0800
Message-ID: <20250918101527.3458436-1-lgs201920130244@gmail.com>
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
 drivers/crypto/caam/caamrng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index e0adb326f496..d887ecf6f99d 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -183,7 +183,6 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 	buf = kcalloc(CAAM_RNG_MAX_FIFO_STORE_SIZE, sizeof(u8), GFP_KERNEL);
 
 	if (!buf) {
-		dev_err(dev, "RNG buffer allocation failed\n");
 		return;
 	}
 	while (len > 0) {
-- 
2.43.0


