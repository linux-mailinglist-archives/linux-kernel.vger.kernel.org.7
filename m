Return-Path: <linux-kernel+bounces-853858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC19BDCC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789FF3B6F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D153128D7;
	Wed, 15 Oct 2025 06:45:12 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AD313260
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510712; cv=none; b=EcBG0OzOBg1E4g2Sj/sZHHz1SIDXcneImvDQcF3Ws41gwvpQb4DroAJ5sGwRAI5Z3p/Vca/KaBxjuEfp+EiElWFimXblbaHz+KPQ9P8R0WA9T1jrCnj/FvBJ3h2YWM/1HGchw54z/FLj1fdkrGB56DY8ojqtdLROWUFgpGEmw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510712; c=relaxed/simple;
	bh=3lASPHjG4j+oazMSCIU77VQWHw8pDPkPIIeliWHUARU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qVOOtQn6Envo369H9Oo8dJVJa8OCH6yoOYCgzao3KqwplnxkUeuMR1jdTNRqJKJ5N9GHcWvLONJHfPj2w95J1GjoHI2QgOoYV+qyleXnB4uyK1ZxdlO9Shls7/tWLBCivo6+M1lnsoefhykJr1rDoArWylnUi4TyhfXXuLMJT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f90f65922so112127615ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510710; x=1761115510;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKf77kmViLg0HSX/TWeb0BbwS+kVSLfsM9DAP1VaUiw=;
        b=FUg0mp+k2WfkuMZkfeLGbDqiYMdHJQCzEC6Vo+cqbC3j6Drv+do1KDh3ZUT80OEugG
         WnxcQvqHlGn6bxULwsILw9DQggXiXb5nmMTcVV1Bhp/POK28a9vX9Mg2CS+WaKcfpfXJ
         rSXTg1MiX51Xh1E/nSQcaqku4RbrC2UUdCSGWvvDCcRcTAI0md+JaG581u4kDpgKmDoE
         gc3EjQtNGI3HqP8DiuWtKu+RQApE021SeXwMeRs7dvpxPFx/EtZ6Iq09B4VZoWod4c3j
         JMugYbPRxxeOC5eydzMpzp7fuxmakmgNW1eBmUS255HnZ2RFv5yAnD9rIrBO8q6KMKM8
         I3hA==
X-Gm-Message-State: AOJu0YzBC28OxO8/wjy4jbFGBmpzyp8bcMdPTuN7D0fvo468WD66TwfC
	R5OJOcTp8H9EyzTkOlKJRnyFC9NXX2Buw0j/gvcUZqZvdjOSqD+v4wZ3ACxL64kTnMVnvkDg8ao
	kt4lUx7na1wtqYrVskfOPnTvOmt6d8jezttOMsWCqab4FCP1zy4HX0tklOMg=
X-Google-Smtp-Source: AGHT+IHP9+IqCevJUobyEpWvndvh9Roiel99R82uO7CtjQvv4ixvM6vdkORUkccTaGZ+IQjSUBlyq7Pw5l+Nechmh3oihLlVjMkF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:42f:9eb7:7595 with SMTP id
 e9e14a558f8ab-42f9eb7762amr182467635ab.22.1760510709883; Tue, 14 Oct 2025
 23:45:09 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:45:09 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef42f5.050a0220.91a22.0232.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: validate chain list count before use in ocfs2_reserve_suballoc_bits
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: validate chain list count before use in ocfs2_reserve_suballoc_bits
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master


Add validation to check if the chain list count (cl_count) is zero
before using the chain list in ocfs2_reserve_suballoc_bits(). When
cl_count is zero, the cl_recs array is empty, but the code attempts
to access cl_recs[0] in subsequent operations, leading to an
out-of-bounds array access.

The issue was discovered by syzbot using a corrupted filesystem image
where cl_count was set to 0. This triggers a UBSAN array-index-out-of-
bounds error when ocfs2_block_group_fill() attempts to access the
first chain record.

By adding this validation early in ocfs2_reserve_suballoc_bits(), we
catch the corruption before any allocation operations begin. The
filesystem will fail to mount with a clear error message directing
users to run fsck.ocfs2.

This follows the existing pattern in the function where similar
validation checks (like OCFS2_CHAIN_FL) are performed on the
allocator inode before use.

Link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
Reported-by:syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/suballoc.c | 8 ++++++++
 1 file changed, 8 insertions(+)
---
 fs/ocfs2/suballoc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..57ec07f9751a 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -778,6 +778,7 @@ static int ocfs2_reserve_suballoc_bits(struct ocfs2_super *osb,
 	struct buffer_head *bh = NULL;
 	struct ocfs2_dinode *fe;
 	u32 free_bits;
+	struct ocfs2_chain_list *cl;
 
 	alloc_inode = ocfs2_get_system_file_inode(osb, type, slot);
 	if (!alloc_inode) {
@@ -800,7 +801,14 @@ static int ocfs2_reserve_suballoc_bits(struct ocfs2_super *osb,
 	ac->ac_alloc_slot = slot;
 
 	fe = (struct ocfs2_dinode *) bh->b_data;
-
+	cl = &fe->id2.i_chain;
+	/* Validate chain list before use */
+	if (le16_to_cpu(cl->cl_count) == 0) {
+		status = ocfs2_error(alloc_inode->i_sb,
+			 "Chain allocator %llu has invalid chain list (cl_count=0)\n",
+			 (unsigned long long)le64_to_cpu(fe->i_blkno));
+		goto bail;
+	}
 	/* The bh was validated by the inode read inside
 	 * ocfs2_inode_lock().  Any corruption is a code bug. */
 	BUG_ON(!OCFS2_IS_VALID_DINODE(fe));
-- 
2.43.0


