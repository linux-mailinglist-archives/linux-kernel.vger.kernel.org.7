Return-Path: <linux-kernel+bounces-765791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44076B23E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08496270E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAA1E520B;
	Wed, 13 Aug 2025 02:39:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF0C148
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052745; cv=none; b=khb+Erh/AT6wVeh2aulVt6cgBOdtlLf57vpNwZUKSbDyZXbQ6bXO8g9+H8szbX3aTY5TROfSqsln47Bpy36j7t8VuWYmJNIHcLONqRY1z1jlTUp1rEgaDtaoGtdvkDDPvk23Ixy869k3Cb4X+A+Qo6+hU3ey2hQWDJk9JD5/MGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052745; c=relaxed/simple;
	bh=QC9OFYRv+gyz2U6H8zlN26/oPu7r6z2JEKA7cC6I2AY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VnMkIn720FLN6aDS460fYXy6iBK01ZsEji0GeQmQLcFo13Vq2oYodagHi3Ew63KQ79S78RqyrsHVRNGj22G3ta8/wBKuNfpX8Kbm8Ikpe3EKeW3bSlLZWQtIGZ2okW0hu8VN7IWLUFasM+g2CKGkCQ/XFhngiRxQ91r2OAP1hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8817ecc1b33so1409566439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755052743; x=1755657543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss6wpLZGIwri1rb7C5MMI6Ntgl6FX7+qtc7xrRSYVeY=;
        b=C0/HwutXaEW67Thr7V8xyaC421343s2CzEt4Y5yHUcODBjnYBc4aCH44tOcfQcW+Zs
         FCnHuyAI6AG57YxajC4/OfhxE1utx9OJ67kqmA4D14qBh2wdYZvsTJZrAUHQUvoPzR3h
         SiP3fklcoHONu07Az54tJb2Up+p4jzbHIP7lsScUIfkkaFIdtX1dhi3Q4m0FasOlGIJV
         BTTzSD5JyBMwxKSBNJ8pJ0Emd21IpyDrJWFg7QjgTnVE8t13w6p+oKdzuFpDC5w7QPph
         1T6wUqd9PoiLgXKCOk5eRQDr5m+i9nI4VzNpdBBNtSreWUfjsH7XG2XMLoT/tj23DPYA
         3/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUmc9IvAHLMSk5IXkyei37qcoKbSqkXhlpvPNfhINEtswKHtpeziYEEWaWJo9BLq6pTD12OQ8cYAoIfr20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfU7j3X5r7Nx74rPeI18M+a2bepUz37M3fZpmpJO7FY8MKoep
	iolZAELi4GPWYphaYidtRnHifDox+un4u3a+4XQ/d5p2UoNQK6FZ3zNPIDGyN3c18sn6a2smRO8
	tNHdV40/mecgRAtkh2YfVBDbQyq0eQatkbvDMKv2BRrIozce7iLvlVCCb620=
X-Google-Smtp-Source: AGHT+IGh9twwY7VnR3k5A8uF9UQVqlPPzzsSlnOimRPJ4gV4gLlbWPUay2AGqxX5TFlo+uExg74Mxe/kGV0LW8/xFaAbJfaWYNr1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164e:b0:87c:34e3:1790 with SMTP id
 ca18e2360f4ac-884295f2c91mr286295539f.1.1755052743347; Tue, 12 Aug 2025
 19:39:03 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:39:03 -0700
In-Reply-To: <20250813021941.4438-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689bfac7.a70a0220.7865.0043.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in move_page_tables

R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f6b549b6038 R14: 00007f6b549b5fa0 R15: 00007fff55995d28
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 2 PID: 6580 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
WARNING: CPU: 2 PID: 6580 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
WARNING: CPU: 2 PID: 6580 at mm/mremap.c:357 move_page_tables+0x3752/0x4580 mm/mremap.c:851
Modules linked in:
CPU: 2 UID: 0 PID: 6580 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-g8742b2d8935f-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
RIP: 0010:move_page_tables+0x3752/0x4580 mm/mremap.c:851
Code: 00 48 8b 04 24 31 ff 0f b6 58 30 89 de e8 f6 1c af ff 84 db 0f 85 0d 01 00 00 e8 09 22 af ff e9 19 d7 ff ff e8 ff 21 af ff 90 <0f> 0b 90 48 8b 44 24 50 48 8d 78 40 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc9000367f6f8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000343ec007 RCX: ffffffff820c64bc
RDX: ffff8880251d2440 RSI: ffffffff820c6fc1 RDI: 0000000000000007
RBP: ffff888034426700 R08: 0000000000000007 R09: 0000000000000000
R10: 00000000343ec007 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88802a726030 R15: ffffffff8df55480
FS:  00007f6b53df66c0(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde7257210 CR3: 000000005332e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
 move_vma+0x548/0x1780 mm/mremap.c:1282
 mremap_to+0x1b7/0x450 mm/mremap.c:1406
 do_mremap+0xfad/0x1f80 mm/mremap.c:1921
 __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b5478ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6b53df6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f6b549b5fa0 RCX: 00007f6b5478ebe9
RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007f6b53df6090 R08: 0000200000c00000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f6b549b6038 R14: 00007f6b549b5fa0 R15: 00007fff55995d28
 </TASK>


Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b86842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9319a42cfb3bf57
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152825a2580000


