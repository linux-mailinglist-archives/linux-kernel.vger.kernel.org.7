Return-Path: <linux-kernel+bounces-868987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E9C06A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DB63AC8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B31DE4CA;
	Fri, 24 Oct 2025 14:16:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E971917FB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315366; cv=none; b=q/YA+pnpfyyH5FWv+gKz5LaIXHXjj8UE8MLNNBEy8fiDEE3WTIxhmG/PqVATww5SqI4bASAfAN3rM/kUnoAMQk0P+8vdhtGLehTSJc9pQwWf/xe0Dx+obDrLb9ZtI9P50vUd6qRjFhLol73YTPlGW8hSOS0YYNjnx5H9T6sGMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315366; c=relaxed/simple;
	bh=DCUO1K9+4X02Z8jAKpVkKQW34dLBas6aaVKsrjFdIvY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uLUhlifK8fJpzT/rDljhtvTbDxjp9hCxFbcejTOSGCxRWsQHtj/UZk9Iy+jMqz2aahZsLZeLinU39P5/z4mdb3AxonIWmWddj8uvxQhw/qNYetDofVqoMO23/+l0CfG8qt69jSNeCSb84S5XbCrUp7rA44gaaCMKgWndJkL5Jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430db6d358bso88524115ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315363; x=1761920163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+uqbsKxxZJN1bnSukq7W0sj5JvM65eiFlpWxw16JCc=;
        b=IMkOrkPgRpL1AYP1OtdvKIqCXU8vSz8BI2HnXukTLIoS/tJKvWSGGuamdlK6g+GqH+
         6iAJmqCvKpuFLSrhyZyCXn2KkalccM1ySpHJIQySfdYxNBeUzbkPloyxziapa/5DIz0m
         Rqyh60K7muIUN9wS7d4zmYyws0nlLKSfNkNBZgY24UMIuVtrjto2fXFEx3kA1R7Zvvh0
         uTSHL5t8gmR8LL7RxgI6Mjoll8PjNfnKmibROO+q2OnjT0ex/1iKKBw6YyAmdSuQgQ0r
         aE4jvJfXsD3X+kq3rAMPdFc+9QbkKN8y7wJhCXLV9rVBord8hUk6v8Q9Zkz0UB5fPko2
         /ysw==
X-Forwarded-Encrypted: i=1; AJvYcCWfGVj9BSjMlt2piIjkP15GuabEJx/LZ/x8Q6qiaFxWWfCR/tR/WE094hOYKfwn6QykZv2n30iYZmU7opA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0fSRS9hnZQ9/jhlkQekJiWqYk4Cq3a8F9EJB0cy5cCJz3u2B
	Lqclu42d3Nyj8tUtuQmhufvNnMqJMRmE0n5Wom/Kr9E/JqPM2VQ0HJ+PwXTXmoA3q4gHoqjKO8w
	ar7Als6tgutaeIhywECr1CxvNMZ/hyMuQcocIAIp9dC0DOFIHsYK2vxYb/Ok=
X-Google-Smtp-Source: AGHT+IGkE8A2MOPlsTTmF/EzfHNH1opYma4naTPNLWCyqwthjAxb6xf5yyGwm8ZFdm4FS0488nCWZL3WjesErlL43mrjjrpGhi9W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216f:b0:431:d763:193b with SMTP id
 e9e14a558f8ab-431ebf6c84amr33721525ab.24.1761315363623; Fri, 24 Oct 2025
 07:16:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:16:03 -0700
In-Reply-To: <20251024071534.vdlG6%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8a23.050a0220.346f24.00f8.GAE@google.com>
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

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=13697734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177a8c92580000

Note: testing is done by a robot and is best-effort only.

