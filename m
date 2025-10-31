Return-Path: <linux-kernel+bounces-879673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18AC23B23
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721CF189AB27
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A2342CA5;
	Fri, 31 Oct 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfZ4NeJq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54F2236E1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897949; cv=none; b=bDhWAa0wpYl8Y8BVLh6RQR0pJ+ms3nebPrm+nk5J4gnJbde5XMc5SDhYybdYM5gCaYWn783ti7R7GWAD/l1+WR5cC8cq5+cMDeGmEIwRTxqq5zElbvphhHWR0PsPcOCKI6JBokJBm1kygEilpxt76LMEjZwPSgVZ+rUN87it6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897949; c=relaxed/simple;
	bh=5BDc6KcSVzzM4URCYJVmlaEuRLHbvFkYpGfq3+8BKJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGZzKNS4kZWPMHwpGIyurRKe0EhYzocrT5UTTFm/A8/1bcWfDQyV81bgzFVZHZ5k/UaXO9EoMaIEh5aEiE4P2dfpEkHO9EA8rN+ZIkGdzWbkyo1JQCtWW0qW4TmCQIJlFscbmn+aHKA3H/NaRhRjqD/+iWOoCXzdH20AdNtzwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfZ4NeJq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897949; x=1793433949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5BDc6KcSVzzM4URCYJVmlaEuRLHbvFkYpGfq3+8BKJM=;
  b=RfZ4NeJqanZEs/bNX9ama/e0ukm8D8XciKQsfTgfIFBh3uOBsrOJNaH8
   bcMnIt+Tne61oYGnPdoaTyeMjyyJDjEyN+6zmFdwB5SW1J/Vu9xVEiO1v
   we266gOwcX1F0Xkqn3riMFZsdiFt00jwtWyDH7vniTrB+0G05s8ivNCPa
   hsg+FBa1FUTCLcmdPYDwoz/GCmhnf5Qz2uJwcgp3gHLvoEBTqJPshYxke
   eg8xz+Q2Lo4H3AoYXvPU0cJeVbqQV2wBmdKP6SBGwcH+ppWSzci5Xdw4F
   06HxBTjJlmpaGj0abQDUKrtXPBdnb8XlIy7XYJsJAJ4esAkSvyKz3X7cK
   w==;
X-CSE-ConnectionGUID: FrnZ/rg5RPOkP3GqmGOA2A==
X-CSE-MsgGUID: LEQw6cTiQ7iJKHYYYyA/CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67888891"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67888891"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:46 -0700
X-CSE-ConnectionGUID: o1JGxKJIQQamQoQ73fzQwA==
X-CSE-MsgGUID: a7Ij78lpQMiV8ri8NRXAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="191320283"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 31 Oct 2025 01:05:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 96CB696; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 1/5] regcache: Add ->populate() callback to separate from ->init()
Date: Fri, 31 Oct 2025 09:03:16 +0100
Message-ID: <20251031080540.3970776-2-andriy.shevchenko@linux.intel.com>
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

In the future changes we would like to change the flow of the cache handling.
Add ->populate() callback in order to prepare for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regcache.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 8d19a1414d5b..1477329410ec 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -186,6 +186,7 @@ struct regcache_ops {
 	enum regcache_type type;
 	int (*init)(struct regmap *map);
 	int (*exit)(struct regmap *map);
+	int (*populate)(struct regmap *map);
 #ifdef CONFIG_DEBUG_FS
 	void (*debugfs_init)(struct regmap *map);
 #endif
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 0392f5525cf3..319c342bf5a0 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -222,8 +222,24 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 		if (ret)
 			goto err_free;
 	}
+
+	if (map->num_reg_defaults && map->cache_ops->populate) {
+		dev_dbg(map->dev, "Populating %s cache\n", map->cache_ops->name);
+		map->lock(map->lock_arg);
+		ret = map->cache_ops->populate(map);
+		map->unlock(map->lock_arg);
+		if (ret)
+			goto err_exit;
+	}
 	return 0;
 
+err_exit:
+	if (map->cache_ops->exit) {
+		dev_dbg(map->dev, "Destroying %s cache\n", map->cache_ops->name);
+		map->lock(map->lock_arg);
+		ret = map->cache_ops->exit(map);
+		map->unlock(map->lock_arg);
+	}
 err_free:
 	kfree(map->reg_defaults);
 	if (map->cache_free)
-- 
2.50.1


