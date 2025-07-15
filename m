Return-Path: <linux-kernel+bounces-731042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E4B04DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9892A16977E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF502C327E;
	Tue, 15 Jul 2025 02:33:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EC250C18
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546786; cv=none; b=lNTXuHz8F9Y/wi3auIByPjWvKlaBvK4gTplC35O8C7SvunJYAvtGHdmH6Z7qyPNeJ3Smwai7woA8yR3nt6h9MNJkQdI8XfU+qGLG2s5gv0jXoh4bwRO50bXT63fRzTkVBCcUJkb4K/ZmtGvHRLP4rJuaeadV1IjudiFOUkE045Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546786; c=relaxed/simple;
	bh=7AndiXTD4sbV5agjvgEfYoTGkIYfFDWFjpNYdv3Xtho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R3fxNbppRlm4wn/Vsvx4tSyYTWzP1q51spKbUZcL/CugP7/a/rBgdPq5caFu289cF6zSQYJX7OjbxFnBi5snwBBQMnqzPn+EhJbfQmMhrQVM+7/Y7H/qBfQTPwG9vGNnWNohblJga/pQihttCV5X6/WnY8KF5M6JegSjF5pL3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e059add15eso56428955ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752546784; x=1753151584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yE4JhMmA44lV+WjxvtXYki/dvYzl3IpMsCSep6EbVg=;
        b=KRG4PiYvSl8bK7jaexF2xde0WRvFx9/2nmn5MS9Fa+Q3cBcA4f3oJdsBRiWeikn5hK
         WmLiAMXtTn4P/ZiewHEhw6Snuv0ro5zAZQ/HTxQIX8Y2n9L5aJutDHWV1uq8MdsNvcFo
         E1/8Hec64qVHFGkceifbtfhEHdNzWBCvlNILhS6ShjNb7myEg7ftriFvUQCJRevSF7jn
         Y7qAaZQfTRdx6sjbLUnMyk5DvFu30F5IZkbQObx5QgXFgFR/Bj/HRcyVLQmAXvV8WpRk
         TqbbVfWAJNHG5/N1Ily+cSiiFreh3JtVnvq6fKsNfJkDQaRqIzxmvxcRQVDTgV3q6jn+
         D2SA==
X-Forwarded-Encrypted: i=1; AJvYcCWxuBH27A9ZubeI/tKWRVJXQGQUiJXlTzw1t+DSA88z6NzkEUB1gtP6hnIbHTJA7WXqLskxI6n45REI628=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCoIERMdBRhcLhrr9LTAcZEjmQ2qUXCllrpSL5Wc2sLN2F+QC
	EP7kn4t/Ft7ohGnYIjKAcxcJn5puHOLBbh9MszS5T6eRQrpNnMx8cnPBggEARydVlJKI8yFyBj8
	Wcbpc3WDySkEXdDFQ+mZqN2aW6vDpfspHJL7a3/t/JdUV4XQVPBbJe+uNIyw=
X-Google-Smtp-Source: AGHT+IF2UUDClpYWB6viGBXYp28+nczoOwxL4W6ADfPyApY+NBZpSA62Hg8TL78bt20h7n3z9+OWCwAApBxgMoMd2psNr7we5eog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b48:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3e2532fc02bmr34673265ab.14.1752546784316; Mon, 14 Jul 2025
 19:33:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:33:04 -0700
In-Reply-To: <CAF3JpA4QvNvdx-tq-5ogMmmaOuZuYq8Q=JZjQj0egWGE-=Nogg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875bde0.a70a0220.5f69f.0008.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper
From: syzbot <syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com
Tested-by: syzbot+f73f203f8c9b19037380@syzkaller.appspotmail.com

Tested on:

commit:         0cad34fb Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=10ad518c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37db4c8907581400
dashboard link: https://syzkaller.appspot.com/bug?extid=f73f203f8c9b19037380
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1183718c580000

Note: testing is done by a robot and is best-effort only.

