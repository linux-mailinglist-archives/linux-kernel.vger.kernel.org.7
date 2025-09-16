Return-Path: <linux-kernel+bounces-819486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F5B5A185
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856541B28009
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620572D7DF2;
	Tue, 16 Sep 2025 19:36:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFA27A442
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051367; cv=none; b=l0NEl0eAEpDOgzLvSnTnugB0G3ImjBwfKN6/BqpGLqHapT3PbRAOYu8QdmoLkw9oqvv6Q/62UG060ubFQQXs5jIyInyOBTM0/7gn4rqDktA6wB+0OWYYCWpdlNlykqPaHID8gH4UpQtZcXQyd8R69VzVwZvw177U7GqwQxBep0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051367; c=relaxed/simple;
	bh=/GCsXmpGJH8UcGzsb2PQWy+Dd/7tGl8xv4UA5G2EXL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QCsQUuGLWQUPTYTxSM26UHfyTte/OaKowVxJwBXrkciAfMfWPdeaXx4fultUq71hXOpgzTD7xj+6PNXdJkBDAgHVygGwVmNptKXVETaRDyjsd5PRn679Ttq8LjyzoneSxYbHXyAvS9GUdAnVQ8W/vYkYA0/BYq6hlbG+yrnV3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so159969185ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758051364; x=1758656164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O367QokAfAYPSahfznzD0NtkuQY1HqC4LK1K7EMoSfg=;
        b=LYs3hb1rlfLD2Sy71RyUQucRbwHZE5lOzAB3yy+HKIrelJzFx0n5EzV2xeIT1cya4Z
         zh0nHI6+u0NABlgAV2muw9nFilXmGzqGRcv5X4SxadeBS5gontUgc3x78vckFhrravAu
         RrRwXuOhhKI4R1IOwEzqLye9cI/wkNvPfiygcB2Kjpxlmn8/zBbU1nx1GZENXvXfpXBG
         cSjbkhbsR0fCBCA+aAfIytItakinStpMtgGtKcauBW5q3fH8I7H9Ns9ZKoLUziafXsDm
         SDvjWswrxrgE8BjoD7EzBP+FIhWyfPebjNH3+qWu1IeT3ipXDoQ2sXIvO9oXOVydB0bD
         tW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXAVU7DPcxsIKYYc5jPN5j7LFByhgPAXok8bTJY7NVI5UUpk8ktFQ5+9B6vTCj/U8FnEkGUULEdkv9TWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJy26jq5f3meK8V9uBFG4fPOKLEoP7WM0p2stFMh2BkirZM/Wa
	fKDARCwDLiVaE2Aj58k+koibYUpM194NDtyoTAgy9fNJSz+3yUDVMozGBkCgCWDovYWC1/7DdRD
	PD/0sxeNLolgCaIWyeKKMR2WUotZ3KVK++bkzbvVAcHhsLrfQmjVLRXTSFG0=
X-Google-Smtp-Source: AGHT+IEGWbtGFaW3nqQOhP+PxqFdPrP/Woz3LQb4/D9rfrPaYNh16BQu35QhVt5KBYdCRpOq0H3O3dJxJxmmBLjsSQK4wnpkT1Sc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:418:84eb:ea20 with SMTP id
 e9e14a558f8ab-420a311d40emr170189985ab.15.1758051364603; Tue, 16 Sep 2025
 12:36:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:36:04 -0700
In-Reply-To: <CAL4kbRPknFFpz9OHU8GruOU-berH3tTqJZZSivzR0mXhAOinHg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9bc24.050a0220.2ff435.042b.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_print_dbg (3)
From: syzbot <syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com
Tested-by: syzbot+fa7122891ab9e0bbc6a7@syzkaller.appspotmail.com

Tested on:

commit:         05af7647 Add linux-next specific files for 20250916
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f9b762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e269dbc7717119a2
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7122891ab9e0bbc6a7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1211f762580000

Note: testing is done by a robot and is best-effort only.

