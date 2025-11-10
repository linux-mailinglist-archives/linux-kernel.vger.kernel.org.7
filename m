Return-Path: <linux-kernel+bounces-894014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A28C49132
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D233341CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891F33DEC5;
	Mon, 10 Nov 2025 19:33:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFA337BBD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803186; cv=none; b=myTrXpMVKlgksPjiyD6aVnelkLOW2+zB1DA++og+qDM9W05yDRyn3UYXz3aN9Ot2S434RAPfGAoD8pkG3GxQf/iR8UGaXqp/Pb4bEQSvG5ijNCQ6LVZwbYGHZ9vQWY54PykVvRyfqZV/X8YkupwgjgfKqg2aEvKzX/Vsbz6Hwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803186; c=relaxed/simple;
	bh=nsKQ3/Oj/W55IRx4xmp575KnL7xSo6svyz4a4hn+J4Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G+rZ9yrVX1BD7FM0k2kFike+yNC++DWUn8Ns9HOEIpw6943DheLKZJQAn0nTOuWgU323UahGhECCh0kEjSUI8i9DhYSYOYSMknXvq94mQk/lbraJIwQPXFO4zXCEKEeSDFnX+rej+GNO9EzDBFfoxtaXmXLN6aKtrmyCDCXq1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337cb921c2so18389035ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803184; x=1763407984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7n3CMEgG9StGVZER/iSL6Or+kxCjdidNFO9NCsS1Ns=;
        b=YMHlhWnbQ653wrib6r4DzeW4KlUVeHF5XaZkvI0hwDsDIVuGPDcVMYZ1Nf61dVDmWE
         2rB9+7GEDNHD3JfwQ1CJyppXcUWQjr1QwDT9mj4moNMn3hQUTIglrPG7Sh2YX7mTpMFr
         iu191+isJkd3BcUakkLqE9YZ+fCy2q5pbz5LTW8ZvmAw2TTn9zVFqOYCHV6xbCV7LYEQ
         8EYjliyE8G3eP0pRO4uy9mbX3IoBbGVHwSIYCVD/W3bcQyi8NsW22UgcTYnL1YfWCJI/
         4HdgMwN8yPGY/Xq7WKOl5pNDoecdDxjq2/Rc4+YVPmbVCda90gkUDE4jtv2JB6BUbtxY
         8cSw==
X-Gm-Message-State: AOJu0Yyz4gjwbrNgxtkcSJCqeqjf+SdGXFSCQaSV323+IVsAyBXoMnyd
	2g2kwupWo3mHX0JuGfYBrEsLmT9OlJTtz+4QqFWorrgjKrwHFlSWY9XjzE64ILaUCsq1qOoIU3j
	4Gq565xKetacMP1JyJWoyp6NWFgfzm0bkqTLEdZ2kc3rrLZ6jsvn8AWKA20w=
X-Google-Smtp-Source: AGHT+IE7QGuDK9THENfk0VDMVr4CLOjXzB47SNppx7xMj3idO3ruGiMeT0LRD8TBH8BUZy9DjRe2ok1FVutwI44yXPo4PDZRBvVb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3813:b0:433:330a:a572 with SMTP id
 e9e14a558f8ab-43367de5254mr147698085ab.13.1762803184466; Mon, 10 Nov 2025
 11:33:04 -0800 (PST)
Date: Mon, 10 Nov 2025 11:33:04 -0800
In-Reply-To: <ckkn76mbmurstoxlhjfnrwjht2hydo3daius5kc42j6s3nsc2o@d4ftoisfyii5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69123df0.a70a0220.22f260.0106.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com

Tested on:

commit:         f8c67d85 bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ceb412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b66412580000

Note: testing is done by a robot and is best-effort only.

