Return-Path: <linux-kernel+bounces-768800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6AB26599
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1605AA221A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92BB2FA0C9;
	Thu, 14 Aug 2025 12:42:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC12FC879
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175347; cv=none; b=j7S1m0Ycve0lqvmTlq5tRinteBc+K6Xt02RKsgYQEe70//yPD95I2OawFY3z9uJZdYjtOpl5iNdDvoOOux7ifXn13LetnbBlxS3I50kt1Yp7elXi31gAFnTVEin8q8LmeMIkCAtx+5H2Er9Cv8G0H43EW1kN8GD72KP1bsA2urY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175347; c=relaxed/simple;
	bh=k3yPg1aAQpEg1eCIUY+jC9DpHpSaMpafiVcA2bYOd64=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t6Jvf68+VVFIa3EnZpQN7H4UGocuH0TPCHIaMT8+dxEr3mX+sWK2/f6BLbqHBF6ixcM9Va4H4mHGCPaUR4mx1Vh78ferL0Ml7Uo66JTnzTbZ4rfNy9zDYDMUiU1VueGm4cO0f/9CUq+QlXEqPMgpFuRALGfMFw6wWFBRdA81FDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432cebd70so211459039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOEMLRawprqNsHkZ2jpgpNUe0GUGeALOt5V9z9tksoo=;
        b=EberzQ1mW6+fUx5czXJ/6cmJwlDApadd/ZYjH3m38Yb5FdA+Lw2UKTFLRBO7kvaN3Q
         ow8fBYoF8Ef9OIur76zOjjZgqkZ7LCJhSDQBPvTQhecXTkZvf1dBX4lZgccfcDKqsDZO
         fu0Q8+V0kGRxysWx4tx411tWAixT2o8KWhW6cKKMlQtJq/OQ1O1HgTmzorOkpm8T0dV1
         Su1dIJ/r+JDfO7D5V5EKLIekRn1xi1/X3nOI25sQJ1oHEFCqlyVFzdFCEw3iXFzrFSA3
         nPK2unRs9ErcZRZtzpjVX7Tt7qlTJF3KSMlCvg/gdn2IUlis2nCyp1NmwqBFSqJcW456
         wHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBLfr+mkiyRohVM+EFwDmjlbEULYHA9wX6ZlKi0KczKsE8mybQWmDKPC4oo7AEGkQX/o9uZzxD/Aun86U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHKqM8e7TK4UDWsXXrgvgYl3uTqtrsIjMbm/hfytrFzZZw/I+
	8qYJwgg7cMjjqZKZ0ZHELKANgPr9rsYAkzjVheoAWZkLsBICT9TZdRLl0M4F4O71nSFFcCiYATU
	UVUwIErIiR27RXeD6xwO4a5UwAp7aesJHhtXMiViu8YU0mSM+KdKhzQgY6X0=
X-Google-Smtp-Source: AGHT+IESUCWjgOWranWO/9Wcv5CQpm+Eh0DhLC/rNCD2k49jxG4ZzIVxpbTlLs9aS+9zhnD1VXoLthwVFYrgzh3wihHYTFlYwUsE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6010:b0:881:8a58:3bc6 with SMTP id
 ca18e2360f4ac-8843382a70emr547983239f.8.1755175344833; Thu, 14 Aug 2025
 05:42:24 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b0.050a0220.17479b.0005.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2025)
From: syzbot <syzbot+listf579ade1619e81d82873@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 2 were fixed.
In total, 23 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1397    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  367     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<3>  303     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<4>  237     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  56      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<6>  55      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<7>  44      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8>  33      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<9>  29      Yes   INFO: task hung in gfs2_glock_nq
                   https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<10> 27      Yes   kernel BUG in qd_put (3)
                   https://syzkaller.appspot.com/bug?extid=0423714c06c369318794

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

