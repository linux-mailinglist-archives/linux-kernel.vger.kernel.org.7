Return-Path: <linux-kernel+bounces-784312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED15B339D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2261888FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFB2BDC3B;
	Mon, 25 Aug 2025 08:44:40 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B61F4198
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111480; cv=none; b=hs19SR7W1JhfOhICtkIiQP0D4ijG4urXdqFyYb6JMANkG2mrKNAOf0J/F0I69mE1SYahYDycwG1N0FheLUMPBiaoFhx24tGQXdXKia5uH3o01WtasnOyR72b2ZNl5H+i+jVpt407++0j6IxgtjEj5/QjetGGzRFjhAs8B9lka9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111480; c=relaxed/simple;
	bh=Qx0EHnxhtjRTgy0Yc6CzMXRY5epJDTWnoDhJh5mpf7k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MptR+chNdoT2UOh/aVj7aac+s128rJt9Q1GlBVJdzFufpPuecxoqnMCS431cdz7ys9ZNU7Oxl2J0tsUvLchIRRh0oeoPVRluGPfY1+3EXxCrrnWgk0kF2qqcY6sOYydYvcl2ysI4cewgwoKp6CtR5X9W+oCpXhEGCyFsU/KnbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ecfda20275so6680345ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111477; x=1756716277;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QejM8CXnArY2Z2VtT+tzHm/yfYtQ1A2A3xEkQg/zxAs=;
        b=SkiIpgk0otvS9fWpcOBJBXdRaRzK6xG5VWtydbIBjZLlssFi4ipa0hBp46a973Nlsw
         fJG2uM5mvwnhaZG2AFWqzCvGy2ymnKtCDBQ+eWS79axGupaX5WoPq4fQ4wUZgv/rXUMB
         TnljEUvl2GfjmcnC+nhH8Q+5R8ifinhTcDy7P/+kqOc9Xk8X6kzvJr/xAmigcFS9mDtR
         pl+Darq7ji80sZpWj0p/J8ewoaupXIETI2JtwCwqRqpe4naUsdPyDHAv9u8Lo8cGPmR+
         /gYOX1/V0+NjpUXvXbRb07dQhWwxV+CBLF8/4qJUPJrJBQrF3h85rI5TQx3R7y1+hslp
         sGMw==
X-Forwarded-Encrypted: i=1; AJvYcCUPwZQVX4YoGkSDeX7pY19wSpCfPdkblStliGlOIVqd83aFWg8s4Lww0/CTYXadUCRhoCPp+WqbibpRKNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIUM11uCyvqJu+efgHLm6/QdG+ZXmkxUUgCvw4jePw1FoA8TU
	toonuMR/4c7XJGnuROu/TaR1s0ruFDVFWdlVbE/Ui0zPA38XHCZREqA/Rr6QeCrNWefytrIS87Y
	KLEfZhFzkmvHrQeDxZZqTgI6To3rDljnIDmV3MthCk4JqW9GM2n4Rd6FIAFM=
X-Google-Smtp-Source: AGHT+IExklVy4RkzKLt1k1C9yMIcJKDJGXqHdt4hcHiXrGxSYT3tvBS0hk1y8LwOXjRNNcgBcbzg8ObZd7lis7tJrnS+wxk6WZKt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3ed:684e:ce05 with SMTP id
 e9e14a558f8ab-3ed684ecf4bmr11871485ab.4.1756111477622; Mon, 25 Aug 2025
 01:44:37 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2275.a00a0220.33401d.0404.GAE@google.com>
Subject: [syzbot] Monthly serial report (Aug 2025)
From: syzbot <syzbot+list55834a7fc215ffb76396@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2317    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 1530    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3> 215     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4> 196     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5> 166     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6> 149     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7> 97      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8> 27      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

