Return-Path: <linux-kernel+bounces-879286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49455C22BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE11A61632
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF132C93D;
	Thu, 30 Oct 2025 23:56:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A32EB878
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868570; cv=none; b=ERZk78qMBd26+30H9brp2ktUoyapozb/bYsLFdsxWLslc+KwnelV4LbwK49wBzhNlQpo3uwESOfBXfPNyUOgn/bHaakifRb1rK1cIk9fzoIHvXU19sAHOs2WB255R/mykFtbKCWmZahWJXIAnYJY/ywU0t/DMbcmaxnYl8+ejbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868570; c=relaxed/simple;
	bh=o/OZIeDeXH8K1U+tFWTSwF6pEz06nnG1mnkwjBolS64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JdatPk5qm/5tNsp87XQgcWpv7so/+GKf2w72zkpDpHjgQHlHnI9XxKR3Q9ybKH4enQpttml6FO/rvg4n8vxQ3DwU1rBTb0Y7CtIhaERue6vyYq4iTHs4hT5Hs/cPV+UtyVmKJUYqlVzIuRtjhsbBGG33E/9bVTCE3ddn+KdcsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330ead8432so2904395ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761868567; x=1762473367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWFFh2AXjRlq7SHpupGD3VhFF3GWWQYUnN0po0lMdKg=;
        b=I8GbmiZLO6f41UGOaqYweM2J+H2UxG1mjW8mScEKGiRpumsEUCdCq+soxPZlakRPf+
         C/ep+u17bixqKrQRrQbIUjfAJegIQkyvhOLlQ+E6V/5doCELyemYjx/d5D8+U+y5ZCV0
         /R0ALe9GR9O6KdEf+N0oVU/Ju+PSwQcX5xK8ERXYA8dwWCXlIRHY9M+MPWQyQ5cDj/nR
         DRD3amfB1SZ91QmqGSfCDqem2kxGAtE2h+Pia3UVtsGWdX45vJz/RSgowO5/m3TWVw05
         Vv3lcVXj6g8YtEHp8dr76zyrBcULHCEFe/0uPUAvFq4gX3oc4RCW6SiKAOzAs5P3Bxpq
         3KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1d3NBCXPluAjcGGZHiJPrOb8A9AIPdD9/mrr1jGFuVNdXLCHpIAHnXLcyVXlad3eA471bPxyUDVLrDyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrXpwKoDiy90F6YyDvs14gifGx2hEmlXcuVOGz/9D1ImalE0c
	ANzxzfV5768kd8ZoP88hVZ476wD9N2fta4nMx66XVgEZxKrALu9vOpYs0g899H/Qz8YJHQJ9qGL
	PUdI/T9F3TAVf+Jj4rGVxIy+dxFVxdnc07dReJRQz5vkSZUFvfIsEeOIRhhA=
X-Google-Smtp-Source: AGHT+IHqiMcWp7EqPrUBWuBLmjvttYI4FjxzoJg7ua+iAbHyuBvbfyJP0CEj9c2u6CJn7uZASV5/amkI/1bY3RWJbeK8Y2qM9vT3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-4330d138fccmr27431235ab.12.1761868567707; Thu, 30 Oct 2025
 16:56:07 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:56:07 -0700
In-Reply-To: <132ed630-d885-4fb7-9f85-0d8ce8f25fbb@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903fb17.050a0220.32483.0231.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: global-out-of-bounds Read in io_uring_show_fdinfo
From: syzbot <syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com
Tested-by: syzbot+b883b008a0b1067d5833@syzkaller.appspotmail.com

Tested on:

commit:         0b447e53 Merge branch 'for-6.19/io_uring' into for-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d34e14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c3bc5e43bf487cd
dashboard link: https://syzkaller.appspot.com/bug?extid=b883b008a0b1067d5833
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

