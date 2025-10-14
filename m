Return-Path: <linux-kernel+bounces-851972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99CBD7D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A93FF4F9866
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116E30ACF6;
	Tue, 14 Oct 2025 07:20:42 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6A30AADC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426441; cv=none; b=S+Stkgz6aU5ze9jK7E1fth8r6YgV1K3yyxF3rGce+F7sOmAy3YkHegE2MvL/Y16+mSNgf+7yC0zZO1bX1cxbpgXc2uMe9vMESUXAI1+PT8Lbhje4zCVgWyl/91KkysW8eOEpY6oz7JEHaeeMYe5W7RczSb9EdX8lurBQNz9nAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426441; c=relaxed/simple;
	bh=ese1AL4Mbt9Qfou8zsa4/1NpQHkJN9OTenytTIEZe5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjHNeyO3RoXbeO1/cSvVNUBpZb26PgT2PL/GFdKh/enQiB849/0eIKS38nXPPFNvPsJzCQOZkedzn8q9hOs7y5MSoZZpaHOAhX/rG5O93nROPCoWkOmW5Uh2m7kYdGqQiu25QYK/rICCW8e9dhH9SKt3jj9WNZ2lW6tCCTXUojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78af743c232so4513431b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426439; x=1761031239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX/I9Icx0RS+yCcmomPEu0g/6wZ9SyCmq3ksJTG9NiY=;
        b=sdtWTPtAjV3OzVSXlv9KzYNY5BriAr9q2Fi5qhnpYXes85cHiRlXUGBOheOqnmqvcq
         ksENvuK59gN37B0yM5vMSm1xAi/Mthw/H9ineAmEMaC9Far1FSPb2Ywe1WKr68pE5wGp
         xN5KE+HyKzcA7jaT2DWxQyokqTzXnAFb5Ae7yPYU1jLoQGnAh4a+uDi4wxFuTNhDG2aw
         AYoCJLuCSlTWVdYHa0ZPf9QHqyRCtI68YtMguWVnV0SHBjlkfJH0DxSLEcr1DjbObb/+
         vVJE1RO/bnmmXzEQFr6iBmLhncO+ox52tmUuYuCKoMf63+VedbM63Fpa/sxPrtSKLtVY
         K8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVIReaIaZHupAmcY7bqLCjWcR8AipWJY9WzYCoBqbkO0h501cmwBuFnTAjzDiUAmrmcgLaVEaBQk4bGeR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6QqEm3+EbCeD3CeXcfVBTpxSmTOWnRcShyYp+TvvwmQ5/Sm3
	HEgXmt1VNN6iXS6n2j4dUcVXeDp/uxuW6M9GjJouJJhRAJVwjqlB+88i
X-Gm-Gg: ASbGncvDVzXVIEjFsu7BFBmpTWZ1dLqUot6Qp9wBLjwkd/OuDpRdSfe/u2RUjE3AdZ+
	icWlkU2veCmVmwnBJVy0k3zbw6U5Dvvmk/9N9OCvYg5Qm4G0a7Kzh1kv3RMXFVrm411XPvUofUE
	vt3hF/C8V267doXOWSpRl1bWmensyuYA8P/HyqAYjFnHgib4SZQ/U+InJOG4GGGwJ/QOXJkSiyA
	6chT6RU0jZsMgnVUpUU4H7FnF1+5Wjt4wumAyPRc28SrqSFiGS+n7uwSA5zHQhx/H9N7T9lls5K
	9JDzExAJmqDlDZm69J1jdoVvOQlRidWhDsYdJsQ9e/MXtkOpViLqi2aMfpGa8oZDmejQAf/4UCz
	HW+pM1JD5AzJkFz1s1MoSFvhiOR8NPsp0+3QPP3KhBcuHxxypgFZw3hfaTwkGlmBoT0k9LsWrhQ
	I=
X-Google-Smtp-Source: AGHT+IEF/aCTeVvSBrO05FwR6QofuqxkKDZvPY8nTM2m7UVq5+hTdMYW/LkSoT6imz0KOJoiVM2kVA==
X-Received: by 2002:a05:6a20:728a:b0:2b5:9c2:c579 with SMTP id adf61e73a8af0-32da84ea53amr32225959637.54.1760426439338;
        Tue, 14 Oct 2025 00:20:39 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm11937092a12.18.2025.10.14.00.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:20:39 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 2/2] PM: hibernate: make compression threads configurable
Date: Tue, 14 Oct 2025 15:14:18 +0800
Message-ID: <9f15307fcf22784a82fc1957133dfc2296930c33.1760423687.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760423687.git.luoxueqin@kylinos.cn>
References: <cover.1760423687.git.luoxueqin@kylinos.cn>
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
index f8c13f5672ec..540cf902498c 100644
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
+		cmp_threads = 3;
+
+	return 1;
+
+}
+
+__setup("cmp_threads=", cmp_threads_setup);
-- 
2.43.0


