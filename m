Return-Path: <linux-kernel+bounces-752671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB6B17930
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F4217B830
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42779279918;
	Thu, 31 Jul 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQfzDTLe"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5F2253FD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002267; cv=none; b=A24dBC7pTxAtdluaZgxidErJLlKGA/0MehgAw8JhPt6mXK691D7MtA2MYY8UnFaCcSiitpbF6Is+NVFwsgTzaubcHkdpUZOdw98kv9mEnEqf5q8c6hSKCGUBOGTRNW5nuALW13o9zmloJmiYA62IK3sccvh2jPzSoTmxS/hgNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002267; c=relaxed/simple;
	bh=KkcxjOXc7+CTAwF08gBNE8VfSajbR19kNgI7NYDtjX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJFwrj3Hck2Im1kod+AdQwQUV9e2NbMv/PUap4YIKiXB983SZoUXCJAZyvJWmiWE2ciEGAvAecEXxB7K6kE3RI+g3hFq43b4RrAk2NeKypHsl3xTu12eb8qhjGQAx/roNC9ubOoIxZhNDV9eD+nyR5pjIFKeqNZWgAcSdbgXGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQfzDTLe; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aef4715270so9482501cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754002265; x=1754607065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BacIjUI5j5irCjGWnkKtBCyvI9Gfht+wak48AY934y0=;
        b=gQfzDTLeWTmrYaYd1fnfSTOVWaTHhuY6kg4Pfo+MqK0PU5aCNU0oVfEMZOwrBnz1My
         6Ads2dWf5ZvD8hrBD21aGAcwFd4UciwFN1G+Z6EcmlisYPePoKJsESlvliI6fx1d9HsG
         inJFQRW6bkTvpOsegViEJuGMpHnu8vX3Po2U0gkDl2qe/jNFGEwlXaaBl/ijCSrtkniV
         marziLFZ6apzl54etAr0VS5PfCWTQVtHpTkRnDzy584oFHcEG4gq0V4NBC//+nUcVG5x
         MOJgmbgLJIk+HoHR2j8SZl8aRRlOawqC/uht0Vj1Oecj61yAMSgkZWkcAacBbG8EzIh/
         uM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754002265; x=1754607065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BacIjUI5j5irCjGWnkKtBCyvI9Gfht+wak48AY934y0=;
        b=Kd058RalI8TZ9Q2J+WEdftZuGceuM+hjRSDJ1Q8Em5XvDlOsl0sK0MFqW1yf7YtmXA
         1v+hrzYhXY7TKjnq+c4jYeFuDReRVWpXEOAhz19HPMFS6Tx0cKA7YLVBUlMKvQTItqgY
         Z/inrptjrIwH7oQY8Y6A44vrzt/GdZskm26BPfeddJqouPFYP4OYGTORZY7Ogphz6KSI
         WFuWsHeARnUOS3CXhuJCo/yLNpGJA8zkdMuKckuqFpA9DNX2jJNf0M0NJ0Nz24danT59
         IjGBsRkfzDsw+7pO9AZyTWvrSYDeFkw/sDewIpGie/CJJGKEWz0vbT7j7TG6rmaSL2e+
         RfEw==
X-Forwarded-Encrypted: i=1; AJvYcCVNpM9f4nz4CIRPVnXeGWBcmIrXdhQNsFy/xr2tIVRFa81+BJ84cu9TkruZad0m4uyiVTxu4G+L5J+g+TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgelxZ0Cy+FUylYyo5MpnEoPRrWpNRNfgGUmXvm57EMoSiLmvp
	5svdyv4duHdLDdD7jBDhhA6aHj3ha640YM67QWzZyRgzqugb92M+2Yo2
X-Gm-Gg: ASbGncvp7NW496bnnHHosg/M96LHfQQghIkbCmj13J9lRHVVFF8g6wlCNl9zua/l7bn
	VAjJAVY2PGhzVVKcjkUKXCamSHlBea1luYUiwDD7udL7b8uIt0I+3NO44WCK3cdIy+mc8w8LWxQ
	fig2tMyuiT/FRdL/g6avi3jECLO6wi82yMEYXzYREBqgKyCE1VZNpBswiE+O4zMVyJTjoCfcYXQ
	lZNl19ur5/dNMgYnfG8XrIMiDGLOK/WJcVqUj8rAvy+XPUA67K7XbMhqbSWqX6JLVI4S02eVqQX
	ryHW8WKNKKJz6AHvC+AS3IjD1ysPCIwipk8QcdKvveD1N0v+P1PcnAKt1aHKtFCdLpDr85UCb1E
	W/2sV15KUnfY6nZBHRDBJgw==
X-Google-Smtp-Source: AGHT+IGEvcLf+uHQE2HUx5wsDP+6Qu8CrTw9fgYQNF2HHdCJeuoHSeknHkmSpDe/9TWgZDJ2PqYdzA==
X-Received: by 2002:a05:622a:118e:b0:4ab:651b:5f17 with SMTP id d75a77b69052e-4aedb99c9a0mr146640581cf.18.1754002264517;
        Thu, 31 Jul 2025 15:51:04 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeee0eca8sm13756151cf.56.2025.07.31.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:51:04 -0700 (PDT)
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
Subject: [PATCH v4] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Thu, 31 Jul 2025 18:50:47 -0400
Message-ID: <20250731225048.131364-1-ImanDevel@gmail.com>
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
Changes in v4:
- Removed 'ret' in latency_show_one() since it is not being used anymore:
https://lore.kernel.org/oe-kbuild-all/202508010632.WB0CM5Bz-lkp@intel.com/

Changes in v3:
- Restored return type of dmar_latency_enable() back to 'int'. It was
  mistakenly changed to 'void' in the previous version.

Changes in v2:
- The return type of dmar_latency_snapshot() was changed based on the
  discussion here:
https://lore.kernel.org/linux-iommu/aIDN3pvUSG3rN4SW@willie-the-truck/


 drivers/iommu/intel/debugfs.c | 10 ++--------
 drivers/iommu/intel/perf.c    | 10 ++++------
 drivers/iommu/intel/perf.h    |  5 ++---
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..65d2f792f0f7 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -648,17 +648,11 @@ DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
 static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
 			     struct dmar_drhd_unit *drhd)
 {
-	int ret;
-
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


