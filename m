Return-Path: <linux-kernel+bounces-844319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B84BC18DE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E848188F8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BE2E090E;
	Tue,  7 Oct 2025 13:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990532E11C7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844705; cv=none; b=p+0MsaGFd4h/ZYsBRMyVcYe55cTACS57ngmYBymmPOuJoyxDX0sYpe2U4g7ufIh/4t4adG0h+NSXIOZMmb0e8oBhWwEsQk2+toXNNUYWqMbXhyQH630Buu89Ivfy49GUnhxyHWzVBpyymCk3ECC53G1PAHgJ29MzMwRkujay6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844705; c=relaxed/simple;
	bh=xWjmLBQ5keQMZ/8RBkxKB08avkEkdT811c//csHk2jU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jw68boqmo90Ft33m8k1p6kAa0+2KhGSo8FX/DmyIjFV2X46QDBFZGhc5UNBe3xTGmWm8IabTiJAZbhQ4zf4syPwz1MS0zyoXlJmaGFx+n1bOGuBjhPoSeKd1uWhdl++Cq11zlSjtWa6U7LwBmEFNWTPsZiJvg2Hyd/AQZgwfhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257626a814so78258485ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844703; x=1760449503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdVSN+laD+F6d7qUqnjLSPnCbbVZWf+THc0/cthgRO8=;
        b=qS81qfdCpYh7F7cxLJ5pgOw3vRSTgqPQrELWhf3k9JpFFBQC0MN4xaZy18KMGYUC96
         sdz9OKait8rpaHVZk13SluYVIOl8DkCOTdV+2dQ+QcYd87oWWo+zg3x64EJJWyA9h7F4
         eNlQWSdk6Vx+WunzFdHpoBKdn2j7Qc888vJIrStfKaPoxDN0qk8YyqeyFog/AX5HYf3z
         L3YEU8BUcoHBGhspYUOeSGSx/VCVhpthvddisQmP3loVRIOfiOUVbOlMj6c+v2g4tb93
         pmal20hDiiUBah98j1Kk84BCNdiBOJrnA1gBHoChwiDpiHU4+ltZaC1A9WejhClT1k2o
         b2cw==
X-Forwarded-Encrypted: i=1; AJvYcCXU/jiEDNvFfVLFn83xb9Ls7uDKEBy/w6bdm/ozm9X8wrEMFZG0gbeTxucGf49hBzn6XEW0bupYm03Ic1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznaDUT2lNYffHAcW8cq3YpwIZR/HoeVqiO2F7WlZ10Dcdzbvgz
	5B+6Y2e+wteTxHv5dd5Qj/GX892NPuSDPnoHwOgaygVrHzFMelpGBxhXkY7KqqltRWqP6/LT0nZ
	U/9OshWfVgIWqtivJkqiggvpsU3eNf0YS0QwXKvC6tynciN+By3+Aj9aN1N4=
X-Google-Smtp-Source: AGHT+IGDe+oPvXrYd8r2KJeAOfh3Qf98hvHejyYDAqBDAgB0WT7eJV883xCSAVgnpvxZvRvNsyKTF/F4ey7y3Yb0sMtJn+EODoJ7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:427:709a:fc87 with SMTP id
 e9e14a558f8ab-42e7ad9c5f4mr189291975ab.24.1759844702723; Tue, 07 Oct 2025
 06:45:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 06:45:02 -0700
In-Reply-To: <747c4bf7-49bb-478d-a8f1-c7092ceaaa81@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5195e.050a0220.256323.001f.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_waitid_wait
From: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com
Tested-by: syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com

Tested on:

commit:         c746c3b5 Merge tag 'for-6.18-tag' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=110955cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f142ebe84501b0b
dashboard link: https://syzkaller.appspot.com/bug?extid=b9e83021d9c642a33d8c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13aa0542580000

Note: testing is done by a robot and is best-effort only.

