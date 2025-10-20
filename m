Return-Path: <linux-kernel+bounces-860286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CFBEFBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FDE189CD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69932E284A;
	Mon, 20 Oct 2025 07:54:11 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7662E1F0E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946851; cv=none; b=q110f2g/38HKeUStCm+Jc+BNVTVuMXeR5nqXNwilccoSeB2d8DV27wOz2+6/zyqoLMMgjC2adDGZddUfb2MIT81NAI1aAaIi3rR6N1Cu6a8cZHddjz6O/UfCFQ1sGr+fN+l7Pn/miY0ZA8CXknLbgr0A9iOiQPdT3458uDxiMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946851; c=relaxed/simple;
	bh=jtM/cZweslp0QHAW5CwAxwpu+TGNxPyAV7qYjkI22Mw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=swikMWRralUhnecmpnQKAmX+pyh8qtRTdS+CU0f2ERzF+KeZ7XmQQ4prqVCQsqCwzvnyxWGw5tralrF1Bf3c1mfKhQEvlRwdAH2x5UhT9UB/EVX+eSFixPFXSYRYrvSqRHV2fjJchB1I9RiussqY8V22ihsD/fec3BnIL5//3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso274822039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946848; x=1761551648;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piqoZtmKq+SSnTeOFUqAbd94ojrA2fUb0XRpnW00QOg=;
        b=tHPCAIdrD+dCha71L1z1qdlrB6sJIfGQpXlJW0tHAfTde2/szwiSmgi4/kd1DM/8TE
         en/Sp3QmdCxZHooczILDFoSkeJhD7bmPEzl+KThzU2gy5RACOkg58iUDQ7tGhCpOUeOH
         hA2/5cjH6Vlgf7GmsZKNT0aQbJVrauzCdnPr2iPmohElIEGj4pBTEqR8zVd++lnivmLo
         VfccgxT5aYMaS0es1WbpcDp2q6hmDrjjd4wqENJ4nmb8WMapUGPRw3Zt5Nm9QcW+qs1I
         dBYcfTs3FJilv+uAhk81w951cfP4seYF5JfdwrduzO/dvFn/zRhvWCYpiipt6pbqjO+j
         jXaQ==
X-Gm-Message-State: AOJu0Yz48ERCYnWSpbxH25IVR5nvq7oNMLKJVPBsGKWaMnmDtyaO/Eqx
	UOL3xeg2iZFh+YySfB+m/yQgIUTnx9g1/HNEOodJ8VgHAmQxqluOd0A3rJoOUED9SqQ0zMrsmpS
	KTRMaV8nlOdyXH6V0VX2LbvWSy4FQ0KOO1uuF7yDVE+vKyECgkzycjxKY/BM=
X-Google-Smtp-Source: AGHT+IHhBU03ipmUByxmMsloTD2ZMT2RFYgssNJbasg4NFONDGo07EqY60F0FcQ2/JCi6R8S6URZ0zbSS7YkJxVBS4IxniOcGjdq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:5c2:b0:93e:8d3c:7ce1 with SMTP id
 ca18e2360f4ac-93e8d3c7f48mr861094739f.0.1760946847780; Mon, 20 Oct 2025
 00:54:07 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:54:07 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5ea9f.050a0220.1be48.0009.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
Author: clf700383@gmail.com

syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
=E4=BA=8E2025=E5=B9=B410=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 15:48=E5=86=
=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/key/af_key.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         7361c864 selftests/bpf: Fix list_del() in arena list
> git tree:       bpf-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9ad7b090a1865=
4a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbe97dd4da14ae88=
b6ba4
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16776b0458=
0000
>

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git m=
aster

Thanks.

From 6dc2deb09faf7d53707cc9e75e175b09644fd181 Mon Sep 17 00:00:00 2001
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 13:48:54 +0800
Subject: [PATCH] fix integer overflow in set_ipsecrequest

syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic=
.

The mp->new_family and mp->old_family is u16, while set_ipsecrequest receiv=
es
family as uint8_t,  causing a integer overflow and the later size_req
calculation
error, which exceeds the size used in alloc_skb, and ultimately triggered t=
he
kernel bug in skb_put.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dbe97dd4da14ae88b6ba4
Signed-off-by: Cheng Lingfei <clf700383@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..08f4cde01994 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff
*skb, const struct xfrm_kmaddress *

 static int set_ipsecrequest(struct sk_buff *skb,
                            uint8_t proto, uint8_t mode, int level,
-                           uint32_t reqid, uint8_t family,
+                           uint32_t reqid, uint16_t family,
                            const xfrm_address_t *src, const
xfrm_address_t *dst)
 {
        struct sadb_x_ipsecrequest *rq;
--
2.34.1

