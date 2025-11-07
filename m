Return-Path: <linux-kernel+bounces-890177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE7BC3F65C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A8618860B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502193043D5;
	Fri,  7 Nov 2025 10:21:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BD28F5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510889; cv=none; b=lYRyPC5KOY8jUMGWh2kQpOX6f+GJ3RlxatmuWyrIgORHTxEb8ltCPlsjMrY/nCFdLGtZw0lXzBb/Iyk+DHDmyNZWvUyy4B/hEspKt3PsgdQvfzmHl8tI1JPF+JkkewHdiqc65HLUnbZlSKXL0aZUGeYuatTe+Ii8Evq413RnKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510889; c=relaxed/simple;
	bh=nkmGhbGW8pKVCxDFuoejFH9cugM0ea3WIosDH7YzLQs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qO4Ka9OCBIO+aDMqTyH1Z0bZrWeBrJvTOXF85n9c1TrN/+15RX4hG9d9qTuouQXEHFm1zpkIR8MOX+BlXH8EiPVP/+biyfaVX/m2OWQTg/O39ecFcWo/eEPPYx19gzhXpTRDSUogZuuRTYQWN1WXOz+mnaosAwYU1s51j/IlZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so17889375ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510887; x=1763115687;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkmGhbGW8pKVCxDFuoejFH9cugM0ea3WIosDH7YzLQs=;
        b=GoMyzyuoI8Jz5IRKYguRjqS3ICtEyZhn6pAETySZad0DoPPRNOBFv+U2z+ffro57/b
         pjur00DuR02H1T7c63IGrYjRho+Cc2NkE3kYD8dqEsrrv0UxppLS2CY/hfL5cqt9ne0/
         3yCCK7RAmRIF6c8qVghmwcSySDCEJFU3xMj6PoI/8914O31jOZMe5LfCTXR6DWCTozGa
         A429KF4dg8KBVQoqK8ii29zUppNG0131+77hFgWCkV4Y9DvZYwT1f32tpEomkt85Wytw
         bJNtf3pzrilFTYFRnApuhiXYrBijgOwbYQeEe/vGyh/x4Ds2mjwDlW9zr3Cpie6O0t6X
         kp0g==
X-Gm-Message-State: AOJu0YxfVRGLT8qLojZdLdWhnJu7clJxaZ38mLeMM8JcwgH8h9bzu6hw
	Op+2oRmwcPOeDsQZoBSWAcCynb2Vibi7NBMav9N9/RQoDo5VsVa/X+dyqDmukaScmcswY//VG7M
	XoLbizvzCn1E5MB7tCEbHMfr+sOuuyTgTphu/AJr6jO6DCfqtwKkFMvilb/4=
X-Google-Smtp-Source: AGHT+IGBGn7KCVbF5MN+cHh87+lQHia+jot1uFytEKC+uYrUSDnEWM+x/G+bS6YwJLTcqIhIEwvKocS8pgOw5wPVP+EH2jfSi2xo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:433:217a:a25c with SMTP id
 e9e14a558f8ab-4335f4a2cb4mr31854305ab.28.1762510887610; Fri, 07 Nov 2025
 02:21:27 -0800 (PST)
Date: Fri, 07 Nov 2025 02:21:27 -0800
In-Reply-To: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dc827.a70a0220.22f260.0035.GAE@google.com>
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


