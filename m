Return-Path: <linux-kernel+bounces-840922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0958BB5BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8335E1AE4C89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D12773F1;
	Fri,  3 Oct 2025 01:27:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399303D544
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454828; cv=none; b=lCNYxNFvd3NyfE/IMtAhYbBM86JUN+XDis101ZTb68W774nTi3lqBlC+lC/XK7RFav5Lqj495CfWpxYKT5dBrrU9YzuCKFvXdayoz3cXZNFIXklg+0pLgCJKWs5Tb6njHN/ANwCdkwDTLtaBjKkwIXs5qv0BJ8D9DQINrXlWWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454828; c=relaxed/simple;
	bh=hrTxAQcFdcHbVaYRj6QxqxRE/BKl8Vu8PQW3pqXxYfI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LOQ3dnOvgam8b1T20Fvb1fO2NJWZno9oCU2obTfv2RZLTqcUpEiiYgNI1suM7ImtmRb1xinJOeNltVyv24Gy2un4I48QC5WEOkUcUC8G7j6DFoTDHowuuQ4oR0JR0qUOFonRCucXXWqYEm+wNMtxz2C9Fy5314JFVHEM8xunoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso211549039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454822; x=1760059622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSmZV/hnldfFeMcUqOY+TsvaP/ZBZaX083DD+cWyDfA=;
        b=AQqrH3/TeKe82G/LplNVnEaV6KUMvnPdKdhpQ433gzgW5+Yjb7tPXrBedUgZNknRPp
         EzS6gEzXno27VmAa9/1AU4YvmCZJqBqzzPpP9atNFpshLPq3nUqrokegxcS9ZLCACE7H
         xrV/2EFvLOVovKtgsgCXc1LNyxHDZvbnAsKng4gcKeFF1VREoAV+/whuKFbSBoKJMEMf
         nwLPbgURaujGTR9xo0nIdYAX2BcYsPSCgy8YqHiC4B+lgnptJMnkCyJXSwn0vTwipgxK
         1iA+dbp/jCoCUexaOtFSm3F0L7pfan72wgXHDHY/A6quEb7Tmn7wjDbwC0Wc3DRBTLWx
         1G9g==
X-Forwarded-Encrypted: i=1; AJvYcCXs95mvoUTiHW55IHUpvhrhbgp/R0wfWCS8CmPorycEUz4k52dMqRu1fxlvLhzXAWF04yCrxlpCRbrGrjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPQkBbLV5qLCv7wk7aYhpKevILI6occ20wmjDFC3kGvVdg4eX
	RQ7Fr27ouBvH5iMdr+2UTtfuKZalfl5zujHi2P3v98faCbAMQeqGga9l6IhYyoTfGdAm9Qg6AjY
	WIMlghtg3q6ZFPdaDikjvmDXvU91MvmUNRNEVllSGooo4UO/g0nVOx7lECxo=
X-Google-Smtp-Source: AGHT+IHudRpISqfi3wse3S1sGdDNxOvlRpJc9pmcPMngFY/X8JmxFkMvTRl5MdyIONhw5pDjJDjATx98ShZMq7O/Au7KLeczynwS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc9:b0:91e:c3a4:537c with SMTP id
 ca18e2360f4ac-93b96a952f9mr147480539f.14.1759454822474; Thu, 02 Oct 2025
 18:27:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 18:27:02 -0700
In-Reply-To: <aN8g1OkBMndiyKyd@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df2666.050a0220.2c17c1.000e.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, damien.lemoal@opensource.wdc.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1472aa7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9442f6915cec8b7
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c8d942580000

Note: testing is done by a robot and is best-effort only.

