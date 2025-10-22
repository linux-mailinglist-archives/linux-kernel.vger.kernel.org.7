Return-Path: <linux-kernel+bounces-865914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9FBFE51E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321F34E7F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95027B355;
	Wed, 22 Oct 2025 21:31:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6627EC7C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168667; cv=none; b=sSKupdAfv6kdl1TzPDwF3Nrhp+CYKZliSde/jqX8s0MZnMt7R6LaSyWl+dobQqm+Q+PjgTaY8lxzbnsEgvYY4WvzO/vIxu8x+VgDh+pQcUcVjMezuStUNi5NA2RzliyaHJDukjcsdLcfkUztg7dxFTO1+ic/lRANS/2eFbZFBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168667; c=relaxed/simple;
	bh=qh+eS6JHKi9iXUDyJPSvioVa2zztpifK5Qth0Vh1j0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l3Rav3h7E1gIsau/UKCcnOj08Z05YpqcLZQFJVsVVBe95a87lqaGwUtVho4VlWimDeFphCj2ItPIJnBkqsDteikL/glxXtpttO3LCyD45GU6GosVTcVTW6qm8Anzk1C2N3RTNEOxL0efyhuNI/XjVioaDdyXpUuLvxW3CQO+WkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so4766615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761168665; x=1761773465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCwGs/KsJr8Cj3UWTpj3LDzpF+YxforV5TEbIODcEPw=;
        b=r9+icW8EK0grNqPx57TUVQoVW3h926cWoUQQK2H1+icI2nijPXwc3qLF6sw7Bq4z/O
         ioRdH/fBZ3PoeWcCi/zmyvGv2AJg5K+VE8fggCiGZu75zGTZvGDKipozlUdHUsBtc6Fm
         LnmIEC0RDQJfJfYhk0eO/jUqWGFoQumosgUxYd4pvkLxqDAE5vWAfLVZANxzpPHjB9ne
         W4MQDZupVb3YZBPRZWE/HPi83ZeyFnEQvf6Pnb4Bl/edmU500blqZwwrzXeHY49Pkqk7
         j7GoWicpDyvXcilqWaVBobmFlPO9j3KycibxjUUrdSTeYJio6Cyv8nxcq5p2CHyOwC3A
         6OxA==
X-Forwarded-Encrypted: i=1; AJvYcCWKqpi2Y7UqAHlFrDo4I5aBD5bdx1YK5vYbN/oD6kuuuMCNX5I/4sVDgfO7miyI3FRZ4syMGF3Un9a6fN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ZaLYm6uD71o3Usuh3WQm8wP8KCmmHQ+DomCDUtVn6VyzMSbI
	KOIf14PRsP0Ry1+ZuYqyFVz5WxingZPhbPWpVLJeREhvLQVyu5VDgXxgAxVIlQsKlXgrAusr0KZ
	cktp6NbfJZ/5TGzzX7W4LNQY/1ZehrVU+4IqUe+YMhnlenIx7aA/rwdAmVVA=
X-Google-Smtp-Source: AGHT+IFxbZr+ckHUFiv8a47cp6o6HuP9r54+qvojzlBc0inzglwq5sDE5zmGTbPbeDvEJOYJfhmn+kHjDfomnOxd/olh1TKAX/IG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:430:acb1:e785 with SMTP id
 e9e14a558f8ab-430c5208dacmr319857325ab.6.1761168663904; Wed, 22 Oct 2025
 14:31:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:31:03 -0700
In-Reply-To: <5499f25e-99fc-4720-8d5b-a6606aad6d6a@mev.co.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f94d17.a70a0220.3bf6c6.0027.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in driver_unregister (2)
From: syzbot <syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com
Tested-by: syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com

Tested on:

commit:         dd72c8fc Merge tag 'platform-drivers-x86-v6.18-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ee4614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=6616bba359cec7a1def1
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e92d42580000

Note: testing is done by a robot and is best-effort only.

