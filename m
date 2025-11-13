Return-Path: <linux-kernel+bounces-898638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA51C55A26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F203B0DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EE296BDB;
	Thu, 13 Nov 2025 04:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6B2868AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007604; cv=none; b=KzGOKVZ1AypY/2YlUtpgrEbMFxrhGodCkic6y3X3jjdT3TSx0iFCz3wgQpmzofGkSQAZJKYSsQ5ZFOYHCS9gkqtiBzsKSFwAM7k3jl9aqktKk8mDqS1b9JSHXXgebk+37Ok8apIJEJQ/bv6yS1gDAsRD8UO4PCUgd/ohmWNYCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007604; c=relaxed/simple;
	bh=k/0kEvRwiH7bBXpnvDYNPOKCsHvB3CQ+ZZPEIxQQQRs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iUsP7vh0C2z0YXSYFTAgkQ3PioR3uRouhnNxbTDPN1YP9sM1fTSzkaQNTmIupjqV9H541JaCZfHAYolEPQc60LvnPBz5ZkpwJNmpPwQASv7LEJ9rxQvJEZD2mYRANcjn5MtFud4q3IeB0cdGmxHxxWC1kQSlX/ZmK3XkAmB52hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322fcfae7so6563535ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007602; x=1763612402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwwuGB4Z4w+XRQBBqMFmm3nkDa/zA7nrVh1VUxbkIh8=;
        b=Jt+N+iPtmwqYjjhtntVT6BkxgMBFeKwBXWt7QaDwzGKkJ09sbYUrQ2Jv4ROSsIHIHM
         E8kimL7LJllPMeT/8nkQ5uYTHMzvLpptf3wHnONoqfl26SjTLP6Lkn7UBhPGUGESaa3S
         cFQBjihhH5QsEML6wnA/xQrudeSw/yKBK1P6nO/lhgbuxsHxNvS/lKxeQbG3pl8L+QV0
         SifzhnszF8Hl4it4+hP20g+sU6g1nas0Ynx/7VlNvD4NxJycmti7W9D0BIrGih5xvhtS
         9VXRvhfEQyGF0oNsP5Fn64WZX4T8Xj9neihlwSpShv0gZZpz6HuhRAy4uSuUZAVA8K9k
         XuJA==
X-Gm-Message-State: AOJu0YzEL0uTgP9IZZ473kNk+vH95H9hjS7BRf8Q8lwm2+4Nqu/7flR+
	bdNbtdrxL/mRyj0Ij0HWrNHGRhpQwuPTtygUPdcyOEWClgkXoK40W9a9Z2vg1Xs8e4ZNG5FDmBu
	l1eXKCchUVt+a0ylHjrr0lOzglz8rWSxt9bpQQUEyyU++Sh2bOw/BOlRMIeI=
X-Google-Smtp-Source: AGHT+IHxI73JD6XvaSh4kZYLe0xeLBknFYGtA4J1Kx99Me971Dq3NaR5K3OFMmXpTAVW4NErQTyKLzcJQbG/FMy9pXaBKSrW2ism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-43473db48a9mr68352265ab.31.1763007602388; Wed, 12 Nov 2025
 20:20:02 -0800 (PST)
Date: Wed, 12 Nov 2025 20:20:02 -0800
In-Reply-To: <aRVVLrFguzGI0Kbq@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155c72.a70a0220.3124cb.0015.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com

Tested on:

commit:         6fa9041b Merge tag 'nfsd-6.18-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f8c658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0fd60646ed018d
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1666360a580000

Note: testing is done by a robot and is best-effort only.

