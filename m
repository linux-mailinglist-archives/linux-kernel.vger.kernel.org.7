Return-Path: <linux-kernel+bounces-726924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D0BB012E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605DF764D93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD411C84D7;
	Fri, 11 Jul 2025 05:44:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEEE190477
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212647; cv=none; b=ef7e1hFdrpvC76sfT/iJ7Dyyz49Wus1Sxwtnq2tExRjzAVVEH6wr0AjFWxhBz3le+HE8+fyPeaLZfIJXjHnP3YEVKCcuWT1qZsBoTTtXx2KO6eoVQaWq3egn7GE+Z+GCm+kRjLOimjfiq/9lcLm1kIBGgCRTawsASQ0tLLCX9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212647; c=relaxed/simple;
	bh=88iX+m/Sv7B+KkvzegYiE+OFM2MuaXpeHt68mCQLc00=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LFp6VwzfNNz8zjU69v4aUL7O8Ai/sN01r2fy1SFXFVT2ZdC8u3PeqicDokHabuElbhTa4QaemvG+gHJORT/OowmiMl50+lWoNtbAw7AkomXJzgjU91i4lsxSaDjpTaHky09sYj7i+ELnBWhG5bQEocBQGEpgh9/A8cPHyIMC1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-869e9667f58so398082739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752212644; x=1752817444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxDnPaIE6YOrYX2xt+DwAZ0bbXNZHUE77EQQehUKYNs=;
        b=EVvK47beVYamTvlFQBDi0SviCEPywlWMAcbnH/26KIXktKIZNTKShqHV2u7XE3XIwi
         6tiIYdxstnwTlIkMRjaREWkux83bBSJihrycDS+haPr/HLBYGILYhPpR1Lsk2pofpczh
         j9esMJzMywsKqhClkYiDSZaSG11c+fAfMrIjgIXEQhhZ7PIFXDe5e/CmxdfMzbkzr/LF
         T/8BI2Cwc0aMotvCWtqUAEB3XX84kEprL4ARUIgQkvBr86ufCePHz7aHrfzCsPs6BVpU
         HrghvEYKIzK+zcrBaBdCdrHn2Fw3RW9WVCxYedpMcCrO70j+c8+NSbwJ5HTH3ju3nqon
         njzA==
X-Forwarded-Encrypted: i=1; AJvYcCVadeFvAMoUjZVJ6X2ZH11bwV4ykDqI/nLXBw8iA9hGc8AEJ/pnJxOR4h2dO0V9dBtVBtdVIT517rKkYAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpofiDoZFo3rpMk4zHpc9bJFkL3PFZHBe/UeYT6uyZSELkgfJ5
	Pz+a3C+r2wk6ft0GZX+/ly+W4LyFYM4/Uc6OpbWPiBadF8vwTWd9n7AN9MM/42sXMO9tDJmBYEu
	Xu0hnPPsL6br3TxnktvICnjJiP/zLJel4GKNyPGSCw/pCXVdGsEt0vHsamis=
X-Google-Smtp-Source: AGHT+IGVQ6w/Mfid9dxZQwhmzUOWLOI58rHemOf8Vq/oPS2ZUkmV8j/gy3SzkFrinSllpX4MUJJROLvi5eIHu0FQ98TZZo3y5D0x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ca:b0:86c:ef0b:3a52 with SMTP id
 ca18e2360f4ac-8797883ec84mr223406939f.11.1752212644500; Thu, 10 Jul 2025
 22:44:04 -0700 (PDT)
Date: Thu, 10 Jul 2025 22:44:04 -0700
In-Reply-To: <20250711050913.3372-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6870a4a4.a00a0220.26a83e.003c.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in lock_next_vma

================================================
WARNING: lock held when returning to user space!
6.16.0-rc5-next-20250710-syzkaller #0 Not tainted
------------------------------------------------
syz.0.21/6653 is leaving the kernel with locks still held!
2 locks held by syz.0.21/6653:
 #0: ffff8880722e3808 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
 #1: ffff8880722e3308 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220


Tested on:

commit:         b551c4e2 Add linux-next specific files for 20250710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15948d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90b2e63e925474ab
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

