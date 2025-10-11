Return-Path: <linux-kernel+bounces-849167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B6BCF53F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FED19A0F68
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0FB22A4F1;
	Sat, 11 Oct 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoWCtBkk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91B1DA3D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185824; cv=none; b=DUB0OyYKuiqGECVDjDVvagAxk4z5vrZdCIFUc/7CxeadgGbm7nEEfb/AhG6+Km2snivnVplgKt79VSkS1LKGdgp6TJnQE3cTd3e6+UQmIJL4wXwT/EZ++dOHq+4UZiS4+qWhvOny9oABn5HehwuyYbSeGsV7v4TQLM280E5Olmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185824; c=relaxed/simple;
	bh=fxrRNcuem9wyVJRqfPuA5LjA0AcsQ/z/YFKiVQDFmoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evrQgFBk+Xt2/uwhauDXlxAF43twqBFhP8IXtUFDLE41mMc7uA3Msle/Op9EPtbw14DgsdK4xA22uQysZ0KD19y1kbhdHREXmVuH8dNpT+P7V7fQ0J36eJJUY60tWh7uIqfU5R0elUzlRE+6I16yq2KNNdy0qSI1A1O7iirqof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoWCtBkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE92C4CEF4;
	Sat, 11 Oct 2025 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760185823;
	bh=fxrRNcuem9wyVJRqfPuA5LjA0AcsQ/z/YFKiVQDFmoA=;
	h=From:To:Cc:Subject:Date:From;
	b=UoWCtBkkMQ4g95l7Yx4y078CQOvHsjKgzIOj+gUu03u83pXy/yXtiDDb7EuPZyaTv
	 h5KjJi2iTuj7mbSu4OH0DKxrxHViM9JoHTCNhO2amYuNLywwBpd9DVJz48Uj6Ft0Tc
	 0eIrSflYWPrqH+MXokZeWZWWJ7KPrgzDD//Kd6Vd7u8w/RLcb86z9ICmnvUFjQTIa0
	 qvZpLkZ+De4pb7d/tK3h5mMNVdGPnhzjRhonUxo3ujaMHOQrKT6ujtf8IYXGEs2kvY
	 Ka4d3zkuSWlCxrovlopSdFdV0oLXMdbFH6pCinT5/hvDvKbXgbreK14mjPh0AyaByC
	 R1tXS1xCwk24g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org
Subject: [PATCH 1/2] f2fs: fix to do sanity check on node folio during its writeback
Date: Sat, 11 Oct 2025 20:30:15 +0800
Message-ID: <20251011123016.715964-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add more sanity check on node folio during its writeback, if node footer
indicates it is an inode:
- i_mode should be consistent w/ inode
- ofs_of_node should be consistent w/ non-xattr node

In addition, if sanity check fails, let's shutdown filesystem to avoid
looping to redirty and writeback it.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f2625..2bb9e6d35080 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1504,20 +1504,37 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
 					enum node_type ntype)
 {
+	bool is_inode;
+
 	if (unlikely(nid != nid_of_node(folio)))
 		goto out_err;
 
+	is_inode = IS_INODE(folio);
+
 	switch (ntype) {
+	case NODE_TYPE_REGULAR:
+		if (is_inode) {
+			umode_t m = le16_to_cpu(F2FS_INODE(folio)->i_mode);
+
+			if (!S_ISLNK(m) && !S_ISREG(m) && !S_ISDIR(m) &&
+				!S_ISCHR(m) && !S_ISBLK(m) && !S_ISFIFO(m) &&
+				!S_ISSOCK(m))
+				goto out_err;
+
+			if (f2fs_has_xattr_block(ofs_of_node(folio)))
+				goto out_err;
+		}
+		break;
 	case NODE_TYPE_INODE:
-		if (!IS_INODE(folio))
+		if (!is_inode)
 			goto out_err;
 		break;
 	case NODE_TYPE_XATTR:
-		if (!f2fs_has_xattr_block(ofs_of_node(folio)))
+		if (is_inode || !f2fs_has_xattr_block(ofs_of_node(folio)))
 			goto out_err;
 		break;
 	case NODE_TYPE_NON_INODE:
-		if (IS_INODE(folio))
+		if (is_inode)
 			goto out_err;
 		break;
 	default:
@@ -1751,7 +1768,11 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
-	f2fs_bug_on(sbi, folio->index != nid);
+
+	if (sanity_check_node_footer(sbi, folio, nid, NODE_TYPE_REGULAR)) {
+		f2fs_handle_critical_error(sbi, STOP_CP_REASON_CORRUPTED_NID);
+		goto redirty_out;
+	}
 
 	if (f2fs_get_node_info(sbi, nid, &ni, !do_balance))
 		goto redirty_out;
-- 
2.49.0


