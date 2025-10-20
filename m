Return-Path: <linux-kernel+bounces-860673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002FBF0AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C740189C6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D640024A051;
	Mon, 20 Oct 2025 10:50:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6393246BA5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957405; cv=none; b=h1flPSG1XMY0wmA3TyfcaByEUXgXQrNShAn5JL/44btiKn+9Yv/iLWSlO3rD9Y3hiN3eG+NF8ulXwgs/0bKxMAKBqs+3UFzE+GQdPQhEmfzjW03/r1IrhU/2msnz3TPWe+3l8JE/apfRLqmFVMK81YI+SatOCqDF7NPcG/d2Uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957405; c=relaxed/simple;
	bh=aFYPf6JtmPFSxpa4Glj2jpOYV+xOBexyRNlm+UJvHQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TlsmvdW7ZDYIj01ZKEy5Tg2osaNRr3LiIbvL6e3SuUBjwNTxuy1MONeM2xj07D+vUQs4ehqc7QsIqKRdN3nlyoQBM0WNH0y8ufnQ+Yereu7Swt/8uGTiy5SxaH1i654afAIUyUxfLkQVvB3HxrybIoKHxkC8PGTwxx9Z9p9OgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so412949139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760957403; x=1761562203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibdl21v3ki3WTz6FkTqapVejS3VIDnDKDKdSRw8nwFk=;
        b=Rr7PJJQWR1Qw4SJR7Uj2FdmUIayif8XVKaKh8P6kvWBc9VFWKML2OVk9PFjSWrloUj
         WCXx44RX6aF1b1HgEKld4DzGl5xVoIGlR+X2+ACSW1xKxvojdbCQsCscWkaUbDwoh2pl
         iOBQi5F/UsyEl8PwfBKJidjmL1WsbpdckXOtbrAOjjFUQnX0lHa8uJeMiwrDXc38qEQY
         okjU3iVXjzX2PvkDQAZ0teaQDO8cwucx7G6IR+JWKcDeaV6IWd5su+OYiEGVR/Pd4aDR
         gCbi69OoBVIbpAsjYoO5GL6SWewsK1v2lDvqOk6WK4BQbuN35FR7GxdNqEe9i/YaDQ0f
         9G2w==
X-Forwarded-Encrypted: i=1; AJvYcCXlPMOT/tEd/s/TXv51C2wsiZh4ebZ3G+UAGITUgT0Tj3/fvoDnpT5lcwDjSKpzdjbMPUvFO/IqbHUOey4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtZa+49H5YYb0AW14vAw4zOYuwf/1qNfQ5h3A7JslZ1XlXAe6
	knNEesaKWaa3enGM3GoRQZ7lgAK38ZZzK27nzD9V/HAK2zsUYu7kzr6rinZQh2+J9fbmk3YoWYK
	CFBnMYY2esF+Vwsa2+QcYi5DCcvRSvti9pbTwwduCh8+Y7G+3oNAieNIG3iE=
X-Google-Smtp-Source: AGHT+IHRgk+RxyuvjempYXjjgiRNkCftiUURSsMMKkudbisCao4rIDx+Jh2VSynh4fudXRwuH1rz+puO7mg5Y9qRIsb+fsK4iWvJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8b:b0:93e:7f36:a90f with SMTP id
 ca18e2360f4ac-93e7f36aa6amr1758321739f.3.1760957403041; Mon, 20 Oct 2025
 03:50:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:50:03 -0700
In-Reply-To: <cbd65371-547c-4644-9e68-9958e348e9ec@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f613db.050a0220.91a22.0444.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         211ddde0 Linux 6.18-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e6f52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c601ba0b0d071c6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177d8de2580000

Note: testing is done by a robot and is best-effort only.

