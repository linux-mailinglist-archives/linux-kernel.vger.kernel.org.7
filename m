Return-Path: <linux-kernel+bounces-816947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6157B57B25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B32188A57C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B903305E20;
	Mon, 15 Sep 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2GW5hSu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4411E98EF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939596; cv=none; b=AcjH/zLnAgKrlkl4gluFYorD6uUDTrVkUeWubrf3jbsZf32wYA0aqMCELc8gbBR5wkVPfh70GWW4kByoCetQz020RJiuPQJK7GTHcrgcmc61h/fesZs0ZJ//dxye48odD2l+VKmfLAXpLuQqxHGBZnJtWvpeA5eBIu3WUQEUCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939596; c=relaxed/simple;
	bh=ka4FueWz0Un+jHqDZVdsex6ys5suckZYq6W+FIQx+Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhFiZokx+AfB9RxzwwvbN491gKGOTSumkX/gAemlpkA2Kb+VUsjcPZaL7HwT42HRr8wk3gROQPjTpMViuJvfbFD39hTc+H6CL5MXHrcCzAWYsVeKgq+Tye1Udcgl/czSYjhqTWEWkcrVJUMPDxdsXIQBTUASVubhBarVlbAwMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2GW5hSu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25669596955so41821495ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757939594; x=1758544394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICbjoiLsYOok1c81flKhzX2Dr5LZXmq+Z/dcfqb5QA0=;
        b=T2GW5hSuYjeCSPKG4uahEZzPreVaiOtEDqUpmvm5rk6dEubX6+yP0XM/nhjJrrrVUf
         c4Exzm7JF4Zw2loI8NezZSKeFG/c3iiVVsDba3Ez2RBduLITvlVscJKw2LVd6rkZSl4w
         AJcSPCjT7H6OIAuHXHReRg2zWPQeS70tKgYG8B3JlaQYCYBPcLj7o9Mr9RmQa5jwNNdw
         g0itH4p2mKF1KORp7uodbw5zFm6HgiIsBSMPhPkyYyXo/762KYxLmFTZBgwCR2z9b76v
         vtpDs8LMPlf1LOvgiBhSTDt+03szq3SA+tBbItgxzzFkOmFmfyUUMN9p8l3LuNl+4uNX
         4XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939594; x=1758544394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICbjoiLsYOok1c81flKhzX2Dr5LZXmq+Z/dcfqb5QA0=;
        b=oqWzClMFhBguU1fGbwUxhO+4PxXr90+19rhSU4O7ESGlRNUHmV0J8KxbsnifTFOnH6
         sDxmrY7hbWgTI23qPIKd+e94LH40QsP7w77lgUopVzNWOigPmDEHDn1+TlrcIFZbagTz
         KcvhcInFyRR60n+csILdINSrKhfeFyYgyaNchjOHkc+7nDKjySFa1tfAtx/cNDJ0CvRG
         mLcjrkfaxgNh+gI/rqhstpYrDihUh1kG3P2n2P01JD5QfvNbPPZd48L9v0MhzI39MTJH
         EgZzY9p/HQ7XJ8p5An2tSLDRcwE0feuFf7zP2axkvc1oCcJeUNKrTBOGXKiLRicz0cse
         Rhlg==
X-Forwarded-Encrypted: i=1; AJvYcCWlLtXZmAnLqUA5D/dLd8DH1nJyuzc1lQRAO9l4Yx+2JCxQxutLgZvcEpcCqZe48J2GjgLsZaBSlPWLixI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9g7R9c48Xrcj/+Y9XfRoTM+zRHyYH8UyWwDKUqYzDqKjMHsb
	c6OsPO96mVf5mHXDOg804vDqR6+u6ixBSD4YjZlYss9NHMsL59Aehzr8
X-Gm-Gg: ASbGncumN4XwXGoEu0Q/A4VGDz1zo08zci8LxpIaZiX/wFRZuLnbmgwr7+ltHI2/5Iv
	NmRfWkwakDZaXocf5wUSrWAF3Grk2RRXP2wp/2XuAMVJm3ceG7ws4/duKfIcqUjYckasqd0fpKY
	4bNbHtuFj+CkXmlybDoGVdyucqpKXxhL7LM7gSQZH3VtPDcTj+i3SoxYkqbFRkFOQ+e9UfMdZ6f
	Iaka5vGrsMe/Y23eRFajZI957/lrlB28TXVfFoTmGSTbW2gjvmct1BaK9TzeAiuVHnb9jsP1AQu
	oYgI1Fz4VS7t/Ca9u8/WusG3Wqlxbf5ZwI20zw6sDYfirNNqs+TFOPY5ZrJ0sgFn3RDdlJBR/qS
	20sNC+SpDdL/iggmgmwS+XJhxjWwRPAPb2QtWAp6N1z9a69UnZSklnKt9O0I=
X-Google-Smtp-Source: AGHT+IGejX8mFgf07YiMaFVmYLT41CYD7SaPHvbYCUMkBuErliPIRTYGZ2dSA/aTiLTYcgLAHiZL/g==
X-Received: by 2002:a17:903:1b25:b0:246:d70e:ea82 with SMTP id d9443c01a7336-25d2528da26mr148679175ad.5.1757939594159;
        Mon, 15 Sep 2025 05:33:14 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a6212sm37858845ad.57.2025.09.15.05.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 05:33:13 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>,
	Bart Van Assche <bvanassche@acm.org>,
	Li Nan <linan122@huawei.com>
Subject: [PATCH RESEND v2] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
Date: Mon, 15 Sep 2025 20:33:07 +0800
Message-Id: <20250915123307.96964-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
was removed, but the "rb_entry_rq(node)" and some other code were
inadvertently left behind. This patch fixed it.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Li Nan <linan122@huawei.com>
---
 block/mq-deadline.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a031922c447..63145cc9825f 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -133,10 +133,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
 	struct request *rq, *res = NULL;
 
-	if (!node)
-		return NULL;
-
-	rq = rb_entry_rq(node);
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
-- 
2.39.5 (Apple Git-154)


