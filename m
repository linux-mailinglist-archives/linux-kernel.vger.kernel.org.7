Return-Path: <linux-kernel+bounces-745668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867CDB11CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5A8547B69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C502E425F;
	Fri, 25 Jul 2025 10:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1962D9EE3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440665; cv=none; b=Tea/pOGdkjTVyOgJ8/mPSM4RoFSZqo7tM7e2iHHA5hneC6NLZg+xK77uUmF4OGgD2DDPmsPgH+HPYh84gYU6WWgTMcdwYczjAp+zXGjaKW5kNaMuqh4bLktCbGs+GTKNol3LoWqr++r8haSQrkDrmW6W+XcwX5yi1VDYbTwgaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440665; c=relaxed/simple;
	bh=WRAB1BDurW0AXCrmPcfqybg/bZ6h8jf/rWWgcQ05W5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xn2kriZtfDB38alXoiAqyA0nwThn+K3jUX7kgZHdkyJ6ZxYXf/LELvEobT09MgLiKS8G2gGLQ2995gDZr5bSA0DnKjT1XlXrdkuvGJ0V6rrBpc0Nxcng+uyfQ/dcf7nJwaYgegVYylpV/iQnosbHkOTPkXlXgybTryFuXloEYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so23131175ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440662; x=1754045462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkKXtnRa1grEm77mE4/XnUcSXOCanlbCPsDnKsirorU=;
        b=PIuJhkxeKPWV9ix6HoXD8dohne7dLxehELpGMgGafLfN55daDrGvfQTx7Wn2hTznBN
         N273oiHh0Llhx42EzlSXIj6xr/BzqoswH0+RrBrIHHHb4wTAp4W6fGQ1dPEvjJWyGUzE
         3fEcLD09VrQ1ILU/xUZxZi0PDgfrTTsbzBficklsTYmLURwO/5YrQC9p2SGkUSOakHys
         fabJ5wwJJSChFXZL/cSKTQqakBvgTg5ioOrNNFyR0niBZaMKn2P8KmY7OUBfmqKlLgOU
         T11OKw0triSPT/eb8PNCPmD0qmR1EL/aQcsNG2S5gN7hxGsRmwnWOSCCbBlSuYr8T8ay
         I18w==
X-Forwarded-Encrypted: i=1; AJvYcCXe2h5ksM1OgHrAN/xjJoBKoUWvu2JNIqBIfsiXIpeQZXa3v6R7rjpNUqHL03s1b09uG4zU98JOAItAEiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkfVbJ2AGPUYOpRdERHK4OgTqpx9q6kinM7jbgmYQ6EbHLjY+
	Dx1tGEI8dp6ngmWKBWJA6mAGOxFYwF7tyypTnIbIhedY5WXI0BoFq71u8g6vV+ydB6pdf78zkoS
	w6k0soqO/cwT+PAQ6xYxVv47z6PIQOHyMl10yZCFu+s8tKe6cMW/izzChD1g=
X-Google-Smtp-Source: AGHT+IEW/gXUwetu/V4dz+VCzsA6giQIjdBnBzSOqY4xUChI1BEBCqSy/KyFK24R4/zcw4cSBGc3pS66cfyAgKWFra0EBEYcChEd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3df:3bc5:bac1 with SMTP id
 e9e14a558f8ab-3e3c5250ebdmr20038625ab.5.1753440662703; Fri, 25 Jul 2025
 03:51:02 -0700 (PDT)
Date: Fri, 25 Jul 2025 03:51:02 -0700
In-Reply-To: <20250725112120.1528e072@ian-deb>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68836196.a00a0220.2f88df.0047.GAE@google.com>
Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insn_ioctl
From: syzbot <syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com

Tested on:

commit:         2942242d Merge tag 'mm-hotfixes-stable-2025-07-24-18-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb94f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7753c32e11ff6a95
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151690a2580000

Note: testing is done by a robot and is best-effort only.

