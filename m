Return-Path: <linux-kernel+bounces-730823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A32B04A68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC97B07A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94B277CB9;
	Mon, 14 Jul 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHHEnw5l"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA5292B25
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531367; cv=none; b=CgYaeMcnr9KI4zG5zW5Mxw/FyzgdFJbIUJ86esTt/spjrdOBvtANjWgPWggzQ7uZ/EjFSyh90fKMR/606ReuBTMxLhFXqtiRqx0GmZczFUmQ56CVaaUzlfudAX7D7fOf7z84X2G1ORa9/QS99HZB0gWAv3OSiH0wk4CJApH8Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531367; c=relaxed/simple;
	bh=x4i3F36zur0SCPEBSIihXNVHrrhQtaP9gSe3rusIcKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOd154YJ6RZIau2hwg0lmzk1vGh2703wkqfuRll7skJB1pObBmTY4SzbG6BzZgYNTm1u47jRFq4apNlX1YrWg/EUI7rUNyNSETurPGPUbl4BsRKxpxD1P4JU1W6j0GlXibM22MO6oA+Kwd6kMJLPyBnwmxqJtYUGmsq4oJRo6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHHEnw5l; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31393526d0dso3468284a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752531365; x=1753136165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOrDcippQTVHdM8Im6lXJg7pxH380YZvu5sA6YJz/hM=;
        b=YHHEnw5lfvjWHsNbJs5OqEaiIsRB028a3VoVd4pu0rJoJaCOhieL/lEmN7GzDYf/Su
         v04d+PhLSreSOuWwaALUV7lqeaQGKhaZy2+/6B9yLboo9plIfoiRUkvyEtrPhAnoN/Tc
         pykM8Ymcxq2E80eyvssDAWTODrN1/biIYf5lLw45pNJv83n0MrU4RzF+uxGZWgSSq9dy
         rf5QIa3/QJvoix2XzoONoWXypnQQKN3wJGhXxg0bedWzHIKcccFaRZ8pcfBgSGyWbqXX
         dQZhIA1tX2FP+BBMHOL9FfWhj35G0O4/axTK+bzAKVRqCSVAM+22pl8Il+XimgHYdg7z
         u98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531365; x=1753136165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOrDcippQTVHdM8Im6lXJg7pxH380YZvu5sA6YJz/hM=;
        b=og4o5/VXCwY2m/HWDuJD4L9YH2QFBaScmwAVtcnu93XaDsU1BFsluTO4GVO7/oJECb
         nR0I3z2SgijL2IJdPmHsIAQbVwq0GZdY73liag4yLOR9zUM80OrQlV32vCD/PXisINdt
         7CgTcrDEROqKWUtuf5sUL9QwaW5i3yJnA40wWLRNEsauJYp3ne7wki8J778AK+HTsSUu
         wgd1UN/UvbMOA9w5DQZkHqjDsP5Z/SrBP/ZRtdObOnXfn6o3TC/bMWYi/awlxcA0p2AY
         ch0Vt1VpYTRjJqRROtlQWZEm/GAO5KDPXU3FbLYHUz3RFHh/LY2AqyMnKeFHvDdvSJ8N
         iNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTLdJuIIHBrLkyZ3gz9OElmSG5igciFcKvzRJ0aRPPQpbR45pdkxj1uc0SmMAdcylgpD/sbLIRWMaqDW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUSydOktTLi4s+hLF1Z45Lnd4c5VhHpnn2M5MAGzMZudwQwxw
	zeh2nJISIhR8By1ltcQdi6Lhu8+l/KOgazNaCnmFcYi11lvm8d6fFDXl
X-Gm-Gg: ASbGncvswSFHKDj/GaPvrlRsWlMzbx8HisWwW33+zU6s9+oIx6t78QuZY3azVyIC4jZ
	ij2yFFxM32oqq1OT/kV5kgZoWv1uP6IUzCKXlLucNqXFkJVs6MsOM3NoynBneJe0NSyWssXPejF
	tvvjAHY5uwlEaqO2dB/ne000ZTstN8YbfoWD+Ckjp+jJIX0Wj/XcEcNBS6MGxIFhCPd8mNCYf2M
	s0rXi9ToMMYFIqj6yzLiGMmSRFx0UFwygaE5Z5E0h8DaAAGTIsOfXDfW0G52ROmtBVhuzQCj2hu
	g+6aI8Qnr1wqvtPhCrPPD0cxEJJR6ZtpS9XovcVc6Te0mGVJRVa5S5gzFk/aHUTn97ztOE/vD6r
	tf61F+Jz1Wz8n5imKKsXehFF+uM909f+5j3dGnI6E
X-Google-Smtp-Source: AGHT+IGEDtw8J5mq4n3QR7e0NMdWhjFjPhLHYhyib35yYfZ/xubqWOItnQ0j+sZBQfSH0+Dy1wDpHQ==
X-Received: by 2002:a17:90b:268b:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-31c4cd65841mr26348729a91.18.1752531364522;
        Mon, 14 Jul 2025 15:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:96:9a2a:564d:ba07:e7f5:17b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003f96dsm13821273a91.2.2025.07.14.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:16:04 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: fix lock acquisition order in refcounttree
Date: Mon, 14 Jul 2025 19:15:32 -0300
Message-ID: <20250714221552.4853-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Acquiring the locks in refcounttree should follow
the ip_alloc --> ip_xattr ordering, as done by multiple
code paths in ocfs2; otherwise, we risk an ABBA deadlock
(i.e in the start transaction path).

Reported-by: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
Tested-by: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com
Reviewed-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/ocfs2/refcounttree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 8f732742b26e..c8467b92b64e 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -928,8 +928,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 
-	down_write(&oi->ip_xattr_sem);
 	down_write(&oi->ip_alloc_sem);
+	down_write(&oi->ip_xattr_sem);
 
 	if (oi->ip_clusters)
 		goto out;
@@ -945,8 +945,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
 	if (ret)
 		mlog_errno(ret);
 out:
-	up_write(&oi->ip_alloc_sem);
 	up_write(&oi->ip_xattr_sem);
+	up_write(&oi->ip_alloc_sem);
 	return 0;
 }
 
-- 
2.43.0


