Return-Path: <linux-kernel+bounces-742978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 028CFB0F900
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0617B257D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80621ABC1;
	Wed, 23 Jul 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RJCcuhdS"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4101F4C87
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291586; cv=none; b=hzkZDA6CrubuQSA9YSUWlFI3papB9U+AZZxM5NULkEm0ObY+v4CRYXCHl9z6v1PzSYndqu5Y8iVVDk0WrdSPnCmFwQRKQMtXjD+yREUocjF793z5bpvhZTgiMnSZh0TkVnLoyoXbCOseWKKsAfb3Zp6xsF6gf8KCa3/L5wJCOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291586; c=relaxed/simple;
	bh=kQOGOP01pSM7xcQu6zAMFe/5lWreS5ZTL0xJ52qp1Mk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qB0baZz4fPpFNl8tPEX7z/2vXldovG3DOrBAYzp4Y+e5pJR4HrBK9YgxH9s5gu+j/R8fIUdMOPmU8wMZ6/1yt6sMv0OL4STmdN6CbkGh6Z3QmwXHRXG+U6B0+M4LBGmKmteChnx2LsyXEersKoU91GoiF9uEemjLreglsqnZWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RJCcuhdS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e64b430daso1637827b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753291583; x=1753896383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQOGOP01pSM7xcQu6zAMFe/5lWreS5ZTL0xJ52qp1Mk=;
        b=RJCcuhdSybXErriM3EqNP3oTFZglQAxcVpozWXAjnOOn3QKO/rpY+EP1UMTKTs3KFN
         cEgcMdejiyMvtF0prK7VSiTmQRAG1Yu4MBual6gePsmj5lnQA6Y05DR5jX6YS7n781oD
         7THid/i/C7OuxjKmKb3WIouX/YYs7lD+Mk8hssMR6c3/6PfiJ2dvd95EGdoVx3dmAKOw
         c+ia8qkZHpF82FZpQFaaK523MdCvs3+CTVAPymuh7r8NzmFXW3l/ccQ+BBDRjgcAlwcW
         XbXitFoTGOmX3HMubx0r9JIKUhjlSYC7bnDFCHnLpX9PYzU6TnG3qYxEw6o38T7o0LnM
         3m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291583; x=1753896383;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQOGOP01pSM7xcQu6zAMFe/5lWreS5ZTL0xJ52qp1Mk=;
        b=OKWNi0DEvrfXJOEW13UJu8nAtvrw/uC/6NlEy0nuSA6TvNGuGI245doMtwcb1F5W4W
         fFp0ltQscU0oMc0HZs8zRleVlAbKNcIf1dKgUaeAzgqB7/GrAviTy/JfkIeK3kcRa7bB
         QE+SZ3J+ThFWPm/6Femx03fbDCkzSvj9yJH1o82OsigoC5g6K0ZbdHtIaOyGTHLu/Wj5
         M5vdQSQtN0XUZXNDzT+Z7I6u+KTKHldKXzDVqQR2KFrTx/QnoakfL5hucN+eXFLILtgb
         2PIKyS0FMdYg84RR9LW0MSsVX8ir62OPE0GIXxBXAxagHJa0TdXRnrsD1oUzYZ1Dffo+
         jV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWVRlnQFdE3NUzW8X1pnB12QKMVbQYqVGnEMZ/4yKqGGLKPBeo+gDulouYWWEjmVI31YU1q2WSTjIPXk9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYwBM0JH1V51Ukk7KNVJNqeQfIsRVPg8V4zOhmnScBsbyNAhZ
	EydwjZRYaJroJSCGfYo9LclY13Ool2lXV3qzc0D38hcmpH+KGKqjCHuDG9v5YGBGXL0=
X-Gm-Gg: ASbGncuKUcZfjwLMoCc8w7KCw9J8f4jvRz+69hCnGzU1+Cs9XqQ+wucvk1GVnh7zWFb
	5VwSr0paBGoaRy4jt/gb3n+wfvfGNMZFF/bmuHeXhOIzEIDDRz0VvcD6aDf3p1u/Z9Aw70VsLRd
	4ZEw89Vrrp++gl4SzKl0dxgJJBopf5uNjYKJMSMbthZUy+toyoQjSOITH9VgeNtyspqKmcsAviF
	xbfJp9ng1is2opJHztjYym2u0xwIrLr92rvPOHR1Z0hpapAy+Q30Q/dX8sqJlqLXtTzMD2GgS9p
	zkFJXmnhdIlRLxM8lL3N1Gbp4bQG53aGlrBuJ6UyC/so3H07mnwtKWubdPGCMBhCiA0zQPyxXJa
	Fc2+xjPyShAa+Xd7hKUi8f6umZkrVfBS14f9HBeezv+Qbehm0OljjlHxBVPssvoCAj+M=
X-Google-Smtp-Source: AGHT+IHXqd7jzHiWyJ8k+HX9d0putuvpnUUY+65E21SAM0UV9VtTRhLDcAqn+ICc0ngR6NExaznPwQ==
X-Received: by 2002:a05:690c:4981:b0:70e:7ae4:5a3e with SMTP id 00721157ae682-719b414a9b4mr43973847b3.11.1753291583107;
        Wed, 23 Jul 2025 10:26:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8821:3678:1056:f51? ([2600:1700:6476:1430:8821:3678:1056:f51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719a9712b64sm8308517b3.47.2025.07.23.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:26:22 -0700 (PDT)
Message-ID: <485fb3da73d92f47fda626f176d65dfbeac9a6d8.camel@dubeyko.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Wed, 23 Jul 2025 10:26:21 -0700
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
References: <68811963.050a0220.248954.0005.GAE@google.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 10:18 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20

Issue has been created:
https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/227

Thanks,
Slava.

> HEAD commit:=C2=A0=C2=A0=C2=A0 89be9a83ccf1 Linux 6.16-rc7
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D17ac1b82580000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3D8adfe52da0de2761
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D41ba9c82bce8d7101765
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 20.1.7
> (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD
> 20.1.7
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D1771ef22580000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D11f764f0580000
>=20
> Downloadable assets:
> disk image (non-bootable):
> https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_di=
sk-89be9a83.raw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/a3f5f507f252/vmlinux-89be9a8=
3.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/a8f9b92c57a6/bzImage-89be9a8=
3.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/f02d92e4771f/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
>=20
> loop0: detected capacity change from 0 to 64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: out-of-bounds in hfs_bnode_move+0xea/0x130
> fs/hfs/bnode.c:143
> Read of size 18446744073709486080 at addr ffff888000994400 by task
> syz.0.16/5547
>=20
> CPU: 0 UID: 0 PID: 5547 Comm: syz.0.16 Not tainted 6.16.0-rc7-
> syzkaller #0 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
> =C2=A0<TASK>
> =C2=A0dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0xca/0x230 mm/kasan/report.c:480
> =C2=A0kasan_report+0x118/0x150 mm/kasan/report.c:593
> =C2=A0check_region_inline mm/kasan/generic.c:-1 [inline]
> =C2=A0kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
> =C2=A0__asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
> =C2=A0hfs_bnode_move+0xea/0x130 fs/hfs/bnode.c:143
> =C2=A0hfs_brec_remove+0x467/0x550 fs/hfs/brec.c:222
> =C2=A0hfs_cat_move+0x6fb/0x960 fs/hfs/catalog.c:364
> =C2=A0hfs_rename+0x1dc/0x2d0 fs/hfs/dir.c:299
> =C2=A0vfs_rename+0xb99/0xec0 fs/namei.c:5137
> =C2=A0do_renameat2+0x878/0xc50 fs/namei.c:5286
> =C2=A0__do_sys_rename fs/namei.c:5333 [inline]
> =C2=A0__se_sys_rename fs/namei.c:5331 [inline]
> =C2=A0__x64_sys_rename+0x82/0x90 fs/namei.c:5331
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f11db18e9a9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd56ec9fe8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000052
> RAX: ffffffffffffffda RBX: 00007f11db3b5fa0 RCX: 00007f11db18e9a9
> RDX: 0000000000000000 RSI: 0000200000000780 RDI: 00002000000003c0
> RBP: 00007f11db210d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f11db3b5fa0 R14: 00007f11db3b5fa0 R15: 0000000000000002
> =C2=A0</TASK>
>=20
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x35
> pfn:0x994
> memcg:ffff888030a98000
> anon flags:
> 0x7ff00000020908(uptodate|active|owner_2|swapbacked|node=3D0|zone=3D0|las
> tcpupid=3D0x7ff)
> raw: 007ff00000020908 0000000000000000 dead000000000122
> ffff888059a96cc1
> raw: 0000000000000035 0000000000000000 00000001ffffffff
> ffff888030a98000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Movable, gfp_mask
> 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5548, tgid 5548
> (dhcpcd-run-hook), ts 123108746961, free_ts 121368908469
> =C2=A0set_page_owner include/linux/page_owner.h:32 [inline]
> =C2=A0post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
> =C2=A0prep_new_page mm/page_alloc.c:1712 [inline]
> =C2=A0get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
> =C2=A0__alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
> =C2=A0alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
> =C2=A0folio_alloc_mpol_noprof mm/mempolicy.c:2438 [inline]
> =C2=A0vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2473
> =C2=A0folio_prealloc+0x30/0x180 mm/memory.c:-1
> =C2=A0wp_page_copy mm/memory.c:3569 [inline]
> =C2=A0do_wp_page+0x1231/0x5800 mm/memory.c:4030
> =C2=A0handle_pte_fault mm/memory.c:6085 [inline]
> =C2=A0__handle_mm_fault+0x1144/0x5620 mm/memory.c:6212
> =C2=A0handle_mm_fault+0x40a/0x8e0 mm/memory.c:6381
> =C2=A0do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
> =C2=A0handle_page_fault arch/x86/mm/fault.c:1476 [inline]
> =C2=A0exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
> =C2=A0asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> page last free pid 5509 tgid 5509 stack trace:
> =C2=A0reset_page_owner include/linux/page_owner.h:25 [inline]
> =C2=A0free_pages_prepare mm/page_alloc.c:1248 [inline]
> =C2=A0free_unref_folios+0xc66/0x14d0 mm/page_alloc.c:2763
> =C2=A0folios_put_refs+0x559/0x640 mm/swap.c:992
> =C2=A0free_pages_and_swap_cache+0x4be/0x520 mm/swap_state.c:267
> =C2=A0__tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
> =C2=A0tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
> =C2=A0tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
> =C2=A0tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
> =C2=A0tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
> =C2=A0exit_mmap+0x44c/0xb50 mm/mmap.c:1297
> =C2=A0__mmput+0x118/0x420 kernel/fork.c:1121
> =C2=A0exit_mm+0x1da/0x2c0 kernel/exit.c:581
> =C2=A0do_exit+0x648/0x22e0 kernel/exit.c:952
> =C2=A0do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
> =C2=A0__do_sys_exit_group kernel/exit.c:1116 [inline]
> =C2=A0__se_sys_exit_group kernel/exit.c:1114 [inline]
> =C2=A0__x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1114
> =C2=A0x64_sys_call+0x21ba/0x21c0
> arch/x86/include/generated/asm/syscalls_64.h:232
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Memory state around the buggy address:
> =C2=A0ffff888000994300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0ffff888000994380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff888000994400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff888000994480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0ffff888000994500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before
> testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

