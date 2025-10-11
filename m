Return-Path: <linux-kernel+bounces-849013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D1BCF040
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB419A30AE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E81E500C;
	Sat, 11 Oct 2025 06:10:10 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444771400C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760163010; cv=none; b=BJRbOOi/x4PWezwr08BggcYriG4bosY7WUaVCZ4XJCWUTK5W0AUeNKxxpYLsjDdGCewGnL35+JEb+wVmS1hMqmhQBLAlYu5oMomzWVoDM1VIs/vLArFfeuHAGIazVY/R4LEFf6ZNXF8wMwW51d/h4LkODlbcvQv3HvFKkovVUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760163010; c=relaxed/simple;
	bh=Vbw0bFdgtsPQxHUZ3I+6OaWcl0TBDM9ff+Yx5SvN3WU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fwbumry8f9ZRG1tU7sulqATp1Aq6sonetb9Hbfxg5qEm8NYyUn+tHRNN5znqDVHTbiGg3REKVPlO0SRaZ1d1OOLeDGEisKqaELMShqn7+A7g751XzwYjciQRC2WGQCtnbX+WnYe26Tj6pvI3j0duddzS7+oiegexuFplBB4YUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42f67904af6so245329615ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760163006; x=1760767806;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG2/NLkjTwlpZ4zn0gPq3Za6S41mA8oMQCDK9eODloQ=;
        b=pG5FLwvgC8X7oEkB2hCA8oY9ShlPWLbf0dPx63smypid2Ix3Zm+mfQ3Slcgmd7fOyj
         9XlgnHqMN1WevuaA2100lMEd9O2Qtk1cPxmd/7u4F0JsvUi4rUqzSNE+2mI7Bb6D9NRh
         VuqxoaZnJAit6+7GBKYxb21VQSLKnu4/Q8CHKQ3O0BF4z7d/S277KK6n3OFOAJ2vtU9S
         6CZi8jQ6EGjy/UCHEEIl9Eubo/IpaimykUUjQ9SPCUv3xuEs8bHly6RFPTKcPcLWPTnz
         Mcm6qXotqFV4gjrquSn9CICJsMnl9F0ryNvcpr5SO0xdjTLexYMXuefpnojkuHKAsh8F
         1mFA==
X-Gm-Message-State: AOJu0YzpDH4Hq0jad2XunNaI2HbjbgpIwHJWvCSRvE0D704YLz7mTexG
	yNfoelE85qeDiXjvALw/Oi91Qo2Ezo7wbOI04NX1ICGieRZRA0YQ6d3AIpZr23TOLUK3189EeXT
	0Cj3WVcU2xjTIyH3B/2Z4pSGbHLhAELiu9ukTnXX29O8Sby0/Q2Oqewen+Dz/qg==
X-Google-Smtp-Source: AGHT+IEnoBmBkEukvPHuePktsxeqRorM+ED7YZPOnBgiLd6HfLrtnlAJgf6f6irDYV4XYjs4mGzV/2QqmMbo/cKTAen8yjIuDlU7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348b:b0:42f:9db5:26be with SMTP id
 e9e14a558f8ab-42f9db52aefmr84487865ab.14.1760163006402; Fri, 10 Oct 2025
 23:10:06 -0700 (PDT)
Date: Fri, 10 Oct 2025 23:10:06 -0700
In-Reply-To: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e9f4be.a70a0220.b3ac9.0002.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [virt?] upstream test error: KMSAN:
 use-after-free in vring_map_one_sg
From: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in=
 vring_map_one_sg
Author: jasowang@redhat.com

#syz test

On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
<syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://git.=
k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D138581e258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dad506767107aa=
cda
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac856b8b866cca4=
1352c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce6a737acd38/dis=
k-ba9dac98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7053b626642/vmlinu=
x-ba9dac98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/13f2d7e62179/b=
zImage-ba9dac98.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
>
> 8021q: adding VLAN 0 to HW filter on device bond0
> eql: remember to turn off Van-Jacobson compression on your slave devices
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: use-after-free in vring_map_one_sg+0x290/0x7b0 drivers/virtio=
/virtio_ring.c:401
>  vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
>  virtqueue_add_split drivers/virtio/virtio_ring.c:608 [inline]
>  virtqueue_add+0x32aa/0x6320 drivers/virtio/virtio_ring.c:2281
>  virtqueue_add_outbuf+0x89/0xa0 drivers/virtio/virtio_ring.c:2342
>  virtnet_add_outbuf drivers/net/virtio_net.c:574 [inline]
>  xmit_skb drivers/net/virtio_net.c:3343 [inline]
>  start_xmit+0x274d/0x4860 drivers/net/virtio_net.c:3367
>  __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5257 [inline]
>  xmit_one net/core/dev.c:3845 [inline]
>  dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3861
>  sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
>  __dev_xmit_skb net/core/dev.c:4152 [inline]
>  __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4729
>  dev_queue_xmit include/linux/netdevice.h:3365 [inline]
>  lapbeth_data_transmit+0x352/0x480 drivers/net/wan/lapbether.c:260
>  lapb_data_transmit+0x90/0xf0 net/lapb/lapb_iface.c:447
>  lapb_transmit_buffer+0x260/0x330 net/lapb/lapb_out.c:149
>  lapb_send_control+0x458/0x5b0 net/lapb/lapb_subr.c:251
>  lapb_establish_data_link+0xa6/0xd0 net/lapb/lapb_out.c:-1
>  lapb_device_event+0xb2a/0xbc0 net/lapb/lapb_iface.c:-1
>  notifier_call_chain kernel/notifier.c:85 [inline]
>  raw_notifier_call_chain+0xe0/0x410 kernel/notifier.c:453
>  call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
>  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>  call_netdevice_notifiers net/core/dev.c:2281 [inline]
>  __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
>  netif_change_flags+0x162/0x1e0 net/core/dev.c:9705
>  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>  devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1199
>  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1003
>  sock_do_ioctl+0x9c/0x480 net/socket.c:1254
>  sock_ioctl+0x70b/0xd60 net/socket.c:1375
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0x239/0x400 fs/ioctl.c:583
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
>  x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:=
17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_free_hook mm/slub.c:2440 [inline]
>  slab_free mm/slub.c:6566 [inline]
>  kmem_cache_free+0x2b0/0x1490 mm/slub.c:6676
>  skb_kfree_head net/core/skbuff.c:1046 [inline]
>  skb_free_head+0x13c/0x3a0 net/core/skbuff.c:1060
>  skb_release_data+0x9f7/0xac0 net/core/skbuff.c:1087
>  skb_release_all net/core/skbuff.c:1152 [inline]
>  __kfree_skb+0x6b/0x260 net/core/skbuff.c:1166
>  consume_skb+0x83/0x230 net/core/skbuff.c:1398
>  skb_free_datagram+0x1e/0x30 net/core/datagram.c:324
>  netlink_recvmsg+0xad1/0xfe0 net/netlink/af_netlink.c:1974
>  sock_recvmsg_nosec net/socket.c:1078 [inline]
>  sock_recvmsg+0x2dc/0x390 net/socket.c:1100
>  ____sys_recvmsg+0x193/0x610 net/socket.c:2850
>  ___sys_recvmsg+0x20b/0x850 net/socket.c:2892
>  __sys_recvmsg net/socket.c:2925 [inline]
>  __do_sys_recvmsg net/socket.c:2931 [inline]
>  __se_sys_recvmsg net/socket.c:2928 [inline]
>  __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2928
>  x64_sys_call+0x35f0/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:=
48
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Bytes 0-17 of 18 are uninitialized
> Memory access of size 18 starts at ffff88811a0f1000
>
> CPU: 1 UID: 0 PID: 5441 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT(non=
e)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/18/2025
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

