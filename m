Return-Path: <linux-kernel+bounces-874797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D815CC1719F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242933B9196
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462B2FE065;
	Tue, 28 Oct 2025 21:54:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF942E040E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688444; cv=none; b=kdNsMTyd0PNM/bfOIa+3xB03levWFWiy6A8Fx/f2VubssgDo/xnEnzDm7bi8XQV5qd7M1uavaLnTC+vu7p16eqsq3Foh0/OBzGEOvdqrbTsADZzkweXIwFvr06we4XGC8W609TXP0AfLEe9BFPd9bW4Zwj8FWNBu3eim20OiFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688444; c=relaxed/simple;
	bh=gGhoVfCYwcVX9tRrOf36XZTy4yNTN9aphoA3oBrXF/U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fHH9IvkMh6VyZ8Bg8M1JTG+fO/ZfPmOVIGpMa4LQdUFDQT2LL+yWdy+59Tl261L1g2/GUNrAZDyDsONZZL/GtRBrAO4ktC0q3pHXAc5/1LzIK6IeRIFnK/Yq7xCn6Fv8UlMDpUGUws8/IFXfn2Q7rjR2ZPpXDoE5SsvmZapiN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d003e87eso235077315ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688442; x=1762293242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVbDYTj5bn4r7uEKFqf8fOZItmTjTtHMQUdwwWuSKhs=;
        b=TRiY+uRcWB+7nWufd8hR2NGbAufmruQ5m45PL+AW1rpVHWhy1mNPABDXUeGMZN3xON
         Z7V9K0DEKvMh8ZFJROo+7gDKm/fHaUUfV9RHq0YRO048Gk+4CmhyhnPWcJhAmecV0uSz
         ACxqqBqyk86IY69p2xdOTTuhEGl5MNPnA5x3rRjTGOynd7L3/+RWr62M7Vjfs9Q3eTID
         4vLZ/7f9ufZZwE8Et9uHAdpQU3v8tIH5lD2lGs+Br8ZijPP2wN90wzqknfEIwXWMeCrt
         U/2/lArTf7n1Bu8jVReA/B+7I8XlOjGWZEH++OmlR1uaGKpVPX21BQOm7gvB89DPqLno
         7MHw==
X-Forwarded-Encrypted: i=1; AJvYcCVuWmzEVuWXYhDv0hFmZC+HE7DMg039AyerZi9qZJL1xOG3JhGzvB7+58w6poycPBPpJtTsW2tDXBX5em8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXm4PAIbx+Ut4cO3mFf8nHJ6wpZDZfd9oTTY6965WGQXWZFAZR
	RX6MhswWSRSHxhOIG7f+FMiSJ2c8lXa181CNf0Vj819eE11MTAiNsmGk6/xHLVkBPERRblKb3I4
	6JjEBW/812TklmXj9ODBL/sY3TI9zPHTWDWRr0WrVJPx4Ru75f6WOA6zljdk=
X-Google-Smtp-Source: AGHT+IHlhqXe2V62plON/Bgr3GUXzg/BhgEvZ/ikZ4snA1mQVP50j/3Y733EN19S4YPowCn2Qa5pWoCZtm+Fvie4xNWs5e/QGBwR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:431:d721:266d with SMTP id
 e9e14a558f8ab-432f9090ee3mr10199355ab.31.1761688442206; Tue, 28 Oct 2025
 14:54:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:54:02 -0700
In-Reply-To: <20251028182255.i5pLj%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69013b7a.050a0220.32483.01dd.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=177e6fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ac432f980000

Note: testing is done by a robot and is best-effort only.

