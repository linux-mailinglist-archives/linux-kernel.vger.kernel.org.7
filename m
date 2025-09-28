Return-Path: <linux-kernel+bounces-835556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3187BA76D2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7918961F1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A0E25A62E;
	Sun, 28 Sep 2025 19:16:54 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE176F2F2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759087014; cv=none; b=Ye3JsxDYk/Ygk3av9TQ14Osx4/sUCqlnyeBXgkujlFxBw8VMPFeYRJH1X3IWAu3V4qUZx1efebMsVaog6OyDVu5o0TPOyWd8EFuH9Z3SYSn2xCtQrqY1FHOuCrXn8LucEJM5fLCZ8xwRYm2brnDo6elvc+UOcM2EM7p3058EjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759087014; c=relaxed/simple;
	bh=8MKE/l0TPJTzIActVqVaHOkdVqDJNEx6tKRIPOkqR60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmQNG25ubFXA8AQhtX+ANI6t2CLjyWWWqBkDKmEt+c+1smx4J1pQtutiCdySfuEsv9jAP5hEsWRuQjrBgojG2HA0vfLFFwPjs7yEor0JKWw32JaTIWaI1cDxzffHOjazPPc8lTkokQNES4uwE1OxdtkPCjwdv2u+IovrW+5V73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594b7f324so73039095ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759087012; x=1759691812;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqEvxXHVRa3NTR711yuiK4uK9w4PHdka9UlxYVOtQAg=;
        b=xGohs62N8kCMCtLOXNXkfNwHVAe0F2cruTfuZlUF2UxEEBZJ4AtYQ6Hvv1/s9N3Evw
         ZgBXIuMvCAiKgNsGH4UsPcIZe8n2Rbt+F6lQKecPO4ouOoEcJWbP/SDqm0YPzu//D104
         gWSdyHIQBqrIqwuGryPSfa8ssOa7TbssWM70KCAemPZtCXg83tqunhM1zPfBDzg9mmY8
         0/xmDfbbICE392zhMcOc9dPqJPlf1dOI3EGZikWR3NCiCH2Efsky0hzLR3zB1YAT0VgL
         P41tjeHF/2kD+YbXJ3qBlDR6kXTh10tbLOmgD5sRfvbdlvEp87mZOAQkbdWyo0PIQz5M
         Z/Sw==
X-Gm-Message-State: AOJu0YzfCUihVvPowgd2uoRMdC1TlkDdAnuSBr7pTiHBTcsOC80xD74Z
	FiO+JxviOE0T1L0gGPFIcAks3UokHlg85+IptRfEMcsTzKpwUV0A5mcI5lbMNVZDHXEFWSD857T
	6prLdVPsGBbtX58Z87ea3CHJ3fahRXD52CEsQXv/1rW7UpIu4aYOQrGX+e80=
X-Google-Smtp-Source: AGHT+IHX9k6Jvt2rS/F3dgrQ6ojljRGt1BcRSNo9Vln//kkWYS28IACoGASrhTwnT++onbsykZgzh8ASPV0MRsMHvs4BOtjFU5zr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:428:1858:801d with SMTP id
 e9e14a558f8ab-42818588186mr54529305ab.2.1759087012037; Sun, 28 Sep 2025
 12:16:52 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:16:52 -0700
In-Reply-To: <000000000000c29dab06004a752b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d989a4.a70a0220.10c4b.0024.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
Author: xandfury@gmail.com

syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com> writes:

> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  <https://syzkaller.appspot.com/x/bisect.txt?x=3D14b5e7541=
80000>
> start commit:   8689f4f2ea56 Merge tag =E2=80=99mmc-v6.5-2=E2=80=99 of gi=
t://git.kernel.or..
> git tree:       upstream
> kernel config:  <https://syzkaller.appspot.com/x/.config?x=3D15873d91ff37=
a949>
> dashboard link: <https://syzkaller.appspot.com/bug?extid=3Dfc26c366038b54=
261e53>
> syz repro:      <https://syzkaller.appspot.com/x/repro.syz?x=3D14237dc2a8=
0000>
> C reproducer:   <https://syzkaller.appspot.com/x/repro.c?x=3D13e34d22a800=
00>
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: <https://goo.gl/tpsmEJ#bisec=
tion>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 6f861765464f43a71462d52026fbddfc858239a5

