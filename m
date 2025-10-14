Return-Path: <linux-kernel+bounces-851971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C1BD7D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA10189F198
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723530DEC8;
	Tue, 14 Oct 2025 07:20:36 +0000 (UTC)
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCF30DEC7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426436; cv=none; b=k2uqmASwXDv4p5fvnAw8e6t2FSOypMA6RhHavJJMo+uQqiRc9AwEel1gTE6CM0Z3YDvNv18AUyAOzale9pXD6loAdc1vDIANAl0baOwLYJGwzzcJ+N5+SfvbhPrxEcnbO/y4bzSRf+YKcd+uNZV7kU30fHe+ihC9Ylmg50G051c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426436; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESoiV2RjD3s2lI4Km0zyJJzvpErTbu6701+YTxq4Cf90flzHiV1e2nGB399FSES9a+JKgbFh0FnXka+KC/OirviO0NNf1Q2HwVcEgdgQ1rQLUJlmWKGMms09tD/Pvl85yKBKMi4bQ2yduAW88MxPZ4fOZThoPdQt25CJ2Ca1YHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-78af743c232so4513378b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426432; x=1761031232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=rLLVPajKoxYih8G/j9UtxnbpEFwDuJ2FxI/DxPG13SV0apN66jn/+eMgkN/stgJAer
         W6HSiN3JhvC4gu6ARwhVd4yxlaUIwlSKkrTcElYlMGgtlvzY/qrintp/ybi2ay7pZ2qq
         zJlTv7jBc30RwQW6iPoiKzCgmOboXhkGPUBmbZxEAicrgfSLucsouF2qePRADj906ryC
         hqg5c6qdeSSw8gZ0qipdUkGqbmZ3fiyf4evd18/fO9rGmLZZvuOgcYMj9bMfEPYAUVDE
         xxYIjtOP5AFzBqtuMDTZyddnCoFD5qlUiL0ABkZQdmytmZ/tMu8hvem2EcOexVgORTM8
         +5QA==
X-Forwarded-Encrypted: i=1; AJvYcCWGsC50SdxfLAxwxJ9jDA6rM0Ttkmb/2sE5XJStjYx3gq+fExpI9+ota5+VBDIq8bEgUdVOjFoe0euUuYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SeER4bYA/YMH4xwpuHtu4Pv0gJvz53HkVVObWPdXeDsIaxQM
	7Hw/APKKfOhaNKIdexQBx0hf6sQLcmZPNGyw9ABrdy5ZIwRt6nBQsPcr
X-Gm-Gg: ASbGncstGzN20zPF7NC3qh0XxD/4SlVe5Q/ASA99iDGGZLaNK0sKwRGU8LodLcYJz4i
	bqRHqMnvsCoIzf2/GKa88iMp5s/ROdHKZ8ykvo7fyaTD34NuYeZHWCqByI3l1UE7/XfXb5UxIms
	KuVyU60gdCh2DYvqSs+uzlWCgu/cf3e57D4pGnpl/xkjZ2BAzieiL0lEXt0Sj6e9g0b6hMX+1BE
	8rbQlzQhsfC+yerVjnsH1+geYMShoYj17UBdxt+xiYCdo540NwwYv9UfHvtzRHFXuWt65frSVdj
	AbFDYK7WubnraXvYKpj9lZQxzrf4+lEVqHBPGt/8TTVH+ftRprAcgQTmmEImHV4bOoDlX2/+tTR
	vCykOYBBEVYvFSaTvtiFVNd5EZsWaVoxSLRJep//5ysFGsfeYOMhU4C02VuT54Wcs1ElA7M0KAH
	k=
X-Google-Smtp-Source: AGHT+IEw3WpKRLPky5hGUBO5huOhqVNP1ah3SMKVxkWxHR/Z2RFXVp1UIm3gDbOY2/fxjjj/eCNjwA==
X-Received: by 2002:a05:6a20:6a29:b0:304:4f7c:df90 with SMTP id adf61e73a8af0-32da845fb34mr31580352637.50.1760426431693;
        Tue, 14 Oct 2025 00:20:31 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm11937092a12.18.2025.10.14.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:20:31 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Tue, 14 Oct 2025 15:14:17 +0800
Message-ID: <b5db63bb95729482d2649b12d3a11cb7547b7fcc.1760423687.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760423687.git.luoxueqin@kylinos.cn>
References: <cover.1760423687.git.luoxueqin@kylinos.cn>
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


