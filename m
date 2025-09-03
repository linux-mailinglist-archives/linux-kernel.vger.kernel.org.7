Return-Path: <linux-kernel+bounces-798541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB1B41F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EAC178CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B92FFDCB;
	Wed,  3 Sep 2025 12:45:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B31EEE6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903536; cv=none; b=LwGWrKwtlkITYiEym7LViYUoWCi7EI4dO92u4A5iUKypCyOyr1oAZ98ha9ml+pKKCG+s6d8n25CvSLURpC1r896Ms6YmiV6m6aTco+qB3hUyElRSUaZyzKDbZxbFL3qx1qjbUiVO5Z+gZ/G0TLTCXaaM4fg7H+cf90LHtS+w73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903536; c=relaxed/simple;
	bh=bZ4hlutzYPrKUfGErsm/riRWumDdf0wyTmsJRvp9GMI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GCvo4QtCWPswHDDcahIkf6+DNjj2o1vDwzyDTt6sXPNcZfCeLitg5t+m+1f++7NPeSTGtHBoEyAoWIza6YMfT7WhB/801YIm0psFW/h4c8H/GH+/7BL7DLlD9OqxPGqGY9/3QIBYCjpWLTb1tsXRQnwAXrK9DP//6UwYVXq4YPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ea2bd7b667so170885775ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903534; x=1757508334;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKgHM1Yb/Xq7EUBuIaw0IgcEP/KFo+QtJSTROYKhV6M=;
        b=P9l8P3vpwbDJp516/qiCeSImj1V9lK2bsgb9YXDthB8xuXX6SONX+5M74cOm+t89MW
         pM/fDZG6nVtG1/0lyxPtO5VPERPaIBBbmfHRqg2v/y/AxaE9q9hVCOBAaIdkb+vgKOs8
         lRoq+2aNgm9YYC/PEQ6BovgYHno/VSCg2IRsniemRh2MSmuhAoGXHbbsS4GdKf5izJXK
         +78ii5MEx5/kM+xa3Hy3cOre0f39R7irVD42CKa5kieJbVWLLspTsR4Q0DbUhl4BZE8x
         z3c6v+TWhPOdpwt89j8h4c0mRpEct04DdgOyqQEodqv37dpLscmVdiVkeic9BqM7YMUD
         AO7A==
X-Forwarded-Encrypted: i=1; AJvYcCXedbBulrxR5tciWH5MsAV9VvpOMD7DkQXqvm5+zObdgfxTObJpczUqgQYnfah4Xnxh/wMGW/T6AmoFlWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcm7PzR908puKoet7Tz6PKKTB3TcH/+2uV46teraiIbNGTTtV
	yz17kwyJgz3LMa62n0mdkGo8y/kMrWjjwr9YH04U3MRNU9tEvD33oriefPbEg3n/bFoKUXr01r6
	tJvy2Lfij4pQ5ZZZKSMrP/SHaH0/O/Xw0JZ2urJnMwW+5+ZHl9n4RWAoF2VI=
X-Google-Smtp-Source: AGHT+IFBo7tv3SLcr8v9VuJKKWtSCymh7lMlr4AoLR6vFceuFZFHhHhiipUbiOidn0jTEsWmBKLAoOjlLxfBIEwmIv9dvpW4+dW7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:3f0:af3f:e9e4 with SMTP id
 e9e14a558f8ab-3f3ffda4bb8mr261625465ab.3.1756903533813; Wed, 03 Sep 2025
 05:45:33 -0700 (PDT)
Date: Wed, 03 Sep 2025 05:45:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8386d.050a0220.3db4df.01f0.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Sep 2025)
From: syzbot <syzbot+listefea082e23d27f8dfc4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 4 new issues were detected and 2 were fixed.
In total, 21 issues are still open and 305 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 72      No    INFO: task hung in dev_map_free (3)
                  https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
<2> 60      No    WARNING: ODEBUG bug in handle_softirqs
                  https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<3> 26      Yes   general protection fault in __pcpu_freelist_pop
                  https://syzkaller.appspot.com/bug?extid=331f5bebb641724ff1f0
<4> 13      No    KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
                  https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
<5> 11      Yes   BUG: sleeping function called from invalid context in sock_map_delete_elem
                  https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

