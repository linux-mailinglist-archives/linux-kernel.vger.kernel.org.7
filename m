Return-Path: <linux-kernel+bounces-748974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB8B14845
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7C33A8031
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3FE259CA5;
	Tue, 29 Jul 2025 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6s1Ikuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26C204C0C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770813; cv=none; b=LbQS9uXUjMK5xf+eeAGVdTKfFzImZHrk2loyio1EpiCYRoKC19zkGXGB+lLOKaEBWFc4TcGwXNxGSAoBiiYFDQaf1hbn0GUjeUfnmF6NP+Umqh3igv/8SUxmsV0s0xkQ0DYDs9hIV6NTx0hfm0rXBoHewa+3/b7bRdeaKhT8ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770813; c=relaxed/simple;
	bh=CAt7BzvgHdL05a36U0ED1tXU0zxEy6nbl6IWT8d6sFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owulBelDFrxAphqEy7gXMb6jBmOq/t+vXNt2i0OYcxCb/c1JASCYEb3krz0L3cnfm0r1lZ19co4KFZGLn/gy49LeVkiB7pERcPCTMqoue32KtMUSlgSZDDguzIXnm4knblWtyb7nYWxxkcw5uqoMLKdsEDXPGquIsOVg/xueNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6s1Ikuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D81C4CEEF;
	Tue, 29 Jul 2025 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753770813;
	bh=CAt7BzvgHdL05a36U0ED1tXU0zxEy6nbl6IWT8d6sFw=;
	h=From:To:Cc:Subject:Date:From;
	b=h6s1Ikuyvu0PTURNbv04+uOa9+pe221MQud4cDKAOGduAwtQUnyRHgffZCFPPNs9U
	 DuP94Qo9QJlHMxhJFGG+/MQgoOQvvDZz6aXKiZX04t0nvwWpJ4HJ38SjuHp9xN/YQh
	 ALf6QNAiPCUa6ufpOeWMwx/bDZz6uqmUqYMSGMOqKGoDoon9pFbWX+sgKnulZxJEj6
	 3XEa+/v4nlC9EA6yDa9VJh/wcbDwwg/eBriiIkUbMNL0InjXqrG+eDhuRL0RQpwG2Y
	 nOPqKYOBHGIjA3GhWznNYA4vDEWUopo1902WMI7vI7HQAGqUBqEUlY/25gDlkWbQtD
	 gSEXLdXrPwjhg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Jan Prusakowski <jprusakowski@google.com>
Subject: [PATCH] f2fs: dump more information when checkpoint was blocked for long time
Date: Tue, 29 Jul 2025 14:33:25 +0800
Message-ID: <20250729063326.435167-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/299 w/ mode=lfs will cause long time latency, let's dump more
information once we hit case.

CP merge:
  - Queued :    0
  - Issued :    1
  - Total :    1
  - Cur time : 7565(ms)
  - Peak time : 7565(ms)

F2FS-fs (vdc): checkpoint was blocked for 7565 ms, affecting 1 tasks
CPU: 8 UID: 0 PID: 1614 Comm: f2fs_ckpt-253:3 Tainted: G           O        6.16.0-rc3+ #406 PREEMPT(voluntary)
Tainted: [O]=OOT_MODULE
Call Trace:
 dump_stack_lvl+0x6e/0xa0
 __checkpoint_and_complete_reqs+0x1a6/0x1d0
 issue_checkpoint_thread+0x4b/0x140
 kthread+0x10d/0x250
 ret_from_fork+0x164/0x190
 ret_from_fork_asm+0x1a/0x30

Cc: Jan Prusakowski <jprusakowski@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++++++-
 fs/f2fs/f2fs.h       | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index db3831f7f2f5..b0dcaa8dc40d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1788,8 +1788,15 @@ static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
 
 	spin_lock(&cprc->stat_lock);
 	cprc->cur_time = (unsigned int)div64_u64(sum_diff, count);
-	if (cprc->peak_time < cprc->cur_time)
+	if (cprc->peak_time < cprc->cur_time) {
 		cprc->peak_time = cprc->cur_time;
+
+		if (unlikely(cprc->peak_time >= CP_LONG_LATENCY_THRESHOLD)) {
+			f2fs_warn_ratelimited(sbi, "checkpoint was blocked for %u ms, affecting %llu tasks",
+					cprc->peak_time, count);
+			dump_stack();
+		}
+	}
 	spin_unlock(&cprc->stat_lock);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46d23c2c086c..3130ca6a4770 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -350,6 +350,9 @@ struct ckpt_req_control {
 	unsigned int peak_time;		/* peak wait time in msec until now */
 };
 
+/* a time threshold that checkpoint was blocked for, unit: ms */
+#define CP_LONG_LATENCY_THRESHOLD	5000
+
 /* for the bitmap indicate blocks to be discarded */
 struct discard_entry {
 	struct list_head list;	/* list head */
-- 
2.49.0


