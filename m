Return-Path: <linux-kernel+bounces-806952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA2B49DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884DE7ADE1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F71DF748;
	Tue,  9 Sep 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxPv38FP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAB28E7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377639; cv=none; b=F3HWQXLWynhShyVuogXP8rgpp+W/Sbj8OYb5KwL4EOyOWn/wz0OZk41c2GCOHL7aL+b92cYvPLA+WCZFEnsiA9xRLtajBuoY+A7PyOAlgUDsLDWZKYNmcUEm/xtjI3rdVACvJREJ/xRIIdLTKAby+zWR/4GuR+LGQ1EBZhXMAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377639; c=relaxed/simple;
	bh=ymn40pBf8LMcuZYP5kWQIkMelBS3xU8pf1c4kutJg+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHb/czYDnWNPDQpWa5or/xQQX5e58zsv3gJD7H8C5bQuDl8ghcrwUMNbdev/0JwlXVw6fjwsAcF+l6Ap42PDIm8Uy9nMqv8KO+ZILf7UYIVTsNv0aCZEhJ3s999So5nLnz7qN/QbPpslYPVlaHibOcBkQtYzkzoVWK+BcBzQKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxPv38FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016C6C4CEF7;
	Tue,  9 Sep 2025 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757377639;
	bh=ymn40pBf8LMcuZYP5kWQIkMelBS3xU8pf1c4kutJg+0=;
	h=From:To:Cc:Subject:Date:From;
	b=rxPv38FPv6SzcgcaBlO1bOGAT+bYTKL3t+lXi3OMJaHpcJzeM8aRP+mxubyO8Bbdx
	 PfXK/7M8yXavlrAnYLglfGqYEThc7Osp6bSCp48hW0Zo1XvYBzjQYUdzaRuoJnrT1o
	 UD7ErKQw+elPr9lU3a6LMvnX4cFvX1MvKVw+lesgjZIvE0gJjx2h2wuMRnW3+X38N1
	 80PgsqYcLF3xyt54bHmwxxunLWZu7vuw7zMr19y3+WW1861xRrxD9T7N5DSTnJUmEb
	 papeGFYceQiNK0FEnpjjLg9h3PM6zUwI/ab0cCYlPZFQr3OEWVBvEc2U961dIzgfBl
	 b4RGQ3gyxqxtA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong layout information on 16KB page
Date: Tue,  9 Sep 2025 00:27:17 +0000
Message-ID: <20250909002717.829981-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes to support different block size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 081b5df0e664..7992386fb9e6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1768,12 +1768,15 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	seq_printf(seq, " Main          : 0x%010x (%10d)\n",
 			SM_I(sbi)->main_blkaddr,
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main));
-	seq_printf(seq, " # of Sections : %12d\n",
-			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
+	seq_printf(seq, " Block size    : %12lu KB\n", F2FS_BLKSIZE >> 10);
+	seq_printf(seq, " Segment size  : %12d MB\n",
+			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
 	seq_printf(seq, " Segs/Sections : %12d\n",
 			SEGS_PER_SEC(sbi));
 	seq_printf(seq, " Section size  : %12d MB\n",
-			SEGS_PER_SEC(sbi) << 1);
+			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+	seq_printf(seq, " # of Sections : %12d\n",
+			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
 
 	if (!f2fs_is_multi_device(sbi))
 		return 0;
-- 
2.51.0.384.g4c02a37b29-goog


