Return-Path: <linux-kernel+bounces-811592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C1B52B39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C47A172E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8CA2D948E;
	Thu, 11 Sep 2025 08:10:25 +0000 (UTC)
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A82D543E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578225; cv=none; b=MUy4IVl3g248SarCYzXxOJrQl+NW3czzklYdN9AFAN3xYk1EtTrsQMlqOPQRp4VhLdJCY/rC9p+vbOu1/Qq3mSrXKDt/OgS2IWIQqxp236GC6+4/KwKgiVdotKAuFyVMaPOGlPLzlDXMXAKqPtKR+q1XBgB3z9AVr4oyS+9tAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578225; c=relaxed/simple;
	bh=ExUU+pGBfpALU11Z5pEd1vR0hoXiz55jE/WtOaShvMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX+LRdudsYw89LZx9RFFmDVQt+63fCnbjiiDOoSu8lUrs7pSherkzcAClS3vekO5EQHVQpEB2ifObBZirWjytvp022yvseUIWwgF5j8TBZIgECpe/Q43mb+9ay/1UuiTMVUmKS7BVQnE+Mw+QfSIXfL2gnotze2G1bXxuDgUUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24cbd9d9f09so5225165ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578222; x=1758183022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvA6blgC4IX6hj9NKO9nOSzXLhviVfQZFwPkL/QABho=;
        b=ZPZaqe1gd6EhBZljgDqAslLtof0Y8sBUOew/5RKLFii0+J6Y6AihNnxHPwauBgJnkX
         hJru3V9uHg7s65itux0WwQI4CKhCTF76FbuaAwwiJ1zDbIG238+u1+BG6rLHjFS4sgxE
         rMEA2uG31IHznOQR2hcKVFE65byArmRi9RPAKXNuVM7JWXLBgvME1Cb3dqitNPPnB8A+
         XZSA6rU8INyQPHwD4TJMKU+C0liTekSJrSCCU/lvGJVSXxPhLiR0UQTpl7k/dGN/She4
         U+r8AOwRFB4cCrRaj7W2soSNmkV/GiR3MxJHQCB1PpUgvunfxiAv3Q/3JQnR+oowZT/s
         SE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVOX2HN0Q1+BSWxNzYHZ0U4w12LNUQThllvVcb93IU5lx5NVi8flEdbnPPf9U7P6CIYUSQZ6zRz8nIn1bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8F3cV+8qAHOobD43kFfaHHyVr4euVzznxX6LCE15fyTZTq6EF
	Eu4RQxieE8hJ04rUWmAdh8WfY3k27qm4wjwmo4tfeP2CxEAjEmcAJEmF
X-Gm-Gg: ASbGncuadKKlP7xuAsQ6Lv6swVN9LOVkaO+aUmyo1dTjceiR72qKOhKHDGsB9e7/5Uy
	qkNmrL0CkRRDaKJIjfs9qzBttkhuh5YmhPc4tsnqsMJrKU0XeboILu3n64X0/Ki1fzmGx1VeMu6
	bFL3+gs+jKCq0YIOm3+fiRK9EgzAheHjoUWnJHJIXEs4ptPPEzGudH+U9x90Rfn/0kgjTcY39ai
	0ooQMn0EUpBWYxBaP5yMrDYZE5OFVDpmXSuDZ3PE3SmIeaAajB2i/Dxxt8QtLZaqZFqqUgzRcp4
	f/8yJWDLint+9I3fa9N7JMNq+Fu+QCc31zjQfssgG0rb50h6R6P2GJAEdXA+PDCyzHI89yamN90
	nDJ6vhcd/rLD3yN7e3nAGN717JOvMfiLgS/sRRxFsC+GpqkImNxWiQjHeoOBj+EYEoyA=
X-Google-Smtp-Source: AGHT+IEazcvj6u3pgAilsxX3V6tb275sE9wo2VIGekxnEjbg5FCeyDwj2jKeAT3aOOHRd55yYAmptQ==
X-Received: by 2002:a17:902:f550:b0:24b:270e:56f4 with SMTP id d9443c01a7336-251736df030mr234774675ad.37.1757578222320;
        Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc5671sm11129925ad.22.2025.09.11.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Thu, 11 Sep 2025 16:09:50 +0800
Message-ID: <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757577879.git.luoxueqin@kylinos.cn>
References: <cover.1757577879.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses fixed-size arrays for crc->unc_len and
crc->unc, which limits the number of compression threads to a compile-time
constant (CMP_THREADS). This patch converts them to dynamically allocated
arrays, sized according to the actual number of threads selected at runtime.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..bd149a54c081 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -585,8 +585,8 @@ struct crc_data {
 	wait_queue_head_t go;                     /* start crc update */
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
+	size_t **unc_len;			              /* uncompressed lengths */
+	unsigned char **unc;			          /* uncompressed data */
 };
 
 /*
@@ -721,7 +721,21 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		pr_err("Failed to allocate crc\n");
+		pr_err("Failed to allocate crc structure\n");
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
+	if (!crc->unc_len) {
+		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
+	if (!crc->unc) {
+		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -886,6 +900,10 @@ static int save_compressed_image(struct swap_map_handle *handle,
 out_clean:
 	hib_finish_batch(&hb);
 	if (crc) {
+		if (crc->unc)
+			kfree(crc->unc);
+		if (crc->unc_len)
+			kfree(crc->unc_len);
 		if (crc->thr)
 			kthread_stop(crc->thr);
 		kfree(crc);
@@ -1241,7 +1259,21 @@ static int load_compressed_image(struct swap_map_handle *handle,
 
 	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		pr_err("Failed to allocate crc\n");
+		pr_err("Failed to allocate crc structure\n");
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
+	if (!crc->unc_len) {
+		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
+	if (!crc->unc) {
+		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1507,6 +1539,10 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
 	if (crc) {
+		if (crc->unc)
+			kfree(crc->unc);
+		if (crc->unc_len)
+			kfree(crc->unc_len);
 		if (crc->thr)
 			kthread_stop(crc->thr);
 		kfree(crc);
-- 
2.43.0


