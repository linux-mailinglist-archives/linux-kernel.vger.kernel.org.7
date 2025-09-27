Return-Path: <linux-kernel+bounces-835013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2E8BA609D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171C1895014
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23862E2296;
	Sat, 27 Sep 2025 14:30:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D82E266C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983404; cv=none; b=FvNChU0kFGEyVO58hXsqpKugnra6N47NHAM+KTa4HfR51CtGLQjdTT6urXcjROp49BZlEKMdG6voOzlUhN9cxIG0YyRkS5cQkEEmUKN6KzT8dDah/p69Rv7hAaurrUQdokaO4oE36bF92BNOtmeU9bfF5kPry/bVDwGFBx2bocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983404; c=relaxed/simple;
	bh=HlWr2hxvgCzMr6T9I/wPkSInGUI8639MvjLuCSeEIqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r4yHKfBCoVoCbiKcPRP6FQEbwDgNr0WuqYgLQiyCd96xt+AKmu02y7gAVdiByWkw/Zvl5cG2c8e7fJubVrz42Q4ujSJMrb87p7KGcNa73bBBb8PYcWJEhPxiyZGvW/5b9tSC6kxAzkcq7Mwv69BXrRidhQEqbycIjMoGE7QfO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42628f7c151so54983805ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758983402; x=1759588202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bp2EzkceCVTt1yni6fLpho2I/VHM3NnkTfrbWaqTRQw=;
        b=HkasFv1uoMjmBXXT04Ner0g46CF4vYcNInXvLiVeiaZ5fmBj0envPoT0l1dKk0HePL
         VJcP3almpyxisD95MoqSqT3mz+itUs1yGNZUJcfdQjYFute/llM0sXIL5j2gFcjT7WOC
         r1rbBH97NFZrYm8pYh1+DfqhRX9QjLNvRw7zjckVgiVcoIXMF42vS9Me+deAZ96xC1lQ
         3P17FtxArI3N4RXyoVl0Z7dizdLVqd4+WhAayU8HSOKXujXHS6OCn2fChu206pcOFKjV
         jsRCEINA9GusrsvGgPPldsPgcffEIUySV+PPrUOBNNYQaRAyR7pFPlwg9fE7YV3FtLkc
         x4dw==
X-Forwarded-Encrypted: i=1; AJvYcCU1wup9kPI8ZKc6r/29NFMSzcTi5mmW+/rJ5kegiPq9Zw2WyyfjXE6Z2zNv1peSgRp1YQNszLYVaqnyFo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy23uhEGuHn8EaXiOj+7FEqzkuZz9ov54V3IZH7/JqC/+Zl6Nx8
	Xkgx7lr+V8tG/5e4e2QTzbzj6//G8CTBKMbkHW1jdbr/t91vH7GZeOQkI5c20sT3wSUAaEfKFKh
	V5xYAXM8Jf7/VL3XTSyfpSF9Zc+AZ0Yoi/dym/hR/AYaGFOLWZImVdmUmS/4=
X-Google-Smtp-Source: AGHT+IHvNyYaqahkF7F3fWDdV0PhoEVP0kpN0AV2iVrAvGQ19veQZ5OjBoZe/GHYs9sd+fju1wALpEKK8DzoWBaijB5xqxlcMKpj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:427:9523:2e98 with SMTP id
 e9e14a558f8ab-427952346c8mr90797315ab.29.1758983401963; Sat, 27 Sep 2025
 07:30:01 -0700 (PDT)
Date: Sat, 27 Sep 2025 07:30:01 -0700
In-Reply-To: <87ms6g9kn1.wl-tiwai@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7f4e9.a00a0220.102ee.0017.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: aha310510@gmail.com, clemens@ladisch.de, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Tested-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com

Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc82e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124c5f12580000

Note: testing is done by a robot and is best-effort only.

