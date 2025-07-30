Return-Path: <linux-kernel+bounces-751329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3FB167C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DCF7AA2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA60221D94;
	Wed, 30 Jul 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+qJ1w9D"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E921C16D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908664; cv=none; b=QniiE1L8g3OnxaCGd3zQ9wRUnijuzC8IUYUxA4LFp1x89rLPqO56dh7Dho+fWr5nnVrXOf7yjSaVblY0ORlGG7vKKPRXp9HfUi5LZymwhygNMcYdyOJRQ4zX/XWAfg+I2luO1vnmfyGemkqnjoMB9LqoFjv7qyqpixvP8Go21p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908664; c=relaxed/simple;
	bh=t3N7WtR4RfBRmftjkE7xfrmPPh5HlmkVCRgdTnGFxNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG7eOR+FQDUq0JVk/zbvzxDaqmCLp2SXIC+bZ43Ce9TpKa2UvDQheAicXHSJw5n6ktv46ijRqiQyGqP6QX/waoKzMy4OEQtx+N0KNLDtQfbdSew48ixASDi6wJ6a/uRPO+8/bH3IveNS0RICzh21mg8wvpuieEg+/E2QPQ/y2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+qJ1w9D; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab7082b3f7so2468731cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908661; x=1754513461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxsQTv+1d89X+/7XUvxxHrkY1JbEEOii8Iv+aCI0JR0=;
        b=e+qJ1w9D/pcBvpjjPTnFFAJKhrZQF6lU8eIGZ6btt6gi1q+pCVw28Cbo/AueLKu8sU
         WSqNA9dZIH3t567CF1B7YrTLcfHcsX4K/jplWaUvc870dydk2C3pUs9nrPcpJE5CuzW0
         ZqJk62O46cLFFL/Ma2PsdfXrMiRjzhPFpg+97YfSo7o2y9t+8NYEhxmIWzp/p+1TlERr
         WZu0LQkooS952S2mqfSmc3UenY56rcpmcFUKMgSNcpB1lW4PAniPIJUZd7jgcM/qihDJ
         ACASjkpJpsB0PflEdEnYeFwK+uOY0uGuQO52udpPBNmZ69HF7e1vVXiJUGallVsOSryO
         dHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908661; x=1754513461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxsQTv+1d89X+/7XUvxxHrkY1JbEEOii8Iv+aCI0JR0=;
        b=hj9dtQny1DLn1SC3+Q83fwR2PEjiDzYbpLA+Jr2NOIZpP4/dGS4Sa9ZTgQjp9mAi8Z
         Lgke97NnNoJjlEbTu65u81XzWZErkGLHxkuH9kRB9w0SPXeLgNMnS8ieMSGrf2mzDbF4
         4xOo/m0bRKYvp2duGDCbZtz6Y6oCqWvwWZXm3XvSFMRZVTfN/VFKB31eFKIftkR/koDS
         TXHoXfdBa1lJqI49Dwu2JUCgpoVm6ltwvwn+6SLKTbsyerYHNwYLdp3JzQu49eOC6Uby
         AbeR6qlrTUOEdhOILgBKdAlLq0wdLZYgbjNill9IrWgv1DM+SfDdW/Oco5Ag/J9GGp1h
         NC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5cZSEge8ZMziMKKmN1xSAMmdcChJeJv2xs/OctQ8u4rVj5CTdHPTiktPmYwdhv6cC7W0zlCxXXNrGLdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5tbKbaMSUOY1vfCwj+xsC/YFrn+CSAoDqeSmPjx+Df8FDOd1
	O6gvD3ODP8Yi4+2xvPHiid/RXuU4wZwXNGlmwdBrr4YYt0GWOkCeGEa2cJUWn1Q8
X-Gm-Gg: ASbGncv5MoekipHZD+dbUNKzExTZZDnfBHHtx/Y406JOji8srRDOl312FL68GIaKItT
	RNkC1+yTob8QRpCeJNjE/cvQf2HkZyv+3DroZACLyPBxlwbBA0e1IZjNNqFEz+wbM5jr/bFhC6w
	X5lvon2KPd0RA8H/TMBOBqey4402ZAgEtPya5kSu6+ydxnRz3ITHyIYnzaUxkNVV1SXg+xg+GLx
	sV4ySkYR69ZyAO5rwE04a3pl/fFlZa29X5oIDTSx5IFKUvpKY6eVbEtt1J7Ndqqm8by5FQZR1xO
	slfKU5+MAg3JKRxnIwDe1bT8vQl/cQxc/NgHZc9kPNA2YrVQJRIIdq9BnwNGx2LZoYfUtXCy65m
	BG8Y9lo8uDUzMQNda9oY05yEMVWhPQd16
X-Google-Smtp-Source: AGHT+IF4SY6nqUnAOs7SYh4/F2wVLWmnhhH7H+aOriIH4llzUs34xcg/l57609kc1KE/JMjE9h1v4w==
X-Received: by 2002:ac8:5887:0:b0:4ab:95a7:cfa5 with SMTP id d75a77b69052e-4aedbc7a2ecmr84409361cf.56.1753908661426;
        Wed, 30 Jul 2025 13:51:01 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeee2570asm758721cf.63.2025.07.30.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:51:01 -0700 (PDT)
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
Subject: [PATCH v3] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Wed, 30 Jul 2025 16:50:46 -0400
Message-ID: <20250730205046.29719-1-ImanDevel@gmail.com>
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
overflow is also completely out of reach here due to the small and
fixed buffer size. The error check in latency_show_one() is therefore
unnecessary. Remove it and make dmar_latency_snapshot() return void.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v3:
- Restored return type of dmar_latency_enable() back to 'int'. It was
  mistakenly changed to 'void' in the previous version.

Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
  https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/

 drivers/iommu/intel/debugfs.c |  8 ++------
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 3 files changed, 8 insertions(+), 15 deletions(-)

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
index adc4de6bbd88..dceeadc3ee7c 100644
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
@@ -156,11 +156,9 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
 	spin_unlock_irqrestore(&latency_lock, flags);
-
-	return bytes;
 }
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
index df9a36942d64..1d4baad7e852 100644
--- a/drivers/iommu/intel/perf.h
+++ b/drivers/iommu/intel/perf.h
@@ -40,7 +40,7 @@ void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
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


