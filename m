Return-Path: <linux-kernel+bounces-782867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C963B3262A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D811C250A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B713194C96;
	Sat, 23 Aug 2025 01:15:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8C1891AB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911707; cv=none; b=pbv2G0r1G4mIjC8r3uY2M2SwZ0FiIRsnXV1B/Lr1Jw890x9ryTim2h6IB2x6n1bWNqHnNHO8vEHstJRT7KhttgxdFQPvoiY+PSjvgRSqJOMcoPsOBS48w2YuGFKRKUv/nFzwbHJMpEs14ddEXjB1byJVnxYtBFwea5ACnBqHcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911707; c=relaxed/simple;
	bh=WIpmha6yRgyzZP/XXUhbXg/SZnSd3Df6L1V2A7dvw2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y2+0cLKmBL1klpGzYOqWZJh/K29Wv8O/rSUEw5Vxgy0NB+9gXc2GFe4CqW5UJTAyEb5Xd8FVdMrvSiQrJlSbQd2xiYY68EkkoWplRMVEa3akNPN0mgPcYYJkg4GNS8HNSUjOoriNXzrwQXG7ZcDkYNiGSIrxr87DujAm4B9aLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e67e4b4ff0so30604445ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911705; x=1756516505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqUXO+FOaOrb+XauyDwN5HD/zcxSWBI9Ntihmw2iN+8=;
        b=R2h/Byl1Zu5XgCOQPpTYNeiaytdgjS9R+pEoKTzFRNQPEnLddF0ISNmZN94W9ovnvt
         WNfR2ipJvHB3ZbY30JpFO+nIksMzd2LIBLDwnvpF6xfeK18K1nSxmgCyQN5dSj4KWp1C
         ZsGN5IO/frWHMdRRKFtkJmGUevHGKrgR06X7VzQ7um6SUIPW6zRrgp+yIa2cWX/LxtdX
         oVi+KhTZPGneh3uQHh9VeQ7273sumW3o+heY2uLQ4MBv4jCgdnIKnEmN6AuPDCbs63Le
         SOsyi4/DgNXL3W5wIdzAhWzJ0Uel+OLWOgrEF4ZM+yjpNetsaPLDL/4x2ltwHGosFKn+
         Ljtg==
X-Forwarded-Encrypted: i=1; AJvYcCVguk/6+rlfrFFzcCJFiuBC28x8fkC9JuqkpLTFyN51uzl9VU66bQ5pJqk5D2/tnt45vbsyDAGbpzdyrno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrQ8RcDZ5GwW8XicJHcQpf6AsehGXyOyLocW6e+KNpmj7lWuS
	Oz21pJtpHNVtKJTr1ocsz5yr4beFtQX690zuSTquQ7S6eaYpYvUZ9Im9bKNyTN+jzs+ckI0YDqR
	7hNmrdXfkfTD6gUIFICbvuyf6yp7+faFGOS64BTga8ZGF4L39yCZ7XNLt+m4=
X-Google-Smtp-Source: AGHT+IG0QAWYiXBjMJfzTwoFkjQtMiqtXumBdeXTiefK1lehTc8/t3Be6xv20/K3TfVkkqj9LCRKxjbMAoKWWJA+XKCTeiyD11K6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:3e5:4fee:75e7 with SMTP id
 e9e14a558f8ab-3e921c4db98mr68836805ab.17.1755911705506; Fri, 22 Aug 2025
 18:15:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 18:15:05 -0700
In-Reply-To: <CAJnrk1Y1UJ54+4kjHvfJvjh2Dp1J_vVJVGmqfh04zoRFDQy04w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a91619.050a0220.37038e.005f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         cf6fc5ee Merge tag 's390-6.17-3' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12393fa2580000


