Return-Path: <linux-kernel+bounces-732699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C186B06AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA701A64902
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42A219A8E;
	Wed, 16 Jul 2025 00:55:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B644EACE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627304; cv=none; b=tMOpA1hSbf1xzMIh9Fb1F/apFIM28v2bs3k5D5pfpwDuCKheen3HLuOgT1vVokC35krimVEeezHMc6JmK5mqI6SmPi4kt5nxU5vQ8O31bcPdsmo0utARWuIp8Z0lrAQMOWa9m4N1cPJBunjoLNma7rUgIqZUt9H7DmCUvTVESe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627304; c=relaxed/simple;
	bh=DP8GiTDr7LONFqWrhR2oRaGbm4kOyXlAQ88DKWR6cFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pg33UhRsNnC33VvML5E7RBx0IqovAyDTbjdvfLsCa1RgSrF0INo59IOUlWDdSrn73SiclU9fRrQkO16ucgkn+E/igDeBlUKjTo/6w7hBO7YUP3VMfMSkX8wy+eAaiS2V9JUegpIQKmfYtRfIQqK7dpDO6Q8MF+IQYPUpJWLsi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cf0364dd2so1098832539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627302; x=1753232102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTgObeiSF+es4KOes8znjLU8b3MFA9dVOpbWT9GtXpo=;
        b=b1Qsj/DNW0aVqnDklhYjOCtCmuBoItlxxN43frNXxENvSfYvsD5OPGxhbrXNLGgmiA
         X/D9p2WOwdqWEzy7Q/xQtWhCQ5AwuRSLIcsEwMSHusJnh1luxL74KADFZOtZG7DK7uUZ
         OIaBf/z3bBUCvaS7Kt4OUqxIGZP4aJRsTHm1oiJ6i1CfH5Pv3MoLPsignR4R6JYpADsS
         QJFrBzdQA3KMVJXpW9tx2E4Rv7wE/HgOwqSs7VrDt0nlZDk89MrMhD9f/9SS+ZRGRuu3
         GRQFvImMCNy/rLbW8+G+d2yDACRRMngwzu0mM0Xi4DgSsktO0cEyLE2i9b2r3u/I0pZm
         NelA==
X-Forwarded-Encrypted: i=1; AJvYcCVRMnIab1DLBhk71Fi6han0x+k7Hd8merUmyCMFVmAdpBt048hP69norhh+TzrLJNZB5LP8X9rNj9REsAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D8/7/A0RYDxIc4GHqH2J+X5MomU93XxwS+6JB7zpo1PWtdDt
	NhvzVKMUhM9vUss2Wnu0NcazbicNrwNesIjbebBo4N+PMr7e1UTNOVz1UDdMB/Gd1KVgEK4yhVU
	Xn4iqFjraXG52MJGAmv1HZS1gKt/ScM9QHHoGPvOpB8Y+MxAAoXu1nhvuHSQ=
X-Google-Smtp-Source: AGHT+IG2Ujec7AL48oA6oc7jrWfZ15/MNGS1ftRczCGlyjHTpMmlvzXzUdU+nJUgpJca62iKOILg8FGu2YvBLz1oL5ZxoVIiFUcI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3e9a:b0:86c:fae7:135d with SMTP id
 ca18e2360f4ac-879c08a24cfmr204755039f.4.1752627302333; Tue, 15 Jul 2025
 17:55:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:55:02 -0700
In-Reply-To: <6876cc3c.a00a0220.3af5df.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876f866.a00a0220.105e77.0001.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
From: syzbot <syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1d2fbaad7cd8cc96899179f9898ad2787a15f0a0
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Jul 11 11:40:05 2025 +0000

    tcp: stronger sk_rcvbuf checks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b7098c580000
start commit:   55e8757c6962 Merge branch 'net-mctp-improved-bind-handling'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1077098c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b7098c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2a6ef56c3805144bf0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12494382580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103327d4580000

Reported-by: syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com
Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

