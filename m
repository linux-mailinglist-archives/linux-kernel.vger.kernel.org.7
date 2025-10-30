Return-Path: <linux-kernel+bounces-878815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE9C2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B781A644B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76FD36CA92;
	Thu, 30 Oct 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGVgiuVd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780536B988
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845963; cv=none; b=LKQS5NYC+RYoDl10b+RZgw+u8ds69f9qu46aY3r6h5GbNZUHFcbl1JgjaIWopjrDRF9CFDvpihgP7uXjQ1Fv8PFz423uPDuacky5vJ+ieoh965ZZbjYcTtEJm3u3zqRn4oLDyKMnXSFak/Ix9z3jUtm8l22OgweJXjUA9ASrmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845963; c=relaxed/simple;
	bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDaNmxfdMj1GCINUnlyBCHioyaPol6G0FIYBaORsIKlzxRLEGyUGi8vqwUlCzshQcvcX6Hccgw5aiAHYl6+BnW90uB4N7zu82LK3ImlAm5zA56fz+LycohiroGQ9f9HasKIazjyNR+9ktgKpYcplhbge8k8uXmEYjLLUY05shu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGVgiuVd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845962; x=1793381962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
  b=kGVgiuVd5jc+5pSP5fguX5f+ZMYDw7u74RCaOzHh/sz9y86VLdEckRt4
   c8mlf02MguR/4VYLU/qbd9sJFW9Lc1c6OUS/HBBbo90bUe3+QFklocRGS
   pOJEPxQE9x4Q8FdRd2WzaA05My4RNg6nQHcHmQWjLzlaWZPCGdfuzRmya
   YWlP5p7JBpmcsc4fNEXhigEy604hiwN5gXd6t+fUjuGE73Shm/Wj2NNZl
   SaHbyEY1tsTmYKntMYKZtYTRhtW29hHEw7+Yg1RlWTZrfJPdPWjMK02M+
   NmZ7Vh4TKm8vTBODdGgzAqxVrjPS8hg0gXVMWBuMrowaDfWK5myUfd4pB
   g==;
X-CSE-ConnectionGUID: Yp6EJE/DTbCEeadTclDDlQ==
X-CSE-MsgGUID: bxBbN28rRaaVNMrp+Xdmzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75117033"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75117033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:22 -0700
X-CSE-ConnectionGUID: hFB7NtryQcuZHVwlIDoaDw==
X-CSE-MsgGUID: OKm4WIp4Q/WAmCH+7hOhLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185951817"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 30 Oct 2025 10:39:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7548C9A; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 5/5] regcache: maple: Split ->populate() from ->init()
Date: Thu, 30 Oct 2025 18:37:05 +0100
Message-ID: <20251030173915.3886882-6-andriy.shevchenko@linux.intel.com>
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


