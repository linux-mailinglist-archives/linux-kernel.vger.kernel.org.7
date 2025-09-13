Return-Path: <linux-kernel+bounces-815026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F875B55E54
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D97AE114F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D031F4703;
	Sat, 13 Sep 2025 04:28:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DDF1F419B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757737687; cv=none; b=oMlinOiznl580QFAcvjqnF6cKGVl3g5mvvWSrNoCIMSxz3gO98Rf+FVbFKqUJhkk7g4Siu52Ek1LGlEnl4m7kg9tbnAmCkrC08MtfPr2uCHJpp0JJ9RzOEwPzJOI1aSNfYAy3azfT7Xa0qPllHPYuhv1gTyPK5FzsDVlasHZitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757737687; c=relaxed/simple;
	bh=TTbuNKOEtkdoYVBghkZRh1OD2oZh/2kq2Kclu1KZpLg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OT5RbOoxfP/nCnRLfzNP6k5+2c2RYLNdAcK+Eik/Lf6f2fLi6ccZ/HHtcGMMU3KO51QejtBqyn+CkEBDDf15VHh0gklnx88rCX9zSon5aZ5Z/LbG5tlND8fjWjqsS6Q66zrV5Abh6JY5uumkesYYSyYHkikJgipSKssglBoAecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-423f9cbfa41so709035ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757737685; x=1758342485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcxUiHPHc5hZpl7N5eN5x5B58VAzXR2Ll1ROmsjw50A=;
        b=SFFlJ1VUGipl/c6blgYmGJC5bCsHq7l2opQfe66BMP57vOEkllhLGwdxrnsq8SjyLi
         VHs0652/X4LrcoMdTYtv6exA4QP4VyhwCD25XT+Wgc69Gx447qRvC2SkbgyokBXVl/PX
         wftOlbb36bt6GFayanshFMZ3wySsn2ACxW45sU2JP/drKFLlpq3HFw3kYIytBu8NepKo
         z5yV1StCPNN/+IuiHR0T5ihUCVqZzWy0K72VkaMvpGnir84PDU1W5RGj+LuAg4831/HU
         /b+Rth40Krcf9Hj2gXNDjdPeZy7tFh0YFyaktwrHgRrkuw0j/zHceUx67xjd1vAxsHaW
         rPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5QhTyTwIgzP3vWa1wwXgo+Y8euDoT1hmPu2dxb3YHycxgDcTjcjZRmfuEBb7iz4XDjZ6GmNc0na+nAS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vLU9ppVGlgCIDIaefPmu+I+9PW1fJRpfjZ2BTvDji8GwpLOf
	MJJ/WHfwWa8k+bMKWEKSsu8uGkK9NDtCMH7ADYAm8snFmWvo3DetXvY27ueJHwbc5+NavgDa6vX
	VznrXCgBwswRSZGgT6h0/1x+sTmFMCslSAZHUL5fmxQ7JSOOIwNakOCiRKC0=
X-Google-Smtp-Source: AGHT+IE5oU46GATWTnXN4F5FjNn7sOaAT+yuV5YCiVGE5L37Q+THjr6Ajf/W5H7ACfiTKpUogyFf6oItUBl8H/6G08tt85d29zvj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:403:ffbb:89ab with SMTP id
 e9e14a558f8ab-4209e64b9d3mr72640345ab.11.1757737685236; Fri, 12 Sep 2025
 21:28:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 21:28:05 -0700
In-Reply-To: <20250913040256.6972-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4f2d5.050a0220.3c6139.04bc.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
From: syzbot <syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com
Tested-by: syzbot+0e4ebcc970728e056324@syzkaller.appspotmail.com

Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132d1b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9134e501f17b95a4
dashboard link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d79934580000

Note: testing is done by a robot and is best-effort only.

