Return-Path: <linux-kernel+bounces-844860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCBBC2F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2472D4E0136
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29883257825;
	Tue,  7 Oct 2025 23:29:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372E235C01
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879744; cv=none; b=UZNEqrTFOVBsmS8R3N7nPm3elni5oMmPODLQ43q1dtRu/OUiW683chlBDuZ1rNfX8spq9lFMHEhiZJqNVozgTA3qDcX+U2/ctRNEJAdTii7AtTLfHAkHp8q6AsAkqA4qPBRnJo/0CeYr3Y6Cz9EiNE0mQ1Z0JtT77i5dUvML88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879744; c=relaxed/simple;
	bh=1et4TFmA+MtE2pexyfRs2I+FKHX1eE77LRLzY7yt+hM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Of25hflPecmWEXzx1rZJ53aq6yobQXeuqH53WcMzHLAZjtQnDz9KdDdULZpK2asucC8XrM9r6BpFrNLL74MolOIjLTb+HcAt4Cjm9qn/e4xVkP+3Uqx+DnI02M0UUOMcON+QhGLkLeUD/OQhEc1l9Kz/raSbB6S0PHH2x0G3Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f6639fb22so55151625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879742; x=1760484542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/rvXYCZEg14WYsInwyVNAQ5lJvCUE2wFXbJBFTowus=;
        b=Z2PYHlou6rd9f4EPxwjZzo22E28kmorwsbKlg7oyIlxgEhRXOXK+pZDMfYMsqveOZ+
         B159EDRtxXHQM1nhgyvBkU+UMEeKLWonFTL3/T9WOnUR4zV8+wlB10HohU+TOcvDbmRE
         Ek+Iv98TE99otmMi6XpcaTR57xBn4aUMSbDoR4t+bw+DWFEi9Z0EDO3KsdugewOg4anG
         UTyiEl5LmJo6ZmjX4gElKv54Wxx4VpMez/vE3CPi0W7oPjZ7A9OWab49HDF+OBW2aKfn
         Zl/X3Eq7FiPBrlw7sZG0uyIDEJq4Q8Oz4xZLowJLiI++/JFX/TPO90ZwEaqhOA5h/kxp
         FN2g==
X-Forwarded-Encrypted: i=1; AJvYcCW4YPkrPsQWNfNDRorku9tFP5L2z4x5cc5MvRqu5LfnhOlR0PBpgUacowOkxyJZLBAPrAffNHYncnD6SRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+WoGol5FCHumngid3XaUduprAw4nFR/jaERVz1swK/jEJckt
	doWIU+6Xoy2Fwvn3qd2Yg3IoGF4lSLPKu3KCwOUHqE/iqd16urr8OVlJXI/apEnAshUNzehH/vU
	Jy9oeeysLTdoGg6OQekaQf8pSgDu0jr2rV9uMIqMPWVMua6Si8kuAA/cGQVI=
X-Google-Smtp-Source: AGHT+IHCwJWbOVllrxEkarX0fulWih7JNfI+rNZ+MjiKezFvhvotiyDwmsfysWChUmXkhd6HRcHk52B0D7Lu3FusShlYn3JiFJh6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a87:b0:42d:844d:277e with SMTP id
 e9e14a558f8ab-42f8742ebe9mr11144805ab.32.1759879742415; Tue, 07 Oct 2025
 16:29:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 16:29:02 -0700
In-Reply-To: <1296925405.322110.1759873945068@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5a23e.050a0220.256323.002d.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer (3)
From: syzbot <syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in indx_insert_into_buffer

loop0: detected capacity change from 0 to 4096
------------[ cut here ]------------
memcpy: detected field-spanning write (size 3656) of single field "&n1->index->blk" at fs/ntfs3/index.c:1927 (size 16)
WARNING: CPU: 1 PID: 6418 at fs/ntfs3/index.c:1927 indx_insert_into_buffer.isra.0+0x109a/0x1320 fs/ntfs3/index.c:1927
Modules linked in:
CPU: 1 UID: 0 PID: 6418 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:indx_insert_into_buffer.isra.0+0x109a/0x1320 fs/ntfs3/index.c:1927
Code: 0c d5 a3 fe c6 05 3a ad 30 0d 01 90 48 8b 74 24 68 b9 10 00 00 00 48 c7 c2 60 68 a7 8b 48 c7 c7 c0 68 a7 8b e8 87 5b 62 fe 90 <0f> 0b 90 90 e9 b0 fd ff ff e8 38 56 0b ff e9 f4 f3 ff ff e8 2e 56
RSP: 0018:ffffc90003a0f748 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: ffffffff817a4b08
RDX: ffff888025980000 RSI: ffffffff817a4b15 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807927e800
R13: ffff88805862a800 R14: dffffc0000000000 R15: 0000000000000e48
FS:  00007f94fb6426c0(0000) GS:ffff888124f62000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3ee058dd30 CR3: 00000000616dd000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 indx_insert_entry+0x1a0/0x460 fs/ntfs3/index.c:1996
 ni_add_name+0x4dd/0x820 fs/ntfs3/frecord.c:2995
 ni_rename+0x98/0x170 fs/ntfs3/frecord.c:3026
 ntfs_rename+0xab9/0xf00 fs/ntfs3/namei.c:332
 vfs_rename+0xfa3/0x2290 fs/namei.c:5216
 do_renameat2+0x7d8/0xc20 fs/namei.c:5364
 __do_sys_rename fs/namei.c:5411 [inline]
 __se_sys_rename fs/namei.c:5409 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:5409
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f94fa78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f94fb642038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f94fa9e5fa0 RCX: 00007f94fa78eec9
RDX: 0000000000000000 RSI: 0000200000000f40 RDI: 00002000000003c0
RBP: 00007f94fa811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f94fa9e6038 R14: 00007f94fa9e5fa0 R15: 00007ffce10dde88
 </TASK>


Tested on:

commit:         a8cdf51c Merge tag 'hardening-fix1-v6.18-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16277334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e89ecd5e8107dd4
dashboard link: https://syzkaller.appspot.com/bug?extid=3a1878433bc1cb97b42a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a8e892580000


