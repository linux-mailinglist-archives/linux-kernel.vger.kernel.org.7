Return-Path: <linux-kernel+bounces-819462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97328B5A100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48087AE9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDA32D5D4;
	Tue, 16 Sep 2025 19:10:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F262F261B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049806; cv=none; b=mcuaNhk0Um640+sibZL0wh6Xpkow6B0+7p5ffw09CIx4ztRBolAyCyF5P4dBi8Mwpy1c7icBkprBs1yFGQqxyAvFQsUAEzU/ODryCBQaCLVrFjUkK/ttE3EYBxCtaA2GUCkJZrPTz48SsJ6kewQ3/pIQ3dEWA+fCK7C7hZ5WnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049806; c=relaxed/simple;
	bh=nM6DpWsueZkUbDDfvkR4rDHXWEICHV7P289l+Lw7Mr4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OWyGuLDF6wKKLU68Kk2Rr20XVWbs+WfmuqCp/mHm3cZ+qcmqCXeWpdApc3RAnQpxQyRAr0NBFBUJG+5cLtGbSGjQ3M3qAkzp9q3f1BAkrY3riTQJnP4ong7OrOX134cC3GTaT90pGqkmOdoqayBwVMOmiAiGG/IPtrYNKlivlUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-424122b50aeso11735725ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758049803; x=1758654603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNkw8a3ojsvCsHpIE7q9bdjplgTl+UjdQk+nrThjcjk=;
        b=vGxRKh/8dalHC+PLEYZ2SOgiKp0yMWveyKuYavDAssJAUi/wC+dLmHfOykOgT9eSd4
         4CmbBX0DsBDlNjDlUVGXqcvJ2sX1cQp72jRNg+157q4cfC622J2xm/sSLX3J+7rX5f7e
         4WuBT/l5/DSS9aP0zfdCPOdBoCBFtmCN1LCLLXCBk1BlTSzHxkt/CGWc0qpo5xCXFiSq
         SKpPGebAAt+5YrnLmw+f8dw2DbO/KkLIfkoDwg7EBT8GMYpJWHxAJ3H85awBmPGoct3W
         ZyoVkj+YJY5zz6X85Dhyh7NQCxyRRZt8gx3HceWdW1PxWFANPLJkiSezpiw5Z4VXnyCI
         oxkg==
X-Gm-Message-State: AOJu0YxEqQTRwOFaQEqiHYHROwix8ir97rpKerBEr+4XKza4NTDb3KuB
	4/5VsnpJjpJjMy088o+WS3xK3dlrR7yNx/ylQ72ax4+ql4cCUq75HAO4rvZY5qXw2MCW0wNfnGj
	wLfD35uZz0JPLO8uVw9uwwVQTCULBqsBkyAO08ZtPifZzSlDzIPVvmfsirFU=
X-Google-Smtp-Source: AGHT+IFhlPNozhd2AGj94QBxW3FnYHNHxOiuwNhsk6uAwLNIY48M1sBTcv5KkN4mfw7EUm2UY+NrRdxV+lwMiBG3bUHG3Uy8XCMn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:423:fd07:d3f0 with SMTP id
 e9e14a558f8ab-423fd07d535mr88139905ab.26.1758049802911; Tue, 16 Sep 2025
 12:10:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:10:02 -0700
In-Reply-To: <68c85874.050a0220.50883.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9b60a.050a0220.50883.001d.GAE@google.com>
Subject: Forwarded: Sending for testing
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Sending for testing
Author: kriish.sharma2006@gmail.com

#syz test

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b677c0e6b9ab..5fdde7d4a393 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2284,10 +2284,21 @@ static void dump_holder(struct seq_file *seq, const
struct gfs2_holder *gh,
  if (gh_owner)
  comm = gh_owner->comm;
  }
- gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
-       fs_id_buf, state2str(gh->gh_state),
-       hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
-       gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+
+ if(seq){
+        gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
+    fs_id_buf, state2str(gh->gh_state),
+    hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+    gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
+ }
+
+ else{
+        gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %p\n",
+                fs_id_buf, state2str(gh->gh_state),
+                hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
+                gh->gh_error, (long)owner_pid, comm,
+                (void *)gh->gh_ip);
+ }
  rcu_read_unlock();
 }

-- 
2.34.1

