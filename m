Return-Path: <linux-kernel+bounces-850065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA72BD1C28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC771188759F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3A2E888A;
	Mon, 13 Oct 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5rZfswh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E532E7F1D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340072; cv=none; b=DVDhyt4HcPSCnvhzEnSfVP9+S8dGc2AO5Ap9sZGjV9xR2W7nuOzcmMh1lM96pLrLtIkh6zsRERdVVyYdOyG9Sc0Xqf6Q9IJ5JdXH8xWUyMTHk1hQ11gCkJCAiSLIVEtPqFBJY3BW/OMevJpLBnUtkj6mIWIVMK7G/+pFJGe9BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340072; c=relaxed/simple;
	bh=K3/wQRtd80mOKiZ1UCIsJf2E4sV5H9LLZO/RFZkGrkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc5kJj+X15eaZYjOltFxHh1JEgiFbDXwG/aj9FpgC9hyphxtbBUvPIPFTvmSyWlB7BRgK0gYLLA/VooG3BSnQnp2GtQq3sLpHIP0gMEf1rDoEHyS27yhRHHU9QqDzRHS0/N9n9KC3U+OCyh4ca6RA/U8wkMC1ligIHgap4GHKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5rZfswh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760340067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DsNIaMyBz10vgtB+Efo27PvdXT6csX5FTBsYy6s6x6w=;
	b=L5rZfswhvAlYSKyKcM/2FBOFF8j5Rj9w5Z0b/wV80RknfIA+AmlZUsN0syFo8J1MpOPStr
	E8H50BqsxL7gWyGtV87RpyPQKu4zJV3ceppRHwpvxfLvweqcYdXql62DZi+S/xHioKPCSD
	OpHlApjX+Dv2QcZvonOMlfKD1b0gMgo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-8oYvehHwOwa2oAJRxC6T6w-1; Mon, 13 Oct 2025 03:21:03 -0400
X-MC-Unique: 8oYvehHwOwa2oAJRxC6T6w-1
X-Mimecast-MFC-AGG-ID: 8oYvehHwOwa2oAJRxC6T6w_1760340063
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so10357621a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760340063; x=1760944863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsNIaMyBz10vgtB+Efo27PvdXT6csX5FTBsYy6s6x6w=;
        b=o5h0zySL9PSHzcbMGBogV3m8IgB8Em8yxfWMR8lT0q3sWsgPHRu3deb9sOh/NuSvFz
         vzpuCfdPIxt/AY1/M0h7yuLoYcWpkKs7nvF1GJSWyB9ZLAi4y5n0Z307sG/EU2m1u/Tu
         6ld5Erc520DJqRw8KiDHiMxlkbSeGwZpGdDUej3+oe/qkuJxiZjMFC6JlFQCX6nrHISk
         fZ30qDPfwilaw08o+/AAy/ZCfFZsEJMuVzfAdfnmsqFIxv3A7LRUjL3e61aSowdqz1fA
         RRupr0fsW0sb8paVaQk1EeNRjkoCc/GH/2SIQpRJaWn/1x45pNRfG62+n5u+YbIbF3LL
         S6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWDEfZI8KXqCo4qGq6ZZckVdiaMRyfx5jVr+1MZ3CXlU8NC1YGOS+9SgF4TvoB2jrms1PbMRfuOuhAaZRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxthhel/hs1YBDnyEW+bHmSC9dPtxiKZaMxyqOOW2qFYq/GgSfH
	izbV4vC/RMsfuJhwUBDiqgM9W4qhFEa9UFZQYw/KRKqjAtNDRmV3pl9oVLzP4vem5l3dpawgwA4
	4N2TDgg2uBVMibhlo4EDnwb7OSlLZwGqboECALZVXisbJRfBJiHMQAkbc6JcQUkXyX7zGYnb4/R
	WbgZ1fzTK6sJqN/psj7/9c8AV0SVpk0fErnx+ic4or
X-Gm-Gg: ASbGncvIj3yL9BdcplksB99/saTB3o+dwcHkU72pnw7pmZ4aLjhZIeongnEpa2PfjOm
	f2vq5JfEK1Ikjb6hGOZvLVVOQ1N4d9E9dJhbZTnulSnDOUJCPIeAoRzpvM+TdAMo/nn/KZXuvUk
	opsSCyYt/d4IQGyEStzg==
X-Received: by 2002:a17:90b:1b04:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-33b513861cdmr26644478a91.29.1760340062552;
        Mon, 13 Oct 2025 00:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw1gY3v00c4iLHb6DyWFBpwCD66C6NGAoEwZCmtsHzKIWYpalJT6pFLsw21PDBBq1ho2TXzucoqajT6furwVo=
X-Received: by 2002:a17:90b:1b04:b0:32b:cb05:849a with SMTP id
 98e67ed59e1d1-33b513861cdmr26644453a91.29.1760340062037; Mon, 13 Oct 2025
 00:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com> <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
In-Reply-To: <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Oct 2025 15:20:50 +0800
X-Gm-Features: AS18NWAEI4kEYPZOrkp67ratHV7y4NA8maUiR-biV_mfbcb-8aWAUUh7QCfvVB4
Message-ID: <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: multipart/mixed; boundary="0000000000001516680641051cef"

--0000000000001516680641051cef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Adding Paolo.
>
> On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > #syz test
> >
> > On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> > <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>
> Paolo, it looks like the GSO tunnel features will leave uninitialized
> vnet header field which trigger KMSAN warning.
>
> Please have a look at the patch (which has been tested by syzbot) or
> propose another one.

Forget the attachment.

Thanks

>
> Thanks
>
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    ba9dac987319 Merge tag 'libnvdimm-for-6.18' of git://=
git.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D138581e25=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dad5067671=
07aacda
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dac856b8b866=
cca41352c
> > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909=
b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ce6a737acd38=
/disk-ba9dac98.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/d7053b626642/vm=
linux-ba9dac98.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/13f2d7e621=
79/bzImage-ba9dac98.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
> > >
> > > 8021q: adding VLAN 0 to HW filter on device bond0
> > > eql: remember to turn off Van-Jacobson compression on your slave devi=
ces
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > BUG: KMSAN: use-after-free in vring_map_one_sg+0x290/0x7b0 drivers/vi=
rtio/virtio_ring.c:401
> > >  vring_map_one_sg+0x290/0x7b0 drivers/virtio/virtio_ring.c:401
> > >  virtqueue_add_split drivers/virtio/virtio_ring.c:608 [inline]
> > >  virtqueue_add+0x32aa/0x6320 drivers/virtio/virtio_ring.c:2281
> > >  virtqueue_add_outbuf+0x89/0xa0 drivers/virtio/virtio_ring.c:2342
> > >  virtnet_add_outbuf drivers/net/virtio_net.c:574 [inline]
> > >  xmit_skb drivers/net/virtio_net.c:3343 [inline]
> > >  start_xmit+0x274d/0x4860 drivers/net/virtio_net.c:3367
> > >  __netdev_start_xmit include/linux/netdevice.h:5248 [inline]
> > >  netdev_start_xmit include/linux/netdevice.h:5257 [inline]
> > >  xmit_one net/core/dev.c:3845 [inline]
> > >  dev_hard_start_xmit+0x22c/0xa30 net/core/dev.c:3861
> > >  sch_direct_xmit+0x3b2/0xcf0 net/sched/sch_generic.c:344
> > >  __dev_xmit_skb net/core/dev.c:4152 [inline]
> > >  __dev_queue_xmit+0x3588/0x5e60 net/core/dev.c:4729
> > >  dev_queue_xmit include/linux/netdevice.h:3365 [inline]
> > >  lapbeth_data_transmit+0x352/0x480 drivers/net/wan/lapbether.c:260
> > >  lapb_data_transmit+0x90/0xf0 net/lapb/lapb_iface.c:447
> > >  lapb_transmit_buffer+0x260/0x330 net/lapb/lapb_out.c:149
> > >  lapb_send_control+0x458/0x5b0 net/lapb/lapb_subr.c:251
> > >  lapb_establish_data_link+0xa6/0xd0 net/lapb/lapb_out.c:-1
> > >  lapb_device_event+0xb2a/0xbc0 net/lapb/lapb_iface.c:-1
> > >  notifier_call_chain kernel/notifier.c:85 [inline]
> > >  raw_notifier_call_chain+0xe0/0x410 kernel/notifier.c:453
> > >  call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
> > >  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
> > >  call_netdevice_notifiers net/core/dev.c:2281 [inline]
> > >  __dev_notify_flags+0x20d/0x3c0 net/core/dev.c:-1
> > >  netif_change_flags+0x162/0x1e0 net/core/dev.c:9705
> > >  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
> > >  devinet_ioctl+0x1186/0x2500 net/ipv4/devinet.c:1199
> > >  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1003
> > >  sock_do_ioctl+0x9c/0x480 net/socket.c:1254
> > >  sock_ioctl+0x70b/0xd60 net/socket.c:1375
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> > >  __se_sys_ioctl+0x239/0x400 fs/ioctl.c:583
> > >  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
> > >  x64_sys_call+0x1cbc/0x3e30 arch/x86/include/generated/asm/syscalls_6=
4.h:17
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Uninit was created at:
> > >  slab_free_hook mm/slub.c:2440 [inline]
> > >  slab_free mm/slub.c:6566 [inline]
> > >  kmem_cache_free+0x2b0/0x1490 mm/slub.c:6676
> > >  skb_kfree_head net/core/skbuff.c:1046 [inline]
> > >  skb_free_head+0x13c/0x3a0 net/core/skbuff.c:1060
> > >  skb_release_data+0x9f7/0xac0 net/core/skbuff.c:1087
> > >  skb_release_all net/core/skbuff.c:1152 [inline]
> > >  __kfree_skb+0x6b/0x260 net/core/skbuff.c:1166
> > >  consume_skb+0x83/0x230 net/core/skbuff.c:1398
> > >  skb_free_datagram+0x1e/0x30 net/core/datagram.c:324
> > >  netlink_recvmsg+0xad1/0xfe0 net/netlink/af_netlink.c:1974
> > >  sock_recvmsg_nosec net/socket.c:1078 [inline]
> > >  sock_recvmsg+0x2dc/0x390 net/socket.c:1100
> > >  ____sys_recvmsg+0x193/0x610 net/socket.c:2850
> > >  ___sys_recvmsg+0x20b/0x850 net/socket.c:2892
> > >  __sys_recvmsg net/socket.c:2925 [inline]
> > >  __do_sys_recvmsg net/socket.c:2931 [inline]
> > >  __se_sys_recvmsg net/socket.c:2928 [inline]
> > >  __x64_sys_recvmsg+0x20e/0x3d0 net/socket.c:2928
> > >  x64_sys_call+0x35f0/0x3e30 arch/x86/include/generated/asm/syscalls_6=
4.h:48
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > Bytes 0-17 of 18 are uninitialized
> > > Memory access of size 18 starts at ffff88811a0f1000
> > >
> > > CPU: 1 UID: 0 PID: 5441 Comm: dhcpcd Not tainted syzkaller #0 PREEMPT=
(none)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 08/18/2025
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >

--0000000000001516680641051cef
Content-Type: application/octet-stream; 
	name="0001-virtio-net-zero-unused-hash-fields.patch"
Content-Disposition: attachment; 
	filename="0001-virtio-net-zero-unused-hash-fields.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgot0izh0>
X-Attachment-Id: f_mgot0izh0

RnJvbSA0M2RlOWYzYmIyMmJiZGYyMmE3ZjUwZWEwNmZlOTFmZWEwMzM3ODMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBTYXQsIDExIE9jdCAyMDI1IDE1OjM4OjEyICswODAwClN1YmplY3Q6IFtQQVRDSF0gdmlydGlv
LW5ldDogemVybyB1bnVzZWQgaGFzaCBmaWVsZHMKQ29udGVudC10eXBlOiB0ZXh0L3BsYWluCgpT
aWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgotLS0KIGluY2x1
ZGUvbGludXgvdmlydGlvX25ldC5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRl
L2xpbnV4L3ZpcnRpb19uZXQuaAppbmRleCAyMGUwNTg0ZGIxZGQuLjRkMTc4MDg0OGQwZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fbmV0LmgKKysrIGIvaW5jbHVkZS9saW51eC92
aXJ0aW9fbmV0LmgKQEAgLTQwMSw2ICs0MDEsMTAgQEAgdmlydGlvX25ldF9oZHJfdG5sX2Zyb21f
c2tiKGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsCiAJaWYgKCF0bmxfaGRyX25lZ290aWF0ZWQp
CiAJCXJldHVybiAtRUlOVkFMOwogCisgICAgICAgIHZoZHItPmhhc2hfaGRyLmhhc2hfdmFsdWUg
PSAwOworICAgICAgICB2aGRyLT5oYXNoX2hkci5oYXNoX3JlcG9ydCA9IDA7CisgICAgICAgIHZo
ZHItPmhhc2hfaGRyLnBhZGRpbmcgPSAwOworCiAJLyogTGV0IHRoZSBiYXNpYyBwYXJzaW5nIGRl
YWwgd2l0aCBwbGFpbiBHU08gZmVhdHVyZXMuICovCiAJc2tiX3NoaW5mbyhza2IpLT5nc29fdHlw
ZSAmPSB+dG5sX2dzb190eXBlOwogCXJldCA9IHZpcnRpb19uZXRfaGRyX2Zyb21fc2tiKHNrYiwg
aGRyLCB0cnVlLCBmYWxzZSwgdmxhbl9obGVuKTsKLS0gCjIuNDIuMAoK
--0000000000001516680641051cef--


