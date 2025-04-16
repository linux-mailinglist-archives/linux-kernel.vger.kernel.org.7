Return-Path: <linux-kernel+bounces-603789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AC0A88C39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD73A6A00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0B28DEF1;
	Mon, 14 Apr 2025 19:22:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4F26E16A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658524; cv=none; b=nWdTwrCSgD7eEMk3JW4wt/gn7jEbTLEvMp/Hio2/V/pxgMmuqfZbfJSJPuiTHBGHp1/Tol8GcCyYC8cMoJXMQMtRIunfqJ6EAXF0n35tm3MvJ8dnn7/VPRQ6+R3ssDzRK67o+/F73dSwPA9D6dFvbVegIdw910oyit8Ec/2TCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658524; c=relaxed/simple;
	bh=9xlzt8t5gZAIZhjWScRdd6YWLJYIILohHTFaHDvj5To=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DKnwFj3eD1S7MFEDVueYrg7cMoLOf6jaxe/x3OiduNWsb7quSORXtpohdmw6qCCJc9zG8kgCmeSOT+k0DRMMFht4V5vN/cU8D8NmzN7zB3XFQdFwm3xPcJazb51FD0llTZ0dkD/GZ0R1/fFO3tpaf5A00OpqVbUOnXxLie3ty5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d5d6c997d2so45711165ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 12:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744658522; x=1745263322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOv5Jk3XoSN+D2KFShSde9xzzddc9ORjMDXmV9hyXBw=;
        b=Bsr3IbHWQwdORiPmcsYZoeJp1Vc/n22oZ5ddP9ik8K7n9t0UaXRcq0mRm/Hg+VUa7w
         fNnYzZ3SBnM5Tuk1T3Y2YgadWbCld7rInER/aN+VmNUr/0RlVtKRwC+JkOpBEkLdote3
         k+RXEkJOXSEpF6YyALtI6MfvHprtpFPbFolTjkUexntnJALMIQIvaBni1JmZ5f1Bj0XV
         MvgHDZrX6n55rMml/MutTbnoWDZgB0ZYJPsutazXb8CciYmE8LAd2qkCKnC6t7h+jD9A
         kjr7UfHtZXCdbWX9FJ1iqkiuxcJGfsYhlf42PeNQUmevUkoyUceBJh+T5Iey/niEgLtY
         v7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVppKsDbqACs+LoiKtx9ofbWpgqt3sTtgFnXS0rfSDP+x+vFpXYQvgr/VkU/xjKzIKeqayjmY4Ejm31dDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbUElgDp+7tDYguDAL1haHqDghL/5+iviA1MqnNbAf0uKJ0Uw
	ALQyLdbPVviESVm8ZKP5aDG7htLcWBgdaAQlzougZUjzAxn7qvGggPeYFEyOJvDeNrdU6QteOzn
	tXSsAGqxyNHU2T1tT7iX0z4Nms21ny0f57dqocWrjvxVdP39fRJ1izLo=
X-Google-Smtp-Source: AGHT+IGEmCZcdWbXVW3Yowdl+fqoNrFiXUdx+Br9L+lc28touHs15V4APFkQfiEPqaQnMiuIzgUE1JifdY5R6RYkv3+LJiMpQ6LQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:3d5:eb14:8455 with SMTP id
 e9e14a558f8ab-3d7ec276548mr118949035ab.17.1744658521895; Mon, 14 Apr 2025
 12:22:01 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:22:01 -0700
In-Reply-To: <67b1f949.050a0220.173698.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fd6059.050a0220.3483fc.0031.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in get_partial_node (2)
From: syzbot <syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, axboe@kernel.dk, frederic@kernel.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mmpgouride@gmail.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e4ea3f980000
start commit:   b7c90e3e717a Merge tag 'x86-urgent-2025-03-08' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=725322cc4ff5c53abfac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137c1fa0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0fa54580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

