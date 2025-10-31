Return-Path: <linux-kernel+bounces-879670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF8C23BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A94404F97FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FB33FE2B;
	Fri, 31 Oct 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcKjUrcV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD632D0C8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897946; cv=none; b=GdcXHheK1416TJl3aezAGNfLc5ybXotr0EulBN9SAZC6xdSY0DaIGatPbM7VtcS8HfObxkZiHHqyAVBeNT9lM/NxV9BFSKZXOQlwn1Yd1YOLLKbrnZqxbr2W2UWB9TJnrJyjg+khpS0Nm+/xYIyZPG8Gy+lmnRpdUyS50XzTBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897946; c=relaxed/simple;
	bh=zHK079r4HYzsWM60ko/wEtpRjo7ot642qsjYLA51hhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjcKHOY9A1MhCQHXCyfuZLvpgf2BOmdsErEGhyGqb9O0uhahMT5dSOCuhnhjaP4DBUbdP85YW4Hd7MlJK7vMXGg2ZctK3DJ7Qcg0xOcro8fa+RcXwB+cYYmu638PrTSdN6JnhY8xpr62okZddvsiBOx76P4Og0lKeAu+15FEwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcKjUrcV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897945; x=1793433945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zHK079r4HYzsWM60ko/wEtpRjo7ot642qsjYLA51hhE=;
  b=QcKjUrcVBQXwfC6MrcGcVOFOxmic8o53KzJd9iHv8BuVtsV5vIqfpDft
   kbRFCPF31uyOZr8iifSLWlkxnTAJjNZIoQozXqOs0unK7iys1WA/7ryER
   cpWTBEx2jtFZByGGQUUqQDkzvqCfj9zLzI38EWvzL5rMP3ZYn6OH0HUkg
   KE/cS1Wb9jRxo26J9VIBqY2+SOXOoEYmu9IYSW9syHy2zL781ULYbO5bh
   rUSJ9dqtarqZYspdHXlslzXPWiyLI2efPZQDQQ8UAzi0AtqZTIoZWimla
   AkDx78aJ3L/uEnqYUoDRo81ZzopHCzi3gAOGUj1QP9bHJ7NxOw6NnqTuj
   A==;
X-CSE-ConnectionGUID: vxjvuWMJRhWS0nOcPT0Awg==
X-CSE-MsgGUID: T1lAXg3hQqiondIxM6r4xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74345309"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="74345309"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:05:44 -0700
X-CSE-ConnectionGUID: COtXOfhVTvWfWx+x49L5cA==
X-CSE-MsgGUID: nKagEXMBR+yQDuGd1zvbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186288942"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2025 01:05:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9FDB498; Fri, 31 Oct 2025 09:05:41 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 3/5] regcache: flat: Remove unneeded check and error message for -ENOMEM
Date: Fri, 31 Oct 2025 09:03:18 +0100
Message-ID: <20251031080540.3970776-4-andriy.shevchenko@linux.intel.com>
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

There is a convention in the kernel to avoid error messages
in the cases of -ENOMEM errors. Besides that, the idea behind
using struct_size() and other macros from overflow.h is
to saturate the size that the following allocation call will
definitely fail, hence the check and the error messaging added
in regcache_flat_init() are redundant. Remove them.

Acked-by: Sander Vanheule <sander@svanheule.net>
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


