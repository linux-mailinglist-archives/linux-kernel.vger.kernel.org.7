Return-Path: <linux-kernel+bounces-722763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA3AFDE8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FE658115D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DE204866;
	Wed,  9 Jul 2025 03:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FkG5eEPo"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B575661
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032786; cv=none; b=PTrG9bPv7ediYi7hY5pZ96WghyVGH07PBDjmiy4cwYLcDYFjQNIZQd6LNHU0nKgHpfYyjvDDjkOZ6ahk/NtMex5UYHwI3RO1GPsLg/yQAJ+i+NXLRyx4FMJSYv/rB2gPRWf0UstNuUw7j6WhyEmF88zkLlSXMPyEZ4eYPAUNxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032786; c=relaxed/simple;
	bh=wT/gI8CBHwFxnc9HyLvkLuaYeo5O3C1wdNqHupVgmNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFlEUD8xF5AulRe5RkgEhycEbRn8LIhYHsrGWp+ur7/2L8uc8bHB+H7dooRiO+DAmLSNsvAvHwt8cYFNpg50iXxdprD3JOiDufsnmdtJnMQCq/vYnPdeueTcWLTC6vQfYpRxEPl875pqJxuqobEo6Choh/n9iGew5ZUaJutBxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FkG5eEPo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752032781; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=f3GpZHDuE3N1k7COKmMSW+fvkGwAnlSYuCB8czZV42Y=;
	b=FkG5eEPoOJrmtbBL+tofv/StobM5ZCQ5Tbns3G7tkjC3sLsYPLB61fl6u7XrsYMxZZwXO6YBpMsbnJT7gT5Mv9sg4UCuLzy7VRO8mJLARMtsvkEzAg/SQCPympyUZSZU6M5KtO0clhUGbFCfW3k4ZZI26Gx0Gq3970rFM2cUgmI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiW0kHI_1752032775 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 11:46:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs: use memcpy_to_folio() to replace copy_to_iter()
Date: Wed,  9 Jul 2025 11:46:13 +0800
Message-ID: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using copy_to_iter() here is overkill and even messy.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index df5cc63f2c01..fe2cd2982b4b 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -96,8 +96,6 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 	struct erofs_map_blocks *map = &io->map;
 	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
 	loff_t pos = folio_pos(folio), ofs;
-	struct iov_iter iter;
-	struct bio_vec bv;
 	int err = 0;
 
 	erofs_onlinefolio_init(folio);
@@ -122,13 +120,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				err = PTR_ERR(src);
 				break;
 			}
-			bvec_set_folio(&bv, folio, len, cur);
-			iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
-			if (copy_to_iter(src, len, &iter) != len) {
-				erofs_put_metabuf(&buf);
-				err = -EIO;
-				break;
-			}
+			memcpy_to_folio(folio, cur, src, len);
 			erofs_put_metabuf(&buf);
 		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			folio_zero_segment(folio, cur, cur + len);
-- 
2.43.5


