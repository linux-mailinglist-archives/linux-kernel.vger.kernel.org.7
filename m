Return-Path: <linux-kernel+bounces-884485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DDAC30498
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F693BCB89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936331A80D;
	Tue,  4 Nov 2025 09:17:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A531A062
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247851; cv=none; b=a/CIU118Uj41Xlh4IcTEHke/cKkgoHYZ44qcnEOZkIfC+/ls1KC9bUZN1Mr4VRYamRqGDD2ZE82EELZbm5LqwBvzezqDsd6WvUZ/ksjtdU6zhwru8vH3e3dhOmrkDuyPxAGCSBnl6ckBi+yqHnY6cscQ1RgihgQiqrQWM8DJo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247851; c=relaxed/simple;
	bh=x2N2Ao/VUOm5LHMgeVOcIdZt4S8Z8P71A7OBDYHROeo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=crHMDWebwVUvX69lbOoUOEMPXjuUXaG51CDvxYF8djvj8ZFDYyS96hxs/tv+o4DAgomRXp6msyRg0wqZaMlm55WrTgjCX/KJD0jQkRSbZ5JqUwn6lqUc3pcaaOlc5FWqHotIrJy1BHU2Ul3d1Vu9aU2W20bXCShC0vZHWwzhso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso106828355ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247849; x=1762852649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0G+klVvNi3geMbF/DqTCZY2vlIqhu0rrXDM72V6APk=;
        b=Scp+7PAVodFfOqyNGlhVsX4OeXN7gmsi+WzQS/TsN4MOv5+LuZIO/mJTC5x7gEmryg
         +1Ky3aqsmFgQYG4Jy6P5Kbn7kko5aEKfb5jemrX1XGpr24BsHFtcJTWqpAtTJUkyWyCr
         YZIL2+5q3V4zedbtWJkcVyzwJK0UvqP8aEp2kGDn8/7oR6IrA/9C6HNLPOPbtIuEpwCZ
         P1tMPB3ZsgwW/nXClgbujEi92n/jRzNHw7VH6Xgw98JuPu2wmkuPXUDl4ndy5cQhLK/X
         9qEFdBov1aEPtTQUIHEKLHZDJlW3sqXBOA5caWNiXt9xvZM16060MI3MAPUFvIDQGp8T
         H/jQ==
X-Gm-Message-State: AOJu0YwaP423C6yP7sdo8fxOAcSHfB63k69nMRiwmEDIWdgmSh0Gtdsl
	bQTw9k2G+52PE1Vdp25tnwCgPt2tI7mLSDbKBjwfE03n8F673Sr0a5SrTQGrT9iQJ40UAF0pl/g
	VlJc20ke6/HKykFgJyo8b8aGOhM3EJkjxO8SuMNs35lBRcRdvww6R64J9HLk=
X-Google-Smtp-Source: AGHT+IENivPcLxYnYpgLYPv9zvCQyccHTCmdN4XNfgrF3nTOylMianJzqRB5o2G7ybt7oMVsfdpfOBtBrXK02tWuklnLrW4u6i97
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:430:a14f:314c with SMTP id
 e9e14a558f8ab-4330d121e2cmr196825385ab.7.1762247849063; Tue, 04 Nov 2025
 01:17:29 -0800 (PST)
Date: Tue, 04 Nov 2025 01:17:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909c4a9.050a0220.98a6.00a9.GAE@google.com>
Subject: [syzbot] linux-next build error (24)
From: syzbot <syzbot+c78a89917a1b7c0fa4c6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    982312090977 Add linux-next specific files for 20251103
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110f817c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cf6c387ad3e8e7a
dashboard link: https://syzkaller.appspot.com/bug?extid=c78a89917a1b7c0fa4c6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c78a89917a1b7c0fa4c6@syzkaller.appspotmail.com

error[E0599]: no method named `data` found for struct `core::pin::Pin<kbox::Box<T, Kmalloc>>` in the current scope

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

