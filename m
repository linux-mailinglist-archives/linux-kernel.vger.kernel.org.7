Return-Path: <linux-kernel+bounces-868482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF49C0548D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E76E8350920
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21350306B08;
	Fri, 24 Oct 2025 09:16:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45028305066
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297370; cv=none; b=TM1EuuVtR2u60Sq6UjOuictqb4mFzbXXKpXAWltcUUl+2PvZmDYi0NaA/tOBFcTjLELGcnE2zBAr9uUtWxPgJs4MgErdhNiGxS72andd1weVL9cmnFb9MOuTetfDKQcDrjIGIFuYD+dtfzJJWU0fSuXluoHp5NE0GAZTeDSB+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297370; c=relaxed/simple;
	bh=1FwV0VB0D1/X61mliPXahL9z1Z+bZd0dBinOalzW47o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EIxZVO25u8Fwq8wF5T7M5D1FPl+vTcnOfPt4QOKMfWwwZbeXjQbCUN+Jpi8k363VVYI/GUMfcOOXn6GQMEf0zaP0Zq7eRl1c7aODRtVam77Tx+ZgWiYxb6zuXOC594qeeFcUId3u8EiacaUm8qA8iNESjic/yPJ+bMutZSO0ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8092427aso181864539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297368; x=1761902168;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOmFiT8ffKC/0ckFyn2+fSFuSQUboBN+TtHKle3nwRs=;
        b=FXm1zG2LbP3POhIdicspehWjuNJ0vJqFXgQuzJ5+wZwuCH/E/RyJoZXtdJDJIzeJvk
         9Q4eFN6nlEevIRGO4SQnzu8hP36MzdJiKbM1DImpET3L5e+rgu3s1TvTsYGI7fpBSrSO
         5mx2vq1r2enobwH+QLh4g5HWj7RicRG9c/vSNCqMxPzEgf61ZC8mq/444xm0gVI3OHJP
         sTeqGix6Lgji5UrN3vT+248n2nRr6u39X0uMzGg7gcjCnO3crFmsv0iENLFr/qVGEZvZ
         LmmjIRZ35Qhl3dF+ElZYnihIKSxCzUfDNyY6vGzMG//59Pu3tMDcGBhR+arae9oAwHC/
         1ntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUffbV0PmxXiubIcJIiWXLdtGOe6tcCDMr0nBbsnwtlDDSKoIrNmsORfSiTN0i/cqxzspMJT+6f7ZgcjSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf582w2zHyhH3dH/7kvlG1/GlHQjn6rG6B/s4rRZydrErayEwa
	cIg+mdz+MtYHr2thxEXtOeUqYvFR/brVrdHNPtxmgzpcKQjC8X/Lg5V1amthKwZT9MWJEsDc9q8
	vfO1mDXlnAOH7bQiJ/fJUPzUW4lc0ooY1vfL1nVqmGHqes2YH+LLmeO1Sd5Q=
X-Google-Smtp-Source: AGHT+IG7/YjP5WkYSwVs5zYJjXLFmfQHXfPf9C1imSWeJna7e+Q+9OhoeBkdiz3rGjKcCwx91MJ6gdepVxJX+MIdopmrrcZMKbqx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d1:b0:940:d7cb:139a with SMTP id
 ca18e2360f4ac-942623a75bemr206868139f.7.1761297368370; Fri, 24 Oct 2025
 02:16:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:16:08 -0700
In-Reply-To: <20251024071522.dRYaz%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb43d8.050a0220.346f24.00b5.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=115163cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c404ae8bce817b30
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ad6d42580000

Note: testing is done by a robot and is best-effort only.

