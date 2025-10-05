Return-Path: <linux-kernel+bounces-842247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC976BB9509
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABF384E326C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40215237165;
	Sun,  5 Oct 2025 09:14:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1E2367C3
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759655644; cv=none; b=BbdR70yheSqAcpBk5zZtE1ZSwXA6FRBy09GhvTh8Pu5655p4lQMkCSvhrQf1ajxiXcrRIX1sJ5eH+LAn+mae7+0xv0vDMhWUkDkE2pg+BGJNr2+2mFAFAMor62KZ9lZUFLuAohiKbWHk3O1WWe47hy2cnLs03Y86DpfujdatntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759655644; c=relaxed/simple;
	bh=H34rSMLRo5ox+4zTFl4GS4LnJIzfr2fDRBwRCw68UH4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mJ0O0tjyZM7IzCwVq2kOqGrDbtPBzDxUWlQI8StYB4hw4Io4xAc6S5WuR0LbVjZIJhuz8m9VlaEvxvjJKOV+8OsTQwjRWC6XnlGx5VWAnRihCtor0D/ecFAJ4wtmsBoTdah98WaQXeAzwlUCWa0mZ+XvdsBwnhcvaiRx/GzV6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257626a814so48818795ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759655642; x=1760260442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmNePfym8pBO656fGUOcU6Vz2O81vwia8wviFyHtfwU=;
        b=QIKyKRdzllQtvx8PV4q2WIsyjEGKY6WigpzfKU75nfmj0swSIPxFD7EkHSFyMeH3SO
         fmHS11JUy9IH6JgSR7Q4rw2PCSdn0TQ2exj7ZlTzg3wjf9mgH4xmAh5BrmEUJalgyOFo
         37zfuF/8peY4fjQLk2u0KQlJNVB5x3luxqYvYKtq+Tf4f6vkX3FIg04IYFpW/Aj43aje
         i2hW4d7QOW9rjrlAascJtL0cPrVv5O4rP0RAjPsu2yOAMt7AwoTKrzJRq5NIVdBaNnHm
         l7KY9zTPOVm4VqynY4iYvJSvuHwTwG5Gne1+5l2VZ6sSp9LnPkCaeNKv7oQSAg+mo3FN
         G1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBmt5/oORLjxrJpp7Nymq8EpoRoM2jLstXcFbFDfcw8+jRf3BNzBh+pReEytOKNhhK0zfIVG48SxzaQK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4IfSsirI38g7v6ChIsAc34EZV4pAkTi10433QCyj68XUGGLH
	TBrrD/o+9vUzbHNbeAYTyf+ca+VAH6ZwPhh+EBdcImOSVeST6THK1cUWSHTWHIJfWQ3lATpBJ+h
	JBrwjgSDjAvTuUxzRPO64iA+1LzQ5gM9LLWrveGjWI0vezZZBV7KO9qiz9Ww=
X-Google-Smtp-Source: AGHT+IEjlfldwzui4PYGsbcKlcMxNtDpApYrLQxJR7n+fzB/NDv4H5uMwRPJ7VsmyWCmjFlL0zA4SGF3nT6y88dh2s3I+Y2nlmRg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:42d:8c22:5e02 with SMTP id
 e9e14a558f8ab-42e7acedbf6mr110493405ab.1.1759655642510; Sun, 05 Oct 2025
 02:14:02 -0700 (PDT)
Date: Sun, 05 Oct 2025 02:14:02 -0700
In-Reply-To: <CADfthj1NsOSdy-Mry0CNr+kx1Rw6gdFy9hN45n-WqLbpbxVZaA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e236da.a00a0220.102ee.012b.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

Tested on:

commit:         6093a688 Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162db942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f142ebe84501b0b
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1573d334580000

Note: testing is done by a robot and is best-effort only.

