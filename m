Return-Path: <linux-kernel+bounces-750392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFAB15AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A73AF869
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4C267F48;
	Wed, 30 Jul 2025 08:37:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9391EEA3C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864628; cv=none; b=qsovV3tDyk0+g85pmAMxNvNo8mYUl6NsQG3yQJ4bjxjT5InkXOa1+v3q8JOyGgF17mjzqnPuiXzyqV/OE+djZsRMlHgEFZ2HlAsHH2shZoEOcN/mYZVzBYrFGk70vHmtZLSoDF3EUi4oX9Mxb1j7CngfMF6AqCvLkYJSUDFhf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864628; c=relaxed/simple;
	bh=NkUOiRCCJLlWb7eUsmBdTQ2b3kyACzJhRlK8S3lG4C0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uyB3vzpqBtaPYqmpH7UZ4EUe1t4ra1zoGYywxs7FRxuikPpELzQXUdg8MDgxToJE2bI0wnu0KHkRVXXTxohE62Xx2g/kbtIjEVsEGC+DZ+IF7OM0u2UBXg+4Qky16gvY5EtGW5OHkl3lL6LwGkp/zUPR7rG+gTDsmX2r0gSNrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c41047044so184696239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864625; x=1754469425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHawJtQ1MGRltb+5jXCTWQSQ/lIKowNfTpts49mnvYE=;
        b=DBrchl9saJjtw8cfivuOS6wPZnuEQjmCYdrueYmsE8TWk5E8pHRmh1v5+SL3geQl2/
         f8lE3t7aTzkJSVW1YYYoUnPZungTnaJTv3rgsMW9cWR5OigvH5UH5dgr2+BsnjBFU+Cg
         31skluVhSRxkZCgSUJHIOSzSgX40fFh/O3ADFQKKXv2VtIU3IEzPGiKN06ufE9DRisUs
         gAyCchzI6xeWo2XYS1izE3nNLZaXysXHKdiwnQGbbC73eZuNiUqOJCoyRfuAe7GAdCqH
         R85rJmzU8ZrOcOMrI1Sz8CK0GZ+0x7pQmR15KT/TMzLRURHnPrBwGViQNCoCdDMvhJTt
         g6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb0x3KHLXEUfxzCcvZ+znY/JpWfueoUh+LlOL5QBhionLH3qk1rbqXs+AyNv86hcFID8tnr+j0STfO658=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHj+X5Vs6giXu/5+Tdqc/DZnuXj3AdRWDRcyrKwuD24q1CUOV
	5/LacPdfM9goZ6hksTuwb5Dr1T/IKMyf7KbQ0H8qFoyXJyNYSKljDdCu74Yfqo2Jdz8Hue6b+N8
	oeuLABYa2qUNhfDhmIcIW5d8vvjgevRHZAQi6gaUDgRl+F2CT8oGZ/05S3e0=
X-Google-Smtp-Source: AGHT+IHn7jUIMw81pbjrArBZNOmKvZBfVtYJhOLqBNdCKPEBye74nPONjr+15DWwZ1JzBUIdk74qVZbF88BPYUSRJd3glY27vmrR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7409:b0:873:47c7:6ff3 with SMTP id
 ca18e2360f4ac-8813771b53dmr493966739f.7.1753864625258; Wed, 30 Jul 2025
 01:37:05 -0700 (PDT)
Date: Wed, 30 Jul 2025 01:37:05 -0700
In-Reply-To: <20250730055126.114185-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889d9b1.050a0220.5d226.0005.GAE@google.com>
Subject: Re: [syzbot] [fuse?] [block?] KASAN: slab-use-after-free Read in disk_add_events
From: syzbot <syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Tested-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com

Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10908834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=295b41325f4e1bab
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3a12519f0d3fd4ec16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ac34a2580000

Note: testing is done by a robot and is best-effort only.

