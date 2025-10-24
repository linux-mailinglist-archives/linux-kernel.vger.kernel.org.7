Return-Path: <linux-kernel+bounces-868483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4AAC05497
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 481663594E4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBB303A32;
	Fri, 24 Oct 2025 09:17:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347F35B144
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297428; cv=none; b=haVSunZz4EB2A8w89E9EVRgpVoITrVV3UWGV9x9KYeiikJOJxq9HmJPwHdF8LgbOAcHn5Ak1g8y54dcjgTufkcJHzc3r/TS85A2TjvhcOe36nMsS40/pZd5zQuwMDqloioGjYTDylhFzr9WSkOkvZ356yClS1PyvR2mgbQpsDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297428; c=relaxed/simple;
	bh=9MalsmU0c1M6dqxX8RdIgQmCXdOqFTNKKvdw76XVhkU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEwerW8oDMy5Cmd1VQ/ct8d3lV49VcQKnZ7l1bIkeYW8mdMOJbIJxmL3fZsR6FLHWioBdodEHUgaZyjrBxUejjTcF6siwW/Fuh6fI6IPNf0MkqSIuMnCFUlbP7TKsGlyZBPbBgASltQ2DZWvK+/QL+gzcNM9McIlNHBMncJDd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-94109728fadso136653039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297424; x=1761902224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uktcOvS2x4QcdJu8N2GGd2GOLezXS9mer/O8B3ex7TI=;
        b=up5knHI1cJhDzziJaNxua8Xy0LpTU9eGPFifOTcdFE724AFa8PGA0Kb9hozwyv/OCv
         l579vjb1v5cULv/pBif3t/Ckque+YTBIVXEzIH6s30blDhlcCAFMmF5Gsfv2lXw5uxqK
         52ce8isSPKM2KZTgeTGdD8IQubfE895Bwk/POuMiFjTrYPmrBJgBRuNOxMp24JvO4SLk
         MhRqQUEv7puvzTjfu67EIT66FaaO2gk95NpxpW4JIz7xXjyEc6DGxEOYnc3++UuKTv3E
         uMdAS8mwYQmKj29X9Y67G2obbjW1f+Bwhxu8NWdjcsSRyD/U0t1c+h0LEzNxaD7P6QbI
         i5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWmzpgvZ2SUeyprUP5fXFpyBh+7dwn49R+ukZHZD26OtBVXbe5bZ/vBm3eHAcL8FbzUjXfzHlorJZ9RCSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4fHqolSl7ouSLUtZVA885Y75WrfqRmW7NrwgpXXBf9/TyTzW
	PPG91IzRklQ7mm7uKZx0/fVsdIreiwSmPKPTCV4qCFtzuH3AK/9UM67u3P+Q+S6ASh7gaxG8uUI
	zxpKg1UJez4PqBN3VqBxI4iToWaX+3pjM2NmR+v4uLz2Php3fk7LLnpm9UfU=
X-Google-Smtp-Source: AGHT+IET9Cr76nHmk//LV8gw9J+v4ljkYY1xJCKvXaw3vTmLAsHsKlCV3LVdIkA25kiivQTlpO6tkKO/5lihCfc5MpbwIxy3lKj7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c9:b0:91e:c3a4:537c with SMTP id
 ca18e2360f4ac-93e7642bf79mr3736467239f.14.1761297423663; Fri, 24 Oct 2025
 02:17:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:17:03 -0700
In-Reply-To: <20251024071155.pT8us%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb440f.050a0220.346f24.00b6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extents_range
From: syzbot <syzbot+f2107d999290b8166267@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __ocfs2_move_extents_range

ocfs2: Mounting device (7,0) on (node local, slot 0) with writeback data mode.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:1365!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 7289 Comm: syz.0.17 Tainted: G        W         syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 82400005 (Nzcv daif +PAN -UAO +TCO BTYPE=--)
pc : ocfs2_block_group_set_bits+0x44c/0x70c fs/ocfs2/suballoc.c:1365
lr : ocfs2_block_group_set_bits+0x444/0x70c fs/ocfs2/suballoc.c:1365
sp : ffffff80cb35f950
x29: ffffff80cb35f980 x28: dfffffd000000000 
x27: 1ffffff019f28001 x26: 0000000000000002 
x25: ffffff80e95b4d38 x24: ffffff80cf94000c 
x23: ffffff80cf940000 x22: 0000000000000168 
x21: 0000000000000001 x20: ffffff80da545e80 
x19: dfffffd000000000 x18: ffffffd01197d7ac 
x17: 00000000fffffffc x16: 0000000000ff0100 
x15: ffffffffffffffff x14: ffffff80ca764f80 
x13: ffffffd01dd9b000 x12: 0000000000000000 
x11: 0000000000ff0100 x10: 0000000000000000 
x9 : ffffff80ca764f80 x8 : ffffffd01198f8a8 
x7 : 0000000000000000 x6 : ffffffd010c7ba54 
x5 : 0000000000000168 x4 : 0000000000000001 
x3 : ffffff80da545e80 x2 : ffffff80cf940000 
x1 : 0000000000000002 x0 : ffffffd01bc8af10 
Call trace:
 ocfs2_block_group_set_bits+0x44c/0x70c fs/ocfs2/suballoc.c:1365
 ocfs2_move_extent fs/ocfs2/move_extents.c:695 [inline]
 __ocfs2_move_extents_range+0x1e74/0x27ec fs/ocfs2/move_extents.c:868
 ocfs2_move_extents+0x2b0/0x750 fs/ocfs2/move_extents.c:935
 ocfs2_ioctl_move_extents+0x3b0/0x55c fs/ocfs2/move_extents.c:1067
 ocfs2_ioctl+0x2ac/0x10c8 fs/ocfs2/ioctl.c:946
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __arm64_sys_ioctl+0x148/0x1c0 fs/ioctl.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:36 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:48 [inline]
 el0_svc_common+0x1b8/0x480 arch/arm64/kernel/syscall.c:155
 do_el0_svc+0x54/0x134 arch/arm64/kernel/syscall.c:194
 el0_svc+0x1c/0x28 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0xc4/0xd8 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x168/0x180 arch/arm64/kernel/entry.S:689
Code: 95bd6322 97aad992 f00517c0 913c4000 (d4210000) 
---[ end trace f4492e09a8a518f9 ]---


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
console output: https://syzkaller.appspot.com/x/log.txt?x=141c2d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37e065cc9b6362d
dashboard link: https://syzkaller.appspot.com/bug?extid=f2107d999290b8166267
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11982d2f980000


