Return-Path: <linux-kernel+bounces-839621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4822BB2082
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404F51927F91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA583126D4;
	Wed,  1 Oct 2025 23:00:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60533313547
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359605; cv=none; b=FPkOpHmL/a5lz4HMBYk6GSs3/YYXysnCw67r/Ayi7ei3dS3A0heysJazVbIincOutUL86No1Vhzu5zPZHJJV0ovw6m0eKN/ptWbMZJ2B5Sa4T/RWUdx3rY/r/8PMzQTnzZn+IfFmKuf1Zwvu4t85lnZQ5KA5VVwPi7skE7LsIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359605; c=relaxed/simple;
	bh=JtG4JX39Tbz5tMd1WlPHiJFKJt6zg3SbHiUTiJ6YHK0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOJ3+VYDWXiGu3K5bXqymEUxYxse8IVBVv2QH8yjl4Y+yW8pmYtydHrs2Y6GI+gcW0Z4sCBDKwlaGnsx7nVwaJvO5U+s9NkpRCk0vl9vJArw2HI/LAzvywd18eKPdTOEgvq57gIXXyBnAp32Ky/0uGNYWpXCSklMimV8OP/sZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so49432139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 16:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759359602; x=1759964402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol8RRMuxtihhXYl5boci4im3WcdnHbYRDby1FKTNtlA=;
        b=rtkRgW+gah3iit9eKONmV4sBkAvl6neVJVu6jY9G85vqXu6OgZG5+2VnaGoYPIlqda
         eW+OkQvpioyv5dO4N4uFwSn3ipO3/KDmy0WSFgyoEkzO86jwqwvtgBPfksbu4ETEXdd6
         lIYwA2PjhOSnlezLMKjnBYRrD7S4IMwYZNhaMi3bUgbk004BHuJwqWvGE/hzkUiHpelV
         ko+sYenwXMjdjbCjV88iULX6ASdky2ZyYlWctjEAfQS7Pr/56g+dBpCRFrnhFb+++SlD
         gOQYYTEEV7YyCyL4CZVPNnAmRtsJPn76R1AlwvXEm5GDkAjIsG2XzPbrZST4vaX0jG6f
         hqPQ==
X-Gm-Message-State: AOJu0YzzFZXDfMOrCHzwESq2oa1sVIKV0VQQ4L1jDD0B6UtBbKWMZLYE
	mgEPaFGrDJdcOfMqxY8BDMoPqLBOvIjap2K63CKLoOtDzdD8qi6WQZvp10wuND2EtHEmVuM83aa
	53lN0SZ8zEr/rl/dQkQUBEbCfOKLqY/tkcucaEGetVln3Bh5SkMrjcMe41l4=
X-Google-Smtp-Source: AGHT+IGfBchekQLAN8MoIFsMHLSiaq4Zabxyj7NUmNLiJlrfQSjTQLluwletWC9968Kc7QlKFlNh12JMcLFxkO8LUDL8mwsx8nHy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:42b:2a51:f51f with SMTP id
 e9e14a558f8ab-42d816771e2mr64999235ab.20.1759359602531; Wed, 01 Oct 2025
 16:00:02 -0700 (PDT)
Date: Wed, 01 Oct 2025 16:00:02 -0700
In-Reply-To: <CAHjv_asg1cduB_9idDZA2KYyN85cavaJLK4nXrhfcSy7Rx1nRQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddb272.a00a0220.102ee.0069.GAE@google.com>
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

commit:         2213e57a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1625e942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10082092580000

Note: testing is done by a robot and is best-effort only.

