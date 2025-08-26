Return-Path: <linux-kernel+bounces-787329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6207B374BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9AD1BA34CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EA2797B8;
	Tue, 26 Aug 2025 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lghTSjtU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67823ABA9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245918; cv=none; b=qG/yZroi6Sg9nbkLTCvNNr01ALUNJG19lipD7mum31DqGVfiekzgGlbpoNTqglCJ19ea5V7yFycZOIm5+1zVILTSu7Ndu+VHetGDt1Lu5B/tIy3Hrpij4ogT/irtOcu1jWjE3nFBIdL2bI2PIJA/tKLZXA4Pv4KhaSdfpPocJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245918; c=relaxed/simple;
	bh=CcoUYKhr2YqXvegnfI/s8qSchCDEhcQEWbufXc6+c80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/lH9V8bCMQxCDSDIQspBr5Tjkb0bFQcn92AeleuWmqWOUZJNPztVkbkkYMLfSGVlE44K7jvh7Aq8cSNeExBWYObEBtEDQGjGlcxcoJovmR+kpKBB0lW1C8pXGa97sIxa/RLAKaqfUmRGSN5EfG18foRUl4IkRPC+bXj/O1yL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lghTSjtU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a3a085so975742966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756245915; x=1756850715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iY5jgqXj688PFbTycou4DPxWJ19/3+efTPtWXBoI4TE=;
        b=lghTSjtUCih/kbZdkuJUk/4ZnF2cBJljeymmkv8AeBbutNRS4F4/tJADSsXsupSDGf
         tqGJJeJxIfv4VbkgC353DyJGN4fT53KTns5EeY+1VWPI8XcvKfLmil8fg/bhcJhxUn2g
         h/mCOX+OY8l8UC5PuAKFtM6y2cNqlBJhmjofBTAnafzVBFArI8CN8n4Kj2FyyGdDQTXp
         8PS7JsYqtjVvrHo6985aUlzVaKDnFau+bfV0sIogqIWj3eQGlMubmEk6KB8WYRBdHKYF
         Fz6rvTVW/DEvU6fM2XAXElzE3t1ivYpyDTa6p9SGraS7LKYrt+urdBQ+Y2bnLsQKLa3t
         IJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756245915; x=1756850715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY5jgqXj688PFbTycou4DPxWJ19/3+efTPtWXBoI4TE=;
        b=cxRvVEFBeUWg3DSgzjn00vrbMMOlxQkqUmw4yVNUaDgznNGKa1Qnpgv43Lh40iIAUt
         JAYaNeDV3ee7cnz5UcYJGqD8gLbQP3U7DRozqtoKQBQsJ3nPhLz8W7m/ms98yiznCHY+
         9GN31+EARIH0uj6nE2Ni269wSYhTkKNm2sJFaIddEjRjhQfyIF2aLeWXhyMYefs1oNDo
         UJIV48JHOA6Ncp7bebGRHLl4zL72ZUxgyH7aSDmIDhlOO0MwjD9dVwEvyZvOVXqH6l6o
         B2BWTDEImJtRh94cflIJ2ZK5u3rCv2x9PGt46HcQ2dlxi0tjghEqAU0VXKZnwGwXuf7C
         SXhw==
X-Gm-Message-State: AOJu0Yy4f2xOURf7sTlMFMD7iRzd7p2/OmHWiV4yA5PPVxEm4a/QCsjQ
	OMEm4yZsQbUnegW9NmMfynZhX3IsefRoSo0WsFNBLGb03iTstNJ87Oij
X-Gm-Gg: ASbGncsvSwUuILCegCuRcWXM0f4sV1UrOOoTVDbhmYUyIqrtMKZTMW1cT5ojSLmCu8r
	z+2icps2H7fsLDn/q8e/rFZe+xaBzTfa32UesINu5p5RMloZcZNqTsRLrlG7XzIbsR3BRvK3cdR
	OArCbBsJETmGsrmvlrC4s8K+jV2aRHkzdFkDHvtV2juK+ZV9xjE+KtHNozJ3Av91p9Qw9AsGlXW
	7sB4m2x2tyLUayd3POUWZr13NEUn5/zJP2I/R1kNEFyh3N9Z3MwPbQHzaNLGBtb3aQg5YCWYfG4
	asvEhZIEAUVbwl6iedM9DdVnat7bmt2JlKIf5WqMcukTu28iY7thhabwUdnGJNQ3vrfGzO/jQ6l
	LuToYswhliHyJs2iVoN1JOfNLQjpPjHEBtEzTdlNpOXvvlaMZA0EAX0OG9UX0NFwOc50XgLqrfZ
	wHuU2w
X-Google-Smtp-Source: AGHT+IFzEwVcxMfQ7XalQBhmYFyxbLkLDeKDjgoqS30M2rsyVg2UheDko9Zat6hdGvCGTyCQVsOfPg==
X-Received: by 2002:a17:906:6a1f:b0:ae6:f087:953 with SMTP id a640c23a62f3a-afe28f8581cmr1691238766b.12.1756245914523;
        Tue, 26 Aug 2025 15:05:14 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:c431:8253:5fc5:acbd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe849d7e6bsm481602066b.61.2025.08.26.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 15:05:14 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	dpenkler@gmail.com,
	matchstick@neverthere.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] staging: gpib: simplify and fix get_data_lines
Date: Wed, 27 Aug 2025 00:05:02 +0200
Message-ID: <20250826220502.210485-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `get_data_lines()` in gpib_bitbang.c currently reads 8
GPIO descriptors individually and combines them into a byte.
This has two issues:

  * `gpiod_get_value()` returns an `int` which may be negative on
    error. Assigning it directly into a `u8` may propagate unexpected
    values. Masking ensures only the LSB is used.
  * The code is repetitive and harder to extend.

Fix this by introducing a local array of GPIO descriptors and looping
over them, while masking the return value to its least significant bit.

This reduces duplication, makes the code more maintainable, and avoids
possible data corruption from negative `gpiod_get_value()` returns.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 17884810fd69..b6d1e650687f 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1403,16 +1403,15 @@ static void set_data_lines(u8 byte)
 
 static u8 get_data_lines(void)
 {
-	u8 ret;
-
-	ret = gpiod_get_value(D01);
-	ret |= gpiod_get_value(D02) << 1;
-	ret |= gpiod_get_value(D03) << 2;
-	ret |= gpiod_get_value(D04) << 3;
-	ret |= gpiod_get_value(D05) << 4;
-	ret |= gpiod_get_value(D06) << 5;
-	ret |= gpiod_get_value(D07) << 6;
-	ret |= gpiod_get_value(D08) << 7;
+	struct gpio_desc *lines[8] = {
+		D01, D02, D03, D04, D05, D06, D07, D08
+	};
+	u8 ret = 0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		ret |= (gpiod_get_value(lines[i]) & 1) << i;
+
 	return ~ret;
 }
 
-- 
2.43.0


