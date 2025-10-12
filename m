Return-Path: <linux-kernel+bounces-849756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC2BD0CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6483A2CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891633B186;
	Sun, 12 Oct 2025 21:30:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1A23D7D3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304605; cv=none; b=YErezxsbwB90K16DKeE2OrqqZyS4fjHiHG8DyZ8w52n6Zk0Hb7cKZ2MaTKEwAzxQcN3mFprx6otn8EeROiu+aaGHi9nLHLxqAnTAwKdTjju6YVcKTX3QP4qPqMCIYlasujYVljXsuR4zsi210tvahgFqepYhvGafCDgyKv73OW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304605; c=relaxed/simple;
	bh=7HD8J8WIvZoID8gPeuviIKrpyU8beCLKGG+uCNS6vLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E+rRPXBEEcSuizZ71lJvW0+YwD4UUNmLQNslTzZqWV2BXfFVQfTnFvT33oin0mM7HtGFon8Pru8ElFFpLzNa8lybhIfJ/1/z+ajk3wwonfa8IlD3VaAjDf8Y/qAzu0TANh+sEglGM56cjZ8CUcAK1ePvTgjo6IcpfLtdZoggasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257e203f14so292200735ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760304602; x=1760909402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iooRg4KZrYD32xeyWBg0UydIyxiIUYKFjxEH2FU/ZFA=;
        b=JgBuKh1Vc0nFW4wtsMMcUxHQwnPEk9fNRTE2YZhozp5+r1l4QISH6w090eBe76Xurq
         rwYOOQvWR9BtwSPDD5LeWaWhyLsOE+MjWTKFqdHp9kx3x1w1NYP1y6CXVBP4abfcZZzM
         F306VagQHP6waSOPudoyRCs0k0shWDYSQgjsOOcM5fkpDb+QXEy+t2KllmVV22ulGcCE
         Tuj+echpZ8+xx6d4Dg8hIIPD/RSr2FD208ylfzZp6pEpHcpsePZ+AvLY9R9wR16azxnV
         I6W1loVuzfANXGeUDZJOUXPHyTrjw4KOU6cW0DK5nqEamFcHZYzLWDUoLl1O6grvAQcZ
         jf/g==
X-Gm-Message-State: AOJu0Yz7lRfbz/Qnk3UqYETgdlnnVlu1of5PKMUpkDV7GpN8Qp+Z3etb
	ktbBBbhWb5uNhwoihlE5LjFnCcGCaBoD6P/RXj4U1VHdGBdpjsm9Q2RxdqVSTqLc0m5TG6Z8DmI
	sDjMRE6zmNx/qKceaxym84gUHwibluLUXqn1JqpWcAG6xRG7UcIJRDKmEWOs=
X-Google-Smtp-Source: AGHT+IFFX6XI8HP9o1VLvonL1HmmGNfaBvRVNFwXDuNHD0v9ls6ab1lagln+Gbw6JoUJxJlAXZCOK5P6Mg+BPXftq65YSFuC0KyV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:430:9707:ef2f with SMTP id
 e9e14a558f8ab-430970822bcmr10751235ab.25.1760304601932; Sun, 12 Oct 2025
 14:30:01 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:30:01 -0700
In-Reply-To: <CAHjv_asDFA+tuP5HBd7j8uW5oS9Etm-oJOCMUv-Yn_eimXmuCQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ec1dd9.a70a0220.b3ac9.0016.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

Tested on:

commit:         bf45a62b Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12058c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14598c58580000

Note: testing is done by a robot and is best-effort only.

