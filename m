Return-Path: <linux-kernel+bounces-879672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD4C23BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB178460B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED832ED26;
	Fri, 31 Oct 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhwqZzL4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535132ED24
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897948; cv=none; b=pCKQkK5+dFLLYdtCJlWnvL4Kcipq6iTX1Bi6dKmje3xcTIUZtZ3iwz50FNUsqr8Zo9MdoAsSFiAVaeJaq1DQBSVAL4gIjFNKFv0v2LKnSMtvNPdjx+ZjJdUCU3tmtGBVIxcU98rG2rzc6d0ebkZmBsFuzmmD30s4k78Tm0Aa4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897948; c=relaxed/simple;
	bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwDZOqur1tLJfqfUM0AP44UN97Z9tkSUBJMj8BSMJPpbtlAPdXXFszsPdUbkOHllR9b5n5bt+/PdRHJt6ywBUjrV2mGsQyxAU6icWCrL8qTtd+2YgHmj1HqRIuvkvusvAhvggXVHf1jAV8OVOJJ1VgVz+/SVPtDuzY+ZWC7CtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhwqZzL4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897947; x=1793433947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
  b=EhwqZzL4rPw6uA9RaVWYPz8w//7kHB4mpJMiyPM469oTDH+efXf/gXQs
   uC61qZW8rrdjqpPmI0HCHVJRnkxArycWh5YOVsqtYdq8XvMHNQS717lm1
   GT7d3d+vPenYwBLLcWw+SHn+bqw+SLsjzNlmFqXskKMnd0V2WeTBVf63j
   Q2CfLv+Nrh1afUWYm5Jsdyxfrg321VU1etuLhXdj9ZZVk+Fc1JWOuyR7G
   lzE3ANCbgAK3t3e0ONkCvQNDcu7hcDb9fy25CgtTNwKxfmrP8Hx0y/WDe
   S+TlGDinpR3zQwQYcoPmTEo/fVwaLOXz/do6QU19AvfmYE8ZPR1wUOKyL
   g==;
X-CSE-ConnectionGUID: 3s1tbHxLRQOjqDhf/Rzeng==
X-CSE-MsgGUID: mUOInZvKQfWDXf1yV/YPxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75503186"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75503186"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:47 -0700
X-CSE-ConnectionGUID: 9HtADjhIR/q20v4VSLKXUw==
X-CSE-MsgGUID: ZFhhlHvuSUC6p+w0M31Byg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="216828328"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 01:05:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A82D19A; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 5/5] regcache: maple: Split ->populate() from ->init()
Date: Fri, 31 Oct 2025 09:03:20 +0100
Message-ID: <20251031080540.3970776-6-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regcache-maple.c | 47 +++++++++++++---------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2319c30283a6..ca1c72b68f31 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -289,6 +289,23 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	return ret;
 }
 
+static int regcache_maple_init(struct regmap *map)
+{
+	struct maple_tree *mt;
+
+	mt = kmalloc(sizeof(*mt), map->alloc_flags);
+	if (!mt)
+		return -ENOMEM;
+	map->cache = mt;
+
+	mt_init(mt);
+
+	if (!mt_external_lock(mt) && map->lock_key)
+		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
+
+	return 0;
+}
+
 static int regcache_maple_exit(struct regmap *map)
 {
 	struct maple_tree *mt = map->cache;
@@ -340,26 +357,12 @@ static int regcache_maple_insert_block(struct regmap *map, int first,
 	return ret;
 }
 
-static int regcache_maple_init(struct regmap *map)
+static int regcache_maple_populate(struct regmap *map)
 {
-	struct maple_tree *mt;
 	int i;
 	int ret;
 	int range_start;
 
-	mt = kmalloc(sizeof(*mt), map->alloc_flags);
-	if (!mt)
-		return -ENOMEM;
-	map->cache = mt;
-
-	mt_init(mt);
-
-	if (!mt_external_lock(mt) && map->lock_key)
-		lockdep_set_class_and_subclass(&mt->ma_lock, map->lock_key, 1);
-
-	if (!map->num_reg_defaults)
-		return 0;
-
 	range_start = 0;
 
 	/* Scan for ranges of contiguous registers */
@@ -369,23 +372,14 @@ static int regcache_maple_init(struct regmap *map)
 			ret = regcache_maple_insert_block(map, range_start,
 							  i - 1);
 			if (ret != 0)
-				goto err;
+				return ret;
 
 			range_start = i;
 		}
 	}
 
 	/* Add the last block */
-	ret = regcache_maple_insert_block(map, range_start,
-					  map->num_reg_defaults - 1);
-	if (ret != 0)
-		goto err;
-
-	return 0;
-
-err:
-	regcache_maple_exit(map);
-	return ret;
+	return regcache_maple_insert_block(map, range_start, map->num_reg_defaults - 1);
 }
 
 struct regcache_ops regcache_maple_ops = {
@@ -393,6 +387,7 @@ struct regcache_ops regcache_maple_ops = {
 	.name = "maple",
 	.init = regcache_maple_init,
 	.exit = regcache_maple_exit,
+	.populate = regcache_maple_populate,
 	.read = regcache_maple_read,
 	.write = regcache_maple_write,
 	.drop = regcache_maple_drop,
-- 
2.50.1


