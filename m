Return-Path: <linux-kernel+bounces-875334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA6C18B38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE8354E5804
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB130E0EC;
	Wed, 29 Oct 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgJRUq1i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3C23BD13
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723099; cv=none; b=kkfJbgUIAFGbD+LGVAe2iB/Rpfh9/6UtDhmMexN0lEBckfETS7P1piamhRec50fbOSbOfvi9ej9HOCBXzWx+8z9mIGqL0tEghMtWta+eiecmLL6sQDGzGFnGGGbzziejah6fGr8NaHqEX8uP6KWLEzkm3LOLZq/f5vLpSYnaczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723099; c=relaxed/simple;
	bh=zQuHvvFCL7RGaZWrKmLYT4hfs2YnHzQbTWDMrC99pJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEljMu5450u7+mRQYrLDkEHuIM5Y0MTeLm+nNR21Ayrc7OXJkJ5Wq4RkDiEeetzN6MHRPIMY4M77fzEcj63xyueAm2ISNMyfLMiDoFUHv61cXB0AePWJmfJxkGfB5gyt31qCG46D02neuakdCQA2IJ/3aCiN7KoBGGvaP/ZX0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgJRUq1i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723097; x=1793259097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQuHvvFCL7RGaZWrKmLYT4hfs2YnHzQbTWDMrC99pJ4=;
  b=mgJRUq1iP/8wgBf5SAcGttjWuHO95svhopIZy9DnMAKNTDhiLF0sDUEU
   YOdEALLdMlmm2jL3GojSiPg42rxT3C5kcpgPLSz/OctW8wKOKJD9mGADB
   YESMpeeAWlccom0we06ClYrY+J8vY5OFZcR8DMceY37sIxRY6FZV45qDc
   dkMEUfpePDLh8TaaUJKKI9mVqNGfU6uMvdUpV6QuZkGdF4dU94M0dllnk
   1ZcAEWHJlOlgcqyJ9KTul78GWqaFsYgpxPt8/xCUJQkpHH3lW5xLVL1mv
   6NuwhWoUCEvplcDo6x8a6H/NBfSB4Fah9VGFBBDpXrqvQhxgh09LjqUiC
   Q==;
X-CSE-ConnectionGUID: icSqZKjmSXGeLL/Hv/k6xQ==
X-CSE-MsgGUID: RZVwM+PMQGylvirQdP5Uag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63870953"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63870953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:31:36 -0700
X-CSE-ConnectionGUID: n0Wgeb3PQ8yp3c6GnMS0pQ==
X-CSE-MsgGUID: hYRbDtkBSma2Jm7c7s/fFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185469058"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 00:31:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5D76A96; Wed, 29 Oct 2025 08:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 1/4] regcache: Add ->populate() callback to separate from ->init()
Date: Wed, 29 Oct 2025 08:28:58 +0100
Message-ID: <20251029073131.3004660-2-andriy.shevchenko@linux.intel.com>
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

In the future changes we would like to change the flow of the cache handling.
Add ->populate() callback in order to prepare for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regcache.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 6f31240ee4a9..6efed02c21c5 100644
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
index c7650fa434ad..149945690cdf 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -221,8 +221,24 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
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


