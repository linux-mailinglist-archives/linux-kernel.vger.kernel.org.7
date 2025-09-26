Return-Path: <linux-kernel+bounces-834522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC85BA4DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD903BD095
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1B2FFDDC;
	Fri, 26 Sep 2025 18:13:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4294C81
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910412; cv=none; b=LbRcbnnLygnhELzpyR6fr6sEWYuswHYtcYW9TLMokRvx+9nZwn+8cORr74WMc+vHD2G3y7J6GVCCXPPqZwwMe3YzbHAFmAZfs0kPc1Ger4inGgQZ2oB8vwtxq8S7zQyWBBjfESRbUFgeglaWZFL1YTmLVQZHMuLgdWndo0uwmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910412; c=relaxed/simple;
	bh=Y4MacUweR9Sb2UzA5K/8xmpkwo1sje1B0Bb3PUY6nFU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i2GD9NZUxsmahtMxIW2dF/XmPIIHAKCncSFtZIseGM/a3TXi994lomH5CEzbfwrWz7IYyBQQcQ/zrDE9tEiQcIYuGEb62s/FVBTzqJZ1SipXNaRnexetiWoxGRWup9dLO7pgJFQoAi3Aq1HNxPa31Jluj+lCxLiK/Jr7JAeUmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42486f6da6fso35461265ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910410; x=1759515210;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trW/5NZOPRaukq5PbeSv7HCfuq1dc+w+tUhzCR2hFEg=;
        b=g1XPd2Qq3dwlAPpHAYe5GZZPR0FjvBcdpal7UACV6J4/NerhvQgF/+rnAKSJ5bWQUd
         KUoP7KVPzT8Yry+DSQvrTYRJPrZ+w0hY0biXh9X3KIevpoDrT0ZonjUxP7jM8N5wo5wd
         f6HqrioKhTRjJTRlVmFcsQL1MRQXfXONAqXn0qRMAoNJ328DTNQxkK7H7m8TDK12Tdo2
         HPrZeGYztgGjplY8Es+V3x62QPYycEPQQLetWhQNSL4TOteL21S6pfUKD+KunL/IZ0/l
         Z5usqMEBraKqZoTRCJ6KHd8u3pQ0WHurinZiSaIrggGgA2g2hIFcbnJrjZCvbekOCVP/
         T6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVRh9GEgAJua+kue7uDCl/D0ytvx01wzb7HLklgsUeQucvU1rHS2tVqzqQolyBLcK0PE2eQn87/ol7QvKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7TNl3qLSi6DLjAcA0ljFzac6sTpH5KKXR6WPE69tfpM55/wm
	rzxGTqNKNCYRdbunQCH9EbX41C8ppPJ21jOA/q8hPKbHtptdBN/B9YlCTWdUh0rRO48oXCO/XBh
	l3lKReJ84pI0oSVxOGWrLtXGMxx7OX6uFMmXIpeI3s5pt2JXvRl61LwdPmi4=
X-Google-Smtp-Source: AGHT+IErxeL7xZBwcqKbjwuUdAQvqvclikF1LKb7JolrauwF35tFenXJzZr4pP+7hdqoDn64jIhyZX+nNkIE7fTJaGjGtUTAaizL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce90:0:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-42595650bd3mr89971875ab.26.1758910409965; Fri, 26 Sep 2025
 11:13:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:13:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6d7c9.a00a0220.102ee.0008.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Sep 2025)
From: syzbot <syzbot+list5c996330145ae76e69a2@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 485     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 78      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
<3> 16      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<4> 5       Yes   INFO: task hung in lock_two_directories (4)
                  https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

