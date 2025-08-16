Return-Path: <linux-kernel+bounces-771707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BCB28A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3559A5642B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B51CAA65;
	Sat, 16 Aug 2025 04:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSU9Posm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E032C8B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755318532; cv=none; b=IteJh4nAiPmN9vVb6VpIbpRjdqRcPPqwTyC02OYfhAKK6AG3V7UJdVqQmXu9n8iicCcLNt3Qzz+daqHn2vrvGEqsTBlgT21R4vhTrtGqDJ4V7EFSlxy5SATlXnC/qIi6EkJnwWQVVEzO9yWNSqyqPFUTHdR+w+N1X+83aZJAZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755318532; c=relaxed/simple;
	bh=T3uRfYG+/Tk9uidSVKx0F9Kn9rjGkazrVJXrCU4rVkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvnW3TpVyX7iStuU9DL8wr7GEOwPOu2bDUXhsgon6dDZWVxqC1rwrhG3gQnoHt3xtbB9uDu7+gWE/yw/MCfnsCBfG+TIhHMbHl3shGxJfWWODhdlJ3nzFs8F+y3p+Af1bFFhyzwOlcJb11gIbACGwzjuG6IHLtIucxjqMYTTOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSU9Posm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea79219so2961330b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755318530; x=1755923330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUdKVXAydBJ9wkHs/z6NzRQghT8Ti2LWocpy6KfUJOo=;
        b=PSU9Posm9yHzCDhNtHpryTsR+6Euwf1z7M+9pPtKtfmggjI7rGlL6alVk5An5t62mm
         fULYniSbgDGaJ2QTWinZPJAl8fPRy2eAoKtz0/PI3P1fNxKdQJW1Zxp/rS+xnnWxfW0W
         D5BAsroS+2MHi+BIYamY/Sk7XOHzwmO2tU/ryE/DgKOsqstO31V7qFlfc6HYSVfLbUH+
         em9WGhvYozZA779MLnzZsAlZJYCod4RAgJ/fGDg3RYi6IxcU+j9Yd/r8d7o/qE7c6WAQ
         K3NBVncTc0f4ZZTPaKQvK6EypEzsIO9YEeknbBPan2jl1wLBmQp/q1tyqFSPBeKWOr41
         501A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755318530; x=1755923330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUdKVXAydBJ9wkHs/z6NzRQghT8Ti2LWocpy6KfUJOo=;
        b=s3J7cersnEO1eCOLP+qoCYpIz+A/5ufaN4gdMGrr3KMc8+VuYryOu6i6drfE/3zAp/
         EZgy+iNix2KUm39vJYAqvsbqhhcpHctEsCt1xIHLS9aHFwduBt3a40f0Gzd8TJg0Rm12
         5KszDQR97VJY+OXhRO6HyQRap/X4YpcKeUFu3IqMJh0ZZxebEAg1KoFbjnsOD50R3JEF
         EELyU+EDBFgEkDEeQGGDtwh9COCwZTwPQawPjcjh1QdEFm3w6a55SkYvAGkigIlGmbjN
         YeHh7fNAOdZSs4TcTVKogVUccKLCVOpYEf/znuDLDmlQ0l0YvYrmZx0B/+B5r+k3BH0O
         cA1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqWm4fRlxfzTPS2tAoy4dU3vPLWiN1XjJ65GC7khPkOTWGfNh6JMM2o1uwC7Yymnpslf4ff0VEWNOIqKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxblFspO2UzoDAWfIOdamcBVkSgbfdIRHsA13FYdScfyjphN+lP
	VWuhNMFUuTAHFjgOFH+Dq1nfslO8HSrvtEkm7HO114t1wy8ErLHEX8pI
X-Gm-Gg: ASbGncuo88myRXalDOK/olt1SGJow01nepUY9TqP0yD27aQTVOSIgGUdZSZSVxNVKjT
	XV46wot1hFjUgYlxh1Iy8YMu0p77Vk16SBxJmT1iYllmmLbU8kmY4MzJym8Xf6HewsYnE1bvc9D
	lI5PM8QytRteUuiKHR/ux8IUWYFkGpDPbN0IxBCGZKh5Pu1e+S34vdo6WllfZwtCLvJj25uZi6Q
	1qrE2+jMobWPVXfJ4W9Bt8NMJuf1bqO6GHCHkmbMM2pP1WNgFEekTIW8yKC6dYezxbBcklevFun
	r6UgZhjx3hRhcMBKyou2TLGwyOSDxDHCgybBIqrXO2jj484rcSseAPw1FnLZKgOpSxW8ZZAPnMg
	aLAbR04VeoyDwOd37T2vsCwxRDrUU0iQ5CiL8E78MBkA4znaVaP7sREwDXRzF2TRB
X-Google-Smtp-Source: AGHT+IHFWWtb1KbXVIg+UozThISuavCO9wv+AE+Tap4j/B944QQFysY2kNhergonWcz8XuW9tB67gQ==
X-Received: by 2002:a05:6a21:6da6:b0:220:3870:c61e with SMTP id adf61e73a8af0-240d2d7d678mr7691737637.4.1755318530006;
        Fri, 15 Aug 2025 21:28:50 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a418sm2611958a12.38.2025.08.15.21.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 21:28:49 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/cma: print total and used pages in cma_alloc()
Date: Sat, 16 Aug 2025 12:28:42 +0800
Message-Id: <20250816042842.3959315-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

This makes cma info more intuitive during debugging.

before:
[   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
[   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
[   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)

after:
[   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 64, request pages: 1, align 0)
[   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 65, request pages: 1, align 0)
[   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 66, request pages: 1, align 0)

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2ffa4befb99a..46cc98e7f587 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -776,6 +776,17 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
+static unsigned long cma_get_used_pages(struct cma *cma)
+{
+	unsigned long used;
+
+	spin_lock_irq(&cma->lock);
+	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
+	spin_unlock_irq(&cma->lock);
+
+	return used << cma->order_per_bit;
+}
+
 static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 				unsigned long count, unsigned int align,
 				struct page **pagep, gfp_t gfp)
@@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count)
 		return page;
 
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
-		(void *)cma, cma->name, count, align);
+	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
+		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
 
 	if (!count)
 		return page;
-- 
2.34.1


