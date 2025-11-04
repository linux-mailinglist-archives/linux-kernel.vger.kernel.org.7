Return-Path: <linux-kernel+bounces-885585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A18C33660
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A343461FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700E346FDE;
	Tue,  4 Nov 2025 23:37:11 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A8346FCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299431; cv=none; b=gaNiTJD8FpGf8a+oBftPhCT8WWy1fAVL/cV0NR1ljuaClX/1UkpGu5/e9yRZMfvXRZYkXmDqNd/jUQ4zSZCTV4sGWdDPz1vBOEDLHvi+CF9Do1uMtGKK1rz84gFiwrQUi62bFllIPcMDD4Eq+29aI8He0diIO/pvATyeXJw51hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299431; c=relaxed/simple;
	bh=epWid5d5tuwEhUJNLT9XLOHKk8Afa04RKvKr9GFs8fw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A9GdTJJjMnj3+nn27bkW3qFx+mYLw2PUffbkR80KtpY2zA53c21/TROTP5BwxTxD30oseuTGrCA+47KxfQavT2/5iBhz9i3NJdTEAsY4nHjVOOWFImAtJKFt2kRlDbU243zlTiYvIzg3DAt5NYn4PEpxABKSgHcEV+ZJ4yseVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d84fdb91so171487505ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299424; x=1762904224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtxzJwWhDlyVW2zGdhnq/Qw2E0V2SGfIBQbh+cWvGHs=;
        b=LNToNHRDxIxMWruOXY1brtl0Sw4JnZcO/d8fHUWWHbLEyH0B3G2ZHwo6EZApEhzweM
         ci8DHoFQV7bTGYfjMUvgaOAoCYgKTPq4XZFm3a5/zlneCHysx9cV2wHiFG13GLghgKsg
         GBa950Y34yLFUVvHdS1oblizVaI8BRVnHGdSzUVrDTBIALWu9XoemyyING7nzLT/C0mD
         xJ1E+7VnYFP1oUKyx4ULg4PTKkzZlZpL3k1VWNEVu2NzZeRPFJQlKiAPGnZQnEqHXTqn
         OoCwF+0y62gyUmoLL3xZFroHYjFYIQkuKARFGpvqhekVF76+wSAXsxFy+66TRwF5R5Em
         uDTA==
X-Forwarded-Encrypted: i=1; AJvYcCU/zzrPqh7DLD+DIybO7dy1wuoTOwS8QXRZue+cZvxzJu/zzDS2rISeukp4vhd6GEtGl08n235OncDusw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHlpaYvHYKK/1QFADExj3wosHp5cVVRo1qaAWhDew7nyz9owF
	pjzwbMDUh2XBPLvXP7DJyQcZu0+/4uphLzWQFO2OYYmHo9omjYwNbMEe9DS2oUh0+tzxsLrTMKN
	eEdZoTJCw3m4tU8yySxb2eKgtQ2Ezo1p66l6Fa5fe8rInp/nqFgBPsRfi6EA=
X-Google-Smtp-Source: AGHT+IG7SKVZa7EYpgieQIJCf3KIrP2SGQvyjwUTEXXD5RirwjyMCTyiAKrGyg6uE2yX1iNttr8YhSm8plGO+6BjLW1qTqxCJILQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:433:3102:b107 with SMTP id
 e9e14a558f8ab-43340753604mr17767615ab.5.1762299424648; Tue, 04 Nov 2025
 15:37:04 -0800 (PST)
Date: Tue, 04 Nov 2025 15:37:04 -0800
In-Reply-To: <CAPqLRf157uvgANx62xnz=Q0ouDp0oXM2fyFA8BRGs6+Vu45XOQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a8e20.050a0220.3d0d33.0019.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

Tested on:

commit:         17490bd0 Add linux-next specific files for 20251104
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14692114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22305ece5c093e2a
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b12532580000

Note: testing is done by a robot and is best-effort only.

