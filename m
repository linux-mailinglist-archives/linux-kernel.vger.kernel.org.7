Return-Path: <linux-kernel+bounces-827997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE7B93A61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2464C2E156D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838E2FC00D;
	Mon, 22 Sep 2025 23:55:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFF1D5178
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585305; cv=none; b=lCW/nmebJu56NC/ifHLwRVoC2+UKPCSXZYAuKO9sf9B083D+L3rF6+7FtgerS0PP2K//rTxNjyWsfA+q+zHOiNQ/69ym775AEbpYv139ybAHLKfyEHFNRlCQ4dsKEzxGBIACepyVUUSQ/waTdziHP0awSkTo8vtqiS5fcZ2pqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585305; c=relaxed/simple;
	bh=NUbit4Tz7p7KAxBmml9L0Oc2br2SE2nP86Mt9lTRuJY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TK+giNDbZ+Arp8hEfS3qkzYT2438LBa4WWCzNXd1zoMfue37w8CsfNWWcqUqE6GmO3QSd4H9TcVxSzaWM1amf0yeF53irBh2B4/ed3AkNP7VcFCPtAgW0y/19QT4GpxQyG5jAyYbxWvEJu5gxK4XLLKe2CN5hpXriAF/gIpyEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257567fb7cso20678085ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758585302; x=1759190102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+djDs6cxW1GMbwz8AdexZjto4F4GkPeDzjrqvUjSPk=;
        b=QK4giZ3ULMyidwSqg8no6KSstEUU3wYjgZxS1ZSr6+67WzspF6B3dztvIZbBznctLB
         BX8n17Vp2e2644LYcte3IMMBzU3qRpn7r8t3bW1zz4gQWmGVSQyNXCgOYlXxex0vFGNY
         q6WRkj6mxeuCWbnrkgPqPPSJiufcBWcfsoe6238hZz5m+w2KlkjsNolPz3Z+LpmqIHTO
         ztI5cSEWIqczBvdbNlWS6n46aX03yWuFIXGgqD+ogT8vfBxlZ0qQ7+E3HNDvYi1gxnMi
         Wsw7wI+3q1wNDGHXDWNGKAZFeHE5SpdQ12dgWLDWFpUHqRzTCP4zGnNLoMFbjGv7nqbq
         jDvw==
X-Forwarded-Encrypted: i=1; AJvYcCXc8/LOV9gYjr205UKl0tDOHOID/gtlZgrbPcIAN6Kn/qIxpP/jc3tPYVYbtoIV4lxd1m9I1bFf+RYkm/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HuG98dxoftMN0Xid2BXw1puJ9S/YPUGuKvEJntVZXNrM+lZl
	aBPDJkaKZu5HMoRpK7shA0UiWZrr4ZYTRYYHh+61K/EBjBGzZbKvKdjmMt0G9PFkPY6xmdfl8Df
	MX79PFRm7xIq2RGMrvhDW3T6Kx5j2mOXz0T3qQfXqE81nCG6LKK8aAhF3mcs=
X-Google-Smtp-Source: AGHT+IFbDYG22hBVnAPdNJekkNCtWUz5HUuzuFtA+hpIzMykoYvWkCR7gPhCTh0jtcvrMVZM5eCN2GgQMiAfmkxmcn9YJLhUWXBw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:425:7afc:b839 with SMTP id
 e9e14a558f8ab-42581e98de2mr13030955ab.18.1758585302571; Mon, 22 Sep 2025
 16:55:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 16:55:02 -0700
In-Reply-To: <20250922225834.7386-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d1e1d6.a70a0220.1b52b.0007.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
From: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

arch/x86/kvm/emulate.c:4091:2: error: call to undeclared function 'F'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
arch/x86/kvm/emulate.c:4093:2: error: field designator cannot initialize a non-struct, non-union type 'u8[7]' (aka 'unsigned char[7]')
arch/x86/kvm/emulate.c:4094:2: error: field designator 'flags' does not refer to any field in type 'union (unnamed union at arch/x86/kvm/emulate.c:198:2)'
arch/x86/kvm/emulate.c:4094:2: error: field designator 'u' does not refer to any field in type 'union (unnamed union at arch/x86/kvm/emulate.c:198:2)'
arch/x86/kvm/emulate.c:4095:2: error: initialization of non-aggregate type 'int (*)(struct x86_emulate_ctxt *)' with a designated initializer list


Tested on:

commit:         bf2602a3 Add linux-next specific files for 20250922
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166138e2580000


