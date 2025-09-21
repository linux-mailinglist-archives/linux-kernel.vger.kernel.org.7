Return-Path: <linux-kernel+bounces-825990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699BB8D459
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6918A14C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D323ABB0;
	Sun, 21 Sep 2025 03:29:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746670823
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758425345; cv=none; b=UXmjXClQZIuTY2BwUeA8bg7loOAtbQ0hxdobgw5mls+S+68jCyTqlVu6VbVcIbVYzAeNfrJ9fsnBww5FXdmAgxd1amie1ptAIr0WmVGd3wLMa2gE4IIoQ3tStAPvb4HXB8lJAHEK8aetM5ezX350dLv7+8imhue3ssgUcBzTwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758425345; c=relaxed/simple;
	bh=NP2CNLbtWXVOuY0EJY6YK0n38qZXqxhvRvf8VykAuwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kvR7ulKU4d4OH6PfSj4CUSNWDRDwnSgR6Hj8NaFJKMAqFe6655ADw0FpnCuFECnHMjxyeh75Z3MWe9iCl9nzxct7QwM364BBJGvlhOzo6O1sv/e0KsTcm+I8LwTvEM3hvJmMb/mW/GcHb1gVJt3dMIrTBzlXwbH00Bqr+dB0oYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4241c41110eso76040435ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758425343; x=1759030143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzF9pQGL/dSDAqCYnD120ecB6ltl87b2sRC/9WMhcnI=;
        b=l/Ye5v5cB14xFZikCP+UAFACsBZVQPL3iTyM7SyRsDEWW4UsWxylDCMasHBVCVqJAg
         Uirog/s8+JYRAAWXxevmV2+WKC5zepEeRImTMdXMpn2fLSnnVuZnIjdmPKFclP9jTAEy
         QYf/In6nNAOAGBK03lzVrUXkS0TMIqjoC5LUFfBSGZFsGQeWhqKbP7rQNbRl+8AkSsDE
         JFqiBWZ07qyZAyNYyn0A7M3EpH8neXsdtqhz4VB1n0wELIkk5qP+jB0nCK4p6N+PLqOq
         w+I7UxjmH3v9kaIZyRoHG1cL7/B7IM9xt1v6k/9SROPI/A82RhXB1YKN+oV10dFxBZMd
         kBfw==
X-Forwarded-Encrypted: i=1; AJvYcCVsiIlDvVljav/zsBy2qJJY7hIeeizwrevHkCS5fSqBAfrkCRJijyGv2FaSyrcGfTETIg2TLXv0oj+TG5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZsytYsviT5cuI7po/q8UcUq0kyUvTSSYppA5SL3PD9Grq5/u
	N/EPSjZld7dgvh/elPvbxpw6Uk6V/geKm0HDwFy+X+B/W7djygoHimd1UzPJ1B9XfS55Lt7/sTs
	pqQVSk4FTD4hsL7TzWvn9IXvLFr/9IaOgVBzHHSmi33q35304JAQxSAZDRDE=
X-Google-Smtp-Source: AGHT+IFkbZf6NnLB56PjPsarlMgw5ur3nyd8v8uoe1Uy3ZR9q/UhrMEzpRBwhJQLT8Mm57Q5itblFJYMc+FgtP3NG6C51KUQP5Sy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:423:fb73:315f with SMTP id
 e9e14a558f8ab-424818f7ff9mr137978605ab.6.1758425342754; Sat, 20 Sep 2025
 20:29:02 -0700 (PDT)
Date: Sat, 20 Sep 2025 20:29:02 -0700
In-Reply-To: <000000000000c329d505fed78c74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf70fe.a00a0220.37dadf.0036.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uhid_char_release
From: syzbot <syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, akrowiak@linux.ibm.com, anna-maria@linutronix.de, 
	benjamin.tissoires@redhat.com, chenl311@chinatelecom.cn, clg@redhat.com, 
	davem@davemloft.net, david.rheinsberg@gmail.com, edumazet@google.com, 
	frederic@kernel.org, jikos@kernel.org, jkosina@suse.com, kuba@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4051ead99888f101be92c7ce90d2de09aac6fd1c
Author: Li Chen <chenl311@chinatelecom.cn>
Date:   Fri Jun 20 12:02:31 2025 +0000

    HID: rate-limit hid_warn to prevent log flooding

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12071534580000
start commit:   fb4d33ab452e Merge tag '6.16-rc2-ksmbd-server-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a237c32900fc479
dashboard link: https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d7ed0c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: rate-limit hid_warn to prevent log flooding

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

