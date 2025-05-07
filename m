Return-Path: <linux-kernel+bounces-637054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7EAAAD403
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FAF1725A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17431B4223;
	Wed,  7 May 2025 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="GbwFUHSd"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6314A4CC
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746588092; cv=none; b=WL5C9fw0BM8lIFu6AnbBL9CNCrWJ3a6njNfm3v5RU52xis5BWNDt4ZJ4c7QXSNui9xHrZMAn71zm51/ZuMf0ZfSev44W7Yxa2fFqU6CVFJDpxYWdJZwkzrPVK6yJWYUO1h7k8ZpFc/FHAx18zgCFDcHtRQYIySLl/01vRvfZ2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746588092; c=relaxed/simple;
	bh=ESxC02pWRNBUcv47DQtf5ZMFYWR7/4c512/3NyZ+IDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kloXkVfQ74s5+Rz5y357L2z6yfL0eZxPsun4gOoVkVswRJ/PjvbLrJhg+iRoQ1eqLBqQc4q8vEr/nRYeYlfuOSDlLzcLoeyq73cJY4aCW1luMqLg1kiJdr4bpNxP/2pDmGtGJMnkzSCgav5TmV1RIHXeesV4eKiG81LefuF2bqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=GbwFUHSd; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d4e91512b4so3735286fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 20:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746588089; x=1747192889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESxC02pWRNBUcv47DQtf5ZMFYWR7/4c512/3NyZ+IDU=;
        b=GbwFUHSdKCAVcdCjH/PlMHr550fdfAhfhnbcTBfqEKZAm2zHrMedWVbUxvYyQOVqaY
         TfoozVBsjFNX372vtBVnf5wNiQTvJBTAGhAckZaRFmQLPSVbwXqWX3jM3OS/qmoNWRWb
         AT3H94qsOJ2z/obTnx+OPQJ9abhmM8FIQd2AM4xvp5QxmzYDstoxVo+zQJxMmAi3cuxJ
         s1FIQIhFQ6wtp//v5eEZ/jGax8PFMG2aP4FDg5PGKEb6SWxjHRZkPNECE3p+44KWOMZz
         aTTRlvwnTVoeQ4KIEyXGYxKLvyoTKPahjBeGQ8KSgeTc8YmkHhYGKLiSs6FFRtxH7SNl
         UZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746588089; x=1747192889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESxC02pWRNBUcv47DQtf5ZMFYWR7/4c512/3NyZ+IDU=;
        b=tFGuVMvVAhuUMqosn+gMlwmRL0D1qR4zmvohhDuteKDE1tImz70daraz3YSriE0PBD
         MInpAUcvWX5ctWHozAJdvyGPxSla44nFbZRJKQKzrR79XXAj1OqJug0MapLAMx+kZwKY
         tHNrCH3oDf3GxFsvyfZuUsRdfqeMoeZDCUKqRMHW2HtxOgbVnBXZuH05m4ULDouqme/x
         ByEuchM285wxqv1oh1DNqn8mzKxw9dmvmTWKw7kCXRM79NsrhDelxTxEiHq/MjN0U5i7
         bkbnW5EFHN7JbyvIC3hhK676pZeB7AwRGzmk2iuxda2TYOAB7UOv8UH7d1ojs5IPCwsn
         gqTw==
X-Forwarded-Encrypted: i=1; AJvYcCWuTaKMgi6DTUKbaW63oMyIjh7mOKP3EN4vrUNilSSOIpDr0lfbKoVQaLIJVw+PR9SFQOyy+Is2lebwQXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzivb92OggDlvt41bljlbA6qPtbKXezangtn/trU9JnPsHDFymh
	Gb+1O6GswVswRjpiAu1M0/zhZdKk6ef/1ieQhNoVcHtYzQW8+H9MEH7LOgBjIOg=
X-Gm-Gg: ASbGncvRjX8ns+aALnBbRqWi8KDY7W6HgBMZQqGCzfPCoeBDqOzX6IZC0ovENxXdZHr
	NwSSDfSEX52h3jTbZBdej9uM8J4C1Iyl4FgEs/h8MQ87ihwvKsXAgwHhY6DQSHOIrDqm/+lg/hC
	8+WSrOqml0goocZTeEB2uvLugTk4MaJNYOL4ubL8a6siZjQyvSCx4WMjQPg7rsRdNT6od7J1+yj
	igyQFVoS7NTtLEs2jetwoHtBAp6Xw7OE9oBoWAVRZaLeHxhaHW66J4jc7PAOrIXGNu3JJ7H1npo
	2nawV7pJtyW7s5RYsgWoUZDzu9EUtDNLBXwad6Jof+HRZqe5P6L8mBP5wcPPmlZ9YF1NrpoafyC
	Ot6ZNyRUD8UWY
X-Google-Smtp-Source: AGHT+IHBKUdfma6drouFQqkr4QYVCCbhGEV8WYWGu8UkttiiwuB2JwmrdCHjxs22uaChUgWsIFpHxw==
X-Received: by 2002:a05:6870:4593:b0:2c2:5ac3:4344 with SMTP id 586e51a60fabf-2db5be42264mr984069fac.15.1746588088806;
        Tue, 06 May 2025 20:21:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:477b:cf13:4e3e:84a2? ([2600:1700:6476:1430:477b:cf13:4e3e:84a2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cb76f34sm325376fac.6.2025.05.06.20.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:21:27 -0700 (PDT)
Message-ID: <d8f947a94233710bffa498d9770ef23469aff073.camel@dubeyko.com>
Subject: Re:  KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "huk23@m.fudan.edu.cn"
	 <huk23@m.fudan.edu.cn>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
 "frank.li@vivo.com"
	 <frank.li@vivo.com>, "baishuoran@hrbeu.edu.cn" <baishuoran@hrbeu.edu.cn>, 
 "jjtan24@m.fudan.edu.cn"
	 <jjtan24@m.fudan.edu.cn>
Date: Tue, 06 May 2025 20:21:26 -0700
In-Reply-To: <1058be22b49415c3065ced5242988ff81e2e9218.camel@ibm.com>
References: 
	<TYSPR06MB71580B4132B73E43C0D86517F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
	 <1058be22b49415c3065ced5242988ff81e2e9218.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kun,

On Fri, 2025-05-02 at 19:28 +0000, Viacheslav Dubeyko wrote:
> On Fri, 2025-05-02 at 04:59 +0000, huk23@m.fudan.edu.cn=C2=A0wrote:
> > Dear Maintainers,
> >=20
> >=20
> >=20
> > When using our customized Syzkaller to fuzz the latest Linux
> > kernel, the following crash (14th)was triggered.
> >=20
> >=20
>=20
>=20

I have the fix and I would like to check it. I am trying to use the C
reproducer for triggering the issue. Probably, I am doing something
wrong. I have complied the kernel by using the shared kernel config and
I have compiled the C reproducer. It works several hours already and I
still cannot trigger the issue. Am I doing something wrong? How long
should I wait the issue reproduction? Could you please share the
correct way of the issue reproduction?

Thanks,
Slava.=20

> >=20
> >=20
> >=20
> > HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> > git tree: upstream
> > Output:
> > https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN/2.
> > =E5=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-
> > bounds%20Read%20in%20hfsplus_bnode_read/14call_trace.txt=C2=A0=20
> > Kernel
> > config:https://github.com/pghk13/Kernel-Bug/blob/main/config.txt=C2=A0=
=20
> > C
> > reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13
> > rc_KASAN/2.=E5=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-
> > bounds%20Read%20in%20hfsplus_bnode_read/14repro.c=C2=A0=20
> > Syzlang reproducer:
> > https://github.com/pghk13/Kernel-Bug/blob/main/1220_6.13rc_KASAN/2.=E5=
=9B=9E=E5=BD=92-11/14-KASAN_%20slab-out-of-bounds%20Read%20in%20hfsplus_bno=
de_read/14repro.txt
> > =C2=A0
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > Our reproducer uses mounts a constructed filesystem image.
> > Problems can arise in hfs_bnode_read functions. node->page[pagenum]
> > causes out-of-bounds reads when accessing memory that exceeds the
> > range of the node's allotted page array.
> > In particular, when a hfs_bnode_dump function reads with this
> > function, an offset or length that exceeds the actual size of the
> > node may be passed in. In the hfsplus_bnode_dump (inferred from the
> > error call stack), when traversing the records in the B-tree node,
> > an incorrect offset calculation may have been used, resulting in
> > data being read out of the allocated memory. Consider adding
> > stricter bounds checking to the hfs_bnode_read function.
> > We have reproduced this issue several times on 6.15-rc1 again.
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin
> > <jjtan24@m.fudan.edu.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
> > Read of size 8 at addr ffff8880439aefc0 by task syz-
> > executor201/9472
> >=20
> >=20
> > CPU: 1 UID: 0 PID: 9472 Comm: syz-executor201 Not tainted 6.15.0-
> > rc1 #1 PREEMPT(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-
> > 1ubuntu1.1 04/01/2014
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0dump_stack_lvl+0x116/0x1b0
> > =C2=A0print_report+0xc1/0x630
> > =C2=A0kasan_report+0x96/0xd0
> > =C2=A0hfsplus_bnode_read+0x268/0x290
> > =C2=A0hfsplus_bnode_dump+0x2c6/0x3a0
> > =C2=A0hfsplus_brec_remove+0x3e4/0x4f0
> > =C2=A0__hfsplus_delete_attr+0x28e/0x3a0
> > =C2=A0hfsplus_delete_all_attrs+0x13e/0x270
> > =C2=A0hfsplus_delete_cat+0x67f/0xb60
> > =C2=A0hfsplus_unlink+0x1ce/0x7d0
> > =C2=A0vfs_unlink+0x30e/0x9f0
> > =C2=A0do_unlinkat+0x4d9/0x6a0
> > =C2=A0__x64_sys_unlink+0x40/0x50
> > =C2=A0do_syscall_64+0xcf/0x260
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fcd9a901f5b
> > Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3
> > 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05
> > <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffeefb025d8 EFLAGS: 00000206 ORIG_RAX:
> > 0000000000000057
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcd9a901f5b
> > RDX: 00007ffeefb02600 RSI: 00007ffeefb02600 RDI: 00007ffeefb02690
> > RBP: 00007ffeefb02690 R08: 0000000000000001 R09: 00007ffeefb02460
> > R10: 00000000fffffffb R11: 0000000000000206 R12: 00007ffeefb03790
> > R13: 00005555641a1bb0 R14: 00007ffeefb025f8 R15: 0000000000000001
> > =C2=A0</TASK>
> >=20
> >=20
> > Allocated by task 9472:
> > =C2=A0kasan_save_stack+0x24/0x50
> > =C2=A0kasan_save_track+0x14/0x30
> > =C2=A0__kasan_kmalloc+0xaa/0xb0
> > =C2=A0__kmalloc_noprof+0x214/0x600
> > =C2=A0__hfs_bnode_create+0x105/0x750
> > =C2=A0hfsplus_bnode_find+0x1e5/0xb70
> > =C2=A0hfsplus_brec_find+0x2b2/0x530
> > =C2=A0hfsplus_find_attr+0x12e/0x170
> > =C2=A0hfsplus_delete_all_attrs+0x16f/0x270
> > =C2=A0hfsplus_delete_cat+0x67f/0xb60
> > =C2=A0hfsplus_rmdir+0x106/0x1b0
> > =C2=A0vfs_rmdir+0x2ae/0x680
> > =C2=A0do_rmdir+0x2d1/0x390
> > =C2=A0__x64_sys_rmdir+0x40/0x50
> > =C2=A0do_syscall_64+0xcf/0x260
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> >=20
> > The buggy address belongs to the object at ffff8880439aef00
> > =C2=A0which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 40 bytes to the right of
> > =C2=A0allocated 152-byte region [ffff8880439aef00, ffff8880439aef98)
> >=20
> >=20
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> > pfn:0x439ae
> > anon flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 04fff00000000000 ffff88801b4423c0 0000000000000000
> > dead000000000001
> > raw: 0000000000000000 0000000080100010 00000000f5000000
> > 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask
> > 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1,
> > tgid 1 (swapper/0), ts 46334294792, free_ts 46209226995
> > =C2=A0prep_new_page+0x1b0/0x1e0
> > =C2=A0get_page_from_freelist+0x1649/0x30f0
> > =C2=A0__alloc_frozen_pages_noprof+0x2fd/0x6d0
> > =C2=A0alloc_pages_mpol+0x209/0x550
> > =C2=A0new_slab+0x24b/0x340
> > =C2=A0___slab_alloc+0xf0c/0x17c0
> > =C2=A0__slab_alloc.isra.0+0x56/0xb0
> > =C2=A0__kmalloc_cache_noprof+0x291/0x4b0
> > =C2=A0call_usermodehelper_setup+0xb2/0x360
> > =C2=A0kobject_uevent_env+0xf82/0x16c0
> > =C2=A0driver_bound+0x15b/0x220
> > =C2=A0really_probe+0x56e/0x990
> > =C2=A0__driver_probe_device+0x1df/0x450
> > =C2=A0driver_probe_device+0x4c/0x1a0
> > =C2=A0__device_attach_driver+0x1e4/0x2d0
> > =C2=A0bus_for_each_drv+0x14b/0x1d0
> > page last free pid 1277 tgid 1277 stack trace:
> > =C2=A0__free_frozen_pages+0x7cd/0x1320
> > =C2=A0__put_partials+0x14c/0x170
> > =C2=A0qlist_free_all+0x50/0x130
> > =C2=A0kasan_quarantine_reduce+0x168/0x1c0
> > =C2=A0__kasan_slab_alloc+0x67/0x90
> > =C2=A0__kmalloc_cache_noprof+0x169/0x4b0
> > =C2=A0usb_control_msg+0xbc/0x4a0
> > =C2=A0hub_ext_port_status+0x12c/0x6b0
> > =C2=A0hub_activate+0x9f6/0x1aa0
> > =C2=A0process_scheduled_works+0x5de/0x1bd0
> > =C2=A0worker_thread+0x5a9/0xd10
> > =C2=A0kthread+0x447/0x8a0
> > =C2=A0ret_from_fork+0x48/0x80
> > =C2=A0ret_from_fork_asm+0x1a/0x30
> >=20
> >=20
> > Memory state around the buggy address:
> > =C2=A0ffff8880439aee80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > =C2=A0ffff8880439aef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffff8880439aef80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^
> > =C2=A0ffff8880439af000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > =C2=A0ffff8880439af080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> >=20
> >=20
> >=20
> > thanks,
> > Kun Hu
>=20

