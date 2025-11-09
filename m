Return-Path: <linux-kernel+bounces-891980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5304CC43FB9
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED39A188CF1D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A102FC01C;
	Sun,  9 Nov 2025 14:11:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB32FB618
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697465; cv=none; b=GTLGpdyGhIJGtoCela+aLtWzAxWVV5RzAdFUXaFmoM37EqBxxC9JRnW34/RX0XO0cwTOP+ddrBkeEgyKEf2ttr0/gw7nfvfZwNF0+YxTbJ9DlbHUkCPbYbKongb5W+WW17OlA+pv5pwvtJ/OULB5hlbRN5gtVSInuv91lTlfmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697465; c=relaxed/simple;
	bh=y6Dy/w1K3XpX2uFUEe+rBJFRb32lSDcExJhalbXQ5aU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZHnADk85rsFDUfhehKOo8UANwxl7W3MEMFG4US700k0dkqqsvuLWMFd8jx6B0hV6JgO2gsUN86t3zpZImFIY+tSJOt7UheIrovKF5pswTfaCw1saZA2+UPL7tFhw+nKiuF+sxaOUnumtVfFqgjkQ3paU1hQwilyTs/CABuRgdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433270dad0dso19162945ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 06:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697462; x=1763302262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m02kWE5lhyrzZgApWthbB6kQBtAUB+gmZPn3Dt1ZsD4=;
        b=T7PDJjecGddaJCaLxCMtiBf9gBFB1JOfqH1716ifa/WEN6HY2kQzvtBSG0Z7+fvgML
         6ZJa31Fh/yIKDVXnpkTteLQNlCwJnlO5UAf5TMq2V+A+BdcdC8/7VVsxCaFlv8wLcLAv
         vkShXJnY+6dE6YZo5ARz7/IsI3Dk42oTP4VAy2HFKZKZgss/oeRqUu5ByCxKIQA7Jt7d
         0VFoDYlcRs0rVaYMsQjCrr305Y4xJl7n/8/gkdqFjh8vQ1Ka0UtEKGQKAuX/1JD2UzeR
         8feRdSp9hTfVtXee02gWYFtb2YJj70auqGf8IRf7+PMisWTTuwjRaH1IH3mSVPOPp8LI
         zWew==
X-Forwarded-Encrypted: i=1; AJvYcCUrOYjX9BMpCW/W0nt8wOplTrDxzoO4IrMrQMeRyAS8pjsU0JZUdhS67iUlA1VWlYAzjtdC7qnZXh6aYNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQ0NpvDG533FgBNMIC+shefai7rJ7zenyBtD7pgwPk3Cdi651
	1R9xOUUn9H+K2A0HSZBpCI0CVnal9vNHP4SugUTa7WZP4zvp77TU07fX7lkYU9Y4+m7njd1UZM5
	F9LOne+D9aXi/RTpNuyN81uFZfF5KMSL0oh3y/bW45LBXTnyuXaPQ8hDX7Cs=
X-Google-Smtp-Source: AGHT+IEw+SyBMcsmvsru2ydmWiAer57ckBKlQAwl2f1WWyRnepHiN7uVkkXdan4vghsxm/ZOPYzm213l8SerzWDt7Il3Poc2ozLJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:20b0:433:7d0b:b377 with SMTP id
 e9e14a558f8ab-4337d0bb530mr14752975ab.15.1762697462239; Sun, 09 Nov 2025
 06:11:02 -0800 (PST)
Date: Sun, 09 Nov 2025 06:11:02 -0800
In-Reply-To: <20251109-lesung-erkaufen-476f6fb00b1b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910a0f6.a70a0220.22f260.00b8.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, bpf@vger.kernel.org, 
	brauner@kernel.org, bsegall@google.com, cgroups@vger.kernel.org, 
	david@redhat.com, dietmar.eggemann@arm.com, frederic@kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	mkoutny@suse.com, oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Tested-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com

Tested on:

commit:         241462cd ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b1a45727d1f117
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

