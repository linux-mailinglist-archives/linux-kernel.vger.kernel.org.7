Return-Path: <linux-kernel+bounces-862576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88515BF5A78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33583352C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AD3126B8;
	Tue, 21 Oct 2025 09:56:11 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3802D77F7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040570; cv=none; b=MiIxtiNY/nKTl0go3B6CvrNMxsdZtciICMW8x9GyELBbzN0Bg8d626dyuyOTZXHR5luEy5r/92ZFNFCCNqP9ILmQe9wlniZoivMpWDVAAvwfns3Wv+BI94qkpfTf2OBqaC24H/ud0t8FsAp0hb1WTV6KV0CqGsKOWQbS0tEXA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040570; c=relaxed/simple;
	bh=fevN7OLwQjO5YLOBObnhOKKTTChO06+d/xA6hmJw/ww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V5shM9wFRLHSjhpZn8JkZom5jqz3UCRuMOemzoHZIb5vpV3N++QwHp0Jpct1Kd+AyCic67LECXCcKx9cxILYAY2X12Uz2nQzIZGv19+O24JU0bDHjSgoWoOoVHjq6JqHLjYX41Z+KS+q96hy03vw6fa4rQ8nVEgxuPjSQhuFH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-930db3a16c0so1403448939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040567; x=1761645367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xB2y01Tg/kwS48G9Y2xFyWAYLJ/yi++K0anNmnsFp8=;
        b=WNajfsAo8MvkUpX0Cr8ra/2YyIKSsy+D3CYtsRJwLSgQR/d4RWnAcu4WUPnWvKIU+Y
         c1g0mHvwmyKrnaGdhIa3OVNqlBnkO01YOfLQPKIys+UnFhYmbGu9Yj2asN6hzUwPsfAf
         24bkmEruvEwm/tdlwfs3+w3IAugeIaYkLB8WRmoodPBSytbCQZvVYy3etpYEGEKXZLnE
         yUH+cu0RmoWEE3LZ05/E+Feo0gIIKemTjwchVe7rcm5Z6/taWgtq1IjBDjE2y1f2Mt4j
         HJJMEVzveFOfG4b8UHQdSLdyWQ8QOXcJWyaqiKkxYaElx6fW0xiHeIZelNlwSDdKou5c
         byGA==
X-Gm-Message-State: AOJu0YzFize4GdtYF4fHmKT/wXN27usW3wkADqY1A5j7MoiR2byFTnI4
	/6PTA5qTUP/lRd3Yk8ZpuESe6v1fFTw/pvht+hcSPSA9RNfM8Y7jmxRdo9SaW4mumrR1WnJ2E4B
	p1/OOAAHutNmpcmGtq2DxkupSO1P+N7YHXjGgdJ3bvlFoMgeo2dohvy/sDygRZw==
X-Google-Smtp-Source: AGHT+IF17SsqyR7Y+7+9qY23xSUwEUnMLsW9KqBCmqvN0SiH3RVsAJlsrjIe+1o7Ooee04tmZ8tSEs77gXUDmgjfVKes+kAVZdNF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341a:b0:940:d860:1ab7 with SMTP id
 ca18e2360f4ac-940d8601adbmr1031965839f.8.1761040567007; Tue, 21 Oct 2025
 02:56:07 -0700 (PDT)
Date: Tue, 21 Oct 2025 02:56:06 -0700
In-Reply-To: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f758b6.050a0220.346f24.000c.GAE@google.com>
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
index 8b7d0b90fea7..cc4288f408f2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -36,7 +36,8 @@ struct bpf_test_timer {
 static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
+	migrate_disable();
 	t->time_start = ktime_get_ns();
 }
 
@@ -44,7 +45,8 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
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

