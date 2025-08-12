Return-Path: <linux-kernel+bounces-764739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB5B226A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05B1B66840
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632E1A0BD6;
	Tue, 12 Aug 2025 12:19:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571F1D6DA9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001145; cv=none; b=mbL5tZ83gIGqyL0hSHW1qq74fSxRaiKTc2bkaWQiFS9M4J8TksW8j/j55wWcKEAY4DvjQPeOISenG9MExotj4CzpsRYKeKDB/UL5odzyAdFazZ2N03/36OLXYfmPepwfKcH8H8LgqI2XjgwjxXmsnBba6/xxIboAVp5aDwqn0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001145; c=relaxed/simple;
	bh=7oJqqMCgBlmq+1rwaqkXTcEUaT7tKzphVWIQzVjW7Bs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uRw5MzTuFnEfyGwbjmntvWwNjsLML4JiAxhHtp2tbBBEnmG0ZPH7TnwT86SmfxvxGzU7qN/b1Fh47tEkK7Tlxfi+wLsmQNCln0UnPiF1jgOhJLaR49iVHKTAkF5FC5xrIQ41J9DoFF0SUnhR4nneLgKs1rCGVEXDCzSTsKZpkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-884014116fdso599439239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001143; x=1755605943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evrBjYGTBCER9bPrI01P10zO0gz+rAoCNj7qPo6KXjs=;
        b=rz4XezNoFWu+uoD4o4SJtSIp+NhoQSqZbXhmVs5wI7n8qE3tVMw7aAj+p+HjUGnhje
         ms/00TvFs7B1dVcER/EqQnMaXb9N5NvkHWhFmVWe2sKDiXUaPeK4GZVfrTA+c41BHwrZ
         mHzfZd441wZ7ixxk2GjVQ9EaLl3nErsZJWChbo7uRCQK5G9AvL2W842gdmh3dTexgRAT
         ltn9ANz9Gptawrq/qf6A3+R9PBiCUPaqsoztCjyDRBt0JgaB0IEgva1OjL3SqRdRtiUt
         rVDqWOwI5V3PGqJcrpdWZFiSder1WMeOqWwMGnB2I6YmG6fgYKSLBNTFOHqsUsvELlBr
         hWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWyiewtFvHx85456CQz4H7jxumTTymbwfoPWyILUIZ/3DN/Rcyw319n7te9flfCAl5qHvQX8zunaFvWaAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9N3gKmTJc+N8E17yIlhgaeZMBD2LtR6G7YLEQWfKRg3cuMI8
	ewp3AstUhuhGmgmALAt8whCPnuL1Iw4tzlGPro0ezleH2TEhp9fbJHDgKfEu8gdNUolVKjlxUfY
	zFFkmOChboR/c8+fBiWs/Q9xOl+M0dbmdAJjdIn4Zu4rwZQNWK+Yhdr4/sq8=
X-Google-Smtp-Source: AGHT+IEOGKK7gveqb99EcTkdmaYelrQY5tDTm/4ktuI/VzFxoKSaj5E4Zh/ea3o+8tNpKcvcXz/1KUTen4Mp28enP+HyvjSrN0Fl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160c:b0:881:82bb:94b2 with SMTP id
 ca18e2360f4ac-8841bf27d2amr679542339f.13.1755001142841; Tue, 12 Aug 2025
 05:19:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 05:19:02 -0700
In-Reply-To: <0d6fdeba-3bdc-4b23-bc60-eb639e628947@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b3136.050a0220.51d73.00ad.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com
Tested-by: syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com

Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152b4af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=30754ca335e6fb7e3092
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e135a2580000

Note: testing is done by a robot and is best-effort only.

