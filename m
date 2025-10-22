Return-Path: <linux-kernel+bounces-864932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D077CBFBE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE519C4767
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14563344044;
	Wed, 22 Oct 2025 12:37:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231037261D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136624; cv=none; b=XIT8AFAF0JL2Ti07HOW8iuIW1b9YHm7gJD8AGZEt7YUhC+lCjJ/k+GuXBgo3n2Ia9QbY5uA5d2QCul8yJKnlWBhp40tAZ6s6o4ZNjS7viXy4rZYQCazc4NNrRseru19NDuWn8DLi/k7wh2MvqX3Tku41roFlwKU3v9qCnXelpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136624; c=relaxed/simple;
	bh=cUyO2P8tTi8ZiAFAnRYzRGVV1ISAbxMSuy97OojJnqo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cCHVOeys7t+D3ZItgQrTCJPicvvWVYCoVYzWG3IwY2VxUI9hC7H4irHyJI43ShgBk/HuvVSvZUq5qmyAhOZPKum4rp/mYvaiL65Tw4pvjPlyT09aI+8mYXI++K/2zOXXxA5poRn0eeD/D5WDpW8t6pg1D4b6CQVC2tkAOllRnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ca53080bso56165745ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136622; x=1761741422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7Kos3bS84gWeogZ/FtXsz4+pX13gI1WuND126ynBdQ=;
        b=rxY7kM3TYe/Jbj1YsghvaQxfzNL56C4pV+KQl9b/22sg5wtqBDUNo0pc/kaWfMovdP
         S9uJ9ZtMq1V50jgSjxyFNvRtJrFpFfPvtpBXur9Clce7B36Pu/CXl/GrDAjVpMRmq+/z
         2yLMpyDP/9cOfoEuVdWP3W4sXyFRdrZubqAFCZcfpG3iIYW8XlmXmPurM2mc6t+ccKGZ
         +sUASPj9UERBfls7rx04ksn0JSEOHGOBgzCjPBE2tRpyH79ChBUT/3vKGr/Bn/xpGt3h
         PWQGlGKLwwhJ+EN77EJV9sQAeb/Q8lbVaPJFkmElVkxk55sBU4gaC5USQRUw/Dhw85za
         xVRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrK3jHpPFsueUWGxVzKm0Pb+7nhj46+PQ545Bufkr3/7JsPuuDMFQ8nI9opQ7RI5RFClxgzLmWjbjfpVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtj/pwHGeG8D57W5q9C4QZoWrU7JupFkzczurf/s+yyDVjNpC
	4weSF5WtV7EeWtMPoZH2MQxxTkmDUOvbGoaye5GEJvLIM3JuRgjcBKjWPG6h+9s9xEzrsar3UOt
	O3RO2QlH7nVwnv3BwlZ1UsF8VDQ90i0iwIuzDKNPggqUUvJTyvtSO3bDsdsE=
X-Google-Smtp-Source: AGHT+IF2XQVvy04ATEOPmgqZTq23h7XATRKyk526gnWzOidIrV9gqGAK2Q37qHiNXjBzs1ht+Rxg2K+xrR/MCSFAMbglZPN/wQdo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:430:ad98:981f with SMTP id
 e9e14a558f8ab-430c524b96bmr264569355ab.4.1761136622257; Wed, 22 Oct 2025
 05:37:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:37:02 -0700
In-Reply-To: <20251022121245.D9ZlN%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8cfee.050a0220.346f24.004a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com
Tested-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=167b8d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c2ce7c580000

Note: testing is done by a robot and is best-effort only.

