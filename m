Return-Path: <linux-kernel+bounces-758612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED30B1D161
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4313BC6B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DD1D86DC;
	Thu,  7 Aug 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l40uR5VH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB61B0F1E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754539239; cv=none; b=Y6ZvC+2b0g8ncqoL330nbcDdfTF8eqmBgEDn4j2n1dV+L26EI97xi++W5OklUDdC36H2vgVL6QU0ROMsNRiFIuN2i1orPPLGTpLJ8clKAk+oBj4pT5NbCsqrFAyTLL+hKy5XawHzVdFZiDQYNkZ/VvJwTLGDigQVIOJcvI+MYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754539239; c=relaxed/simple;
	bh=kBwCJJlDyKVKUDaMrt/cerX2ZHziG6F/f3hxF2St+1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m71NxC0xVJwc4b1LxPEULt8WS6D6tAaPcP3T6Fc3KlpJFsxEiU/gRbg4BSCVah9KgesWyzz9G9hCryttk++7YvyP7bMmt3CnD4Zupt9WpfKO4sOvV+1rR26fw8DjoF7Z3+9xBZj5d2X4kfbU6g48kWRsVGMUn9hfuskMNDM58dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l40uR5VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE722C4CEEB;
	Thu,  7 Aug 2025 04:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754539239;
	bh=kBwCJJlDyKVKUDaMrt/cerX2ZHziG6F/f3hxF2St+1c=;
	h=From:To:Cc:Subject:Date:From;
	b=l40uR5VHvjl0QJ0mcyoepwYCOUS1PQJeuPBmTapo4/kKENrOGFpUO/dR5gQdosvP0
	 2apjnAR//pEulEI4yg2FomDR/cNvEzJtBxOlFU9qVd8Jxu9z5taACiAybI6fRc67xn
	 IYxtp19mCamrLFsHqDQSCp1avMfyn6QXiGFLYT5VyYvScCCzk8rL96/Y+tg3Kqtw54
	 0GemrBh4hayOo5/nrpmw8/OqIRgteztm3c9klfnUeG3ckL+yA3CMAj7Gb6K7GtU8bM
	 UhgTptW8yJOOw3t84GMryMgbDDgEPyC9einFH1gn0BxJ5GcVPESYTYVHYk8pUXB5mP
	 VBOB931cELULA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: add timeout in f2fs_enable_checkpoint()
Date: Thu,  7 Aug 2025 12:00:25 +0800
Message-ID: <20250807040026.3834543-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During f2fs_enable_checkpoint() in remount(), if we flush a large
amount of dirty pages into slow device, it may take long time which
will block write IO, let's add a timeout machanism during dirty
pages flush to avoid long time block in f2fs_enable_checkpoint().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/super.c | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 464dcbf5c32e..df4466e652cf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -275,6 +275,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
+#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
@@ -1406,6 +1407,7 @@ enum {
 	DISCARD_TIME,
 	GC_TIME,
 	DISABLE_TIME,
+	ENABLE_TIME,
 	UMOUNT_DISCARD_TIMEOUT,
 	MAX_TIME,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c1f45df9efec..411265c75698 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2623,16 +2623,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
-	int retry = DEFAULT_RETRY_IO_COUNT;
+	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
+
+	f2fs_update_time(sbi, ENABLE_TIME);
 
 	/* we should flush all the data to keep data consistency */
-	do {
-		sync_inodes_sb(sbi->sb);
+	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
+		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
 		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
-	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
 
-	if (unlikely(retry < 0))
-		f2fs_warn(sbi, "checkpoint=enable has some unwritten data.");
+		if (f2fs_time_over(sbi, ENABLE_TIME))
+			break;
+	}
+
+	sync_inodes_sb(sbi->sb);
+
+	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA)))
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data: %lld",
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
@@ -4229,6 +4237,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
 	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
+	sbi->interval_time[ENABLE_TIME] = DEF_ENABLE_INTERVAL;
 	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] =
 				DEF_UMOUNT_DISCARD_TIMEOUT;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
-- 
2.49.0


