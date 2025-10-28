Return-Path: <linux-kernel+bounces-874583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F95FC169FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38D31899F10
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E573491D6;
	Tue, 28 Oct 2025 19:32:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDB25784E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679929; cv=none; b=W32nvJOTv3XGol7v+xUlSLEFWMly4JgQdwrOxlUju6cgKTJkJJnr5iy58UkHYKxz+0emf8o0Wz7aUQ1tz0jDc4n3INe5EHZ0uPe19LuN/dQHqkx6fiA2M3oIOiWPq7N08VEBbxGo0KrT2ZCr9lSvszPXOt3Zr5wPldWnr8LfrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679929; c=relaxed/simple;
	bh=4mlQJaL4gPTQQMMpyjMItd2Fj7wHYJU2zpJG04a5mYs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LZFJiKYQLV7C2rhS1aOR5kPtLxN3CKx+LLgaxZlYL2PA+ooKEb0kS4zSJRikvogrPcEFSXTW1LdKxpm8S4Tq/7alxazozC1tXSDkCq0Wjkizyo3Yl7eu4fARmruHOIND3VEtoksRW/EeI5T+zfXQMJCdIKV1h+xwRhpfeARF7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94109728fadso605835339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679924; x=1762284724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfUcnJjIGx8U+iQiH3uZc0pEcE0ul3Uh3A8egc1Hu/M=;
        b=deYTl7vD8vc8K0gSJ3EjnfUvBwv+TLBalKqAYaOH9mhghRatad4+4vm6xCTuJS4NRJ
         taSS2v7i8Bhd9x3zEsqvRYaFvaEugFcyAu0nQjTdyk9AH5Q2DuO1zmQQlzjEtgH9+e/6
         hiI8Tqd6gNehmzu+30rZxhrQxgiBvI9od+99Sa0PcYS3d65xvp0h32fWAy/TQNaduHWA
         CFcmAIO13fkApQvxZmFkndDzCrHvH5btR9WUSeXjqnKj7i60ltIE0aKdXFGKTDaB/ay6
         gpvxO/1HbTIhtoojUizCaIcWADOA0ackHzxJUQlhkYdLXxG0btxPiCbSjdhc/Iphmv7B
         x9JA==
X-Forwarded-Encrypted: i=1; AJvYcCXSBpWg/oU3kSPWK9zRLeBudoRExuebb9tmVT8aP7igVUQ7iiMFhZ9DS2RoodxoJNMDMiZ0RvAetBqtfqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6n8GfEgoDU4IgMMIzJWzNoAKRRJ5Wn5KBG51IhNxs5H7rroSC
	0YXoqcULOurg8ujMDZyqXMmdLjVXY29mGhz1aWZOE5TYV0TyMPDzriUufebcOUTGUKFS4AAlzBo
	p98BBPBt50NyZS8sTVtncwtY6aBjB5GFUNjUkloLc6mPjI74DnEuXbVqBaEY=
X-Google-Smtp-Source: AGHT+IEQ+JMBS9Y3b7cBB90esJNRrZbSxAvLmQ40grGxhSbXDCgPreA6+7oBIhlNX7L1CwwOiy66QN3QZW5i2UOlg4MaqshcAnEy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3786:b0:42f:9e92:a434 with SMTP id
 e9e14a558f8ab-432f90286e7mr4860975ab.21.1761679923805; Tue, 28 Oct 2025
 12:32:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:32:03 -0700
In-Reply-To: <20251028182245.3DboF%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69011a33.050a0220.32483.01d7.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10a16932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae55ec3582be8d28
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173377e2580000

Note: testing is done by a robot and is best-effort only.

