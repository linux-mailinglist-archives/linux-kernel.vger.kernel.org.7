Return-Path: <linux-kernel+bounces-724710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BAAFF618
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297EB3BFD62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3965FB95;
	Thu, 10 Jul 2025 00:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCAA32
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752108245; cv=none; b=BZckwWaKeiRVga6RjQWlRNZ0PmpRdB6cTHlpf80wexrecnhErqv+vdLR3WFtfSrAvrZm0OUaeA3OpJ0ToZsa3BCkNchw59mGU4IfW4cUcbqWIYrHUP/1eJOEaJM/AXYRqdBFuLXfFqoLPBB7eRM+YKquxoSN/Pz08lmBow6dF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752108245; c=relaxed/simple;
	bh=GtFfO5UBSQpd6M3n0qyyFSGpUGz7IH8edCIj/6qkjNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qbHdCpezwthLsxZboy6atLUqNObQb6H5FuoPyq4zHJWCEaYeZJRoJib0HNrjsmgli095e2bxrZwVnTSXv2B2tP6urfkVem/RD0QN+c3UWoSC7RsXbWoUg2GDPm4CNbMQfbmRR9R7WCQsrobfFFrDWPKHjaKkcvTDdbxcFt31RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso79587039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 17:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752108243; x=1752713043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6ubFXBJaVX9NJ5Nijg0B0BPCDcgJxeSI1/VddLlHAM=;
        b=WtqLGqCB8xP56lE0QorhPDLA87E14bZSh18aaS+X55Jcdc0er84efrniXG+lvZU7yV
         yj4KiekKVtNzYOPylwTupJhhuuxr7wIcfOzVcDTyULpkEfW1INQNaQJC+SaztaUmTgWI
         UkRbaY6aeEpjn9JY/19Oqq0I3UHGou0gi0cCF5t1BrH1URPzZzq14UiL5w61j3xAesK+
         R4d3Q3KRt1yzIYcK2jKrfeyeoMk5fek6YbkomitIKyfRBFGB+kpNIFoQ/g9JBcNQCdcX
         C4wYV60X3rwK4SrqgjH6ZMLO8mBGWTHh6oWq6vpM9/LYoykB2IKbQ9tPFzSf9mYVpd8o
         ApdA==
X-Forwarded-Encrypted: i=1; AJvYcCXS97gJ/InlUnCNS5x2LkMo1p/Hh+P2Oubt/Q3qG379ccBIsz5SZCIGsN4M4vSe68eixSSGFv2C+AsRXDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWexZ9wxELNAJgBS9B/s2m6QPvA3eKZEKRBObSB2AZ6Khp6vkL
	ws2Tu8PWzU410Z9OMRXve5WLKVzYr5Mpm4y995MmYimBQD2D+Szp9Fk64xOQ/xBLEJNcz9Q2vNh
	KfKZxMREioUQ8QpfFroc/zrmxANcTY6nAJ0JIFP3j0LRGk9MwZ5sZttF55Go=
X-Google-Smtp-Source: AGHT+IEEZTrsGg61LrPeklxaxuumgz77c9VLsfiGovZIPBLMORTLfebejWKSzMwqiccyUFrmz9OwM5HLJ3KvEiSnw5pXU5bjBcFZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:408e:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-87968fe0bedmr74344039f.8.1752108243595; Wed, 09 Jul 2025
 17:44:03 -0700 (PDT)
Date: Wed, 09 Jul 2025 17:44:03 -0700
In-Reply-To: <686ea951.050a0220.385921.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f0cd3.050a0220.385921.0023.GAE@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_file_fsync
From: syzbot <syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com>
To: anna.luese@v-bien.de, cem@kernel.org, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	john.ogness@linutronix.de, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0161e2d6950fe66cf6ac1c10d945bae971f33667
Author: John Ogness <john.ogness@linutronix.de>
Date:   Mon Dec 9 11:17:46 2024 +0000

    printk: Defer legacy printing when holding printk_cpu_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b19a8c580000
start commit:   d006330be3f7 Merge tag 'sound-6.16-rc6' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b19a8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b19a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e24a8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ed3582580000

Reported-by: syzbot+9bc8c0586b39708784d9@syzkaller.appspotmail.com
Fixes: 0161e2d6950f ("printk: Defer legacy printing when holding printk_cpu_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

