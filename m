Return-Path: <linux-kernel+bounces-622641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE091A9EA18
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE4F16BBB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127F22FF22;
	Mon, 28 Apr 2025 07:54:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21A21B8E1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826872; cv=none; b=Mm23HapCnYT9nfCikxtTnpkZE5ZZCzHWnh/LvcyS1HoPkTxiaeZO4/ZbtKCv5wuhQOLL/XpmC4qaE/4Ufda8diK8RCfSw1ch6HWJ/QB2rLALuCJoP2hStM/arihibHnPDUFuZAuShEimpJs9eR6xYfzfK7XKgPNAMu+EjybBe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826872; c=relaxed/simple;
	bh=51AoXsXVp7yiHR185Rby8tv3yG4dzn89op8/N9TGwsg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xfn3Inpx3JjGEw+QdNqzAMfG5SfdOIMrvrb5AZIf/LN6sXsXGcoSun9bxg8IjzH0uHkcVSOcbj+CjveiiPUpASn03aFLa7w2cegtWpL6CaRUBGVTNQFBXraGH7Bof1qtnmrQIf7m4d1rsp4t0CfU7c2T2oYs6YGcjXN5MNISo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85c552b10b9so382199339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826870; x=1746431670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3mQV4GgW9ucfCGH5ohcvWSs8E4D8ePWgUerNiBqhAs=;
        b=JEyqADamWMpe0bBmoEX1pRRxYOwMtQwi5rS9pwfQvbuItqA92C/ctZ6doTSW5uHM61
         rvgnR3V19QCTqiCy7b6g8UP+BXdhgg0JWlMPdYKI/1lvgxz1AmsUWkAhngjcr/nTo0FV
         MMj5mv38x8+a2/QMj4RmIXibXgqQVMOdKu1NQrY7SY6MLqqVqR0MMzKw53ZtBOripmaP
         2kby6lr2DdPt6v+LPmsnd9RZRMD21yZHwAH2QPByJNq8IRT8qiciRD6mGxmnW1voCFr2
         JTrvsZL772sxiJeUDF7oRXUThq7xrxA4wP6iVj3U43uVesembVlEY37wyEEqDxyUgFTX
         L53A==
X-Forwarded-Encrypted: i=1; AJvYcCUIx84W8wbtqRkvKqsoDxDQH1XMjdEOq5Z3APIZ62gINQ7itv4eF8n2POHIgNxHhI+yYXEyuQRYyGGOuj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww8vJTPZKh7Z9NAks0+HoHqsA9X3ttSJqpfUMddGMJQ93xwzDO
	U8JL1BWQvim0FMaWCnrcVC6E+qKPZ2jfRCSRvk3q2UXECkwyq7KuDLHe9o2sBnWEFdSgcwbSOXY
	nsM9PH2w3egthXprw75bN+6tv0CYk5pPfOwOhPCFtJ9iuBTgglEtFky4=
X-Google-Smtp-Source: AGHT+IHVAcxNFeITuhMUgOArHuMxEJhyad2kWanyw0wZTdzwPho1YpgTg1bCztAQ38J2oogBJ7vXZxoDWmE/Pz9gyxGF71xsm6aR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26ca:b0:861:7237:9021 with SMTP id
 ca18e2360f4ac-8645cc87ae0mr1163470439f.3.1745826870203; Mon, 28 Apr 2025
 00:54:30 -0700 (PDT)
Date: Mon, 28 Apr 2025 00:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680f3436.a70a0220.23e4d2.002d.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Apr 2025)
From: syzbot <syzbot+listd6e9f2d108f77c2e22b7@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4982    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 3902    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 838     Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

