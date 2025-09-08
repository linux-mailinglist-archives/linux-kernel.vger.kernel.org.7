Return-Path: <linux-kernel+bounces-805033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E3B48343
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344CA1899DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8F21FF3E;
	Mon,  8 Sep 2025 04:30:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B1218827
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757305805; cv=none; b=JV+1D5jce3D2AJGjgTvVDyPDJPVsoRlu5OTZaN/MUgc0oHV+fcINCBvNhMW8AnZF+fgYELfmfe5I7YbTYF9ZZpy4Z39Bc4ciU+L1yzFRqBQfysn+FVkXCBGL9sZBASCLvVbyObbD4zMLjrR+dU+1Hiyuc6Eu7xYI4Pey5kJCZ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757305805; c=relaxed/simple;
	bh=4zkgAfJ47wYvARL/HU5hwdAls1pAwTkHezvtoue9GJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SGa2aFlP17uqA0LDv6YRprmH7HwGMaABRPuRUVDx8uJsR3znNDVduh6gE7G+a+5jAbF0+9OU6NT7aNcZoEb8JhCZjvKIW4kHUM5wHa6PlI1mYKoByHOPEp4LVksJgqXBddRZQtbsjqJm+7dC7TNIIDQ/pNSxdksDucLTxADUVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-889b8d8b6b7so74914639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 21:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757305803; x=1757910603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKg/g/XoJErvdToiWX/Q27vZTqTfinN/J6yC7CugODI=;
        b=JnThnQb5m8YECajk2vLKEzCCHjDhemrrhBM0TuzSLPdyCHsuD6S3BGKPdvuMRIlHye
         udn6lG8PbLbaAFFZRKmS4ByKpEXINU45v0g4x3GmrwLDAM/Q13mnyAvquRFhL8EGkK9+
         guBcRvW5BIDpAl3ZU4QWowlk311yvN125DkU6mgHpQahMpPI7ac1TMSAlPfdnP5+rtor
         XCmtPB7vthGGNYj4GGd+D9Pw0HT4s8wVMPNQToI8FJ4bLaEcNApMLMT5zdc6wqxZgRXG
         XDhOotDHAv6W9BtuKa1l+ocI1T1y2VOxgf4ZHq20UWKz1EYAU46UHaFx4HAsq165XVLb
         k4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7yMffucqUe82uFdWlz762u4S9LWeWco3U0fbTHRY3je8RidOAFtQl0P7QQ989+Uq3YYvIGSm6s+EoSmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqWKb5n9ru2gDffZRqBLJMuA44U91JsFPb+OzRb6Sk2ffHQE0
	Kb/VKTkHWVdm3lxExrBhWb0ZtYjpUqr8Et0A2EtGioqkP8x8CXZiPj8yHcjiH/lUvzZj/nfDKBC
	LrVcTi/l4MkiWLxxxgIEF0qF4EGW3dl7MTV8rX8pvcaUxxN6e1rTpFxfBdZM=
X-Google-Smtp-Source: AGHT+IGPKdo6XGzXWRxs8GK3AjURBkNRBzmNdwt1tAD0uRVr1AmOZCv3S4NUzRIjrDq90pmE/Ak2fuHxXW+LtPKeKZplQof/1f3p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:3f3:cd20:d7e4 with SMTP id
 e9e14a558f8ab-3fdfaf2e158mr94576065ab.1.1757305802594; Sun, 07 Sep 2025
 21:30:02 -0700 (PDT)
Date: Sun, 07 Sep 2025 21:30:02 -0700
In-Reply-To: <68b9b200.a00a0220.eb3d.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68be5bca.050a0220.192772.0831.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register
From: syzbot <syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, david@redhat.com, 
	io-uring@vger.kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit da6b34293ff8dbb78f8b9278c9a492925bbf1f87
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Sep 1 15:03:40 2025 +0000

    mm/gup: remove record_subpages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1240f962580000
start commit:   4ac65880ebca Add linux-next specific files for 20250904
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1140f962580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1640f962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc16d9faf3a88a4
dashboard link: https://syzkaller.appspot.com/bug?extid=1ab243d3eebb2aabf4a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a0e312580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101e3e62580000

Reported-by: syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com
Fixes: da6b34293ff8 ("mm/gup: remove record_subpages()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

