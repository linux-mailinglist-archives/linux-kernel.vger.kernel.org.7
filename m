Return-Path: <linux-kernel+bounces-879669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945BC23B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C30D1886C68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037033FE24;
	Fri, 31 Oct 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVFe66uN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D2285C8C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897946; cv=none; b=LYQmKuu9QozRIjdowqiOeAuBcmy+HUxWwz68YsUlvMmcuGuxMQhcsvcOqDM7K4mCK/Q8KluDgH7DiDfiz42CRRE6SIQ2O9L59fEwPrr3Xk9RVj9dn7zmxAvMBvW3R8skBOaUJZThgHo9Tg2jKxeV7Qhtk4p4BVQvq3dCN2KdKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897946; c=relaxed/simple;
	bh=Kbe9y64hXWiuWxkOATu9oioQHRlr3eUQs/jSR4V/4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZoyIUJwPhAs8UlItdtEe9thdvONmhd2mT4jSH7LZEZsgrs4OA4SGgJhL9p/GR01Y8+0ifhhbvx6Pf9En9vk2TyqbAg1osRulBn1b2DrS185MHH6U46Pm9hWtVkSuWIIiCzCFNew5SKsnEw0ID+nqKHZrR6x4WV5MS5Z3sQ5L+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVFe66uN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897945; x=1793433945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kbe9y64hXWiuWxkOATu9oioQHRlr3eUQs/jSR4V/4vI=;
  b=hVFe66uNVSe4ioe6BnUOTUIG9xys9SFd06YwOX2vVM3EYrbIg5i6I1T6
   tQFz0FSnbqT5aarYfc01IUEX+LVOH7kr5J8/r7dB57ofvBwvTh05B2byQ
   z7XLeXVyToUR6ASbRbfLgc06Zbz8PSuKtm1iFo0/W7++61iIYLZih1bwP
   5zvK1LMoTF2p5TLCsZd/EiRP1d6+Zzq1qHOrY2zmreOsipo85UH6d6n2a
   7pH1T39R4FvgV02zumbDbz7QpWm8C/VbDMhgyOzIjNGaIBBd103N69J7p
   HuFBgh81gx0wJNLklYS5gq6vnNu63V6UcRvQRkdkRNb0zasyHJTNWBfMu
   A==;
X-CSE-ConnectionGUID: FLi74X7SRG+J2cMlfTuH2Q==
X-CSE-MsgGUID: xY/gQuxrRRWWYQiPzUE1wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75503182"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75503182"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:44 -0700
X-CSE-ConnectionGUID: HMy6gP6mThOoTurDAk3reA==
X-CSE-MsgGUID: ZAHVhraOQ1mTEqIhPkGP/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="217010409"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2025 01:05:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9B2E597; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 2/5] regcache: rbtree: Split ->populate() from ->init()
Date: Fri, 31 Oct 2025 09:03:17 +0100
Message-ID: <20251031080540.3970776-3-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regcache-rbtree.c | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index a9d17f316e55..3344b82c3799 100644
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
+	.populate = regcache_rbtree_populate,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = rbtree_debugfs_init,
 #endif
-- 
2.50.1


