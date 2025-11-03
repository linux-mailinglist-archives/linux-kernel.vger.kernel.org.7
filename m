Return-Path: <linux-kernel+bounces-882346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F3C2A3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4534B3AE165
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB328DF07;
	Mon,  3 Nov 2025 06:53:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49688236453
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152785; cv=none; b=ou+TRYWH65oe6YPgvL0coH4JEHmYE3W+RKiilKbFsqf4UoLosiUSW112M2I7KK9oB9mh0ZruzuNNwIDBoFNTTYsBsx/uqGpEjSQTn1d/fb+jkt9dLS8MsD1x94vjQKHYLr2e1BlrpeUXU8Cc6two6pBDe57YMaTnSm+ulDOpuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152785; c=relaxed/simple;
	bh=rtwiLg39jRHrW/2IMi+S4pdRGNfonuk7Sgylcilz5pY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V46TmzhMldB5xnVGnddJ5uFqgbiLfh3zhl1a9iJID6uBapgZ1OwZZ12+tzq4fAMnTo2xWnaAA2SEPC4ZdrUakhIi+FXPC84qLkK5Ya92koHG5JSygH6ouKYae/Q4rHKCpiW9mGjWKlNs7YSKt47y3bujtILtetXEBcl6pl41IRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4330ead8432so26674785ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762152783; x=1762757583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKpPeoyHlt9rqty8Rc9OqAhBoPwC6oagWF1/FLdQWDc=;
        b=X+By4ApSCvcOk5YKvwZBWJFOWUzknThJflAxMohKhYnOVlWdt7RwRDSMohlJhPzuwW
         S4sgNCKbfBH44hp93jZ9MEj2TbtLL/A6az6WVoZ4qU6e3E8dqbnZaaeGLQM9vJKptV2s
         CWyabnBLao+osgcZApikvvyZLiaV2FAHHa7wUHc00uv3cJ2dOsFBaL7WmHxFPPURM5Dm
         xWZplEEufnmYKG3bWh1TCpf8Sbkg9Yb3ArqjhS4acGEOgtprWQ20m6EltBfPKYLUhUi5
         BeE6IGs7KN6SQf53/0xVTNYkxrsuipkVEmC+8fHqfrF1zLflmoCQ88aD+XmlbYtiuiS2
         iF+A==
X-Gm-Message-State: AOJu0YzL1Bv5YVvtBLz0ou9exPQ9lKaKAfqAsxVukoOQF4RcnJuGfLWl
	8NDvvakN/I14VeJ3TXC0uj8qLvOaULUPPpZFaEngWLMAypET35nhTwFRWGg3JvlbJImjhSf60e/
	4KJneoaewupFwKW9n5GTKd3e3F7mbLpGdRn5a9WzXGQizkO8oee97k7D0SDo=
X-Google-Smtp-Source: AGHT+IHzhQNePd8zABFwSC4Wcg336jJCapFw2t/QZLOJPT3MP8WBBu6o9ZACB3oYazCE5Q9QPtjbZPRCGskc7FfwHbbBrcjKL5/g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-4330d138fccmr171223685ab.12.1762152783533; Sun, 02 Nov 2025
 22:53:03 -0800 (PST)
Date: Sun, 02 Nov 2025 22:53:03 -0800
In-Reply-To: <20251103064432.3767881-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908514f.050a0220.29fc44.0035.GAE@google.com>
Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to run ["make" "KERNELVERSION=syzkaller" "KERNELRELEASE=syzkaller" "LOCALVERSION=-syzkaller" "-j" "64" "ARCH=x86_64" "LLVM=1" "bzImage"]: exit status 2


Tested on:

commit:         98231209 Add linux-next specific files for 20251103
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=55e89517f3847929
dashboard link: https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d41e14580000


