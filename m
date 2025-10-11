Return-Path: <linux-kernel+bounces-849097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230DBBCF31C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF27F407F33
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65A255F22;
	Sat, 11 Oct 2025 09:38:37 +0000 (UTC)
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F9253954
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175517; cv=none; b=I1MtBbqdiLbiNUQ8HuoVsYqPTkSdzKUhCdA0Q/e9TuK5G7lI/LL6kRnAGzHBjgs7F9aeN5xrSqHfAM6ifly7ieW8ejCB8+hcZJ1KlGPdEJ4Zr7vqY0hWUtpfayAzEtJ0VeTLTfFbXsh0JKGQ5c7VbT7dlT3SConDiI5vhZ0+3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175517; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPB6zIbXejUl+5SdcUiwM9fDCJPiUWkTQhOMBhH/DlATaddZ2dT55U1krUnb0cx8dYhnPGb4kE8cy5XaLhtJXbQtfpjeuQMT1fdVD9WB7b+cK6tlYxkbCXQ2blXqO/1OUO2IXJA4oPHNrmRZqDGs7PXPhk10fO5Z4wguvK9lB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-330b4739538so2671347a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175511; x=1760780311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=K7pROypYieTDEbTc87zRd4MDO//9KSv4paekPwBWUZlwYOScXhgWCK4Sh6qD0qNUSx
         uAe0dwscSamoVtYV28s5serkE1DgbVZjhw8kFNy+E/C55wB3iBu20wR/OkY12wV1b3qL
         GtfKzqJQrdcjv6d0w7vM6j7BZ3Tu+4CgRezF+/3Vx25RtdFF+8lJtpnrjCUvx8Mox2XO
         v9Hrf9DjniWTQgFCmbTqLGrhzozf579zTmLrN7W3ATRZwZJfDOf14446zV8dM0Iq5hQt
         YbxcFna97b551VUU26+RF+rHFT4Tqlu9wWTu38rIfri3iWnrXAm+Y5cHtDwnp1jtNF3u
         FJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9MPF6wm8dpsAQdBNr2xBZwVzart8Jt/BxA6H9LLnpPAvkm75tbRek6Z4Kd0qhRTNlXe+d+HHyzRwH2ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHId0S8rBqb7TfwKBQhbVwItsYdkb6wZnT6HrhFDETabWpE1E
	awnAJkL40UXxYUP00DbNpkWNfMtX/dVzv7i/7nAGdZf1nuJE6WEetTmA
X-Gm-Gg: ASbGnctPXVSeozurmrvA0cny+1mt4rF+DW/TwDuXrl0eTA3sehqTxz0a7e/TtFXw7XZ
	C8/ji15wgZ4Exys9i+On+Hmj/i3ZwtVe2b2Y4m89PtWNMWtiT0sLlkSXcXKXmLH+P9ETDQ6wsii
	+OYT1jnM2i52YYasFF9JoJE/4mX8jYMcRnDDLHbnOOWuwGlYiumae0XPzpdR3xxShr3/WMoI01p
	ta5oEXBZ1oQakaxEyV6Qyox6zjqODrznzeMgELJNBHdG8hseqYxEHp+XInSD0czvDWtW2xUfigD
	7vB9GQ/tBNHnsPLrnRH0B4YNfXOhEz6HOcAn0OjMr2sqoYbilqwviE0WRr4wXzf7eXUvufnjCyM
	0CpRLZnWc7xggFoW+CHCrSEvpFJ6vibheR78QTvuX8ea/95fWfcT/ukoprBaYAAul
X-Google-Smtp-Source: AGHT+IFiEJTgEZ7gITg0ltZOAeTCgaHrlxDzUZUaCp1bwW8p5kR4VlJsyoL6nwGwLe7Q6nTphvU0Bg==
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr21624129a91.1.1760175511334;
        Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Sat, 11 Oct 2025 17:38:07 +0800
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


