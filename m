Return-Path: <linux-kernel+bounces-870318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7DC0A736
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C562189FE71
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225852D9786;
	Sun, 26 Oct 2025 12:34:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AF2D8766
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482047; cv=none; b=TbTGCVGBB+zUecyTH07baXDvPS9ogjWcL1Tg15jT8guJ7gFM9iPk1bHvN6HYoS+WlVk1e/LE0XqlTrGr9wsBuCIRjHPp//ZhP7I1F/017V98BcJXSegxYFLamaIeNJaaASYAsRwaoHrjH9aUpgkmttEiTCnvqP/3LXDt3+EMww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482047; c=relaxed/simple;
	bh=+nxtf7ij0qhU8CI7665GsgAD8dfCp77GIF/U1qMP2YY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F0qlHJV7CGv6yFg6XdbOKWZ8VZ25CHk3PViGDkUtJGGtpLjHUjdtJv4MqPZ982R3hRfQlY36Ma+2ug3UI1VQIn4tiRyYumA/ZrcXEA95GKX4G4KwIU0yPQNasVEQ/9IY22jYv4B/t45JaqdbbY4GEGhbFURvt5fMvQbuhTnF+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d0cf9b85so147729625ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761482044; x=1762086844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHDblXBsE1UZWs2606MJEfEsqCX/cuuCHll07I2k8ag=;
        b=KN6Gl6+Hw7jXsKxeS0Gc8nc3XntxQCXg8bqC7U1K8EWsOfzjRhmmJVxhLSY+jBgXu8
         P86lPcykl0kX5POKs5kKCdMBHzzsBwCsqZBG2aqckgbPF7uVB0OWfCeM1RmYyKNVljIG
         tlleJ94QM9XvCa7YUROsK0Y0Hn908dzJzbYH+reaOHCQFiyvCJUlJywnTwpXkw1dM3tC
         8kDQ0V7lTNwnfNv1nSJeO0LLfwEQDf2CftUxJCwxFslbfnWiaWiRXirbGTpP4pQuoS0T
         Do7+LrSzzhllTR+E15FCw9w3q3n3GyE45tJg5E8I7E8EjKLYLx0Ce+YVyYayQ++cLAni
         cn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqn5hi9dLeLJguslmQClphfIGL7JxjkWa/K67HA6s4LN6qPujHYTBVUrmvp/tkTyOnwwWsX4SQCqPLRFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBLlupjZlGgpUAQH3H8KjWeIjmpcCQkrugNqdlbb1ygbHSUWG
	8pucI1IN+sSRgYsbSM+YAHLVKXzWJE4g7lbgplneDUzVfn61YZrCo6/TFQ8ABRNzrvVz01BEeFa
	TxlLwPmoMku1gkUXfeviMRk749WMjWA3lJ2dOYbbUsIuVCTfP6fbSznaGZFg=
X-Google-Smtp-Source: AGHT+IE7q41PXUXRqzY92VxJEzKN0XCUkUwUhi2cB6I9TQqlZB7U86i2EMFdTfVhysfNR5TIQFuUc24TtXOmyd76z1OVLUWYKt3M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:430:ab94:4223 with SMTP id
 e9e14a558f8ab-431ebede78cmr96792685ab.8.1761482043962; Sun, 26 Oct 2025
 05:34:03 -0700 (PDT)
Date: Sun, 26 Oct 2025 05:34:03 -0700
In-Reply-To: <6716f9e2.050a0220.1e4b4d.0068.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe153b.050a0220.3344a1.0090.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in extent_writepage_io
From: syzbot <syzbot+9295d5153c44d86af0aa@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loemra.dev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit cba7c35fec267188a9708deae857e9116c57497b
Author: Leo Martins <loemra.dev@gmail.com>
Date:   Tue Aug 12 23:28:27 2025 +0000

    btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ea5614580000
start commit:   6efbea77b390 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=9295d5153c44d86af0aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c18c5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12186f27980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move ref-verify under CONFIG_BTRFS_DEBUG

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

