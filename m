Return-Path: <linux-kernel+bounces-728971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7FB02FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C289818932F4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2A1E990E;
	Sun, 13 Jul 2025 08:29:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721321A08BC
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752395345; cv=none; b=bsLSZewjruQ/T1aAdefnuh33fKl8FDm1o/5F/x+qchYiKC5pQw99+d58+4anEQMRsIVPBuqZMZkHQEBuS29xLbJ8FsufYoDAUH/LTvUcxpOSUmKdrAPznZjo5R7SzLaGONgv7qVa/d5z+NSAUvAurI8vhgBctWbGKzQd8nyUz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752395345; c=relaxed/simple;
	bh=6NcX3XE35Dg3mnzmFmFGOC0s8zH6bcMy+SFJQghqlFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=APn7z85yyBjkKwKiR4zoBGuFuime9y3I07J97/hddiSVrrMg8fxD++++EaMHrzA9IqLmQH5qJgpxPNOg9smu4FrjzLiRNfB21JD9XptidRuUbNgKL6lxobeDX5osCLkZspI49wQdEiWus0Fqm84UZOq21a30IAu53y3RE2yJ7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e1618f03c9so34264665ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752395343; x=1753000143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebB32pRaTG/p+vbOA73+f1NqGaxl7tr/9nOHMfK7NfM=;
        b=LfWTYcm4rVgzAo8fHYMknDf4gcjPCnsI0mAzJzlhfYQd/8iaRlHAxHZ36zWdAAQ6Z/
         aqHw35aRlteM0WR2/54KXIZ39N4ch5BBMtRLM71eBnEzI0AT4frjx/33r6uXH7JFHTTk
         hSVHXuFgOO26+b6zYxFEQ902TJAMK4d1yN8DN0M+qMpEM9ruV+O8pWaqSOFClVesVWAc
         4Vxb7mNUJd9kMQZojNdR/RIykMQhKGZbTTFWBzogtqd+iM2rODSDFruHIMX/VleoHI/q
         MgjGNcJBS29gZ0IESmiPCOyo2gGP1TB5IW0NMVD9LmIsnjB4tZo3fJsAgdQNGB7HDvHC
         d4MQ==
X-Gm-Message-State: AOJu0Yw5x+a0uxN3kzE18s1RxxH7rzNlBoItguvd+M1dG1GZx7Br5Moz
	moSWwEcZuP+j6RE60WDwIlSwyp6jP5rVMiVvvN38cl6eCQWeIsFZd1pajEMUxH9PrjSj+8c/0h+
	igFoBiEGh0vE6Y5JdVES/StuVlCCrMrXTfuJPQbeNihsqnzxQS4FnM98ac68=
X-Google-Smtp-Source: AGHT+IHZ88E01ej7Vse2jDvhJDpbWkG4Ph6mcWXqHOLhWduGhpr36X7Qjvq9PT3V6MV1z2egBRg525YrnC5qkWVoieVNuuEoYthe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3102:b0:3df:5283:ac73 with SMTP id
 e9e14a558f8ab-3e2533106d4mr116169885ab.12.1752395343536; Sun, 13 Jul 2025
 01:29:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 01:29:03 -0700
In-Reply-To: <e3dd81d7-16fe-4d04-99fa-ac81fb4b4289@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68736e4f.a70a0220.3b380f.0027.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mchehab@kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, sean@mess.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com
Tested-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

Tested on:

commit:         3f31a806 Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a150f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fa07d4580000

Note: testing is done by a robot and is best-effort only.

