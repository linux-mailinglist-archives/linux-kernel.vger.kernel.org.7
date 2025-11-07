Return-Path: <linux-kernel+bounces-890261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AACC3FA20
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4839B4F0BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45EF31B81C;
	Fri,  7 Nov 2025 11:04:58 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029D2FFF9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513498; cv=none; b=Uw5Mu0vvOEWDkFkpopeWH7BgDDz5RZ6MGeUoJSN1dwpw4Xb9k3vgY5ICNF0FzD2PawHXAMTlXQnK8aQBSzYwd2dpffjSagz70ldWLqv3nhvay7+nqz12Epa7LsMavVmVbSHcIqsfhd4HOv2UV3ApLyZj17M3EgQeBw6YFLTuLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513498; c=relaxed/simple;
	bh=p0N7L6ikhIfH27UWEziaLqlevCPegI2IZ//SECV84Ew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kQRBnAeqrjBPoByO9sh4p1HKiPLEAstP/Pp5GQ6uEuMWnyoob6/yVuojNQJ2nWGG/PgHQKqhew/FLTaZCUzVD1O1/edw7RG53YPdKKY9nqi3sVYYHO5Grv9qMHnpS1tGYpfpT+cPKjy0/V5z+gydrHSRmTyAMgUYGlDXLefxZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43328dcdac1so16354785ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513496; x=1763118296;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEAQ+DJ7d07d0eou6tJUshHnTNtSWeH6xZmZhZyNubA=;
        b=GqpR7r2njcrvMcbm00igxrWGXqWc2COXoH1fkDRjjphl//G3Xlq/TWccZO5nT9kGm7
         g8AVfuxPINqEJWus4xW7MZ5lybZ8WsV8I95W9U91DzLXZF9rXvsQsOfth8ouyhhQTajW
         hUWJwU/gftBIS/Gb2FW65vZfcre77S2FOqxMEbevmXAP1ilSw0nkXBThB/ytXq2HtL9g
         Q62HP36wjKfTJ5+idCwrSZcBAxT2yuyLSKGB3RbrQnr2+FpdOmR2P8BzIsYl7fpsE147
         oQKodNEooFyEHhBouTPXX3oOciPzD487EW6S3lDactUzKbQLlHVw9Bj62WGX5V0z7LQV
         PSyg==
X-Gm-Message-State: AOJu0Yxv69ah8EGfaxakKGD47B9kB5hrlxxL350+puzSRd9xXGTS/q9T
	FVXJ37Ni/rLMsZNnyLqlQkYTDvim3Qo04KEphqmUA+Gk3om+usDB2FBbMCieIScPm1j0+ZCUC6N
	0WjBUTIUPM1DAe/6FBDppiIsN9347xZR++tJkWV/TCMXbodKOyalYzCNzS6c=
X-Google-Smtp-Source: AGHT+IHH/zDnru4+XqZpfKnAUjqwgYQZ4qrhZRR3HE3LMST7Mpk+Q3wDQ2LhU0USfdjCFvMVFm30q+SDUdPLDcGwXa440A87Z7A+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2786:b0:433:28c7:6d7c with SMTP id
 e9e14a558f8ab-4335f3f9be5mr40218325ab.12.1762513495935; Fri, 07 Nov 2025
 03:04:55 -0800 (PST)
Date: Fri, 07 Nov 2025 03:04:55 -0800
In-Reply-To: <690be734.050a0220.baf87.007a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd257.a70a0220.22f260.003c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
From: syzbot <syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
Author: yun.zhou@windriver.com

#syz test

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 871cf4fb3636..0d6c40e7e551 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -270,6 +270,7 @@ static inline struct metapage *alloc_metapage(gfp_t
gfp_mask)
                  mp->clsn = 0;
                  mp->log = NULL;
                  init_waitqueue_head(&mp->wait);
+               INIT_LIST_HEAD(&mp->synclist);
          }
          return mp;
   }
@@ -379,7 +380,7 @@ static void remove_from_logsync(struct metapage *mp)
                  mp->lsn = 0;
                  mp->clsn = 0;
                  log->count--;
-               list_del(&mp->synclist);
+               list_del_init(&mp->synclist);
          }
          LOGSYNC_UNLOCK(log, flags);
   }
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 7840a03e5bcb..a5a5bc0a266d 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -275,6 +275,7 @@ int txInit(void)
          for (k = 0; k < nTxBlock; k++) {
                  init_waitqueue_head(&TxBlock[k].gcwait);
                  init_waitqueue_head(&TxBlock[k].waitor);
+               INIT_LIST_HEAD(&TxBlock[k].synclist);
          }

          for (k = 1; k < nTxBlock - 1; k++) {
@@ -974,7 +975,7 @@ static void txUnlock(struct tblock * tblk)
          if (tblk->lsn) {
                  LOGSYNC_LOCK(log, flags);
                  log->count--;
-               list_del(&tblk->synclist);
+               list_del_init(&tblk->synclist);
                  LOGSYNC_UNLOCK(log, flags);
          }
   }


