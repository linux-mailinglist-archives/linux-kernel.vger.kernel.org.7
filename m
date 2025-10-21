Return-Path: <linux-kernel+bounces-862385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68DBF5225
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5860018A6DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796412EBBBC;
	Tue, 21 Oct 2025 08:02:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A552EBBAC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033747; cv=none; b=S9GRbkZWHunucVxstMBIqayz5JFd7mBkjWqvxsjiA0c9GJl7/KPuWmT8OrS/o+42zSUZ/AadP+0c7CHEPWJB/Kbq5PsiOGo62lQ0quPP32up2KPDG9Efns11UbC8X1r9h7JBeA0V4n17+MxC95ns6z61nLtqbHu8AI9/YPy+6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033747; c=relaxed/simple;
	bh=hL2gB1q0VDI1syvgqzalY45oVF7hQIYm3mMV4Q8i8f8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mVqi3JjoUmQ/ugEyvZvgPBXCa8ptpbB+G/Z8gS5FakjLMI9dLlZ8A9eZ1ZEgAS+3ld6RGUwoaNxm7weZm9xpnrttt+lpAt2dSOjR6fZP91ZQF0Wdk5Atew7gusPHVc1+WD94m2hb1Z0bc3ENPI9ff0wiJOCEJ2Sk0fXJD/3acMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so1539306139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033744; x=1761638544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVojPbmDd8gpKG50KykZMIwE1cqFIKnT3dH0bMxWekQ=;
        b=D4pPAP6qg4cVQiD6DQPA+EcqunpvGqMsRf9i57UdUg8b8AQJ8WM6sw1LzMr1kJ1ob6
         lyeEXHk/t+PRGrlO+xxjm+xRte3QDm1KiwMTaYwltvbJYOcB2VkEGMURGwpFxrQmwXjw
         vTSNDAc94+XHmoHg3KkFAYNrxhm2zNQpZZmaMxPvkW/bW2yjS0ReflLMsIDoXkln5Y7N
         PnjMcXl104MgHi+LOTHOF+m6HWHcBR53UPX4EcVBvpapbq8KJYYUc/uhXBpHdArWVNxt
         +DUEbLXy5Ky1+8EYQN84vEMm3Dklbsa0oxHwxQBUSdzcvwE0pEiqCJj5w2UWvqdOzKff
         caYA==
X-Gm-Message-State: AOJu0YyuoGRjGJdx0IBIZstrPTryrpIUroIdttFrbLBzHGr/yVKBM3sT
	UvoxbIslnsEOkxfZZ0YuSbXohE5rRfUglI2m1VcLj5PUbKQ8qfmEypOxPaGVVXr1hiObKYjnLci
	N1QxXZXa9pF2TIiMA0U7j3i5D3NRXH2JdzJl6/v0IrsI1mz4LBAoaEWu446U=
X-Google-Smtp-Source: AGHT+IGWFogsWiEGXpT6LEkD/wmRqVt7qt+7Dl9ZTxt72m86e+M9GYYLMuJv4FX7L4/87earjVxjJqLGdKGMzgpGFHd2FsY0U2UJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-430c5223fe8mr250787785ab.12.1761033744757; Tue, 21 Oct 2025
 01:02:24 -0700 (PDT)
Date: Tue, 21 Oct 2025 01:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f73e10.a70a0220.3bf6c6.0002.GAE@google.com>
Subject: [syzbot] Monthly trace report (Oct 2025)
From: syzbot <syzbot+list8aaabda4014edfca824f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 2 new issues were detected and 2 were fixed.
In total, 13 issues are still open and 58 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 144     Yes   BUG: soft lockup in mac80211_hwsim_beacon (2)
                  https://syzkaller.appspot.com/bug?extid=7e51ea277ea81fe6935d
<2> 85      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 70      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 58      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 53      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<6> 9       Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
<7> 1       No    BUG: stack guard page was hit in br_handle_frame
                  https://syzkaller.appspot.com/bug?extid=593efacb260a29c44abc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

