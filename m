Return-Path: <linux-kernel+bounces-835121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650FBBA6539
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F7A1896870
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F11D516C;
	Sun, 28 Sep 2025 01:01:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CB2F2E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021265; cv=none; b=X5pt16Ax8SbJC6DTF/2qPPJQFGizjOxcFgcOCGM0c2dmq13cpbZeQYCp9qde/WKh2MoCiOI1NaF4eMvnXJwKAY3WKGEDsq+eVg+WzDJi/jgCEdL/irRlkFmTQlhTXt8OrMRkPB66WWBK6qaVC3tE+YguQBjlWgmZId2M3hk4X14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021265; c=relaxed/simple;
	bh=0tMqG3BeknP/OcKpYvRLR22b5v0FdTcZyFvQMirNY/o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TuQ9ygdKbhP03242SCs2aL7Pcx6H+QDLe1FTK6msLxsr0UDlo0jA1UMXCjAp27jR0Ux9ig4h42Y+8wvZ7aAhZP9Np7Od5f5ATj+KuS+zpLlKQZADURSU8csdlOBe2PD3V6fhRLzSeF8NiMS4t6JKHJadeR3YtGthfbpq7B0Kt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42af09092b9so3953715ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759021263; x=1759626063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eePJd/KpRWZej3ed6w1IGjX51UIwmLdtMgmlSOGgm7U=;
        b=OX5aw0Hocu83kg2au+bnzym2aEV+7c829EbBDZMwrVgY8Vsu2x2yHs8x5lVgpRyZez
         rSbpar4X0EPLpiCLP0MJia2qTaIv8uNdDuoAo3QKQ7pNXqxnsRY7U5uWn73/f2n7kpRh
         Zv7BZGbnG8jMlu678+e5jdjgCvKqcO33DFmgIx9of57diczYw8Gx4F1HHPMVFsw9X+BE
         VDFoknMW5bZdmf765ddSfRlM0GT7f8hZHAKLacIOHl9pLGZ4fsLtzv+juswVzVMWlgRZ
         XXgac4ipMDpAXow7POpxelXzVeJZEuN7WNM/tJYBffAr/zzkkZr2y25dfIqu0qMlByX3
         lclQ==
X-Gm-Message-State: AOJu0YzKu+OupBTW2uUFrOoNd3e6nZE9ra4KQOOsIK6nK7RA+FRY7b3H
	3CgSBuqXa/r3fkqU4wSzeHo0XbwZmrVGcQe3JEdWfjjXs1t7RwcXAFpMqUK/yfQlttCtj9/ME7u
	HVHbZ2Gcol1nH3xKoyUN33apHWn6StFD+8QTGaNwLABessZ9sdx8jlnTlyss=
X-Google-Smtp-Source: AGHT+IGSRG0/4a5UG5oMoKFqPS3MvmRkf0uzT3yOx44IDv6zzg2KsUpr+ukdbFqvjBR+06MBrmukSpJvij/SogsmprjLk9ZtxOH8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3805:b0:426:9b42:2a06 with SMTP id
 e9e14a558f8ab-4269b422a6cmr149391725ab.3.1759021263037; Sat, 27 Sep 2025
 18:01:03 -0700 (PDT)
Date: Sat, 27 Sep 2025 18:01:03 -0700
In-Reply-To: <87ikh39zw1.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d888cf.050a0220.25d7ab.0432.GAE@google.com>
Subject: Re: [syzbot] [comedi?] UBSAN: shift-out-of-bounds in aio_iiro_16_attach
From: syzbot <syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Tested-by: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com

Tested on:

commit:         66acb158 comedi: aio_iiro_16: Fix bit shift out of bou..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156472e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14a96f8b241aaa26
dashboard link: https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

