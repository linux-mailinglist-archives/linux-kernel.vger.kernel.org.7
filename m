Return-Path: <linux-kernel+bounces-897371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CDFC52D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508C54A60BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50F2882CD;
	Wed, 12 Nov 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmb+KeaI"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637F289811
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957219; cv=none; b=sR/mBe2i70webqq1kZFISm0jmXGYZd0kYmSX9Pt8CnlQgpwPuLhZPXI6kZv2+OKIi88E5uNziOFQ14irbt8sS25HJBVxmsfe0PfvGQ5UUBc/Qz/4nZpgBuY16mms3Xk8DV9l1dVgGwMiUkCcWtdu+tGUjzj+dpB1BPSeAIVn4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957219; c=relaxed/simple;
	bh=PLEsEAFhjPh2pioJvZvoAHlFGMw3+0W/MvVkutfYANE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIPy8eRnNsOYlQL/tZ/e0nDo2nGNQexL7Cm/blnNg6Qcj2XQkjas42rh50+fZr/2/Ksi6odcrrLn/j23n9tr6K0juLedHP2S2p13WoA3qJn0TtXnV3FVIjm+lgcj6Wmv4MYgKYcbcn1dE1izmdzW5Zm+0xbqDvGQjJItDr3BT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmb+KeaI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88f239686f2so83615585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762957216; x=1763562016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=23Yna8J3d3mh9gPmuO4K36N9DnURcSnrYweW3R/KSeg=;
        b=Xmb+KeaIata+2GuSfT5pWgt7616+mGmfA9/5lpVvqMk3jftOZ4BXDmisrbRVSY6ffy
         DGDauS0V6u8p0y7D4CBaSpRoNFPamiYDX9XmELpQJ/QDpsy0R+7LFgkVsPPO+mCk7m2c
         foldaqKnqI3ygbwTW7OByzQYQAk6WeI7Dm9AYYFE7hYpDxL1zw8q+E4LvLpp0s8Z5GhO
         zfclY68WLagXpChGp1mUwMgLvoJSV0O+erL4YL9yrqsosY2TwtcRdFYn4EZhv02n5Ivl
         mbYj+v/hEQ86ItA9lmyrtVDe3qyNbqYsYQE42C/oeS/BX5ziy3bDeZxMZ8sSNPTp077A
         jNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957216; x=1763562016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23Yna8J3d3mh9gPmuO4K36N9DnURcSnrYweW3R/KSeg=;
        b=dXWBE3RPY1T3BRIcWNfh+GGSjU/D7+facjFIMUVOWT4h+j2+Zt75c9npXGUMsm1CVL
         NuKNFbLs/uyHBh0zccl1kwMAcgiZ/Lu50g/dCN16nJU/y2QvOswtlB50npwmK/UlOkHU
         t7+pIjDVhx9EMX1VKWa+1kiM//1yatmVaZLQanCIUa0/OMPkPLvXzR+dFQsCCUy5gTHM
         QRto4/4KRHvAuVsv84HNJPmSEDkbkYw5CRcmPbCuc402t8uOPL8mKK1px2TVzEX4vu5v
         frvrRSZc7/Bsq2kRwVff6YgEfZCfgkq+CAUgtXM6QOUoP6wnk01sZPoTUyAs53Af9ljH
         +MWw==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ4Cdka6s5d9U4OGAE02RvNkt1mDfHlzRfQACsNPz+WBdf87eTbm/ajcOmSqOcu4Mcde7DrtQxHPKWoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dyVJq9TwKoqXLvZZ0ysovxIgJD0OPa3D4O3yH38Gs/Mfh1ms
	ghYXMNfD0IIGFCf6pxxYuj7CcVL/eigbd6Q4JNS+HHe3EYDidEiasiJp
X-Gm-Gg: ASbGncvD+uUcB1MtLxBnOQ9Txa745WJFgAbraUFL5FEnSrZbswokDUpsryp2OIv8ncY
	QHLYHBx7Tt4BOG6ktUpTrA86KpSu5jwWeQmHQ08fV+Uk+TrXh65m4f7alJghNXlTiX7WrrZG3ZD
	zF8qeqyXbKrx7IYMIn3E76YjEyJdHRZjs/+3ELckSYSLAAXMJMMfarUfuWRoCrXcoJX+GA8GhNe
	jy6T7FqFDJw5p+xJ03I/XakL4qmYf2Vo6qS3hxPmR6PVfysJw453h8QaWkb8SokN+lSxLPxC632
	KD0elbHUXGQmqtplHQfk+s6QG1C+9neuuK9009hET1VCLK6kUbt4+xQZ2WkzouQmsfm5MrJ3Mtr
	tHi3G6ROAPBtHaiJtKi1d7w6VZo6WBV2t8EMD7XMHoOQ40WtdcEE8YVtBQeb8LZP1fDDZPS3/CF
	hn5d4jU0dlhrn3UfyM9yat
X-Google-Smtp-Source: AGHT+IE//gkdyNvrQQM5f0E3fJn6m5YN9A3KpABhw9zY72kYOdyBFwY0fArMYvrWnTVYGlxGj7DiIA==
X-Received: by 2002:a05:620a:458c:b0:8a1:87f8:6632 with SMTP id af79cd13be357-8b29b77a7fdmr423471885a.32.1762957216282;
        Wed, 12 Nov 2025 06:20:16 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84ae06sm202417785a.12.2025.11.12.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:20:15 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: cem@kernel.org,
	djwong@kernel.org,
	chandanbabu@kernel.org,
	bfoster@redhat.com
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] xfs: ensure log recovery buffer is resized to avoid OOB
Date: Wed, 12 Nov 2025 09:10:34 -0500
Message-ID: <20251112141032.2000891-3-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xlog_do_recovery_pass(),
commit 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
added a fix to take the corrected h_size (from the xfsprogs bug
workaround) into consideration for the log recovery buffer calculation.
Without it, we would still allocate the buffer based on the incorrect
on-disk size.

However, in a scenario similar to 45cf976008dd, syzbot creates a fuzzed
record where xfs_has_logv2() but the xlog_rec_header h_version !=
XLOG_VERSION_2. Meaning, we skip the log recover buffer calculation
fix and allocate the buffer based on the incorrect on-disk size. Hence,
a KASAN: slab-out-of-bounds read in xlog_do_recovery_pass() ->
xlog_recover_process() -> xlog_cksum().

Fix by removing the check for xlog_rec_header h_version, since the code
is already within the if(xfs_has_logv2) path. The CRC checksum will
reject the bad record anyway, this fix is to ensure we can read the
entire buffer without an OOB.

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Fixes: 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---

Can xfs_has_logv2() and xlog_rec_header h_version ever disagree?

From my understanding, whenever the h_version is set (e.g. in
xlog_add_record()), it is set to 2 when xfs_has_logv2(), and 1
otherwise.

 fs/xfs/xfs_log_recover.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e6ed9e09c027..08d7b25c4ab1 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3064,8 +3064,7 @@ xlog_do_recovery_pass(
 		 * still allocate the buffer based on the incorrect on-disk
 		 * size.
 		 */
-		if (h_size > XLOG_HEADER_CYCLE_SIZE &&
-		    (rhead->h_version & cpu_to_be32(XLOG_VERSION_2))) {
+		if (h_size > XLOG_HEADER_CYCLE_SIZE) {
 			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
 			if (hblks > 1) {
 				kvfree(hbp);
-- 
2.43.0


