Return-Path: <linux-kernel+bounces-846966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AD1BC98B4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9043AB021
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D82EAD0D;
	Thu,  9 Oct 2025 14:36:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C204246774
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020581; cv=none; b=CtJOlZ7goXw9f5y8NgZmpr0d/N6Y49YsLFL3oOFt73ESK95cBKijX6nLYYB0hI+RKJyjx+Bfd6cYSkwl1jteHX1o354sIBB9YqBL9xfEWJ6gSqyKMJOYhPimYdIrcpji6X1cPSyOMQMDb4yESKD9/OD66BWGA6akrt0FBDYl+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020581; c=relaxed/simple;
	bh=s33areDPTCAkau2kcoh5nmm8/D7zDW2jg7Vs/Rk5Nf4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmvgv14bkp61/wMaaQ59veISv8WpJqCRE2gITveHT7G6YrQtInHx9TvtUSA61yy2V2Wv09EUUGPPkRpelEtFcr533Z62Qlen1hwehIs/pa23xPAqdEVSk/OVSCMgr/EALcI8ewX+6E/bs20oXjh1oTNnAoPdtC8tXnJNZV0idxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so199871939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020579; x=1760625379;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmKYTRlaUrpEyhYKqVsjM+t7Gaa+oP0ZiRWMlGL3PKg=;
        b=pT0vteVfHLRdAMcHU4Vw8xFiyq6CFaWARhTTrm6eF7GJThI3kKUW8fMFym2om/DhuB
         /SV28dxkLjpCGpo/hPSecapZmXgNZ+9Hpii3lKGroel/Sh1frg27zahJbe64ZYIJfowd
         RylHWT2redn244zWQU8mzz1neXKY6B+F1CdKAQDfuSvHyWJY8975etTjhbc4iHrXh5AR
         GDHbyXBh01eR08X/5FSQNQqTafCVupD8wZ2QCq3kzJjPP+rEhBXSjve9fyD2vbQXTPtY
         /kCkHv1cZ7xrwuJ6Xxp8uPATIXfToc+OKpy0XQDvmsbZChEjA0mz7HtyTlJF1F6SduDn
         +LHA==
X-Gm-Message-State: AOJu0YwP6IZgNjMjz7lz65w1SX9KqmZGH3+scIfOPGGr3pldzRO6w+g3
	L1/+sNqPL7uz82LYwyNlM8bGexCjxJTq5dl/b9ULXP8g66bkW1RnklT4tEG/7r6thMGxBy807bf
	UYtkUwv3shDHIyH+9xJ4tVneH/0gKsLohMxDMwsSyzUbazVl9TBKRps7Pdek=
X-Google-Smtp-Source: AGHT+IFecMBKlTSqFFzFFvdD6oj4nLbbWwBd9pI2LW53hxytNd0dWwmRF3JVlwP79a+ptQpTFbegx+fX4qeEQTfuUZYpLk1ZJB6m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b03:b0:93b:ba4a:3b67 with SMTP id
 ca18e2360f4ac-93bd199182emr797813839f.18.1760020579132; Thu, 09 Oct 2025
 07:36:19 -0700 (PDT)
Date: Thu, 09 Oct 2025 07:36:19 -0700
In-Reply-To: <68e0b136.050a0220.2c17c1.002d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7c863.050a0220.91a22.0006.GAE@google.com>
Subject: Forwarded: [PATCH v2] ocfs2: clear extent cache after
 moving/defragmenting extents
From: syzbot <syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting extents
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

The extent map cache can become stale when extents are moved or
defragmented, causing subsequent operations to see outdated extent
flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().

The problem occurs when:
1. copy_file_range() creates a reflinked extent with OCFS2_EXT_REFCOUNTED
2. ioctl(FITRIM) triggers ocfs2_move_extents()
3. __ocfs2_move_extents_range() reads and caches the extent (flags=0x2)
4. ocfs2_move_extent()/ocfs2_defrag_extent() calls __ocfs2_move_extent()
   which clears OCFS2_EXT_REFCOUNTED flag on disk (flags=0x0)
5. The extent map cache is not invalidated after the move
6. Later write() operations read stale cached flags (0x2) but disk has
   updated flags (0x0), causing a mismatch
7. BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED)) triggers

Fix by clearing the extent map cache after each extent move/defrag
operation in __ocfs2_move_extents_range(). This ensures subsequent
operations read fresh extent data from disk.

Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=2959889e1f6e216585ce522f7e8bc002b46ad9e7
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/move_extents.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 86f2631e6360..10923bf7c8b8 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -867,6 +867,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out;
 		}
+		/*
+		 * Invalidate extent cache after moving/defragging to prevent
+		 * stale cached data with outdated extent flags.
+		 */
+		ocfs2_extent_map_trunc(inode, cpos);
 
 		context->clusters_moved += alloc_size;
 next:
-- 
2.43.0


