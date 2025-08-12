Return-Path: <linux-kernel+bounces-764369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED71B22236
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24463B2EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A22E611D;
	Tue, 12 Aug 2025 08:55:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0A1388
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988905; cv=none; b=EQYvm5zGe0vMbN7qmL9TvDydBvjp6LorCmuJVn5vAlh6gFsZx9VoUMvLQm0i2jZwkJiw3Zldl1WYK+MuAgwOpVNnKVyimJx/j7A8f8yXl/k7LI0O/fmsufdlcOY4RYLGxoA6NYmAlrlV9ZCgD9swQcWECXs6lerzq6NaV76GxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988905; c=relaxed/simple;
	bh=5FAwIgCWwLvG75FTJ67snAUC94QQP3/IP6u91l7EtzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m44R1evmEfPPA52oSeMZYgZcaQchlhd5QGEt1M0k9VdF8bvxNbLoYCs97c9dtYtLVIrXLiGWzwPH5swk7ZI5J3lDSVAMarDSlrLXbFRpZteRm/xr+NwtBp5LPjb8bB8yEeDgaEJeHckBbvaPUyXleaZ3RbmFT/3tniMbb30YkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8816e763309so519749039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988903; x=1755593703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4Qvdr3epVEVndEgOI31ELS1GTkpXAidB7+cLopG1qk=;
        b=NsnBEEuW4zkeio4RGgnK8f7siRxDMj11Bt6nNoPiE0lnckeHvAaetNoqm2RFmCOIHs
         uy+OSi3intrtycwAoUld8dLQVncE8UMLntU7/bkGPpBgX8LQQlap8WHNc7ypW22mCoW1
         NWshkcwu/8JXClCve86Zelh1pkVVGw1NXHmHY+JU4e1UBZkoxESJq4bbvo6menD5+BE7
         JrLQUtKLGWiGcVwrP+UqcnITydPWh/6pMUtHPt1WogPqMbhc4r7Ca3T9uoZVowQuS2j/
         RjgVYP+XMIB9BYdOQLfB/pZqpYEWyvq6cputwleOPD9o9aaRu+p/b446PcG5PxVbvIHT
         COcg==
X-Gm-Message-State: AOJu0YwJ76W4D5bcysofphxdX83VwdSGG8lO7wMwvzLakMQc1dLaMvXT
	sR/NuIhv+qdRLitO+Sk7Hr9FQt95uxT4qCAdcyXtLGOfunjyB4twPbMUGz2Sv2UZsirHQiVVJ79
	0FSRLmhUW96AYqZp/wMu0s15DkluqvCdaR+H7pH01UuRWSxle2vtB64/Co4o=
X-Google-Smtp-Source: AGHT+IFgaGYtyNYhhextw5nsjFa8tJpzkF65+NM3DLpTAlC9zZE+TGzK3PRs6MZ+0bnB6MfuF1iBhj/r2PYM9LMfkhHKlStaPdxu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:87c:538b:2a3c with SMTP id
 ca18e2360f4ac-883f1278d0bmr3349742039f.14.1754988902981; Tue, 12 Aug 2025
 01:55:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:55:02 -0700
In-Reply-To: <20250812040733-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b0166.050a0220.7f033.0116.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in virtio_transport_send_pkt_info

DEBUG: zerocopy_fill_skb_from_iter: final skb->len=0, skb->data_len=0
DEBUG: virtio_transport_fill_skb returned err=0, skb->len=0
------------[ cut here ]------------
'send_pkt()' returns 0, but 65536 expected
WARNING: CPU: 0 PID: 5984 at net/vmw_vsock/virtio_transport_common.c:435 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:433
Modules linked in:
CPU: 0 UID: 0 PID: 5984 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g53e760d89498-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:433
Code: 0f 0b 90 bd f2 ff ff ff eb bc e8 0a bf 64 f6 c6 05 ba 87 32 04 01 90 48 c7 c7 80 d8 b8 8c 44 89 f6 4c 89 ea e8 c0 4d 28 f6 90 <0f> 0b 90 90 e9 e1 fe ff ff e8 e1 be 64 f6 90 0f 0b 90 e9 c5 f7 ff
RSP: 0018:ffffc900029cf530 EFLAGS: 00010246
RAX: 3eb3238673451c00 RBX: 0000000000010000 RCX: ffff888034db0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffffff8f879d50 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: dffffc0000000000
R13: 0000000000010000 R14: 0000000000000000 R15: ffff88804fdd20a4
FS:  00007f24a46d96c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000003f000 CR3: 0000000048de9000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 virtio_transport_stream_enqueue net/vmw_vsock/virtio_transport_common.c:1118 [inline]
 virtio_transport_seqpacket_enqueue+0x143/0x1c0 net/vmw_vsock/virtio_transport_common.c:846
 vsock_connectible_sendmsg+0xac7/0x1050 net/vmw_vsock/af_vsock.c:2140
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmmsg+0x227/0x430 net/socket.c:2757
 __do_sys_sendmmsg net/socket.c:2784 [inline]
 __se_sys_sendmmsg net/socket.c:2781 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2781
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24a378ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f24a46d9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f24a39b5fa0 RCX: 00007f24a378ebe9
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f24a3811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000024008094 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f24a39b6038 R14: 00007f24a39b5fa0 R15: 00007ffcbd16bc88
 </TASK>


Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17794af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ad8c34580000


