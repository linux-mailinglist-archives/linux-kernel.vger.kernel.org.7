Return-Path: <linux-kernel+bounces-829652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB4B978AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EC71B21B11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F730ACF5;
	Tue, 23 Sep 2025 20:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC726CE17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661145; cv=none; b=sbYrBqHkBZ6Rb6F7Tl4+a4yGGtculsagTrD7mTI98qwBqS44JE7+VWJs8BhoDRHjWL7iOBX18vzpGnVi50ZLItUSotRCR30rON3N5/I7MNx6cUTCBgio5mjh/XenNYrg3qPaHKh3Sk8fRWACAqs0UEAZaYF4J8bvX0b6t7fsBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661145; c=relaxed/simple;
	bh=tQxZ0c1VsXxaYB79eg+ulpck48hsslqUouLBeMg74FQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ka/2a/3gCiRrb0ZMoGCTYyPlPAydEhZjfK9gW2OwEKE1KgZ7wnitXJUPse9c5lOV/6+mQfcJcyQN1SD//+yzOzteJ00aCxQfeXDDmYjtd20+v8Iqx7bpANqkWHrmVX0cy1iOdETYINx6b+VE+g1H6/OsTgnAdEFZfN5+q9QQOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-425787ea1ceso40512645ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661143; x=1759265943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYIR0mMBCVt9fGMK2+oveNeuXPuGotpRItEFRD85+bk=;
        b=eoeCipVsha4S4kjGSj03y/ULZBuC7o94KUuEyjEar4XxFamGDGQQtMxJcxcqo45IB2
         wCdUhvAyjcRNHGEFOTjOaZz0QE1cXKY1vkJufpLo5HQFNeuX5EAXD0TwucD5EAM7o+Wr
         sfo5FN4YGGcwM9qBgywSGPm2C8DB9mDVIAwr6Jzkj+KWB2MjqAPVRdHEGOVR5Dxsh+vR
         bK9SJbhkPPhpCw+ZAnPpZbK5tqvtkoAUVHNUuzYEjaC67o5WnfV7clGB5GJzoIaNweom
         PqwscODI0/DhoN322fadd64N7yqkfGWc3YznrxIYH4mPyaHyg9gWknIa9Oo07ygYdkdB
         Q/Wg==
X-Gm-Message-State: AOJu0YyG5JyBySSr8BlIwEXSs6PetBfDl2plTFooaarsHrSgo1E8Iypf
	HFx2dAh0HII9QLbpxnhTTLmALNuV9uQgm7M8bbW5ikjjyqHdS9SYJoVvZxfKGrvmMBkCjUsmODh
	EyqtM6uLzN5jaH1VJyB/8pJx0n6897r5TUnAT6lRuKq503rNAtukV86a8Gts=
X-Google-Smtp-Source: AGHT+IGp58mcoBwUtb3RmOjNaxQq57TdaDJhdTlVgQ7q0oPBl85aWDVIqpkNFIOteOZJgKj7Mk1g8iVXj5B7slsN72Fj9sqOlke+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:424:515:43f2 with SMTP id
 e9e14a558f8ab-42581ebceb3mr63300475ab.26.1758661143207; Tue, 23 Sep 2025
 13:59:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:59:03 -0700
In-Reply-To: <CABPJ0vhxvUrsFsL7-q5UJeUOsy=gz4nUVJxCOLjBaPP5cB2hYA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d30a17.a70a0220.1b52b.02b6.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KMSAN: uninit-value in BT_STACK_DUMP
From: syzbot <syzbot+ba5f49027aace342d24d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rampxxxx@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ba5f49027aace342d24d@syzkaller.appspotmail.com
Tested-by: syzbot+ba5f49027aace342d24d@syzkaller.appspotmail.com

Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17370f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=ba5f49027aace342d24d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128f627c580000

Note: testing is done by a robot and is best-effort only.

