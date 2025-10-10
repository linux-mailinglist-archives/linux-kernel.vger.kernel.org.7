Return-Path: <linux-kernel+bounces-847989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FDBCC387
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF43C1A6584D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4A25F7BF;
	Fri, 10 Oct 2025 08:50:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465779F2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086210; cv=none; b=Zx09w7T7lxaTGh1oABum6tv2emS+XjP5QWUgWx2AAnZ7tH0sNNp/I02JNtsUjECkb7uA5XTQeyGq8Q1CKYhA6qjG/r+oW74M1iNw8rWb+hk6O5iOGxZ6g7XjF+Z/dRWQaIoa8t9sI4KPHC8aVGkvA2xOSKNtaD80+EMYbygZb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086210; c=relaxed/simple;
	bh=YwoJT3dGrYAzSW7sSM0bbyjDmtV7Gy9JkeEiEAdBJyE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K3+VHrgT//bXfc6SWkbf2UbpL5o2ytITU7y5zu8D/nWnrh8A7BEAy2aSqP9Y0CGxpk/xmUuM6dirchX413UryI2CaP/6iuP58wL7ovLcfCTXUOoM5xwzcEz+fZNcms32VpwNU895cKSRJW/1x7I8YnyT946J0w7qawZZQjkxiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90dfda98b4bso987610739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760086204; x=1760691004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6R91HcSA2ZKcBppmWfwRcXRVnVestRa0RD1GSfBj/k=;
        b=NA8S+10Pk7ORXKW6elTTbG+qrWfXwZLOVq6TgvbSeHe2lP5H/fPkUQrqw+FGINFL7Z
         P9xqV2hIse4dYDXREooePwot9JYa1VpjhAStS7dHLIG4v03we4PLH4eeC49JWLqVE8gm
         yLomKWVosBGp9oLZYg9nIBiULmgBn8ITZrJKH2Mgn2VtN1zW81s/f70UgwjtV6c19idy
         Ck4Mbxww/BLTk45olCSpkK9Zz2TdcR7GIXd/8HuEsCf6ami00JquP1DpZif+SWEYwseq
         qpa5WYykjZCkiFkrJH2y7Wc+lLVmTMmnOs7dtSpeTq8tgewb4EUGM18QdodYIAyVIKwC
         P93A==
X-Forwarded-Encrypted: i=1; AJvYcCXEdKI6nbCqDbhu3BQBf1qHG7tg1hAIhBt7tqFrc6aZ+n4gIXxdbS12JV9wG/rL0fzgW4045VmJqUKW/34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGBhFdikBK9noRIP23b6SMnCPjPt8Caas6H9EjG41CU8u8QNK
	nYtXpbaD5M9zyNLJ6Mg0jmZ9rLAkOo9JD4CAEg0kr+Yo2EpUTSjMxiOBMwYiKa+QDXjFFbwutpb
	9X2FRdZbEZQ24G+M5kGAVocWclnYPVlKxmNQj7kAUqPezMNO0mxuym00aLdE=
X-Google-Smtp-Source: AGHT+IF8R22E131fbvb2wtWEf9gw1O6i2fkhaLNRW8auLmUVy9Gju30JFEB/5p1jSAvNBMWdQtdpLSl/4/+DYTDHR5WzoYKF+ezG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1344:b0:924:6f04:eac8 with SMTP id
 ca18e2360f4ac-93bd183230dmr1182169439f.4.1760086203876; Fri, 10 Oct 2025
 01:50:03 -0700 (PDT)
Date: Fri, 10 Oct 2025 01:50:03 -0700
In-Reply-To: <50d1d8ef-e315-45cf-9d04-24eb9a908656@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8c8bb.050a0220.3897dc.0128.GAE@google.com>
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

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1657b458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b842a78bbee09b1
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f08dcd980000

Note: testing is done by a robot and is best-effort only.

