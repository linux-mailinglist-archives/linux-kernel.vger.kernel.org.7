Return-Path: <linux-kernel+bounces-773596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6858B2A230
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCC11892915
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98D26F286;
	Mon, 18 Aug 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+bt43j+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948B1C8606
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521048; cv=none; b=HkEix5JrNsVg3FJv13YK/jKhhF6EZeoUrJL9bksEe+i44JkMV06TOqIJ+Ryobk9LNb9Fv7cVEuDPYT2XoCoEIQZ9Os+wqB/2p5M9kH+oTb4P/kbpoZ8ttFRwtau7gy1EuayEZmnqHykcCenDgBujmRLB8M+4TEYCbe7Sx9uXXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521048; c=relaxed/simple;
	bh=6aGqCiA6EBBUcNyDlJKSPmjxNo/EcNfKGRu1rG6Q2kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KMWmHIgBtSRaOSAGhqYmTRu8axxBmz1F4LwdRkWNp+KOqd2ttf7tYvl6qmlF4n+K8byUqN34vkHeWHwScq55DJ0zNK/w+/31QoY2S8GOWCsODUM0ZydeQEEKmgK6Fppngy6mkm96xm45XzK73Ek80eTcVSMF+YWDuD6tAkN/Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+bt43j+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755521045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvncjTdzIPX4OxUXStex7TG7rfgQjXRHLf+RsIP8EfI=;
	b=Y+bt43j+1vevJUoKf/ba21WMTQOPRtGpHW/FrFo68ph15o8DGECy3GL52Y5wkNRy2baAYy
	XzYZ/rkPJOcUhUR03gRf8SB3V5qUvrq357R93wMHOAfxn6A8HL+6SmbJntz78x+yLh3sCS
	yy7LowJW1YYktWuFEufqY+6uklJSiGM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-7jkI-QfoPVad0MP5s4H71Q-1; Mon, 18 Aug 2025 08:44:04 -0400
X-MC-Unique: 7jkI-QfoPVad0MP5s4H71Q-1
X-Mimecast-MFC-AGG-ID: 7jkI-QfoPVad0MP5s4H71Q_1755521044
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109acac47so121992411cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521044; x=1756125844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvncjTdzIPX4OxUXStex7TG7rfgQjXRHLf+RsIP8EfI=;
        b=qpvGrF1YbEs6dsGFphu9W371rP1j1ez7qDmYndZD5gi76IQeOQH+NS/lfVOYd6ciRh
         BJ804pzCJn7Q+ztiQxMPz2OX2rTexhNaONXktIoyASVJ2+ga27BzT2Zrw0v/gurCSfhW
         N3o3g0nKHgL7sQiW1h8nwlmaS5xsT5HUQHgzupYD96pS2X5NdPZQRdPZqTskOmNVxd6S
         dHPMJ5ZxVevXEv9r9Z+2La49gfsyRjOmMui/rFl5HcSoPC0t/rDyLLGI55VcMkapyE2+
         HQwV3q3rGvj9TDze2srFuIlnryDCVreDBeZCaZ133AnECvlpTZ1C111uEVm0ugOHz14t
         RUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFklXIBeIDPJFcJgxXdgMS+xj237T0zY9jhYA2ds2X4Efvt7T6AOtkV16K1CmCrfNJ7o0iTWL1rLVqyLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyerLiWM57PE+X9sSDjzeMjtqrPqmLvl4WwU1lUNQ2nhIpIeQqw
	9fpGEAZYaCsS/Mj5v2xGVbr0bqvKey9F4TLcBfiB50FpRqu3MV3omXo1hokwEl1XuVQjTuu227X
	JXSqD2PnbbFzALhFIbxLo6dyslm20ZKrZPV/erO9o0KqXxmV2iIIyWOiQRC9TAbCtjQ==
X-Gm-Gg: ASbGncsDf4jQbhoT7X13mDjP7Nrl7JPWHHgYCtOnACjgqqNIw56IWVye8yFjC6zNryi
	N456WDuaStwOgGEXX/2Qxs9Sfs4NAb9OsFaK+xm9EtNTw6/+3hb3jmahiiEA/xkP47//oMU2/md
	MmlQwvJFQIeQ2c5WdguOB2prLq76O8i9vov/MY6wNQrSHBg1qSOLMiD84EPhaMklffPxFQuZvF5
	ARfNRSMGkIO+Z7qkZ0zoeptkeaMOp2qyhnbke3lnSxvJ4Kt38GQNIJte6R5WUIR6TSVSSEM80k6
	YxCIhWCRufQ1Qn8BP8GEqtDvSr2IT40vyfrLleY2+zvcPPk/kSGnixw8b+igvXoNDlInohCC80G
	p7wpJpCYf05vufGYZUEz3H7Y=
X-Received: by 2002:a05:622a:1308:b0:4b0:be3b:d40 with SMTP id d75a77b69052e-4b11e23b4a2mr148806291cf.40.1755521043609;
        Mon, 18 Aug 2025 05:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCiRnnM4C5nf23TM0fj9m/lD4eCzTRcJhFQw780tv6KUnAh4LnAZT6De6CY7kOKRpxksPajQ==
X-Received: by 2002:a05:622a:1308:b0:4b0:be3b:d40 with SMTP id d75a77b69052e-4b11e23b4a2mr148805961cf.40.1755521042937;
        Mon, 18 Aug 2025 05:44:02 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc1d99fsm51618961cf.4.2025.08.18.05.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:44:02 -0700 (PDT)
Message-ID: <8847edf3-abb6-4efd-8f19-77663556da33@redhat.com>
Date: Mon, 18 Aug 2025 13:43:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw (2)
To: syzbot <syzbot+901524eae72170197041@syzkaller.appspotmail.com>,
 agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68a2184c.050a0220.e29e5.0070.GAE@google.com>
Content-Language: en-US
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68a2184c.050a0220.e29e5.0070.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/08/2025 18:58, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8742b2d8935f Merge tag 'pull-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1414cda2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
> dashboard link: https://syzkaller.appspot.com/bug?extid=901524eae72170197041
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8742b2d8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b561d09cce5a/vmlinux-8742b2d8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0eac1e9113b1/bzImage-8742b2d8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+901524eae72170197041@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
> gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> gfs2: fsid=syz:syz.0: journal 0 mapped with 5 extents in 0ms
> gfs2: fsid=syz:syz.0: first mount done, others may mount
> gfs2: fsid=syz:syz.0: fatal: invalid metadata block - bh = 2051 (type: exp=14, found=8), function = gfs2_quota_init, file = fs/gfs2/quota.c, line = 1430
> gfs2: fsid=syz:syz.0: about to withdraw this file system
> ------------[ cut here ]------------
> kernel BUG at fs/gfs2/util.c:331!

That's strange, this should have been prevented by this syzbot fix:

https://github.com/google/syzkaller/commit/338f25e2408a360bd3af7f03091b1cbda0887a52

Perhaps it hasn't gone live yet?

Andy

> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5364 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00016-g8742b2d8935f #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
> Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 20 7c 25 fe e9 46 fb ff ff e8 86 90 c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
> RSP: 0018:ffffc9000d32f680 EFLAGS: 00010293
> RAX: ffffffff83ff2ada RBX: ffffc9000d32f740 RCX: ffff888000aa0000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffffc9000d32f810 R08: ffff88801fc24253 R09: 1ffff11003f8484a
> R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
> R13: 1ffff92001a65ee4 R14: 1ffff110087b3815 R15: 0000000000000004
> FS:  00007fc82060a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdc3a1909c0 CR3: 0000000042f3e000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  gfs2_metatype_check_ii+0x78/0x90 fs/gfs2/util.c:514
>  gfs2_metatype_check_i fs/gfs2/util.h:129 [inline]
>  gfs2_quota_init+0xfc8/0x1230 fs/gfs2/quota.c:1430
>  gfs2_make_fs_rw+0x181/0x2b0 fs/gfs2/super.c:149
>  gfs2_fill_super+0x1a7b/0x20d0 fs/gfs2/ops_fstype.c:1278
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
>  do_mount fs/namespace.c:4133 [inline]
>  __do_sys_mount fs/namespace.c:4344 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4321
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc81f79038a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc820609e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fc820609ef0 RCX: 00007fc81f79038a
> RDX: 0000200000000400 RSI: 0000200000012500 RDI: 00007fc820609eb0
> RBP: 0000200000000400 R08: 00007fc820609ef0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000200000012500
> R13: 00007fc820609eb0 R14: 00000000000125bb R15: 0000200000000900
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
> Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 20 7c 25 fe e9 46 fb ff ff e8 86 90 c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
> RSP: 0018:ffffc9000d32f680 EFLAGS: 00010293
> RAX: ffffffff83ff2ada RBX: ffffc9000d32f740 RCX: ffff888000aa0000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffffc9000d32f810 R08: ffff88801fc24253 R09: 1ffff11003f8484a
> R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
> R13: 1ffff92001a65ee4 R14: 1ffff110087b3815 R15: 0000000000000004
> FS:  00007fc82060a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdc3a1909c0 CR3: 0000000042f3e000 CR4: 0000000000352ef0
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


