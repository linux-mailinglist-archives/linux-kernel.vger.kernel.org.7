Return-Path: <linux-kernel+bounces-878812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C6C21861
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3061A61639
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EC366FD0;
	Thu, 30 Oct 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l80ABL/c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334636A608
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845961; cv=none; b=CZojzZH5ZyXQDIcRsHEYEChNW07lL3J2QsLSkzcysfWVgfWcuZU/dIAUsl7QC40iR9aObsDcyxs+n2KmhCuTOOevwLNEWsOdRCqvHzoSzqeb0L4HzMo76MxVns2/dqVWM6CtRTNrZ6XeZr5YX2ayjg9wy5Wqlc8Gm/yzCJBHgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845961; c=relaxed/simple;
	bh=p0TML9FLbpbHRHWAs71KOwBosv3+hC/P9zEcIKgeCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmehs5lb2O+m3gkIPBb0ltPSVLZzFvO2Nthbngl+KHVcILLn7FyJVA7rAOGeGwaB3NaHZIbppwaVDxQtiP3Hz8rwOdiZ9l9h01NDgfDinY4dzgPUwI6SxmiLnR/EMSbvr4j85lB5U70qCXdCULSeRe6fOLWx2E8ouqJyiGACi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l80ABL/c; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845958; x=1793381958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0TML9FLbpbHRHWAs71KOwBosv3+hC/P9zEcIKgeCk0=;
  b=l80ABL/cUkkF3oX+6U3afIIgWgKH0hfpxdgMRfW9WzqV6d+XN9eGmpIA
   cIryxKc/SniOYhpvUaSRcqBbzrO8J+bIAcItYPZ5jjynjmP+mejjk7G/8
   TfexSOBqM+lbEYQpn0Y4/fWZ9wgsBAee6BqvRHRpZYmYLtgMSJA1T2QtO
   Vs7cHnkVitnMLv09HtsdNtUXTelUxPFxcV4+TxpO6KhYfp/s8PC+RiGa6
   gT7/RqM3m3WwPPbNlWXVkp0l39JhasKJG7gRqM/CW8uOV+O8ELjo9UH0U
   dDzbHp91k3ToSqm1+OFxwp22zCpdVIccNH8u34T1KJBoxMYPkQD2SJZ8z
   Q==;
X-CSE-ConnectionGUID: xkBERv8ES4qVi9vx+5Qjxg==
X-CSE-MsgGUID: LeKo0O7KTeCbZa0efNCFkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74596797"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="74596797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:17 -0700
X-CSE-ConnectionGUID: w+0zih30TxCk7ED1Y9bf1g==
X-CSE-MsgGUID: jvyRwa7LTUWMvYl+ugwuCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185895474"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 30 Oct 2025 10:39:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 70F1899; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 4/5] regcache: flat: Split ->populate() from ->init()
Date: Thu, 30 Oct 2025 18:37:04 +0100
Message-ID: <20251030173915.3886882-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split ->populate() implementation from ->init() code.
This decoupling will help for the further changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-flat.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index bacb7137092f..53cc59c84e2f 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -29,7 +29,6 @@ struct regcache_flat_data {
 
 static int regcache_flat_init(struct regmap *map)
 {
-	int i;
 	unsigned int cache_size;
 	struct regcache_flat_data *cache;
 
@@ -47,14 +46,6 @@ static int regcache_flat_init(struct regmap *map)
 
 	map->cache = cache;
 
-	for (i = 0; i < map->num_reg_defaults; i++) {
-		unsigned int reg = map->reg_defaults[i].reg;
-		unsigned int index = regcache_flat_get_index(map, reg);
-
-		cache->data[index] = map->reg_defaults[i].def;
-		__set_bit(index, cache->valid);
-	}
-
 	return 0;
 
 err_free:
@@ -75,6 +66,22 @@ static int regcache_flat_exit(struct regmap *map)
 	return 0;
 }
 
+static int regcache_flat_populate(struct regmap *map)
+{
+	struct regcache_flat_data *cache = map->cache;
+	unsigned int i;
+
+	for (i = 0; i < map->num_reg_defaults; i++) {
+		unsigned int reg = map->reg_defaults[i].reg;
+		unsigned int index = regcache_flat_get_index(map, reg);
+
+		cache->data[index] = map->reg_defaults[i].def;
+		__set_bit(index, cache->valid);
+	}
+
+	return 0;
+}
+
 static int regcache_flat_read(struct regmap *map,
 			      unsigned int reg, unsigned int *value)
 {
@@ -134,6 +141,7 @@ struct regcache_ops regcache_flat_ops = {
 	.name = "flat",
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
+	.populate = regcache_flat_populate,
 	.read = regcache_flat_read,
 	.write = regcache_flat_write,
 };
@@ -143,6 +151,7 @@ struct regcache_ops regcache_flat_sparse_ops = {
 	.name = "flat-sparse",
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
+	.populate = regcache_flat_populate,
 	.read = regcache_flat_sparse_read,
 	.write = regcache_flat_write,
 	.drop = regcache_flat_drop,
-- 
2.50.1


