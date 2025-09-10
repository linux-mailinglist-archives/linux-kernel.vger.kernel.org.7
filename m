Return-Path: <linux-kernel+bounces-809566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C0B50F23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C4918941C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF6309EF6;
	Wed, 10 Sep 2025 07:20:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647E308F34
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488807; cv=none; b=jg29+BsfxSh1wQogYK0DgNKTQWHrJnahBPxiNpcqYSqI984aa0bJ+/APZANfxTcYLO2lK3jfnspmvPvya+PcTCA0OsqYEEGqZeUqyh2ciaNlQ7TgXS1uVYrby7lImBxbiGme/YPsugec6cuk2mUudbPqsRc1K0tn9eWN307OifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488807; c=relaxed/simple;
	bh=g4qx77pmzTOAF7BwlpF+LAkOzRB35kNRI5WXxTMn37g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lzbOGKYCj8FHwJJEnfcskk8TjEmwfelCdxSiHdWWIk2fic2iOtCtzq8T25pQfzm7H9yDNFR3u1fmG2dhWCZelRn1a5rl8OEfQ7FOCa0MXLyQMPF5Dt7RWdi9hj36XLtVUyifnCQtSVxvaUmjumbUrPXa0dtl3wr8i0fJf+p3Q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-400bb989b1aso126144905ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488805; x=1758093605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq2Nm8mOpiYO3aZi6xQsbBBXx9UxleJOPne87mDiqow=;
        b=M7I0aptSoG0pZZZGM5BcSBefjDpt1AIMOwK3M1vPpCKyPeqtWVnsQknB1cV6eApZMk
         Me5/qoHA2/yiyyEb3OKqTdKGddDeXJE95/i8XZoyilAeC3YxCR4YSx5SwDmb6pnygs/6
         G/Adp1xRmOpZrj2A1P2ZOYEaPedshibE/9IKTi6rlDHY1GC+Z2FPLnD1JuJnFXtk4yVD
         SKQbci1qZlkUjFkkBDz3dKZ1YPsWbgV6gWKJRacHFR1qyXZv6yF6d4mk2U07PhGQQhi2
         XVUEUBfPk8NhQrdQUuXljy2cwrx8NdxAf++wTVtBNzmccOqtf67EAXG/Epo3f/EpPtHK
         4YVg==
X-Forwarded-Encrypted: i=1; AJvYcCUcXHZzU0wk8DfXu/wIJHZTjKDLX0iXqJt6SGHdWqDfevF2lsu20r48FpHHGofsv2RuisqSZrz+HiFUyF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcSem6GK3iNxsRVvxCBBZlGpvF2hjkKjTWfcKlTbwfWGgsNYR7
	KolP7DtQP5UOCDEBvkGvBQR15fmSNd8+5djoLX7wpBVJvnDh4qXQfg5q4enX5EEV8dRrFkstmYt
	j5vRSsgZEvuzTkZdgs+ZKjELfVkb6Ycn9phl5+PjplTyLJbncq8lLc3TKOX8=
X-Google-Smtp-Source: AGHT+IELFz2CwDc37xjKVFddkK2kiM7V9nBPIUHCiWHTinTwwOIesxbjHp6JGPP0KExChwDhfUQPjMClYMH93LIBYKh5KcKi4ore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:416:5159:b34c with SMTP id
 e9e14a558f8ab-4165159b4a5mr32996505ab.6.1757488803973; Wed, 10 Sep 2025
 00:20:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 00:20:03 -0700
In-Reply-To: <39724768-c8e2-4efa-ac08-cce3d30414b8@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c126a3.050a0220.3c6139.001b.GAE@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
From: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>
To: calixte.pernot@grenoble-inp.org, eadavis@qq.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	npitre@baylibre.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Tested-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com

Tested on:

commit:         55196010 vt: move vc_saved_screen to within tty alloca..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/ tty-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=159bed62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

