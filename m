Return-Path: <linux-kernel+bounces-867116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6CC01A12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DA85567C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C2328613;
	Thu, 23 Oct 2025 13:57:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2C314B93
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227828; cv=none; b=UlC7iM84g8vaESq2GR4Ye7fBJPIVj6abKhUqg1gFYvX0OWZlVxm2TUezYbLmDguZTq8amEQH+x/Z5KAFlnWQ4Z5NUa/EoWgCNGdukcWuolGhQRw7kacnDxn9pnMF6m7Lv0hpFadgTLfG5TgFhq0OCVhKoYACG9Gzfu5574+9Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227828; c=relaxed/simple;
	bh=SclmSJlTdruQ0EkZKZTupRQtu66eerRcSggYRTXOHtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K2NTI28cZW6qizeWKRJkgaI7WyR0y0zR557EavFPBDNaesAfRzl1dCIQQgFtwaKYLo2t/dDGv+KB+HKuZkzo2OJVYLxVeY92yqWH0/OJLOia+LSYAxEqEAz/ouq6SGgjR2oYnswlOZPOavLH/X7lu2y0ivNEpr15n7pwW9BMWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db6d358bso38463805ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227824; x=1761832624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u10LDTbVjEbcUiFJZw9JbpL7ZcFO1YUrPk20KrX22BM=;
        b=ZkxQJjcbjxq8cek1jh/Lg/5wCxguaeIC7e+PKVe++CA+fmzU7ExMfYLlflhb0PcA+P
         v5J+/7BrYnKVNy8fAWTYsEWRAk7dTQZzIT5r/xX28v3xAmtQK+KJbS+QP9jmp079jwsu
         Xb8d+NbNMJ12WMEIrTwMdMXpu/0nMX5RajmR5WG8kNgP9hJAq0mU6qvYcOaohZboEmDL
         8peb/xLfh5eVx97JetQhFvIn6vwHu/d0xrVzAi0p+N2xBgC3OWQCosF7bj5gAa/OHW8C
         W/1qG9TyOJr5n8bob8+m4kl1VGXiwTzrmF/N7+1N2cjSEYkKKB76hhuA1Yz7dMbEimbP
         eKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT2jYCOclQMU+FZYwFTz5V1k9FvlZEAGC6BbprcEmX6iednbRrTtoNTvRHRjwM/p6GTvZDqhAUnhuiK6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScwr3p7oJQP9Arbi9TwRq5YMS4jXDcLfUoTkWIHT2Y1G9Ujbr
	9BC1qiRVADc65XoiZQN9GX8ssojOeNYFVRgruIUr2886oQbkL4ysALyYOE+er+Y0HewI5f37xV9
	iZifONmTs4+JG1EIEGKt8ayy8NJaRMD188P6oRiFBXH2FWZ06HXDp9AB5QmI=
X-Google-Smtp-Source: AGHT+IH0zBvxDL6Opw+loUNstvuAzQR9djU2nClJI5mzg7wxOmVescCmVzEC7BBPlM6+tsxgHHXkORQ8KX3dzVYxgS+bEmkeErLF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c05:b0:430:ac49:b3b1 with SMTP id
 e9e14a558f8ab-430c5247174mr400905225ab.12.1761227823739; Thu, 23 Oct 2025
 06:57:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 06:57:03 -0700
In-Reply-To: <20251023133603.ZNEGS%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa342f.a70a0220.3bf6c6.0059.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         43e9ad0c Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11960258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1712c3e2580000

Note: testing is done by a robot and is best-effort only.

