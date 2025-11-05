Return-Path: <linux-kernel+bounces-886712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25462C36564
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8693F1A409F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E27343D86;
	Wed,  5 Nov 2025 15:13:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD33431FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355587; cv=none; b=HbJ16voz8ZeccegGgCyCLLesstIIU+Si+Dn+Imx4E2yqcOsi0rZgK/umKlzcV2xnv245Am1C8YoY6Jj+FbyXBr8CHwJEy22rQq2nns/Hx8UkYhGUdnOW0ts1fOD1Mi6NZwOrmJ0fDu7HkId3tldWIv7utPJCuXDEE/EcAHFfbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355587; c=relaxed/simple;
	bh=dLcTW1aCAzLhaJVOj5O43tCa5J2ImJgjBVYCgfVT8Ms=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a6Rg0R6fu9Qee+XJiw/kqbwo9kDJGa0eAmgf2EpTHkFH93o+cXkNNTl8+bgfRrnHAeSXYMQI9HYEHlkqHaffYikFHnt9FugzWHUd3rNHYsykAZ7sK9mEuXrfXOhdFeQscQjTcY+JQ8vh65+vL2Ky1zKDud1ugsIu1OtMY9QZmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945a94ceab8so663964539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355584; x=1762960384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC4CyBjhOEnXk/s/LxiIlBFL0VGpqEH5wTl9IHwuW6M=;
        b=buVoZtL7nL7EaGzET+6BOsHZHCqreZKy8P266iIvYTrwYT1TdiCZgD8GAs6nTxTMmh
         ICVetD2j1OYMZaDXkj7GGFS99Dak9g0euHpqE3L3YkoTNsKYug0LzUR6NA0Rjb5Fwr0U
         uGYwytWL5XPo8bUdaUTUcpFn7WTkgx9VPbK1I+mveVuGA5+uLBvg6Sa1dnXXc5pWXFKD
         NkhKKR3+olIaVWj/d+LZMvyd2VQoAKO+s/3p96DxN9/yal6HOXixpteiyVEHnCCvsoCA
         O1JxnvAyCYClsQwvoMUsTcLYytwONQpP4E2jFpISDegBFsLxNfW9hEGCeuEZLkDhiWVN
         N+fw==
X-Forwarded-Encrypted: i=1; AJvYcCUlMmD5KQNKQbwIgEFo270tlA38fxqQOwvQ1t9NWyaM1AxuwIZmuoWn046gUxUnDglxTY+2YBliEE4eWys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVQB30OsoMT8GGBmcwA7Rd4GgM8ND5SjaFYCicJnz8lY8urwT
	a03aEIhAECwU5uvE8c3l5yY3NS4PoV69upmBefw82zR/tc2meggkTHbWjjYjf52NWJCfn7e7yr/
	E4SqRr8XS+Llvu3YvzkNIsj8v9dL4ALh4ljGqaN2jwuZioGKF2y1VbVRUZSM=
X-Google-Smtp-Source: AGHT+IHhUJ3Bi8k0fQ4Hm9e5q1z+3H2zBxC/PvIh5v0vXF3M/QMYaKkoiMGp/nhdrvxO86zbloW/c0xId6+Ug54DfmBqPMDCGS1L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:430:d061:d9f7 with SMTP id
 e9e14a558f8ab-433407c519amr41503085ab.23.1762355584739; Wed, 05 Nov 2025
 07:13:04 -0800 (PST)
Date: Wed, 05 Nov 2025 07:13:04 -0800
In-Reply-To: <9f0a89ac-f782-4afb-8fe5-9575de76b201@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b6980.050a0220.3d0d33.0053.GAE@google.com>
Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: eslam.medhat1993@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com
Tested-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com

Tested on:

commit:         84d39fb9 Add linux-next specific files for 20251105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15cd1342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=413cf24e78b667b9
dashboard link: https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fc2012580000

Note: testing is done by a robot and is best-effort only.

