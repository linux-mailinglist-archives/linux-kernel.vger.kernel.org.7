Return-Path: <linux-kernel+bounces-720209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A2AFB895
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608664A1BED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E121E0BA;
	Mon,  7 Jul 2025 16:27:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F6155A25
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905625; cv=none; b=MNFJcmdt/wHRnPp5bdDPjvMi3d7OwrqXZsVkJYBCS4DZee8pl0yDhLo9AR73fQWzSers3JZdHxlTMn6IuXHAAoTNwmVOTpEVefZMCXQ6apBHPLCpDz72PrjphVjtH3r6YVdDg4lGjbEtVaiA9J7Ph4CXhzIEpI28/mLipYMAwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905625; c=relaxed/simple;
	bh=tc7S7/eJ+4S+9/JAOptsRxuYDB7uxt0LSF1mHlb94MA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MUPWzhrqLlv3tgvk4KYqGwQFknXi24ak26VY0YgNCdoCAkPosG1F6tCDFcbbXRo2MJDafdHOFfTHSOex2Cgavc8aStTDDdH12v0Y+M+YRlwggfBegCTvASWZsjbUzygdcZc083IunA0uagIGGoIk7tUVb3pR4vHPykjznZuZTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso93572495ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905623; x=1752510423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xd4C3A0IQjFn8w25wCpwJKDvBmxbazZS3RQuLT16nfA=;
        b=Fd5qqD7whBnnlkH66Z1qz5Zb88qN0FQtipOad7BMXDrl7goOtTWuTpXF8rhu0siiK7
         5550VA55VgabR1Rji0NJEN5eeyy6lVBTaWY/D94KAHyQ7VX0jE1ix3mVRXYj9faz7+tx
         8RCQpCn52IYDn8yWK+ccbEm1YUv6s2g78i/4lWeWrbOz/Y+x96BCRYDyZpKFASy8ol/I
         Dy8KdP1nJdNKzeZgP0BYjcQzYfBXi0dOLZuE3SmlCa4CQZ5fimKAdToRaMf+tmuT4nUg
         kVFwEGitx7Kvli2PvHbFXhin8+4km6AIeSvzzR+Snu9zyuWeOpOzVHqSfIKugK1Jg1LA
         KyDw==
X-Forwarded-Encrypted: i=1; AJvYcCUqIYT/aPbPy1c4qM2HIFLb3+EDoEZrJiPxBTKxA9G9iL5d+IczwjHPjM5IHn+TERnvBRGeWPwpQsa7vcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvL4SMlyIxDY0JAgrvJS/ptUI4X1Vxf9maMQTg/d4bmc6gy872
	urKKXkCQft0yM4lYd5r/N1WFNO9AMEyLBKc6prAR4rIGyueDTDTWlEOJvsLOBvy+zV4Tqdjn1bH
	+RvPNPjoV/CLqKKBmHZXI4FHLiISEzvKhmhNxKTsWMtrr0Y2WK+Tbgm4lMcs=
X-Google-Smtp-Source: AGHT+IHzzX7Mg4FWi1z+qau3zmFOwheiXBj8VZFTP5NPpqzbwVV1SNLfCRtgBd4ZnG2nf2LTtvp0fsLXmVTgqzJqinccbR/z9+l3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:3df:49fa:7af5 with SMTP id
 e9e14a558f8ab-3e153a55f96mr3025755ab.21.1751905622720; Mon, 07 Jul 2025
 09:27:02 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:27:02 -0700
In-Reply-To: <6710d2a2.050a0220.d9b66.0189.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf556.a70a0220.29fe6c.0b0e.GAE@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in do_coredump (3)
From: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, asml.silence@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, frederic@kernel.org, gregkh@linuxfoundation.org, 
	hdanton@sina.com, io-uring@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2af89abda7d9c2aeb573677e2c498ddb09f8058a
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu Aug 24 22:53:32 2023 +0000

    io_uring: add option to remove SQ indirection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ec9582580000
start commit:   05df91921da6 Merge tag 'v6.16-rc4-smb3-client-fixes' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ec9582580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec9582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45bd916a213c79bb
dashboard link: https://syzkaller.appspot.com/bug?extid=a8cdfe2d8ad35db3a7fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2228c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d48bd4580000

Reported-by: syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com
Fixes: 2af89abda7d9 ("io_uring: add option to remove SQ indirection")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

