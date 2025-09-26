Return-Path: <linux-kernel+bounces-834099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BEBA3D96
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8AF1B23967
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AF26A0B3;
	Fri, 26 Sep 2025 13:18:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511918C02E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892687; cv=none; b=HkRt4kj6vnpR6JGdueOFfe75+382SgWdkIS6H0RmgtCW5dh3Uq0lQYZ4vGUw2valF4zhcFUZqeuMjWy0C8iIdrsVsoIgzTLAKP0UYNZRoWG26gvQJ2jRzU//sUg5B4JPq+lRm2xeEx7o5ohoNSxXKvNo3yZihDKr9hBkBBqwZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892687; c=relaxed/simple;
	bh=SvimFLSfOGgMRcmY8EQ9yvTXVoKzlzZcSdJogVFdiAE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aRRT8+srCxrS17HUN8f4meDPrqnVKZuonFjwH1G8psK8zQ98DTmV4tfN0k+zKxcK3nPH/3qpMFfOD+UkZ88y6a8Y6+o4BMZJjD1Uk4uXBYzMN9bJKenUvBcgbLl5YNYJUOH3kZaYH6fyqlAg+JsSuul58Sn7wEahElf/Hrp37wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4258a5580edso33402425ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892685; x=1759497485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOnhPUaLPBTie8Gf8zY0tkPzT/v/WRIUrbWXBIP4oEI=;
        b=HqVA2dvN+VLiuDSVcUhwuhjeHM8rmDeu4RKG/eJiqGlwylGpmpYqptehP9YnDUwXwj
         dvXF24OvqtddYnyyvgjPkK9nRw00/6YQuXS6LKtR2wKNyTXVEgFqz4scx35noJasTd2Y
         QMc0YRqkYYiok3rFSSf09L91pBEd5jZCGU5AfuYOc3jKZsICv8tli7l4Jj6OqKp0Gmxp
         D8hd+kmDSsW14jPn71cl1nvfHJDnZSGUkTrRdPj9BEDR/nt6tS0SrSCrTo/tTywFWO1b
         4dOhwNn9T11CP62luAGXbeqHlHXAF+rEy1+nr5v3J0q3deAfDFUQXb9czq3x8gLXCNG9
         e/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVApp/ILXb3rnvrhlf0mzqrULsRfCbhmozjtNUGAorB18coZn8hAQ9PV3no+FWLdrm9zzLkRxs4RW2cXcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0KV6umxI0i6m+Pe5rLRd/uBPOr7olXkCFRa/G8tR/qKYydHz
	alAsBGIBOsFFrmdK5qmahpBMXme7WRcocRo3UiMiKAWPKT+UiGi4evUEQt6gOxdzdE7dTN7cCfd
	rT/11pBeZPgpFyeFZmVlUROKJctzK+4tx1RJxz1lKHmYDCBfAyjQaFId/ti0=
X-Google-Smtp-Source: AGHT+IF7u/ynEbGa8WbnbkS32gv30v45TscSmvAcFUCZrBvWlwBDIFlL+eBZWx3DwvWrdiKv6wLr5TX7t4yVA/KsbnZrtNgnOy6U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-425bdaf0355mr89960275ab.0.1758892685463; Fri, 26 Sep 2025
 06:18:05 -0700 (PDT)
Date: Fri, 26 Sep 2025 06:18:05 -0700
In-Reply-To: <CABFDxMEZq1yjunCgJegUw5ky5GWNBw+pmSOwkfismXymJn_riw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6928d.a00a0220.102ee.0003.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com

Tested on:

commit:         8e2755d7 Add linux-next specific files for 20250925
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=103f5d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30329cd7f7188983
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152b9142580000

Note: testing is done by a robot and is best-effort only.

