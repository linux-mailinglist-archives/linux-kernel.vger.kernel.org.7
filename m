Return-Path: <linux-kernel+bounces-843283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F5BBED5B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357A03C00F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683624728F;
	Mon,  6 Oct 2025 17:43:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C591C84C0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772585; cv=none; b=IK0kMoc/KH5QmwRlGzqrOuVmsuW7Q9A/KC780WSaUb4qt+7k2HU9+NacLv+skDRVfu5jx1a11ifADYBP3CKj/JmMSQIuNyLWaO7r2xnqatbOXKullWwQU0YTtHPcYMuKr1+rt8yS+FqeXY8m5g25sY5MAcBiOKgo557BV5ZRPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772585; c=relaxed/simple;
	bh=LXjjNR8YiT5sUysx1u6pVdFJ9nMoKSj0ksdzXCTj+AQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=idejYujwK0aJqJmpmKHNA4Y/wxmSazcgMmJ04i5H7ig2MFJmCQ9C6AHc7Q5AlfvKHpdiFDBIoVGdNY2VaWOSi19oJjMcsTaZ6J1y4wQJF0TD8u9c0Pl91bEhH4KZV59R+4lCid17Doo7xbtuT/cxvzHR0RnUftLuEShnMA5p4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42955823202so81801445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772583; x=1760377383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nc5mddgG/7GKSnuUYngNJMFPRhvRMuy11+kqvkjDBTg=;
        b=jdKen/7xecW8yhAxAiqjvaungnzK8nL2+7W/DZATuTPLQ0b/MlPZazzzsYUTquXP2Q
         1yZBnqwzR6YA2o/qm2WLXFYpD6ixxmqMZvzd4tsuhQoK1zeJsNecLno83+ZUybVY/XWa
         S8cp5G4uxgeDCov5xL22I3yKawdjXhqFeO3UM78nNXgGRNl9txHRw3mR4o9/BL17Lk0L
         nqwBuUBJV/N3Ib63lE6pqgWSUnEy6tN25wQrLlXdoGKIPD3MPHsWBK7HugN2ZiT2Z95R
         HYJopWa8PhDsJrPRWAOeykb95zzr46cpu7F9pBxzbas8PFJqYpthauO8cE4D2N3Snpge
         BlVA==
X-Gm-Message-State: AOJu0YxTGVd5j+VJES0zzRJtidfLJe9xX/WmN+Hgj2QI/MV9Bt8Zfixt
	rwub/boX0tctIOm01epzvdnTHl/RgVQNmUHhVklN/MKcbdCRY+63JLtc1mB2x8Nj0JKfAeS+J1i
	qvW5cCHPdd4qep0Xlssq0Kg7P9xK9i/D1tTtGzScnaV4zWWH6U1zZL1O8bfc=
X-Google-Smtp-Source: AGHT+IHbK9EAR8pBAU45K8Co8r9b8itoLE1zLUQLE4JfCqQE9Ulr9MeP9Ume4PaqLudMPMHM/NWxyhED8QbDAF7661MSYu5Vt292
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:405:d8c4:ab8f with SMTP id
 e9e14a558f8ab-42f7c3b2655mr6188655ab.14.1759772583236; Mon, 06 Oct 2025
 10:43:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 10:43:03 -0700
In-Reply-To: <CABGqKE2yvE91xXt0SeJJ+g_SpSXC5mE70grx9Cb+GreJOApf+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3ffa7.a00a0220.298cc0.0466.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in cgroup_freeze
From: syzbot <syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Tested-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com

Tested on:

commit:         fd94619c Merge tag 'zonefs-6.18-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158af942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e2f942580000

Note: testing is done by a robot and is best-effort only.

