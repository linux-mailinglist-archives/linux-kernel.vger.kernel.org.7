Return-Path: <linux-kernel+bounces-871590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A2C0DB90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BC454FF3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418ED243387;
	Mon, 27 Oct 2025 12:50:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB7230D0F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569426; cv=none; b=nx2ECYIlE6ljcrmmtbll999hJ5luzqKhFmMdEE8j72azgE3uEdFfnUNsD53nVPY+IlD+rNk9HQxWMAtNzZ8m0qhzYu0Caqfk5C+4vsdNdOLKFRrz0P4XGSshsp2OCc061pXb3ZGhz/vcWkrCdQmI4QwL5Ba91FRHP4Kxq0KJ644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569426; c=relaxed/simple;
	bh=/6jms8hP/eQHjTorIaMNk14twucXBZ/VsMxazDiXRoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u5cdFO39K3wDH8iaZ1RsThvY7jHL34keqQUXEGLl9dSDM+CJCSrG0dN6EM1G9fX4mJGnM0sPHlhuty0LJOBqHNKbwrvi73SjfdYULKxpc9dy6R0pQzJVKY2df3vDouvir07aeTDmBBMm4dIO6fRDS5tfI2+eAralLg7Y10VFa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431f20be851so28465935ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569424; x=1762174224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFhJ1WPgQ0gOO3MDukEG+hFs09fqZnICt7HaXQmaIDg=;
        b=hrT3J8joUpG2dKRimTNtfewm0EFUdHKM4MGe42havgD6OYXtv1M/id9JMZRMouJaaR
         WozobPmevU+TzUpjkHb2+luzQWd/sxmOetC+ECjKf2zwHPJfn3+6LqBerqoOXf29qM3h
         IUIlfSQ2XCKSjo2IoM9LRsbkpl5moS4jw+aGPp/s2DujNNV8QmS0AWobf5eIqTeM6Gkg
         KpFThM+GMQ7SF/Af7MgtYwIvKvbU6t8BwpgTPCJZtKFGYrBRsF9OskFX/5q8cVXBdEVx
         5XJVaERjOy2/hAYsOzq6yPXvNXtFYnzAvPc43TtR6ub958hoWdc48+VkkaqUXhmTtXeG
         /yfA==
X-Forwarded-Encrypted: i=1; AJvYcCWRbZpTeek0Gv/T+K0A5TfRQP83csfQiyiyZ5EQaNkYUDmtBhQjgecAxASIZKqWfMjzinpOWviL7TDqICU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJH9qb4v3Jama19LYozbjvYmMilIEmwiXr3x4o3PKZXihmrOgh
	NfofsmbP+iL23qsIkO19fUh51+VyAkxRosORSrpRFPuBeJxrDDXqWEkdcnZVpns1nUiS2070Du9
	+WLlpiHe+GmJ+AXpqHxGxxcoVZ8mGZBI76oty5kcnIyWmLtdow5cqMaGD5x0=
X-Google-Smtp-Source: AGHT+IHnuRLzQQP7XFAZVPiFkDTMpA7JrF5PPKLtr1Wl9AfmaJ5TAh3aGshzbCOjbG368UdHhty7D28QdPo9Y7Nb2DMVaqXjzzBV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id
 e9e14a558f8ab-430c514e290mr535726415ab.0.1761569424127; Mon, 27 Oct 2025
 05:50:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6a90.050a0220.3344a1.0391.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Oct 2025)
From: syzbot <syzbot+list04627eb870b6c8bfc804@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 4 new issues were detected and 1 were fixed.
In total, 53 issues are still open and 225 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4145    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<2>  806     Yes   kernel BUG in bch2_quota_check_limit
                   https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
<3>  771     Yes   INFO: task hung in btree_write_buffer_flush_seq
                   https://syzkaller.appspot.com/bug?extid=cf3d1015b55ff73dcdc8
<4>  519     Yes   WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<5>  332     Yes   kernel BUG in __bch2_trans_commit (3)
                   https://syzkaller.appspot.com/bug?extid=b6ef9edaba01d5b4e43f
<6>  304     Yes   WARNING in bch2_alloc_sectors_start_trans
                   https://syzkaller.appspot.com/bug?extid=23573dac1278bb26916d
<7>  40      Yes   INFO: task hung in bch2_run_recovery_passes
                   https://syzkaller.appspot.com/bug?extid=c2294ae43bae606e3c7d
<8>  7       Yes   WARNING in bch2_recovery_pass_want_ratelimit
                   https://syzkaller.appspot.com/bug?extid=3bf8b0169d7fcc0ebcd5
<9>  7       Yes   kernel BUG in __bch2_trans_get
                   https://syzkaller.appspot.com/bug?extid=3a42e4989f9047772c6d
<10> 7       Yes   kernel BUG in bch2_trans_update_by_path (2)
                   https://syzkaller.appspot.com/bug?extid=e7b9dfa79acffd3aabdd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

