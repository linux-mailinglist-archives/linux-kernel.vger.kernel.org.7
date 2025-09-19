Return-Path: <linux-kernel+bounces-824737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FCB8A0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678A43B2120
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF031326D;
	Fri, 19 Sep 2025 14:42:35 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE730F541
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292955; cv=none; b=P7d7FP11iYlDP5c7B4FLK++kyf+PbeIKExEnDoLSb6vuCLwjsmTVSa+Rwh/ORWrbxpIBx483xHw80W/NFkyWxVUEeBYdgE++gsrfsRhxpzIYNuLtAOvS34sBDbSJMqjdp4xYCIDIh0Vfs0mf/Ekm6pB99kCVZbCgXnv6o0K+5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292955; c=relaxed/simple;
	bh=eYug5nY1kLWNqPv0F9P3ohehG5w9Djll2U58geBLulE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RmCyeOSWaGTpLKx235+7zAwYDK1nUHkOWNO7wXBfpgtUR43Oe0xR7HqvML/dUBCp0I5hnHsBcrqG3VrorhfsCU51CR4VztYLwl6/O5zhx5NX9/NDK7i02/jnRKnU2Gtqfzui6y2Z43NuHpBSqYof46+OMFVOe920SZPNxc2jZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8876712ea4bso440525439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292952; x=1758897752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAMs2+dv285mVlWJA8sr/wQEoMByjVHUfh3jerhKeq8=;
        b=HYcOtF45IhGi/6q8Ntd5XSLbNYXrsus8Ab397reQ1Fy+5mb5NpG/s5WA19xPIwef+S
         +l9AcbYDsQGBjnotzR7SDuiZ6ASUp14FURaaOWE/SikUEQ9TaSWhAozPRwtWBZwSiL45
         bNJs4u0oPy8EA1QaCXXrTolUrA+lu+YC7yQJuEpRmDtLaWz6ovcbHO3xGCvX8ApugaMJ
         ltNmGS8ViDs/ps5Vl3IKKjpM721jXVHqAfldnvGFF7y+kc4uS7Q7aWr30h0fV1t9rYVp
         0Pl1mnrouX7dD4rS6R02fT6o94PhV20NesSkLEqLW3DB7zLkOTvQmMuaiHF5zU/YbV60
         VVfA==
X-Forwarded-Encrypted: i=1; AJvYcCUntE8cpt4zKbKMOZbUwDGMzMeCcHq3I4nLvDYRfHCr62yMT1jaFUGTkvc79GkgBPotOFfW9yTITkzMYa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i7nWwa+8OoP7Hb7q58Qcf0nY/bs9ajxqlyRyPqN34tOlHZfJ
	SZFz8kabhmzpMKAxuJsAgooNWGLOFXDaKGQsSXbBzmv1gejiUY03EnNg9HlhltnQbcnx/XQ5zhj
	zsYeqxnaXZknruxJJ9YlandJlMfzH24wQJ/XtVVBYRugqSUWNZLQvGjVvozU=
X-Google-Smtp-Source: AGHT+IFL69chW45OJ+YdbOPP4b6VMa0jjV3dnzR4T5WW/fF7ucF7RSBtGHHzwyJ4vvYtui8tXLhb/VNVwBVichO/CcPDUZWGGx0d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258a:b0:424:7f6c:78c5 with SMTP id
 e9e14a558f8ab-4248190b437mr48957965ab.7.1758292952511; Fri, 19 Sep 2025
 07:42:32 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:42:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd6bd8.a00a0220.37dadf.001b.GAE@google.com>
Subject: [syzbot] riscv/for-next build error
From: syzbot <syzbot+8ea9d12facf13c334f88@syzkaller.appspotmail.com>
To: alex@ghiti.fr, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a054965b36af riscv: errata: Fix the PAUSE Opcode for MIPS ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=150c1858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6ae75a6b3af4c52
dashboard link: https://syzkaller.appspot.com/bug?extid=8ea9d12facf13c334f88
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ea9d12facf13c334f88@syzkaller.appspotmail.com

arch/riscv/kernel/entry.S:78: Error: unrecognized opcode `alternative("sfence.vma", "nop",0,86,1)'
arch/riscv/kernel/entry.S:446: Error: unrecognized opcode `alternative(".dword do_trap_insn_fault", ".dword sifive_cip_453_insn_fault_trp",0x489,0,1)'
arch/riscv/kernel/entry.S:458: Error: unrecognized opcode `alternative(".dword do_page_fault", ".dword sifive_cip_453_page_fault_trp",0x489,0,1)'

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

