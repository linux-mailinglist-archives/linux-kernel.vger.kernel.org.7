Return-Path: <linux-kernel+bounces-871200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC031C0C998
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FB5934BFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9D2E7F1E;
	Mon, 27 Oct 2025 09:16:17 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515242D5C86
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556577; cv=none; b=Psb7SoIZMlqrefXrYA+SXGB37nKv/18ilP8qw2BGs6Kg64HON0Cz58J0uS7KkC9LbpVWGZbocjrp241m3fb+VAJIbI15JYOb7tXmCsKzMQuegquQnzqNKUBQpDlnkbdd58NDNxFkRdskLx5LQ8gUrQjONqnO4nmLmFSnRPpUQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556577; c=relaxed/simple;
	bh=Z/1f0wqqdsWhc2FSgLRDK6PtcCsAzviHQ3OZUvR0lNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D8E1fOHA36KKqfC+IBQ16ucjpkDtAGqRDPHkMeFOuLIn4lvx9hUARz33xyF+nrTth3ukafjDxibPjdYxvKlBv8Z8lPpAJz3Wx+o9BapkMaRqBbm2zFz4nS/V2unIsE+6lggLIIJ1IM7vpvPxrWuNpE5l9ucwDMfzs4hXneA1vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee668ff379e6d4-1a077;
	Mon, 27 Oct 2025 17:13:03 +0800 (CST)
X-RM-TRANSID:2ee668ff379e6d4-1a077
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W4100033 (unknown[36.137.216.17])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee868ff37855ca-a4e75;
	Mon, 27 Oct 2025 17:13:02 +0800 (CST)
X-RM-TRANSID:2ee868ff37855ca-a4e75
From: bajing <bajing@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] Fix the problem that kunit cannot run
Date: Mon, 27 Oct 2025 17:12:30 +0800
Message-ID: <20251027091231.1770-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running ./tools/testing/kunit/kunit.py run,the error for mm/swap.h
is as follows:
ERROR:root:In file included from ../mm/shmem.c:43:
../mm/swap.h: In function ‘non_swapcache_batch’:
../mm/swap.h:66:19: error: implicit declaration of function ‘swp_offset’;
did you mean ‘pud_offset’? [-Werror=implicit-function-declaration]
   66 |  pgoff_t offset = swp_offset(entry);
      |                   ^~~~~~~~~~
      |                   pud_offset
In file included from ../mm/shmem.c:68:
../include/linux/swapops.h: At top level:
../include/linux/swapops.h:107:23: error: conflicting types for ‘swp_offset’
  107 | static inline pgoff_t swp_offset(swp_entry_t entry)
      |                       ^~~~~~~~~~
In file included from ../mm/shmem.c:43:
../mm/swap.h:66:19: note: previous implicit declaration of ‘swp_offset’ was here
   66 |  pgoff_t offset = swp_offset(entry);
      |                   ^~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [../scripts/Makefile.build:243: mm/shmem.o] Error 1
make[3]: *** [../scripts/Makefile.build:480: mm] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/home/openeuler/kernel/Makefile:1924: .] Error 2
make[1]: *** [/home/openeuler/kernel/Makefile:234: __sub-make] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 mm/swap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/swap.h b/mm/swap.h
index 26fa536a8947..04695e1af068 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,6 +4,7 @@
 
 #ifdef CONFIG_SWAP
 #include <linux/blk_types.h> /* for bio_end_io_t */
+#include <linux/swapops.h>
 
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
-- 
2.50.1.windows.1




