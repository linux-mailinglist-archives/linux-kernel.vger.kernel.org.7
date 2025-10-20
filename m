Return-Path: <linux-kernel+bounces-860765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90355BF0E13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B5B18837E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FE301009;
	Mon, 20 Oct 2025 11:38:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F072FBE02
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960311; cv=none; b=Ir/4v083n8Z89KQknzF0QxjfADG6e531qUhzLukrIIjK+B1kBJ91vreGOgZJq8If8QYf6r2VxOh8erB8BiL66wXHrhxcXI1+3H2qCHpyREc8MY5GXVPUeFyATDlTVHZYppH6+U3nU/ynp3FhF6WjP5eCmTTei07av6wWq+txCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960311; c=relaxed/simple;
	bh=X/Lf6eJ2MeIX6uQyHWlFiCMgPrqb1bVvrXirRM9qSNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ltk/wcpyr/PxL2MDjPhB6pkazsssxZxopdXYM2QKMeUMte6rBvjjwwWGGivpzF0E18bEFi9KBRqOl4N8rjUF6aZJKILH2RkQGl8KGWaz8s0022C2R2WzoQJhHztA2I2se48gQAGlwQbMUDVZtH2B59jfV5L8RIqVNeoH9nijtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e86696bd9so223424939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960309; x=1761565109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T485cP2PDfKw5L0LRph7Bn15y7b3Q3pOZ3t1w+cyIf4=;
        b=LETlgEUNCtXA4Arhc/Qk+5A3kVDBz0HAokpiqdbgFGNNc8xgQ/eb7aAeWQduQm9oPS
         v+mINigzwDo4/jATZhz9TTzyHqqCMP8BbAbASCZwGJsWXC4qwCu4XjtgUgP7SWX3DGT1
         QhpRw8O0Rjv4hyslNed4lDvPNVp30OcOkGXwds+T7yU8IrtsrQLEUNgzQGPsprVZXKhD
         79IKMDVUvXJCrIOYELhqKUw6PBoBcLwDo0e6BFQN/b3XrnpIZWJCHTlTwQTvkcwIjk7a
         fB0UUFTJOIRRgtUrUmMCC+SZqa8VSgm524FmherI6kwHrxXj9sQKHQr1zSt/Oit9T5pJ
         1Q8A==
X-Forwarded-Encrypted: i=1; AJvYcCUbNsBM1xdkIyoQoo0D96Z5AvwkTP6tG3wLkH+NbxKADdoS9Y1kx3mDr/CxARmvbBpLGWn99nKKMBB3ktY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLMPeOXJzLsNjYC5MerhK4eQy056eJ8KJEtHzz5GppPk6Tps9
	P8mt+L3uy4Z0IwXoVI/tOUqSlIhfQ9Eb35HuhMOj9BshWSwrDMw3ruXveRi5wuvNuu72J++MCVO
	MBepUK83ZYLk77Wop+3OyHi/MclUtlyJpr++w74iZkWdiXWUKcGIhfwfQyyg=
X-Google-Smtp-Source: AGHT+IHIyMhT2Z7ldaGWSNIsMhOp6eIxGv/OXeRO4NSe4aOlKDrIeCpWJ8zH7xQnYmCBAGYSuEoYeUAhfH35xDnurjNGR3f1fo6u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15d3:b0:940:d1a7:dfa2 with SMTP id
 ca18e2360f4ac-940d1a7e14bmr873323939f.1.1760960308844; Mon, 20 Oct 2025
 04:38:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f61f34.a70a0220.205af.0030.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Oct 2025)
From: syzbot <syzbot+list0d3fd201f302d26981a7@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2597    Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<2> 96      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<3> 5       No    possible deadlock in flush_all_rcu_sheaves
                  https://syzkaller.appspot.com/bug?extid=aecb85f534f8915b6f5b
<4> 2       Yes   WARNING in v9fs_begin_writeback
                  https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

