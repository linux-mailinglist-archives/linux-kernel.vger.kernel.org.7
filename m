Return-Path: <linux-kernel+bounces-878814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3FC21864
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476541A645BB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24436C25B;
	Thu, 30 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7hwiSLr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9F36B972
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845962; cv=none; b=Pv+eKmVqz7xU01F5Hy+NQtWX6gxe5leFn78De+cfIEIEk/sByFZvoWnQBMXnA/OzPhSDhJIgaetRTveY55UgdPOb3Cv29BZOlUQ7sm+6pL4EiXjypNkNLT67Iw7gQ4wo98AJFIRJMNea0NyeQjDGCX+7rkSgnmcx0nBgmjCmikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845962; c=relaxed/simple;
	bh=5BDc6KcSVzzM4URCYJVmlaEuRLHbvFkYpGfq3+8BKJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNPZ5LLoC0eEd51j7KR6VBTLXicStzY0yTDIv8ZE9wOdEgiFFjCmPevOg/0yFGAF/WBGPdCCzfhEOvrG0ygRlArlN3jhnjNOm2xtj5dInUxuExlzt1vuqyH8L0TGHb1ycjq8FkbmtM2cmzHng+A7yI/TKC/GUtuAHEZM4SYcSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7hwiSLr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845959; x=1793381959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5BDc6KcSVzzM4URCYJVmlaEuRLHbvFkYpGfq3+8BKJM=;
  b=F7hwiSLryq2XqKj1ZJdLYTZh5gvXfJQ2j/pZvqcU+if5X4WdzLMvGd9u
   cfJEbRUc9H438ZvkWSkCamtwS5I3FAo+M0Itz4HOfZHyRALnkRqE82uk0
   vcadLkXmQHOV8r1a9Pu/OfawB1vFHvfypYohCmldpDsAd8CXsyRP385Gm
   p3Tj0mCzY5kDQ0JIiBi3VwdOZIiqIRQWwSYWd5LknMQI516r3kQEyWUpZ
   tQzSapptGY2OFt4MUucExvl/K5MuCe9xbzGhtaO/qpZf1X6qXc/yQNjHe
   QjI0Xy7HaRicMlzlc8EgXL4E0GdaHh4yCwKHmdxwaHkmrn54lOGB2R4oJ
   Q==;
X-CSE-ConnectionGUID: /R3YbbniTeiZ0CYQhWqGDA==
X-CSE-MsgGUID: we+TuCXkTa2ZdGG+pdAdeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75345921"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75345921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:19 -0700
X-CSE-ConnectionGUID: KtDE4tdeQrys1RMOIkaF7A==
X-CSE-MsgGUID: Aq9qppV4T46bD854lFsMBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185224750"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2025 10:39:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6437D96; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/5] regcache: Add ->populate() callback to separate from ->init()
Date: Thu, 30 Oct 2025 18:37:01 +0100
Message-ID: <20251030173915.3886882-2-andriy.shevchenko@linux.intel.com>
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


