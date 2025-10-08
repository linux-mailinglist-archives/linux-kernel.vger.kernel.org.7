Return-Path: <linux-kernel+bounces-845852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C976EBC64C8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75E4A34EE02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2202C11DB;
	Wed,  8 Oct 2025 18:32:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C432C0F97
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948327; cv=none; b=QnmCavuu5UmybQ+cKWYGmxz0pKnF0yhVW1ILUnazlXUvPLlNgppR6D7vqIlnQS6MSzU0cZGqL7cQ8MufIVKxKSk383oUDtL76hzC3s7rrLlvOm2Ks/wDxFi4btoI7UxPDkX8oZV33XEEQE0apjZvmEEuLTmszKcKD/OzblBecP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948327; c=relaxed/simple;
	bh=pQr0RXKDhtdHCYuqgGg4G30GwwOEqAFonoahRIyYkPM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o39BIzQWQjuURhRYSqd/bjWC832wdl8ytFaQ7MxQngBFQugLT2tkoPNZcSSrwXgldlwQHbtF3YY/dyxDPKi8qNq46rn4eVGqBAVjEi1eSsSBOdv1i9dOLSLCDZ3FDNnU1rUQyr4Q3fig9xgZaNEWIdPaGi93Z3ccKtjfR389vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f639d6e02so4836685ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759948323; x=1760553123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaZOpCCY5/XduIX9mtEV8gBwSBZGOkUpcxeW8AAMz9o=;
        b=pYKu4Dd/PQUEtpFZ5/jzYY9zUxzbROgSJpj3DmX30fYgfDFIas6iZ50X+aaIoevLmJ
         UnCLU1WFzt4w+3nZ+qkXw+90lFdtL54QMN5K13tWNWU6WgLmzvsYJzpy3TMqWwloAHl0
         15GcOP+IaO8CAXmGtXQ55y67+6QmVtXei+f1vbKQ07dEkk5H9eaRM2qjni8X2ipFbZ1R
         EqOZ0CAm2d4wPZOyt/7O/dRW2l7O6MZX4mftdJPPbO7dc6gvPZGaJ2zQHpjCfsonv2+2
         nzNtr9WGwogG65Q3PImaNvWUHHX640oAkKq1Qpt9ER6GBTClgibH9cDVy4xd0xn+MLjr
         0Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCUCfjLUEkEVeVs9RKtMHu22I8+bJuvT37+PWkuuN8MdVaRvep8qQXyZLCFweL4u+PVO6FrovugfU2BndPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMz9vldaDxyYOfhvPS4Fn9IbHQtvTBx4DNzh5KCUuVgZ/waKKd
	aYOJCNs976KhktF2tryT36C7Fe1DClFQ8eUmqXruI/FzfV6LbPOjnYm95eUY3DJPhzPBRsECbm4
	TbHi5LXDJ3gnX7AsOoLPjAwb6E44VDxfYphCQTodvb1KEZZG9ZAfx2lX4Hb4=
X-Google-Smtp-Source: AGHT+IEvX2DUtFqjql1HQOA4RLqxL4DHSGgNUqm9hlxconRy3HmItVFhoZ9obM+mvLIX8JG3sQNgpqfH1o3c+9mzAl+adEfY6ulG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:42d:8268:5026 with SMTP id
 e9e14a558f8ab-42f873e45c5mr41891275ab.22.1759948323433; Wed, 08 Oct 2025
 11:32:03 -0700 (PDT)
Date: Wed, 08 Oct 2025 11:32:03 -0700
In-Reply-To: <f347ec0c-a49c-4ec7-be81-f2829227ae75@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e6ae23.050a0220.256323.00e5.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com
Tested-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

Tested on:

commit:         0d97f206 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=134a11e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33b052d7a6d140c9
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bbf334580000

Note: testing is done by a robot and is best-effort only.

