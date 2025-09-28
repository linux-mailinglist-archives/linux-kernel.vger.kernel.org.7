Return-Path: <linux-kernel+bounces-835576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68399BA77E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125127A839A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C329ACE5;
	Sun, 28 Sep 2025 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDp6O9gc"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E9226CF7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093331; cv=none; b=JOptkxQrlYhI2mSNdsBhA+3TCprly4ofOmc3XG6vApZLtAUaoJbs6hI0lpsrCT3COjWv7+flA71+geAVAt9Njhs3B/j5YM883fPOFg+jSeJL3OLY/vzCYBS7IP5OAGUef61c5W+vktBJ7FY49XbeRwYPIsHbRhnS8xreXWYOr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093331; c=relaxed/simple;
	bh=7gRqA1lzDomVvZ9HdJ5xM3tJEYy4qZM4Tf1HKy4xaKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsYmCUgsxGQLSTUPJbWiYQJF547x3EMNihmz3zgAzxVkz3TTIBKu/See3+rf/zpikfFx8qlbOdQ8P1aFZaIW7eYxcAaRL2TT4qzsQNZsMY8oKZaCiet16Repea6OnnkuLfz9b+LPvqkHHl32nd/v8HkcX61ljYbn/xicowOp/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDp6O9gc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2981365f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759093328; x=1759698128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxkm8jE9ToiUS31/wtNowypDOUu8isLYkTQLRPslSVU=;
        b=MDp6O9gctyCkzhG2JANeh0QornOvlUp1gnGb91FKsoLnB93AVLOQ73QBg47oZKhnlM
         +G+QHc2RaGPDfZ0WW9RxUnX8fgOT8boLlthN0zCjsaeE7D5W8b4dYBA5PcmY2mCVj4cq
         bHMw1xiY8ccffu8engHLoR3tBGQNbWZbD0e2CwAAh6jZuO0Q7AgTvSY9moANdqzxQ7DQ
         m0YfbLsCWXxxzRZnxsUEO6UFfD2AxJFead2y0Ks/koaydi8c8w1RhqjMBkl5Ykd9nCqL
         TkQAu4QMtI0x9onMWM9uNZuT01TM/NTDoEBLn+EoupWM012lwTVKMzIu0B5zrUeyn5Jg
         s9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759093328; x=1759698128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxkm8jE9ToiUS31/wtNowypDOUu8isLYkTQLRPslSVU=;
        b=fBopp/xQEKKcCQwi/W69cpHsy1CdHYuvwawvbkaHbAoEfwJlSRK/efYmLHoe9g2rCH
         5hgzQSuNBENWhAZ8S/ncr+em3c5EfAryUuwjnyf8UbX2aOKCuXhtk0dBFMHgi/u9ya6M
         KIJPKbb5qPZjazWlyfiUuO++1FzX590JpUW4ooAWMseqa0EJd8SR/xSVoADm8iteSAgp
         ScKeA++svBVOOYJqWrh375FOijyKN+1PlMCdUBEM0JyFjIEpDk49jM0GNr97Ehuq4kJW
         OvtxmTqJwFddKRFSF8ntVHAF909OtOgLk1X8BHGV96vJEkfAsFy1oIL2xfeQwMSrRaIl
         eCCg==
X-Forwarded-Encrypted: i=1; AJvYcCUdXE7IWsazPsXnq9xjwy4Q4GRgLTpBAOff0ngdoFTYu2YKCpip/D37iVdxjDO+O4DnlWfgWrQtw5bzhUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+wP0KvaS4CM2L9NpwqvvYnN33gOrliaD5dP3JApKLGCmvkhR
	b+oi2AIdz35PqIyxIe6KTWKHPbIT72GLCqROYx3tM7KJ1cSlNSHNPt5e
X-Gm-Gg: ASbGncvfAuM4LswLnWhiKit10lJVdOIf0rcTBvKCQSt8VaA1osh0SOVGS0IG/+AWudo
	TlGP3YrVnS5eSn4jx3a+yT5hF/q85WDr+DedUACeXPfD9zLJiw7NNuDOaG1YXHO5N2GrkW+4zfK
	/aW3v9MbcIiezytbUVvjS+Q1IBQRpwPmoQpf2VltpHgM06eDavqGnYVt0HbvF57fz31MhWIFnKD
	m2I/7pTjoxxmYRRFj7JXNNd1WLYxV+2m+2Gxt84tFymBmiv5EwDHeQaMPvFZSejOVQoWKI1akTH
	ZtUFLfw9blaz9jquUhLmGfjh1iQrxw+xTiFFoBZcn69F5zSlgxJoROApbotdRTCYer20EEr/5o8
	E2H1bauK48hzgwZvJqE8AsA==
X-Google-Smtp-Source: AGHT+IE9CTRtnxkm6JMDZSimOuYV/5weeNvzrjUJ+0Z0yRZI1GfxssHnK7NaXTSzkYrHfFKdvuTsjw==
X-Received: by 2002:adf:e6ce:0:b0:411:f07a:67fb with SMTP id ffacd0b85a97d-411f07a6bb4mr7969797f8f.55.1759093328488;
        Sun, 28 Sep 2025 14:02:08 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb89fb2fcsm16366786f8f.22.2025.09.28.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:02:08 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] HID: hid-debug: Fix spelling mistake "Rechargable" -> "Rechargeable"
Date: Sun, 28 Sep 2025 22:01:18 +0100
Message-ID: <20250928210118.242631-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in HID description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7107071c7c51..438a12046e86 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -2523,7 +2523,7 @@ static const struct hid_usage_entry hid_usage_table[] = {
 		{ 0x85, 0x0088, "iDeviceName" },
 		{ 0x85, 0x0089, "iDeviceChemistry" },
 		{ 0x85, 0x008a, "ManufacturerData" },
-		{ 0x85, 0x008b, "Rechargable" },
+		{ 0x85, 0x008b, "Rechargeable" },
 		{ 0x85, 0x008c, "WarningCapacityLimit" },
 		{ 0x85, 0x008d, "CapacityGranularity1" },
 		{ 0x85, 0x008e, "CapacityGranularity2" },
-- 
2.51.0


