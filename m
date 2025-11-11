Return-Path: <linux-kernel+bounces-895341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B04C4D847
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72FDF34F8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE3357735;
	Tue, 11 Nov 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsIlg9UR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD50350A3F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861962; cv=none; b=mLXd21vpM0AyQnwoh24nmEWBLpLfxAR09v8y9eFnr901lVETSANwzUcYbfovxJckeEUXPd+65jr4OVtC5wmOD6sjUKjJmewvJNj9Jj8T+HoPO9vCs2ZChgiHywOrAuxFlSSI+qiR8yH/yEt/dhXt2vBZ6v8fEMsYfclQlrIJLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861962; c=relaxed/simple;
	bh=f6RcoELmzojj6s6Tg/noSowPetDGuPHU0f5LoaPLD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7SSy11wAyiH0lhqtNPX4QQOi/ifCnxHB/P0UbXP+88oLzgNUP4Sd/qeuqr9Ap3cT9CDe395CdZ8ryjJAnRWhDA4bUUnksGs5anePpB5O2OPr2yhCUlTCQ0F/kzIyLzmR9afhj4/t5/SN5U9uzvEoWgWhE5DOf3PCX8BzWG1uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsIlg9UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56582C19423;
	Tue, 11 Nov 2025 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861962;
	bh=f6RcoELmzojj6s6Tg/noSowPetDGuPHU0f5LoaPLD7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsIlg9URmd5Z32DmwfJllCOqoT4FFNMrnIOQpTunvJgHxOGWaXwm4UYd8PztkT1Jz
	 v2iD7wCWOpWjrVTXF/DFIdRztCnzfRBUZGuuEr8Gplt6vGjjm8oQ7K2mR2zbCBTXce
	 YA5HSI7jin3x1KD7XZLRuEIQxLV5FiZwFtZ3oM1UdeUp837MXeVqHccA4PlpO3rifq
	 dmIokR5pPUYGaOcMLobqGpbDpR4J5xUHpKYy1VjgTTvIMOE0URKvwwd7AmGfVxsWQ/
	 C02M6HnS1QB/20qc6aX88xvSqCToNklNa9H2xpg7RBPnnLg/Fxi3P73bqU0r2oGY5i
	 VQ/jyIzkFvD7A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: change default schedule timeout value
Date: Tue, 11 Nov 2025 19:52:29 +0800
Message-ID: <20251111115229.1729729-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111115229.1729729-1-chao@kernel.org>
References: <20251111115229.1729729-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch changes default schedule timeout value from 20ms to 1ms,
in order to give caller more chances to check whether IO or non-IO
congestion condition has already been mitigable.

In addition, default interval of periodical discard submission is
kept to 20ms.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 6 ++++--
 fs/f2fs/segment.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d0e0a01a659..74cbbd84f39b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -407,6 +407,8 @@ struct discard_entry {
 #define DEFAULT_DISCARD_GRANULARITY		16
 /* default maximum discard granularity of ordered discard, unit: block count */
 #define DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY	16
+/* default interval of periodical discard submission */
+#define DEFAULT_DISCARD_INTERVAL	(msecs_to_jiffies(20))
 
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
@@ -656,8 +658,8 @@ enum {
 
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
-/* IO/non-IO congestion wait timeout value, default: 20ms */
-#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(20))
+/* IO/non-IO congestion wait timeout value, default: 1ms */
+#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(1))
 
 /* timeout value injected, default: 1000ms */
 #define DEFAULT_FAULT_TIMEOUT	(msecs_to_jiffies(1000))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58a5d6bc675f..d146c5816912 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3462,7 +3462,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+			f2fs_schedule_timeout(DEFAULT_DISCARD_INTERVAL);
 			goto next;
 		}
 skip:
-- 
2.49.0


