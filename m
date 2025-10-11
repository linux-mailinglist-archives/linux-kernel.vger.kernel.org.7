Return-Path: <linux-kernel+bounces-849099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED006BCF328
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F4408044
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08760257846;
	Sat, 11 Oct 2025 09:38:45 +0000 (UTC)
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45739257848
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175524; cv=none; b=ZYEuEu5aMV5LCbnRCvqx6euxgpPfTtYF5fBZQU/EK5MfQ6Xhr92tCaV3u4tuPxl9mPQJceAn+GF3o3CrCcLQUjTfIG1BuAGapbBn+J376lv+MPeV3kbfR1YKp0RaQdo8AaCAyLoNGjXUQKCC/Fy46wOJ5O5p0ECSyJdnRImqUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175524; c=relaxed/simple;
	bh=bTB9DzoWH3QIpeBu4xYDTQAzXlJCXk6gbv+o+fe1N3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/F3LDDjDXNgCOZXEECCd9Af54oFPQCQv6DpxGkFc1T9XukllOdAOoIhP4uBXhEQK8BSi1PGfuH7cyHhU1xJNxTeWCHQrucxDQqi7/miRZ9oPQEdBnHgjgk5IepJe3l/yGhkK1Kt05E9bFroQyRz94tEnqae2Ni9/XUXy9XdOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-271d1305ad7so46911335ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175519; x=1760780319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVV/uiMu0xHtlKgwsYx2mXd0JzCW14CDL0hbQStIbj4=;
        b=flzlqLsoJAXdUmXBawN2k/Pbhp31S1ji/C+xrLodDHWCnlKn5giBzF9QiW8K3atwHa
         LAlD3pr30QKtmt8vRdT7lx4wXUqUCOX2qyvfzuWxjxuBnD2by9TgJCk1XLbnn4ayTsV+
         78hurOTWqZ8Y2K8HpveyJnarDedGr/lyrGHD7fkrMoOptJbKlFH3xlq/VzHLqDD5TETw
         NBBGGEUATVhz3a4gBV50nwNjlmGQl5OiUFoXxc4B37R5Z+hO0B4hBQgy7QnLtrW8dPBD
         XjBgZAFLLmRor03xYrmMyl1MoY1fWBRA1E3VidL11twRy+AexQqPSVYMvSdITujDk8Cp
         jCXg==
X-Forwarded-Encrypted: i=1; AJvYcCWMG4opV6iN7H4wwXD+oOyjPPEdv6xNb348sSzyEiySEK8v9gChutmUwFhOLCqfK58R6Hevzv0drvs9eTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStbJc3jHnpqwDvmxErFj6exayi7rCJMvxJYKfLqZvBwDyn4lu
	pLt8TvAA7IlUD1KEI6x+IaF1tYqIZhR/S3XdEczQuEHvCSZrpBl4LYSyAcv3wnXvxyQ=
X-Gm-Gg: ASbGncswIPnvLxiQvozobHaTG0WWbC4EJ/l27lQyT7VL4mhFEhfwOwjMSZhT2r8I7Ny
	tJy0Y73gXM2OHenMBjnmd5t5yVKT598PpFsPa5QmgfG8TDbq99qLyz0ipSHXTPakNQ3hbobiMXK
	qgPCW34MBqnGvDHKt+ph/WOu30KA5+Vn94q7xPYuh8MxsOQ5RdFPGr9CixszTSIt/5Pt8hURuT9
	kRpWF17gc4dldmLPFUtQGxes5yd939rUx3kn6S0ff0rIfg5X9Ug7H9UcrrN/1pRVw3ihl8jVdv5
	j4u8LvKKES30WS7k3DZJbz4uaNh+mCB5CU6zX6L522DnGEARzAPQieKO5tXAGIHfl5uGzprm/Eg
	+IxBbK0YcS6wGaXI4UHamjCWxt3PWllWU2fJ71ROujE3yJRi4cpcgIH+R4Adv/ZZE
X-Google-Smtp-Source: AGHT+IHpGLpU8M9LjptzuKQ5BOFJfe6J4j9z7uO9gDV2SVJTv45LojULgBTU28zYulg26XhrRR4Gpw==
X-Received: by 2002:a17:903:3807:b0:269:4741:6d33 with SMTP id d9443c01a7336-2902737a672mr193197825ad.23.1760175518554;
        Sat, 11 Oct 2025 02:38:38 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:38 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 2/2] PM: hibernate: make compression threads configurable
Date: Sat, 11 Oct 2025 17:38:08 +0800
Message-ID: <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757680816.git.luoxueqin@kylinos.cn>
References: <cover.1757680816.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The number of compression/decompression threads has a direct impact on
hibernate image generation and resume latency. Using more threads can
reduce overall resume time, but on systems with fewer CPU cores it may
also introduce contention and reduce efficiency.

Performance was evaluated on an 8-core ARM system, averaged over 10 runs:

    cmp_threads   hibernate time (s)   resume time (s)
    --------------------------------------------------
          3             12.14              18.86
          4             12.28              17.48
          5             11.09              16.77
          6             11.08              16.44

With 5–6 threads, resume latency improves by approximately 12% compared
to the default 3-thread configuration, with negligible impact on
hibernate time.

Introduce a new kernel parameter `cmp_threads=` that allows users and
integrators to tune the number of compression/decompression threads at
boot. This provides a way to balance performance and CPU utilization
across a wide range of hardware without recompiling the kernel.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f8c13f5672ec..dfa9b7c0f96c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -519,8 +519,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 				CMP_HEADER, PAGE_SIZE)
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
 
-/* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
+/* Default number of threads for compression/decompression. */
+static int cmp_threads = 3;
 
 /* Minimum/maximum number of pages for read buffering. */
 #define CMP_MIN_RD_PAGES	1024
@@ -741,7 +741,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
@@ -1257,7 +1257,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
 	if (!page) {
@@ -1697,3 +1697,19 @@ static int __init swsusp_header_init(void)
 }
 
 core_initcall(swsusp_header_init);
+
+static int __init cmp_threads_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &cmp_threads);
+
+	if (rc)
+		return rc;
+
+	if (cmp_threads < 1)
+		cmp_threads = 1;
+
+	return 1;
+
+}
+
+__setup("cmp_threads=", cmp_threads_setup);
-- 
2.43.0


