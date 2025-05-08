Return-Path: <linux-kernel+bounces-640145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22120AB013B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A06E503B99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FD286D47;
	Thu,  8 May 2025 17:19:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05820E700
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724770; cv=none; b=NygddmWmUgoeFd1z/gorQXNuADxWRwsZb506UD4C+A+82uWXwOj+Sk3MsRSVwa8t6UKAsShSqCCdql1qJuClZuSs54TTgT3kE7h0HcZEG8GRBT6kWEsOjwTBEM4Ert8JYaUEgO9TYF4VOrSozkVMe9742iE0nDPwV8PTPA6qWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724770; c=relaxed/simple;
	bh=4PcxyCLxRw5xLFxd+3PFvbroo5a4qaiLNukIyi6hYuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozEp/bi5jF0+brbOYqaflsbspwg5yUecNRXAfD4H+lfDvZVDjbJpnkOV9np3VwmlboHPmontEJ3kMPAuRVpFcx7uA9/6rwRpanZfJMYvT5MZgkL7afyAXPH1uzXdV9O2PADjb9TKDotlxcRPY3F38syv88eXHbB6K4621ffm4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B54E236D;
	Thu,  8 May 2025 10:19:17 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770113F58B;
	Thu,  8 May 2025 10:19:24 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: [PATCH v10 02/30] find: add find_first_andnot_bit()
Date: Thu,  8 May 2025 17:18:30 +0000
Message-Id: <20250508171858.9197-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250508171858.9197-1-james.morse@arm.com>
References: <20250508171858.9197-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

The function helps to implement cpumask_andnot() APIs.

Tested-by: James Morse <james.morse@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/find.h | 25 +++++++++++++++++++++++++
 lib/find_bit.c       | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 68685714bc18..5a2c267ea7f9 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+unsigned long _find_first_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size);
 unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -347,6 +349,29 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_first_andnot_bit - find the first bit set in 1st memory region and unset in 2nd
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first set bit
+ * If no bits are set, returns >= @size.
+ */
+static __always_inline
+unsigned long find_first_andnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_andnot_bit(addr1, addr2, size);
+}
+
 /**
  * find_first_and_and_bit - find the first set bit in 3 memory regions
  * @addr1: The first address to base the search on
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0836bb3d76c5..06b6342aa3ae 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -116,6 +116,17 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
+/*
+ * Find the first bit set in 1st memory region and unset in 2nd.
+ */
+unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_andnot_bit);
+
 /*
  * Find the first set bit in three memory regions.
  */
-- 
2.39.5


