Return-Path: <linux-kernel+bounces-784310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7402EB339D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4658E172CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4F29E10F;
	Mon, 25 Aug 2025 08:44:40 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3962737FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111479; cv=none; b=qcsMFHF0f/C7a9761v0lOZ0fqRFwU0JsxMULts3vz1BZgf8ekcsJGNsDfhe1Gumn2YA1/oGJHfU4y5Rmd7+YpThaQL3fYt0n6qPTr0eWJnOL6YrdZWC22/N2aR3Dn1teIZVXVhWk0jt29+IMT1oO91YjL5aqdTTZHmi9ZZ3Slf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111479; c=relaxed/simple;
	bh=qBcWJbcPPAOnnhlGWrqskW7Iw/IXM3owQvo8agRuMKE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=filr4x9QTxxf5AbAyFCX5SWh22zau28/vT+ZKakAtO4mS26wIUixVrU7Tm7O7x6LqsprNp9AZVRlUWyQXujIov7E5fApP6CcbEwzeAroildwygwXzMnZtqiaovXdNJNhhyCCX/jlqZSyxH35gtCEX6ueap6UkC7VxhTLeliZPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e67df0ed87so134252175ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111477; x=1756716277;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz82sMEh414hIzMlvz7mnUHU8bfMKBwhBUzlRscKbSE=;
        b=tNmG4xRxOpTYzkyFe401MHPMYlkq5UIwS0uUNEvI6ZSTsTtRgb115yhPvqMaoapD9Q
         12dUisfeMce2e9rmKyOudPrzfXG0F3h9tqtoMn3UHsGiaw5xG3FRAUsxrnto7YWmy3OC
         S75WRokyRrgbyd3wPIGFa/8bMA4A6BetlEo0Zq9DS8nyN0gOa9eLI+pn1e0Ln3Z2RHNH
         3cA+w8E2vFORTLIoLE/MdWO17T8CgvL+YN0MJJHB0dM5Wg7zQ0Nk9SsQg/djmtqyz34y
         jUcaz/mWfF4rQXUYpYqFKB6CiQdbZZRLgOQ29C3uJUsYAdUj87o2V7OHetXSd+CfpHRn
         MwAw==
X-Forwarded-Encrypted: i=1; AJvYcCWX2fgcj+s87hXtXtlVjTWWJWokWBLlHb/IXFCIwPccfG490DxyrK8j6PWKvUGtMXSQfOkkx8NOGVJhuh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3YvHRPe1gQMI4ckgO6PgZFysz8wBhJbUu6j3Kj4tM5p/Fvtn
	o742BkOeupmEb6P3qm4r8K8UWkQrM62kx2al7ZHPF1VIhmmKJ1QH62+Tch/DGXelBLKlWEKsJ5e
	fr8VCYcolznjEH/2CeHNnH46wpj0YmkkqmWo6WOCStJLz72aBcMI/LA5seMk=
X-Google-Smtp-Source: AGHT+IEfOc0gvBkyt7z1ztJ78VZp/MVSrcmCO/joBCWsq0Zy6sZBG28ZBqtQVh7Ilu9xIKOVWPfmJ518Hkx2C3wgLvaAKGvcYh8H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:3eb:e261:15cb with SMTP id
 e9e14a558f8ab-3ebe2611d2dmr58580555ab.25.1756111477408; Mon, 25 Aug 2025
 01:44:37 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2275.a00a0220.33401d.0403.GAE@google.com>
Subject: [syzbot] Monthly comedi report (Aug 2025)
From: syzbot <syzbot+list02c26f0910ca5bf8710a@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello comedi maintainers/developers,

This is a 31-day syzbot report for the comedi subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/comedi

During the period, 1 new issues were detected and 2 were fixed.
In total, 11 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4212    Yes   general protection fault in pcl818_ai_cancel
                  https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
<2> 514     Yes   BUG: unable to handle kernel paging request in subdev_8255_io
                  https://syzkaller.appspot.com/bug?extid=f7ad508e3c76c097483f
<3> 234     Yes   BUG: unable to handle kernel paging request in parport_attach
                  https://syzkaller.appspot.com/bug?extid=c47f45cfb7fc1640ced7
<4> 32      No    divide error in comedi_buf_write_free
                  https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
<5> 12      Yes   INFO: task hung in comedi_open
                  https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
<6> 8       No    BUG: unable to handle kernel NULL pointer dereference in parse_insn
                  https://syzkaller.appspot.com/bug?extid=ab8008c24e84adee93ff

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

