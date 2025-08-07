Return-Path: <linux-kernel+bounces-758578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7288B1D0FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DC55628D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939E1C860A;
	Thu,  7 Aug 2025 02:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq/MaPLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB3199949
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534678; cv=none; b=CuQhRa7AsrZaBFm1PMc1eWO3JF4QclCY5Js/BZWNO/sfyxRlFcvjKCsUDgK26UwDd/r+UY7nPfyiUPY1WNispED6DM+/xFeoeGN460v4R68OdwIYiEbzF0oh5OkYrx3JfY3sma4357atQbNS78G2ZpIuS74b7YnryDWChNCPPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534678; c=relaxed/simple;
	bh=c9pOcEq733xsT46pnT71jjNVyY0UXgWUHpI7NDDAkFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkAhWoo4vK2FN+U3M6oLoESvX61JwYPusaQchN1JP04yXw6qQfETyFf012PhLpjJZnbkHNWF0Qi4PPildwLSvuQtTQ7fM72UI3Q4JNq2MJwfGmR4k5gAwT5EKRoMKKwLGNtPQ45ptAnDxpA6E6BeJ91H4EEyYYjB69Vb4AkIZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq/MaPLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5495C4CEF8;
	Thu,  7 Aug 2025 02:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534678;
	bh=c9pOcEq733xsT46pnT71jjNVyY0UXgWUHpI7NDDAkFg=;
	h=From:To:Cc:Subject:Date:From;
	b=jq/MaPLF3kzXUvUxqp9OPWs3Nzvxyc64oiZrObh2md7bM5Noq3cptH8zoIE6Jdlft
	 1+fUsO8lHrhIO/jn6Wgslcu8+K3jEV3gP4/AdGQW5b6zP2PLTDsY03KorNhFc2ZdVk
	 4bA2IKAPBmk9LYERasyCX3pi8iOYaBLy99+L+qv/JX+51UC9mxA9IoCAcvUvgHG60s
	 +QsCLt9jzxZ+SnEzjzyPzZ2CPpvY3HNIfuiDayTER1Mo3jhgKtomXOyxVNUXIdd3Du
	 r3hd/U7H0R/iSiNienhdajtzzngV9JKOQe7f4xNlyu8py8oZS8UQKKAqa/nK9PMDMa
	 yIClP7oiW5JZg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to detect potential corrupted nid in free_nid_list
Date: Thu,  7 Aug 2025 10:44:31 +0800
Message-ID: <20250807024431.3805293-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported, on-disk footer.ino and footer.nid is the same and
out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
any potential corruption in free_nid_list.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c          | 17 ++++++++++++++++-
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 27743b93e186..286e8a53f8e7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -27,12 +27,17 @@ static struct kmem_cache *free_nid_slab;
 static struct kmem_cache *nat_entry_set_slab;
 static struct kmem_cache *fsync_node_entry_slab;
 
+static inline bool is_invalid_nid(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	return nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid;
+}
+
 /*
  * Check whether the given nid is within node id range.
  */
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	if (unlikely(nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid)) {
+	if (unlikely(is_invalid_nid(sbi, nid))) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: out-of-range nid=%x, run fsck to fix.",
 			  __func__, nid);
@@ -2634,6 +2639,16 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
+
+		if (unlikely(is_invalid_nid(sbi, i->nid))) {
+			spin_unlock(&nm_i->nid_list_lock);
+			f2fs_err(sbi, "Corrupted nid %u in free_nid_list",
+								i->nid);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_CORRUPTED_NID);
+			return false;
+		}
+
 		*nid = i->nid;
 
 		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 2f8b8bfc0e73..6afb4a13b81d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -79,6 +79,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_FLUSH_FAIL,
 	STOP_CP_REASON_NO_SEGMENT,
 	STOP_CP_REASON_CORRUPTED_FREE_BITMAP,
+	STOP_CP_REASON_CORRUPTED_NID,
 	STOP_CP_REASON_MAX,
 };
 
-- 
2.49.0


