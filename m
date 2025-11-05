Return-Path: <linux-kernel+bounces-886610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEEFC36124
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155E24670D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFC32D0C8;
	Wed,  5 Nov 2025 14:29:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958B32C95F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352945; cv=none; b=Ohp1/3RCjR1VSEauJ2zCrns37Twsoj9X3nXr0PQEvY1dj4KCmJY7jC7R2MQPnUvZMMprFdRG9KyAuxi0Gzb3nUyJbFQKhze/6FLL/ZUp/bZsa4lNgasLsInmOJHwmCwJbHgxMltOXZrED+a9jj9927n1lsXEmIZ4LppCBvdIC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352945; c=relaxed/simple;
	bh=d58MPcCmO5/nfbGHA8dpyWynJTnUOiUfoKpngFofkNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N5xqRmSMpAJyUYG8g7W2JXerouJCG+O238jmqcB3PYQBD+PMcbJJopnJCG1AqubDiFs36/2lXh0Lorx/pGx6t7EsXoNdR4kM2FZsjoG6vxXyQucxKiHJLUc7T+7EiH4Nwo0BNOk2s3alikx5QhUHA7NboIjGy4iJ6e6/pL45HjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433154d39abso182246675ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762352943; x=1762957743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX2RQNHe86RB5dnmPGjo5mNf73NYEp5cSo5zaYG0okM=;
        b=DyTtRuK9UvfNdd5IMLic1i6gdBFKr1S160o5UEMWVYsPh6EMzN9gS1UcITkFnVFwjl
         wt1m2VkAHQJufbk45/u2h9Wb7yomjHaAv4oyhnIxE0ucfvpy5vq/6wYsuGRf4Lqyc8Dq
         gpd52/KBYNv0/phpDkJB+2aB+cXmLAYVZIW4II0IQ59JUbFIb8NGLWfdYTwvK2T+lX+T
         cL4WtTIGfmokFa/Px6Vr+AzzVPYdyA/BYkE1QQesoIefhkCQj4RK6Wz7Sp4rh6qMQzud
         bQ8Li27sEjxvw4Y5fBRB7GoM+jCoIaaGrqtOy0ffRKljQm8jWuDaEFx4ducVuf8H+oyP
         NLEg==
X-Gm-Message-State: AOJu0YyVU/7YI4TXP6RGKgPg0M3uLTfZmSiVBuvbm6rKwhaqay+caOBo
	pc05dzdntURplwkWqgmMX5Ax/GTF8XJvd+XwelmS1ziZp3TKsuY5wKMATmlf9Ma9R89+5Gac3nt
	4jDa/+6P7f2tXxyku4ewMueKbljKIjRjHYtwA4GzyWB4VXuH1408iouOWUUU=
X-Google-Smtp-Source: AGHT+IF9Fz3+ZUIxRImgwljlIHSp5dob6QnTgGALAFEljsTs7c0cvhdCwRrTBI6mmIj1jjf3FyejwBOWiNBhRtgNFSrHkXJYO2Ok
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:433:2882:dafe with SMTP id
 e9e14a558f8ab-433407a3d7dmr48883475ab.9.1762352943232; Wed, 05 Nov 2025
 06:29:03 -0800 (PST)
Date: Wed, 05 Nov 2025 06:29:03 -0800
In-Reply-To: <CAHjv_as4YzF0mBcTt-RR6MauSzEnhFJrN8Z0hm-9yUeeVhaKzA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b5f2f.050a0220.baf87.002c.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=162a9bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eeb63aaf73b06da
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133da17c580000

Note: testing is done by a robot and is best-effort only.

