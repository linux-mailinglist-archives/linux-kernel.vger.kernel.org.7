Return-Path: <linux-kernel+bounces-783299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A8B32B76
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FDCAA386C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534F204C0F;
	Sat, 23 Aug 2025 18:18:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C393DEA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755973086; cv=none; b=nlAwtWvDMzB80ZsRAs1nCRU2ohbi2By24ZOl12vg7Mtiz1k3N+JlAWnSXeckxpkYQo3kZbtLF1CRbnlQ5GJiRgfJjR6MI2ebH23rWbcJJN2mJHD/cEAx7u5Lk0lUkeuIkD0PHQsWY7K4bhkqoDbKca5VBVVlrS9vB3h36NtFwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755973086; c=relaxed/simple;
	bh=g7Hne3raHlGTvyEDEgQDRYAepFzKEytUjYe673UuyWA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sBsOrrCcfSWg2N6n7kM08OWr9bFKwodjGCNdslfjel1lQjM9OluUo1TpAi0ymlcLuZ2SyFAfTvibW+Z6Dr05DnSpRJ+7/tskmzovNC6V9QkI93Bo0e4ejTx5HKMB6rDMseNDCZtSJeeW3Or4JhHWGLcXhLmqAhHGOrMfD4H8jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eb14eebe86so13122125ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 11:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755973084; x=1756577884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvrGI5lO0JIHO5yIhJ25utXK+qOPL1vuXZ2aqhdEn0Q=;
        b=tuqr0MO38RLoImk8WHpiWPxWm2bcY6R+14uU91nu7bOKSMFBmcypfnP3ZZOrOUp3gY
         dLhVydosA5oJDQdlof5Cvu9WLzOdNE9AeBO2rOdUafBQ9m0RvFHGHUHLRzu6S20217AL
         vR+EZEYJE/Hda++comq5waxUMCL7wqYaD8xFhJPxjomM5YhS3As0iXa4E1+uzuR4DjrO
         5N+aVJV3EUj2RtPiPiCf/XGi1lMM2EL5+rXO5XdKqlaj6ieySvhxxjyN5rW2JwXuWzIT
         +8qz+Jepo6sypUxTiXrp0TMFdpHIPG7CA4K+jOQxOQqorw8w8Z1IROibFAuRp1v3dVux
         NWww==
X-Forwarded-Encrypted: i=1; AJvYcCUZOgeVWX5SxrvcN7XD63pWe8qmjYXioTcwF153n/Z0+Vc+FRpVMwMCLtVJkGLNopCjvl0y3VLToaHimfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fBIZnDoHD6jCY8wOnXNcWyCiUTvcXwsHgnl4J81UmPemWj8n
	tXTQdhNzPAYVotzCAnGoD+eGNhZmdG20i6pktcO93cZ5X5P9FGqX7Ty2v+gBsDFPNPkv5rEyvMh
	/KVOWO6++q++NZjxaNdkxMxsqsGjFpbTyc35nvPuAFcd3VzqRFuvqTq+LhgQ=
X-Google-Smtp-Source: AGHT+IFVwc7hI9obtt58xxmeGlSqaexaNaLEJlVyz/6DHUm5aTWR3nDdjKIhdaWkxLxfEoeiFurMgXW4Mo4jsyqrFY4PSYwGOcQk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:3eb:5862:7cea with SMTP id
 e9e14a558f8ab-3eb586280a4mr20689245ab.15.1755973083974; Sat, 23 Aug 2025
 11:18:03 -0700 (PDT)
Date: Sat, 23 Aug 2025 11:18:03 -0700
In-Reply-To: <20250823100703.0a0239d204ca2487363d2adf@linux-foundation.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aa05db.050a0220.37038e.0069.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_set
From: syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>
To: ajd@linux.ibm.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com
Tested-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com

Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1058a7bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34aa432f9050e15d
dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

