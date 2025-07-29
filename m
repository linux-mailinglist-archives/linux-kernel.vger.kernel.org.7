Return-Path: <linux-kernel+bounces-749455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB036B14E98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A51916816D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E519644B;
	Tue, 29 Jul 2025 13:43:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69B10E9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796614; cv=none; b=l057IbZQZxwW3YzthzrMuFjszdWHlTPOBm6+3g0X/c15wVs+t+XghOYMf+Z6kcTvzq5267cM8N6sCoaonJgR/9y93V47BJO1zEgb6UV+db9NKGIYEzbN0FzQ1d+1YTvp8xWafqrl5WazpAug5TG3Q0Z/HfqYdJjjI2HP9Nceeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796614; c=relaxed/simple;
	bh=uRoSO7tcE3dvzQ2BVkjeRpeb8CXfTi10j/a7KfV8nqA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EvgfP5lJ83ChUtyJOJGzOLZPigns4ezdruJdvv1AIALypbxMVyaVxCP/byPLfZXAxQybNTm2HNvsSx8EBAn2QzeIa8lMlxeWNuBfer4IV7AnUqfPls5N7/ZnRCp6iFYscbYbeNnf1Z9zKF9W+WvndzIzm3pRUVFO/xcYKGqBRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c1d70dabdso622837839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796612; x=1754401412;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfPSRFCJJD8p9mD8tQfd3CHFNlMP6GZPCHFVAsBl15Q=;
        b=chloQ4oaMb6fiqFjd3ri9FYhDleL5/1A5Zirsx3SHp7TjZmUo0ghw90w/VeWr7Uxew
         01Jrxy0ej/G2r4Vb95TBNO1Ovm1uW3BTfkpM9fjjKsetbT1y8aJUFdSEW/ZwHxuyq7iQ
         skpo9Fb3tGjmH1FA6/oluxC0kvLd9ppod77K5vn31uwKd5oNsb5o5WUOMkHdoqEGXPu4
         /W6SXyQ1WTK/tMSn0HhAprht4SijujGNLM2UIULOs6xlQaP6UUJbthPu3EK9ZXjDEgy8
         QRGaiHFMb1xDJ1bLrhYcuw6hy4ouSxzi9y0gkVPVia4PGKJMISFOsmj5mc+cnRg7F4hW
         Lo/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNUo2eKbRd+G93Y8UNg+lY88OC/wU28YIxDHss1VwPNOUdBf3/Z32t4A2ZRq8GDhz09/2FM227kE4YAvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LcuYFnOUuUeiYUnWkDMj/2Y28WtWw+j4WJgcOTz/UDQhxe1c
	qJnlA6qaRpmj1XlX4NxjFhezGTRDCx/3sthbDe0wDfGcXjIXzFUGjHKFlags7dE9fxV9UMzGMDf
	2njHPD2Bsy6wheQdEnId2bTVT1EvOGDzTr4BOd376eRMmHhL/wuAS/tTy04s=
X-Google-Smtp-Source: AGHT+IFJ3wreJYI03mrMmGlttjhqBsgGEc5zIZuEdZq3DQuaa2u+d+bv8DbZHvzjN8jEv+fDqTCNpeQLrxFrW6xL27r44ElTVt5c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d5:b0:87c:1a21:4d17 with SMTP id
 ca18e2360f4ac-8800f10173dmr2629718739f.1.1753796612407; Tue, 29 Jul 2025
 06:43:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 06:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6888d004.a00a0220.26d0e1.0004.GAE@google.com>
Subject: [syzbot] upstream build error (23)
From: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86aa72182095 Merge tag 'chrome-platform-v6.17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171674a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3816ffa0a2bab886
dashboard link: https://syzkaller.appspot.com/bug?extid=5245cb609175fb6e8122
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com

arch/x86/kernel/setup.c:1251: undefined reference to `efi_mem_type'
ld: arch/x86/kernel/setup.c:987: undefined reference to `efi_init'
ld: arch/x86/kernel/setup.c:971: undefined reference to `efi_memblock_x86_reserve_range'
arch/x86/kernel/cpu/mshyperv.c:496: undefined reference to `isolation_type_tdx'
ld: arch/x86/kernel/cpu/mshyperv.c:494: undefined reference to `isolation_type_snp'
arch/x86/kernel/kvm.c:600: undefined reference to `efi'
ld: arch/x86/kernel/kvm.c:600: undefined reference to `efi'
drivers/acpi/osl.c:210: undefined reference to `efi'
ld: drivers/acpi/osl.c:210: undefined reference to `efi'

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

