Return-Path: <linux-kernel+bounces-720844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B676DAFC117
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F71AA6DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C27228C9D;
	Tue,  8 Jul 2025 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lzUmdFXk"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7338199E94
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943491; cv=none; b=qjGx+ggyIVPgi11wBxmYOolCc0ANVzVrw8nTD8Z04eY2ATO3QK5UbwS8/lQq0AKaR/5AbzDY0JYdHWovpwlc25wz8q50QzzT6xesogOdTHFbmm4UFkrMsBEdwnCjmg9Avq/ODq3we9g/f5a5aMPhJLQ3NyKvgVBVQHItMpv5djM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943491; c=relaxed/simple;
	bh=kCffdQKYAa0eeS/Fo5NqJK/zqawTmRmlInuXwDV/e8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEOXUl9l9sv96Vh7CsVyoagAeAnve5uavMKt1GRpXia4QgooqUDLx6PB9y43VxzYZNJv1k08kEUclXjzuq+TjVifSQNuhqRcuug6QLMEsd/r538efIuzHQYB0zvHLONyowfqiX+Nr9l8gmKBCCTlV0LJKspWKTubll2BtXMxtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lzUmdFXk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751943486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D/SQkQyiBiqr7Hn8p76kER8Q8ghEeOvxX581xJ16oHI=;
	b=lzUmdFXkGbSW54cHDHy7PdNmyGuSogBqv4AabCE2ZXtgLqfj54kwtxAGhrteNEn7e+claO1EOkvHNx8hhgLBpK4gWdYTlnJlsdTvD5NCrt1BiU8WhHp1Wv0iw6WdHu8tOK+I1zufx5r0ELLE3N5z7N+n276NaKXlYl7qItmB0Hw=
Received: from 30.221.131.215(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiJ79iY_1751943484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:58:05 +0800
Message-ID: <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Date: Tue, 8 Jul 2025 10:58:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250707084723.2725437-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250707084723.2725437-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chao,

On 2025/7/7 16:47, Chao Yu wrote:
> All below functions will do sanity check on m->type, let's move sanity
> check to z_erofs_load_compact_lcluster() for cleanup.
> - z_erofs_map_blocks_fo
> - z_erofs_get_extent_compressedlen
> - z_erofs_get_extent_decompressedlen
> - z_erofs_extent_lookback
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
How about appending the following diff to tidy up the code
a bit further (avoid `goto map_block` and `goto out`)?


  fs/erofs/zmap.c | 67 +++++++++++++++++++++++--------------------------
  1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e530b152e14e..431199452542 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -327,21 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
  	DBG_BUGON(lcn == initial_lcn &&
  		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
  
-	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		if (m->delta[0] != 1) {
-			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-		if (m->compressedblks)
-			goto out;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
+		erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
  	}
  
  	/*
  	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
  	 * than CBLKCNT, it's a 1 block-sized pcluster.
  	 */
-	m->compressedblks = 1;
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
+		m->compressedblks = 1;
  out:
  	m->map->m_plen = erofs_pos(sb, m->compressedblks);
  	return 0;
@@ -422,36 +419,34 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
  	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
  	end = (m.lcn + 1ULL) << lclusterbits;
  
-	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
-		if (endoff >= m.clusterofs) {
-			m.headtype = m.type;
-			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
-			/*
-			 * For ztailpacking files, in order to inline data more
-			 * effectively, special EOF lclusters are now supported
-			 * which can have three parts at most.
-			 */
-			if (ztailpacking && end > inode->i_size)
-				end = inode->i_size;
-			goto map_block;
+	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
+		m.headtype = m.type;
+		map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+		/*
+		 * For ztailpacking files, in order to inline data more
+		 * effectively, special EOF lclusters are now supported
+		 * which can have three parts at most.
+		 */
+		if (ztailpacking && end > inode->i_size)
+			end = inode->i_size;
+	} else {
+		if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+			/* m.lcn should be >= 1 if endoff < m.clusterofs */
+			if (!m.lcn) {
+				erofs_err(sb, "invalid logical cluster 0 at nid %llu",
+					  vi->nid);
+				err = -EFSCORRUPTED;
+				goto unmap_out;
+			}
+			end = (m.lcn << lclusterbits) | m.clusterofs;
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+			m.delta[0] = 1;
  		}
-		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-		if (!m.lcn) {
-			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-				  vi->nid);
-			err = -EFSCORRUPTED;
+		/* get the corresponding first chunk */
+		err = z_erofs_extent_lookback(&m, m.delta[0]);
+		if (err)
  			goto unmap_out;
-		}
-		end = (m.lcn << lclusterbits) | m.clusterofs;
-		map->m_flags |= EROFS_MAP_FULL_MAPPED;
-		m.delta[0] = 1;
  	}
-
-	/* get the corresponding first chunk */
-	err = z_erofs_extent_lookback(&m, m.delta[0]);
-	if (err)
-		goto unmap_out;
-map_block:
  	if (m.partialref)
  		map->m_flags |= EROFS_MAP_PARTIAL_REF;
  	map->m_llen = end - map->m_la;
-- 
2.43.5




