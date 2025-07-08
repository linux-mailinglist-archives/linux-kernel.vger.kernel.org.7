Return-Path: <linux-kernel+bounces-721436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E853AFC92B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C263B2CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99F2D8388;
	Tue,  8 Jul 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv7UV2GP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7628751C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972999; cv=none; b=QIkTLWwsGtZpPyvfMWXmORrCVleUjtQ46MoRVV3Lc2eZOJjpv8b01j396kA/LdXG/mozM5nuzLhbgPVGX5BFKjNMTOu+gNXwshQYjSDRDBFRBULI8+TA/2KVL4C7PEHHne0IsCK1763ZwEMG0o82kXpSEzQ0EStV40HTLccWips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972999; c=relaxed/simple;
	bh=dzheaSPee36sOXHJUq2zZC2pzBfsWvT3LybX/c1YjKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpHjxjbfGT/ngNkTrJ6MvdehLinNpdgPhpnKYHfHznrz+Xw1GY5VG2byQuaYPZzFentqVC+IcL2T/K/04nyYdkmCyoFzYdV4O7raL4p/EQANl6w9T4GPjhT39B7NmIntCtFxmiHMHSx4yN1YyZQUyP9FcxxJpCg5Sjx0TgJ4Ekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv7UV2GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC886C4CEED;
	Tue,  8 Jul 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972999;
	bh=dzheaSPee36sOXHJUq2zZC2pzBfsWvT3LybX/c1YjKI=;
	h=From:To:Cc:Subject:Date:From;
	b=iv7UV2GPxeslN/c+dWo2tlE6eeBbe6ESxV1+PppBsNhs+MUET4Fo1KhD2kdyZiqPG
	 OLOXYF1G4KqiqeYkujK82qFUKO8n/LcKz8KOHxuFZFgubSuclYP0jgeMc4wcKGpeb1
	 aT59nNUz4hy9iz9+PemFLUlvnitzu50lJbq+xmKjnxMPtN8wdL71nKfQ0gOl+KByoZ
	 8PWLxlzjgL0Rg09qD+tUX0crYZsfBL6rLPZrGqUBMzm29IRM1o0q6ulmFMl23+k27m
	 K/Pog/L3CrlZV2IQW9pbRIAQ9sr+aLLc1SsiNsUr7achFNDDVYWoxiuaIA0TRDjZXi
	 y7FjQugVXwQEg==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()
Date: Tue,  8 Jul 2025 19:09:28 +0800
Message-ID: <20250708110928.3110375-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All below functions will do sanity check on m->type, let's move sanity
check to z_erofs_load_compact_lcluster() for cleanup.
- z_erofs_map_blocks_fo
- z_erofs_get_extent_compressedlen
- z_erofs_get_extent_decompressedlen
- z_erofs_extent_lookback

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- include Xiang's cleanup diff.
 fs/erofs/zmap.c | 103 +++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bebc6e3a4d7..431199452542 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
+	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
+				m->type, lcn, EROFS_I(m->inode)->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+
 	switch (EROFS_I(m->inode)->datalayout) {
 	case EROFS_INODE_COMPRESSED_FULL:
 		return z_erofs_load_full_lcluster(m, lcn);
@@ -265,12 +272,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 		if (err)
 			return err;
 
-		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
-			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
-		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
+		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
 			lookback_distance = m->delta[0];
 			if (!lookback_distance)
 				break;
@@ -325,25 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
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
-	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
-		/*
-		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
-		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
-		 */
-		m->compressedblks = 1;
-		goto out;
+	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
+		erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
-	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
-	DBG_BUGON(1);
-	return -EFSCORRUPTED;
+
+	/*
+	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
+	 * than CBLKCNT, it's a 1 block-sized pcluster.
+	 */
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
+		m->compressedblks = 1;
 out:
 	m->map->m_plen = erofs_pos(sb, m->compressedblks);
 	return 0;
@@ -379,11 +374,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
 			if (lcn != headlcn)
 				break;	/* ends at the next HEAD lcluster */
 			m->delta[1] = 1;
-		} else {
-			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
-				  m->type, lcn, vi->nid);
-			DBG_BUGON(1);
-			return -EOPNOTSUPP;
 		}
 		lcn += m->delta[1];
 	}
@@ -429,44 +419,33 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
 	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
 	end = (m.lcn + 1ULL) << lclusterbits;
 
-	switch (m.type) {
-	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
-	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
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
-			break;
-		}
-		/* m.lcn should be >= 1 if endoff < m.clusterofs */
-		if (!m.lcn) {
-			erofs_err(sb, "invalid logical cluster 0 at nid %llu",
-				  vi->nid);
-			err = -EFSCORRUPTED;
-			goto unmap_out;
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
-		end = (m.lcn << lclusterbits) | m.clusterofs;
-		map->m_flags |= EROFS_MAP_FULL_MAPPED;
-		m.delta[0] = 1;
-		fallthrough;
-	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto unmap_out;
-		break;
-	default:
-		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
-			  m.type, ofs, vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_out;
 	}
 	if (m.partialref)
 		map->m_flags |= EROFS_MAP_PARTIAL_REF;
-- 
2.49.0


