Return-Path: <linux-kernel+bounces-766112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224EB2426E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD08626CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154E2BE629;
	Wed, 13 Aug 2025 07:17:57 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC81D5CD4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069477; cv=none; b=CzM5eFMo5fEEw5PDexG81RMqUQvqDSjaKU7HB1uaqsnRZOMpYY8UO0VIhy1wa9mYeGRzuH0BEDDr1c3p2bo42dSVDjuxG/JgAuDsBOutBBHIBHM8dzemxlmoqW4MA7LNX8AqySCZBTCbj3EhVgviFYBjLcsgg8hYM+Mn47POdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069477; c=relaxed/simple;
	bh=yx5d22O6GS87qKAd0DQ2odvf7pYBa8UK2MQ7XPuXfkM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UffIjTKpkU+VuJIkWZKD5ocwuYkXJ/nxwRw5MWwVAGgNZGvUnCVYHTaXJTNHacEd6hrO/GEqcVXEOI+zYpM+/sibe/tpjKVApVOyriBCF3nV6pfuvevwIRaela0UcdmbTfNQ8WzGtRLUL+ZOIsQl0ZRS4woTAUBua3KnG9uynZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57D7HhlX016523;
	Wed, 13 Aug 2025 16:17:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57D7HgPg016520
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Aug 2025 16:17:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f63d8d11-2254-4fc3-9292-9a43a93b374e@I-love.SAKURA.ne.jp>
Date: Wed, 13 Aug 2025 16:17:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] squashfs: Verify inode mode when loading from disk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

The inode mode loaded from corrupted disk might by error contain the file
type bits. Since the file type bits are set by squashfs_read_inode() using
bitwise OR, the file type bits must not be set by squashfs_new_inode() from
squashfs_read_inode(); otherwise, an invalid file type bits later confuses
may_open().

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/squashfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..dee8fa016930 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -68,6 +68,10 @@ static int squashfs_new_inode(struct super_block *sb, struct inode *inode,
 	inode->i_mode = le16_to_cpu(sqsh_ino->mode);
 	inode->i_size = 0;
 
+	/* File type must not be set at this moment, for it will later be set by the caller. */
+	if (inode->i_mode & S_IFMT)
+		err = -EIO;
+
 	return err;
 }
 
-- 
2.50.1

