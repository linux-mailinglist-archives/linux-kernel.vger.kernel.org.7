Return-Path: <linux-kernel+bounces-804616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B93EB47A7D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6932023D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AF221DB1;
	Sun,  7 Sep 2025 10:30:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FB221F29
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757241006; cv=none; b=r9jdpP9UsK+DfExNzl6WF/VI7pOSNezOhoygSVJYlw75lJ4e+uYG3N9njRrdmdpf5DXcrWx+YRixETWsflLRf05Telnq3bBlZRvkyCw6T0CovTQXvkWEpTO0yTVfA1h59QpPqInPoIkhgFS7NruVfe38/iGfgtvKI4tVCWTOymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757241006; c=relaxed/simple;
	bh=3qmo2Exl7SBE0vS/bTnkIkJB4dc903adRpcPibx5WNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uHNABa+PaLEaUkUh25yTcKil0wYYThJHxkfaRovof5sbBmdej5Zpq17W50swSptUaooS+SlOHOnUBS8tcjKR1W1kOoQuhK+mcbFas//8SLicn/SGzlHhdwFFwjYmAbAUG/hqYYDYe/mwKZmWX2hYdV3KpmbydcbM5cPDAu8oho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ffbd7e6662so9132635ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757241003; x=1757845803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juiyFxNwoHnOk7R9sf1XaAG7wLx/X2khmptvKFlffvM=;
        b=CQIa4BUpvjuJhYei91u7+PBe4gpRrV2kGSKNr3/JkdJ/V0xbEjQNh3xMZSu+aY9h6M
         pzP9oLFyiNr+QM7+8/MrReiwUMYIAyhj5VLzoBGeiHBk6wmJqudWI4SUHbZBHjLAuUHQ
         d6qXDz23LWz1A/O5OPaSlb12GrxBA0xktgplGA8gtoVunv1hwHOML6aiCgdU27YaLvfH
         excg+0akWd/JVTu1/0AbJ4x8Ea7jGI27L+fEI/elDIf5xt4Bj8zrCeqDu+7ZvYhwltr6
         xkXrMkQ2dOb47dygJzhpbEAI5rm+EjM2wBPl/M36lfuVJOle4HuXjppNHpSdUlP4un3k
         SBhw==
X-Forwarded-Encrypted: i=1; AJvYcCWsw8Qh7H7acfORjMoWlmCjtX3xfxcOqmfmvw0dHRhguAYIQ/iEKeLJHX0f/zfxzUYKRhYqCqdN0Bk1sQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUueJ0m/wCk8QKrsWIwO34fXefs7RNxex+RfBCpwPVhEJexvP
	9I/0pqghcxS0QM7bymy8LntV3ogx6vSU5M13/sYLPL/GVjWrZURc8bLSXQp2H62t0PSXj5AVH7f
	kKtfMipsAdaqVUsq0XV9i1W51JCiUw0B0pkUbFItA7ZFQZbqp2JqdPL7ztRs=
X-Google-Smtp-Source: AGHT+IEoQxVSwCh3gkd50t7Ol2Hvb8QkOHPr2kFW5aUB/3OfNGYTXUKZDZlp/0xbnzduouOkpUJ/+JP/Vo4uXHC3CX0Zq5ns+vNe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:403:e0f2:8f4d with SMTP id
 e9e14a558f8ab-403e0f291cbmr19501805ab.9.1757241002868; Sun, 07 Sep 2025
 03:30:02 -0700 (PDT)
Date: Sun, 07 Sep 2025 03:30:02 -0700
In-Reply-To: <20250907100548.281460-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bd5eaa.a00a0220.eb3d.002d.GAE@google.com>
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

commit:         b2369207 Merge tag 'rust-fixes-6.17-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123b3962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162ab312580000

Note: testing is done by a robot and is best-effort only.

