Return-Path: <linux-kernel+bounces-853758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB30BDC8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5AB94EE222
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5628980A;
	Wed, 15 Oct 2025 04:46:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6DE7E110
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503608; cv=none; b=cN/NVdng5dHraAlxH9vbiREt1R7/OT9HvufW+4adLbcPwRVP5/KH/7aU2IPmnwbqcNL6/A+9AfFDZskW9uyKdIBC5fmZyP9zirowimbqelsv5cJAOY0tB2/Jkhzn/7shCOmrH52aqtQiXcoUGTC2vHaSvfWKRYmk0iKvQiWg/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503608; c=relaxed/simple;
	bh=TPK9LXOZxTHGKBO9He4YnEMvGmD+RsQMTh42dYV2IXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HI+gSOFVVACQZp1zQu6oarPnXm1aSC1dTXElp3Pxa9Fon8TVu9irhqxAJfCvmov50Fuc14KvJl8QtQe6VLEwMa4LVvjnlZBGOmtoq3/0DFY5OuY3FV3CYSLDTVGfOGhTq3vk9BqIo3Xvg4st4HI7l9l2qaFGjaQ9pEZv0JhbJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f86e96381so155539795ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503605; x=1761108405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK8kYxoISMvpl1XU8oilgeIwNa4kbIU55Xz+t9ghUSI=;
        b=IcGIo72kal/QMivJWzeca8yShDRDVhObHRBdNuEb+ik/e+/HWxeCsN468TmMuc1mRZ
         7MOi2cgVtR6yaO8GaGUoYnmOhWcD/DMYLyY86Af7BR8d/9elguZXNrPFtk68zshCLRbQ
         QV77V/G//v6sXU5VNxm54bUimlRBPxSWYiacCvJYUxRchrVhDud00OS2YSN6e8tuHWma
         EdKHJnJrZt3HfSb8lXIdmY1Ot9mKuVVliz57y9pbgxwpSrueGHbU/GjhGJygrHeUyW6F
         jJDhLhEkYY06vWeWoGtvyHUHpetZFpWCtUiUgUDjZFeFxkr88oRgndtxO1BFeMM+C3v0
         E0Ag==
X-Gm-Message-State: AOJu0YxaG9bKf7RXvuAS0Sgl2xHQ/wVmryyiBMyF08AcqjJdO01bS/8n
	aiWXT878VXcb/+NvwdbD3YAxjfxMM75BPmgVKS5MW5R66mkE5yUgEzQ4shtBRwhtkQmkK72sNbo
	FwjnuNwlAB3Pk46QhTqApHkVbUa7n5J03GU23tG5sjYO+1dMuA5Mmh7KGKUw=
X-Google-Smtp-Source: AGHT+IHGhPKZ0juuB3F0zG8JAulc7bm2I/yM01QuVXmmElCsW6PnpvDy29yp3vU459A0mjWvQwENI20FzVBeLces2ocQgplFJvko
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:42e:7589:6290 with SMTP id
 e9e14a558f8ab-42f87377de2mr303599765ab.12.1760503605675; Tue, 14 Oct 2025
 21:46:45 -0700 (PDT)
Date: Tue, 14 Oct 2025 21:46:45 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef2735.050a0220.1186a4.00a4.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: add validation for chain index in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: add validation for chain index in ocfs2_block_group_fill
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Add validation to ensure my_chain index is within bounds before
accessing cl->cl_recs[] array. Without this check, a corrupted
filesystem with cl_count set to 0 can trigger an out-of-bounds
array access, detected by UBSAN.

The issue was exposed by commit aa545adbe491 ("ocfs2: annotate
flexible array members with __counted_by_le()"), which added
the __counted_by_le() annotation to cl_recs[], allowing UBSAN
to detect the out-of-bounds access.

UBSAN report:
  UBSAN: array-index-out-of-bounds in fs/ocfs2/suballoc.c:380:22
  index 0 is out of range for type 'struct ocfs2_chain_rec[]'

The fix adds an explicit bounds check at the start of
ocfs2_block_group_fill() to validate my_chain is less than
cl->cl_count before accessing the array, preventing the
out-of-bounds access and properly handling corrupted
filesystems.

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
Fixes: aa545adbe491 ("ocfs2: annotate flexible array members with __counted_by_le()")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/suballoc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..dd58cc0f9838 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -353,6 +353,14 @@ static int ocfs2_block_group_fill(handle_t *handle,
 	struct ocfs2_super *osb = OCFS2_SB(alloc_inode->i_sb);
 	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
 	struct super_block * sb = alloc_inode->i_sb;
+
+	/* Validate chain index before accessing cl_recs array */
+	if (my_chain >= le16_to_cpu(cl->cl_count)) {
+		status = ocfs2_error(alloc_inode->i_sb,
+				     "chain index %u out of range (count=%u)\n",
+				     my_chain, le16_to_cpu(cl->cl_count));
+		goto bail;
+	}
 
 	if (((unsigned long long) bg_bh->b_blocknr) != group_blkno) {
 		status = ocfs2_error(alloc_inode->i_sb,
-- 
2.43.0


