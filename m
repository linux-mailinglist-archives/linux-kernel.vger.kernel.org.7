Return-Path: <linux-kernel+bounces-879668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 625EBC23BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D29684F7192
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62B33FE18;
	Fri, 31 Oct 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT21J+Cd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7F17E4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897946; cv=none; b=WiIjkKWc/h00nj4JV23BUTI1mtdvsGpwizNiRexsT+2SyoTi4NMmOO8q9lNjeXvMnMZ2BLSppxSkG7GTgjfE5Yo/it8fWqmfCGDZN27ZiuIOrrvmbUr102aT/aocNIcYX2tZ+aVvAIbUB/UrbwcJpfrenPnv1BgwKguXBjiXxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897946; c=relaxed/simple;
	bh=p0TML9FLbpbHRHWAs71KOwBosv3+hC/P9zEcIKgeCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpznductDq+AiTtfbrn96w+SI4D/l1zfn8fNCC8fqEUDzw8lP+mcifF7G8vFY9pb7ZVvWHCuhc7CrW5fe0Q4p2vgkHp4TKU5J0VsZJhGSUl7LkvrSbRECsntFL95FucP2u9eKpyYzWKvK8Q90xpVhWnb17lfRtUr4EDlUr84M1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT21J+Cd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897945; x=1793433945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p0TML9FLbpbHRHWAs71KOwBosv3+hC/P9zEcIKgeCk0=;
  b=lT21J+Cd1OVIHt14MGVkVBzHhqFj6QMQrLamPQCE8yDN9bhl/K2RwtQW
   brTOpfIN9ITOIgoBBTOKFaCAWk8jFmDxxWuqGtLsVGwaJOGDc7f/6Nv0D
   stgyVR73MobQEz6N8JEMVCusl58K9jlDsiynP9sLqv0es4UFfn1p1NAXP
   QgN/0bqH54e0z0w35riAAdLGnIuhNt+GQnE8Kl5NHByrS4dC108qJjN0q
   EL2yunUtn4Lh/mq78SEMVM7N49CA3hvHbp0Ze0IZVj2fGB/ba82ZDST2a
   EbIWcXc1oicmEuPTi67mSI6Ozd0zBBTUG+bT9D0D37YWSwM4o/AFO9VyB
   Q==;
X-CSE-ConnectionGUID: yBS0RKw4Td2Kv3AG/7qDSQ==
X-CSE-MsgGUID: N3QciobqTlaWKFe3qQqDkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63939057"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="63939057"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:44 -0700
X-CSE-ConnectionGUID: A0RqXhG1QeagOqmIaKZgmg==
X-CSE-MsgGUID: Ny/A/36HTDO2/2uSCjgizw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="190254451"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 31 Oct 2025 01:05:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A400599; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 4/5] regcache: flat: Split ->populate() from ->init()
Date: Fri, 31 Oct 2025 09:03:19 +0100
Message-ID: <20251031080540.3970776-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
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


