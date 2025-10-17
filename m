Return-Path: <linux-kernel+bounces-857464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A3BE6E02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A690235A5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CB30FF02;
	Fri, 17 Oct 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pPmWEpZU"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AE33F9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684753; cv=none; b=ogqLevnOZOFPl3M+4mHJ7gkcTaHrgxP7RVeR9d8Q2LqnRyfajX87tmOUqcHvqo3BpOfVhq0fn7CQGuyHA3JP3geqau5dpc6mdubSKxb/5u+wr0H1qiMeRu78/DROoGmJy0gaNU4MaUWKCmf07rflqSupLBkzmKaFrRSYU9f9hA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684753; c=relaxed/simple;
	bh=3imxam8W9K/t0LkkdtWXlZmyBMYF1w5oXBMVkcEyrxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZvsgmfRLnEQZY7EBnOaC+gYoPIeniqAocug0ticcPpHszMDT9r4Vv54WzlDwcQdSgWAGWk47Ksrob1A4H2opKxZJu13k56uBPHznSB1XxwWwfYiTt+MST2V5uJWFg9cafePpKFTGOydBI2SMSMGy7VAwxrRpyI6sWH1CAafo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pPmWEpZU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760684746; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M7lDlpIyKY1H3VYmkPTYXMTYJIOdRidmY94vSP/ywNA=;
	b=pPmWEpZUqSJ0KsKPOk7R/2LrPFzPuQo5lQ+mlGDOlyvjYa7TAMackkjf6sZ2pyVhmHe+ljH+IZHINiREy+AKNfKPVEn+WXZRloCLNsKcJKFXCpEuX2rd41XRKvEU1J3kCI3U+CzGtCHMO3y7gxtqaYpI/lhlnqwYWF0RcY3SSdU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqOynU3_1760684745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:05:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: consolidate z_erofs_extent_lookback()
Date: Fri, 17 Oct 2025 15:05:39 +0800
Message-ID: <20251017070539.901367-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
References: <20251017070539.901367-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial m.delta[0] also needs to be checked against zero.

In addition, also drop the redundant logic that errors out for
lcn == 0 / m.delta[0] == 1 case.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6aca228cd2a5..a8ce531f4f19 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -272,20 +272,19 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		unsigned long lcn = m->lcn - lookback_distance;
 		int err;
 
+		if (!lookback_distance)
+			break;
+
 		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
 		if (err)
 			return err;
-
 		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
-			if (!lookback_distance)
-				break;
 			continue;
-		} else {
-			m->headtype = m->type;
-			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
-			return 0;
 		}
+		m->headtype = m->type;
+		m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		return 0;
 	}
 	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
 		  lookback_distance, m->lcn, vi->nid);
@@ -435,13 +434,6 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 			end = inode->i_size;
 	} else {
 		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-			/* m.lcn should be >= 1 if endoff < m.clusterofs */
-			if (!m.lcn) {
-				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-					  vi->nid);
-				err = -EFSCORRUPTED;
-				goto unmap_out;
-			}
 			end = (m.lcn << lclusterbits) | m.clusterofs;
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
 			m.delta[0] = 1;
-- 
2.43.5


