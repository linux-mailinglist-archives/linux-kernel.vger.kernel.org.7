Return-Path: <linux-kernel+bounces-788062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A36B37F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9BC1BA4FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FECF2F999A;
	Wed, 27 Aug 2025 09:54:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4128312E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288446; cv=none; b=nITdUwkecoHEgTgIfmTD+GCscfyFLKMYTuWOKwDlfIoGJRS5U0EJNrYkXmCJrlpplpozHHLdbXsYw9CTqv1pNfs4OsHuD+AQi/4K/k22PUya50OXDEaEpGy8grpj1cfv7Kn8jQH8q1e5+NeHSbClaLFQghVI2ThUf+t3fruWQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288446; c=relaxed/simple;
	bh=Ko6gcXoLS2/amIpOn2k/AyCL4mrqcDn05q+8UBn9azA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=utt1gvDP5brjRYqX4FN+Tr331nOmo/d8FnVsGf4Ia4FjwxgaMBpBLOz6NIwmQT1MG2lVcfrqk11hEzT3zpHSMkkOhrCdWGNzC6IgS/q0TUzKJMdTHdjx1+hmc96PgxGLoL5iiKjp7zfLJiUAM1AE2N+Tr8ir4AduWZG+Mo9/kLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso107936839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756288444; x=1756893244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKPh2SlwChQU7ZuhqgSBc2ks3+rkl2HA2Luen55P8zY=;
        b=vfoTw6YWCwp6vnIGOHWWxRj7Xq7mi3MghLQUxQNwwqhktwlHka83JL3PbIeCABTw33
         kAA7RdT17mOxc+FDPeCv15t+WvESdgi5mE8Rv9ybEcmLkAyNZagRYXDCnoMel8CDaIzN
         kGuitm8f27E6OLbXZ2fndZmEE7deUPP6G5/Py3CYP776Hi56fV9h2Ix/XRA2jWN/MAM9
         mOyGyP3Sau0OaCLTCkLuyMc/ONnAWnHNiN57iOMN4wLSJmDSVz2UW8nDoIxtpEFGadqj
         4n63FYsfKcrKcZwt3YTZELRr1tc+HtfwUcJKZCi4thm12CUw27z5lrn5gEsjGoyMAJXm
         hofw==
X-Forwarded-Encrypted: i=1; AJvYcCWTAxGk5svMcA9C3eCAK7wGnO0TB3aktK1Is4fjBfKrTMKQTmFHgeQrGO4aEKKOhmmN8iWWKFoj7umSHlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykG2CiqTKQuunLLO6WkccWsAceCi7K6DN2p87DTKwOMwiwY5O5
	7kT1jdsdhdOsXYF0j5Ykl/TLayNqKegWWT8xaAEF2YV5gM2iBzBY4ySlBEfRAcG1Ch49JD6W3cv
	8DnBtjS7GW+rUD7c4l8js8guoJansMyvttf9LhiGzDgEagmdLKX9FRvX7FNM=
X-Google-Smtp-Source: AGHT+IH1Z5+3ewdHv4H31Zk3rHJWNDr6CeSPjZ186XygBcvPL23EUJogL1/i7XZi25NZKNDtAlftkUoLFlwH9fRMk+UBKfnXWIUU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce82:0:b0:3ef:d63b:2722 with SMTP id
 e9e14a558f8ab-3efd63b28e6mr31092225ab.8.1756288443979; Wed, 27 Aug 2025
 02:54:03 -0700 (PDT)
Date: Wed, 27 Aug 2025 02:54:03 -0700
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aed5bb.a70a0220.3cafd4.0019.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: eadavis@qq.com, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, slava.dubeyko@ibm.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 736a0516a16268995f4898eded49bfef077af709
Author: Viacheslav Dubeyko <slava@dubeyko.com>
Date:   Thu Jul 10 21:36:57 2025 +0000

    hfs: fix general protection fault in hfs_find_init()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1519c634580000
start commit:   01a412d06bc5 Merge tag 'pull-ufs-fix' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15611b82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117cff22580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfs: fix general protection fault in hfs_find_init()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

