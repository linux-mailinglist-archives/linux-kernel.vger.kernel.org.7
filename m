Return-Path: <linux-kernel+bounces-882953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D3C2C086
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F213AAA42
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD330FF28;
	Mon,  3 Nov 2025 13:10:38 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924630CDBA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175438; cv=none; b=H7Xb4GqKH8nZHsPRWj53QYDlRweOPuP2Ha5A66wS4VQJc8fw3C0pG0OUZrXp4N1CzyG3AWppeEH+KzUUH8wv7mu7JnioI+w13CIumT3pA9NnF3Fzzl1JywaJegpjXY6Y28D6E11q6DdyfcSDFfDtsAZgxrgYP9GoiOgym1nNkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175438; c=relaxed/simple;
	bh=0kweIpBjLwsaUfCaQ3Lz+4RHhynx7QnaLSBzfQ3AiyY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hu7/bI9P9cT7QIHWJbnTYFATrbR5+amYYm00JDYJnyI1uGGcvXZfNdVA8+9DVNO7ShazQF30kxVo7Ou8kzkV2/dJTFgDRExSjZNaYHA7SoL5JycV3SkJGOzg+V8LwHyt9qb+ndNpkMS4+a+ndWiZhGczUYbDUrpWTxtLjEXicDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9484c28ead6so288069439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175435; x=1762780235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLJ66hhXNV/HWG4YPamY6JleAjJAHrH8FugRFTyDWnU=;
        b=mvEH+Hw02UI4azytazC+kn9xtS1zNVHi9hqODuqRzwkXV6Ld4Gw3B1IDQZ665k07SH
         jicKAVq2sTMrqyrDsw+GxGo7FmUihr6it5m+XRcEkZTldGAzAGEd5laipNSevJspeP+T
         vVrSJBPRCniEocnvCdqt515/0I3WKOI+0Xs/+3rfafXPik4OKnR3mLxMDgV5ymbP+fcF
         jZ2DP/IE7v5sflGBw/o5XS032e/yMxJXcGQWqdQCc24KixrODg604xdJ9x8pKjHuMZ0T
         k8oz+sqcHu5CKsNT8Q4HY+fEBpNk5we/rPaxbQaEJnRNifmhqCRRBhMdF9RO4g0KTJRM
         80mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/oqrLOlOIVey6j9+yY6i3S5nKYyy4lqqq4Y0P7OfUOhxfUEzvSNnU15P/sp5Jn1mKvKSe97x+XnmdZe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBa7IUzrbyfXFyvoExkh0h3vimJqsB79Cjfqixfg5be+wVksxr
	1Pj6hoBZmutsHxiRiyKKVCbMoKXO8Iv2xIJQvLY1/LVGo7MGuCwXBVy7+2ZIel19HAg5U+EKv8G
	s5+Np2iJF907BGjWMLVW71sCwY1xI4U6egPXBPvvokWs9goNJTfMUbdUwftc=
X-Google-Smtp-Source: AGHT+IGnJXgJ7H+vLRXpvZRmXLRGl0W558D8Tz1IMtZDd5OAmew3vHktzusxKJXjGf2AlKR+2Ffxyj3Ze76tWWaNL2NhFXcpRuWU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:270a:b0:433:2aad:9873 with SMTP id
 e9e14a558f8ab-4332aad9b89mr55929615ab.29.1762175435219; Mon, 03 Nov 2025
 05:10:35 -0800 (PST)
Date: Mon, 03 Nov 2025 05:10:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908a9cb.050a0220.29fc44.0047.GAE@google.com>
Subject: [syzbot] Monthly smc report (Nov 2025)
From: syzbot <syzbot+list2de134faa4e1daa63f2d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 49 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 573     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 146     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 19      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

