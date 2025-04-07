Return-Path: <linux-kernel+bounces-590691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D04A7D5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9955D16EFE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371822D4FD;
	Mon,  7 Apr 2025 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPCSjXZ6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8822D791
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010496; cv=none; b=S50w9FO8Fmhu4TEYHY+MqjL6OgtA4qm/81JwCy1Q+BMwfrTG6ojw7HrbFvjx33fg6+zSK++FG7UNRaKrSmHRea6OJkd+N+qfv4pjnuw9dXtHTmLzBkoUzrjAYfXyTrPwyjC/CF6mOT8Bz2oQMoxHURDPOYEX8pbpriDgvSVDlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010496; c=relaxed/simple;
	bh=4qx9srvVw5/073OAlAi2thUlYG31LR/V0K21OZO/4rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVyl4N80t5pjPYFRHoUlfI8fPpgI8CCIOqGun5kxTCaakD1bcVlUt7baKdsKzlqUsxt/XbqcdRwuWL9NguQmOwlNLN4QhE70Mrhx4cLfbT9GtaIeczl0+vfQu6gmkfny8wNaXam4Ng9Km4b6gHSpqfk8FBTRpQK/dS0vI4G6ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPCSjXZ6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744010493; x=1775546493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qx9srvVw5/073OAlAi2thUlYG31LR/V0K21OZO/4rI=;
  b=XPCSjXZ6FyFd5WkmLwBI3gls9ttYBikGsXT7J6CW2yur9b5AAcMVH0Bf
   eh4S7qjgJzVdwH8/+JS3eFHmiU9DZkta75+mWxDaTlBY5vx0HwX53PUi4
   tpCbZwXBaLOgz9/8C4Chu4pC0laA4VzEH7hOTiPKHTtYn8zpGEHrVmau9
   uThgevH3G2oXd3tQUfMuo9O2X1f8Ova2KBJjsN4JwCUnoNL12uAyWMr/K
   gHVhnLh4Ia51uZHRVw66qUMUJCxVgZESTqXdYk2uCHISEKw808JfD9Xkx
   +FRCZtriFkEzFhU5xbCB8hWY4M+otgoo7iMMgIJ01f4Be+q1dfgrclAm/
   g==;
X-CSE-ConnectionGUID: lOHDhflfQeiaMSQrzo6Hbw==
X-CSE-MsgGUID: hajhqCGoSd2alikR7yQ/3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="62776509"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="62776509"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 00:21:32 -0700
X-CSE-ConnectionGUID: FalYELIfTy28RPnuAw+9nA==
X-CSE-MsgGUID: 0V7vV61KQVaaXUii0bRFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="127862657"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 07 Apr 2025 00:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 596EC340; Mon, 07 Apr 2025 10:21:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dm table: Fix W=1 build warning when mempool_needs_integrity is unused
Date: Mon,  7 Apr 2025 10:21:26 +0300
Message-ID: <20250407072126.3879086-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mempool_needs_integrity is unused. This, in particular, prevents
kernel builds with Clang, `make W=1` and CONFIG_WERROR=y:

drivers/md/dm-table.c:1052:7: error: variable 'mempool_needs_integrity' set but not used [-Werror,-Wunused-but-set-variable]
 1052 |         bool mempool_needs_integrity = t->integrity_supported;
      |              ^

Fix this by removing the leftover.

Fixes: 105ca2a2c2ff ("block: split struct bio_integrity_payload")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/md/dm-table.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 35100a435c88..53759dbbe9d6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1049,7 +1049,6 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 	unsigned int min_pool_size = 0, pool_size;
 	struct dm_md_mempools *pools;
 	unsigned int bioset_flags = 0;
-	bool mempool_needs_integrity = t->integrity_supported;
 
 	if (unlikely(type == DM_TYPE_NONE)) {
 		DMERR("no table type is set, can't allocate mempools");
@@ -1074,8 +1073,6 @@ static int dm_table_alloc_md_mempools(struct dm_table *t, struct mapped_device *
 
 		per_io_data_size = max(per_io_data_size, ti->per_io_data_size);
 		min_pool_size = max(min_pool_size, ti->num_flush_bios);
-
-		mempool_needs_integrity |= ti->mempool_needs_integrity;
 	}
 	pool_size = max(dm_get_reserved_bio_based_ios(), min_pool_size);
 	front_pad = roundup(per_io_data_size,
-- 
2.47.2


