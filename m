Return-Path: <linux-kernel+bounces-757463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69662B1C26A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7818871E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D2B275855;
	Wed,  6 Aug 2025 08:50:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D596275AF0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470204; cv=none; b=ZBBxKGDTCCszR4HEDPOTWawxkGh1EjWeZaALXz6avqxVDVik1cDQ5/ipPFQwQVrNEAIby+7Us0MUEPF5kRSSL4VWtAhofwb9s6CfVEEmgftnpMdPmTLz/7Yt+VSJ2lYlI4pZzU+dOCNsK1TgGUT/phdqG/E+zPs6d6joMMeYLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470204; c=relaxed/simple;
	bh=SemCcx+sq6n6O545C3Ts6ANB+SpMS07DqqtHta3j4x0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jGaZxoTaLr0z3Mm7e1elU6Ey0uPirbo692T/I/CMtG6+/pcX6KcQmvmP6tEPUCMn7/6OzNslKlvBOtfY47Wt0hlumVPpi3/NqbZaS+zkXVesuKj/33Cs9neDH0xqUMBpoCOih4ZeWF2IyzQ3Y76b6r8AaOFcGzoWJu4nW5uBUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881a214c747so31559939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470202; x=1755075002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBmwiUt+nuPRAaMZFcsCuQ9KJ321I7uGUFl4dkIzOH8=;
        b=RdpxrWQARGeZGGk98e7JtK4miaHfcswSqFnQ2AZkY3353c3QAQTpIassPV8rNYqyYy
         29mhD/TEtAYZpC82X7zSunvlVGF2fGCNNSxFROQBu4+SyEAQ1sBAIQbcz/lmLeFNx0KB
         ojzMf4y+PWd5nHvQTkEzKkyP+wPdsM7SyqL2ww9a9LuubrtI+nlfiI2R8ZlIAED5f3Mo
         GijeB260NsOj4x4xf4QdpgFYjHFw8bkFtAEpIxqYMY8VZePM2Bt9inpogkfFjW9lNsFS
         I8a6W3L+FqV+NWDXmNDcQE+dt7zwbp/JHyAtSxhZ3yrxUSj3oMyMdw1e8uT9HuWxS1Nn
         hlFA==
X-Forwarded-Encrypted: i=1; AJvYcCUzrhGXtTikFX/nzZvBnttNaDAsQjjSP4J7DaAvxxDV1J2THU3hCaOW7SoOQnn3tMV241mqWnpYcwR0Hw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICH6iLdjT4bWBZ+BCuHSnrZyHmSgj3i7tfAL+mSaKczgi5Otc
	SDzhRgzQ1nHaQozNaqHzUN1EHuh54TmAvoMEiDPPSmojCAteb8hQ3sSa2+glv6lH/Bf0O/cDQXL
	oVX/jwb/aeoaTcRKLGIzp3rAFxfeaV25ZaA8I2w0tW1pF5lLLpw/lG+77+s4=
X-Google-Smtp-Source: AGHT+IHaYA4xki8tgHJ3350HmR2xD1uzniV2gnqhQaec7hvthAaMDhr+upWNXvyeyzWrWtf+0GqE8fq25jR959POJE3Lz/prH4Dt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:fc0f:0:b0:876:a8dc:96cc with SMTP id
 ca18e2360f4ac-8819f087f95mr336624039f.6.1754470202487; Wed, 06 Aug 2025
 01:50:02 -0700 (PDT)
Date: Wed, 06 Aug 2025 01:50:02 -0700
In-Reply-To: <18e151e1-6963-49eb-9e45-60c7cb8af15a@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6893173a.a70a0220.7865.0002.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in __pte_offset_map_lock (2)
From: syzbot <syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com>
To: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com
Tested-by: syzbot+45ad2baf16fce6bc81f3@syzkaller.appspotmail.com

Tested on:

commit:         366a4532 mm: fix the race between collapse and PT_RECL..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11622434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb90b5976661bfd8
dashboard link: https://syzkaller.appspot.com/bug?extid=45ad2baf16fce6bc81f3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

