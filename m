Return-Path: <linux-kernel+bounces-861440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00781BF2BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72E1F4FB4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AB3321CB;
	Mon, 20 Oct 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rNPSE9VP"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3423321C5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981833; cv=none; b=fX292W1ij/9/7q6T/4VAecaDsJbJGV+r1LH1E9ToSMU4wqHxXSqZfKOWUza9o4cNTfZI877WxvOJJNrRMMJQq0CRxO5xkN6yc6bmbrmbx8M0gFt2rRM1MUOtgnivoxAQuSExkBC3CifrJUxac0W/9JNAbuvzbuA3Dbu6lCvD5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981833; c=relaxed/simple;
	bh=7FWRRuUr0NPDt9srgoKtdHi04YZV5u2d3P8yEn31ikE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEwivgYHjU8CiYdYmh39fMg30FFKyQUq/ZllKTH99WhVh36511byU/sB0dGS+TCSYCnEusYkxyEREBN0lgPBV6WiOYfk66116kZk10tnSDztv3WKgXQjVPHz2hBiP+96JhMlLieR0RHNyx4jD0BU/5+OVZ57Mownp0nR5MAr3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rNPSE9VP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPalUgdnLDU31YmTgBLbYTrr5ltLFLk4XsuAkkg0cvo=;
	b=rNPSE9VP/Vlt1/lUcHlnlYQVgHIAtQbdd1RGWkuGCDKbbjZ0urxA/vejCfJGi/QDMIQcIH
	2M5UPhp/dKbPhbwnyjmGUQCkzKRJ2kJmbPslKBeQ9t/eyCKsov70h/5TMPyrwL/z/EEzq0
	zVWUu70JU1JEN1b5UvHvyuJ5yGJvEus=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 03/10] cacheinfo: Check 'cache-unified' property to count cache leaves
Date: Tue, 21 Oct 2025 01:36:17 +0800
Message-Id: <20251020173624.20228-4-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit de0df442ee49cb1f6ee58f3fec5dcb5e5eb70aab ]

The DeviceTree Specification v0.3 specifies that the cache node
'[d-|i-|]cache-size' property is required. The 'cache-unified'
property is specifies whether the cache level is separate
or unified.

If the cache-size property is missing, no cache leaves is accounted.
This can lead to a 'BUG: KASAN: slab-out-of-bounds' [1] bug.

Check 'cache-unified' property and always account for at least
one cache leaf when parsing the device tree.

[1] https://lore.kernel.org/all/0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org/

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230104183033.755668-4-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 480007210bcc..ab99b0f0d010 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -224,12 +224,9 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 
-int init_of_cache_level(unsigned int cpu)
+static int of_count_cache_leaves(struct device_node *np)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
-	unsigned int levels = 0, leaves = 0, level;
+	unsigned int leaves = 0;
 
 	if (of_property_read_bool(np, "cache-size"))
 		++leaves;
@@ -237,6 +234,28 @@ int init_of_cache_level(unsigned int cpu)
 		++leaves;
 	if (of_property_read_bool(np, "d-cache-size"))
 		++leaves;
+
+	if (!leaves) {
+		/* The '[i-|d-|]cache-size' property is required, but
+		 * if absent, fallback on the 'cache-unified' property.
+		 */
+		if (of_property_read_bool(np, "cache-unified"))
+			return 1;
+		else
+			return 2;
+	}
+
+	return leaves;
+}
+
+int init_of_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	struct device_node *prev = NULL;
+	unsigned int levels = 0, leaves, level;
+
+	leaves = of_count_cache_leaves(np);
 	if (leaves > 0)
 		levels = 1;
 
@@ -250,12 +269,8 @@ int init_of_cache_level(unsigned int cpu)
 			goto err_out;
 		if (level <= levels)
 			goto err_out;
-		if (of_property_read_bool(np, "cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "i-cache-size"))
-			++leaves;
-		if (of_property_read_bool(np, "d-cache-size"))
-			++leaves;
+
+		leaves += of_count_cache_leaves(np);
 		levels = level;
 	}
 
-- 
2.25.1


