Return-Path: <linux-kernel+bounces-852900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236DBDA318
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35EF3E13F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A21EEA5F;
	Tue, 14 Oct 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndGMd3vk"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9F2FFDCA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453949; cv=none; b=asF/ZnLp4/QVGMSGax7c9YBTDn9bX6+t8p/RoiRIl19Us7qLR1IkOjxlu4EThHOajUxpIQigesW+b8Wvo82/qLWop9bVhNfuA2Je0nDrOEG6yFsB5uBduYz+QyCYrvHD35g86xWQSn4a76zyU1GJa9/3n55fLWW/zFD18Re5fd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453949; c=relaxed/simple;
	bh=NhtmRhm7ndhen0e3a4IWvzrXrj6/aX6wOhDZxyZza5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J73uYNeeglNkxdRcK9YUvXDD9vzr9yNILBSTE+lPr8sRWCzP35AUgLSVrBoa/fX8AOGgvwB/wiW4FRDRmW6EHJMgrSf31aqG5cavELUIVHUAkksko7bll1rsEN2Wf1537vHyepVpT/aRzPYF1j9Rb1hjeDSwYj15zHBKL/5nJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndGMd3vk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f8116a130so2483135b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760453946; x=1761058746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkA3DsnAjaOe1kWah6dgRh2HdZ2TK46Tu48uO23EzeA=;
        b=ndGMd3vk8jM1pIYbJnfvoTiyi8FoRhleqwrBh31iZR28Wn3YgnoAWe323XjA24DQWW
         3RIS2gjhnka7kANi06kgYbRZtTEOeJrzScSbvpoCqM7tMmr5xAlMSTD2BVeala0UFu1n
         D2RDDyeypXc4xRZXQJZ4Y3PV7O1QGVMuXt7eZIKyfRKUh2yJk6RMSecQymqu4pVaojO2
         8Enm5uC2r1Set8a1vnegn/f/MPYzDZ23e6s8GXYPnQtVgT3FrUUWmJtNLSfMBgFT5iJL
         DCVB4jEyAR7zNqInLJ1HinK1nfxOy4hyu5hh+uh5W4pJxqgNjTYXWcHx16tv5wZf9hz7
         o6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453946; x=1761058746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkA3DsnAjaOe1kWah6dgRh2HdZ2TK46Tu48uO23EzeA=;
        b=Ha8k9iA9d8EsWGAZBd78NsFvJBr0n1ohGtnwnwAy4eSMhO75V4D+2ojq00YmOqP7pR
         wGy7D9EkHIEMaslpww9OFhraid7olr9AJ0Dsv+e2ptB//0C+AXGGghGsY/m7qOzfCjD/
         HEQVHUYgIwr7doPnQjVZh6Li0gLUG/WMZ3W8L97j6lGcVr8kyMGzu9mF8aojFLewKeL4
         +HY31KVVwU8b8E7OlwT2Q/fYD5S+YSnT0ST5AHXd2LC/o5Ro5Q6bJJDPOCcZuQnGuCSO
         0a8ByUMfL4/vNL2ArEv0hyba10Q+U175as6xWDVxAJNYDHrPm49LMMZPEQvU3acuuGVa
         Wbhg==
X-Forwarded-Encrypted: i=1; AJvYcCVGrtZSvxhh48XP4QlZgWjFp9OYYpJZDkmTyueamg62sabiJt9wDRkkLevroyVnuihzDf/rKaQJ4c6bvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvulbNy+1NJ5EyYUFbIxt8E5md3FnF2bXJZPGMC88xQZfq3CxR
	oTOteDTDDM1OXIDl3HUX+6t0e7hhxJr4Gwpl55SlLp627YdDmfPSgv9/VDp1oWoj7OrbYgzIJjz
	5tB3cat8zVpUFbp18sWYFsH0RjtrZVI34rsO5f9O1
X-Gm-Gg: ASbGncu3/18ulF1TkcillV3oqu7ydGlYxDgdyrwvwvscQIv5c5oQcDDqA8VJO1dxGJ/
	O93uLpuxJXavLnDzvZXlmHSM1H4NjUsDAdGqCz6OxGyYBaHrIiWp15OSZ2a4hcVxO6rp1HTJ3Ly
	JvcXtillRBLqz9kDOUKV/ef6JZf4k/nB85V/vUw1BIQ4kPJhQIZEEAiyv3Tu9Dzj0qlouJ0C/tZ
	aAL6A2SB6isHSvRjoP2fprZkF+qiJoo/FvZN0g9GUTbsphjlSMUadjtgBiyGOU+otraaRrnx12D
	G8Ngrh7x
X-Google-Smtp-Source: AGHT+IHixQM4D7/C9rvMcEsB1y1V6c33YBzzOkECVikf4/w8buGAafM7wqHTb2wd9uqoervTXG8HHlEiUKNWOxEwi7A=
X-Received: by 2002:a05:6808:11c6:b0:43f:afc9:b889 with SMTP id
 5614622812f47-4417b4080edmr10801592b6e.50.1760453946012; Tue, 14 Oct 2025
 07:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68ee633c.050a0220.1186a4.002a.GAE@google.com>
In-Reply-To: <68ee633c.050a0220.1186a4.002a.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 14 Oct 2025 16:58:54 +0200
X-Gm-Features: AS18NWCNgIb01RCF4Y9Jg-O5lmrWBTRPt9GoCeuQXeptheZO1YJO6W6vZZWdYBA
Message-ID: <CANp29Y6VadSqY3Pt8Leih+W+czo7-yYZE33juiaCKLHYZQ1p4w@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in fscrypt_crypt_data_unit
To: syzbot <syzbot+7add5c56bc2a14145d20@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-ext4@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz set subsystems: ext4, fscrypt

On Tue, Oct 14, 2025 at 4:50=E2=80=AFPM syzbot
<syzbot+7add5c56bc2a14145d20@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3a8660878839 Linux 6.18-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13d25dcd98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7add5c56bc2a141=
45d20
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d996feb56093/dis=
k-3a866087.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fa6f6bc3b02a/vmlinu=
x-3a866087.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7571083a68d6/b=
zImage-3a866087.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7add5c56bc2a14145d20@syzkaller.appspotmail.com
>
> EXT4-fs (loop5): mounted filesystem 00000000-0000-0000-0000-000000000000 =
r/w without journal. Quota mode: writeback.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in subshift lib/crypto/aes.c:150 [inline]
> BUG: KMSAN: uninit-value in aes_encrypt+0x1239/0x1960 lib/crypto/aes.c:28=
3
>  subshift lib/crypto/aes.c:150 [inline]
>  aes_encrypt+0x1239/0x1960 lib/crypto/aes.c:283
>  aesti_encrypt+0x7d/0xf0 crypto/aes_ti.c:31
>  crypto_ecb_crypt crypto/ecb.c:23 [inline]
>  crypto_ecb_encrypt2+0x142/0x300 crypto/ecb.c:40
>  crypto_lskcipher_crypt_sg+0x3ac/0x930 crypto/lskcipher.c:188
>  crypto_lskcipher_encrypt_sg+0x8b/0xc0 crypto/lskcipher.c:207
>  crypto_skcipher_encrypt+0x111/0x1e0 crypto/skcipher.c:194
>  xts_encrypt+0x2e1/0x570 crypto/xts.c:269
>  crypto_skcipher_encrypt+0x18a/0x1e0 crypto/skcipher.c:195
>  fscrypt_crypt_data_unit+0x38e/0x590 fs/crypto/crypto.c:139
>  fscrypt_encrypt_pagecache_blocks+0x430/0x900 fs/crypto/crypto.c:197
>  ext4_bio_write_folio+0x1383/0x30d0 fs/ext4/page-io.c:552
>  mpage_submit_folio fs/ext4/inode.c:2080 [inline]
>  mpage_process_page_bufs+0xf1b/0x13e0 fs/ext4/inode.c:2191
>  mpage_prepare_extent_to_map+0x1792/0x2a10 fs/ext4/inode.c:2736
>  ext4_do_writepages+0x11b6/0x8020 fs/ext4/inode.c:2877
>  ext4_writepages+0x338/0x870 fs/ext4/inode.c:3025
>  do_writepages+0x3f2/0x860 mm/page-writeback.c:2604
>  filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
>  __filemap_fdatawrite_range mm/filemap.c:422 [inline]
>  file_write_and_wait_range+0x6f0/0x7d0 mm/filemap.c:797
>  generic_buffers_fsync_noflush+0x79/0x3c0 fs/buffer.c:609
>  ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
>  ext4_sync_file+0x587/0x12f0 fs/ext4/fsync.c:147
>  vfs_fsync_range+0x1a1/0x240 fs/sync.c:187
>  generic_write_sync include/linux/fs.h:3046 [inline]
>  ext4_buffered_write_iter+0xae9/0xce0 fs/ext4/file.c:305
>  ext4_file_write_iter+0x2a2/0x3d90 fs/ext4/file.c:-1
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0xbe2/0x15d0 fs/read_write.c:686
>  ksys_pwrite64 fs/read_write.c:793 [inline]
>  __do_sys_pwrite64 fs/read_write.c:801 [inline]
>  __se_sys_pwrite64 fs/read_write.c:798 [inline]
>  __x64_sys_pwrite64+0x2ab/0x3b0 fs/read_write.c:798
>  x64_sys_call+0xe77/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:1=
9
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  le128_xor include/crypto/b128ops.h:69 [inline]
>  xts_xor_tweak+0x566/0xbd0 crypto/xts.c:123
>  xts_xor_tweak_pre crypto/xts.c:135 [inline]
>  xts_encrypt+0x278/0x570 crypto/xts.c:268
>  crypto_skcipher_encrypt+0x18a/0x1e0 crypto/skcipher.c:195
>  fscrypt_crypt_data_unit+0x38e/0x590 fs/crypto/crypto.c:139
>  fscrypt_encrypt_pagecache_blocks+0x430/0x900 fs/crypto/crypto.c:197
>  ext4_bio_write_folio+0x1383/0x30d0 fs/ext4/page-io.c:552
>  mpage_submit_folio fs/ext4/inode.c:2080 [inline]
>  mpage_process_page_bufs+0xf1b/0x13e0 fs/ext4/inode.c:2191
>  mpage_prepare_extent_to_map+0x1792/0x2a10 fs/ext4/inode.c:2736
>  ext4_do_writepages+0x11b6/0x8020 fs/ext4/inode.c:2877
>  ext4_writepages+0x338/0x870 fs/ext4/inode.c:3025
>  do_writepages+0x3f2/0x860 mm/page-writeback.c:2604
>  filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
>  __filemap_fdatawrite_range mm/filemap.c:422 [inline]
>  file_write_and_wait_range+0x6f0/0x7d0 mm/filemap.c:797
>  generic_buffers_fsync_noflush+0x79/0x3c0 fs/buffer.c:609
>  ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
>  ext4_sync_file+0x587/0x12f0 fs/ext4/fsync.c:147
>  vfs_fsync_range+0x1a1/0x240 fs/sync.c:187
>  generic_write_sync include/linux/fs.h:3046 [inline]
>  ext4_buffered_write_iter+0xae9/0xce0 fs/ext4/file.c:305
>  ext4_file_write_iter+0x2a2/0x3d90 fs/ext4/file.c:-1
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0xbe2/0x15d0 fs/read_write.c:686
>  ksys_pwrite64 fs/read_write.c:793 [inline]
>  __do_sys_pwrite64 fs/read_write.c:801 [inline]
>  __se_sys_pwrite64 fs/read_write.c:798 [inline]
>  __x64_sys_pwrite64+0x2ab/0x3b0 fs/read_write.c:798
>  x64_sys_call+0xe77/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:1=
9
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __alloc_frozen_pages_noprof+0x689/0xf00 mm/page_alloc.c:5206
>  alloc_pages_mpol+0x328/0x860 mm/mempolicy.c:2416
>  alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
>  alloc_pages_noprof mm/mempolicy.c:2507 [inline]
>  folio_alloc_noprof+0x109/0x360 mm/mempolicy.c:2517
>  filemap_alloc_folio_noprof+0x9d/0x420 mm/filemap.c:1020
>  __filemap_get_folio+0xb45/0x1930 mm/filemap.c:2012
>  write_begin_get_folio include/linux/pagemap.h:784 [inline]
>  ext4_write_begin+0x6d9/0x2d70 fs/ext4/inode.c:1318
>  generic_perform_write+0x365/0x1050 mm/filemap.c:4242
>  ext4_buffered_write_iter+0x61a/0xce0 fs/ext4/file.c:299
>  ext4_file_write_iter+0x2a2/0x3d90 fs/ext4/file.c:-1
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0xbe2/0x15d0 fs/read_write.c:686
>  ksys_pwrite64 fs/read_write.c:793 [inline]
>  __do_sys_pwrite64 fs/read_write.c:801 [inline]
>  __se_sys_pwrite64 fs/read_write.c:798 [inline]
>  __x64_sys_pwrite64+0x2ab/0x3b0 fs/read_write.c:798
>  x64_sys_call+0xe77/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:1=
9
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 UID: 0 PID: 5879 Comm: syz.5.3882 Tainted: G        W           sy=
zkaller #0 PREEMPT(none)
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
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
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68ee633c.050a0220.1186a4.002a.GAE%40google.com.

