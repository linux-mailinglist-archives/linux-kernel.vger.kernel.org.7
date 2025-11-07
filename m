Return-Path: <linux-kernel+bounces-890274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE43C3FAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D09254F1789
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0B2C9D;
	Fri,  7 Nov 2025 11:15:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62F2472B6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514143; cv=none; b=Xbu/CWFbg3mRjb6q/LW7ZG0mf+dsu+O4R+Bh7O1TUwMhE/XY+YwkS+6LN7KeWu0TTcbLCMWOIsMLK56drI5Pze6mny62D9DbFIO0RhQePf9wdzQm2M+oHrGxcjdpAYFbLAS0fUx2fyObhcwn6WVTshUexOyFahQAezCcha24ISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514143; c=relaxed/simple;
	bh=nkmGhbGW8pKVCxDFuoejFH9cugM0ea3WIosDH7YzLQs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HalpeyPHbtnYERggxEwuV+iSGcoAuwHWdnUIqsZ6l/rqAVt6MxBlCvALwP8nfkE2oL49csyiP9XHK5gGdoYWDlTc47PApi/qdwhN3SFVwg2E/SxPbirfimV/kMIU4O3sU5T/2wU66PfBqshx4QqwMlpxJf5lrNNaGfB8TOjLqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4332987de75so17409175ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514141; x=1763118941;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkmGhbGW8pKVCxDFuoejFH9cugM0ea3WIosDH7YzLQs=;
        b=qUDlgTe8nLg9YGIjldOv/nMWxfCsarXh4TecxjYSL5fVT25GeHKE1q2GxSiBPPZ/Hf
         zA6hHkuvJhJRkdpCKSMMK4qyIU3uhUmmn3VoZQveW6HWfR1OPgH7kAOkxeUk99Wmn9sg
         noZ9TmY5MU4/BxAjmmIxWDxjWC3ouu0r6vkCwr9SELrH8+aWGKMlPofmv9y7ZW1OXSot
         w3ajr+Lw5j4gFgVWMrxzKO7hcw/xwt+uj/r/cxPkE7qVMcpWEH++GRKoudwOjl5sgNaT
         Acu7IAmrjJUzKEbKXnBfez851SqDYxVeOo/Ft/n7EOO2UK/AA+NBd97rukspBDywMKSb
         gpLA==
X-Gm-Message-State: AOJu0YxgRYlsUJmyHIKu9s6HX5rgsyh9/vRXwD8i6FslyFpImXr2f5DN
	B+FrpUbvcTjQzTe9R/NbMLlN1rOnfQtVVlr3at03a4uJHFdaVnoTfutT7F8Za1MQ/tC30TNeALf
	1B/+O6SVlVJUw9dqDmXzpisyqayfWTLXdn8AO5ZW/gWFuuXPhMS9BNWljeN4=
X-Google-Smtp-Source: AGHT+IFNNo6owAoYoAPXYBZ2Yo49LzOPLkbtAA/FmR0LAXXly152c9IyI4oU4kHC+rbOiFEVHWvSvL/GN5NCeNbY2vE/WSGFIbSi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:433:46a7:be57 with SMTP id
 e9e14a558f8ab-4335f484062mr32342325ab.8.1762514141054; Fri, 07 Nov 2025
 03:15:41 -0800 (PST)
Date: Fri, 07 Nov 2025 03:15:41 -0800
In-Reply-To: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd4dd.a70a0220.22f260.003e.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging
 request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in=
 diUpdatePMap
Author: yun.zhou@windriver.com

#syz test

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 871cf4fb3636..0d6c40e7e551 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -270,6 +270,7 @@ static inline struct metapage *alloc_metapage(gfp_t=20
gfp_mask)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mp->clsn =3D 0;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mp->log =3D NULL;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_waitqueue_hea=
d(&mp->wait);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&mp-=
>synclist);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mp;
 =C2=A0}
@@ -379,7 +380,7 @@ static void remove_from_logsync(struct metapage *mp)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mp->lsn =3D 0;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mp->clsn =3D 0;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log->count--;
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&mp->syncl=
ist);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del_init(&mp->=
synclist);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOGSYNC_UNLOCK(log, flags);
 =C2=A0}
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 7840a03e5bcb..a5a5bc0a266d 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -275,6 +275,7 @@ int txInit(void)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D 0; k < nTxBlock; k++) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_waitqueue_hea=
d(&TxBlock[k].gcwait);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_waitqueue_hea=
d(&TxBlock[k].waitor);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&TxB=
lock[k].synclist);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D 1; k < nTxBlock - 1; k++) {
@@ -974,7 +975,7 @@ static void txUnlock(struct tblock * tblk)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tblk->lsn) {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOGSYNC_LOCK(log, =
flags);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log->count--;
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&tblk->syn=
clist);
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del_init(&tblk=
->synclist);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LOGSYNC_UNLOCK(log=
, flags);
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
 =C2=A0}

