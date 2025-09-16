Return-Path: <linux-kernel+bounces-819171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202AB59C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B51C03640
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8F23D298;
	Tue, 16 Sep 2025 15:48:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE734320C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037686; cv=none; b=l6xihHPWVFpd3YXD0kiSTM2KbPKeyvYSeIaK6w/QhwM7pflvU0mJxwhWLIbbufy2YDbrXympVI5TwTfXEEtbqEfQWv/Nd/LFKPVc8G+r2lASxRtgufnmJH5eNpqR7qEWlvTJrgXovv7B1BHtj1JLA3NWIc6k8lEVhvQ68T5PXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037686; c=relaxed/simple;
	bh=ME871PuuLoLruUgRH689zkVj6tci1cQZVGlrYRJJU2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ql1Rmwl3RijwL2vLZ5ktIt2YLpR5nqwYyHF/Q1yWteHFsYKm5DDJ22evX0l1OzU5wcARotYASfZI8XIkX5NAsUCTBZwI6/lDJR+bZoYho28mByTx8KEgnNIpD8cSidhNxdiK2ds0LfmIzmJ1uQjrX4BCQ9T83J9I+VznJFe6nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424122b50aeso8551015ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037684; x=1758642484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFxkt82wHIi3LtYj4/kbpFYb6Uehv6JAkbT0HdYzdPo=;
        b=LBb0XIcNvCe/hUvTmChX7f4MriJ4rpj94/A7FlO2M3HnCvF+/K7io7kstOvaFak184
         rZRpXiFZM+Xy67c77MWrku0PxHZe7r+Zw02I1lhjsCiTSpiuXJyIZXqZn0lqkXdy3VEW
         mqVaFuzrcxQkGuOnU7R/ZfeGKi7ktwUICOZPBWAZsbwHOWyYTLur+cdCDAX7G0Sa0jIS
         76gIMjprgR6t/21mlKxtOe30QNUW1GX+tGOOuDmVzaaCd+oe/VVDY8jYUx5Nhv4O54da
         txQk0Ipn5qgx6sjuZzI1VztlEQ3C+SIgvfkpqJvX+x/9v05LrTILRQfBg4/Ah2125U7p
         ypeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYBvuDgaV0d/gUmxEWSo/piHgkpxeS4VOaDXsuM8OsioKgGFZ7SSfmqFDTVJqcFU14Nplj1muEUaFxlXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJEiF/B4S7S/Um+wmUQKJG4RU+dQxsmPnfGRalhetG51AHVOY
	lQ6PzojxtaSCG0zBBKcwuVWwGSqXoSiqjMarNW9UigSBPIEyj7bghZt8+Vt0nf7Nvu1Emet7KI5
	PQibQcIlhe548sePuHdb+wAyES+eWqW5pjewBTvl3cIF4cFiIsxltZrvuwJE=
X-Google-Smtp-Source: AGHT+IF7Uo2EUA0BEPgvS9unnOkwdXN3dlTqyentpnhn1CQ4N/ZtElw46+YVWfHza+V64HH0MTrLljKYb1t9iczJgTU0cf8+YiKV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:423:fd07:d3f0 with SMTP id
 e9e14a558f8ab-423fd07d535mr79206975ab.26.1758037684537; Tue, 16 Sep 2025
 08:48:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:48:04 -0700
In-Reply-To: <bc6d2cd1-39a3-4b95-b8b1-92fecf28679d@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c986b4.050a0220.2ff435.03e7.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         cceb4136 RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=1242f762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

