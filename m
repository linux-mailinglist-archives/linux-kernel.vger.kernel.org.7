Return-Path: <linux-kernel+bounces-865276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA552BFCAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A86506FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3334CFBE;
	Wed, 22 Oct 2025 14:49:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2F34C98C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144545; cv=none; b=py2XZxn3w6bx4EmnxIXAV6oZeVd/GCzZAeho28I9p1cBLLxYbeh5n6Naegbgl8XWqnNRAwrW3eL7iNuLpOMwA9LK151K82DymuDuza9WkomQ2lsqqztkCPPTKVznV120eSwDQydBImPSdE4GERZBVzOG+TwKViEg0E5XBQuV2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144545; c=relaxed/simple;
	bh=yb6ko3uW4fBXUIWtO+pl6/cCimILqSsHghzXP6Lw7C4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mKPt+gWe5ZPTrwH4Fy+7TDhwCESYIi4ziCHv0yoq+cer5ZP8gkPXukAlpJVFbUgpBqAZqLl7fi2skiNix/iKINJOQloP4hI5IJalFCGFVIO4K4YpwVn7bgxTdhK0+lbsEVDqzVAXP6yqsXie1wmdyzUfxOFUJmd6YMUgeExzGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430afceae09so76684595ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144542; x=1761749342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VMEaSXwy0tYSRLUSKZ0QAdWCYXERfWLTXr47ndAhog=;
        b=gp3rgpWcFFsiuUUpZ7pQejkkzJv7cpfC/SdN/Heqf6/umWs+W1Vt8xjz1ayTzrYXH2
         ClzL/t33kSXsJHrlsYMNVVDwuyzpu6oqeqlqxe8CFpHSZTatiwdyGoQhP1Ikaxzuy4aG
         LFFck/MC9qYp3ujz3WYBZC6SUpNSiPyuwsAYYvdcOlxlviCKg+QjaFM/VfDRYb6ftWyd
         J9NGb7mVSojHCS49aYnJj/OVOl6oCYFzv7uh2m0W1VaMqvSUcllAhraUjQSwXqnGyFt1
         wgSdeB0H4Qz8R5RBLh2HIOT/oL7e3u/s5MA05/WAd+T1Guo09OKbAWeeCNkCLVYpu2EM
         pXEA==
X-Forwarded-Encrypted: i=1; AJvYcCVshDdJ93yB3elZtBVcPy3d9Xm8KUwWhonJcYgdUmR3l7+HFuxh3OVNFt2z6FpjABRN2T8yqfOMnr6mcsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0DJCTtlCM+Iqw7oVEsr2XE5pGaJutbyYWqonih+/Up6yOjas
	+Wc3BLBrpg5YPuOgqEmU9zHMhO98pxo3fswncthiq7lm77Yxipa8KiulyVA0w8FuKQhXfHR8we1
	kOMJ1P+q+2nCz+QSmnOjAIr67Vc5E+9qoNhAzT7QToFEtpdSLjYB57shOAjA=
X-Google-Smtp-Source: AGHT+IHAtnzh9M1oLX2r3WevE1LAmEhz8gMuVWy9orCDRVPOqOQCMlG3hx91ns27Tkw62sK/0WJGQAmoMDPHjwJkJQiB+UTa4tGE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:430:b3e2:a96e with SMTP id
 e9e14a558f8ab-430c529e627mr298565905ab.28.1761144542568; Wed, 22 Oct 2025
 07:49:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:49:02 -0700
In-Reply-To: <20251022140056.5Yda7%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8eede.050a0220.346f24.0054.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extents_range
From: syzbot <syzbot+f2107d999290b8166267@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f2107d999290b8166267@syzkaller.appspotmail.com
Tested-by: syzbot+f2107d999290b8166267@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c6ce7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9a2ca2a8964bd4a
dashboard link: https://syzkaller.appspot.com/bug?extid=f2107d999290b8166267
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ac4614580000

Note: testing is done by a robot and is best-effort only.

