Return-Path: <linux-kernel+bounces-862761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81366BF6172
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD2719A1665
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98032ED24;
	Tue, 21 Oct 2025 11:37:49 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3E32E6B1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046669; cv=none; b=sVZj4GEAGgRizt+wKhefL5ooDVbrZISMplzhRLtB036t0hhPnNvrTP4OPBSx97dQoJYcM6tyrpWdJ6uP+pI5TbJSpG+eG2foZ9Jpzbss84XfpdHpngWBlEfdB4TZJK1N0cWwbu8bj7s1/gMA6hNh6YBiio3S3y8gyiCwYZXXLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046669; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0o5PjngxNbGpg2XyDXRlxupx7I95OkeGcLMmDmDlRmgBRIGcU0FnvWw7DfaVCThNIxB13RnLI5u3WNDjDNSxPyCHXba9rORE8JQZnHqLmcsCFAtPoe+LI1H9RlfazlinMyN3qV3s1X26KHF8NUX2TL2NVJe8lWgmhWQiglTHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78125ed4052so6754783b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046666; x=1761651466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=pSVkFu1B3RK5ZHLpqQBxbwLQ9E+/Dyb+GfiAQy0fBpathg2wkkmyGNw+LRc345ti7d
         0lBbgjdH6grEmXvRaWLP4msIpVyA/hIvBcHmLdMarmkhf49izYJeFx09To7UaiM9K2nx
         0KnzM4T5lp5ImZQS/VVQTMMet1y4CQBZDsDVG+a13lrDcyRnaCJ2IEyVBmtyU0T4aphS
         iQXoH4K78PE/Shyg2kUCMmfLQvakhhA8OKpkJpY1+I0BqQ1G2Dl0dM6LsAxy7pDaiJDw
         X70Z0h6PeewSbUibMDOiM6iEf68rcX5vYJnZdXHqzvSCaKnkpz0kQ0HN4mxPEI/Dq4gP
         j1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMNbPtX/M5WuxoP8XqjRCma2nv7TM+0FPfulNlL2cFCL0mfIiEDt5WklenGhk7XU9iqFAfH/z2Iw0jIdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6P/CrImjivMSXBSqIydWQwDQI5+/hyJ5OvR2zDzD3TymSZN8f
	ED8Vw2lriWwMfZR+lZX0tZKZPm90iRY+ftBEIV7MC+a1kNkFoFpnjdob
X-Gm-Gg: ASbGncuOyDj96syX5y0ry9reL0FCL23gnazAonbl4x/pxr1eb3gmWenc7hDMMl5VJNT
	XNDSgC33N9Fg+WVxM0E5pu2QGe8Wk6HipcYYHPLp+G5CVmFEqT5Gerdz/v1JVF96EodA5CQIqw0
	7PF9cJ5XbylFx7Xlg+oV9f9ZDwOZPXqAtWhWpNfgaPOTldNrpHWCt24cqHixytEEVrwm+M9THLX
	O1nYbT4JABeWu+Chy+yrawXpqcCrSNMFfPiN6KeZXXcHSnDUXejjU4i3fydnrWRWhRCRxwQ1X4d
	A3pgQ7x8nIHLEWHrRykweWGxJVC0dvs1rhAdvcVDwnHl/MsokCJgoN9DAtMH6XEAEplX7BJC/tp
	njb9ourFS8c4x6RlzEQBCYe0JgKEj0wYGoJpHNO3LzSYK7KuM11Iwu+i8h/qZwuK8MaC3fhpXUV
	I2f72gau/n+FyxgA+Ye3HadJQ=
X-Google-Smtp-Source: AGHT+IHTW4/gF6OgIb2qlrRgINO+x1D8thSVStMWU5wqlHnByPzRDAXjq21hKuIf9on4YFT1CpZNcA==
X-Received: by 2002:a17:902:dacd:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-290c9c93c25mr195327565ad.6.1761046666417;
        Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 1/3] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Tue, 21 Oct 2025 19:37:26 +0800
Message-ID: <b5db63bb95729482d2649b12d3a11cb7547b7fcc.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert crc->unc_len and crc->unc from fixed-size arrays to dynamically
allocated arrays, sized according to the actual number of threads selected
at runtime. This removes the fixed limit imposed by CMP_THREADS.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 58 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..f8c13f5672ec 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -585,10 +585,48 @@ struct crc_data {
 	wait_queue_head_t go;                     /* start crc update */
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
+	size_t **unc_len;			  /* uncompressed lengths */
+	unsigned char **unc;			  /* uncompressed data */
 };
 
+static struct crc_data *alloc_crc_data(int nr_threads)
+{
+	struct crc_data *crc;
+
+	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	if (!crc)
+		return NULL;
+
+	crc->unc = kcalloc(nr_threads, sizeof(*crc->unc), GFP_KERNEL);
+	if (!crc->unc)
+		goto err_free_crc;
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(*crc->unc_len), GFP_KERNEL);
+	if (!crc->unc_len)
+		goto err_free_unc;
+
+	return crc;
+
+err_free_unc:
+	kfree(crc->unc);
+err_free_crc:
+	kfree(crc);
+	return NULL;
+}
+
+static void free_crc_data(struct crc_data *crc)
+{
+	if (!crc)
+		return;
+
+	if (crc->thr)
+		kthread_stop(crc->thr);
+
+	kfree(crc->unc_len);
+	kfree(crc->unc);
+	kfree(crc);
+}
+
 /*
  * CRC32 update function that runs in its own thread.
  */
@@ -719,7 +757,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	crc = alloc_crc_data(nr_threads);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
@@ -885,11 +923,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 out_clean:
 	hib_finish_batch(&hb);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
+	free_crc_data(crc);
 	if (data) {
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
@@ -1239,7 +1273,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	crc = alloc_crc_data(nr_threads);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
@@ -1506,11 +1540,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	hib_finish_batch(&hb);
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
+	free_crc_data(crc);
 	if (data) {
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
-- 
2.43.0


