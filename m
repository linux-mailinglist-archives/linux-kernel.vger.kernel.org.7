Return-Path: <linux-kernel+bounces-729521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C138CB037D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D32168108
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD323643E;
	Mon, 14 Jul 2025 07:23:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E5233722
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477816; cv=none; b=IkBDmJj39tXiZisOxDLLzg/3UC1ZoPYCDH6HWFGLr97KG1RB03XZlBU+GKGrpeaXfCA+ZrhgZI6GqwT/OHmjO0MzYgn4rEBg6SkEcPx7a+s7Bh6c7d6Il4YMkC2ge8QoPVIniKvDMbSWzHK/xqUbpevOIl5NCGiG/VUSgeEr7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477816; c=relaxed/simple;
	bh=FJ3ExfCWaONCHeorw/P08LNxEWiMpCfkZCwqNxgfz/I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cISiqxWO7aOwvs2838/QdEpZ22gliY6hT2eMqVA0O79PKSzW8DrGg3F+SEErGIxQLSXvGd6EWD79bzq8POfyVIGEJGWgPaIuZdlVqMSLIF4anGCDS7zpAuGyL1qmZmowFqY0IyuqkvRX9cdAoFrY14CdCq3KzxNzX2Am/JMvohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e059add15eso46272105ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477814; x=1753082614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEq/9i8dm66/4bTT69fACTtRv1m0n4oVUgYXfDfMYCQ=;
        b=Kruyd8NpH9uHIsJChPb6EggIPXfGhyeGDj3pNPM8mH0bfcaQxYs92UJNQfoW/RI/FO
         7qUTRRhwPbXkoooRgVsrgD3Wf+/TDrhhbcWdfLA9P5Ixe4/6mXV4sIsrEOq1SA+LnxCs
         oMZc825C5vxuNv8GpXGoxInPRRwLSJuhKB8Jhm0rted7ccAfDJuFPBDssMp7G8zrzFfc
         hxwQL7TBYoUyzNPbSHapQGwoX1npTKBU4Ngjnd+ujIR+30+vAq+q58kiNfjkV5cIvp3e
         ltUtMgruCPo11VzldsnxaRelT8pN99UgSuohtrTzq5YH1MiEDOetW3gpj/FWmJZM/Swg
         tyiw==
X-Gm-Message-State: AOJu0YxZYZZH9LPf8ipH0MyUZYAgDfcfR806O6Or2i/HYY42Js/XCOhy
	0IZk1LDCxuig8W1Sv97EroGXNCU+0EVQWoJDehauH80cLPvN4KjJ5mEFwROosww/+YjBCORUVZ8
	jfPehx8veKIsDETCoieWwDeqrfyJi2V7xqk/aNacovp2MSy+EwrfG24x1jhk=
X-Google-Smtp-Source: AGHT+IFZSKkCQHJ+bnjphTM8F/AEXkqPhL5S/FfmE5VezNJINUTk9Kzfbb8OqCbYRLHFtW1vl7OGvwdjL85ja7djvi7PDNkkesZi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154a:b0:3dd:8663:d182 with SMTP id
 e9e14a558f8ab-3e253305706mr87465675ab.13.1752477814321; Mon, 14 Jul 2025
 00:23:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b076.a70a0220.3b380f.004f.GAE@google.com>
Subject: [syzbot] Monthly mm report (Jul 2025)
From: syzbot <syzbot+listb3b18a7a10294767de91@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 7 new issues were detected and 2 were fixed.
In total, 117 issues are still open and 299 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7412    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<2>  3828    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<3>  3641    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<4>  2879    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<5>  2554    Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<6>  2365    Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<7>  2135    Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<8>  607     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<9>  570     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<10> 430     Yes   INFO: rcu detected stall in sys_newfstatat (4)
                   https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

