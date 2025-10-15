Return-Path: <linux-kernel+bounces-854861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86116BDF9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15392401331
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A12D3A7C;
	Wed, 15 Oct 2025 16:18:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBD188713
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545085; cv=none; b=Hcmzl+pkTckV6T69L5fM1I03tetiLq6vrbEZxtT7A3tbC+SzKzkgqvmYtNLWWF6vHefqL3j0FC1X/9x/meWTopQH2sqcFBgpeABazTJHOczQAkvQCqPMznGqe9BLmMFqI+PeWdwcWBg0wW9h8LNuv0vcZr3hJQDFLlaPYznGTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545085; c=relaxed/simple;
	bh=GUcEvdj0FtsgnNgyRGtzZVtOTyXyZbSAOn/LtPkvpao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q5otxp1kR5+a9yRupt3dQeEIWmdpf9YgnF/05QWcnXHmZUv4ESZZsF46vTKpqUalBXlagNeKZhsQBHOrRw59Q0kgKXRZnt6DImA7cH5rGfWcHmR1OOKH1SkJa3K9Z7jeBoHUIp9e0dX5+dJDDRWlS96pucbaxFNttptByXmGCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42a076e4f9eso167075895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545083; x=1761149883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGJFF0h+Cc2HN5/SXx6z3VkQJkpMRG3pW68rP0Tjkaw=;
        b=gmUzuarzGh7TLFZAJyzVCGIeyC28jqbF/STt0FwrAYkptAIhbB9XYgzeatSLTSEQIV
         jP+s6ZKRNCWONzVdAiilCNnMOPImMDLc14tuuVxIOK6dOfRVC8WJ761Y9a1XDF/8hOw4
         MLi8V95xf4p3bR4p6RdtYgrJlbj5sql45ZRBXczD/YTlOr6v0pG86j6dUfn+7Lq1NwP0
         yc+B/zp8FKkP1u8ie07Eqyy76nIJogYoucrtH6ft9zH56OYekzRlQcP/l0xVo2efU2Xx
         qCEBQ5bR+QfMk5XwMG6aoJPjc885zZ95r3QbbPIgj/vtZI7grxMbwERP4SMIURlavw3E
         JM8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHiCh35wopNSv3mR7Z1Wu6VIKYQBp3mzFQhL3x1MZtVZfzKLsiQByN1naxI/Ls8CIosuD5uDRO1RRklG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISkNZ4vdh77pBZPOCgVyZaemuGLU00Xcyyc+vniAbFHbiZPDX
	kEZO/zdp7xBm3kFPPrLylrDMVQjNqUyOwhuiVr8PGARrH5tqo6isfjG3w7HobHeVE6NbZxas0Am
	+kFkBGiVqmOcMuOi1mfJFPiIwD1PAeNYs1juPXJRe/EeRmi+Vb7ic3LRNEWE=
X-Google-Smtp-Source: AGHT+IH1gLGVosl7lE82EyJiX3BM2ILCsIPhgICW8ikwAIwvMiF1cWkkZ0fFGtrU0XgZ3ZmpN+W22os4Rc4zhu7kAxaV8JD7deQF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:42f:9eb7:7595 with SMTP id
 e9e14a558f8ab-42f9eb7762amr202453695ab.22.1760545083242; Wed, 15 Oct 2025
 09:18:03 -0700 (PDT)
Date: Wed, 15 Oct 2025 09:18:03 -0700
In-Reply-To: <673d458f.050a0220.363a1b.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efc93b.050a0220.91a22.02a3.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv (2)
From: syzbot <syzbot+48ed002119c0f19daf63@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loemra.dev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit cba7c35fec267188a9708deae857e9116c57497b
Author: Leo Martins <loemra.dev@gmail.com>
Date:   Tue Aug 12 23:28:27 2025 +0000

    btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1176267c580000
start commit:   f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dfd130580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dfd130580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

