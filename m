Return-Path: <linux-kernel+bounces-691549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00895ADE5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2B175709
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DBD28468C;
	Wed, 18 Jun 2025 08:45:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53227F004;
	Wed, 18 Jun 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236339; cv=none; b=CXuZCq8rHBRL6DK6zYe9KvutztaNLCH2KrmfOazVO9ZWzn6EuHSGmMx897l0gsxWli0R9XzuxdgmyYLw005EuR8F+yHd3lDISvarxHw3warVz/h0I6QC39tI+8CKuwq3O2uVuqwOzXAMEPLK/k6HlrHpnk7C3G2PKht6d3FfK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236339; c=relaxed/simple;
	bh=/scxFsdOhOWauDCYQ6qQPC249bPouqja97HS52+FhHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSUNsAUtHyn8iPE7SsSeeBxsVwBzLnRHZsH2ZGYUoUSVY9duvlMeziz1kHbQgrKSBpCM+B6+UCEE6leLT9yOrs70FwtPKLeUhJIYgKaASThkSi2tywBTjTEMFIxP6OVABRMmfECm2hjdCxYyF5OkcHYQfDqmk9aeg31rkNarNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A85514BF;
	Wed, 18 Jun 2025 01:45:15 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857E03F66E;
	Wed, 18 Jun 2025 01:45:33 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	pcc@google.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	yury.khrustalev@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v9 07/10] kselftest/arm64/mte: add address tag related macro and function
Date: Wed, 18 Jun 2025 09:45:10 +0100
Message-Id: <20250618084513.1761345-8-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618084513.1761345-1-yeoreum.yun@arm.com>
References: <20250618084513.1761345-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add address tag related macro and function to test MTE_FAR feature.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/mte/mte_common_util.c       | 17 +++++++++++++++++
 .../selftests/arm64/mte/mte_common_util.h       |  2 ++
 tools/testing/selftests/arm64/mte/mte_def.h     |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 5c5680a87498..d9702a542cb6 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -6,6 +6,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <linux/auxvec.h>
@@ -130,6 +131,19 @@ void mte_clear_tags(void *ptr, size_t size)
 	mte_clear_tag_address_range(ptr, size);
 }
 
+void *mte_insert_atag(void *ptr)
+{
+	unsigned char atag;
+
+	atag =  mtefar_support ? (random() % MT_ATAG_MASK) + 1 : 0;
+	return (void *)MT_SET_ATAG((unsigned long)ptr, atag);
+}
+
+void *mte_clear_atag(void *ptr)
+{
+	return (void *)MT_CLEAR_ATAG((unsigned long)ptr);
+}
+
 static void *__mte_allocate_memory_range(size_t size, int mem_type, int mapping,
 					 size_t range_before, size_t range_after,
 					 bool tags, int fd)
@@ -330,6 +344,9 @@ int mte_default_setup(void)
 	unsigned long en = 0;
 	int ret;
 
+	/* To generate random address tag */
+	srandom(time(NULL));
+
 	if (!(hwcaps2 & HWCAP2_MTE))
 		ksft_exit_skip("MTE features unavailable\n");
 
diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.h b/tools/testing/selftests/arm64/mte/mte_common_util.h
index 4e1dd959df9b..045e4ad2f018 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.h
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.h
@@ -56,6 +56,8 @@ void mte_free_memory_tag_range(void *ptr, size_t size, int mem_type,
 			       size_t range_before, size_t range_after);
 void *mte_insert_tags(void *ptr, size_t size);
 void mte_clear_tags(void *ptr, size_t size);
+void *mte_insert_atag(void *ptr);
+void *mte_clear_atag(void *ptr);
 int mte_default_setup(void);
 void mte_restore_setup(void);
 int mte_switch_mode(int mte_option, unsigned long incl_mask);
diff --git a/tools/testing/selftests/arm64/mte/mte_def.h b/tools/testing/selftests/arm64/mte/mte_def.h
index 9b188254b61a..6ad22f07c9b8 100644
--- a/tools/testing/selftests/arm64/mte/mte_def.h
+++ b/tools/testing/selftests/arm64/mte/mte_def.h
@@ -42,6 +42,8 @@
 #define MT_TAG_COUNT		16
 #define MT_INCLUDE_TAG_MASK	0xFFFF
 #define MT_EXCLUDE_TAG_MASK	0x0
+#define MT_ATAG_SHIFT		60
+#define MT_ATAG_MASK		0xFUL
 
 #define MT_ALIGN_GRANULE	(MT_GRANULE_SIZE - 1)
 #define MT_CLEAR_TAG(x)		((x) & ~(MT_TAG_MASK << MT_TAG_SHIFT))
@@ -49,6 +51,12 @@
 #define MT_FETCH_TAG(x)		((x >> MT_TAG_SHIFT) & (MT_TAG_MASK))
 #define MT_ALIGN_UP(x)		((x + MT_ALIGN_GRANULE) & ~(MT_ALIGN_GRANULE))
 
+#define MT_CLEAR_ATAG(x)	((x) & ~(MT_TAG_MASK << MT_ATAG_SHIFT))
+#define MT_SET_ATAG(x, y)	((x) | (((y) & MT_ATAG_MASK) << MT_ATAG_SHIFT))
+#define MT_FETCH_ATAG(x)	((x >> MT_ATAG_SHIFT) & (MT_ATAG_MASK))
+
+#define MT_CLEAR_TAGS(x) 	(MT_CLEAR_ATAG(MT_CLEAR_TAG(x)))
+
 #define MT_PSTATE_TCO_SHIFT	25
 #define MT_PSTATE_TCO_MASK	~(0x1 << MT_PSTATE_TCO_SHIFT)
 #define MT_PSTATE_TCO_EN	1
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


