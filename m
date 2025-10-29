Return-Path: <linux-kernel+bounces-875435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B2C19031
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99A13B0D20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31AE324B33;
	Wed, 29 Oct 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="D71oeyFk"
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A831280B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725584; cv=none; b=lnGVz7AAlmtYk4BdfjBQo6Dpp+VoK70LyB7f9iWbP7f+/tOEZjad1DL2XoIzHXi3tmnAi6aawIRtq9gcf/TNIeSC6evnPcijxOAiUP/95Un1EBC1LKyJ3YtAaQBo3ZgpmI6rKMz8S1aFoMMJmboFb6kPcxl2L0bwwJeN5KxR3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725584; c=relaxed/simple;
	bh=uW1f+VyML3jkjaRTgFCWvm9Cy/jWTOSqwBw8hEONYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB9o6xI5be4SdMm80pEYKMCheDjZPVHoPOjMdguB0yQ+vqDeFxZ50xlOXFu5aA0XpILD3urJN7k5D1epl2ITtpjB54O7dz8LFM7cF1JlK4kFO2ZEUI6aPOYNlqI95N1SoSoTvlpOdqEhzByDPVFi/3y/5+vcBd0iwL4VQ+Wba1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=D71oeyFk; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Received: from terra.vega.svanheule.net (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 47941690568;
	Wed, 29 Oct 2025 09:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1761725575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqSjmY/zxBiXWdPxezzMnXfs6xXJS1rNM+yXl18h57M=;
	b=D71oeyFkEjKn0jtgA0GSx/yMud60IPodSD+hCn8rWAAUuhqJ1VSogtCc53aXZvqFaOBbOB
	pq6E0xB0hoG+6nwiPvHjTus2TuZDEK0a/2M7EzpXRFgaTSkqALuI+7ecdjDzwF29lhKBye
	CXfO/CMPaRVy8sRx/IJ7hOxoKbapacgg5AG5H9OOgKeG12RSpg2vBuIgHV+zOzRmWM/dbD
	IrYa1LxnehylpGzt5drYlX11pUE+hf8JZQBvbEyrPwJ3ZujS+cqRFcVQFBdTAcMPXKilh8
	6/7/ILQm7Ucn1H5zTUH10Tnfsg5eCK3F6g6L/PhQ7wU85xfa4POEAa2AioiJMg==
From: Sander Vanheule <sander@svanheule.net>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 1/2] regmap: add flat cache with sparse validity
Date: Wed, 29 Oct 2025 09:12:47 +0100
Message-ID: <20251029081248.52607-2-sander@svanheule.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029081248.52607-1-sander@svanheule.net>
References: <20251029081248.52607-1-sander@svanheule.net>
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
Changes since v5:
- Use kzalloc() to zero-initialize cache
- Drop short-lived cache_valid variable
- Drop unused initial value for cache pointer in init
- Update regcache_type comment to document the difference between the
  flat caches

Changes since v4:
- Add REGCACHE_FLAT_S to remaining KUnit test config tables
- Shuffle code to make the patches cleaner

Changes since v3:
- Define new flat-sparse ops instead of modifying existing ones
- Update KUnit tests
- Allocate cache as flexible array to limit performance impact
---
 drivers/base/regmap/internal.h      |   1 +
 drivers/base/regmap/regcache-flat.c | 102 +++++++++++++++++++++++++---
 drivers/base/regmap/regcache.c      |   1 +
 drivers/base/regmap/regmap-kunit.c  |  22 ++++++
 include/linux/regmap.h              |  17 +++--
 5 files changed, 126 insertions(+), 17 deletions(-)

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
index f36d3618b67c..86f7679175b1 100644
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
 
@@ -18,34 +22,62 @@ static inline unsigned int regcache_flat_get_index(const struct regmap *map,
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
+	size_t cache_data_size;
+	unsigned int cache_size;
+	struct regcache_flat_data *cache;
 
 	if (!map || map->reg_stride_order < 0 || !map->max_register_is_set)
 		return -EINVAL;
 
-	map->cache = kcalloc(regcache_flat_get_index(map, map->max_register)
-			     + 1, sizeof(unsigned int), map->alloc_flags);
-	if (!map->cache)
+	cache_size = regcache_flat_get_index(map, map->max_register) + 1;
+	cache_data_size = struct_size(cache, data, cache_size);
+
+	if (cache_data_size == SIZE_MAX) {
+		dev_err(map->dev, "cannot allocate regmap cache");
 		return -ENOMEM;
+	}
 
-	cache = map->cache;
+	cache = kzalloc(cache_data_size, map->alloc_flags);
+	if (!cache)
+		return -ENOMEM;
+
+	cache->valid = bitmap_zalloc(cache_size, map->alloc_flags);
+	if (!cache->valid)
+		goto err_free;
+
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
@@ -54,10 +86,24 @@ static int regcache_flat_exit(struct regmap *map)
 static int regcache_flat_read(struct regmap *map,
 			      unsigned int reg, unsigned int *value)
 {
-	unsigned int *cache = map->cache;
+	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	*value = cache[index];
+	*value = cache->data[index];
+
+	return 0;
+}
+
+static int regcache_flat_sparse_read(struct regmap *map,
+				     unsigned int reg, unsigned int *value)
+{
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int index = regcache_flat_get_index(map, reg);
+
+	if (unlikely(!test_bit(index, cache->valid)))
+		return -ENOENT;
+
+	*value = cache->data[index];
 
 	return 0;
 }
@@ -65,10 +111,34 @@ static int regcache_flat_read(struct regmap *map,
 static int regcache_flat_write(struct regmap *map, unsigned int reg,
 			       unsigned int value)
 {
-	unsigned int *cache = map->cache;
+	struct regcache_flat_data *cache = map->cache;
 	unsigned int index = regcache_flat_get_index(map, reg);
 
-	cache[index] = value;
+	cache->data[index] = value;
+
+	return 0;
+}
+
+static int regcache_flat_sparse_write(struct regmap *map, unsigned int reg,
+				      unsigned int value)
+{
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int index = regcache_flat_get_index(map, reg);
+
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
@@ -81,3 +151,13 @@ struct regcache_ops regcache_flat_ops = {
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
index 95c5bf2a78ee..f6fc5ed016da 100644
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
@@ -93,6 +95,8 @@ static const struct regmap_test_param regcache_types_list[] = {
 	{ .cache = REGCACHE_NONE, .fast_io = true },
 	{ .cache = REGCACHE_FLAT },
 	{ .cache = REGCACHE_FLAT, .fast_io = true },
+	{ .cache = REGCACHE_FLAT_S },
+	{ .cache = REGCACHE_FLAT_S, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE },
 	{ .cache = REGCACHE_RBTREE, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE },
@@ -104,6 +108,8 @@ KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, param_to_desc);
 static const struct regmap_test_param real_cache_types_only_list[] = {
 	{ .cache = REGCACHE_FLAT },
 	{ .cache = REGCACHE_FLAT, .fast_io = true },
+	{ .cache = REGCACHE_FLAT_S },
+	{ .cache = REGCACHE_FLAT_S, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE },
 	{ .cache = REGCACHE_RBTREE, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE },
@@ -119,6 +125,12 @@ static const struct regmap_test_param real_cache_types_list[] = {
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
@@ -136,6 +148,12 @@ static const struct regmap_test_param real_cache_types_list[] = {
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
@@ -1597,6 +1615,8 @@ static const struct regmap_test_param raw_types_list[] = {
 	{ .cache = REGCACHE_NONE,   .val_endian = REGMAP_ENDIAN_BIG },
 	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_LITTLE },
 	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_FLAT_S, .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_FLAT_S, .val_endian = REGMAP_ENDIAN_BIG },
 	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_LITTLE },
 	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_BIG },
 	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_LITTLE },
@@ -1608,6 +1628,8 @@ KUNIT_ARRAY_PARAM(raw_test_types, raw_types_list, param_to_desc);
 static const struct regmap_test_param raw_cache_types_list[] = {
 	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_LITTLE },
 	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_FLAT_S, .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_FLAT_S, .val_endian = REGMAP_ENDIAN_BIG },
 	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_LITTLE },
 	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_BIG },
 	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_LITTLE },
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4e1ac1fbcec4..17bed25dc4e3 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -55,18 +55,23 @@ struct sdw_slave;
 #define REGMAP_DOWNSHIFT(s)	(s)
 
 /*
- * The supported cache types, the default is no cache.  Any new caches
- * should usually use the maple tree cache unless they specifically
- * require that there are never any allocations at runtime and can't
- * provide defaults in which case they should use the flat cache.  The
- * rbtree cache *may* have some performance advantage for very low end
- * systems that make heavy use of cache syncs but is mainly legacy.
+ * The supported cache types, the default is no cache.  Any new caches should
+ * usually use the maple tree cache unless they specifically require that there
+ * are never any allocations at runtime in which case they should use the sparse
+ * flat cache.  The rbtree cache *may* have some performance advantage for very
+ * low end systems that make heavy use of cache syncs but is mainly legacy.
+ * These caches are sparse and entries will be initialized from hardware if no
+ * default has been provided.
+ * The non-sparse flat cache is provided for compatibility with existing users
+ * and will zero-initialize cache entries for which no defaults are provided.
+ * New users should use the sparse flat cache.
  */
 enum regcache_type {
 	REGCACHE_NONE,
 	REGCACHE_RBTREE,
 	REGCACHE_FLAT,
 	REGCACHE_MAPLE,
+	REGCACHE_FLAT_S,
 };
 
 /**
-- 
2.51.0


