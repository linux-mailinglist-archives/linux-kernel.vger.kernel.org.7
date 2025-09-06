Return-Path: <linux-kernel+bounces-804390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5100FB4759F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F900580F54
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2596C2571A5;
	Sat,  6 Sep 2025 17:21:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1161D7999
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179264; cv=none; b=j7tm6HGxBCBrU735OswKkn20dQDZUTymOwi/sgzIn42XbGkb57080WySNFgtVjuC4Bk8qh3k2/+wsiYqfTOY807fdQKOU1MuRgSQ8ji82x6Do48TW8U7akYFDW6cRzM0PNMzQLBfTTY02HtndpTLPIpJFjDuDc61UpDJ9QpMqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179264; c=relaxed/simple;
	bh=tQxZTMo28pR74Eba+y+tCQVhhsHZi3p/ioyT1ofUnS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r1sXOtm2wlUMdG/DR6Imp5JyeoN2/aNl+XpzPF2FNB0HQ6PaS3ThpzTuen8CtOTA1VxmdNlBpXs149ABFcrQZFRTh1W+2TkR38z6V1L+5qzJJ+HqEDiCVazbElf36tVT63cCyQ1HyzYSI9pKj5fQUlgTULQiBARhOfFDzoNp5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ec58544f79so87024265ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 10:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757179262; x=1757784062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KVdAtfXYXQWJRdIiNCPgVS46Oso5VqxBYZAHrli6R0=;
        b=wCZgCXOApMekMk+X7QuJnh/cAh10R5r1SlXnw9Gob+HaBFork23DIuqTmrpKBZba5W
         4IRiUKHGf4P4iElcrAFQzPFN/rheNo26OL38yzwVAiMFtOI6cB08lgoq4/tL/tvDxodr
         G3+cHMH7HQKFsIo75UwzGg6hSDJLH3cS8VUN95UZrHjp11xLBj5ZKPpf7R47HmSntIPK
         bPT/i0uL2aq5gz0sqjIkXejSiTBcg1bZyKfutXsD5KVPcHL31UM+eOGz/3T6hLL+Su9h
         pzSpGFZwqkRY/x1g6D1tH+UKPSqyZD1fpGXArlGko/E9S1XKEmrdfQYEO1M5JTHJPCYr
         iTOA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQctTBcM6QKmvx5FrpWLiWdcW7dTg33TSUUEAAAN6yfoMt1kfqJ22/+5aq8aBEAv26oqw+VR3+FYQwT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjOU/r5qjAR5ZmWJpX+XFjFs0s3tvvNOq7gmV6+ZPnW8B3Dub
	/xoC8I/Dfe2KaDdQkw+4u/MBs1V5i4/4KK3dDBxwbMy2Up9NUgaQdsS/4Zr+7+oYsYaHPDRf6+k
	gXJmj8a1C52b/l6HlmA4JPrOXd1bPjRmqJat82REpSyGqM+rOviVVSRrFCg4=
X-Google-Smtp-Source: AGHT+IHjtfsAvPlaAzgSpHJHqk93cwZfo+vC6d2Vdsdn/XJ0hGFuwgH1fqhtUvx/ZoGiBZhoYO/DOO8EDgCAUc6eoR+ho8iJJqNT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152c:b0:3f6:6068:8382 with SMTP id
 e9e14a558f8ab-3fd978f4c6bmr34467045ab.31.1757179262485; Sat, 06 Sep 2025
 10:21:02 -0700 (PDT)
Date: Sat, 06 Sep 2025 10:21:02 -0700
In-Reply-To: <20250906164038.153124-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bc6d7e.050a0220.192772.01b1.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Tested-by: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com

Tested on:

commit:         d1d10cea Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13687a42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e7d312580000

Note: testing is done by a robot and is best-effort only.

