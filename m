Return-Path: <linux-kernel+bounces-823897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28DAB87AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25808165EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59038235360;
	Fri, 19 Sep 2025 02:04:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634241E9906
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247446; cv=none; b=FWX26TXhZ1LaQxmSRnS7sDEAxMWZIarGZvml/oFNvuUe+qPwWrg7c2wJJwchaeAK4f0JbOxpJaLlQIxyha0d8guB3075OwvZAcHvBRpxlhtSl+KCHcloI4CvU3yD4xASaXVDHCTy3RO61FKSmh62Eq7pHrdvLvSOVANS8EfjfjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247446; c=relaxed/simple;
	bh=WK1OFFpYQessk5d91vtxNNS9Qg2VutAMa5MTpR6D5Hw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QXPWIhQAbm1K/ROhq3N167OzdKhHbAnQROFkvIMVWwzwH/wcnKu84WuMfXoT2zal2zl7Gx5RCgn9EW0w3aME75TWkt+Q00nC05H4iSuPw8Kte2XrrAxvb0//mHl4ayqkM+cQu3cFcCG87DsFIdB+yueEY03bYQfGa4d6D0t4Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424122ae369so35233445ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247443; x=1758852243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9cP6R5nRzC5RHRQeM4eIiYRxxr14X1zpBs0jA3llns=;
        b=YrDrNaMkEuhxS4k1fhNBJCZh2BeMXf95g8MITYPkgwGFwyceA9GzBtC48FsknhjL9Y
         1N5a2I6Lo6B09mNYY21CehlMXzM9tfYGG3HBb4ftVIjfHL0ya7wdS8AQHebgwdg0ZUQA
         zNAa6UAKZzfQo3ebCNCFgnwKnsjY2PxUOf29OchUHFrTf6Du/LoChsZcB/0qqeuF4qbn
         0WsyNfc421NwuUAA+6ORtePkCnz5OIN2fCYCPPvKamFRfsXSy4+M17d8ddo+r4j9/Rd0
         mzczOqIGm/wOChNtFwNr+h9yYBFlhAOdba5OzmyTmyvJweT+p/QvIY6fx44eAe5VrVJ3
         izSg==
X-Gm-Message-State: AOJu0YyMY++t+NgQ2PAC2UVw7aKqWhMh15yyy65jutRLQ2X+IHJnBfB7
	IMjLYxBfuQHaex5RwHecRJ8FsyRD2gHFR+Y9dt39Qr9hFaxGjQhSKQRvck+/2N4PxW/SmPGmjxI
	+PFe+y1LDO89PGcxYnGDTGXroE6MKehhQQx62vgBwX63sdwCmiMd8W7MX9e0=
X-Google-Smtp-Source: AGHT+IER48sGBbrpaMZ4LoGwS8sLu+TyyfXLl/mgfRpxlqleTyawlqVNAjI5ggvab2Kp/ww6MgNPb+TvZdIFetN7VqeunSHi/ZKH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:424:61f:acda with SMTP id
 e9e14a558f8ab-42481970f5dmr31760595ab.18.1758247443450; Thu, 18 Sep 2025
 19:04:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:04:03 -0700
In-Reply-To: <20250919012918.213435-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccba13.050a0220.139b6.000c.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
From: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
Tested-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com

Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bf1c7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10bae0e2580000

Note: testing is done by a robot and is best-effort only.

