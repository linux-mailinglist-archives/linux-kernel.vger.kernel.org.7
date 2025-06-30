Return-Path: <linux-kernel+bounces-709113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A49AED970
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0039C7A9C45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0352550A6;
	Mon, 30 Jun 2025 10:10:40 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03560253F23
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278240; cv=none; b=Aw+OB1ztaTmepMkIZnQzM97YrNeBGLPJ5FbCf+tfjbbD+RrzQlHqbuHP5tbeLa6lQwfiGfKVr0QOrtp/9co/st5J8fRIzVbEAEHGJH1DdXJQXkNKuxLzT2FKVU+KkRSGgp3hPfia7y6x3SwO8/mL+h5bEsxoZdGn+NI9As43GB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278240; c=relaxed/simple;
	bh=q+GSaN66P/hAbaEd0dbJ3bzboSnxohFm4lWe1BgqdKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LTK7wkdna/DCEmkU8yr7T0zUdeMLOl2tCygPid8JI7H2SCgs7KH8/ZtxlLE+EGfAnyQ90JKHdFcX15F8zVJjNYjnqoLF2mw8ofRQrMCdgHFnvVHHVsI9KSSRKZjy2B8PDULLEDC+IU2aAk17XlCN3efFV1xfWjwoywwjf/WKLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-875bd5522e9so142766339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278235; x=1751883035;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYZYzPhKsFZqh+UEh+ih+pVdEdOtXAWoeXoCZUGdQ2M=;
        b=cJAu05PxJlkljdGJdJu0NB7/m3vzq7FsIUypUFalHF7l7mDv0NZrL/hrteLcw/ZedK
         s88Ik/90F1/6tPfFvDumwNau9spFGFq/EQXHD/jcD2Kk/K3mnJzpJ7xz00Mh8B6tyju0
         0kZAvbMmUXvf4zvDWebUYuozk8WnBD0o8GTdo+nE/6Wog1jpEEGmTZJZVujytG0majMl
         851OU8O60Fa9ZljUBRPcZfnS3aoN2uox/D7mOO5jX7gzXSQBZzR3gjV1rtXXhDIQQKjS
         vsHyo0rBdIWEolDqMQ7dQQUoNTHcChfsvxvuhOlOG6JM3OqWEoiio9+AMKbrFTKmQXNv
         TR9w==
X-Forwarded-Encrypted: i=1; AJvYcCX7n1zsr9mmKP+WRvpEItqjUW+o1C9vPOxkeQt336kkhdJiRRn82Y0zuXDC1HgVkiT8v8abh2Ji8S4KdtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6p7BImpRTOpKbkHOFwsTyk74fts9swFYhzIvNSNz+A7RAy6J
	rIGJp9LHfRS56Rp8M3HLcyk1eo7PqHNfH9On5A4VFKH69rY4Oy8DtyY2HJw4OYxIZ/OtgR2mCdt
	qXhA+3iwlhg8SKjkvR+rhp6tfCjkU8e2OMlpX3Y1klrM0y9E9UZXJSgT8inc=
X-Google-Smtp-Source: AGHT+IHz5oO5qpbyZBE/sAkrgQEjJ+W7LQ5l+8B8YQm3F/RkV34pJsh1ifMkIJnT3F+aTwJzUkH72FqcP2eRPFrNzWu8M2aWQYDC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d85:b0:3df:2a58:381a with SMTP id
 e9e14a558f8ab-3df4ab2c75dmr153922205ab.3.1751278235044; Mon, 30 Jun 2025
 03:10:35 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:10:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862629b.a70a0220.2f4de1.0029.GAE@google.com>
Subject: [syzbot] Monthly tipc report (Jun 2025)
From: syzbot <syzbot+list277ba083797cba9f1423@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello tipc maintainers/developers,

This is a 31-day syzbot report for the tipc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tipc

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 84 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 668     Yes   INFO: rcu detected stall in corrupted (4)
                  https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<2> 95      Yes   BUG: soft lockup in do_sock_setsockopt
                  https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
<3> 10      No    general protection fault in tipc_udp_nl_dump_remoteip (3)
                  https://syzkaller.appspot.com/bug?extid=a9a9a6bca76550defd42

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

