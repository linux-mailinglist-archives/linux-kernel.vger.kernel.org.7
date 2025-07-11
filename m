Return-Path: <linux-kernel+bounces-727864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B77B020C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26EE16BFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1582ED167;
	Fri, 11 Jul 2025 15:46:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896442AE6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248766; cv=none; b=JPK8KRkFxmDBmintKGwD487KGB0avtn1gHGy+Fq6ZtUSyRIY9q2USVuzdebPFGvPnZAXSNr/dMSTeBFcMm+fvfExnsKubftFgwPHeTZP/II/wIUVzcNBQCWtyH+XP+kNtXTi+FFxG11mUk43PzWLKkY+lELrUDagY47/pw0uniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248766; c=relaxed/simple;
	bh=bPrbP07mMcsWL2ktUCR0mdz/Inbltoi1XkP2DLQNhhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K82oGWPQtZ1mbQb7NyoT7rOOIhRVtlISzYZslfp9h3fN7EhYTC8J9t664iWClUkmnYmSF1mOSfRRDe5H/nVwI/LtioYxCub1FWAofAUxhToqyj/ARaujPHmyGnFwXLm35IKlx+1E8Blw8vSR2vuDiFkTqjCK0hxgIa/ZO4/cO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cfea700daso215025939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248763; x=1752853563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y+lnmi8KlAguxn1V69T2094grdBHvxMOIAJM0Y9WKo=;
        b=KAdxZdYt6Y/cS2QvdatYOi++KFnyhPHqqiEZJJIVJO+0qp8lfsAkJGydxTALGM1gP5
         69jUndTD+fJUIHTFKqut637jtUFmHPczpupGuW392LyXn4ZcfMGFdnpfveU8ZDAgP7/X
         9UsKZLBHql8xnioqLKLVYhQwzaIGgydv9/Z+tHDBKQA6TcK0L2LFf6r+Yi+t9pYt41N0
         njhLWLI/+pZjXPDLnFzUwc7FELxAem+rO4kJubLhT3Sf+q0hzJbshbprN7IoaIiGo0+I
         wi5zZl/c62zx1JM3FbqMDfs8VMsn8tKTGz/jE9dbaLExoYuP/JOAqzr7IezGJuR0Lb5h
         429Q==
X-Gm-Message-State: AOJu0Ywlrj+/YtQYJtgAdOag1Gem+GZ0z9fdgFoc0cuN8Samq1nqTGQd
	dM1S2FB10840yKowGUmz8/AaOdxTIq4WXZdCl3gQxWIij5bIcFHVfmp2YwIcRRGowtc+K1dil/u
	iz+i/jjuPz45j+QfQydvkZ2cfKjoVMwW/PkP9cYDmkB2SYJuHn5WR1uXfT0A=
X-Google-Smtp-Source: AGHT+IHp1SXkjTgx55UZ7XNp0OkByhNp8tMbN0s1nErWxoRULUG/f7zPfq/f4A6hIiR7gWHyb7sUi8p/TjMk9fN01V+7YMmlvAMf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160a:b0:867:6c90:4867 with SMTP id
 ca18e2360f4ac-87978fec056mr406569539f.14.1752248763662; Fri, 11 Jul 2025
 08:46:03 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:46:03 -0700
In-Reply-To: <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687131bb.a00a0220.26a83e.0053.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com
Tested-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

Tested on:

commit:         bc9ff192 Merge tag 'net-6.16-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15604d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e860f0580000

Note: testing is done by a robot and is best-effort only.

