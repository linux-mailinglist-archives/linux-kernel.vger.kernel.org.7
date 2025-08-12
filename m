Return-Path: <linux-kernel+bounces-765082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26BB22B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6E164700
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AD32ECEB8;
	Tue, 12 Aug 2025 14:52:46 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E92EA494
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010366; cv=none; b=QORoy0hcW9yCtouQ3Y1DL7Lg5dnFve5Y4B86LgYvQRxrCqkM4X3evnH0RRNyD3mC3hYmW/9ZqO8iUpdMamBpfm+ROdrB47BaOpBqehy+NqCrbrMWat2LXubE6SKAuU/kWWbdB7D9ogdO3hrQfG/nbCRwj/VUXu+KzIh3jMNMXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010366; c=relaxed/simple;
	bh=k9ctZhc4mokvNOENdRBcjC6Dp/9kA8HiT2Ytp4Y9nQY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MdPatfxzQWTecXuBtGnPrNPnGpOwpiP+s9FtxACkT4S6km/VTqX9rB+h6xnPN6EDzLcgAHv9avcoOY6I+hqp11E2V6gVkG+sMmtmU77JBVpNAY2sxEw8UIoAYyFX7XILyvq2F24KK18DcENnRnkVrW1V079nYECvvU5EM5PLSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57CEqbe4091839;
	Tue, 12 Aug 2025 23:52:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57CEqbL2091836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 12 Aug 2025 23:52:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ff7dc567-1db3-4939-9b0e-77e91a8d898b@I-love.SAKURA.ne.jp>
Date: Tue, 12 Aug 2025 23:52:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>, LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] cramfs: Verify inode mode when loading from disk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

The inode mode loaded from corrupted disk can be invalid. Do like what
commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
does.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/cramfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..12daa85ed941 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -116,9 +116,18 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &cramfs_aops;
 		break;
-	default:
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
 		init_special_inode(inode, cramfs_inode->mode,
 				old_decode_dev(cramfs_inode->size));
+		break;
+	default:
+		printk(KERN_DEBUG "CRAMFS: Invalid file type 0%04o for inode %lu.\n",
+		       inode->i_mode, inode->i_ino);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
 	}
 
 	inode->i_mode = cramfs_inode->mode;
-- 
2.50.1

