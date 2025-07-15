Return-Path: <linux-kernel+bounces-731817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE451B059E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3854E06AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522F2DE6E9;
	Tue, 15 Jul 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z80kQLT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1E2DA748
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582267; cv=none; b=cggt9xxTM3MzS+zjw2ljCag6y9ezdB5gJqPUCVIvBFJ2gXa5KOIxkc973OK5pIMuN9eX7As6mAmHvtlOm3iqN52bOgduCkVeD+z3pWjUf1WyqFQG6qYV7SSvvmjSymC1TH6W/HHgVAe6nxdUqCiJoFbs/SIUt/98zg8H1sfV8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582267; c=relaxed/simple;
	bh=rEiRHG6HAIbV2ucrb6G23Zk+2pFp866wDOUcKdTyO7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LmJpme/R0KY+trSWDxFfl0zgrdeGcL3PCr3XCq6XMsruHHB1sYWx6jvJqv6IGMV8yEWQZSCLlvDTygzSIzWnLYXCfLGHl0E2zfrL1FpdAAamAF9IEhmq7D6WY/vWxBNtJ/1KAvtz5btgfyC67nQFwJjCMg2itFYUserwgAemtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z80kQLT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752582264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMV0xsqHJ0j7LmZPmZF2apPJfGJJxrjk32U1PoKgpWk=;
	b=Z80kQLT3kEUr2UiK33Ngv3iR01eUvGjj4+97DoKXKpwGi0w+F2JdyNikwARacuOzbFyxuU
	4R8HJKxgvg8DSGjkuqJQA5iRAZJ7dNRn+zgebAZKt5PirEGTlV1kXTbwrAiiTUScLea0Ej
	ECBulu7DVoyEMiG3qrT8n33w0PlJsOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-osuw2bU6NwiPzIezmLzTIg-1; Tue, 15 Jul 2025 08:24:23 -0400
X-MC-Unique: osuw2bU6NwiPzIezmLzTIg-1
X-Mimecast-MFC-AGG-ID: osuw2bU6NwiPzIezmLzTIg_1752582262
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso31976235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752582262; x=1753187062;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMV0xsqHJ0j7LmZPmZF2apPJfGJJxrjk32U1PoKgpWk=;
        b=Bng/fo7oVYo/HhGJHCF4qKauBN8KT73yGNLj4NrKyfxhxFN0w0ZvcSe+R9B5baENXq
         2Mz5sT5HQzAzwICqdxbfiTZ6fVSXo2eerLsx3XhZlUvzdSQJ1NnNhi6+G6UIxCgFX5YR
         ByktPwUdY5TcqkiOtdVF5Bx7u+LPXTZOoZCsNFJOtulIHQWSZaPfFtSIeighPcZnEDxP
         GvCqBdMzUxtNKT5SW4RwYZsw0esWaDVTbh5smaynXwXLcRxj8/g3yJKtfq1hSHPBdRAL
         e7BfkViS4nnePYOVYbiFjvbyvVU8jS6y2zwVOSodUfNbfH6NUMWJ7OP7Pl2/RNA8PXdr
         hoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRfb5SHipogL9uhgXnnXK5uFvSBbRZ1zvIjXfqt2yssYENdqQlMPIN0k8pV3lQJhX/f+zzFTrsI8rbv+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8Av+JtsG7kX92MmruIvaXVpqy+HxvlZ83Hn3WSY9JSlayLen
	takJNJVLspdBrvi0lwRaOJlVu6jD0Xp+ZDOj9USsno+FLxzzjjN7CKE2quiHxEpz3br7ds9EwgM
	tjvErBAGXVJSmFovbn6e9IfUR42Xyyo6FGYh5wUKCF7wMwkecEaLAVCzCoI7wUUV4wg==
X-Gm-Gg: ASbGncs81f4iob7tsnYv+oSZBefhPcTQhs5tT1KCDSGTv9cW9YohI+GIUyqsBoFq2rH
	PHiZsFMgu64JbXMVhPyYzugNBe8NfkkHlg23JjxB55LYRCSV21JGBRkvcNYgzr63xn9AxHdVm/f
	T+/M9Tf5m6GvGaB9MRXiRrPOFsNUKA9Ajj80/N1aWGVOh/vEsmDyr4HU6di2xbdPR+RDhFKtura
	z2wE4SYJHVUS6snZnwoE8U3px18O5eHTuUwE5L6qXc2yqkhS5gppZCYo2tctot/+VD8tmvpOmIs
	dcwFvcArsgVzOfjoxw0uxOYNBHUmal7uUx7d/xhtc0VvCxHQQ8NJY5uGEtW2rvep5qC5EkIZvOG
	WGm843jTLoa63ljphPFgipTM=
X-Received: by 2002:a05:600d:108:20b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-45625e79ac3mr20290435e9.14.1752582261833;
        Tue, 15 Jul 2025 05:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOecdjNw5cygsLqVU0X3EgZ+tzI9ZGCUAttic2DhZnOH00RJdRSeI42fAVJ674raEM/LllZg==
X-Received: by 2002:a05:600d:108:20b0:456:12ad:ec3d with SMTP id 5b1f17b1804b1-45625e79ac3mr20290235e9.14.1752582261350;
        Tue, 15 Jul 2025 05:24:21 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560eb98a40sm90807825e9.27.2025.07.15.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 05:24:20 -0700 (PDT)
Message-ID: <76704579-e2a1-4000-8d0c-b3ccd429870d@redhat.com>
Date: Tue, 15 Jul 2025 13:24:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
Content-Language: en-US
To: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
References: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 gfs2@lists.linux.dev, agruenba@redhat.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 19:31, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    347e9f5043c8 Linux 6.16-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11afb18c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172470f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d0fd82580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-347e9f50.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/49ae91eb36e0/vmlinux-347e9f50.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/78497f74bd6b/bzImage-347e9f50.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2445b7dba270/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=15d7918c580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
> 
> gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> gfs2: fsid=syz:syz.s: journal 0 mapped with 5 extents in 0ms
> gfs2: fsid=syz:syz.s: first mount done, others may mount
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in fs/gfs2/dir.c:1544:15
> shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
> CPU: 0 UID: 0 PID: 5508 Comm: syz.0.16 Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
>  dir_e_read fs/gfs2/dir.c:1544 [inline]
>  gfs2_dir_read+0x1730/0x1780 fs/gfs2/dir.c:1585
>  gfs2_readdir+0x14c/0x1b0 fs/gfs2/file.c:116
>  iterate_dir+0x5ac/0x770 fs/readdir.c:108
>  __do_sys_getdents64 fs/readdir.c:410 [inline]
>  __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9672d8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd2be2c848 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
> RAX: ffffffffffffffda RBX: 00007f9672fb5fa0 RCX: 00007f9672d8e929
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007f9672e10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f9672fb5fa0 R14: 00007f9672fb5fa0 R15: 0000000000000003
>  </TASK>
> ---[ end trace ]---
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 

#syz test

--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -450,6 +450,10 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
                gfs2_consist_inode(ip);
                return -EIO;
        }
+       if ((ip->i_diskflags & GFS2_DIF_EXHASH) && depth < ilog2(sdp->sd_hash_ptrs)) {
+               gfs2_consist_inode(ip);
+               return -EIO;
+       }
        ip->i_depth = (u8)depth;
        ip->i_entries = be32_to_cpu(str->di_entries);
 



