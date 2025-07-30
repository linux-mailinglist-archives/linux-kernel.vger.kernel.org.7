Return-Path: <linux-kernel+bounces-751324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327DB167B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3826247F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF642206B7;
	Wed, 30 Jul 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1U4WXo4"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C321480B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908061; cv=none; b=jbC+l/AXoDNRHpM3TeTK9mKghV8R4o9IYxawsUZVf6S4XHDzLIaSljOosCQN+S5jWBJcVQf6CdDoQTwYgvrOFwXqVRkQJzUEvdp6aGKbOZYF8AhtJNMwbeuQpC9IXa/7r0vHUxNgEPkM5DBz+wC7bFcmg/i9vEL+7ivStKkHN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908061; c=relaxed/simple;
	bh=CsObEssTfFyAOuxMHOBuH4SwCM9FsgK44eMrRV/+Bag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixIRBkN5pXb68BPSPAIAfwlkR8FOtXn3YjXpUXYaCQOlk9YGxzSpX2hbQY4LEiBcNPgSlMluMytVQy+KaXzcV1A8fE/bZVUPN4BmNAIDCZ/uVXD9AXlA2BtwDqTR2mfXasE4YN8quWy4oyfkN/7/RxKfHBGwDE88s5qYoYGrpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1U4WXo4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7076b55460eso2636656d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908058; x=1754512858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XLKL6Xhg/Q0qq3baCuq/rD4471fpLDdQOk3nBX3yRc=;
        b=j1U4WXo4jichiglukgarpgWbg2vvV7SwDh+uy2jb1wevp7XWg/SxblZHmpRHLdyr+P
         t09WE1P8Dfsl3a7xOYu9R35uAQ83XzLUwKgCZ5D5YQLl/WnggtT3CVjf24E8gWqgF3fr
         Qf0hZVSNhNmmmCxX1CJtckSKjlGyxr0CbB6iPEfUDp0mKtE/mqZfXJ6vMwhCjTa16+78
         69dTdDchHTSnY9jAIYW696XnG2mvBwB0k70f+Q5MFfxGl2TtqeY1Mv/HGzAPxME4fjq4
         H6HHTOK44oKPyZevxix7mxU6kzRoE433RXMfLmGvyYmuhidvCdEoRb8ZKSgCuaHcF6WD
         w9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908058; x=1754512858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XLKL6Xhg/Q0qq3baCuq/rD4471fpLDdQOk3nBX3yRc=;
        b=oUjWw30rThyNte+in+XWNvF0hy1Phg+9ka+cy2tzggWcGDjDNf22ljqzm2n+8uRVBy
         TTQeQsFxXWDRWlDHnheBIQZfIH0YsFCI1h6/7OvDo7oG+qaSNOQ3NLLfdlXLdP4bD531
         U7vlr12kJhsEG5hMN3SuXwkDgFflEdVLsgt9jlgbgG+rwdwGlz5IRRwo4YRoOHZaDIYw
         EQTZyYFae2l/21XZ4ETARQj1pin//CtVDimCY3Q2C6O19jjPwzRsP+bPQg5QniNW2DLW
         6fWUa5QMtJ4+Jwp6O9BEw31c0baPeabF4BP3VzYQpE0n3pQgPFRbVtDjFMdH1ujIH7bi
         ftOw==
X-Forwarded-Encrypted: i=1; AJvYcCUxDCFq+WjbcDaj+ou090/DtDUNciapX4gu5jRTMogAC365e1gU9giq3CrgZEFav/v4a4ZrLgIpE20ubsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydp0Bf2UUGBmrpovRML0NlCPWvBYRJ5gYHkYisTMNGHaAkZ5M+
	4RtErZuVPgv3qMDkQQdcC7LGDkm/Kwa39mrapzwOGsQzOr4D+Ash8oFm
X-Gm-Gg: ASbGnctYYq6xWigsOLk1KoT0rjaDzj7F98vdMsAgF6CfUhvIxCXGBwfBWq0sCpkeuHm
	CoSPo/8BOwZoYIM9h+2PyIIoJN4klHadzyP8v82ikJIexIzHr+rAThmECLV4NEyDnk7ju1easDM
	dSFJY0wJ4H0omp5/gHoDkpI2jdGFjGZpvJEd7Cr0qZQvSSESp4gJ+AX3zBYl3O78AURx2yPfOu0
	xWE83b5bFpujdvFZN3jdlnEu+3qsB3e/ODG++Zh7+QaaQVCVR9h+SaGuj8sUmim6xo6LHhoDOz4
	/StpCgpnlupAkaUlX5J5QP3BM0TQhxiiC3FfyerBHZ0hOAP+5SLKIdxjZmHg9SrY9IC2hxLvA53
	adZGHVwWrhuUsnj5KlIiBCWQ1+lx/8zef
X-Google-Smtp-Source: AGHT+IHKi+RRvgWVQA9W//b5vs7l10xfB5gOYL+kEfkwHUFEe1OBICZQr8vd/q/KpqPni1qwrTF87g==
X-Received: by 2002:a05:6214:2424:b0:705:c148:26a0 with SMTP id 6a1803df08f44-70767197d07mr74480876d6.31.1753908058186;
        Wed, 30 Jul 2025 13:40:58 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299ff109sm64448176d6.10.2025.07.30.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:40:57 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH v2] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Wed, 30 Jul 2025 16:40:37 -0400
Message-ID: <20250730204037.28159-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() returns the number of bytes that would have been
written, not the number actually written. Using this for offset
tracking can cause buffer overruns if truncation occurs.

Replace snprintf() with scnprintf() to ensure the offset stays
within bounds.

Since scnprintf() never returns a negative value, and zero is not
possible in this context because 'bytes' starts at 0 and 'size - bytes'
is DEBUG_BUFFER_SIZE in the first call, which is large enough to hold
the string literals used, the return value is always positive. An integer
overflow is also completely out of reach here due to the small and fixed
buffer size. The error check in latency_show_one() is therefore unnecessary.
Remove it and make dmar_latency_snapshot() return void.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
  https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/


 drivers/iommu/intel/debugfs.c | 8 ++------
 drivers/iommu/intel/perf.c    | 8 ++++----
 drivers/iommu/intel/perf.h    | 7 +++----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..c4aca0eb5e29 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -653,12 +653,8 @@ static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
 	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
 		   iommu->name, drhd->reg_base_addr);
 
-	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
-	if (ret < 0)
-		seq_puts(m, "Failed to get latency snapshot");
-	else
-		seq_puts(m, debug_buf);
-	seq_puts(m, "\n");
+	dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
+	seq_printf(m, "%s\n", debug_buf);
 }
 
 static int latency_show(struct seq_file *m, void *v)
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index adc4de6bbd88..7e726e1ba40b 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -113,7 +113,7 @@ static char *latency_type_names[] = {
 	"     svm_prq"
 };
 
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
 	struct latency_statistic *lstat = iommu->perf_statistic;
 	unsigned long flags;
@@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 	memset(str, 0, size);
 
 	for (i = 0; i < COUNTS_NUM; i++)
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "%s", latency_counter_names[i]);
 
 	spin_lock_irqsave(&latency_lock, flags);
@@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 		if (!dmar_latency_enabled(iommu, i))
 			continue;
 
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "\n%s", latency_type_names[i]);
 
 		for (j = 0; j < COUNTS_NUM; j++) {
@@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index df9a36942d64..dcf2741c2d53 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -35,12 +35,12 @@ struct latency_statistic {
 };
 
 #ifdef CONFIG_DMAR_PERF
-int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
+void dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
 void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
 bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
 void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
 			 u64 latency);
-int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
+void dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
 #else
 static inline int
 dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
@@ -64,9 +64,8 @@ dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 laten
 {
 }
 
-static inline int
+static inline void
 dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 {
-	return 0;
 }
 #endif /* CONFIG_DMAR_PERF */
-- 
2.50.1


