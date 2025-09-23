Return-Path: <linux-kernel+bounces-829430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C4EB97165
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E5618847E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B7284B42;
	Tue, 23 Sep 2025 17:47:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51B189
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649666; cv=none; b=EPlUUPBXBHU/3e3JU+W6fMHpGN4upMBImfR+5Q1Ol7Dgno3Cq9kFwKRMc5ZdOc0RSwHNBaCF4Xuwrc862yW1VUf7bpOKcD9lG8lWk/+IRthiEmZtpInpFIqapgSEZ7Aoo3K79p756lojVG5RNlIeetKiF/SGevBilNugijjLqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649666; c=relaxed/simple;
	bh=NYhVbLQmCiKAkkw+FgLiYG5boqLHzYRj7IsPHhe86tQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ud/CC8DNv42TrLPUDe4HVSk+LKgH0JOoLM2fL52k0D/fA3V1P3twPlO1iOA2a0QyIx02vYTSVLMjlo3i/AE5+b5PNjGYwl4zZul36FlVOlErOroQgR/LbUyUckpaSTG+xVkUAusfzluVERSU+fW/gE75Qbn/8oPzYqOiWY+YiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42574804553so74863415ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649664; x=1759254464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UweK9PxaB89GoyVZ7u3bZJ3Y7spgw/H89b5lz78D1OQ=;
        b=XmWLCTzT+8paJyblDZpiqlfcDF0XcBYu9tzvRmMLqGzIosaMmmMre7Wdj59uXTw7tD
         ZuU2Q8Br/HtFnAxI7AuhVENpc3Z9Iiq5ia2eQVB5xmaVHopXhhjoSYZyMf42SLKxtRnN
         g93E53HkpozW0miWW8q5sEK9rpwA8L8Vj6suRV1RVu21w4PHQqg7bjJFsJU2gBHNRYX9
         AKhdtb8yyrZs0HrehzjMyQ52iZICiHXivwWf7LGyUmc25SY9k+/a2hy8cCzAOoSk+lpz
         rWiF+J2vX/C99DqoJX5lNxf4md5KQJlcSGtwAu+P5lgF5YSxgwcRvbMZ9KYj1xefchO/
         J5QQ==
X-Gm-Message-State: AOJu0YwuRYxD0CGpFiblk4lg9LzAK8ElRQCuVAk9VhUScGSqgeEn/XQn
	vseuxG4Y7/UVpW2ZyeGdy2kQulkLB54CuYGMjtyLxInyVC933lm6tmRQJ6OEM0fr3snzXEEyA8Q
	dPJdxgn5bDHwgne3xbVdF5KOLji6XUypg/V5k2MO5NQaMO/cMmE2qpszRVXI=
X-Google-Smtp-Source: AGHT+IEKIcYQjAktB74rtlMsqNYZaVUFQTqnE4I8zsg7F2qNS2ekhJKu4/izsmu+LRYifwD3JBc+iWt9FU55iUkdbGDetfxJUEFb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:424:80f2:2a3 with SMTP id
 e9e14a558f8ab-42581e1717cmr55992715ab.6.1758649664173; Tue, 23 Sep 2025
 10:47:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:47:44 -0700
In-Reply-To: <68197d2b.050a0220.23d401.2859.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2dd40.a70a0220.4f78.000c.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in BT_STACK_DUMP
From: syzbot <syzbot+ba5f49027aace342d24d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in BT_STACK_DUMP
Author: rampxxxx@gmail.com

#syz test

---
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index ab11849cf9cc..4fbb0e39270c 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -770,6 +770,10 @@ int dtSearch(struct inode *ip, struct
component_name * key, ino_t * data,
                       /* Something's corrupted, mark filesystem dirty so
                        * chkdsk will fix it.
                        */
+                       btsp = btstack->top;
+                       btsp->bn = 0;
+                       btsp->index = 0;
+
                       jfs_error(sb, "stack overrun!\n");
                       BT_STACK_DUMP(btstack);
                       rc = -EIO;

