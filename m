Return-Path: <linux-kernel+bounces-784737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D313B34083
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE57E17C2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6348271441;
	Mon, 25 Aug 2025 13:19:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E221773F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127983; cv=none; b=OkQ8WC2/ryioQ4LBdMScbMJkNqR2J9ERHu7+S02eFCk4AKENRNjyLVcSxCys7CuWTjKijrRqE9U52N1Q1cbYPUs7v/QVKr1k2hRvkaJlT8CT+EFP7ZTiye6mYO2AtYJFSGdpmZhxs6DfHQZDxjv2CNHX9vxTZ1Nv4ed7FmvBvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127983; c=relaxed/simple;
	bh=So+cLh59wFV6WlC+MdzEWwEidHZnvDsZHCEBKhIg1qY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sqc3xI6FWH21IPFFmh3PUhqobRDD3nWpXasYjkz5rujHnQQi7ufuJlSOH37Yh7RUplDAyz9WXQ8p38yYL91BFOGULSr/MdxaD40Bf3tSj2hiJ5GdyACdnItCJBvZV4XqX1WOMGN7LjfkRU38TE7yMTpVzwroLNtcxoESPLj8/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6830e2382so138708865ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127981; x=1756732781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnPwcV7XV+OKMtppIn4w2Brof3ieT9kdiC+gJ3ovg/4=;
        b=CUwu5jHSqk0iVbtDjkmEPKeeH6ggEyZOzGQN2VvCN0HHWZdJImpMZ7b0qP3HTnaAre
         MD9MEG5G3JTlv5f00okQmUL+WTrwbYJsOVGafrnglEdXrPTzK3QdQc46p85d3vfOTrqV
         ua1+1f8zDSbC+tZaKMUWovpBgTNoV7G8OPZmo3G1NRHSFRZAwddrMZx7tnWixOYEXZET
         Q5FkfrrppzwzvladEZESiXwEHoy70SPoKQCc6QFqu6zWoI61dUzKhIwBBkgt9uZeuL2I
         D+Nny7QTZ2s9wZYz0pLtHi9gFIf26krzQ65FIvtgwq42llPgyzYQt5lXCrdTR/FDKJVg
         YdrA==
X-Forwarded-Encrypted: i=1; AJvYcCWCykm3rGI4XE22ZzxKL1qtuyUnGKiJbt2v/0GdqeDAt6OJPHOuoIuXpFQ9OvWAZHTmNp40HPE0O/EKtPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyenPTw7Z/JGXmvegmYokK5RDDPxGpEB+f+LYDdnDJpJpaLe8/
	sAWhvkkfqYk319B721i1qB+zVPx0tvX8rswyqawibGKNsnoVWCBavng/PiOrZonflNAzDQVl6ZK
	5890kFd2uDoeX3RI/JUjJDiU4PWshhP2eitBWEHUbnpXal7d81nFg71K434w=
X-Google-Smtp-Source: AGHT+IGnKj67SqUKzIsKL4YCEGT5LHPMqCLohbVjhqxj8GDHlK5HhEd7WwWBCYIl6Dw1gHMr6uOUGXvFPWZRKHcoEWupWIJOkHgR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440f:20b0:3e9:eec4:9b59 with SMTP id
 e9e14a558f8ab-3e9eec49ea7mr96860655ab.32.1756127980870; Mon, 25 Aug 2025
 06:19:40 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:19:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac62ec.050a0220.37038e.008f.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Aug 2025)
From: syzbot <syzbot+list87b222bdd76a860b53ed@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 8 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22993   Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<2>  16786   Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<3>  6561    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<4>  4896    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  4799    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<6>  3005    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<7>  2666    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<8>  2644    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<9>  490     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
<10> 413     Yes   KMSAN: uninit-value in bcmp (3)
                   https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

