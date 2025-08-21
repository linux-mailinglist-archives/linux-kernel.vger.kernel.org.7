Return-Path: <linux-kernel+bounces-778909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A082B2EC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79747BFEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F42255F2C;
	Thu, 21 Aug 2025 04:06:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C822A4CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749168; cv=none; b=L6yN5e5Uzpj1rFKWuS885yQH4liOBTsJ5rNAPadllDDxNB9fLAhtSapOeaGi8/r6kGft8MI0PioUInbsOXtOIMIAHO3dCO6EcY33bJnW4tn/y8P1S8vjk8OeZ89Qdx2/nbrkrLMeKNkMVFXkxMv82WMyv5eWFITGDWA3iP52m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749168; c=relaxed/simple;
	bh=CzX3JaJ7NwONLAn2TTeNBMK6lIbHD9i+uC1AXEIdOFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FGSTamnYDmDwqavcuv2SL0dx5Tn4pr7Jq8oroMKhZA0B5vB4Q2JxWE4ghtQsNQh82N0UbPcP7JX3ktfIpuPUvb9NcCkrfkv/8cVPBSuoD1Ra7Vm2u3idJytjjjfgEI/OVhjHpltvfN96mC/t3qykpGHtJvGi94vpuwwNFxK9DIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e1d004so52792939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749165; x=1756353965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcPZ7h1w38XKs5IO8/ha7JNh4WrNn3KTQrDcAx81ZOg=;
        b=TaFmX3pAGULcnobqYoSH1h3jpC6UDAQfw0uoxupg49muxN8DlrCzcQlUW02/pXBzC+
         JnDkJGWVyjN//jQKlcE/UCSXA9ZBe+N11HNaBnrXjUEUvmyjtrO1/pqxMHJoZBn+7Gc3
         Acaw+n47RC5W2VaGGRzTIGmFhy7CXub4wb1o0hBE/717Fc6tXt8E5FX6vWU1JnsGvg1y
         ttz4yhA1rNZQwqELw9mk7k4s54Lr7ZrU2yKPocVeDWPLf66icEHbIpqU9kEI7/2u+oCa
         ctYRpZeaOYmKu0GsEwfbiuL7hKuobitItxTtoGmDRI4geHcJNmlk27qZyuSOMstryJ5N
         lnpg==
X-Forwarded-Encrypted: i=1; AJvYcCX2E7VSq/ULz06XarH0oaQ95Sqb70zvIN21ZLuprf2OVBgV2u1nwQV+juzEUNb8Lcw85bj26vnKEmS37aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH7jAs1QYigiggEla5h8z98Yl1jL4io3iws8jW7KSlQzGAdb3u
	Sixp+Aj4xH0dAvYQQw6rqHa/IQtZjx/yiNWh/iHZBsIx87aj0wBm2YH66pWBBSyfPwaOT1s0aPL
	xySVK59jbMuI30TmHxhEjhcdKOhApsQuno6P2RfkRcFvmMmvDwyIkkOXqD/c=
X-Google-Smtp-Source: AGHT+IGhvQdQ1rnNUg7em2QGQiFzvqEhT3LwDf6es0ungmVDt4/JphxGZD7eCFZIEomXzEnT23TdbSP+cmIP2cVrADIEKOeFTSIe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:3e3:cc1b:2b5e with SMTP id
 e9e14a558f8ab-3e6d6acf0c9mr19983935ab.15.1755749165619; Wed, 20 Aug 2025
 21:06:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:06:05 -0700
In-Reply-To: <aKaW9bi5INq7OwGy@codewreck.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a69b2d.050a0220.3d78fd.0016.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in v9fs_get_tree

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/9p/vfs_super.c:57:22
shift exponent 32 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 6530 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 v9fs_fill_super fs/9p/vfs_super.c:57 [inline]
 v9fs_get_tree+0x957/0xa90 fs/9p/vfs_super.c:125
 vfs_get_tree+0x92/0x2b0 fs/super.c:1752
 do_new_mount+0x2a2/0xa30 fs/namespace.c:3810
 do_mount fs/namespace.c:4138 [inline]
 __do_sys_mount fs/namespace.c:4349 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4326
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6fe798ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fe87a7038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6fe7bb5fa0 RCX: 00007f6fe798ebe9
RDX: 00002000000000c0 RSI: 00002000000025c0 RDI: 0000000000000000
RBP: 00007f6fe7a11e19 R08: 0000200000000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6fe7bb6038 R14: 00007f6fe7bb5fa0 R15: 00007ffebc4cd908
 </TASK>
---[ end trace ]---


Tested on:

commit:         5303936d Add linux-next specific files for 20250820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156cb3bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2619a6495a03d773
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fcd442580000


