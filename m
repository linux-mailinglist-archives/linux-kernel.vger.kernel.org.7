Return-Path: <linux-kernel+bounces-765924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176FB24009
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0ED1B6546E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0F2BD5BC;
	Wed, 13 Aug 2025 05:08:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4F26E71D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061685; cv=none; b=FPwLrupOCFGweFIT4bhmnmdPLX48PHy6UIHCs44hPT7DDVh2HcJITxd3UuAsC2mzpOsHO5q31b+0J9X1AsC+3lj7h3jX5lRsOoVYh4OY/8IUWyIGTws3jxG9yoMe09AhJ41ygVkYawNhMgC+7430Jhub8Lz/VZCNfn0JLi91dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061685; c=relaxed/simple;
	bh=aFM6iib2vgGtHxB6cD1SQTMGskii00gutxGizR5KPdw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uC1El712l7VTXxVKbNg1rA3Br0mCCNupmiCADW6dff2GDdny4npOtAr4CgXq7U4hy4kFYOa0yWvfA/6H/4fkSutwo6YOWjV6BU5UG2cleSk7PVT8qTk2D1PR50j6BMD7xtvwL50ORcwCii2dPZMyyDeZGEomJY9P6EAz1iPnVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881a05b0846so600316539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755061683; x=1755666483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aRgnC8pdaqi1WtoctxrdtHCiSuRrurqcXKWjYUn/gQ=;
        b=af1syO2w9qG2H9LfLjQCrjXydlWcml9W5ZPfdm6BXtee+m4SGcG5FeRVk6kYN0MYr6
         PSCXT0Ku8p+rOodFoJSfT21edMNVOXGiyTDPiz2k0d7Rs4vl/mYLR0ktQNPocM63q5PX
         Q51ZsD/8nlg9oHdcGo5sJAG1lMpvmftZIQ0/VWlgGdFLM+dUulF2n1U/Lf5GBaq7BU6j
         UM0wezNkxBO6qRDhiZjAun0dIJVvM1hfTdqGsFJasUQSuMUIvY5TXxU61fKupT169Ky7
         YH14pVCqexMbnpTykf7ogdYHIU+8EchrBkj9MhOI7P4gQEi0MesTtUNb01urbNbxGCXI
         nBPw==
X-Forwarded-Encrypted: i=1; AJvYcCXA7KXpOFqyEQZN/IaPBXvqPS9e+9tXkEBvddo0snfkVSifXO14tSH3rugF1W8ktX9PfTwADcBCiBolrzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBPBdje0ffM+1XFEzI5fAlimXdTlML3nBGZzuPQHsP6Kf75lE
	D5s/0+dOAQZ3wiAXjkQ41Wpqe7erEjw0SuWPz8wQeS5bIlXvM+Weq3XyTsZebqOAz4ELfP+SEiW
	PSwyt6xfGVAi1vyxe5eIkzAVuUDuD83n52137W636Koa1MybLHfiG/JfuhT4=
X-Google-Smtp-Source: AGHT+IFdU16hTe+3rTRLdmhnvw9e/HlyKqPC9f3x1xVy47/8w1RwlLxU0GFUaP4N329O77Izh/5Qii96T9yfgP56raMbWWyjaUlr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0e:b0:879:674e:2c73 with SMTP id
 ca18e2360f4ac-8842963a8f9mr303580839f.4.1755061682744; Tue, 12 Aug 2025
 22:08:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 22:08:02 -0700
In-Reply-To: <664ea661-081a-4040-96c4-26307ba020ed@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c1db2.a70a0220.7865.0047.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
Tested-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com

Tested on:

commit:         0db9b72d mm/userfaultfd: fix kmap_local LIFO ordering ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=128fb5a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2323b2d6038203a5
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

