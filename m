Return-Path: <linux-kernel+bounces-762530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3638B20810
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C6E18C4EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7492D239F;
	Mon, 11 Aug 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at4UkOvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46726D4CE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912497; cv=none; b=nreE0eMIRBDbVWGaUx+hYOTEzWnRtVdFKXqL6vXoOxRsIQ1LkIamfgXm7gphyHkkPZjKpkQpxl/r7kE1xWIOn2+IJvXB+uN+wTJnBECYPARFQmKw/EdUwzvUwjG0v+pfgo4RngKCjpmIgW6A/ma9xrpVlVOX6oc9KCMotRUrHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912497; c=relaxed/simple;
	bh=51wNWVQOpou5wJgNNVWp3dJSjpKJGs0ljeNl9exowZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YygmecmMgIcLLFXRZc8czPUyNwvB50zKsf7NyvdSvBR21ohY0b10B3SPHbZxG/OZ3TytPPpN1RBvCJhMYUDPVBTtGn62umlnszxB8aIdMEj6WnnI9Eit0jFg8SE1NaDayhI00NG/mK8pXcofHjj7acyJYioj1D0oQYY3iO0boqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at4UkOvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D1EC4CEED;
	Mon, 11 Aug 2025 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754912495;
	bh=51wNWVQOpou5wJgNNVWp3dJSjpKJGs0ljeNl9exowZw=;
	h=From:To:Cc:Subject:Date:From;
	b=at4UkOvhu5/i7kf4YTbu5G2eSt2vGZBwHhKkQcF2G3siDcTHHe+4CeujfX1t1SEeD
	 K5fhszitucY9WZVpI1WMTlRivcDhEcAN3j+Knns6ejx7ZxKqD922Xpaz9FWLLXK0+c
	 QiWEro5wWqDmOdpCh1dQeU5VQULyGzlArOPfjbi+dpX7RNg/bDD5AT7XQUQuGipdXa
	 n2Mz/YhTq9CUSrzlnrhFFtlecaEjL4PIJOPZmjY9SPJNHwj1Q8u2NWxFD98fQn6yeL
	 /uziq4A8HKR7sbUQCDOMt+sbO//okPwM32lLQ3wVYkoaWY0aXiLvyCxWViDZbIKUvh
	 1Q6pJbsDM2jxQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: clean up w/ get_left_section_blocks()
Date: Mon, 11 Aug 2025 19:41:23 +0800
Message-ID: <20250811114123.1085143-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce get_left_section_blocks() for cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index fdc2c34daa47..36427fdd6b15 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -600,6 +600,16 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 	return GET_SEC_FROM_SEG(sbi, reserved_segments(sbi));
 }
 
+static inline unsigned int get_left_section_blocks(struct f2fs_sb_info *sbi,
+					enum log_type type, unsigned int segno)
+{
+	if (f2fs_lfs_mode(sbi) && __is_large_section(sbi))
+		return CAP_BLKS_PER_SEC(sbi) - SEGS_TO_BLKS(sbi,
+			(segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
+			CURSEG_I(sbi, type)->next_blkoff;
+	return CAP_BLKS_PER_SEC(sbi) - get_ckpt_valid_blocks(sbi, segno, true);
+}
+
 static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
@@ -614,14 +624,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 		if (unlikely(segno == NULL_SEGNO))
 			return false;
 
-		if (f2fs_lfs_mode(sbi) && __is_large_section(sbi)) {
-			left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				SEGS_TO_BLKS(sbi, (segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
-				CURSEG_I(sbi, i)->next_blkoff;
-		} else {
-			left_blocks = CAP_BLKS_PER_SEC(sbi) -
-					get_ckpt_valid_blocks(sbi, segno, true);
-		}
+		left_blocks = get_left_section_blocks(sbi, i, segno);
 
 		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
 		if (blocks > left_blocks)
@@ -634,14 +637,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	if (unlikely(segno == NULL_SEGNO))
 		return false;
 
-	if (f2fs_lfs_mode(sbi) && __is_large_section(sbi)) {
-		left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				SEGS_TO_BLKS(sbi, (segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
-				CURSEG_I(sbi, CURSEG_HOT_DATA)->next_blkoff;
-	} else {
-		left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				get_ckpt_valid_blocks(sbi, segno, true);
-	}
+	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
 
 	if (dent_blocks + data_blocks > left_blocks)
 		return false;
-- 
2.49.0


