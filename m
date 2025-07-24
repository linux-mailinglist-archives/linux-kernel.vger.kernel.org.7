Return-Path: <linux-kernel+bounces-743734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F0B102A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618C67B45ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F657230BCB;
	Thu, 24 Jul 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkHIZ1eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7F2153F1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344126; cv=none; b=b/jgX8tQCyuEONgEV0XDrSCM9GPPlZnNUxaejW8yQF8g131poIDpz8x7Fwsn7ly8hiKEdcW8evQb5asGiMcZJuCDt0hMIDQS1BT/Gd3fIbMnO/buHGVy4La0ibUZ4gte+RIUITAwnu9/8TLx4Y8gljyFiMUmaImuqH3u9aY7AUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344126; c=relaxed/simple;
	bh=iaDPD72sMb6TfeJSJmsKI22EMCqu+G8KRwPlGUikTWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD9r57JDeapUzNnzJNksCjGgzpAf5sWC5CWuvdpQL1z15J+S7Grqg81kezYDoVlCJ7LcP/LOc+qXqyxPGXfLAH5HQq4tJP/rn1U4AgVW74G+HhzGUWx0HPknhTFxbSacieslPuucpmUZTEKCDtIo/SBtlJIBcrU8+GbEelxSP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkHIZ1eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE40C4CEED;
	Thu, 24 Jul 2025 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344125;
	bh=iaDPD72sMb6TfeJSJmsKI22EMCqu+G8KRwPlGUikTWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkHIZ1eY4lbR3/jhDmJ/9jvU1h4ob1ZYQYPdqR8zf+LWo8yfjJy6S3JrPPDOZo4BU
	 T6mrgZOLcTYWMkOb6zxwiVO5qI3tMU1951c185UUGpKMYFTyWyZly1878WAaqDEQ84
	 3TzdxaPumCVSxXvIJoL3QwbsfBAGT5kjJzBr3WG0kJxwycKCtATJfDQv/1KGDtH6Jg
	 L3dfO2sT8nwkvPYTOHa2xlVjJHifBGuYQ5oLuEOmMo8p4B6Tle2AanEvgeQgQqP9Ox
	 y1/pO8YKjoKYKsQ/e5+lQNdaIIPyf1Os0chqre+ICXb4b72Ujht5jLO/qi/Z69A2lJ
	 ULsC6bHwcoa5w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/3] f2fs: fix to calculate dirty data during has_not_enough_free_secs()
Date: Thu, 24 Jul 2025 16:01:43 +0800
Message-ID: <20250724080144.3689181-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250724080144.3689181-1-chao@kernel.org>
References: <20250724080144.3689181-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lfs mode, dirty data needs OPU, we'd better calculate lower_p and
upper_p w/ them during has_not_enough_free_secs(), otherwise we may
encounter out-of-space issue due to we missed to reclaim enough
free section w/ foreground gc.

Fixes: 36abef4e796d ("f2fs: introduce mode=lfs mount option")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2123645cf175..5e2ee5c686b1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -668,8 +668,7 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 	unsigned int dent_blocks = total_dent_blocks % CAP_BLKS_PER_SEC(sbi);
 	unsigned int data_blocks = 0;
 
-	if (f2fs_lfs_mode(sbi) &&
-		unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+	if (f2fs_lfs_mode(sbi)) {
 		total_data_blocks = get_pages(sbi, F2FS_DIRTY_DATA);
 		data_secs = total_data_blocks / CAP_BLKS_PER_SEC(sbi);
 		data_blocks = total_data_blocks % CAP_BLKS_PER_SEC(sbi);
-- 
2.49.0


