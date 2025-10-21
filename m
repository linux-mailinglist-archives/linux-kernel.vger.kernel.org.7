Return-Path: <linux-kernel+bounces-862573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A35DDBF5A66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A4DA35041B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119A2EB87A;
	Tue, 21 Oct 2025 09:53:20 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52D261B75
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040399; cv=none; b=Ld97KvjuBpiX/eN3x2R3zHJEFW2Yl48Khf3zD1BCWZbQiidq2kjmsrYkhORPP5zkgiL6O4RifBOJOf03XmGI3SCZkTlygNW9PT79iSLe/df1TuY23hNTBopRdtW+fDw4ggnybj2lm+POpqiOSbGc3bW6TYHj8Emx6nT+QyDtRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040399; c=relaxed/simple;
	bh=NSSFFadB6T/heygUc17E1yzcyP9oFXhkRb9EfAlCiZw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TgXWUtLJ7vqF90SORQhkDZ1TnE9uxPg+e67HgtqtIz5kNw24FW+kTFZqH6eFsLQlIAfBDQHYryNaX07Ixyn8fX0GGy/tc6GaK9+38QNoJEw3txQ5N+5wWOWFyBPswHK5ZAYvWjiDjQXcOwT6NkdytcwmD6qVYE4qBXm5G+DGWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-940d395fd10so718728839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040397; x=1761645197;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Om/NSOIxTN20TSkGJycUFW+bNm/1D3MvjGtvk5SMTrs=;
        b=JxNvUp43gbbNDaP0U0tSPzX5lJdg5+k2iU/+yaneZWqltkXYNoNmouYqtbwgfl5jXp
         oC7e4Fp/4esLcJAKZZDmZ+EmXDczE2GbAa/6POnHuUdFWFfJrf7YZWZKM5EshhfBh/NP
         T4u9kBN4gq6LUoyRDM1pz9f3ExjNKQZfggEpVQ83Tyj6AjTrNNLmM4AdLdskHLRtbJv5
         p79kx7qHumrw8amsQ7HfIMbdV7MloHrTUAGxsRkVNNwVQNtR/f44kWZa0sEkZjRzyL0L
         CDibrEJ+69E2WCcJz6kTxypMNAqamCSwMY9VYL8+cuUV6ZTzIQe3RfSM4AChGOrKzngI
         JGSw==
X-Gm-Message-State: AOJu0Yw1n436711Y9BnJLYWKYAq/5Nvf4FL26sv6NcpqiEdqTam0PXQd
	HUfXgx8ppVuF2z007axnzWRU1hsrOCwH8ZuOMyg5C+dcwzY5dFXacxjSCkrwVYhghUVfTqVyyzV
	zoLcG4SndlCGpk1+F9zX4/bFdG+iS3pTuOtSWer50x1KIRyxRfELd7PgO4wF9eg==
X-Google-Smtp-Source: AGHT+IGlUKIuISb9G86JK7B90ABNJ68+3nlq9IJmPL0+Y2qkmlVPsHOT7bBtSjuhKG9WEuKJBfwgbsBd2QpGCkvURQQ0DuMeSzwj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60cd:b0:93e:8a05:5f3b with SMTP id
 ca18e2360f4ac-93e8a05632dmr1757744439f.13.1761040397533; Tue, 21 Oct 2025
 02:53:17 -0700 (PDT)
Date: Tue, 21 Oct 2025 02:53:17 -0700
In-Reply-To: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7580d.050a0220.346f24.000b.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Author: listout@listout.xyz

On 20.10.2025 14:08, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 'off' as d..
> git tree:       bpf
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
> 
> The issue was bisected to:
> 
> commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
> Author: Sahil Chandna <chandna.sahil@gmail.com>
> Date:   Tue Oct 14 18:56:35 2025 +0000
> 
>     bpf: Do not disable preemption in bpf_test_run().
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
> Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")

#syz test

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8b7d0b90fea7..1d0047073eda 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -36,7 +36,7 @@ struct bpf_test_timer {
 static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
-	rcu_read_lock_dont_migrate();
+	migrate_disable();
 	t->time_start = ktime_get_ns();
 }
 
@@ -44,7 +44,8 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 	__releases(rcu)
 {
 	t->time_start = 0;
-	rcu_read_unlock_migrate();
+	migrate_enable();
+	rcu_read_unlock();
 }
 
 static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,

-- 
Regards,
listout

