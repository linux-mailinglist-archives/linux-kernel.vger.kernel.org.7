Return-Path: <linux-kernel+bounces-874758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7766C17094
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2091A60143
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9DF354AD5;
	Tue, 28 Oct 2025 21:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45218351FA0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686886; cv=none; b=dAaVgBcPOdSRgmRJiOjnMronlW+ftkLMK0Q4vRNWh8VPfu/tmQhE0D1Ifz7b4EXtHAn+QW+NIJIe+ki6l89XpyJijtCTuHkfZY9JrysYqm/nVZPOJOWeVmJeybVbTk7ES5pi5GdrRNyYUP3tEbPW2xnEl7cmB+XF7iP5ipWFWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686886; c=relaxed/simple;
	bh=qEFaelsG5O287CDqUHKhd+eQ1fcmmgw4dKPts+lnPfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DwojBDcZVPAbAlEBPAQ1yzLNDIWJPFIyFN7DrhP2TDX2oCsfELjTERrh2AfUaacl8DNjGJ3HPFl3ZpRgHKnD4q2GhxDax0HUrmCKSei74vQnnngJaIIHdCElU498sKwvp77QRJ6AKeHgVcAADZVlsSIhqeaWTvR6RV+WTYU6jN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db5635d6so85559745ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686884; x=1762291684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9Py0q0o2cQM9167yN8xVDmOuvTMJjoC/DIuQyJM3XQ=;
        b=mttvjEz1/mhq8OdOrT7s++y5n6AR5WJLe9dmC4o+Kq++HnTfkvD1jfRhN65mTTdqUn
         a5o9LZk1+deqXs7rg/vyn73MbXzXP1BzMNrnFJCIqewvfD7a5R627+2AGErQWcTdmrj4
         mqlTDZD8p+g6/wkfcKLXdk7ud/tT8o++s6Z3TlGsc/WyOCtTCh5RN5WHTOgHx31MhQSL
         +eiftTWCmk7/RB9HFNXGtMa/e+W0F2UoGO/vwzFuAtDwXr3RzeHEuk2ycShYBHaO6ZUA
         RyKpvFck3Qu+3CJjZ9u0i2hf5D2ykxGRd+fKMAM135QCSU5qHXTk0VYGtrnM+lQ5bUxt
         fywg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfYA6+APrIGn7KvHLqOhmYmFZ1ajEC9rys7sFo5zOA4LwmKhoLAX399UYIo11bZ6z4f+LNqQVdpOdIrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68cfbOZ5l+fXxyf2mrmqvZVpV+bICMSEQB4SGn90W28ddd9ak
	EL0747t/a+hfM5vLPJAm76l+Era10zao27J4zEH+MmvrSFSrTyMcmdVvS8me1+RhnpCPoabL/hC
	IZTHyhdkeCl3pkzvKRZ0oIeqGh0PIJgqBSW9KhqyoUh+h6u9qvy8hQrXCE5c=
X-Google-Smtp-Source: AGHT+IFjX0sIRU5uja8++KwPqZ0HFhbXVcNBMfMYog4TrrXh7jWwA+9BnwU5c8sOoMHUOQsr+4oht84ac//PC7L9cL4QvBvQgT6r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1485:b0:430:9104:3894 with SMTP id
 e9e14a558f8ab-432f906644fmr9107265ab.30.1761686884283; Tue, 28 Oct 2025
 14:28:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:28:04 -0700
In-Reply-To: <20251028182247.yvNrt%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69013564.050a0220.32483.01dc.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1574f614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fefde68860cfc8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12db57e2580000

Note: testing is done by a robot and is best-effort only.

