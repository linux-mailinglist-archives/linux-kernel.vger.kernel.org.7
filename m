Return-Path: <linux-kernel+bounces-865249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821FBFC9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011D7189E2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD3348440;
	Wed, 22 Oct 2025 14:36:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D47345749
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143765; cv=none; b=Z3utKDeyCm1E2soGdmxsq2aCYEsWWCq3Zznim3cypYSbIW/yn1E3fCddGulGNsVIv/MIGSy0oVq9aEQ8M09u7LaQo3eMALa4hJoZmhTYxPsJCzQMSBbwPsKKaKz1v1LuOvfuEASvIErU5DdrmYvZCOfi2DxIr8F6IevIXUTrI5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143765; c=relaxed/simple;
	bh=Wu5rZHMzYLt2RiYSEnQ1RuSsngV3ZNLqvw84JEA3ca4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k5+8aQWG5+EKeMdLbrRhM6lGjXbMpB0K4HznXo1vMC1Gysb7qIoF6kdQiZaXhl5wlxyLeQVWEh48qSNMe2XReB63uX70adL/ISg0eTKL5LWVEnch1W3qqypEfMLm/aBbwuih3giduA4R0AtP0CpP28VwhzeEPV9Kl9Ln2NmUm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db5635d6so51128185ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143762; x=1761748562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4UYY90v7X60QSZjwoFVDKF1Ze5jVrj2B7b+JPnxtdc=;
        b=KtbQXpU+nxkjf7fD/hVcWx06Q8LRpePOiXgXtVt8+Urs9xwy9+fFnTvQi2pC0FsT+A
         6C2rK0vtI/HERk3nSph6JLqtCpVDnhtGzUttXkKqLCuyxsFM860d04WEGQIVZ5P1AC0M
         2BKWStebM2hqLTwduhb/R+qP86Kmq9tXLirT0BmTUAqpnIDqZWgRHFeUU05N1rafr3sl
         GJCg3HFE0DqQJNZFEJM0XQLBZP0KbT4y4HflliCgTXisB+78gHg6rmscvC075e8/U+cg
         SYh/hKbeA2Rv9wosUYLBVjaAp8HizaunZGvEEslKaoJItd7Qz+qs6mt3n7WOaQU23Zoq
         6wfw==
X-Forwarded-Encrypted: i=1; AJvYcCX5O6P6xnmW2hqAxHiP6HGPSdQzbcZXSI3u1hq7syVU3lNdiqdxWMfo9xJ5EGWal9LlANNBHOcoXgTuII4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7YMamPHWka54BHY7tF8FQPdkB5K5SGR4R13X9Jw1Ahe+0gSI
	+d+36q8GfgD+62sMUmb9OsWySTz1odaJlqluUTZyO0pm69wkfHFh2ClFsBwAtHaiS8CBP5fyONE
	dHeo9DpH6be/tXXtYENUcOnZ3YuB55no0YOQqB9Cj0iBIPJg2Lk2Ieoq6jtM=
X-Google-Smtp-Source: AGHT+IEUH02EUHIhFiH1OpwMHevKs9QpZU7Zt8EoCv9CGBUXlIn9Nt3x36Zb9ilXgdTfy7LLCIl4NG7jSNHUOFNR1OE0dXLWEhAh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:430:a7d5:235f with SMTP id
 e9e14a558f8ab-430c52b5a72mr302828105ab.15.1761143762755; Wed, 22 Oct 2025
 07:36:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:36:02 -0700
In-Reply-To: <20251022140016.A5JqV%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8ebd2.050a0220.346f24.0053.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1046ce7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ba43e2580000

Note: testing is done by a robot and is best-effort only.

