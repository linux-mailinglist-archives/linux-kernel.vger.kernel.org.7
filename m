Return-Path: <linux-kernel+bounces-874548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D4C168D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1C394E83D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422234E769;
	Tue, 28 Oct 2025 18:59:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924D19CCFD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677946; cv=none; b=T/ahezSJJPmpLOPNoJKFrk4DrFfgJYaAli49Oq4QXmYX8DH/PR/7UmqQLeHv/Kc0W70NdsClRCstQPVoj4ipzTtgY9Nu8pCerpke5YBSZrtoa94i7lu8nexQt/FjuSSti3YREKphAlwCTqvCF5KjQdsOeNcTqGVf9rvwrwMFOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677946; c=relaxed/simple;
	bh=Pz+g3f7M/rTudjcQ5A0MxzMlxo/TXICATfavC4GSHPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t5KBz1JNDZp4UhSk2zmEhcLwyrLYbEAhmQJ+In+J16jqnrcvQSScHrGYhB0SZWTMolKzLqceOsZe5Tb04HZ1VDjiNm+e3i8rV0YhXcktzZmRrx40HpiZXg7JGSd6PSPfOQ6J+sCefkcFzjWa8vVw+B8nQbuA+vSK/OGfKqouSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431f20be851so47329245ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677944; x=1762282744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39QvCMLGV/YiU43N8uQhf+dEabuxwxQWea65GD+iDK0=;
        b=esceD+80ypHI7VLf7DI8TfViVFs13258pVCuoUHupVf8mfO8K4Spmk7gDE8T6WQ7dF
         YZLrYnde35XEeh+9/d7RhF1t+2Fg8uzTPy1d84lt4ddfvJ+BLzybeJXkKMXM59TzNrJy
         I7xJ414XDI3aMin/gqsFivcapaDU5AIyS/HsIWsTk1MCIPpxNsX/ttrzWNoI2ZE8KWHj
         3BqOxgVevLa4lSowFXl8areoae0tlmN4ReY7Mnt5caQwkPS5UDBNLLw9kpjan2bjt95J
         YcSOqLSQvkcV8R6l9mSTKUXLouIj8GqdwTPSxQB/so4LmGTrzHQVahyDuOHfZYIaEVy/
         e1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUrbUI8u4hVJbcsLvHRZkFDDuWYSxeG3IDhUPYa/U/aaST7zrzY6JySFnR21Nn3Wwd6lCG9K5FZ+ilRAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuZqj2g8CGH+Po8AGKEPPriCcKD2bWEYUbD0vnaiymGX8jYOM
	XbR9lUHge0z4EvDhE8lW3aj4xj0R+7pA0J9k5h6m5ZGRqv3Psbg6LVECMkip08Z+Lvcp41UEvOF
	nVNmnzurMdgw1XcBxk92oMjO6BLXKWDPVoG37q/71LyBgVHthGSBLvyJJ0Jc=
X-Google-Smtp-Source: AGHT+IFBvSHm8dE0SXSOh1l/uX9n2kjtOU1ANFfr+iu+5/hRUXR6RsaCY7Jxq1oZXsawv+toX9H0zfnmki2a0q0gGEbrEUvHVy1T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f10:b0:430:c4de:f161 with SMTP id
 e9e14a558f8ab-432f8f86fefmr4015585ab.4.1761677944091; Tue, 28 Oct 2025
 11:59:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:59:04 -0700
In-Reply-To: <20251028182057.zO55R%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69011278.050a0220.3344a1.03db.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ed6c92580000


