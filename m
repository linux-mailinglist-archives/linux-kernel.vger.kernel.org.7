Return-Path: <linux-kernel+bounces-861964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B358FBF423F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C9818C532B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5271E834F;
	Tue, 21 Oct 2025 00:22:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C371DE4DC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006127; cv=none; b=jF18qz7K8rCzVXFcC6dzRIYmvnb4mR5+gWitM0HZDDv5Gx5Jt4PL6tc4KpFoloeIppbYgIKWWvjhT4uNmW6UUekpPPiGq31woH6jeLFX2QrM027f0f+b73VBEFzzQskyH0SjB4PTEg6kQFGdU9lsVqs559u1dAGSHkuKWPBgzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006127; c=relaxed/simple;
	bh=jRyncedbsfPxCBLZAFSkbwCGHsi3919HNn5Y/JMoML0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TAnw+gEDGr94uGrRyi9KZdfElvzaqxpNJDBCK0tR5x3y8p7FgcnP2L4Aj5E25qEa5YaaO58vzoHYkxYzQFAjKy6p9qc00C7x+6h3ByQyyMK62d3CQk+HnV9WJnpQDhYKXnI596bon0d5kU/rHYBEgDNDFpjrCBxXdNJkiLSlw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d4ed5cfcso85428215ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761006124; x=1761610924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKTX4vlZO4HQTsOIDE9lqj+OuO32L5IMo8wGmgc6IKY=;
        b=BHj6V2T8uR0uHkCWoJ1dzpZeErKcWtMEBe1YiS44L1U0LqG2wv+Nn6ho32yBp1U7qz
         +UIAT6FaAf8aRg14esPH7EMkjyqqGo9QZhDbgwhnFRIpJHerQmRHu1e92pgYx/7jd1Jk
         tnq96fPe3WccqJAj3H13aEwO96cvGHu15h5U0/fn8aVnNDQn/7rTOG6OlBLI/JfXE6d9
         rGNZNDGrD0qsCzYYGTLHb+zUknvbBAOZ5AtGwD1dk9I3VM/RO7G1MiZypvC9oSYiAxBv
         imDB8yH68iVX9v19pjBHsYtlrJbpqeTx4NElRMy87upRHr1t50LwhvYk56Z9SWhrkt7f
         CKvQ==
X-Gm-Message-State: AOJu0YxAS0eDR+BhrdZwjqySH8xKLLSsfs8UNlOAA0pHfIeq0cp0m8VM
	QRariKqA314bXANx7Hl2Xw+mWGBUBPfSQbTVtusWdGe7ZsU3uZjpx2wkEA4sZVKqHAvGR61+uvu
	nynRqYryhUQyMxtTKfTRtF5WjG2FtL5X42dFSJDoz7d/Oivh/xhlulMtyVyE=
X-Google-Smtp-Source: AGHT+IF9mpx4lwvvhdUTiLriDQcCet04Q6hPOAk2gQ2PVDrR/Gq6iWUB0+bdQ5INb2BsDZqb9+CAeN6g36gctGIGwryv1x6SWxuY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:42f:8b0f:bad2 with SMTP id
 e9e14a558f8ab-430c524715bmr237471095ab.10.1761006123824; Mon, 20 Oct 2025
 17:22:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:22:03 -0700
In-Reply-To: <CAHjv_asXz7E0MyxJC1msGY0Jy2JmsYOZKDftL9v8MtCLJcoQWg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6d22b.a00a0220.18d35.0000.GAE@google.com>
Subject: Re: [syzbot] [bfs?] INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Tested-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com

Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135943cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a77de2580000

Note: testing is done by a robot and is best-effort only.

