Return-Path: <linux-kernel+bounces-878811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F040AC21867
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B43B3878
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6F36B987;
	Thu, 30 Oct 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqoysPAC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532BF368F2A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845961; cv=none; b=CqWEUY2eqxttdgTa3R+0GxXPVnHNhy/Zmz+ai8iX3xJ/yLiqZYiYztSF+Dyp9SqD6UPZg4Qz0qdX5TonWVfR7mCSAtQyBJ37CyNs8/qFxBQRUMJduRpvKCL8Ke2eWT8+4QV0r1yVwc90s1yEKYi7Mrnmb09O+oWLrygdekD43h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845961; c=relaxed/simple;
	bh=64hz6eN9wMTQb/u5lIj1gRNc79dS5LgF6HqMkkNo/mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brLehFI+cBA8HazTJOzDnhChcL+yxTuLGP5ttbQEGCdmX1TrP4jMZJ3fBHGAv4WgZ9wKwEsnhBAdqTLpMNNMo7mRXbEK9hWDL2j4IlHrvg/PzJS0/vSOd4j/ZUzaeffp6mjmxDhf88nCbrMotrCtff/2AN5nUYYqQbzH/wiP5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqoysPAC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845959; x=1793381959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64hz6eN9wMTQb/u5lIj1gRNc79dS5LgF6HqMkkNo/mw=;
  b=cqoysPACLw6IJQPAm+Yfa7iUM89JbbIuDPIbLCuYMGNpr7bW7kypt6gT
   o5eRREcmy0fVaq9ErE6G5tvVOiwcZDChaBGwo+Mvy+BJz3ZTxiz+eci2u
   8gXaxzG+I6qu9MR463kS/PyP89UjBGET8IOf1weja1BzTKTycBpIy1TVZ
   yvPBOhVWteen8gHF3O61RDr4p8gSzXI3c7Wm8KomaP6+dv7tj3td+Aqpu
   4iufDlySw4FvNGAYdQjuNuTygX0NFHtIsfUy6KxA4vQZ2lEqbpfDf1VDy
   MkCV6mx1+4BOoi8kWSvB6QhSHDg+lsAhJQULXv7dwxWdxf63BlBOB4v0N
   g==;
X-CSE-ConnectionGUID: R2h37poQSrSt9yqVlESu2Q==
X-CSE-MsgGUID: VTfKWjr1T2GpJxm7SFRw2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67859007"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="67859007"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:19 -0700
X-CSE-ConnectionGUID: EB90RWiOSDOWGMYainPjBA==
X-CSE-MsgGUID: T7X94qlYR1yC2H60Zprgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186458300"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 30 Oct 2025 10:39:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 688C397; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/5] regcache: rbtree: Split ->populate() from ->init()
Date: Thu, 30 Oct 2025 18:37:02 +0100
Message-ID: <20251030173915.3886882-3-andriy.shevchenko@linux.intel.com>
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


