Return-Path: <linux-kernel+bounces-891580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68078C42FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14CA33492FD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78614215055;
	Sat,  8 Nov 2025 16:19:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE41DF980
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618745; cv=none; b=BNAjGE4R/qd1k8T8NOvMLupm7Lkk3W3FPfAxJHZt5/w2znfUgY59QRfFvDjwwg9pWwqCdbdrdUSqQIB1LxRJKyoqU2t52ybCknZbqU0r9ZvoecUuSy9osT3Kv0poXbzwMwTHwnNVcrJ8q9/RFbnCZ58i82/GwA2p+TOv1zaArDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618745; c=relaxed/simple;
	bh=8OUIpEXXbsf2/NHOM3VplIj3n9AgbtyjGDwuHKGszGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQ4bpAjRr9c1wWsLgf1IiYOBLvUMGEJkTQgG9F7hAV0kYml5HxJ8S86my6MXYv/6OMVH2sExKNTP5ER08pABJJX01hcPC/Le9F85+aZSQORiCni4EERP08dgbcHEisyRdsVPYhxnVhvFoXFKFyxsorgx895tIRLB9amNnlnw7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433316b78f4so18538055ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618743; x=1763223543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6CnMY2R0/nwgxF3GeEFQ6/eyGrzFvoaMzoUmypXJTk=;
        b=DKzl07MLfDKG5GmoTaVjukcOa49r46y6hXgwRUtPB+G1VYmG4lI2kzIBjJSnjV+Ys2
         7yETXRkE0iAkRNrcd9X/rZ1glJDqU9sWhYFpNwiE+WamTWSfA29YXpHvCxFUNU7n2kgr
         9smrXJ0yKdXK4VG+FLqrtiGOBNDCzklUuail/Ecr1VUyPZRv9MTfLsxA0pmrE61U1Kwe
         PHS5fHpwECBnM512kguwilmRmzOmYM+DDMDDiRoov2R2jGwFE8zKPQQjjWXSsPii19SV
         Bk+8C4DJFdxuP6t/mDWUHq45+DZItOF0yHW3LKVtmmKQVQ/RoghoXYDMZbns1BS2iXFx
         07Jw==
X-Gm-Message-State: AOJu0Yw6G1KTk5brzIAU4wJj0jMrEdoK1GuJgAIrGSq4ElizohUwGL7+
	NynRdkyOP0bGsicmXdhjwQR509T2EmUaq5Tx4hHhUZyjoQHgNBni8+5w7w1cqxVYfPEWz/L5Ph1
	WrvLOWZcq3EO2HKIzpoJJNJINEueAPthqhPu7WW8RL7UwDRM5mNvNUKo3Lws=
X-Google-Smtp-Source: AGHT+IGvOVxdjLyqgNx80HfZ8/WCSOxrjp4l27e6f1uOpXNdKavblFU9AZgf4ahRJWELoN6rRnbRdAmIEi8qz3mq3PH7njURRuN4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:430:a550:3003 with SMTP id
 e9e14a558f8ab-43367debff9mr45150065ab.14.1762618742915; Sat, 08 Nov 2025
 08:19:02 -0800 (PST)
Date: Sat, 08 Nov 2025 08:19:02 -0800
In-Reply-To: <CAHjv_avmxaoUvH17xdu+JTw42Dmc70h+xooj1JxsKjQ8Fh3GrA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f6d76.a70a0220.22f260.0086.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Tested-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a790b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110a0412580000

Note: testing is done by a robot and is best-effort only.

