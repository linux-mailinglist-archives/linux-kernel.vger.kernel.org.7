Return-Path: <linux-kernel+bounces-824837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D8B8A40D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECEF47B94F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883C3191B3;
	Fri, 19 Sep 2025 15:23:57 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881DE2F83BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295437; cv=none; b=Rw4FpIYBqdXnL42m2N64uqy+0QS6u4fhNtmmQCrl6ZLYxND4SPKozY65gQmzWLXYplbSjFLq1I4zixVvrmySq3V+dvlqZ8JW6skII1QzGM0EB4ZBWo+1Tz5KgjZ1/UqTepdwFJjuB7z63RlhEx3tItqm4EbV0C0kSyROv58DIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295437; c=relaxed/simple;
	bh=XYFLZHbK/28IoooDQT4/+7sWTHWXrNPCcSz0tmVI7PE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IwOKP71uPBmhAGoFkzEgKJ8dtbRI35x/gJWxmQR05vv1oTTBeWxKC06I6l3dOxNEdu5ej22F6qc3e/kst09OdBd6gA1tx+7tdYXUJp667/jc6MMj9Rt2Kqc7TdsW7aSRMdayYa/f9NXbMFqR/bRdqgk4PsqZ1G/VbGTorF5QG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42407a5686fso29337875ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295435; x=1758900235;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9j0tA4IkJfqex716ma0GkhBUR4lpo1QH74hq1wKlws=;
        b=e7BhrBlNaOFqNo36Ea0fY2A3Aay0KNbrhsuFPB+XcH6kClen9PfoNI5LUwKCC7EIEw
         bnglWhwopHedufGYQzHAn8FxSJb2kkd0Qpp3H/sWM8UORdewf8Wk5NzIfhFl24DamSFn
         Q7YazpFEyonwZUrB6lqKmHbQYBw3gJ0LGnAqwgwYPw6vjpAWLD6bZoT2QVnD7f2rn2lR
         mytOjyv5HmJRSKdrk3gXdCZu0nD8TUwDF0WcT2VJKspgSkCNzIiZLYR3XdOK1wKriCeF
         PZLgSY1/QgPvsuB+VsYI2HYpxUR/yWt8fR8fYiGqb42MaV9wbNX+bfdrdK/a0Pw0CFKc
         01oQ==
X-Gm-Message-State: AOJu0YySAoRi6rNwRMzzANnw+6uc5Xw+8cOQv7bW5y0VU7YGXmRpVshj
	CeNGEefV+72yXs1veOgBRUqDKkVJGlRTPuoAac7Ytf57VHdZAN/ScBIuL+ZRvyF+8YOpw/qEo34
	KA6nuFKR9KOl+anHyWpwqyP9eENb+lU28LEY5WC32MYcOs0lLw2QDSj+4KCDSyA==
X-Google-Smtp-Source: AGHT+IE64ilsRf0MhIUMba0qLRxkJJcc2e4WtCNB+KG4IfQ7V0eUEeLKBykI74XAgyVjBEmnsMQ0Yj550AxIpIwICjumb+2CBoJy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:424:7f01:c0d2 with SMTP id
 e9e14a558f8ab-42481999e4cmr68565035ab.27.1758295434757; Fri, 19 Sep 2025
 08:23:54 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:23:54 -0700
In-Reply-To: <67d9cf78.050a0220.3657bb.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd758a.050a0220.13cd81.0002.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
From: syzbot <syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
Author: pedrodemargomes@gmail.com

#syz test


---
 fs/jfs/jfs_dtree.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ab11849cf9cc..c200b37f4562 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2129,11 +2129,17 @@ int dtDelete(tid_t tid,
  next_index = -1;
  else {
  stbl = DT_GETSTBL(np);
- ldtentry =
-     (struct ldtentry *) & np->
-     slot[stbl[0]];
- next_index =
-     le32_to_cpu(ldtentry->index);
+ if (stbl[0] < 0 || stbl[0] >= DTPAGEMAXSLOT) {
+ jfs_err("JFS: Invalid stbl[0] = %d for inode %ld, block = %lld",
+ stbl[0], (long)ip->i_ino, (long long)le64_to_cpu(p->header.next));
+ next_index = -1;
+ } else {
+ ldtentry =
+ (struct ldtentry *) & np->
+ slot[stbl[0]];
+ next_index =
+ le32_to_cpu(ldtentry->index);
+ }
  DT_PUTPAGE(nmp);
  }
  }
-- 
2.43.0

-- 
You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/825ad453-7347-4af7-8a14-3aaf678c83a6n%40googlegroups.com.

