Return-Path: <linux-kernel+bounces-891177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC1C4213E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AF0C348982
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BB315D25;
	Fri,  7 Nov 2025 23:59:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335D20299B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762559946; cv=none; b=WoF5w/t6oJdzlkcojKzPBdT+HHUqGd/YNfHgv4qlIla7tYUV9bxulBV5/KjrW0Ih92nbTaZED3/qg7KnyLcr1why6iPsfLeMf8NrzyRGlIwjIhbn0wbqmyiHh9jkbqiAKrdLM42gNMpPKgiN0aBC7P0D8ahwaTF/brrEj+682XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762559946; c=relaxed/simple;
	bh=v2uHFQCF2uYvIO2HtOyzK/DNJ5JC9qi4QyWYW1x2WGo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p/Em7VBSh2uoBJFOG7s2ieVYlCRO5pwBPGSJN/cZNnPcPYpM0vFuVKZCAvbKazhhN2VETv4DyVy5GsmFTgBDR/h7139bVFzrsaXB9aOglCsaFrbTg3WBVCSwj8EM/zISHh9IMYwOezjjPgChCi3pqP3tt3tqUTzI1aPW2FNSOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4335b48ad16so15907745ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762559944; x=1763164744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9K5l1efnxzzsrGiz1B4wNKc4CCxuCA1kRn/bEPOoWw=;
        b=p8IvyG9o2iBIHqkgZvI8h6Qr0caqpJ8uKISy0YSQMoIhbhX0EGmWtPThM+0JAEcY1H
         0gO3Xs2LUjIBQ39XdjnKQjNnZqiDa9f9TKR6YKlAJZChopIjDhnLTDDuM7iAigSB+y4Q
         So6ZdE3Ysa+dPgBFm0XbP8M7PMSwDGHrEf9NVfMcvKukyMUK48Vs6+3+hBfkzYhZv6Xk
         bSm9mvvvxP/b6uSQfnY+jEofv1EcSs8ANQRxqOa+gTO8/g0wrkXCupWyaLqLBVRCOnD+
         4pCnXueMk9vN+276YOXG3f64qCmpeM7fblybyuFbtZM35wAoK/+flaBvnTOX+HxDCV00
         GcGw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7nANsj9OxQxIlenjazJbZBMIJObBftgr9xGsyhkE2LX31Ki62t0KGwb00W+zOsPU5L8BNgFIFYd7cOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhC5wsSHbJbmJIP6MNqtjeynDxYUtUCQpJN6FePGneHz2IKXX
	HkhKPr0Sto791GOEFysHYhwGHZ7rzsorNDiOnwEP3va0YnuytzpVDZcDv//d43xQsRno5uW7pb9
	gC6FoYNQde3ofe1VhQ+uysLWTLfhijrKjfv+qDJYLT8AhXEW2NYah9ISTUkg=
X-Google-Smtp-Source: AGHT+IG1pkII5HqICQTWsJQKXqz266wIYVAPJjFi44RyPfjjhhKQpktghnerfrihpqIPgOKsg6sG9l2Gpw9Xn+2KF7j696qyvNue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3499:b0:433:5c7d:d213 with SMTP id
 e9e14a558f8ab-43367dca267mr19809345ab.5.1762559944561; Fri, 07 Nov 2025
 15:59:04 -0800 (PST)
Date: Fri, 07 Nov 2025 15:59:04 -0800
In-Reply-To: <20251107-rackern-unbegreiflich-e49525c53d66@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e87c8.a70a0220.22f260.006b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Tested-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com

Tested on:

commit:         00f5a3b5 DO NOT MERGE - This is purely for testing a b..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11e8b32f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b1a45727d1f117
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

