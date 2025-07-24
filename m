Return-Path: <linux-kernel+bounces-743990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1FBB106A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D8A1CE831A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF66242922;
	Thu, 24 Jul 2025 09:32:44 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2823FC54
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349563; cv=none; b=MJYECcKjEvOc4TkxQR6BdFfLtoTpOExcPK/8o00i9jyGq66cxvHRr3l47Yr14ZeuZMLbh21mBbb6WWrKGbOWYnelI6O2GBRtre+vwe8mlx0X5Y1xj/M0rJ64rzWYRt/EToONc7jxbwIluEOklgMZsAwUqZavaRjRxhtSNy72XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349563; c=relaxed/simple;
	bh=j4p4THpEVFUK46+TOZqx0eQQ+UWYfOVBiPoxtJt273E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T+p+nUjpfOFiRv6e07CLjLs6GCePeULHfGhkvnQUrcIikWdEfNFKhcfkqat39IwESzqX6DnjM9zxsITe6z2+tlf2oCGeXFRP6P/+GcVY8yOCxrnFvVxtYel42VK56KUwxl/dmkp5eWnOOVTZOFHJSGU3YTEw4UIuGMSNCwaxXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87326a81ceaso207347539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349561; x=1753954361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2H5dzT8NL0tMEJpZJfICvEHpJw1At6ZGLFZ40FERow=;
        b=sRXQ6/2bBQ3tcGSXsDr197k4+w6YiMEzNyI0chZZFfhJeDpU6JvZKRllPlRy3HSwDY
         A5lmyO6zlzh07/8oSUr9/8xsxf27l3WnPGwweBaVeCdU23fK3GINbgZNGAFbssIc3oU3
         TL05s37tjYlUk67GckNF+yBUuRi3m5+qTs9Mc50MDswuEcKEYUu2LSQelA7DYhL8wfTT
         zCNeTFC72puw1/oVi2cvOk0flhCvWUPYRKGCQyC2IwrymnsXjCtRIg9GyhwIMWP37EEu
         cX7Q9cgfzJJYA/uP+H46a5Jey7GbIHis0HlTU8Hcv+PAxOnCr31G6RYlmsVMTjb0MQIC
         2rUw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4HrRmP04+JHVdVFn5XSZ3WYy+QMWhm2Q3cOP8CQNLfFUvhndX1epPxbJsIGt61jOaPB5PF2TG8CQXVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGUK/s/Memh7qlDCIKBx1xJZCRmWqV+TVCNuIhOgk1w90OfvI
	LQ0K0ysrNCT03Tzt8HBKsvcr5cnoo6rZliO/oo4IKwF/MkCTWorBcV+GzZJfAygLKL+pKySOgJW
	HgdTqIPxJxWkWmJMiGlGbCFX/onW+vx+k2pg0NXMAFVI3icwxGG+9LGMJPM8=
X-Google-Smtp-Source: AGHT+IG5QFzKoITOD9BpPcKom45fYQPXGIT20DHfeLB2FlHkxEPv6nWtvHnXD/mqjlKGh2xecliL6OJl73tBFvifT/bzybj1u1/3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1503:b0:87c:1c2a:3cd2 with SMTP id
 ca18e2360f4ac-87c762076c3mr181596239f.5.1753349561400; Thu, 24 Jul 2025
 02:32:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:32:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdb9.a00a0220.2f88df.001c.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jul 2025)
From: syzbot <syzbot+listf09721d34cbf05dcddc5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1359    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 196     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 189     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 138     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 96      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<6> 77      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 24      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8> 18      Yes   INFO: rcu detected stall in console_callback
                  https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<9> 17      No    general protection fault in n_tty_receive_buf_common (2)
                  https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

