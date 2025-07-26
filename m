Return-Path: <linux-kernel+bounces-746907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DFCB12CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 00:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67071C204F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03168224220;
	Sat, 26 Jul 2025 22:03:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142E1D90AD
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753567385; cv=none; b=uIWBZmYoieb0jcNgK5pW9AJDSbPusrgpChoWKg2NAkObTcChI81WT1+rs1PxWJCG9mogJWS381vBqVTt/u6GbD8/duelEqAQX2U85yPzBLkBVeO5uCrj6Ip0cne/pz80hjpv5G+Rb04l9p5uv84LItcQYv+NmNALoJIoJAbAh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753567385; c=relaxed/simple;
	bh=hAIQEa9/wMDIbPrtWnPtN/2kEFN1fDZrN7n44Sn3QZ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V06HzpE07QSqq4v0NenARIxet/CQ6bQ5bqQ2oo5Mys3RlB47w9GykHMbtVjgY5P44WaNLU8zRF1GyKlGfluOHx81zk1CRR4pHjz/cK4zoNfu80hYH4mqkkjbeK3gRFez0yWVhV0IT4OANo/o/g69jy1n2WNQ1K1bxxC19eJnQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3d0bcd48fso13880735ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753567382; x=1754172182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RK7wGz2vWGFPMqUZLIN/3luuaxzEK1Gxjaz5YHOQ2g=;
        b=iRT2isYZOf8fyxVkKk522BawT6uDWC6A3+g6dLovOfl0/tNOl88CoovDrch/voJ2P+
         UMOp4LZQsTv1mRhiCb2mXc4La+2N/vYgpfCc0P0m4Np6voT/su5bNhPUkPsuB0ICUpnv
         FL3N7kyerG7hhntVFA1Y5FAA+LMCUH8yBTJDLNCGuL/Q+qZWLt+nj0swRDB6ftMlIIpi
         3PNQ+pAFy5VLebrIrkbJ0UEW6GDwqHlOHMBPXPfei/RwjnDwdmZ578nfXiTRKjQla/Dy
         Kzvdwn9c+S57DBLCi1Xc7gu9Z4yTzSwlW8C0YNdJdRz7/0NOLaok6aIX9r0pK5/GmxyY
         h0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWbFzhLb6HQHZdeSUT7wlT40bMpylbvpH2W/l9OD6JjsK0UFswQznzpS2lPQgk3v6CQNxBpMDEsKJ6Heyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO7iOJ9989tBCehJ9WN7Nuvq1bPtUhvn18sk7UjBS+F7xSsEZq
	0JHkbjivBGeyzNWXN7txWIhx4aSmVcNhQazWnJ2Mwmai2Sij9/K5IlKDeeOlXFFfd7knF4L5s4k
	IYrG+mVDMMYrHNUrdkvqWo51AOlxp+rbGTq4iK/B4AZ7mTeJv2ZQd21Hlblw=
X-Google-Smtp-Source: AGHT+IGZJC+VY48tFT/D0XvvvPAc0mmUr5HSv8HwlFMtkySwxIdOR6wdI6eArVetLqp+iaWLw0Ee/+zNfWqSm2UgqEfcTk+iLg9R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3dd:b808:be74 with SMTP id
 e9e14a558f8ab-3e3c52e6cd9mr103088085ab.13.1753567382583; Sat, 26 Jul 2025
 15:03:02 -0700 (PDT)
Date: Sat, 26 Jul 2025 15:03:02 -0700
In-Reply-To: <20250726204144.107432-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68855096.a00a0220.b12ec.0033.GAE@google.com>
Subject: Re: [syzbot] [usb?] [input?] KASAN: slab-out-of-bounds Read in mcp2221_raw_event
From: syzbot <syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com

Tested on:

commit:         51d4b0a4 usb: musb: omap2430: clean up probe error han..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=103028a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3af2d4b01cd6138
dashboard link: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16574034580000

Note: testing is done by a robot and is best-effort only.

