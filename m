Return-Path: <linux-kernel+bounces-891406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF41C42979
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3817434A3DC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547132E5B2A;
	Sat,  8 Nov 2025 08:32:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871627F015
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762590742; cv=none; b=mA1jre7Yzvrmaj/eBaAoFC+xtI5HKBWQws7W9EMPkHCbz43PUUth6L3we+nf1yTIgb/Woy3aKcMRxF17bFramYzH7kach5go57k1QKe6U5aBzOPL0y9/q3t3yyoGNsrboWxqtxL1QSmgYC/bspW+ICM3EYQTMKjHEp94Eh4N0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762590742; c=relaxed/simple;
	bh=Hxo3EfTfNbCX1woph7ErglQ5r9laF0dGvYnLH7kW07Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Imp6/im+rLxcHQci5vASpr8+NH/zVzKO2ALnmuS3x4iOqAza+ZisAoGz/jekCwsRUWXSt2ziiTYC7KuduGsJ1aoXg5/8+ibbwQt24bycpTJiInKzHzkjDQcl1GfFddFmt09O43gHlCOKgSH/S83/b8w9coi7WtuiimLqfZq4oVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4336ed83d20so3338075ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762590739; x=1763195539;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxo3EfTfNbCX1woph7ErglQ5r9laF0dGvYnLH7kW07Y=;
        b=XljeI0t3aer6StlEm6gBRKt5E/aHbJodNcY3Ldmpt1wvrhmaBjoS/1hlUytbKPJGEa
         9+KTZtNlVBYlTmYYidS9dbJMGy2VczWV1uM6ltipbT7SgoXZKdzhvoeKd+vzoJZF/yEZ
         k2D4cEmEsbQFNK2sA1cPeUSChOA4tbZoe/amW8LTY8cRq6DIJTjqnKimI25ctgUrretb
         44WY2QmKCGfYW115vqSOkVLDof1OCxe6YirjUfHzk9Ott2YY5bJ/7QWEo8cSNLqKwFkB
         /RxiZ9JqFHGyHzke0Fknc/ltHesyen9+gM8sWnfi3U14zFM4MoWauQcvZRVePQdkIT71
         uR1w==
X-Gm-Message-State: AOJu0YzuDDhMLvRjOTBb/aQVUtvQoTOseAHHGcAl4P0mRYglDEVrKI29
	ogH0uqDjyx2f9k3Ms78J4L3I59TXKhekeADO1r/olRF6ndk13TffaumydFUMPL2Nf5ruVd7h/k1
	3H0itjxm7DP8pKovFIZgKlJpwSEgEjx49Qj0rjNhDp+blRBO3KaFRif/qjHA=
X-Google-Smtp-Source: AGHT+IFPl3eojIXbpcobi1Dj5PW6AQBO/hmEitYqv4E6P9pAxRW8XQude4R0AKJHUHw3rioKVJK1OlKF+Y2FQ8uJ2dPaRHU9JBPX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c08f:0:b0:430:ce63:4180 with SMTP id
 e9e14a558f8ab-4336299bbf7mr48153085ab.8.1762590739593; Sat, 08 Nov 2025
 00:32:19 -0800 (PST)
Date: Sat, 08 Nov 2025 00:32:19 -0800
In-Reply-To: <690d9fd3.a70a0220.22f260.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f0013.a70a0220.22f260.0079.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
Author: yun.zhou@windriver.com

#syz test

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 7840a03e5bcb..a69bb5f25301 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -1073,7 +1073,7 @@ struct linelock *txLinelock(struct linelock * tlock)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TXN_UNLOCK();

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* initialize linelock */
-=C2=A0 =C2=A0 =C2=A0 =C2=A0linelock =3D (struct linelock *) tlck;
+=C2=A0 =C2=A0 =C2=A0 =C2=A0linelock =3D (struct linelock *) tlck->lock;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linelock->next =3D 0;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linelock->flag =3D tlckLINELOCK;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linelock->maxcnt =3D TLOCKLONG;

