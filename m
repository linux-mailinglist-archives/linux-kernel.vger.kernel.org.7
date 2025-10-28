Return-Path: <linux-kernel+bounces-874568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A075DC1698F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1781A2311F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AE34E772;
	Tue, 28 Oct 2025 19:24:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D220F08C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679444; cv=none; b=oongwm52tYKdf1fhYEP1WSnOU4Wh/kdlIgqw4u9X00w64PkO83HTQGEXuXIWGhU4yh7WWv+ZttIexkJW1abJA3fi1lL8HwrU6u+PUK7z7ikhZVrFvDGbAawFXPzRtU2GCyDnXSAwm5FCDPuAlHjhsKtOaP+af58CvTqmBac6j7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679444; c=relaxed/simple;
	bh=9FeXmfYOJ0DvtrVZjCkjkBY3X2PjnJUyCSKfVv6gqZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qphcGYk8WVBkiYWttlb5wRW0BHZvL/DmIO6R2lDDF2tWOLfMwD5aKPCl2J2OND7FxEJlj9iXhM/2R46g+NCRE+T2519xcpS9wnSfTjCKMRnwcVL+ZCGYItD4USVR0pzEmMNby20IaIknhsAc8fkODBDDsdcybceNKtEi99Cqv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c684035eso2886315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679442; x=1762284242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZ31FlbSrtscnyIGqMdR/Vz8F3ml2u5F/oqBSjLkGY=;
        b=VD5QXT8Fg6NdV7eitHtV3EDcOqZATxLivTNesxMT9O2E6BPvabmf5YN3TH31cLvjpg
         MOb9/OfXkjpqtdMsTyml5HWGfn8IifDmhSf+q18PJ1W0w5d3i7ClyOXxjpgSvoqVSeqm
         yfuOZEQgkrEq9iVesWxtMEMLfQSTSsdOCeKTmjfeESbyp6hYMu9tPqjTjA7eOUs9amdx
         QqPdmAo5moqW7c2mmgG+AFsDYwDUhI1XiyZZ6uTH/Ez/JGwqKK6kBk4vJmCdngY7j51A
         M5iqqoqPjeCG4TIKTDmvRUjZ+CUF0WVMWn4NWQYgae868n2u+R5isDdctYoqPmFPlTLu
         2fJw==
X-Forwarded-Encrypted: i=1; AJvYcCVju/ffHNMu84w+VogJRw5vrOftwuHoS+wloCsw0Jr4hrnCJtIgapC+nok6HQUjffaerxeK8iJKv7u9s9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hnowsQyVkMtInq+p4IUEepfXdc4jWTIU9ANjubJ3KL+cdu5h
	yPFbjmSS3mVWJ3KWmNJeNyW5ObUCsraNf1Rmpr3dDEsm74zbegoWmzQt7DXO+HI5KSPkn3zy4IJ
	lA5r2nJNps1YSpGJdkpq7tZl2d67wg/cZOsouMWSUQOppeQK6ExATIQ7HyCQ=
X-Google-Smtp-Source: AGHT+IHCB8JPGKROAW2FyZrI1adMWh2yGMIiLBTFvdwg+SCGN4quL8WTdmCM7F5TrkpNJFvDiR9AH0knrVFil42Uu+sLtYV9sI0r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308f:b0:431:f39e:6bd8 with SMTP id
 e9e14a558f8ab-432103bc8bcmr66132015ab.5.1761679441882; Tue, 28 Oct 2025
 12:24:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:24:01 -0700
In-Reply-To: <20251028182253.F7MbO%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69011851.050a0220.3344a1.03de.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=155b77e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d75e2b3488f52930
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141e1f34580000

Note: testing is done by a robot and is best-effort only.

