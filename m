Return-Path: <linux-kernel+bounces-868953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215FC06944
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9413BD408
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D731D75E;
	Fri, 24 Oct 2025 13:51:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542F3164B5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313864; cv=none; b=QaR9Q8kTdbAKyvltLta+EAYm/x/M3wmilnTvL76rmg/cMGq6lMcpSx36wZcU49NPQYXyw6PyKwYp+ymUK/6kBc7m1th57p4ItXYUi9b9xCPQxobbyEx1KRqGlkkHda+M3MbUHO99eeYuuCgLqCkqMa5Od5nQKiHbdt2XO5mmIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313864; c=relaxed/simple;
	bh=k5LOs3dC9/IS4m0sgGwpCgYLdWsFeYx2Rr5oOvbsF0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=po7fLxHJTq82hs2MWFwqOFgrdRxlSsc+C9wydK8YAL5iIttAzGz+B+iPO7KJdXhl95pty7uY/ORdOBzQj9gse4qV1dATDlqBFYGZb29jxDKg5vOkakzFtVM/8NRkXjSxsf5w/AQxMv8tQSXgFyrt3qFaqdctNbKRB4zGL4piFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d1adb32aso20420585ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313862; x=1761918662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n4bLPISXKiSJ6WIL2erSZUgo87k9HnXWwxAg/ZV8Mc=;
        b=oQNNZjhhAQB09K29diCTLeA3MxX1ThxOj9HWtskc4Ut/EcZF+wYLFxS43RB32qJ0LM
         ZPZJrEShGOkjeMPeRPr3iqFVQStdEuhEB8D3p93KiKgH772vEa9coLsthLjxTXv3dhDa
         hFgp7PjSuj4njwxgtCtF8k46rTbsPhCtEjDLMLuiv+8TzFSGZvy1ENHLYkuFrrlbzetc
         +ZCzxZbt26/C9k7Vz/eR2zT+bBTCdfYBjaFOm3AWwd0LYPheHtbytc11KwNvZLzhbwNc
         YXWr30COnFMw+GUDtd4ICB9LEUbOhfnJmJu/d3SXGm/3lxOnihqjBQCP7smoDHqmOP3c
         F1LA==
X-Forwarded-Encrypted: i=1; AJvYcCXidB2L+orhMYOn+BZnqldXkaksGWlSIy0zKByfUdZLjhdXJNu5C+Rd5/ozWGSEulMI48BN3w2QhG6btw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpY6XtjUirx7NJZ4YrQEnDFvcHEtJbM0FAQKKizfQ3Iww1v7EQ
	NAVVdgcEA4+33bXzPhM3Tbequ6A807mgt4eKFuBTotqj/Zkoia5qvoOMukPWn7hXL1fhEKiJCYo
	afZ6oKkWi4s9YkvDXbJ9MZia0hXnsWgx8N7hh8R2kOshqWM0LtbUMzbS8LXw=
X-Google-Smtp-Source: AGHT+IGnvPvSAeDnIWCwAJbIh7c27P6xuYoup6WG3iMxqr9yWAnwSBrcnLCwfdMv/EXqrJ5pcy1zhmwHn+x1BMM0ZALKG8/pzpLl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1605:b0:430:a5e3:fd70 with SMTP id
 e9e14a558f8ab-430c5253b58mr363350925ab.9.1761313862105; Fri, 24 Oct 2025
 06:51:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 06:51:02 -0700
In-Reply-To: <20251024071530.y1waw%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8446.050a0220.346f24.00f1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12097734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f28258580000

Note: testing is done by a robot and is best-effort only.

