Return-Path: <linux-kernel+bounces-835125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF2BA6550
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DCE1899A50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5F21770B;
	Sun, 28 Sep 2025 01:18:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104F212575
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022285; cv=none; b=B0xWKHT6jb/2eIp6TYXdj55oKreTu0vVNLwQyOqrjBdgCSAXnpBy+3HGAmR0rIbfvbopMWXmJubxEmuA3xiQbnbvk7BQCliEImKAc8O1FdH9CTq6a4RsBhikgIiVnOpcdP9TGVM5L1mKIg6/p+E4nEdpF2+mODTAxockJvJEdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022285; c=relaxed/simple;
	bh=s9UrUGbB10eLSVnTLfWfQwvvoF7hTMqbGr+eRTrnb3k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r2aS0AG9br/dCD0va/MG+hxSZIeX0q7kP3S7o/N8A7EDJ/XEJfwbLYc3rKrHDcUM+hz5hpEN0Dlb+C0FbQDFViQrm/64wLucW0wwUDPlY0U2IBJYsE+9kdLsshcuVkN4BnXxHGs94pYEMeNQ5LbTwSRHbOavg6oivvpJSXtouqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so77036875ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759022283; x=1759627083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymka2ebL+ecXPik/sMRUbMeE2crl8QcWnBk4+iHbLkk=;
        b=mbVAwZ+WKG6hmORqLZnR1xY4dRUkMJAeIBGYh3WKK1QKg1E6NtvmU44Pp4otLuLsCb
         j9+4SnPDZBGpu++2sv5gIGajGO9OiV+h7QK/Wi42kZlZBSFisDiDp0XjinkzRnFlONjG
         Ous9WwOtdTUSpZEmDTb3syaxlwE6HfEAapHNvxWnlLXSc4ES1EN2nddFiXifkpWRDMeR
         EHPpvIP25AIwAchJctbpG2qR9TlrkkqA7ofFrgMwGwXx7zE6qt7TPYyMqJTxZZb8jDXr
         GyhqEHfquHWcvBiOj0usTjjz52ZA90Zmfbh3AdTz1eQKFHNvEMS7X6psW2Gtq5tHxp3i
         Qehw==
X-Gm-Message-State: AOJu0Yym3OBKV6UfYtN9ApsbDHCNXqi9yeyydzliGKNwWTp0nY/pkswx
	v3CLKqNKaF3pOn0yxn4DAwBwgWHuqLZK+99L9sG7WbNJl4WW4v9wc4Ub6kNfMq2LNLNNy3Qf8im
	FKNrKbvZteLRSzNQw4KNp16sWgCBa6TBgaF4DSGTUbkJ3jLLsmf0xPP82S8E=
X-Google-Smtp-Source: AGHT+IHsccyJ0f4x8aYnJE1LreOOM1auar4qtiIOwKQ2fstGJYUwW6AMlDas+t0XA4ET2cLIxC24vWqRWPOJjA2va3/15MqF52ND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:42a:fef2:c001 with SMTP id
 e9e14a558f8ab-42aff0206c4mr8127165ab.13.1759022282836; Sat, 27 Sep 2025
 18:18:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 18:18:02 -0700
In-Reply-To: <87jz1ja111.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d88cca.a00a0220.102ee.0022.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in __btree_node_pinned
From: syzbot <syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com
Tested-by: syzbot+9f41e4b255897d99d4e9@syzkaller.appspotmail.com

Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165292e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=229a4110fb045cc6
dashboard link: https://syzkaller.appspot.com/bug?extid=9f41e4b255897d99d4e9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

