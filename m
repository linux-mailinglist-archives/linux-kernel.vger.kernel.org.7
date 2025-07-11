Return-Path: <linux-kernel+bounces-727554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F7B01BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0F47AB980
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AE2BE057;
	Fri, 11 Jul 2025 12:27:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E029C35C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236824; cv=none; b=q+nJDUeA8KbkSY1Kb9WymYoflT2b9XGqiebMHQMfuF70i8ceDOGUti+9TR6SiiSXXqymZo5T9gGx2ANHmB9ghmq+SF3GOTrf1VSipdB8m6x0Q86ks1QTbYRL2m0ImyDsUuTy98Y/SKongkopUjFWFLitme/M70r/jQMvboe29IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236824; c=relaxed/simple;
	bh=5RThLuz3tFL7phwFf/QiuipK2M04eM3fXnIvO+PM6js=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UeH0dQ8TDTeKDv7m1AleoAn2H4v1nbl7LgaSefZxxFG901dAIWPYRHLGgwJqFVm8OZaLeHz4zC2oWxfqP+84jmLCrDvCznvClm2UDuPmC67X1fLx/FiiITX9ImwKe/q/pwNX5CiyOANqrdJAEra+IVeMVEF2ufTRRqNoeCgIxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8760733a107so235057639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236822; x=1752841622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLiCgbUvpuHgSzedG/d0dkj2/LzDFoEPV2dlBZwd1TU=;
        b=VwOX/38SaqstzEteI/nnARTe9L0Pwyf7wVJ9Ipb8w/s/jWXCBehpWlRrOE6fsQgBwS
         Lm7jx6TQyRYg3TTFKSpW+zdyfnlDv2DhMsZnZEipL+mtzDfMTLAFGc1LgAbifV85ZuRh
         eMM4VKVctG8HoOTeVRp8S/apMWJw3sx7dSafVJdeHCgt7A4vNs5BalN0+1nEE9qCGK8V
         dBvXK0WcRwTLXIeDjpQtyn/X8A+/S/z+PCZhNL17QlJw3foSiSSpxUxziPCe14mG4Mgl
         5ZCxz7EM1tiwUeccSIB4KJQqzc2Dm6yNWrnNuIwkiFV6nbFUWuM0UJpwQZt/xOYhYKVg
         lD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG4jnHvLu9RaZtS2TvgAtN7x9RFRy2/jV8ALF0OfDPTgDFRRUYKyxIKZeHqeuXIjYwSPbEYlAuIa74Jto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyhP6+Js5c8Vfi4UVzq0K2zapcZBT6M+2t7aNyFRqnT2qzghs
	SlOUHC2JXEAuezJKu+G50qnPpq6RHD0hZvq5WmBhI56o/ks63E3XbJYX7VeQMW21Z18z6LMa1Pt
	dCYMRE71c3tSnr+t6+wLgDjRIswaTKygw/MtOWTtRSftPNeUG//NfYFFzX2Q=
X-Google-Smtp-Source: AGHT+IGRhMJOZvny5MX2PRrEbROR2nl61a5ERscS0MwH2MJL0/EaCuaUyH5lY/Hs0+U19HgsshuS2Lmy22Yo/U4JhtOYqknQ/OW7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b90:b0:86c:f2c1:70d1 with SMTP id
 ca18e2360f4ac-87977f521e7mr361411839f.1.1752236821815; Fri, 11 Jul 2025
 05:27:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:27:01 -0700
In-Reply-To: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68710315.a00a0220.26a83e.004a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 77eb64439ad52d8afb57bb4dae24a2743c68f50d
Author: Pankaj Raghav <p.raghav@samsung.com>
Date:   Thu Jun 26 11:32:23 2025 +0000

    fs/buffer: remove the min and max limit checks in __getblk_slow()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
start commit:   835244aba90d Add linux-next specific files for 20250709
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

