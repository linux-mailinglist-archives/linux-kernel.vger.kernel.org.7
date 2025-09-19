Return-Path: <linux-kernel+bounces-823882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F5B87A46
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273084E5EED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086B245006;
	Fri, 19 Sep 2025 01:53:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11730215789
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246785; cv=none; b=a4EI2eeQdpdo+5oqOsC8GU7j/7GxFhT7h6mw5NTjaogvrMY7Bph4lqNdrz/CAfSyzZBP60dFnkKZbr/fNt9uSmhIXfK8Tnsn4AiUZiDmZI5TIT9N6er0XCw8trs/9d1mByNk2tImvTpycAn0+tw0x74FFitmwIbc1yOZ/29wVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246785; c=relaxed/simple;
	bh=HsqXOGytWmTqTX55WwcivWlmPMXBaA6r9gInXS/y5GI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iaIYCb1QY86Ij+f3QjNjXox5DBYEIORZ3V58ev4qSQml0cg78DwI+j+BvWD/E15frNlOp/9aunUYMy9mPYjh7EQqrfuNX+Ai6/XMPG/1uGaIb8OP8X3J8hJJviW4U+nYWmnw5usmlSjY+79/ijw6Bz3vvSDe+kIr890xIdOJIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88c3a3f745bso365732539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758246783; x=1758851583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5+E4pD4Npho+TjkB3BTKVRK66Yv7VfqKIzT7t52A3k=;
        b=AvmYr/V/8Yaf63byG49/QbdpL0cWpIyvEZXu2FBIK7PWEYqcVzGsjb8Nv/NQWRa4xy
         CgivJuc+xc+zd4ICI4I7AfnO0e3/f37gYphxCLZJVAysAZmjWf2GWxF9Cbxjjd7LKZMl
         fch4ZEQmHe5FgJ6z3pvUm4BwoJyUYgvuBX55iYfS7HPkPU0vPtcBU5DkqoZbhWgi+Hha
         OIVd1gLNXbJvoQ8rjfIHe9r/O0LYVJiW93oS3IZSheWlzvtMzDePO/eWRf046kXFZyXg
         Zf1DRKL5JgGj4bLNJ9chF0NEJs1FR6Yk0uuhDhBAxlMlNLIaMEi3usRSAPUH5R5SsMV6
         GaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVrJEps2bqBnEwFxfmy8Tf1kBdQj8XQjKQvlP+JNR8sZqnJzwywb3b/oil5ws3sB36CSmBAQ/WDA02AqM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1ufacuiAQejkqUyck3SYhEBKXn9pHbk0uDmYORqXbl0GUSiC
	JpEd6o8IHBpZ4ouXbb1W+CsJDDBxnwZ5bo7x5DciPemSLsIr7X5zErYUG6rI8dC2L1HslB6okU+
	u+Z2OiEO6MQe97WuJowhoECFjUT3QOrYMtA4nVDF8IRUkHqlywghfDlbVV08=
X-Google-Smtp-Source: AGHT+IGn7kSpNfcJVx/hg3eqJx5ch9U9bBXxhqgGez1fBZOhIzcKluhNm7SDOLYq7WKKXSUMdJ0v9Kf9lDdv1LrFsoUEqYSbp1ch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:424:8166:9b7b with SMTP id
 e9e14a558f8ab-42481927117mr29492505ab.9.1758246783367; Thu, 18 Sep 2025
 18:53:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:53:03 -0700
In-Reply-To: <20250919013214.472874-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb77f.a00a0220.37dadf.0011.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com

Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4c712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142f1c7c580000

Note: testing is done by a robot and is best-effort only.

