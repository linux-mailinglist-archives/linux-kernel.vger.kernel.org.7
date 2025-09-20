Return-Path: <linux-kernel+bounces-825866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929EB8CFD0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AB77A6E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B2246333;
	Sat, 20 Sep 2025 19:43:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725B239099
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397386; cv=none; b=I04WTaoV9t/kDNAfOgySGhyHxFaAIKV0l3Y4WwQn0JUVIgVn4lY3YOkuTI26ZOjqnyFNMU7jkbFTNIs0vzsXM4JET/CSWEdqxaUugf6v4fL9GaS2dz7Dwmx4tOxb6xJXP3hK7wXN41ULcTrwXp7k37zGHLvoze2LP9E61rEX3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397386; c=relaxed/simple;
	bh=QuYIGusTvOYSD/1Sv+PjTfL2RMStemZ69WBb+RybRdo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmDmJA8nvNoRv/pSRL0ewklbcbX5ftFNoAjUtaJaLKhmoYbGGa6hz3gfl/d84T2JYakheDA9Qp11Nx753C7F4ApAM+RMDQ2rN1yMV2MKfgUfUH91sz61YnBrc2GS1QX8/H78FTQVn68Ikszi2U2SneqH3q5RW7W8mu72eAK2bQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4248b59ea91so33447775ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758397384; x=1759002184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBvzsX2omWKdi84JCHzyZTteeFJIcKBtEK53F2NzRsw=;
        b=aE+SBwIMLi+prSKxyswicpcWeOTIlzSFBTXd5RMR1IG/wuVNf8McGi4qooQq/KFIhl
         rWTuXoklldedL2vYTDWyg+oQXQjo2GS+oIXCe0GxzdHFjweLiPQMWbwfszV5VYzPpClV
         y/SbYmj/76WYr0dyrGofVrtr644f3rWa7WceeKl8cQP9Pjwc1cyOkDmeXseITDYKX8u8
         AvrG+MnufcxmRIv0StH6DitquravhPcpSl2gKUoIHg56+BedLvdWCLncIUAunDmSBiNs
         wXhfdtX+K7wnhv1989PsIo0x5dvhvKJVlyVfJeJi7oLtlxIE4Lo8G3mi3bORyERvyMEg
         cqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsl39kCTNpyThWPaW78AS8jMbibfPvRmSU3AMEecUhTmfa7ZtVapqSPjt1hgT10taO8UkaMRxFjnLKW9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYfJF74VwBAfaKMHlukHX7wft+uV7FWVV6smeqh4wnquqw8Ah
	TQZdHNcKAX9vAkQHKGX7fYOP5J7v1Vy04lq3BvEp4xOaKNA+WcoIob8sv2eC8/Z5kuk6XniRHuC
	yRo5qIYv6eFNfJiQv6wS8QMDxzg8bV4vAejRoNhnsZWln6wGNSZLQuDylbfI=
X-Google-Smtp-Source: AGHT+IEtZyMoXVW3l1ojFtbNdcC7mLXpWav8mZtJ5CSGhrfsDhdmDMkvIey9mIvEXcz9ZaIWUXCjIAhizpMGU91QyVPSiDMhXXd4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1647:b0:424:b862:831b with SMTP id
 e9e14a558f8ab-424b86291a1mr50334645ab.4.1758397383912; Sat, 20 Sep 2025
 12:43:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 12:43:03 -0700
In-Reply-To: <20250920170037.9612-1-hariconscious@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf03c7.050a0220.13cd81.0020.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: hariconscious@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/tipc/node.c:2121:3: error: void function 'tipc_rcv' should not return a value [-Wreturn-mismatch]


Tested on:

commit:         3b08f56f Merge tag 'x86-urgent-2025-09-20' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff65239b4835001
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101470e2580000


