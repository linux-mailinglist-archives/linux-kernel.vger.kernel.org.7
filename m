Return-Path: <linux-kernel+bounces-756247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B00B1B1D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A9C189D5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379D26A0A6;
	Tue,  5 Aug 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpioAsAF"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0A1C6FE8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389218; cv=none; b=aQMkuWqpulwyAE0pBN54NbLE5CXUqfCGXhmbEGfwXYDCAPM1uUuQJA53xUwPqxXs/D48GmUiu0aUzOH5Ejoh3hYST4QCpe5zRCNjzS1Q64WoYh9EZxhL52Sdn4h7hOm6fNAHOkZLqc4Q2BjPHCdOxr9wQ7oHWnMG4Ck1RqSfr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389218; c=relaxed/simple;
	bh=yHS07nMwU4DvQAKXhw05BCSFbHkQtv4jF/xqOUl6vKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOSkyr7KaeqGq5/tTPOI+Tg2oXCUXvNLoJjbJxBGOt7vwVpcCzpp774S0Fcc5MSsEY6EPcJrs/xNjeX110L+oIBRgOC+jYHkCm2jKG5uvq5Jv57Vz3kUqCcClvqwtVCf6VsxWKNpS/jXFL3j3vD3KY4aMhFPNHDIio4IZSl2soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CpioAsAF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so4836407b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754389216; x=1754994016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ID/O+jpa5Id4ySA0O281Ba8wApOW+JtPIM75o1GLIzc=;
        b=CpioAsAFk+SNSyTqcpZTu6b25BQbEIq3uEXBepL5DFE2yyRZkOewSyBHAzHH/kFTMC
         DuMHTN6yO2YYPMruxnFSaJ27h2InAcevytck/WwYLfAPj3lRPkNMI0aYN8tA6h8d6f2G
         64cNIvhUygUHpdElRifYZ2Hkn0AIPJcVIQsEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389216; x=1754994016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID/O+jpa5Id4ySA0O281Ba8wApOW+JtPIM75o1GLIzc=;
        b=HMqddFLA4rXiZUPqA+sa64RceryaNL+GT2/liM1X+A6whZH8kJb8XRxfgBqNKRM6WW
         zQ5lrGOOW7HMJU+DMbkwpsRuXc0Bp14jOXVyiTdxcUdb/idxZjj4nprb4mf7rhvn9Q1k
         FFjuMwuhnWjsx2LEco5u3SN5XhbdWJoIp5mmvCV5oGB+UqjBnyZx7eM7ekgNZ4NHSB33
         CfJk2awP+n4BynN0NRsRSKnwW18N2tkpS3Q6h2mMTfp25VI0UjjsPfiSjp8+05LGa3v7
         tLERNz+sRkmKOBefKhFzDbZFgiAG7t7HMASNS9Cr7WLKBun839Bs1U7GWGkFCIm4bbkZ
         51ww==
X-Forwarded-Encrypted: i=1; AJvYcCVQSwKUL4wsmfPpTJBjoFGXiAFcWhUAjo4nYhRSfHihYgsdc7fL5C8vScH5bRaY6rrZi7zclbZ/hyWrOzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqcxScTIPGVyyvHQBQn9wat9t4/o9CkjAUE9agWuCqOahWyWS
	dhNo7wMoRMm7kvkIwLtPb5q3d5eXNRcSPxWQIJxacpibOl+fmYoFXJOTdZ2W0J7tsA==
X-Gm-Gg: ASbGncv4+wk9D+TKauRlrhQZdlWze+Uh4TgnR1puGk2Ewl1lqOOcmrCRgZ5LZrUvHP0
	oO8AMCHFYBZnxK2q0BsjauVvGBmdpcmj6T1EMt3U4feDSzxRz2CaPFkwqmynf5WWwRmrLuvQ+GM
	TqL8XGuDP/9m5iy8gIyo0j0y2dhHg3zQqmRuAxRTURQv4/+lcifsYj5c4wWd7LnXv0ngC40qra3
	LRP8Iv4HsfC0xNbo/SFwaTd5bSWp8xxNmuhg7p1VamygH7t2il2JZUj2y2GeiUs41H9f2/cb6b9
	lheibBE7PnFMmiYeIroK3rFVvejZPvofsZvVQZL3eI8LPTtcNDtUiZ8jwFRP7BD+hqtTZG3N8GC
	vQ9B7rlVCS45MN6jl/uVupOmAv6EbaLz4vNN3TMllPizn3C7QmMluLfhW
X-Google-Smtp-Source: AGHT+IHS7XFrrCxOiBykpYR1RvBX10iSlM+rgsdsXMYDtW6cReThVLsKUIzXwtUEYfThTbVIyH+8+A==
X-Received: by 2002:a05:6a00:21d4:b0:76b:da70:487b with SMTP id d2e1a72fcca58-76bec4bf096mr14993206b3a.15.1754389216404;
        Tue, 05 Aug 2025 03:20:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f30bsm12587965b3a.16.2025.08.05.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:20:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Seyediman Seyedarab <imandevel@gmail.com>
Subject: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Date: Tue,  5 Aug 2025 19:19:29 +0900
Message-ID: <20250805101946.1774112-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs handlers should be called under ->init_lock and are not
supposed to unlock it until return, otherwise e.g. a concurrent
reset() can occur.  There is one handler that breaks that rule:
recomp_algorithm_show().

Move ->init_lock handling outside of __comp_algorithm_show()
(also drop it and call zcomp_available_show() directly) so that
the entire recomp_algorithm_show() loop is protected by the
lock, as opposed to protecting individual iterations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Seyediman Seyedarab <imandevel@gmail.com>
---
 drivers/block/zram/zram_drv.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8acad3cc6e6e..9ac271b82780 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1225,18 +1225,6 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
-static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio,
-				     char *buf, ssize_t at)
-{
-	ssize_t sz;
-
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[prio], buf, at);
-	up_read(&zram->init_lock);
-
-	return sz;
-}
-
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
 	char *compressor;
@@ -1387,8 +1375,12 @@ static ssize_t comp_algorithm_show(struct device *dev,
 				   char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	ssize_t sz;
 
-	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	down_read(&zram->init_lock);
+	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_COMP], buf, 0);
+	up_read(&zram->init_lock);
+	return sz;
 }
 
 static ssize_t comp_algorithm_store(struct device *dev,
@@ -1412,14 +1404,15 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	ssize_t sz = 0;
 	u32 prio;
 
+	down_read(&zram->init_lock);
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
 
 		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
-		sz += __comp_algorithm_show(zram, prio, buf, sz);
+		sz += zcomp_available_show(zram->comp_algs[prio], buf, sz);
 	}
-
+	up_read(&zram->init_lock);
 	return sz;
 }
 
-- 
2.50.1.565.gc32cd1483b-goog


