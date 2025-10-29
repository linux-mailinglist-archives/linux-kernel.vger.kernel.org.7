Return-Path: <linux-kernel+bounces-875337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F54C18B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D08435480D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719430FC2C;
	Wed, 29 Oct 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nvgzgawv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E21C861D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723100; cv=none; b=g1DJmMfc8UVsNkBldh/QE2Gn0z7VA19fnVN8J2m/AeJG/3qjX/p4CfdBz6qJKGDLzo58fzO3QivGYSPTB8wrHQH98FPbgUHhF/BMgv2iT1YV/zt+jSC3+JmzHiz4jCmSVLwvojYPe9zjKn+ky66ZzXa629nnf9+ouEvpKZXUCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723100; c=relaxed/simple;
	bh=U0/rjQE1vdYL9FqRPQDxRZmHchX606p6o6tCuSRACdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD+nOaaI+s0SoXXt8YUENFnfrsi2k5LfS9pcq4qHCb8oq9QcKtj+t09fXF6nkopiY0vILQM6U+kT9Hq6n5M+fFYtqeGCgIom91QWSi7jhF7lj/2w2y0q+mENVPzxcGWGMp9FDP4gaWL/rUEkdeywtPcLpwsKJfVr7JkX6fKcmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nvgzgawv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723098; x=1793259098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U0/rjQE1vdYL9FqRPQDxRZmHchX606p6o6tCuSRACdQ=;
  b=NvgzgawvV+KS1ld33Y76+hFGa03MVB6ACMYPV9PAiLCVAXpJ2F+aV7da
   llJnBMec7g0piQjk6kMtHK2+YQhC7sNcdrfH6gL6dLS/oHzJHqNT8Q2Xr
   +ld7C09LSfUv2SzgTZtHvqPkpUZ3XOyg7r9BhYdUSduJpd6LEL00DUkse
   M3m+5ok7tGZqWbUAczabxtgokVg2Hg2EHlmizg2EWXkwJxaSFEB8ATBn8
   JsndgL1SQiN0l01y+ptlp1pbF1xHz0qhry+uunDrIGFmVvuhMb7ROGvOq
   hleATrQtARuTedc5tFBxir8/87iI9meonAJtZtNHTFrb37rO+SK0T9taY
   g==;
X-CSE-ConnectionGUID: ZsZ1g7mtSHCnAs2nbEBTSA==
X-CSE-MsgGUID: 1ZR3mpbtQ5yvH07M8vAfkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86463820"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="86463820"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:31:37 -0700
X-CSE-ConnectionGUID: ijO6JgpyQaaLTyjFl0WqYw==
X-CSE-MsgGUID: Z7vc40I/Q1CeEz6qBlOlUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="189890054"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 29 Oct 2025 00:31:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 654E798; Wed, 29 Oct 2025 08:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 3/4] regcache: flat: Split ->populate() from ->init()
Date: Wed, 29 Oct 2025 08:29:00 +0100
Message-ID: <20251029073131.3004660-4-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regcache-flat.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index f36d3618b67c..adcfde75f2b3 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -20,9 +20,6 @@ static inline unsigned int regcache_flat_get_index(const struct regmap *map,
 
 static int regcache_flat_init(struct regmap *map)
 {
-	int i;
-	unsigned int *cache;
-
 	if (!map || map->reg_stride_order < 0 || !map->max_register_is_set)
 		return -EINVAL;
 
@@ -31,15 +28,6 @@ static int regcache_flat_init(struct regmap *map)
 	if (!map->cache)
 		return -ENOMEM;
 
-	cache = map->cache;
-
-	for (i = 0; i < map->num_reg_defaults; i++) {
-		unsigned int reg = map->reg_defaults[i].reg;
-		unsigned int index = regcache_flat_get_index(map, reg);
-
-		cache[index] = map->reg_defaults[i].def;
-	}
-
 	return 0;
 }
 
@@ -51,6 +39,21 @@ static int regcache_flat_exit(struct regmap *map)
 	return 0;
 }
 
+static int regcache_flat_populate(struct regmap *map)
+{
+	unsigned int *cache = map->cache;
+	unsigned int i;
+
+	for (i = 0; i < map->num_reg_defaults; i++) {
+		unsigned int reg = map->reg_defaults[i].reg;
+		unsigned int index = regcache_flat_get_index(map, reg);
+
+		cache[index] = map->reg_defaults[i].def;
+	}
+
+	return 0;
+}
+
 static int regcache_flat_read(struct regmap *map,
 			      unsigned int reg, unsigned int *value)
 {
@@ -78,6 +81,7 @@ struct regcache_ops regcache_flat_ops = {
 	.name = "flat",
 	.init = regcache_flat_init,
 	.exit = regcache_flat_exit,
+	.populate = regcache_flat_populate,
 	.read = regcache_flat_read,
 	.write = regcache_flat_write,
 };
-- 
2.50.1


