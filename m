Return-Path: <linux-kernel+bounces-851817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8081BD7592
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7C31885BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922B30C606;
	Tue, 14 Oct 2025 05:00:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC762727E3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418008; cv=none; b=Avs960KpkqwLihwkMZK8Tim6W7/jFrhuzM86j+OYLv5wcsjTAj7nfYZ+w1IGTE/W5Yob6uDGn2TyM7pcMoSEzBzSH3DbuIf9n+qupGYIU5nnE4bHTaehARERmaYZWBkZRPBjYhihBYsJEb6r1gUcNZi2biXEjpGAYwNWPuQ7SX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418008; c=relaxed/simple;
	bh=clwrISk0wxrNNxAJoSB9lkdxYc27MuP/ZuvIR6RF1yw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=psFnK0CfZvayPQLg1dui4j2EexpkWOK6ZJmhaMZSQfzkPz2bKF0kNgGr9hr45nQ4RdPJaJPZWZv12kUk+kR0DledCFQ1sX+p+1UDbiWIQ+DLzdL3DSPU2Zdk7CSkFL5mcnDjZtr0xUDIkIRlr2ZdcHlUivA3/AuyTSPDos43LY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so108444865ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418003; x=1761022803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NeqdIbIfYAbvXQ7OkGouk2gnzb3sUr8o/JVB2wpYGg=;
        b=dlt5j9KRdzRiST/keEfh1w5hs+MBHEGWny2qR3kz6bgEpXalrwHZViKCVUx6wTjFQt
         AiB/KB3TcZ/4ALkls/srTsVFcXXhVAyT97SesEtGEFI5vneYgLsW6jIYnGyBLqJd0ThF
         +b2KA5RpP2Wa83ebtMfrtp7bXwkluRNmDX6zh62Te3Nnl97qSEVGPgjJeSbhY7eYIqeo
         yPVWYWh29ulHzrl78l+BV5d/eu86fmhvnevtO0eoebvX0yLxJzVEbH6AwAU4oFjHKEQW
         q32ZZovQtoEXvIzXc48JAMldczefFZ4gq9UB1OKObrHRC+aivxYvNb340C4QTCFHBZi2
         SdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8WvgbsuWinslKQvlsJIrpnBkH7sKnFgg/pS8UqTWmzPjqYcp+NfSfjNe5N+m/LOVTgxqrNR024pQTmb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/7QctAZ7LuuDEbpRvuU2IQRI545mY6eGgX2z+hHGLtYfNsbg
	9E83aVBvsc6ArMMnup/fmcIQlFxl+fswi9W8Lp+CkDojSIssos2ayTsXCm7ZMSTB6BdV46avm/6
	rOJ2hQD/plPQ4muNVONZ55P0obLJ0+O/UUQyJhMvAhomPK5V8rfm2kzaP3Wg=
X-Google-Smtp-Source: AGHT+IFWkHv81YRlbPNuxjwFkCPdTW3EF7i2uezmJ1gURLia9o2CGAGr/qHFkGOm9RgEOPlZ8WughvmGamuZ5xT6UcnfLRhMuw/0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:b0:427:709a:fc87 with SMTP id
 e9e14a558f8ab-42f874211ccmr207392335ab.24.1760418003460; Mon, 13 Oct 2025
 22:00:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 22:00:03 -0700
In-Reply-To: <20251014041430.347253-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edd8d3.050a0220.91a22.01fb.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         52ba7632 Add linux-next specific files for 20251013
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114e79e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=271da434ef3da10
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c4f304580000

Note: testing is done by a robot and is best-effort only.

