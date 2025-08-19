Return-Path: <linux-kernel+bounces-775852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A144B2C5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AFE17DE15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84A338F5E;
	Tue, 19 Aug 2025 13:32:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DB2EB853
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610324; cv=none; b=mFlywKDbJCcMw34+sf3AxfNa9iDjm5PJ1ViFOqSWrxyGgGGKfJMETZC7tT8vWWXsYG5Cf6KAePjgnylPRzNVSJPGkrBD0vafd/lIlsNUy40OdS981OO3SgChQbL/AWQTLRKyJWqLAZ9jfvxcc3kOsjeXdSx73I0AW3mxx3Fo4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610324; c=relaxed/simple;
	bh=kXWBUkGtz59/tjkcV307Yl1L281mx/fY69nLbnQU19k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RRaMMcCB+nqujv2qff3NXJZkebk8q+5m01JzIJbdt4m+DXevpyFrNN/JKxgzItz4Fnm5lmJCXmkNFe2+zbLjtWOUB5ESPdNwEvsJKDjBbKrPKpEIGc3h6ZnkAF8mb1CaX3bvmcziLcGwHpW92wigLu/uawDulXimdLF3sP3W7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e66d90917eso20607105ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610322; x=1756215122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4UJsJ/WrnZ/p7psOZ9KjbOHkDwwJRK0bmHqErrjnCE=;
        b=HS8XqlebQ3Yxx3JNIOqW04sUKMpp6ESkAwQPzKX8PlB61cGNLfvNoTA4ohOKr/tjzV
         p7FR7Cw1xek0iEBZBNkr6QOWTcp+RRqTGGviZ6wrJV+38uEdWbDg6oQDGQrHFu3dZzly
         Dn+SyauaTKbGrubSaXhBW/o5bKqa/IKOCVrpWzSutUdHHukAWKYKJLeDrN1QnRpPRDK9
         eamsgdCY4JFqGeYYNv77BLyZ2dclQluvGnOHQScwEZJAtUL2+FnbGHLcuXLPK1TNrYHR
         ZhqgQKSa1kjl4JubC3vbAaq816cluCwp3jTgVdr+UVuX9TTXmUvUvGUEsmQzVjSyRXvS
         Ib1w==
X-Forwarded-Encrypted: i=1; AJvYcCWpMk2ervJQQmuqKQ7EO02+W6y7fk9jUexVTLpYKij7BxpSJ3o1N/aEUTDUYDknS+HfG9l5a0RBUfK4bZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNHJTOczS7VCkmrvcPXWppFZHbU4DJpMIjB64kNPJ3GaRhDMO
	L4S8xdfcNIKLr13t3OX4/KmGi0dbNs4yRS0a9QiEKvGd/dd/TPk2o9OgO4RhKGxpgKvKBNu0NeG
	SB8Xm5Xht2AWog2Hqseobk4K4oe1hzJ1Gu6OdCNc2pL0c4vtDRHmgzmW0K4g=
X-Google-Smtp-Source: AGHT+IGWqthspiHt8qBXIxY9G2aPSF3WkcwGbiTU/L6lJzxXPyRNQAUaQDFZxcO4Hhh7vKik2c2vwAUJ5QHQDV/m4iCiWTNGewj2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2511:b0:3e5:7f18:3e86 with SMTP id
 e9e14a558f8ab-3e6765cff36mr45245065ab.1.1755610322494; Tue, 19 Aug 2025
 06:32:02 -0700 (PDT)
Date: Tue, 19 Aug 2025 06:32:02 -0700
In-Reply-To: <tencent_D3EE1B172523BACABBF633209E3D1BF84B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a47cd2.050a0220.e29e5.00c6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_evict_inode (2)
From: syzbot <syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com
Tested-by: syzbot+47d8cb2f2cc1517e515a@syzkaller.appspotmail.com

Tested on:

commit:         be48bcf0 Merge tag 'for-6.17-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141643bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7016efe6aaa498c
dashboard link: https://syzkaller.appspot.com/bug?extid=47d8cb2f2cc1517e515a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170126f0580000

Note: testing is done by a robot and is best-effort only.

