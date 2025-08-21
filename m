Return-Path: <linux-kernel+bounces-779413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118AB2F3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872DF3B31A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B32E9EBB;
	Thu, 21 Aug 2025 09:23:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D92BD031
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768186; cv=none; b=Ydq8HAMFMlg6wrtU1BI5kJxNNIm/pFI9Y/PSMuvHfMaWLtwDD599gTuBNh+NwLcCWmgCmjS1kN2FBe0LH0BHnDSefhzlON8xmZpt3Yz5JT7i6PPDHXXvI36XG63NiNDF7WBc7dvEPr1ydlh+DJVHepiP3ja4hucpNwk186J9x20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768186; c=relaxed/simple;
	bh=WCZDKgo7yoV2Ay41zKZi8zTJTfFdRcXhO/zfnSxSdps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o93bPv/sGM7Uq0PDp8tPROj4JfXW9YmP06WRAAD11qbo9X4WmbbcIBswlxWR17OGDkerDUU8erIB0uTj2t9Xeq6LRDUjELClpQltKiTLDkBBJfT8Pg16vSkD886opdKRHnQftW7r9cvAH4Ezu+16KNEEmAgMTiIOLD2L0wFbv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e5d398a961so20858415ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755768184; x=1756372984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKir4ayNb6PiB/M+72qfF1KOS5bW4MURUJIg+KnK7fU=;
        b=DB87Xkr5OW1MHgK4R1Mr3aX2vw2kHrqIwrNab5JHowojB5Opb5hDMDQQHsbZQIBAzt
         uX5lh7mvwf7T8pPCoyVBq8UBaRp3ifhRsBgrrGNwQMBp5HwKboMWGWmrXYKC6Zm1/r1Z
         xdcleEiqQvULTVxSs74BR6fax8Z8SaOQT/MrqFQUaKwdZOu3RsuNP/kifg0hEsSebgp1
         SunlPUqzTQpNOMWDClDzz5NFDfJOTaj8XShlu9xrVKf0AyZFeQQILG9SFajzI+8A8A0U
         MGmMHsjj5GhnuNLLFwky/FVES1QChqRVYJYdEUtO82/mAUyQwruymxckwJQVMZMbqTHG
         t1iA==
X-Forwarded-Encrypted: i=1; AJvYcCXbU8RhW+HAAUVYl6b6o44jxGo6IpO3PryFzd84f9vx50P7yJTUwsuYK0FWuXR0TBleqGvmhWmGpxqYFqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+M/5czsYQkDGyRSmABhEMeJbC7IiHXnbEQqJzC4l+IbhlQK6Z
	j5oNW7ki1vqSLy8YgQuJdTo4skuKeN9fAxCdD3ZLMdAkpfKyLMjNpVrI/H7hJHKFnN3LiXycdqJ
	Xo5PvkVDo2mm7Z+iyJ2XmKvK7+HlBuE2RgxNqlAZojcD0p8w8/RUqx1hFPrY=
X-Google-Smtp-Source: AGHT+IGvFTHJN+83jRDDbB8asMYffQIQSkByQKRNuBTGfPSvb1Ey6SIOjn/6Dksri+LOd4AQachENKVJ/Yfmj0b+mCLADS2HwGlR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3e3:ef06:674c with SMTP id
 e9e14a558f8ab-3e6d7861fd3mr32010065ab.20.1755768183872; Thu, 21 Aug 2025
 02:23:03 -0700 (PDT)
Date: Thu, 21 Aug 2025 02:23:03 -0700
In-Reply-To: <20250821084742.5216-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a6e577.050a0220.3d78fd.0020.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in v9fs_get_tree

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
shift exponent 32 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 6499 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
 v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f470358ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47043a2038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f47037b5fa0 RCX: 00007f470358ebe9
RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
RBP: 00007f4703611e19 R08: 0000200000000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f47037b6038 R14: 00007f47037b5fa0 R15: 00007ffea4e4d958
 </TASK>
---[ end trace ]---


Tested on:

commit:         7fa4d8dc Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=174c0a34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ac96f0580000


