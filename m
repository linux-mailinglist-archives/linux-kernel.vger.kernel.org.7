Return-Path: <linux-kernel+bounces-837983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4DBAE2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA75326360
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9830CB23;
	Tue, 30 Sep 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P5Et0A+M"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727D23C8AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253299; cv=none; b=W7pX4o0if9Wo9TN/FYiJmBednbx14+sGmFcuyu5R5k9wuQMis44xGUzfDSN27j8y4pRpm9cmY/721pR54iNrD7F4eYWww0Sj+07KOGJngVh59FQ2rL7RclEs1uZx/MmId8JZp10Bi2MRDBCGGmMmUznFJDDPVkltjJPFjcYioa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253299; c=relaxed/simple;
	bh=tUnvFmCCxQCmLoZJDB6NRrJPLZGedTfuLJ+idkUQuS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyOO6JDUZ1Ggvurek52hlzf0hoAkE7HU0+GI+ZbaE5qeSmribIl4PzCM6oTs5zFJXJLEn3i8n1t0oKikUCA9+bRfW94YeMrO1/L3gnj/9SS1zXkob+6YJSGD9jg1a7FAXYIxzZ3WDVPJpuBiU6ncLtahLlzPJra5a1B9Y0ym6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P5Et0A+M; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759253293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jXdDUesC5zbmyy8oZM7nt2zHLqp0Qspm6EZEQwCjGM=;
	b=P5Et0A+MsrYTHxup/MJD2+4oY3ArVUnaC/Ht9tAea35pIzFGKf2gJu1O2sSrsRXBdqqG72
	P8V/E9XnDXQk+5u9XJgaQ/ceT57orkNTnuj+q1QzE1KjSnCa3PoAv4kgHhUM1ot1znN23N
	NjGFOZ20DhXnQ/vat91P6it0K6x9W+Y=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 1/6] cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
Date: Wed,  1 Oct 2025 01:27:26 +0800
Message-Id: <97c153dc50435689e06ca620ce871c8165d966d3.1759251543.git.wen.yang@linux.dev>
In-Reply-To: <cover.1759251543.git.wen.yang@linux.dev>
References: <cover.1759251543.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit c3719bd9eeb2edf84bd263d662e36ca0ba262a23 ]
RISC-V's implementation of init_of_cache_level() is following
the Devicetree Specification v0.3 regarding caches, cf.:
- s3.7.3 'Internal (L1) Cache Properties'
- s3.8 'Multi-level and Shared Cache Nodes'

Allow reusing the implementation by moving it.

Also make 'levels', 'leaves' and 'level' unsigned int.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-2-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/riscv/kernel/cacheinfo.c | 39 +------------------------------
 drivers/base/cacheinfo.c      | 44 +++++++++++++++++++++++++++++++++++
 include/linux/cacheinfo.h     |  1 +
 3 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 90deabfe63ea..440a3df5944c 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -115,44 +115,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
-	int levels = 0, leaves = 0, level;
-
-	if (of_property_read_bool(np, "cache-size"))
-		++leaves;
-	if (of_property_read_bool(np, "i-cache-size"))
-		++leaves;
-	if (of_property_read_bool(np, "d-cache-size"))
-		++leaves;
-	if (leaves > 0)
-		levels = 1;
-
-	prev = np;
-	while ((np = of_find_next_cache_node(np))) {
-		of_node_put(prev);
-		prev = np;
-		if (!of_device_is_compatible(np, "cache"))
-			break;
-		if (of_property_read_u32(np, "cache-level", &level))
-			break;
-		if (level <= levels)
-			break;
-		if (of_property_read_bool(np, "cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "i-cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "d-cache-size"))
-			++leaves;
-		levels = level;
-	}
-
-	of_node_put(np);
-	this_cpu_ci->num_levels = levels;
-	this_cpu_ci->num_leaves = leaves;
-
-	return 0;
+	return init_of_cache_level(cpu);
 }
 
 int populate_cache_leaves(unsigned int cpu)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 26e13887aba4..7663eaddd168 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -223,8 +223,52 @@ static int cache_setup_of_node(unsigned int cpu)
 
 	return 0;
 }
+
+int init_of_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
+	unsigned int levels = 0, leaves = 0, level;
+
+	if (of_property_read_bool(np, "cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "i-cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "d-cache-size"))
+		++leaves;
+	if (leaves > 0)
+		levels = 1;
+
+	prev = np;
+	while ((np = of_find_next_cache_node(np))) {
+		of_node_put(prev);
+		prev = np;
+		if (!of_device_is_compatible(np, "cache"))
+			break;
+		if (of_property_read_u32(np, "cache-level", &level))
+			break;
+		if (level <= levels)
+			break;
+		if (of_property_read_bool(np, "cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "i-cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "d-cache-size"))
+			++leaves;
+		levels = level;
+	}
+
+	of_node_put(np);
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+
+	return 0;
+}
+
 #else
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
+int init_of_cache_level(unsigned int cpu) { return 0; }
 #endif
 
 int __weak cache_setup_acpi(unsigned int cpu)
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 00b7a6ae8617..ff0328f3fbb0 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -80,6 +80,7 @@ struct cpu_cacheinfo {
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
+int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
-- 
2.25.1


