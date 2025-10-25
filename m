Return-Path: <linux-kernel+bounces-870108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF44C09F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E91E4E5D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B0306D37;
	Sat, 25 Oct 2025 19:28:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCD2C234E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761420484; cv=none; b=UA1CCz4o7sKfwFd02L+DGzO8zMFjTNeIyouqF4eGA3QGFJbt3NeskI1TXu2bx7ndZhzszz+DKfReQf3vqlatF0XsrVzCN7HIk8VkX019sOF03mNTYLYvgl5rkpPupswmTtQYFyCkVLOylcX11JFinCohmRO9dlIw2OZGDXw8hF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761420484; c=relaxed/simple;
	bh=fjM9+Nv8IBMSvAyQjqIj+zdSn5WYymU5s3GOC4GJQiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bd+W3QSqPt8NrtRiYVqR0VuyF7xQoRn3kjk2Nq141w1S/Ei7TRdB35lAoFr/HCyxvSHPaW/Io2OZ18ftrdTMfkb6VcNyw7vNqUhPYypB61GRa8rXCuJ4NgMrHxf+PChkkhowK8Dv9R3QjGDrwaMqht5FdDGeuIPX73hHzlujHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430e67e2427so45080735ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761420482; x=1762025282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enkP0q3fu608KdPyNUFP0pGjeIAxuOCFFRrpwx/W+Cs=;
        b=tfuwDX8Nho5BvOK3W4pR08axvonda50z9ShRAppYbW9y2Z7SDjSjfgro6Axc1KLViS
         RHlwPVucFToiQFCygRe9/neGOtB2phdH0N4lce2ftqWcMnU1ooFi91ptdiSBSy7QudJQ
         ybwFQjkSv7etICoVPVPETFydLW3vAwvxkDrez9xbK864Xz77xMDWnpdl8wns+fXKO8+3
         G3HVHb6Pkce55+IHuueQvcEy1bwoSgPOovrZ/EIC0grnl6oKe7d5F/IF6+g98vhQtu+N
         XRNC/rxuPDpyNxJ4NYsRlBYpqgakALvkr3VGsdpzymDHphjhO8XNCDV8zrhPsn70S3ef
         a1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW3u0r+fzCn0DcZC6GzEPw27uOHstT+QBJkQYC/GhsB2/FFYdXOHUBjgBU7U2oPXJ/uQg38GRdSaWBAsBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdo5VTKMHMpgFnISKaR+b7n9JHcm3zVJ3xgMaTyDGsT9aJbWhu
	gTPqOFTVr2vaLHEPUjNEIRmGRXbDUKLQjymYDS/asqpALDWC+iKvCIbwNogDJs1P+Fx9jclZ/vi
	p5eNoKpMy0ByXVF0O82w47HDquNs/Qih5rcvQty98AvPzJaaRtqy6SPZY/8A=
X-Google-Smtp-Source: AGHT+IHuaYoxiX9OUUySpqLQbHVQ+UVgzIs8Km7n3hgq+3cygOhPn6olAhAHZI5aKW2R2AmRCUO8K+9L82cYMsA8GWrU4jxjDaIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:430:a66b:4ec1 with SMTP id
 e9e14a558f8ab-430c527ea55mr457691095ab.23.1761420482358; Sat, 25 Oct 2025
 12:28:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 12:28:02 -0700
In-Reply-To: <CAKTQj-61-rCP0AoqpUgaX66NmiTKKJK8CoYxZ76qbN+bv+dWSA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fd24c2.a70a0220.12011.0003.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-out-of-bounds Read in
 mcp2221_raw_event (2)
From: syzbot <syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com>
To: atharvd440@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com
Tested-by: syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com

Tested on:

commit:         72761a7e Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f2ee7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8785cbeec147850
dashboard link: https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1275c258580000

Note: testing is done by a robot and is best-effort only.

