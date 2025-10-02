Return-Path: <linux-kernel+bounces-840569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91105BB4B21
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368E619E57F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194626B742;
	Thu,  2 Oct 2025 17:29:11 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CF19CC02
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426150; cv=none; b=GeSjEWw2nAwCmI2epg2Ijc4gGOnv3XCsR9V8punsbLtig881H5AY8nzh4zC4nrP2MrcKWPujRnQpTdC5ij4Tw2u6fD3MgNt1jDFQWSbrH/qD4jUU3BXV7aMgJU/UW1IP57k33zBiGCUg8IHHWYI8Yxa644aFQuQk8j54PLgA4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426150; c=relaxed/simple;
	bh=AqhowbJ7NZoFUOYkPZZwUfQ/2szBhRiMno34TH0thKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q0Ax3OVcEG5Lrnw3a3OwVeDDXjvmp0TJ9KMk8+FTd+wOr+fexDrwOk+2l/+d5mgnjJk5bOWhEht6aGo9KYYZOAVzZTKgEixQhDfp7ZdkxKFLIIiJ5ynTbSRA6ARQ3phVkkbt2ffh3EM3r17nzwkfLLoe9TOnNpHh2TOmrkGp2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8874f33d067so137703739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426148; x=1760030948;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOm80GeneGCHwHJxorr7A8OlppBS5dvf3uy3uLShFyk=;
        b=AbN9J7cKIJiesR7KIhx0yQlhNORKtUdxBaT5HkKLqq0o01bDz/ROGs1QreKmvuRnXE
         QWJYKiYingKFQ3p8YUU22qv7VAPH293tkv9UuHdqR73g7ene3wuEHZDbylfp9pOJ+fc8
         HCOdOXeDMhbF05Mrezz5r0swiW3fAPAHyUduCCQ9BDfSlzN+P2PawK9ywxuq18Py9A+Y
         wHp/GVT4XBJVhfpTypqeGs5Qv/nQiA3biafUubeDR2HIxfVVy6UVqL7bLKo/kJWDBlW7
         dCwkw7zkiBE7crcZS2UjFyRuBW6LxCW0I2Q4c4aFlH5LZTNYqEsWWVPDST0FMxUNuT53
         qThg==
X-Forwarded-Encrypted: i=1; AJvYcCVBHK1dcsdObz6pu7HLsRS/J/fh6TMow0imOwYInYcefdjkCJfdDb4IacYzivhISPgTP9B//ELDOWKHdJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xBqPnFtWv009D/3Hd/7JXjiPaW+CsJnJ3w5Pe+/YUFs7joSQ
	vKjYFhtyUXQSCLn5sX4coKM2ppBT6hdXOFvdfCtVjC4Ll7iYJnG5czs1Z7gaO1SSc96+GDjw/ty
	uDP6lP/N2T3lD2QiwotTp5ycV7Bs0ZPvIDiLlywHnb/Zbv7+UXKyO4c01sso=
X-Google-Smtp-Source: AGHT+IFvLBKIMuyZ3lXor0Kd8IDPXsaHIT0Lb7ZussSWh7r0vKf+pgpZ3frF+Ak8qsO9xuSJbQ6i2DOLCRyq5AnNTMGbutpKXADR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:42e:6de5:b42f with SMTP id
 e9e14a558f8ab-42e7ad2e8bbmr3803335ab.14.1759426142977; Thu, 02 Oct 2025
 10:29:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 10:29:02 -0700
In-Reply-To: <CAOeBcHMF2n1Bf5Tdx1kd9kPOAg-nCofANxY_RfV7VmObdvCgeQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68deb65e.a00a0220.102ee.00df.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: chelsyratnawat2001@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hci_cmd_complete_evt

=====================================================
BUG: KMSAN: uninit-value in hci_cmd_complete_evt+0xca3/0xe90 net/bluetooth/hci_event.c:4226
 hci_cmd_complete_evt+0xca3/0xe90 net/bluetooth/hci_event.c:4226
 hci_event_func net/bluetooth/hci_event.c:7566 [inline]
 hci_event_packet+0xcdf/0x1e40 net/bluetooth/hci_event.c:7623
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4071
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3346
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3427
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x233/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 hci_cmd_complete_evt+0xc9c/0xe90 net/bluetooth/hci_event.c:4226
 hci_event_func net/bluetooth/hci_event.c:7566 [inline]
 hci_event_packet+0xcdf/0x1e40 net/bluetooth/hci_event.c:7623
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4071
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3346
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3427
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x233/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 hci_cmd_complete_evt+0x775/0xe90 net/bluetooth/hci_event.c:-1
 hci_event_func net/bluetooth/hci_event.c:7566 [inline]
 hci_event_packet+0xcdf/0x1e40 net/bluetooth/hci_event.c:7623
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4071
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xb91/0x1d80 kernel/workqueue.c:3346
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3427
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x233/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4197 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4292
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:578
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:509 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:496 [inline]
 vhci_write+0x129/0x980 drivers/bluetooth/hci_vhci.c:617
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0xbe2/0x15d0 fs/read_write.c:686
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x3014/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5862 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: hci0 hci_rx_work
=====================================================


Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c065cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40e84ec1e5456fca
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117fa5cd980000


