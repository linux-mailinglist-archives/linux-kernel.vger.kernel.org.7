Return-Path: <linux-kernel+bounces-857929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69FBE843E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86459352219
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314E33CEB9;
	Fri, 17 Oct 2025 11:13:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8F33CEB5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699587; cv=none; b=kqu7wW20KamychybSp+UZMifGh/XXmx1twLtgCY8Xel3CZ7xMb0JmOJJRd/kWr44SM/1Wfwqinq3l2yCgtwLdd5UU018MgDl3scHNnu/gwBHor9qM4UlAKqK9VUFrjcQ5qO9wvO/N8onFOKJ/ZCAN0X6OreK0vyatXV9r0KVeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699587; c=relaxed/simple;
	bh=weWYArLB8ZVJ6ezexCm37ujvCQU3t5+Hg83tEuYx0B0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bMh4YDL5UeIFkrNspNtA+9PmNmzaFHd1YO9Hhuc/QMlScsJ86HZFE2DDBnyRMlccdp0JYI7J/nY4Kw+3E8c+oa57Odu3cxGv1pgMFuAjsCss4UC2ZzJTGFkJjoMn5LgY4Bncj+EZ4nKZG7jeqr3ToRO+IVRm0PAk9geE+Vc/lIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42fa528658fso59283775ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760699585; x=1761304385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kni+sDIL2Jfkp6Pl+QKNklryz6k09rAnEqK2+NFa3oI=;
        b=fudxsPKMXY+qYEoWYbFbOQkVC34aU/+9VdmuE9+MvQUwdGLgu7RlDnveDqA2k/5cfC
         m55Eupwoi6+8ZjDUH9e7gBSo2UsRZ7EH8f7PS2ldvAuWFcVXrvBWEUNV7LLCkXy4TfEe
         G6JJJ7dLEnVP9AwabuCU5zB9qftago/OaYLgf/DvL1v+wR7Lk/9at1BkPdTRj4yjk9x/
         jgO/e6cUeMrxNFffROEo4N0RoZmR6qvsMdEy3XOsp+f1nknjuhUmyp+A+xRSPb8SQtRz
         YYeTgzEvrqw9LjsRMX3lKZy4qjSYTGtvZTxxUVaNKeD62feKzzfUE3LLTLN6qJMc8ITK
         hQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWWpPMpf4J/FF9qR3350L+4c1w0F6ZuD2sZRUts33zVadyOGNu3cEHmyrSxbkxNlx3O2GH85bR2VF/ZijY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvMmJBDEKCg52FEictoCUJu+xYrhm8cYVgj+njaJUhfdQ7QQj
	5x4SpeKR0xDSVY3xVPZYIGlIMUuw4i08r1BA62QxVMDFdc+FjTwUBucAw3BTbttZsz+2lEs1cX2
	3HVeCyyUicZIfrb/YK0hLGLXSdIHxZATOVih5FjCijbBUadSOFg8f+RyUl7I=
X-Google-Smtp-Source: AGHT+IFrBSYUoL62jqOcT/He3k3mT96lbbKIf/+O9zUClKZjzF/gWdSdAIQRWG1qoLflnMT1MJjCKdYuk/5Qbk9LgXTwj8HV5ea0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e6:b0:430:c38f:fb83 with SMTP id
 e9e14a558f8ab-430c5262333mr42324265ab.8.1760699584785; Fri, 17 Oct 2025
 04:13:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 04:13:04 -0700
In-Reply-To: <acd7c1a9-c756-4ffb-b9ed-c2b962305ca0@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f224c0.a70a0220.b3ac9.002b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1426cb04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c4b67c580000

Note: testing is done by a robot and is best-effort only.

