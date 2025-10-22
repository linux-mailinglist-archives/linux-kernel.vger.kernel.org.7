Return-Path: <linux-kernel+bounces-865825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F9BFE1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631193A8B26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9E2FAC07;
	Wed, 22 Oct 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="KELzKlql"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37562F28E3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163499; cv=none; b=hiYvgc2Ay2I04f9uXNY8OLW3JQFhJLTnG/4WSEDfp6LRWn9oIVTQjV7yL888qSannQqGYwkwiRpS3pccmDYFM9Ex8D2PTLVHyidiSrEHl2m1ma8Dl2hbMBrChycJt9s/qdNxZFKdEwKpscXDvjaAgJYXSanYHfM2qm7285da55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163499; c=relaxed/simple;
	bh=vArYOlHSw3dHtGB+jYnhJ5JVoTIgXSpWmJm6vATTd0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgzI0MK0neSltDkx4XHImFak25broksRXsEcZ7irUZKg1pwgOaWlhvhscVm9S2fwZIvWLYkxGAyKht1J1vt+EtNB/iIF7NX5xwYjcxQ5LY89CfP7VUBs4nQ9CL4yofuvUKsRXJOyz4DJpUPjl7ohgOq1v9rLrpXCegPq5SXmpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=KELzKlql; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 77ADA68B9A0;
	Wed, 22 Oct 2025 22:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761163489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFza/X3iPKHOe33ggUnPmTHTUIBGIsqXCELjzJk8XUI=;
	b=KELzKlqlV12u6YMu85rOQpxxOjFgHUuR+WQ+4TTL949Vfqz9HDeaA7HZuqrrQh27sea/J8
	vLniNDdy6iYvdkmJBFwgmrCM8lXKeI21NOc0+ijeUl8+tvCaIjXBpSP2A34c4QqGo7wpl2
	qnvWjbHF533fTu9EFgO0uv6sGBS/ve1/la+7Myc4qbgSfeB+2UzoAKq5Wru4A66ex0d8N5
	2Oc0lMbkPJoJpUXQ9B9MKeELiB3fbfRmoqu4smEoI58N9vfmRzXUT2UAse/QnSvZLrkxu9
	NYYBUGXBe+huH/eV9yKl5Fus7bgnl/7OOORm54XCuBoLgyIGFSVjGaIwU29E/w==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 1/2] regmap: add flat cache with sparse validity
Date: Wed, 22 Oct 2025 22:04:07 +0200
Message-ID: <20251022200408.63027-2-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022200408.63027-1-sander@svanheule.net>
References: <20251022200408.63027-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flat regcache will always assume the data in the cache is valid.
Since the cache is preferred over hardware access, this may shadow the
actual state of the device.

Add a new containing cache structure with the flat data table and a
bitmap indicating cache validity. REGCACHE_FLAT will still behave as
before, as the validity is ignored.

Define new cache type REGCACHE_FLAT_S: a flat cache with sparse
validity. The sparse validity is used to determine if a hardware access
should occur to initialize the cache on the fly, vs. at regmap init for
REGCACHE_FLAT. Contrary to REGCACHE_FLAT, this allows us to implement
regcache_ops.drop.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes since v3:
- Define new flat-sparse ops instead of modifying existing ones
- Update KUnit tests
- Allocate cache as flexible array to limit performance impact
---
 drivers/base/regmap/internal.h      |   1 +
 drivers/base/regmap/regcache-flat.c | 103 +++++++++++++++++++++++++---
 drivers/base/regmap/regcache.c      |   1 +
 drivers/base/regmap/regmap-kunit.c  |  14 ++++
 include/linux/regmap.h              |   1 +
 5 files changed, 109 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 6f31240ee4a9..8d19a1414d5b 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -288,6 +288,7 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 					 const struct regmap_bus *bus,
 					 const struct regmap_config *config);
 
+extern struct regcache_ops regcache_flat_sparse_ops;
 extern struct regcache_ops regcache_rbtree_ops;
 extern struct regcache_ops regcache_maple_ops;
 extern struct regcache_ops regcache_flat_ops;
diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index f36d3618b67c..52ce125a74e1 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -6,7 +6,11 @@
 //
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/limits.h>
+#include <linux/overflow.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
@@ -18,34 +22,63 @@ static inline unsigned int regcache_flat_get_index(const struct regmap *map,
 	return regcache_get_index_by_order(map, reg);
 }
 
+struct regcache_flat_data {
+	unsigned long *valid;
+	unsigned int data[];
+};
+
 static int regcache_flat_init(struct regmap *map)
 {
 	int i;
-	unsigned int *cache;
+	unsigned int cache_size;
+	struct regcache_flat_data *cache = NULL;
+	unsigned long *cache_valid = NULL;
 
 	if (!map || map->reg_stride_order < 0 || !map->max_register_is_set)
 		return -EINVAL;
 
-	map->cache = kcalloc(regcache_flat_get_index(map, map->max_register)
-			     + 1, sizeof(unsigned int), map->alloc_flags);
-	if (!map->cache)
+	cache_size = regcache_flat_get_index(map, map->max_register) + 1;
+
+	size_t cache_data_size = struct_size(cache, data, cache_size);
+	if (cache_data_size == SIZE_MAX) {
+		dev_err(map->dev, "cannot allocate regmap cache");
 		return -ENOMEM;
+	}
 
-	cache = map->cache;
+	cache = kmalloc(cache_data_size, map->alloc_flags);
+	if (!cache)
+		return -ENOMEM;
+
+	cache_valid = bitmap_zalloc(cache_size, map->alloc_flags);
+	if (!cache_valid)
+		goto err_free;
+
+	cache->valid = cache_valid;
+	map->cache = cache;
 
 	for (i = 0; i < map->num_reg_defaults; i++) {
 		unsigned int reg = map->reg_defaults[i].reg;
 		unsigned int index = regcache_flat_get_index(map, reg);
 
-		cache[index] = map->reg_defaults[i].def;
+		cache->data[index] = map->reg_defaults[i].def;
+		__set_bit(index, cache->valid);
 	}
 
 	return 0;
+
+err_free:
+	kfree(cache);
+	return -ENOMEM;
 }
 
 static int regcache_flat_exit(struct regmap *map)
 {
-	kfree(map->cache);
+	struct regcache_flat_data *cache = map->cache;
+
+	if (cache)
+		bitmap_free(cache->valid);
+
+	kfree(cache);
 	map->cache = NULL;
 
 	return 0;
@@ -54,10 +87,10 @@ static int regcache_flat_exit(struct regmap *map)
 static int regcache_flat_read(struct regmap *map,
 			      unsigned int reg, unsigned int *value)
 {
-	unsigned int *cache = map->cache;
+	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	*value = cache[index];
+	*value = cache->data[index];
 
 	return 0;
 }
@@ -65,10 +98,48 @@ static int regcache_flat_read(struct regmap *map,
 static int regcache_flat_write(struct regmap *map, unsigned int reg,
 			       unsigned int value)
 {
-	unsigned int *cache = map->cache;
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int index = regcache_flat_get_index(map, reg);
+
+	cache->data[index] = value;
+
+	return 0;
+}
+
+static int regcache_flat_sparse_read(struct regmap *map,
+			             unsigned int reg, unsigned int *value)
+{
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int index = regcache_flat_get_index(map, reg);
+
+	if (unlikely(!test_bit(index, cache->valid)))
+		return -ENOENT;
+
+	*value = cache->data[index];
+
+	return 0;
+}
+
+static int regcache_flat_sparse_write(struct regmap *map, unsigned int reg,
+			       unsigned int value)
+{
+	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	cache[index] = value;
+	cache->data[index] = value;
+	__set_bit(index, cache->valid);
+
+	return 0;
+}
+
+static int regcache_flat_drop(struct regmap *map, unsigned int min,
+			      unsigned int max)
+{
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int bitmap_min = regcache_flat_get_index(map, min);
+	unsigned int bitmap_max = regcache_flat_get_index(map, max);
+
+	bitmap_clear(cache->valid, bitmap_min, bitmap_max + 1 - bitmap_min);
 
 	return 0;
 }
@@ -81,3 +152,13 @@ struct regcache_ops regcache_flat_ops = {
 	.read = regcache_flat_read,
 	.write = regcache_flat_write,
 };
+
+struct regcache_ops regcache_flat_sparse_ops = {
+	.type = REGCACHE_FLAT_S,
+	.name = "flat-sparse",
+	.init = regcache_flat_init,
+	.exit = regcache_flat_exit,
+	.read = regcache_flat_sparse_read,
+	.write = regcache_flat_sparse_write,
+	.drop = regcache_flat_drop,
+};
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index c7650fa434ad..0392f5525cf3 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -16,6 +16,7 @@
 #include "internal.h"
 
 static const struct regcache_ops *cache_types[] = {
+	&regcache_flat_sparse_ops,
 	&regcache_rbtree_ops,
 	&regcache_maple_ops,
 	&regcache_flat_ops,
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 95c5bf2a78ee..70ecb3e46472 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -54,6 +54,8 @@ static const char *regcache_type_name(enum regcache_type type)
 		return "none";
 	case REGCACHE_FLAT:
 		return "flat";
+	case REGCACHE_FLAT_S:
+		return "flat-sparse";
 	case REGCACHE_RBTREE:
 		return "rbtree";
 	case REGCACHE_MAPLE:
@@ -119,6 +121,12 @@ static const struct regmap_test_param real_cache_types_list[] = {
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2002 },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2003 },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2004 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0, .fast_io = true },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2001 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2002 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2003 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2004 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2001 },
@@ -136,6 +144,12 @@ static const struct regmap_test_param real_cache_types_list[] = {
 KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, param_to_desc);
 
 static const struct regmap_test_param sparse_cache_types_list[] = {
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0, .fast_io = true },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2001 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2002 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2003 },
+	{ .cache = REGCACHE_FLAT_S, .from_reg = 0x2004 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2001 },
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4e1ac1fbcec4..a5987f1a1a76 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -67,6 +67,7 @@ enum regcache_type {
 	REGCACHE_RBTREE,
 	REGCACHE_FLAT,
 	REGCACHE_MAPLE,
+	REGCACHE_FLAT_S,
 };
 
 /**
-- 
2.51.0


