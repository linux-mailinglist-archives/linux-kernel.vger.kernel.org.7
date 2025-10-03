Return-Path: <linux-kernel+bounces-840985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0ABB5E59
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C0E4A084A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A81DE8B5;
	Fri,  3 Oct 2025 04:23:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CE1DDC37
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465388; cv=none; b=aoGjaWZUk3jMfG3WbPAgd+077ny6b+/2feoWaheMwPwh1EWwdUKFQ495xVSQNjUCCL0Qwy3lLTQJ8Ah5XdQ09X7SHfLIlegsqaL8JuOxPo+ZFiVieJrPdu+YfUCIuRibKw2RIWtI+GaDb+aGtrZNu50eZ7ivlxIlo0r008QC+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465388; c=relaxed/simple;
	bh=HKV2G7xK0NTd1QesbTsCr49zTjkvB1hGyDTI0OAALgY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YnZkxNZMHYoOz4PZG2nHCA5TqZtExYzjVZCKJtMEhqfp+EI5fSwjazAnCYhCSfzsJteVu+JJFa4zckBkRtdqKJuqnvwpxHKRuarNibItuYLTXvly4hpGQ14796DKybD04KJViE8EX6KLB9RZ5AJh4lntz4+ib/AgtulY2pWCRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e347d26bso245159539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465386; x=1760070186;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heeo35bzR6TCKyVDE0Dwx36OB4enkxeB28ejktvZPaI=;
        b=jMVVRK+NbWalLe+YOq47XnfuQCTj5cSw5mHMCfKhd/wqZzAuOPFRPrSmVwn1djeybI
         Q2X2oDrNgWycEO1yVb/hyy/BnpSkANTN/1VLM2875AOJXtkUMvMWvsGqZlZoPooJVHNz
         XCSt7//aXqxhB3ulTCpasGtkS+J2gkgx1CKb64QrRiVMVfKX4ay4TMU1BByjYhZmLkJI
         ELuW8YrazSaMIUuC85LsKZzgBBgvSckl/VnZjMUIrzBckEb7Jb6hzTqqBIBpuNhvTqtp
         kVNmXxwgysFS1Vq0mOK5iSNiSEodDKU0Ft6/DK6EDytSZnBNIVz94tMSML3Apst7QjVC
         06xA==
X-Forwarded-Encrypted: i=1; AJvYcCW2YzRFjjOxezxkKPJPjlttPSYre8cURgTxzzTEI3+now4DlyWuR0sJJTQSrmueQ/Kn70ZICvBnJ+t2ll8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUL6t5lUPPOovMjsxPp0d8gqi0+nNV4D22ax2Rli7YSQRc5mm
	XDU6X5EQFkL+xwuyGk7tGychG9ioDMsWJZYE4tVTZQ0ZRx72cSPb24wpd6nw7i6kqSextkDNk9u
	Ab4GDfLgUKthiY0jljCNKuKWGLZpZk7EQ/krrlfsRuXlj6CDhM8cDBO2tTFo=
X-Google-Smtp-Source: AGHT+IFgV1g/mhNiInUWc8HH9LuTV0oNxgHCANV4xcvEX1qN/fbUWat5rsRl8j8NOYYUOG15TWJvCl5xiWSokcQlqMZx9fT/qvYu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd1:b0:883:fc4a:ea55 with SMTP id
 ca18e2360f4ac-93b968ffff1mr234481039f.3.1759465386256; Thu, 02 Oct 2025
 21:23:06 -0700 (PDT)
Date: Thu, 02 Oct 2025 21:23:06 -0700
In-Reply-To: <20251003040153.2411696-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df4faa.050a0220.1696c6.003e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117c0304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159c0304580000

Note: testing is done by a robot and is best-effort only.

