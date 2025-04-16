Return-Path: <linux-kernel+bounces-602635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11958A87D55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DD9166D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11342676CA;
	Mon, 14 Apr 2025 10:17:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827525D906
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625846; cv=none; b=AokQzwU70tiZJoEYn76A2T5WWyGm7MjC/7AoP2DzCxfeEg+CQqhGfRVOqayqxgenUaSzcv9bPXR2m1MgeOeqsk18DNzOXRUjuMJKW00Cby9sp3tv8o5H0PelXLvB6Npw6gr9aa1vVANeyYtKlzYKwAUJwpP+cMH2wANHfQ2dDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625846; c=relaxed/simple;
	bh=odDTN9VcBvmH7lQXsEvK8NZdfyWLsCw1Cm4NEalN4NM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bwqHRafGNpQeURJ08PEA7ftmeXhlREMsPYdNIeOAzrY/AnbxsIqApfLTahE/wRpYdo+ybnEhCu/eXZmK1IcjyLMACMHnGrXhwnMRPDqwSwRm3Veq5zDqVIZPd2AjjkBnoE+Z4Ftq+sr/X/QOHM8ySxRQtVshcVfDAkUk+5fQzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so49935585ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 03:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744625844; x=1745230644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzxcOMrq7SJpJks5dmooTkk/gac1NbvMuS7VOMpo8ww=;
        b=lZ0M3XpmbcrVprgQobrPAs9U9YEusoWKGHDdV193rEreVikxUusH+qIyx3UHJ4p2xd
         VwPNKIu0tv3YSVE+W854FLkqHs5ueF+dU8+ud/+dBrqPQkguoxZDXv2PHonbn+WyBkxC
         PiEtgPsFo+a1AggMo2D3CW6Sjqt9uCHl751o3RynVWiBdgL5OoBLObLLdEk6z4hsPkEB
         +sz9Xpc81tsVhQtka9zLu19Mv35tf+6y2MudxSZinZqPHj3ECMSBUhaBHsXJIfF4PZQg
         EtXfFxmZPZRHWu7m26Vk6766U0a2Lj7SYo3cUSXlRR1oJManoSxtaxNnn5BB5pHNT2zB
         HU6g==
X-Forwarded-Encrypted: i=1; AJvYcCWLI48+H30yKbvLVGf+oOGElXQTJVGjcirrOyXtcB6VO0XjoGvCzSGK+KMkr3XyQ+dRm1PkSaJDtNf5dk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHgHrWSljq5om3sJaba+2/cX7JE4bX5mjc6Co4Q2WYw6YLUl8
	nQSll5TfqrmN2IIqzLW2ofXP6+VgJmRbv7ydJm+D81Eq352uv5WNq4JVx/54IaqUZ7Jy5TE7Qu0
	RkUbaF3ukt7jsbTCIqymj59jBPGiSam3JSdYnOmuDjpkikOlmKQjzkEg=
X-Google-Smtp-Source: AGHT+IGf9PRtEClTFUKjlKcxvI4JF70SyZhF/6GSG/6VkEWT1i78GYcupudoQvMaErONMddpM64JxBwosJGxDFJ30Y9juOS82XL4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b82:b0:3d5:890b:8db with SMTP id
 e9e14a558f8ab-3d7ec1f3dd9mr122784015ab.8.1744625844006; Mon, 14 Apr 2025
 03:17:24 -0700 (PDT)
Date: Mon, 14 Apr 2025 03:17:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fce0b3.050a0220.3483fc.0025.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Apr 2025)
From: syzbot <syzbot+list433fdab3607fdab30f2f@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 3 were fixed.
In total, 8 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 48      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<2> 27      Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<3> 13      No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

