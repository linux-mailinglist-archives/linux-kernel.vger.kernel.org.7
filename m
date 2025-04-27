Return-Path: <linux-kernel+bounces-621902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C05A9E015
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44A9188F473
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8A24169B;
	Sun, 27 Apr 2025 06:48:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAC2356C3
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745736484; cv=none; b=MYopHTREeudLIJKp18fa2uxGG3NFQ8EcIrAOUoMHjgmtRmN9Gs13J9aXR8fpSK4nfUxKE5FYeLGAIoNc2OwpoyNQPm8JtdL533JkSZkszXnZ46m28B+mjtVQ33ldnSpwWOezuXFR28vz56gMzPI5YxmhXmc97XH+yel9gnm8klA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745736484; c=relaxed/simple;
	bh=p88DkVDoTPjuTqQQlG+Crm/jbbCAM1qWyeBgoyWbuUE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pRcNSKBTdLNFhdAPqng5GRe4fDRTrz+SPXQJQpXhflCDnxs7ZAgnhM1OtdLW1BqzxtWy4+kfGAB5t9VdgSgAoiPnuRd083bXaU3kmdjnPs2R/T38spBlgfP5qYjT6dqOrmKwbWi2rED9My4X0ys5mGuR36zv9mww+0F9q141adM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b53875729so777767839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745736481; x=1746341281;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cgW6uBbOB4mdKLaE/LVEhF7fHuoWU2ZxxEGkC6xgh8=;
        b=d9l9SJbB6xIOXpxNUB3Zlv8xvuugEynnc2sjuVvZ2O+lJflB3ONy9HAoD2cldM58Iq
         y5souHCNqpq7p1bgSifiqZadYa0IySf9Bw0k4zSZduaXCMn7efQIKSwS6d7yhg7dbc8Q
         y/OJ0J6FkxfzSZbn5oNoTt7fVv4+tUlkBLoQMD+k2ammx73Y+IkAPtd4y8224y/t8XYd
         F+c7jecyUgkAtU+brZnw6twpoey7CsjinLQEZuA3A3kl5Jhmy0/5QxJw1S60Cp5RlcXB
         kFDKg+iaNtCUkOWpUqoJGL3VSNRBgOlYVRZrom1qMtvhS8XxHDQn8BFTZ7kliASwjWEw
         pk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnyNS8J/RdggSfWkOALLOhMSmk0G7OR77HGgZWrdJkOYT3mSW/3zsInoQSbrkW0VBgmvBH9Mo4hQ9x5n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8H0VFnYSNB9E6ZcU5AKli6uqWv1/WPd00x8/cQGB5OTXgGU+7
	vItVfGItHgjo4uBf2hff5m50aH4Db1ncVWZLW8pR8t83TaGGesEWbI1THOaY5NXS9Ru7RX2VjvG
	m91HMSEoS2u6ToXy1SueT7EQBKRpZOzEULYUtGbTWVZ6d2NXuU+t1EeI=
X-Google-Smtp-Source: AGHT+IFZxHbHZqfLbHDOKYaG7Ff5CiIUrZRpktLOBK3sdBVN9mw/Pw8QIL0euv+laP6sEOIPZkiBaBpKrpN+PvhKek+JXIVCVjNU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7288:b0:864:4862:91a2 with SMTP id
 ca18e2360f4ac-8645d224272mr726398039f.10.1745736481792; Sat, 26 Apr 2025
 23:48:01 -0700 (PDT)
Date: Sat, 26 Apr 2025 23:48:01 -0700
In-Reply-To: <6751e9fb.050a0220.b4160.01e2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680dd321.050a0220.2b69d1.001a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in check_extent_overbig
From: syzbot <syzbot+fbc1f6040dd365cce0d8@syzkaller.appspotmail.com>
To: davthompson@nvidia.com, ilpo.jarvinen@linux.intel.com, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiangrongl@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5d40a8577559250029ff571de38ffcbc226a63d7
Author: Xiangrong Li <xiangrongl@nvidia.com>
Date:   Fri Jan 24 14:46:55 2025 +0000

    mlxbf-bootctl: Support sysfs entries for RTC battery status

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126f9d74580000
start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=fbc1f6040dd365cce0d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16804020580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed1330580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mlxbf-bootctl: Support sysfs entries for RTC battery status

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

