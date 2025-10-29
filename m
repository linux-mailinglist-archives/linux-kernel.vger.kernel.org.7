Return-Path: <linux-kernel+bounces-875335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A63C18B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8613A9940
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031730E856;
	Wed, 29 Oct 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFd4aqr5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDF272816
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723099; cv=none; b=EeoH+AeftUUGNICpDBH6h5AV2N+LBNZPVaBBi2PsKVsBAWYglMszqN23RG9F2eU+0EoaDphNUh7IXtjraHDxbxXawdrIMg44Ga7lboYJZAgtQywz92EiZysXXB+tJ7XLsC/laO2QoKe2cgIZqYjivadPSQkzuXelToLXj6lZwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723099; c=relaxed/simple;
	bh=64hz6eN9wMTQb/u5lIj1gRNc79dS5LgF6HqMkkNo/mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtU3BDIUS2kgEBDQkyvgo61DMttDA4HaSKBKSczd0tXdYjs1HOFVBDnyPyJl69NPlt34waL8a+oUdRih67N1ZxYlUWaHwzNnmwGDsx16hlo4aEIYaQdKfziV/pNMeCO4pY44WlgvAamo6qlq539xDNPPTLDjT/euwUyBfjNitlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFd4aqr5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723098; x=1793259098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64hz6eN9wMTQb/u5lIj1gRNc79dS5LgF6HqMkkNo/mw=;
  b=RFd4aqr5vcuD1TGDfhDnqQgSF46WApltN7jW5KTPRhrhT+7Drx998e8H
   sRUTRo2lsO8z15zugoQ2YzsHuuOOlFcfN4PC2Ikky/Ms6WYw+C1dRBUv5
   7g/QJ4PVOB0zaIh92YOiwMyLdayRIzLpFcgT9UR2vHQcNqlhyPo5SYQd1
   8Qk+2vqJejg/aZnpK2L9JTpmJKUv11uMCNH6biFlJjBDAx+s6NSQ0RxTF
   LGdm9MUHdFbnVZmAJPHGEI685V/mK5pI4n6zTa8bTirVLe0lxXAHEQKbX
   3fhJiSEa8IXMjMJH0vASrULCPTNtnnlry3T+txxiD7Ov5l7cVMhnCg6dK
   Q==;
X-CSE-ConnectionGUID: qZBWrBdYQeqI5qZiLIRLkw==
X-CSE-MsgGUID: P/Dl1VXHTsSbNoFoYcOzIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63720714"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63720714"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:31:37 -0700
X-CSE-ConnectionGUID: UAk3yzuRSYiNnKQuZWX6KA==
X-CSE-MsgGUID: k+o9ycgLQ6aECAux3D0Rwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185213942"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 29 Oct 2025 00:31:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6164B97; Wed, 29 Oct 2025 08:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 2/4] regcache: rbtree: Split ->populate() from ->init()
Date: Wed, 29 Oct 2025 08:28:59 +0100
Message-ID: <20251029073131.3004660-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
References: <20251029073131.3004660-1-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regcache-rbtree.c | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index a9d17f316e55..2751714d52ea 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -184,8 +184,6 @@ static void rbtree_debugfs_init(struct regmap *map)
 static int regcache_rbtree_init(struct regmap *map)
 {
 	struct regcache_rbtree_ctx *rbtree_ctx;
-	int i;
-	int ret;
 
 	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);
 	if (!map->cache)
@@ -195,19 +193,7 @@ static int regcache_rbtree_init(struct regmap *map)
 	rbtree_ctx->root = RB_ROOT;
 	rbtree_ctx->cached_rbnode = NULL;
 
-	for (i = 0; i < map->num_reg_defaults; i++) {
-		ret = regcache_rbtree_write(map,
-					    map->reg_defaults[i].reg,
-					    map->reg_defaults[i].def);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
-
-err:
-	regcache_rbtree_exit(map);
-	return ret;
 }
 
 static int regcache_rbtree_exit(struct regmap *map)
@@ -239,6 +225,22 @@ static int regcache_rbtree_exit(struct regmap *map)
 	return 0;
 }
 
+static int regcache_rbtree_populate(struct regmap *map)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < map->num_reg_defaults; i++) {
+		ret = regcache_rbtree_write(map,
+					    map->reg_defaults[i].reg,
+					    map->reg_defaults[i].def);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int regcache_rbtree_read(struct regmap *map,
 				unsigned int reg, unsigned int *value)
 {
@@ -546,6 +548,7 @@ struct regcache_ops regcache_rbtree_ops = {
 	.name = "rbtree",
 	.init = regcache_rbtree_init,
 	.exit = regcache_rbtree_exit,
+	.populate= regcache_rbtree_populate,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = rbtree_debugfs_init,
 #endif
-- 
2.50.1


