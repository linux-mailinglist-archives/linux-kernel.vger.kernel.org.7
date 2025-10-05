Return-Path: <linux-kernel+bounces-842369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7AABB9985
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D78F345C05
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1681A073F;
	Sun,  5 Oct 2025 16:48:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C394125A0
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759682885; cv=none; b=XyWeZQFUr0tFllURGqAGU5s/bz/y9upv0DQtgIUIVFmNOG+caiXqMT7uFtais2d18onh0/cF4/ryNcPFzwzmt072uTm6umOdd1wqhOkh3g29hbLjaZNcvi1ZP5hyfp0f3C2kXyEkDNCPCp7oQTiqh4H6rrbbMa/rvyfLuNdIaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759682885; c=relaxed/simple;
	bh=Sre91qC2hboHCxnN7N+ijsfJWRIunEMcehjobPut6dc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EHnuiJRr7epBmGog0gTttcxOSHc6AYtY5MHO+apGpzyjSa/Aroy4HDsmeBWkfFI6v/Jkkt72zJ0mtSabQ3eaJ2OD6DIVDNgR9Wl04sUXKM4MtZbo2nC+6uX/9E/fxTWMGTKwZbsTkjc3Put8DWzqawndNSWX48K+aaOFXQvbINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42e7b963212so88936285ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759682882; x=1760287682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oXb7PF+VeA+usHOd3dH0gngexRPKDP4LVXG0n28u+o=;
        b=W4Tvv5e0o+G+26+TgdYBiZCxHBmsOWRCNTbLmfERlEQVJjSixR+0llqCFTwS2RNn4u
         ovTxPyAQqH/cUNqmZW+jBe2Pyvm0MtSKMPDvHrEGueii9Tf0ZJY1Fgtc3m5xmbN5el13
         ggc8lDegy2nxiJMsCmOfMh3KaTihZTUzmp805gutpGlk+gBBOx2TaTulqmQLGtVAvUrr
         eVFmuIATAz2xt37AezqjVu086kY3GhJ+GhYvRNpg+/7mKdARZRmFwDVrnzVwcTEG6Bq2
         uAJUNgF+ChulZ+YjOkRTfJ47ATaiN2R6z1kTVFTRtZR0DcZyu3sr1LqxRCRwo8HFTxY5
         5QvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq4vVeR9iQHMA6C9zuXnFti4tqU3quhpV1MdlADwH9OJv84BET24oM1G/pgwCR91f9BQxG1Eqb5bVpCjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqSF4Iv7z7pH0pBpaTVIlXAN7S36JM1ljwBGqkcbhdigvIt7l
	MOtRSupe9eJc6RmvdScHtMHldVHtyCgXGPR8qBS3S9S3oA0js8b1HSY1Nkx1G8MiedQUB+jEIdm
	EF744pQobcKBTJTy27O8+4trqAzWRoNrNhvuciX6f19OwwhSPGjC01Qz36j8=
X-Google-Smtp-Source: AGHT+IEkCQ7HwtZExjkd+Qb0S8VnzVA/aRBL8f4/dZs9rBJbdo+yNWOfdu0Z6aWhrqDD2nC3xGGDlDmQTEMg1zstTjBzTHL4ivgo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:42e:70fd:f5a1 with SMTP id
 e9e14a558f8ab-42e7acfbb59mr158073015ab.3.1759682882528; Sun, 05 Oct 2025
 09:48:02 -0700 (PDT)
Date: Sun, 05 Oct 2025 09:48:02 -0700
In-Reply-To: <CANNWa05YhQ9Ycr13e3SOYgD=cms5iskSENUwXUgk0T8zkMy97Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2a142.a00a0220.2ba410.0017.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_path_level_init (4)
From: syzbot <syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssrane_b23@ee.vjti.ac.in, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com
Tested-by: syzbot+55c84106264e92ea9ada@syzkaller.appspotmail.com

Tested on:

commit:         6093a688 Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea2458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=55c84106264e92ea9ada
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

