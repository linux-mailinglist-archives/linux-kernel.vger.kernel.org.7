Return-Path: <linux-kernel+bounces-815382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968EB56391
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C69481C62
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E62BD5A2;
	Sat, 13 Sep 2025 22:19:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506A19E968
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801945; cv=none; b=K7aNIOIA+1T4oYqLWxCnIXRf83tILq3dD8THwHedwrKdODswx2oLEpZmBhp8TPMXVG77sU6bpsZ4f5A9WNMZt0hNzxH+rEm0nmvDIVxmi0EQ2ulxtrUc2bn9VL7GxU08bCvuJ8pkr5/nQoHi8ssMaV8CkQ0wJO/bF6O7E1rgB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801945; c=relaxed/simple;
	bh=V8KWTfJAXe5U51lFDT/nIDnV9U06+TVlcHHAOpSs4OE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vj2ty7j0EWUCZCqfUXSbw6SRdDjJlv/4bP2HisD4wI6gmfDMBDJq5Na9k0N368Lhz/ilzKvliAXL8SCZUnlcOX4nrZWx67p7c5v0kmT6VYTFmO46xjnnKrWz1P4kN6LKNzIW1ozlLYHHZ9JebhX3RAQB9iJgmoH0b7oWMzEjri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40826edb6e1so24016915ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757801943; x=1758406743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kdro/UhPAaYKCYvjR+8D2rvwiyRztTlmg1xMUQL1gM=;
        b=tUGxYhh/w1sPZNdtzaxZ0/12MX68XUYKMRaRUtnv+BKqKG7FLctoqJOMUjlNMMx3Ch
         QIlRrE0UvEAWQlHrFOuKkOXTjxkYCzpm2GDkNCJdhomnNWNLg7clY44jSziVlqSlzRLX
         HnRMgVFJ++KEOe+wmATajC7s46Rfs4UG2krsBWqQLtKXWW53gEA9sma/7R7rTuDP6zsd
         6M1VNqrsJMBIFk+sFxSz1YdWsDwvOGnEp3NwVTbYfWbv/NW8nv7BvmS9CXkC7+N0yQXG
         8yXGdlROO98WTXUdUWVd12ZLZenEZ0HdP22x+/9Mfp/CNsbIy+CZLo0/9JOgXoUj3jTA
         diJA==
X-Forwarded-Encrypted: i=1; AJvYcCUqGkrkPNn4/1/mSi+oQ/AmIgjXNc05ln9KP4tuO/yYZlB+g7iVmss7X/CL3ECihAqgM012t8QfiSqyy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckDnDceln9wDV1c4Y+5U00/Jzy6KOEke7RRkx2qQFz16kcTHA
	4RcmW8tFjxkzHx4r7YyATBxWGJduQPsjNEvpOv/kbnrwZPEIF+8LWr8ZDxQLFdDKP+yDiUGduxW
	cJnsRVv0iEk0RJvCzSajsFiyibEdaZi370fQqHPXwTfAzysYkVoh6yzhsHlo=
X-Google-Smtp-Source: AGHT+IHQX4qa0uwDd3OIYInm6KE+5/3uSBwO44mSLzJrVwbLYjrFNXKu2P9PWx2ixvJiw9nPPTvKNIBXgq89Vdjt/KBRzcqQiGXn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1906:b0:423:fc0c:e5bc with SMTP id
 e9e14a558f8ab-423fc0ce745mr16633025ab.29.1757801943267; Sat, 13 Sep 2025
 15:19:03 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:19:03 -0700
In-Reply-To: <CAL4kbRMJQjoUGfUPrLmziK08sfCeHusvMPN1xLAW5zckkHqEQg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5edd7.050a0220.3c6139.04dc.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Tested-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com

Tested on:

commit:         5cd64d4f Merge tag 'ceph-for-6.17-rc6' of https://gith..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e10b62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152f3642580000

Note: testing is done by a robot and is best-effort only.

