Return-Path: <linux-kernel+bounces-897647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9EC538B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFDF5665DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A723446DE;
	Wed, 12 Nov 2025 15:51:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D624E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962708; cv=none; b=RjzWn3jEFo++TtPSvoWAYS17nnr0WeZIs+ENRO8DIX7A+p17iVOo6nJLSJ9ebLBlqugwMS+wDFLVgOpf5y+3kdHPKNbasqsrcI40pid0KZ9oHCb/7vGiUabDVIqo1Qf7pGqD2ZER5K/GVdsWDYadpCN5FMQSPA8Dp5/2v1oaNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962708; c=relaxed/simple;
	bh=hj4uv6C7HwyDgg028stZUSgjlW5iEffkR5x53Vqmd9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EJHh4nc+tXSyYFnMxmfhZbRiD/dNJiPKv4L3NWBH38sLmQjFF1eLWw5t2+UsoQ3Dox3d+O/3lBg+t8cQ3xgO2wOS3T9ZjC42XrWMlnbVaYqXUeiKbnaW0CAtJnP19PgphDx3B3PjrR/pdYV4jA6e9RLiVsXpheWVwePiFyhlw18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433692f7479so26147005ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962706; x=1763567506;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYPqfz0aNwUGvgLGLiiMApttmmpUaWtKimeerB9Akps=;
        b=OSQ3F6uCW4WoBGF8eLIJMXS8THkPpKQ1vv6PoHnH2SNFNsrhbBdHqLpDb5rs0XL7sg
         blnqCVPf0u2qm0XggkAbqind55E/RZAuGFxsnYfPZe48+MDWfyiHW7HRF2WexFaklpid
         DEvJtlbF9xG8EtfHnF4u/8Y8KdQFlp42cxopkx5Wv8PaCPxuspNAJWVvl0GUMetKsl0v
         qx8nbjk32KEdu6uRscL4ZxDEvrKw+iuDJuNETeRjwzqfVqITZQ25+/6vVshilvw87Age
         tSzIlRnJqachRNqiXTAAQlPnZ0Emo1wcLqviYJ6fn6oqg/q3ivX3NyVPefsbM55/LTMU
         Pbtg==
X-Gm-Message-State: AOJu0YyzVzJFCAI/FpvQU5KWOW9ngtM86bpI/UDXHhdx5TElt4BPzsD6
	2sHTr60T162QO5t2TlZElnYrRbuR7caJQbY3rMK56O6HtZj9nCi8HBbAmF1aMptD9vhOZTikxCO
	wMku+m+4JK5WpzWEn9COHBcOnq0jy+KxMOj1/wNua12x1fk5ZiZoenAO57z4=
X-Google-Smtp-Source: AGHT+IHJAr8D2zbW8wFTvmr/T+9das2IIT+yXiFIfGlG6x49fqHIPWbBk3uiO0GDgLnQQQ9LWUqIe5/gvWmW2QSP4uwdOLHefUyU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3103:b0:433:7e2f:83c5 with SMTP id
 e9e14a558f8ab-43473d08c88mr50100545ab.3.1762962705838; Wed, 12 Nov 2025
 07:51:45 -0800 (PST)
Date: Wed, 12 Nov 2025 07:51:45 -0800
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914ad11.a70a0220.3124cb.0007.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8=
021d
Author: vnranganath.20@gmail.com

#syz test

On Wed, Nov 12, 2025 at 9:03=E2=80=AFPM syzbot
<syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/wireless/util.c
> Hunk #1 FAILED at 963.
> 1 out of 1 hunk FAILED
>
>
>
> Tested on:
>
> commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D878ddc3962f792e=
9af59
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1261465858=
0000
>

