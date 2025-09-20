Return-Path: <linux-kernel+bounces-825843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5DB8CEDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5997E3C87
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33E31281E;
	Sat, 20 Sep 2025 18:33:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CA1DF27F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393208; cv=none; b=G0n8Q8LjJXNg1wCMsdCgtdmmqiciyW5PnC/C/bDBisIgbKNA2yLkKTiIj5rduwzPRpeG6WwlWM86HSG0F4OG8LWCdPsPVplJ1Aolwu1lGT7f9q1xNHfcKzK9us9bSexbwxsrp1w5smi+lMYnqjcWHufOPIXe+oyxNvmKeEKyT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393208; c=relaxed/simple;
	bh=q3JwbZLYkwQ6662aLHgG3XzreNcfXAsrUOq0SyjB5Do=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B07/pMrF11Ze8FtYkpwf3Uu8+nroPZTsp1rQU3VpF+p2zg4FO9fSX8DiNGgujYpr2JcG9OUPvgMZWPj2dMkrbCQWnwUEz4qtwCH+lmBrDL8gEzCedZNlCm8/5LtTTmmil2UxRzCxKcP3tSxIBIXmxdIJsPf/qKW6hnoRV7sDGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-887777bd720so355302539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393206; x=1758998006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MxQWFMj0zJHq+eE4KxBbGkYIuLFaEc9m0xWis+dN6M=;
        b=pld3jIIJYV2meVNYAC/AGH1f24NWEbU4fa22/oaDvqkzUwSr33NR0Zwprf/Qfx+v0k
         lGS2O4/FUU54bIFhFt5bwy4IGPFeaWrVehDQi1WNL7qdQm3XREBDFPfHfEDjppEymLDk
         GHy9pn8rsmofdKUU/dP0hqZqjCVWuEYDPaa7BB1kTMn5cRp1wDJU7pfF17ZVF07B6YSv
         IjWUe9rL74t69mzR0QzsfZy+6HQMi8h3x3X1S6gNZZZFlLm7YjvpTaUdMm6loK8tL5PW
         xKDBygWBTcz13LCvW2B1crsdTU5EGmoW/hDHFtwnAQhbmBIb556JcGBXLAYcvzn50YBB
         zeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUH0mMiuMSKgmXKGQ48FT8Web4b0+O6Q3qrQQPzu3X9HtIFwFZli5KGaU2tDQj3YYscjD2OGuilChvYe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPchnxfcsI+yv/dhSIk2URRDIjJfcHiCAoUIudzQXoA1KNKrZG
	VSWJFox/ihbrlvXAm0HGWllrkEHLoIK67HX7q5n7O7DVyDlMw4XZ2jngaGY0zjA47UmLYMKpvp5
	rE/B/+rSY+SvObBYVV8Vfkn/PXVW4vfnebnrrR7gZD+zU6zSmwjNSbtkwiR8=
X-Google-Smtp-Source: AGHT+IFZHvT24Hr2IWmXXBCBm3AbfLkO1CrX2GHqJ7LPOLF2UBqELELG0UpX0nSreYr12sGwFWvG9P/DkpiG/5Jout9w4zYMT1HP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:424:8c2d:ca43 with SMTP id
 e9e14a558f8ab-4248c2dcd45mr51544435ab.29.1758393205956; Sat, 20 Sep 2025
 11:33:25 -0700 (PDT)
Date: Sat, 20 Sep 2025 11:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cef375.050a0220.13cd81.001d.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Sep 2025)
From: syzbot <syzbot+listc8cad7cc6e5421df7d8b@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4276    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 557     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<3> 554     No    KMSAN: uninit-value in __schedule (5)
                  https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
<4> 211     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<5> 3       No    WARNING in __nf_unregister_net_hook (9)
                  https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
<6> 3       No    general protection fault in nft_fib6_eval (2)
                  https://syzkaller.appspot.com/bug?extid=109521837481c8e96ea5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

