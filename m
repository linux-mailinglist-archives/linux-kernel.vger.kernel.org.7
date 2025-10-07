Return-Path: <linux-kernel+bounces-843632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E29CBBFE03
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F124ED7DB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3661D61BB;
	Tue,  7 Oct 2025 00:47:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483734BA5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798025; cv=none; b=GsfiESsvGYm17h2bdmmam+ImRRi+UBe119pS5aMhV90ReP5eX0k+q9Z9p7p0xXKM0O+AEQuGT2mjbQ918FoEsDgYxr/cbMTx8eMY6MvxGPGQurA3pAV39b75tR2fsQr9n2T5M7oXvGkuEhUmDedCQCjQJsBTJ1AjPi+m+/+s3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798025; c=relaxed/simple;
	bh=/edHMvz+Y94IkGIsLIBbfy4ZTCY+RKCL1yC1EXnf1Mw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RRGyhxA4aFfOQ5FVzBl/ax5JhnBhcw5Sjin82G/Ny21nlgZP5UOZgsOKfHwLsdA0WXqEu5ReqrQr18/oZr99vhXT2l2UxVJGHpCl5tvtPeVbEXkXof5RWXwxGCQQAsnh3ZKktrYNAOGcjegEf8G4G7YMyAD/fUVJLibWRj5RRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f6e42c844so56828865ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798023; x=1760402823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PbGjzVRxtTuYpOOcutOEgeT9EIRHwUbach4rkxczu8=;
        b=TRsiAzlT3e+LSEdX9glx55g06hpPHii6qSN0YQNlGaNYo4DFirFixFd8Rx8W+1htaG
         xjXXZv4cb8Fr3COs7qmH+SwYogstNZo7AWoiJMwlH3Y7MSi1T18fRiUnppcKhQShAY7e
         bpDsdkzGm7CyRO4+eWcPOdo79yJfVE9/HKl8CZX45blT+M8BTL5E3r+Zr9J8PQQ14D1n
         sJc45STkf+9bjSoT2XLdc8oSHoe/Mjr5hwGxR6kj1LZd+X4Zua5Cp5nqeLkWdodv+2UN
         xTGWXjKlZ2LRhX1uGhK1gXuBqGF2bjlwI9jorkjbKsDDX48MoLDYMbGYWTA1RkMGpmy4
         6nng==
X-Forwarded-Encrypted: i=1; AJvYcCXelhC3eAzKRgRHGUw6RUznbFAuEN/kLqf34h0RRpWeph0wVicd1afoxyzxI3iRK7a2ZlEBp3ZzjqApgVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7I+s3nkNJG24D6ZE/noPed86MA37TPn7vfn4+OKE+ihe1nlC
	WzhYsVE4fRZUd0kNhiKSrRjUuzX5H4eD3p23bP0ZUTmr94yifVVoVppgxN/QMali2CczEnIFLGw
	zjdPekmfRGiKi3NxLpSJSSnZR3Ml6uYTbhEhjq4biJ2dV7HEk3Ydhd66wGfA=
X-Google-Smtp-Source: AGHT+IFuQmXH2Y1R/sHKs/tHlrWglwesCLeiRlwymjn5Hs9AoFRCepyxaawNkimFNHgnmEwnlFaj0zeCnge1l6GKUHCHKJSkJGqF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:42d:5d48:acb9 with SMTP id
 e9e14a558f8ab-42e7ad0501dmr176812735ab.7.1759798022940; Mon, 06 Oct 2025
 17:47:02 -0700 (PDT)
Date: Mon, 06 Oct 2025 17:47:02 -0700
In-Reply-To: <20251006223805.139206-1-nirbhay.lkd@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e46306.a00a0220.298cc0.046c.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in attr_set_size
From: syzbot <syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, ntfs3@lists.linux.dev, 
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Tested-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com

Tested on:

commit:         9b0d551b Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a855cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50fb29d81ff5a3df
dashboard link: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1609f942580000

Note: testing is done by a robot and is best-effort only.

