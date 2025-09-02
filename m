Return-Path: <linux-kernel+bounces-795967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A01B3FA14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B9C4E064B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D42E7F2D;
	Tue,  2 Sep 2025 09:20:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA73D987
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804835; cv=none; b=HnyOR6U7R0s1VV1yMvuJyXeSIjLmQPiAxk+gItd/ekZOCyFTNJv++SGGpVI9tY5YjtZYApPbxAhXq1KfRY+QRyyWvo2UFx+U7G6BCbbnri/UDSK7pLAg2S/DphjS6uv6t6T4DCbCgSn16bMWEvEwDu2gCVQJLMZvFnr2Hlz6U0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804835; c=relaxed/simple;
	bh=3zbFH3NfCG6PExXmtMAKrqokdBlZbKycFTghETNw5x0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dvP7+lbCWzhv+8JA7NYG1hhCV4U+q+hqQzJsqYtf/zbAnp8jYGaBpxByVcev1psuSfsjA1hqH6rjl1imaRCIGruC039YDJ6MKRpCF1RIbqRLH3UHsuJ17wevx+caGZZjsZjdgP4RwvqXvA6lR5uTtFl5u7AtUNNwBahAozUlt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eca67caa2bso57362025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804833; x=1757409633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Osa16BAe0oPttsuktQJPR9uoZh+5UDs3WW7uk5/b//U=;
        b=K0A+gZfiun2fG6TX8Feb1bcqdERb6xptcKzpMHC0dVgtoeDueiKuvxHK1o7jiOGTTa
         /UmfoDbsUZwWgFhLYsXyvv4LigHkbLy3g+/YlhvHeAW4vmhUOBW6n+NkLjYqHT0rELUF
         /wUik4SG7tN7vALzVYNwpmId746Zfbykf6vm2I+XSaIRBMJNN8UY3pn6dbIW1rem01FI
         7BeLYF6cOUpj8I0rpqsxxiaZMY8g/LzHQtXlQslujxhg0AjS1UduI37PZzeG2fQXe1Nx
         tfG9vS+9z4DV+q8MpLxnInT89KLHuzSVz+yxU3aDuUKz8thqJfz4SL91VsGig09l/tEF
         2x1w==
X-Forwarded-Encrypted: i=1; AJvYcCWgivU5XFHhs3wEtCEO/75janHzulLkQ5tZzKobF0lm+c3BkzEUyHWCUp3n9wgSpiYNnUidYYHH3Gwoa6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcn5dev+KMi8n0vlAj+1pO40ohGHQHsSQXpsBI06qAvBx28NR
	WK1Z/GtSN14AAjHBSZDO/l6VPByOwL/uvNcWjl2Ms2KaD7E+SxELVfT3YPjVNjhowvWc7NYp19I
	KbEf4T+FW/19ZzaYAiZxx8pEu/M6szg3ji+URQPZDO12V+7l7Pi3qIQZXdeQ=
X-Google-Smtp-Source: AGHT+IE0aLMHTHvzdjyedkAA9IhTemTUqBrycikGy0pxsSkflnUQVyEIXRP/pHtC26uBzz/R5qakBZqRZJ7h81hMXsMcSLeMwD1t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3f0:40fd:9d1c with SMTP id
 e9e14a558f8ab-3f40066c444mr170838375ab.9.1756804833293; Tue, 02 Sep 2025
 02:20:33 -0700 (PDT)
Date: Tue, 02 Sep 2025 02:20:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6b6e1.050a0220.3db4df.01cb.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Sep 2025)
From: syzbot <syzbot+listf2b14a23ee18fa1ce2ab@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1301    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 1006    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 81      Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

