Return-Path: <linux-kernel+bounces-878813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A04C2186A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F903BDEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC336C243;
	Thu, 30 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fItbeAW6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450836A61B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845962; cv=none; b=X7s+xZQXXC4m7KWMrilZRenlCrgEGj4AXz1O8HilTcV7p97b4oEbAK1hkVxvKPf9+oy4YyIelpTNzk2lNmjiyXCJHNHCuYFU8+cSVXOdfRW1oLq5LwgkFw1XEO/k1aQ2WYl1F7YbqnzOo4Bs4v8+tnGzjuhU2t2txv1+CKvht7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845962; c=relaxed/simple;
	bh=HvnsiY17eHzORT91DrZmgc5kRgcglwx4EykmEctk1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eus7oL1vlffRHLjKkHrFx2B9Sg8oot5EfE/TXiFE4O/1fzQ68ew1XXo8dv/y+p0cRU9XH33fhHDSrxvLujvfyggBW5AvBZx4wGuySV13HtffWKpEy4KQKitqW0LoNJ2Pn3igv/hmtFkUp0lVZQ+FVYnXVWF1O15Oh7KOzF8CzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fItbeAW6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845960; x=1793381960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvnsiY17eHzORT91DrZmgc5kRgcglwx4EykmEctk1DM=;
  b=fItbeAW6Zp3iL6lUxJeA9Cqi3imQfnbmvqR7pVce9LyjX+DOrX+VsuVn
   YciF5XkArHGqgaDVL3zVx/va3bnGYiEzRVvJs2AKBtDVxkLOKDfClCDtN
   Oup2z0d9ZKAywt5O4NMa4cZzv/P0sn60u/Ncara+UCNU4AlKEnSwrV5qR
   9CSh9fUZIYtg14MpaCdc47fPlnX5sLvu0Us8MPtQpF5u1aED0VBaiBy0C
   J47au+alCUiSt90s32UA486dnxU0xgW6Ej1yuo3edQqBgW2BBtu3lmGZo
   prsXXoGEAOpK+Y4Bk42emxZlMkiafkkJAkcs/J6Q102n+VgxV/tL7udxb
   w==;
X-CSE-ConnectionGUID: xMKx9IPcRQWEgziFNjvnCA==
X-CSE-MsgGUID: 1StB1nf+QTWZjSMn376j+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64038630"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64038630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:39:19 -0700
X-CSE-ConnectionGUID: byRNiFhXSfK9Am+CpmtXYQ==
X-CSE-MsgGUID: sFaxre9DT0a1wkz0x/tjdg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2025 10:39:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6CD5898; Thu, 30 Oct 2025 18:39:16 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 3/5] regcache: flat: Remove unneeded check and error message for -ENOMEM
Date: Thu, 30 Oct 2025 18:37:03 +0100
Message-ID: <20251030173915.3886882-4-andriy.shevchenko@linux.intel.com>
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

There is a convention in the kernel to avoid error messages
in the cases of -ENOMEM errors. Besides that, the idea behind
using struct_size() and other macros from overflow.h is
to saturate the size that the following allocation call will
definitely fail, hence the check and the error messaging added
in regcache_flat_init() are redundant. Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-flat.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index 3b9235bb8313..bacb7137092f 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -30,7 +30,6 @@ struct regcache_flat_data {
 static int regcache_flat_init(struct regmap *map)
 {
 	int i;
-	size_t cache_data_size;
 	unsigned int cache_size;
 	struct regcache_flat_data *cache;
 
@@ -38,14 +37,7 @@ static int regcache_flat_init(struct regmap *map)
 		return -EINVAL;
 
 	cache_size = regcache_flat_get_index(map, map->max_register) + 1;
-	cache_data_size = struct_size(cache, data, cache_size);
-
-	if (cache_data_size == SIZE_MAX) {
-		dev_err(map->dev, "cannot allocate regmap cache");
-		return -ENOMEM;
-	}
-
-	cache = kzalloc(cache_data_size, map->alloc_flags);
+	cache = kzalloc(struct_size(cache, data, cache_size), map->alloc_flags);
 	if (!cache)
 		return -ENOMEM;
 
-- 
2.50.1


