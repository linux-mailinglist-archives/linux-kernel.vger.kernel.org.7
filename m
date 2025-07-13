Return-Path: <linux-kernel+bounces-729042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B78B030FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05C7189B5F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23257231A23;
	Sun, 13 Jul 2025 12:20:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6A1F0994
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409206; cv=none; b=MfB0Rm6uKjmTPpI+Na9lKWV05TZ/z+WzDI5JC0MS4I0alI3wIqt4hUvIiXTJjkPlouGcz2wT26y90eihLHzBi1LcCR/v80H6DkicPySiQYf0jx3Ut9F5sTTItbS6+z2DNu3hGTU7WBrM8RbbqC06JZctxGzwAQnZ6D5dVIUdiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409206; c=relaxed/simple;
	bh=4TLGo6GK4QSP+WPahMdSl6hUqJJNrHr+VZrospIkjj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mlMxtqqaQfT++hlZAyNJ31gXlilGRu+6OekgPbxVz+B/xNsro0aQrK1OfE1yE5dn/VtNe2HE/6HKPLsavE0H2xX2vf9/pa6GJiDaFvoKEPyByev4iN+7n2Px0FCAPi9jYCP6utJix9wZCoYxxhZY/WGCdnPFs/f12Ks+6TuoVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df33827a8cso78959385ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752409204; x=1753014004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHfZZYwlltX3cnWzSRwgx2BtUxjdDvi1oy+Wb8i2L5c=;
        b=BBBBe1kc5GEbEZVUWTFeodjTaYx4Qz3226d/ScBd7fH9iEFb7lL0jKuSrvmXjl1MY5
         7lhECkyqdS9ClBO7Y2JXSeLHsd2cySC8TMhGREakchBYqzakPR8jzz1H5FFuZ4JDVAM6
         OZMGOYN3bh3z07BSshmPnddGsbq7AohbI5JRPcnkPm59iMlwrssxXY9lphmTUgXMRINz
         nQC/+O6xzsfV3vUGRS0f1Yk4/Dufafyu1yB9uJjkVeNiPvo4BLUvWMjTuvxdiCXcrgAQ
         qnuL7HhOkUFotyKT6r6oAk3+YoqaBbTgFJYkO7f3A+rZ3UuM969DrNkRMRuamtmi+dKd
         yVsA==
X-Forwarded-Encrypted: i=1; AJvYcCW0X4HFg7wha6Ohy36s2rwdoGjSpW1rk0xJ5vr5InCIEu6lfXgQJ+eDTkwA8j1Uj6TrODkvfcR6w7upkbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHx2PS2oexuR5mLfFNkjUDAoF+ZSPszd5r+Lfz8E8KaEQjAGLV
	6UY5UWjeVGj4ro1ADIEOR5YlYseb160x1/g6bGbXpZ0khRqzF6bvJS1d7Sw3SBFaQKO+v5DnsNX
	1gGxySGKN46G+KZcoibHUo1qkXWdSw8nf3ShH1k0aYL34Pis9UrZfqRQHZtk=
X-Google-Smtp-Source: AGHT+IF2Exx2IUNfv7fdIrV5sTW8rBytOis0b7TGzJm4zo9XvFCq3New/6Dkvq4Mr7o0fywQcedS34O/GhHp43TJvQ62c0w91YUL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b85:b0:3df:399d:39c9 with SMTP id
 e9e14a558f8ab-3e2542e803amr113121025ab.2.1752409203286; Sun, 13 Jul 2025
 05:20:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 05:20:03 -0700
In-Reply-To: <6743b30d.050a0220.1cc393.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873a473.a70a0220.3b380f.0031.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_update_nr_hw_queues
From: syzbot <syzbot+6279b273d888c2017726@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ea5d82580000
start commit:   a52f9f0d77f2 Merge tag 'batadv-next-pullrequest-20250710' ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ea5d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ea5d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14321d82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179590f0580000

Reported-by: syzbot+6279b273d888c2017726@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

