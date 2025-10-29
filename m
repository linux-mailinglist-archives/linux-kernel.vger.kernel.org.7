Return-Path: <linux-kernel+bounces-875336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD8C18B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E4188F1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEEF30F937;
	Wed, 29 Oct 2025 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH3rtcZp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED32836A4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723099; cv=none; b=afWApZ2ZHNm24jtAFfJHAWdz9g+JfkEdm49ziw/0xyR5Tec38cdMldDnYHFEVF6CYCkkwCfGxNbEEP8eVjKmYnVV5sRD9omts4raNyPGwzfG/HPk4BFDo8XE+Dc61qHRVuDP68cMSC0ZpFSTIkEA3NHcfECd+FilvyQlGaoyLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723099; c=relaxed/simple;
	bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4g31+o8FuOuPKF/r6VvxBLZuKhRmYsYe8nscf8VEtjP5U1gpAWc/6rAndhHT5l5M7HymHT69CGZik32YtDZcepWX8ubuauBNIuSAhIkUCb9ExmYdHS4VgZTqG02RojMGABOPmQlVHD5SnjJi62XmwChwW1ZmF26CkmgplO1bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH3rtcZp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723097; x=1793259097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spUqVFANeu6zA5mqKFPkIzzbgdNgivsG0RxjQcBExq4=;
  b=WH3rtcZpVSO3MDmUpYSKv0HEZESy1G2yDHOQRdKtuqvJoUH8MWVMYqOJ
   qeR1KcKgk2RDDpetPwIvyDo0u1EUuHcE25KSyvxMOa2pL+6nEjTY/fHh3
   quhIBCr56aIY6xuk4QXCtsH/oxr40S/AhYYpVNxV+euMRv+39KbiJBuXR
   wD62vD27VsIQlrFqUgLf3ehLRDKK2gfAnVd0JbDmgiUU4Cl8tN54u+6kv
   kYWqX+Yho0xisOVMJBt83nXVoAwyeQkO1e6sUyTLtF3WN+R5f9bUlDNmH
   A7O1AQ29ryhv4/SOic9FnM4XkbX1rhGeoen3hdqYPs9w2K+xVlbj5FxmI
   g==;
X-CSE-ConnectionGUID: nZ0G+FEQTPecyM1ftwwjVg==
X-CSE-MsgGUID: G8sRo2fAR9aaV60OvV0cHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89304576"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="89304576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:31:37 -0700
X-CSE-ConnectionGUID: 4ddSmd8SRV+FlctmoJmuXg==
X-CSE-MsgGUID: qMBEHcEiTn+AoORM0ZIS/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="222797252"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 29 Oct 2025 00:31:36 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6915799; Wed, 29 Oct 2025 08:31:34 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 4/4] regcache: maple: Split ->populate() from ->init()
Date: Wed, 29 Oct 2025 08:29:01 +0100
Message-ID: <20251029073131.3004660-5-andriy.shevchenko@linux.intel.com>
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


