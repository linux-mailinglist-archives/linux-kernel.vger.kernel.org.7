Return-Path: <linux-kernel+bounces-728486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F61B028D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1EC4A602C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559BC1534EC;
	Sat, 12 Jul 2025 01:44:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86222946F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752284645; cv=none; b=YC64Z1++JOLuFFlhOjWB8MkQDP5HBAFHBpoiMIkMPLqxOj5QqTiTHy69BWrbrG8eknzx2lLsScqf2t0eaCWc2buXhjOheFss+m8psfY7Qb2kcH0W9NF1NqFcoCRN4W0Q72UAZx0oKIqRn+GZdg5THSBRBjdVxe1zkiz1hl2M3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752284645; c=relaxed/simple;
	bh=QM/AjzhBVsE60eQZUgJOrwpqNvV+wdJkrM5yeB/TOcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gi4KUr86DwXvlQO+wkXP7jAEx7GH8HQA98p09V2e5yCe0KOjzJv61bMw9J+aIFpgd76L2QaqsvBpWhHl94VLeh6xqCvxF3ckLoc9TJi/KFUAWlpJegz4+NRPplK0b1y3VQPwolC8RDhLeQSR3bajyr2En62kGdg9VQHtiQrQ2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso26869495ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752284642; x=1752889442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKKgWPnNMElrCjQoMPILDCZHqM/tR7dg5yI6r32GA8M=;
        b=jjBxCkJjGVZphJgfIn885ZydXoSDWSIieClRt8WdaMZrotmtZpijBRjmpNcQH212Pf
         g6GdVKnXS71v7wITj+7+OyDbucPOznV0R9TQvxHWlg+R5jFxoQCRZ5jLpk375ajh6SMo
         1A6d1C/PYvf4uPLeBa2zLzsyKvxxoXkxUYbQznuYcX+r53dNl91sA7taSD2j1sGwKG7Z
         /A8eGlAjfKTANYsS1RO6XJIdLTslxYeDsExF5lfzRo5EvXiZp1Ag1zbGg0/vX7qWCzl0
         tJEN7N0VzwhCp/b8YcgK+Dfv2uCuz6TILmOVe1QRZWLv9XBcyDmlDSZhTfl5ZCVDlujC
         MkTA==
X-Forwarded-Encrypted: i=1; AJvYcCVL8UOcqcirNld7ENZP6X2p+hTEtwcd/RZKHb3f5yMgrgzXs28Ij38sWkkY12vAFKIE+8iaHkAVg8LpelQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgwfRMm96phjnaulPoyz8Sn8Vq4gj/ohZ+IwcSSiMJdHTtjlZ
	BMXlfBj2pLsdqDn18VAz1Vu9LKHU+gM53H6WPQcnDOxVOlkrq/PTwx/IFdC56/Ho1MMMkfSv6EB
	48wc67WfQNF1GPUHL/ANozkYtLq/jKQojTRRjwlfvQgJxyK0Uk+iPMuGxwCw=
X-Google-Smtp-Source: AGHT+IEbdna+uEaTKySAh3LXK8qC5TKRK7ltobkv3pJa1aMBtALaFgvUqQwktu3ryVJL1ey/w6zOJKgRajNu+fnbmorRxAId1BnI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a0b:b0:3df:385d:50a8 with SMTP id
 e9e14a558f8ab-3e253287b49mr69074935ab.6.1752284642466; Fri, 11 Jul 2025
 18:44:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:44:02 -0700
In-Reply-To: <20250712005751.3574-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871bde2.a00a0220.26a83e.0069.GAE@google.com>
Subject: Re: [syzbot] [hams?] WARNING: refcount bug in ax25_setsockopt
From: syzbot <syzbot+0ee4da32f91ae2a3f015@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0ee4da32f91ae2a3f015@syzkaller.appspotmail.com
Tested-by: syzbot+0ee4da32f91ae2a3f015@syzkaller.appspotmail.com

Tested on:

commit:         a52f9f0d Merge tag 'batadv-next-pullrequest-20250710' ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc7bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=491e511dfc95d0a5
dashboard link: https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cb2e8c580000

Note: testing is done by a robot and is best-effort only.

