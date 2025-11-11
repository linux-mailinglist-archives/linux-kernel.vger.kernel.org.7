Return-Path: <linux-kernel+bounces-894553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B3C4B4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA523A4DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF57313298;
	Tue, 11 Nov 2025 03:17:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB422069A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831028; cv=none; b=r0IBL+EBseo8N2i2hmUHRvN2JcRZkan+Ui3YWmYRagwgx4hFo7v3et+Tn1PpVC1Zkz2nshsWM/32rrhC8304Wh67CaBYNpXUISn665TpXii7NgEQKr/Vr9mpOV80U0ASk2r/0X4EzWkVzLpB5DEUMaYq+ItEZl0OnL4M4oSMeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831028; c=relaxed/simple;
	bh=nWAdVnduhtg4arbgK1PLBi0J9P4uSdw3irLPI93TTKE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Er3WN9Pb2QEC7ojGFWfrFMq/VZP+59weFzV7dNJh9DiJmiQXPeQpyBlz4yEQTjesO5Lx5P1VHGCWwO+aBkjpGJ+ewh80JhDqx7jXyL3BpWklqJ6Qv9jQeQ6aZh+lM1uFqU7m3hYtU0BLoyn9cXzWUQjH5GNn9H7Uis9FrxHQUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9486f0954daso543544939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762831024; x=1763435824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e7/UG25kWgIqgM7+UJk7QQmXjwIltMSi+meRgRywus=;
        b=Yn4LnX5HOnwGe0/5MBynVq+UZzGfzQZdevv/D4ry2dsJzZm0wCH8xANtQDGpr1M/do
         W9i3SNW4yvEDJMIvpyUUxRj3xeCsiyLsql45FJR2nCcGrYQAKOsrtmb6ITnDKoxP9ARW
         Gy2GDRYnAvH/DRwUCeJCbYk1rir8u8+FPsINAxgKtr85r3Gqcqd8sCrSoHsgW0u03vdX
         qvOpz+Wh/VBc8AubCKbNvUdFy2NtQY6+8rSccXHAXjc58ZyGwpQOLVBGdJ3jaV4nmhux
         /R4/Pp7EBIm7xPyf0gxQMYe2rLJCySTGAew7dLtPFJpOd61vJzMl2NuMy8aek3VsRRlJ
         WuLg==
X-Forwarded-Encrypted: i=1; AJvYcCULdtJn4iLhMDCryRr5BrDNE3hCG1VCa+tpquuWjAakCOH3KZ6NOG/vzDrBadzpQobeMqjy/Nt/9QjXGbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4LGXyC+Ubv0O2BrJjK28Vq5oMPxcRs1MRcK3/FPHeXm3q2sv
	MoOtCD61XGS6j0WTvqllLWtGXIRAtkBNuRpsdAZ9lRylu/bu6DAI862+GLcrxBDiZ18muCKEjqA
	48MurmTP/NeULzw01Kd0mNid1zgTj3nbTEr29XXGiQTI5It5+42AZXF85gvI=
X-Google-Smtp-Source: AGHT+IHDX0otME7eeexqGJPKLS5L3M7eBy5GRavPUJH8xo8pA8lcL9JzgfD90X3rBsOZsuTCK7cuOmRnYd0AsGpufOP3OtVHrKwC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349d:b0:433:4ac7:13bb with SMTP id
 e9e14a558f8ab-43367dd8a03mr177160515ab.11.1762831024279; Mon, 10 Nov 2025
 19:17:04 -0800 (PST)
Date: Mon, 10 Nov 2025 19:17:04 -0800
In-Reply-To: <20251111013052.1801231-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912aab0.a70a0220.22f260.0121.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_listxattr
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Tested-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com

Tested on:

commit:         e424ed99 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14150658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1789960a580000

Note: testing is done by a robot and is best-effort only.

