Return-Path: <linux-kernel+bounces-816019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129FB56E45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D691785FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256C21E2834;
	Mon, 15 Sep 2025 02:23:40 +0000 (UTC)
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322CDF49
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903019; cv=none; b=RxyvwjsSWz9KEALCKkD9ilEUfQZ81P3EwuSDPqA+NxijJ1lIbLn5h6leE8naqGap47pDEccUnDyDd/cp5/8tzYyzXZmlpf+LVB6ADe3D9WN37dijcmbN4ng9ExA8JrQ6flt2Mw2TdZfYnCP24mV8QFy4u7FgYqexBIkDakJX9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903019; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X40f+kSaZESBvGM00uPv3W+i7FoHVnz9hs80IEk6DOpuBRnAZPBDtsGMzovFgFjj5iKPRnNUhqtmg1Yrhb+0rnHJcGCxEn1e43xpOf+esEsgmKTolrzfK4mCRnDi+sNY+SoEETlei5f4/Unbjwg3H3XAlctpZ5vAMW4nOGf3pRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so4896049a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757903017; x=1758507817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=F/oVKO5FxpydvDAJxn9bUvjuG9s885HwA81c9OjWJMrdw6y6dJXnZV9wb5BBBcSaSz
         YaEcMuuY6xHHfdoYtqImctFUwsk3TBIQfw5m2iag5/lcDruS556yR9sE0Y6D7kfRxSy+
         ZwGlAoj9TPtZyY1gWWOwo4Ymn3DZfR+Hp3bIkVqBfvvdMA4eGh0xzzbw9xohdPvgZ7dD
         +PRiMbs+xDNMX15go5+qrPjHsG8OxcY7psFhHznHav7S4kN3VWodn8Kx8P05/f+7Vq1o
         GUyTaPomeDPCsRQvWJYMRmlQjZ8gq6Wr+1Ecz8O3a0/VZ/srwU80pxx4FjHzW93WTQ4e
         u6FA==
X-Forwarded-Encrypted: i=1; AJvYcCVMI8txJsdyLPogljhA8uNmYDIbE51o3xR61D4BXpzLrrcFLJsPxg+54lbH+psScJqs0seIDYhp/9GtdDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgOJ75J2AtyTEfrezKa2UKg//OaAeTTAbyNDxTP8mRZeQtfhi
	YmH3CUKDqiStAsfLT42MyGrHfAk9TfKelbZv9jJ2p7V0zNueeh/UAijwwwX4fqsAe896Hw==
X-Gm-Gg: ASbGnctVkiFP9ZDN2eVs3P5nc0KkL2KRJ8CK6MoQo2PFtxL2S2hGC9AU4oI2+0NpecQ
	2vUhKy5m6zDr3lhRgIdkwjiDSvmgdmvYMC4rMwbg++7YOuoDGHclG0xuA8ze/GUJ11eo2g2vmhA
	2mdMDQJ/DEkFLaOGvgbRsZhqKutUl65bCdSNlBngmkNPZaQTXNCMcnNGUc6GqSPJrPBUwp6Wlcz
	esQb/TBbapat2uHEcLAL6CDNnw8D8ypPh7PhB5x92wexSgIqbNstrW6OUiaS5VardEHsnvJktV3
	3JSlRm1WlaAo2wer6dkj0whhuCMYKL6fCkXkNi9CjefGLBgNDkj4JufSZsE2cLWlxBKUkrfW7Or
	yomanjlOat6impau05hOMFcVX/ak3E1EJH+ndWh7UL3EtxwNezeVbYXg=
X-Google-Smtp-Source: AGHT+IGCzMqjyIxY+q9axKvsWCWGBNWWCtm+onfNcg3p7CY3kXX4t1UCWQ/s9984z5mMtiLmvvhrnQ==
X-Received: by 2002:a17:90b:4b89:b0:32e:38f5:e875 with SMTP id 98e67ed59e1d1-32e38f5eaddmr3605344a91.14.1757903017266;
        Sun, 14 Sep 2025 19:23:37 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([39.144.194.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37005a82sm2969607a91.16.2025.09.14.19.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:23:36 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Mon, 15 Sep 2025 10:21:24 +0800
Message-ID: <1bd58d2398ab79a9ecdfe239d6097051d8606724.1757680816.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757680816.git.luoxueqin@kylinos.cn>
References: <cover.1757680816.git.luoxueqin@kylinos.cn>
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


