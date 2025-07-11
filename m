Return-Path: <linux-kernel+bounces-727030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE914B01427
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4DB5A337A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03891E51FB;
	Fri, 11 Jul 2025 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1d2b/OG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4D1E51EA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218101; cv=none; b=PTEpAsV+QpwcvjKF1IHxyN3nXVx4rtE1BjGI0FHPPXwcU+xPcrkwVSAQTI4n0vO5uN/V6Dvk6xtXyv23pX/3NOaLpprhncp4guKTB75CWJc96EeHmOY/vgWTwKXPbw+P/TW4f8iTxUM3V71TbC3ayqe3lNexzuut57W2s/eyxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218101; c=relaxed/simple;
	bh=LYUnlcYQnWCTsg1aj82TguyO32RcRYUeONZaChGaCJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2bNUxZXz5qtgYDp/asO2XqRg2I4wwpGSR5RElO079YEXV/shIVw5W3lF3uyqu7zIZci1By/tW0dzDtaV9cqdgmb8jUj2tMjlzvy0xohS2vfT3kqMRkCylFZTFHkY6js+UBLcdpRkJPDUxn/onlN2A+3JkN860ftFIsgMZURmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1d2b/OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99509C4CEED;
	Fri, 11 Jul 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218100;
	bh=LYUnlcYQnWCTsg1aj82TguyO32RcRYUeONZaChGaCJY=;
	h=From:To:Cc:Subject:Date:From;
	b=K1d2b/OGNdgkm5rLx5K8x5P4J0Hn5PcYJTz5zTjCkBFbNUuByIbBp7wJ2EqZAIm9k
	 K5kVO0rc+jtE4GJ7H6E0SvKV6fEphptwoQnZuDYON0wRR0HfygjvUCH7pcHvKZ7wzv
	 kyUT8BUap4aJElFn0y0N+SHOvxxDiDSTEyFnponRQK9SPELQKdrmoBIS/MEXnkZy5P
	 XFmj3rF7RPftLb4nHgchIcNPDPQqf18f+zsW3vW2ih0OE8D0EOg5Wq45Bekn87TKjD
	 PNKKMnGUsWhVrgGTv6u6trhB9PlfLOmgVKz1qc5ZGvv+uX3DovVYm+WMs8qWLawOAX
	 ravwo3h4x7Cmg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid out-of-boundary access in devs.path
Date: Fri, 11 Jul 2025 15:14:50 +0800
Message-ID: <20250711071450.207302-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- touch /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- truncate -s $((1024*1024*1024)) \
  /mnt/f2fs/012345678901234567890123456789012345678901234567890123
- touch /mnt/f2fs/file
- truncate -s $((1024*1024*1024)) /mnt/f2fs/file
- mkfs.f2fs /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  -c /mnt/f2fs/file
- mount /mnt/f2fs/012345678901234567890123456789012345678901234567890123 \
  /mnt/f2fs/loop

[16937.192225] F2FS-fs (loop0): Mount Device [ 0]: /mnt/f2fs/012345678901234567890123456789012345678901234567890123\xff\x01,      511,        0 -    3ffff
[16937.192268] F2FS-fs (loop0): Failed to find devices

If device path length equals to MAX_PATH_LEN, sbi->devs.path[] may
not end up w/ null character due to path array is fully filled, So
accidently, fields locate after path[] may be treated as part of
device path, result in parsing wrong device path.

struct f2fs_dev_info {
...
	char path[MAX_PATH_LEN];
...
};

Let's add one byte space for sbi->devs.path[] to store null
character of device path string.

Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8cded45cfbc7..64996153e4c8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1289,7 +1289,7 @@ struct f2fs_bio_info {
 struct f2fs_dev_info {
 	struct file *bdev_file;
 	struct block_device *bdev;
-	char path[MAX_PATH_LEN];
+	char path[MAX_PATH_LEN + 1];
 	unsigned int total_segments;
 	block_t start_blk;
 	block_t end_blk;
-- 
2.49.0


