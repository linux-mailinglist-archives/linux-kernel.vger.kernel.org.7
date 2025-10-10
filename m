Return-Path: <linux-kernel+bounces-847873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D904EBCBED5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943413B437E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1DF274B29;
	Fri, 10 Oct 2025 07:32:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90E227E83
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081552; cv=none; b=LuLj6/nfTj9xKiixE/C/4ie9GAW0aol54kD9vCl66TGLCE9EyzBelCFIJ3mMPlWc4vHPYz4Q/rJxQ+1w5+vX8dY0HS+d3uT9aO4FukO+3rQKMmMRDR0bVe/AkwHCnDriWariClvXMiyL5cE1W70i6Ipt0n4QnyRiUbsnuVfPFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081552; c=relaxed/simple;
	bh=ttINZP9/5MVUK0XvaowCW7l/505B7b4VQq9AdR7brbw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RJ7+PNZfPV9X4b682wv7o50IEp00SS4OWFTRKh9X/ijEbeVfzHe/UXBH9PQcaH5mdGcESSSii2bg0rPabjVPNHtVlGjSzz485CjImt6VtO+1n71xhQLZVPykyI9CG4sb0AS7BkHLmKuE6QfnOwqSkEzsmxhyJwuZ+QyjkvHW66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f9b476ca8so33680375ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081550; x=1760686350;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQPoOHJXVilhqdCudz8OjlgRyvFMfrtV4ytvm2IsQfg=;
        b=pqleMmsPIE18/5uKUysBUjset/Oc+kTPZr6wIQmkS+8bZi7joJzPS3cOqUKMcBtDtR
         k7XWAoavLZQWa1N2XSnmT0014CSnOjrluSsmXkypKnA+R1A37rmT6ox06SJXv5liaHmL
         SHlrn9Z/NYT96Aorwmqyv9f8Lvt1pDH5wKlOtatHdC+kK1nZvzK/Ku+U21FNcrgU0slR
         qKSa0wW3r+1p4UmnYMgp0PbmP0DNIS4QvAbZMwRz9oMAhrAhz3BFosQB1/d+BVpM3smu
         pVea4oNKEhJB72Qu4b4MTLaFmXKm4/uTtkSvuY8uGcTvPp+KZwFgZ4w8BPIDsxt2boAL
         XIsA==
X-Forwarded-Encrypted: i=1; AJvYcCUScqssz4DyFkcpMVa1GNL+bBkKFnRY9EKuRq2DtJNKA3B+FDsEP06vEFpmR8bcoXN2tnz8woV4LXphGtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqy/g+LJj7ctOQw2PTuGwmot7THDvl4uENWk+6LkAjqXqrzqaL
	xjeMQT5QQ0KL1mfyJeOGGxf+sDMKXbJQ5vmI13kiVh+C1d3YRe4/wTNRVv6YXPvPWFWEklv5mhd
	u5DPAVg/ZN4VWP9MvvxTWsb3/bRxBZ1ih7K9B/b0BdvZjhoYekAXmu89r54s=
X-Google-Smtp-Source: AGHT+IHRnXbjnWVa57fAT/g/AunyboyoAzVLWuG5/Zj91A2ki2q1fTgqkAUvQTGs9z1Wl05C6nvOLw5ZFDRsUEJpiNCrvDKng1J5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:42f:8b94:c128 with SMTP id
 e9e14a558f8ab-42f8b94e60dmr85150445ab.28.1760081550412; Fri, 10 Oct 2025
 00:32:30 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b68e.050a0220.3897dc.0117.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Oct 2025)
From: syzbot <syzbot+list6bac0337c0f09a6aace1@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 649     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 15      Yes   WARNING in __kvm_gpc_refresh (3)
                  https://syzkaller.appspot.com/bug?extid=cde12433b6c56f55d9ed
<3> 4       Yes   WARNING in kvm_read_guest_offset_cached
                  https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

