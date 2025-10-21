Return-Path: <linux-kernel+bounces-862087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE460BF4666
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9414E18C5288
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5B1E868;
	Tue, 21 Oct 2025 02:51:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04A221275
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015064; cv=none; b=srW1VOKZ6Wej+Os9NZkOji3tP1szIk4iubmx48X36EXVqhovNX8zLZDODyFHLt1Uj+fgg1K9v5K+GS/dx1BCIQS6mhcj7jd1nkS4f0zvwVqw9e0H1xgGxbPLCXrPy3DeDvltFLBmSBmU7akM5FGKh3hsjJhue+t/yZFQx6nTWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015064; c=relaxed/simple;
	bh=IIYe2dPIZrycyaPLEXaR+fRISOJY/jOMEOoUOUmCn+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kjSss6Hhd2sSi4+DtJ7ez65wz0Gb8rb0SStxRLSBR2v7h40UQtiKQHGmds9ob4pMoG1deJZdhWwHfob7IOfVj1CmX4pRrNcTCqrbvIIjUDgXdtRenQCIr+psCZoP+wf90QrtQ92s735/vj5iklxPaxs1JLspWUIg+AfqmtkY5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940e4cf730aso267445139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015062; x=1761619862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXSZh+LhsJ2L/ekgxcnIbfTrKmZcZiu6txpf6OpGVxQ=;
        b=XL1eJTszhtoumynrC/wbITI1dQlCXcfTwNGtBjHALV0Dz8/RYFn4qOKqmbuB0nVTYm
         0U4I0KmHna+8yI5R9XmroaySIYg+hQzD/Eyi631hvuyaWWDdcSCVrOdNsm54xUykS6OK
         Zf6/5HufU4IzY+7+sCoiqfM3uvc6QUtW3R6320n2Qr4a15ZW/1Wt/ONUbCNyhkepABVO
         GICgergZ54KQrMxpfwyHOl5ZysyszhFyuO/xItGdkWiRsKH3D9jzi9KxGIzMqNEnDBLo
         P4xdLTwfrlJscAPrQaVJmuzvR+NbGt6h7hk4dvnmq1IN8hzIw/SZMjWh134IFAQojHWd
         7HcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV49kfAdjZI6coIBJzlU36vxhZkoIfyqaWzdXfWsWwfMfXA8IbhEgT2FKV8uwOi7kj9whwGFYZ4+c1cARE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RsCwlL0WWWWunGf0IHRa1BI5AkMSpopM9tDjxp6yjEZ4lSR5
	G2kP0cY2q0Oj96N3gqFw8P7vWD6iDFQcYYCcMi1SmCNMCBsTW5IIVoahYiUU4m7oxog1mTbvtW5
	lDWjvljbAbqfmgM4iCwPvDJhK5K4/0sqOD0l9OISZvNAlj3DfHKRG8DUoBiw=
X-Google-Smtp-Source: AGHT+IHvZHgVqZ2gLYBy1BwzdWwdDpnEx8KDqOxqqZr4ueOTARER0kfWHjvw+Xsp5JCASB+duBwHVP9LeadQPpVkIg3BxVX5HqNM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:430:ab98:7b27 with SMTP id
 e9e14a558f8ab-430c527d375mr222509045ab.20.1761015062186; Mon, 20 Oct 2025
 19:51:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:51:02 -0700
In-Reply-To: <287c3a106ca4565311685d637af0884c5a6bdea2.1761011646.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6f516.050a0220.346f24.0002.GAE@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in poly1305_blocks
From: syzbot <syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in poly1305_blocks

=====================================================
BUG: KMSAN: uninit-value in poly1305_blocks+0x1a9/0x5f0 lib/crypto/x86/poly1305.h:110
 poly1305_blocks+0x1a9/0x5f0 lib/crypto/x86/poly1305.h:110
 poly1305_update+0x169/0x400 lib/crypto/poly1305.c:50
 poly_hash+0x9f3/0x1a00 crypto/chacha20poly1305.c:168
 poly_genkey+0x3b6/0x450 crypto/chacha20poly1305.c:233
 chacha_encrypt crypto/chacha20poly1305.c:269 [inline]
 chachapoly_encrypt+0x48a/0x5c0 crypto/chacha20poly1305.c:284
 crypto_aead_encrypt+0xe2/0x160 crypto/aead.c:91
 tls_do_encryption net/tls/tls_sw.c:582 [inline]
 tls_push_record+0x38c7/0x5810 net/tls/tls_sw.c:819
 bpf_exec_tx_verdict+0x1a0c/0x26a0 net/tls/tls_sw.c:859
 tls_sw_sendmsg_locked net/tls/tls_sw.c:1138 [inline]
 tls_sw_sendmsg+0x3401/0x4560 net/tls/tls_sw.c:1281
 inet6_sendmsg+0x26c/0x2a0 net/ipv6/af_inet6.c:659
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x145/0x3d0 net/socket.c:742
 sock_write_iter+0x3a6/0x420 net/socket.c:1195
 do_iter_readv_writev+0x9e1/0xc20 fs/read_write.c:-1
 vfs_writev+0x52a/0x1500 fs/read_write.c:1057
 do_writev+0x1b5/0x580 fs/read_write.c:1103
 __do_sys_writev fs/read_write.c:1171 [inline]
 __se_sys_writev fs/read_write.c:1168 [inline]
 __x64_sys_writev+0x99/0xf0 fs/read_write.c:1168
 x64_sys_call+0x24b1/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable desc created at:
 poly_hash+0x11d/0x1a00 crypto/chacha20poly1305.c:135
 poly_genkey+0x3b6/0x450 crypto/chacha20poly1305.c:233

CPU: 1 UID: 0 PID: 6603 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d40d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=01fcd39a0d90cdb0e3df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c58e7c580000


