Return-Path: <linux-kernel+bounces-895252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A2C4D5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBEA3A9108
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB33546F0;
	Tue, 11 Nov 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xW/aTHYW"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C8354ADF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859450; cv=none; b=V+6xzOiYy0cOlR+bkjI1UcAaSVCTu5TCTvwK0Pp+HuSvWKqXV4pAlPJL5Mvr2ZBou0+GaFnlGoSUM/wA1BHfR1Gjr3WiVaxK9KDOh/IuexadrygMvP+aKPSB4OsTD0pokDtvY9SNNJXxyvePUASrxLFjhivfct/1nA1y6dCZjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859450; c=relaxed/simple;
	bh=NGZY7D8PfbiFbd887TvButBPycC3r7BwVEmdgLETi1E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G+xxzDtZgyXXrjY3vatXKp2mIFKof0brTcmamJ6Ug+I/fQmMkMfF+PRy0kPJWVnKjYHIjmXpaK+Wg5wCcsomDTiuyZRo15Cuy77hv48ub4D94Y2YFSs0ytGd8pzEhWoG7rHFCF+5wHlr8CPvKDQ8Bo7d6/kBqUTW841Cuc0BTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xW/aTHYW; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762859145; bh=5KM/czTHkFEHND165zBXo4h8LPx0eIm+WQx5hjmuObY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xW/aTHYW1x4ZRti5PsqbAPZF25ISvbe2qgJ6GmpJmfZPhpdpCbA65riVx7Ss9pJx3
	 ytYs97jPDCJ7BEJM3K1hedaKvqI8WvEg0k7B9pBkOybXuuazqBlJQA2qRVcjbFdCo7
	 5beh5Lzl4lsf2PpTz77AS/hZQkJsDlIsm2hSNPNs=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 169964CC; Tue, 11 Nov 2025 19:05:41 +0800
X-QQ-mid: xmsmtpt1762859141tr7uwxdsx
Message-ID: <tencent_F07E963236A64B34744177E3672A3CB93609@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe0yCjW11OIF5FklWQl0wX+LOZc/f+cvUuOiQe/CgaqrlUaSvhyq
	 k+p+l9joDQveK7VnTuHD3QhthEaJ95H14ovtl22FaTJuM/7kolcxFwHZ+ljMAgZ6EDp2JZzwuE5M
	 PRGgX1WXpFQFe8O/HGXb6ekmgITxcMRSJo7+FA28NqCJKqHB62vLB3bZtE2xrC2FRYS92Uj0xO9T
	 xUgBXD7zN9p3MOjRGSYEequpybtNra2coHVecSMnrDGfbN+/EdASTMcA5Np8OEU9rZyPQ5LmHaLO
	 MD42mYGidXHjKonP/Hi7WY0+oYWN9mfT/lHfDLR7A6P8v6hdcqVOt/yxu1ZLEiEjex+9iWzyGIZi
	 iDg/T/SnQ0prT0CrvfAK17Ndv8+unHe573RhggVuxzE2zAdCxns4qTxZYRviFCr7wKU3jh0YqLRy
	 c5+CD95tKj71dasvRrq/wXdDgILZVfAdC+9vx1Hcc4ZvShCqAlsTVNkvHjE8DIaoj21s5qyTgaYi
	 0I7si44lWF5xZhUi0EKEOGrxBc1A+hd5OL94u0XlNcvtf/PzktEE43lCAZj4L1VW1H01Mj2vYl4o
	 4CBS75Cf+GHfaT3N0G5TdBN+N4Kx8mfo9ZjzbdlDOlZCOb0y5Ew1VjI6WSXY9HtZ7hOsB/dxSUTk
	 SUI8qkGFpZAYp/XVWv2GoSICmBixSiYUj55BGZVJVQPtHsZMx6HAkAIeXwo8EeytUXRGqwZv7aV1
	 Eu0Z0ahueQzhJ2zI+BlCTtPjpgCTxx8+NIZ6XGhW34xtQNAVwMdoKEBs4H3GFszkNoHzcqIgNTTl
	 KYRe8GW5JvkLZdkdJeWD2ITnz0l1Rb9u2pd/HZwH7vzymdQDSKsAysb1GB9MF2msCNyw6WQwiZfv
	 HPdi6B5KD8sQ6wvxjBRN1Pk/J28mwQLQxLEaeTQJtusvUL8ltOTp/o6GjV/I6/fQ3pRCjDbt4j7p
	 jnKFhTGIikeSjfyKsqUwB7c8IyROEamD7t5m2n2CvVWMR4KOjCyg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 1/2] fs/ntfs3: Prevent memory leaks in add sub record
Date: Tue, 11 Nov 2025 19:05:42 +0800
X-OQ-MSGID: <20251111110541.2266435-3-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
References: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a rb node with the same ino already exists in the rb tree, the newly
alloced mft_inode in ni_add_subrecord() will not have its memory cleaned
up, which leads to the memory leak issue reported by syzbot.

The best option to avoid this issue is to put the newly alloced mft node
when a rb node with the same ino already exists in the rb tree and return
the rb node found in the rb tree to the parent layer.

syzbot reported:
BUG: memory leak
unreferenced object 0xffff888110bef280 (size 128):
  backtrace (crc 126a088f):
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715

BUG: memory leak
unreferenced object 0xffff888109093400 (size 1024):
  backtrace (crc 7197c55e):
    mi_init+0x2b/0x50 fs/ntfs3/record.c:105
    mi_format_new+0x40/0x220 fs/ntfs3/record.c:422

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/frecord.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..b6cbc1fc3455 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -325,8 +325,10 @@ bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 
 	mi_get_ref(&ni->mi, &m->mrec->parent_ref);
 
-	ni_add_mi(ni, m);
-	*mi = m;
+	*mi = ni_ins_mi(ni, &ni->mi_tree, m->rno, &m->node);
+	if (*mi != m)
+		mi_put(m);
+
 	return true;
 }
 
-- 
2.43.0


