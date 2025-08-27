Return-Path: <linux-kernel+bounces-788241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64654B381B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FE168A43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E12EF654;
	Wed, 27 Aug 2025 11:48:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFA1EDA09
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295286; cv=none; b=aNxHgXFHXKZBfn4Tpx8Z0B4En5BJ/Ie2gzJMk0T6+xwVI/L0wuy04lIDxE8pp9HBy1VY3ttyGc7XABlSGrMD8DeCY2OcqyB31XuzAcKf2c9XviL0jw9vBLzVKXtGv2LaGJr0cdBL6Tut5JAIELxiHvAd1ujjxdQY9V7awdE3tUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295286; c=relaxed/simple;
	bh=Lzqw4yG5X9adYi13S+ZqlzxYQJQeGeqenG10o80I6SI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nEIQMRSQqbi7zGKWBdgn/hZ3BYnoHPjQ4M4hlPPtXG6NN5JR4LlFr9PeXTCE9Occ1Tk6p1iUxmuOBT7dQ1zVt+kSt8CS8hnGbvyO+VmztG9Y71xXhARP4K2IeXxEj19vMikn4nlykOFchsGWKeeH+pliQXFroM4BvZUhkwh96eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e7172deaedso68531195ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756295283; x=1756900083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ1/bK8yJuj3TaHyHUCbcxI3lfRfPuRfA8WBcc16bJo=;
        b=OxnEmqhqq/JDrdTDKvH5i9SVQtHTtO07Rj2THmCReuJnGY6xex2tJcC6DKdvBlghfl
         ZevvGs2xRlulyGFE1OoAIb2SgD3/tslqt5balIZ6t/WeVS+jnd4ODH1M0hcH/8u6lesS
         qaCi2zV3pRxjE5+pf8iVeJEHGmKeSfbKK7lQlmHC2QHuLTFQgezexIA+6D3ZVjZ248Z2
         w26DNi92CbqCcQkW4eEzLwIJVFLPaxqK7hTyH+pDsbkO049Wm/ITVLWyUGHjgPpaqI2d
         pMNBqCXtB4UZAn1CO7el2SVCPSFuOOaCVmptYPiWcqZ25Fpqy2N3qW6Ats2/5FR3fZHP
         Me7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU09HVZQ4CyjM2/8D71L81vttQ2vImUSUZZ1q5ha7jXC5thbF7afa1/+5Vtv84KPItnZaupjtNRaqh1/Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzr/tN/4mXRCVcFDaKdq1xxnY8I1b4B2XRyoDxjoyVehxDMmNb
	4PSbnEp3N99zrqoQH5sBczekupwNgPlDggFQ7W5mr1tVZBuN6MYVRQit8XsSBKMY6Re7Xoc/fEc
	wgp4at/neFgLb2lIgru5ViVrICwQvDx4rlXtK/VkmrgW5J148Ql8YRel2b/0=
X-Google-Smtp-Source: AGHT+IG7zSCyONoBYLgMaD31XPpR8A3Ror9QCkbbyFgQDgQipd4PC3aofPGuUJzihgnqFK2WTiAbDPzpx+ndoEXX0N4NrCQjA1bF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:480a:b0:3e9:4547:5e03 with SMTP id
 e9e14a558f8ab-3e945479d7dmr226052015ab.10.1756295283748; Wed, 27 Aug 2025
 04:48:03 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:48:03 -0700
In-Reply-To: <20250827110046.5887-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aef073.a70a0220.3cafd4.001d.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Tested-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com

Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14023c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d43c42580000

Note: testing is done by a robot and is best-effort only.

