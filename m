Return-Path: <linux-kernel+bounces-826175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76BB8DBE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019057ADA84
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E924CEE8;
	Sun, 21 Sep 2025 13:31:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DEF2C08D1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461465; cv=none; b=hA9FqlNh4q4+9872UoDFh4VGNC5OzL3PNEIYfNX3pP00wniEWFh0KgyFXVVTH261NO/gW0L2mj7498NIDOBLTsi1E5/Jf9dDwsJlSKHdpodk0gVfhRxwqDQW1tWc2TVNuZxzIcKWeYbSpYhX530X2GCxx6+QGrYL5/wNk9UcgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461465; c=relaxed/simple;
	bh=WtrS07d7+cKxJcvuS+5QoQ6PIOvYu0pVJLWpuP+Tf1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JviT9ygwwvslijhnLXVnQFxoODQmTLvJVc7Vz8VMh+MzxM/XSyp4eMXrInJm1xP0jB2wHLSvhY3l9m2D0ZVziVSqd666ZiOrQUld1iCxslveVoqj7R3WXYiELFEwAeRbgyMyB50HA7rre0BuwqFD6RZPAtm6kCeLs+3/CS7JnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257462ab66so10729775ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461463; x=1759066263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiQRdYcXrpiVf19CCztsidu+S4PHDmYt4POx785FwlY=;
        b=TcgmGQ0T7FxZ9rfLGI25VkIiyqRqQZCxPLeR5CEORlanW7CDyEDXGqUMYn/8oMmniX
         33lnvegykCtlollaoNStjQkFEcW80xLzrAiaXnutz58oTn0MP3eos+ij3TJK3Lxnbb1U
         LqLnIjO2D5OZsQB6eQM/NyB/S6VvAYs3ysrOEcOV5aI4t1mBlhnMH6jnif5sN7GGt4Ky
         Csd8oSWwW3K9xs7G0aB9kFneePai/uDqnipsdObCQuL/Jm+y0uFsNsE+tkdhUSp1oB3j
         gZf/XkC3qd5Uf6u8RXZb1se1GuYhpx6bvkxuQXTS6zwdotIRFgT+VhvwddoTlPAZ6Ad2
         y29g==
X-Forwarded-Encrypted: i=1; AJvYcCV2aXXXXVtdRJtWODJk/kIjRy4Wu/gE48wh/glPzy/RMncjVN7Yufm1bKi+TF4kHrOhiGIu9DFPLEzDG3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaluuwQ41XVg8NLbKt1j7vW3yskpr6yLNFUQ2IpX0WWpE9Erkt
	tBlpPRKplVfa1bQdeeaFvAlRGMDvIH1urDYwhmXehIlCBUHjLwtQ+CAYTmOH9XOqcI+BRz9nnyT
	Rr70hs34tA4cXm1kq3/hgBnoePwdqEEi3Fss0Jov6n8VUm6qvi43oMttaHmU=
X-Google-Smtp-Source: AGHT+IEGkrIO9udB5nrXdVzkfiVIL/hcTyXlJ1peYFPQ7nDbEh6eWcUemHnCxcKw1j2N5V2c1NDHpUBCeLMWjFFu7P87V5ZxCe3u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:425:7539:bc39 with SMTP id
 e9e14a558f8ab-4257539bf4cmr17571985ab.10.1758461463162; Sun, 21 Sep 2025
 06:31:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 06:31:03 -0700
In-Reply-To: <68ce15c0.050a0220.13cd81.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cffe17.050a0220.13cd81.0036.GAE@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in __bread_gfp (7)
From: syzbot <syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, jack@suse.com, 
	jfs-discussion@lists.sourceforge.net, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113248e2580000
start commit:   097a6c336d00 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133248e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=153248e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=4b12286339fe4c2700c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116310e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1430b0e2580000

Reported-by: syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

