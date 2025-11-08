Return-Path: <linux-kernel+bounces-891489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3797C42C37
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778794E6C3C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB7301005;
	Sat,  8 Nov 2025 11:46:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB212FF17D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602373; cv=none; b=G8VtD4mkr1bJlB7OgjbV6/6cnnZHVWmcQnNul3ZkNyPVUjKmFJglQJeEImJRhgsihRuufRIQuZaLEzd4EeMRhbP4qBGY1xqvb19iG0RFZcriM8aTVCKMc7HTHTK3/Ys3SXxwpePFW4mk4ZRHyS1eREsBABSXsgyCh+l/OFVgEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602373; c=relaxed/simple;
	bh=89T+4qHUQTIhG/SFKMt6Ii4GDc1WK8TCsdeL307uyVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rsmkcVMw51+gjgDmvci2jAu8uOjFYazP0/t4o1ejXU0WkQ/iYJ7uigtciRTEqDNKPTUyyFrh/YgpqIbY3O1uodHqg1iTMVi8X2UQdXwaldVnj/OFgUu/IHxVtE44eU2Up89u90qHxPapRD+2QpmDTa/TO2r/kWWPi8Tr6N6+xFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so144013639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 03:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762602364; x=1763207164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT3nWmWtpfLwoiQ/LXrBCnymc6GSizFbMsCyBhkjSMo=;
        b=FL+2iV7pkRiGIRBndWQ6+W692HgzF9ih8cbEi143YWC5yVNPRGH3vyWn2SV2UgYPjL
         bY8EfJPv00+CmYAz6fm2XooIAexSEwKjPMaAwEUm4Ed2yfesV8ghmE1JJg3cMwDvkohK
         NcP4Fgjey9ayve+uFI3dRY2AKYBSfozfitwUaIIHY/bTA6pqmpJQIRIJkrpYQ8rmZs49
         yPzCf7qP9th+kgAHP/Tg1jjYHN+1MAx68QIWaxo/hu5AkQ6rLGLLn/sNtU4q/EzolH15
         FgC81W7Y2VJRWkZ4mXlULM3hk5FsR9i1tydKKbOeDYfQFJGtbSLC14fLOs7d0Jf4EfmV
         eLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7ac5o53fNU43YzMU6sF8ZOK2Ki6ONshuKkDKQgAbgc5TA26LXqwxwbOJ/LAaxxLb2fMIyYxC95yaur00=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxic/PmahzvgBZvxZiGGRoS1DsG20t9q2qenk4TK6zInLSwreZ
	MjRbUF1hwzgtaZqEgvGRGMXIBtM2uVafrVc3QpEprrEwG/l+OvOb6lo8jZpoJuahSUHSX/ShjZE
	AjMvAC5M5HViuX3TpkQh5Dj7Rq07wzc1SLA3t8CfZjsqourgC9VxK7HogH9o=
X-Google-Smtp-Source: AGHT+IF0lzmC3C5XiHZSRivjPA0W6wBCehFT2N8SafVZfF0emtOTtW0CiDs6zRdErfomW1D917I2L6HKV6ZJHX+cmO1ZDnUEfj2i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:433:74cb:e13 with SMTP id
 e9e14a558f8ab-43374cb13d4mr7183385ab.32.1762602364207; Sat, 08 Nov 2025
 03:46:04 -0800 (PST)
Date: Sat, 08 Nov 2025 03:46:04 -0800
In-Reply-To: <CAKYAXd-ycMzZ+o2wDMk4tdE8msafQ1syedsC-n19i=0Bba-x4Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f2d7c.a70a0220.22f260.007d.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134eb812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1258d084580000

Note: testing is done by a robot and is best-effort only.

