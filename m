Return-Path: <linux-kernel+bounces-768802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F4B2659C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5BEB62F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A82FE05E;
	Thu, 14 Aug 2025 12:42:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509632FCBF4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175347; cv=none; b=DPAKLXoHnQLiKsF3+u4bVk0cnxwrmZ10AswIBoxv8AjuYt38E7PcySktpItmEotAQLnfh/7Arvdo5VLAZslZqJOhFVwJQHlLb57z/z7Em2qfdZqLVxwXetSW72ILsDPR/PX2HU3IVGdoYqIV9Shz9ohP6v8+FVSX0Owg1pA9/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175347; c=relaxed/simple;
	bh=lgBEW/LBYelp0lkPzsI4IC+KjRXqT8MhNVGkjmwhQ+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g3FTaZBIStWogKYzOmVxymQZ1wbCM4mP7dGfgDLGHkfF2oVL9+DP5SLxCExxKkkIBAbEiMAADyrgLqCCQHKGR5pbmwmRmhb4PzK0VEIoBjheEvGkIGJiUGp4Y9WDcMg9kZod45Y0qcczUUuX1Qbm4CJGPjuEOuSrgpXDu31TywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88428b350fdso120080739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zz/rWUCteoULmmIxjoLSoJd+Ko3CiZlGW/ae3x/QnaM=;
        b=Zy3P0BavOMz/XSCei+KrJB3uaa1fTZ4e0OxDrtorgAR17527KxqaDHMy0lBJKjlsYA
         B8JPr8fCVpfdl6+2yAEXzYHgRoyZFc1zLnNoq6TsestKa7UzzDwdCvWYpvCZlj+OKM83
         LSKc2YxQPV6jx27TxplFIdQGMMvd8sqaoXTXIXQTMvaL1BMklSUOd90I1kFBjuYNdNtY
         /mU8FZWubTwf3uR4dqxyePdIbiHvfnrBPEX/U/ZCm4vyyH89YIEVqthKkxSsLdLbMLlD
         mXVe9CYyoEw79d3KCN0CDy39m07hdeoy7Qg5/2yniFHpPBX78xya+FhDjUKcqg6/Rx8X
         nw+w==
X-Gm-Message-State: AOJu0YwOeC5gf8LSZRWxG0jYAD3cqHww1ph5eRpCl3BeZNJWUrnWAfGR
	xQ32n5QuQ91/bzvKbe4Rp1S44RVvSHWtGVGBx55slj+bKjOdLSOb+UGqmSOjQ4jW+b59uVO9CpZ
	ol33Ej3MuyVVUmR1clZuk9ZZ8wykQkoiDbODmjWzlC7r2uZzraU79E/mJoKo=
X-Google-Smtp-Source: AGHT+IEweosvu1I4Kvukd9GFIM0Y6NjElScp+kwI1nztOJX/UAYPDxRdmpBDX403V5EYB8OR4GXmIgWEtXhT+O0AUKiJQYKzkBl6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1542:b0:881:886b:9bdd with SMTP id
 ca18e2360f4ac-884345d72d2mr526236939f.5.1755175345441; Thu, 14 Aug 2025
 05:42:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b1.050a0220.17479b.0007.GAE@google.com>
Subject: [syzbot] Monthly mm report (Aug 2025)
From: syzbot <syzbot+list6c834587f966cfeb9a27@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 10 new issues were detected and 3 were fixed.
In total, 119 issues are still open and 338 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8289    Yes   WARNING in path_noexec
                   https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
<2>  7419    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  4019    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<4>  3641    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<5>  2909    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<6>  2729    Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<7>  653     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<8>  576     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<9>  444     Yes   INFO: rcu detected stall in sys_newfstatat (4)
                   https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c
<10> 442     Yes   INFO: rcu detected stall in dput (8)
                   https://syzkaller.appspot.com/bug?extid=eb9f416500ff134ab699

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

