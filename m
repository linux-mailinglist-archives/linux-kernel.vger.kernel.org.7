Return-Path: <linux-kernel+bounces-844942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91688BC31C3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4780B3B8300
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B19296BAA;
	Wed,  8 Oct 2025 01:32:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90E25A2C9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759887125; cv=none; b=YrOfU2p2K30RRz5MI9R21RDqx1bDdzwFlmsLEVS1a7gQ0TbvsRTGhMCLaP13PaJHB8oyed7gkBow/LYAmo1r1QU7TvK+NmHYJ8uK0MT9nxcEHku27DAsJRa1SpDebGQp7Q0/uuVuU4tuEB3YZnqnTSnSOdoh8IKldYeJTB2eQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759887125; c=relaxed/simple;
	bh=JjYiUAcEVHic5kTL9/57PUUspZUTe1KugqQ8aJl3fsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JIc9uSDG7h+VFM3WBaDa+uNTyu/w1l0YxDK6ZTr4M4yz1sBLaTHxzhV4T7m2nEncXitNZxhyBAyZy/31td5+Fuxjtzrhce9g7IhN8Q2+lxZHMqgtmWKUnF0AcBbCRTgsxS/8FdIqJybYtORcNhRMP/y748JvQGYKFGyI6XuchWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f6639fb22so56758995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 18:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759887122; x=1760491922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Odmpr3/K7GXDT3dw7DJg7DqXzfopWz2++pbeuyB9nx4=;
        b=ZUgUnlrJKqr69O0h/HthtsQSqfXTdbMGEepfAU2es+wHnLubOZCqlLRaIlAhHMwujs
         /LuIO0wxqx1Bh8hKaAzog8X7SVW/XYKGK08FQEkPOsGmLMgenR9ew3m68rEtRuxfB+A6
         oGxKoPgrM686yQluuK6oE09PUFH4jc06DaoszAFxb5Pvyw5i6nIKGh8VQcuzhjYtxkfV
         AkmjlqWr5AXH0N8P9YVJ9B5o98zkcVxYHiN0ADnsf+zLyXioQwNtFUw8L3gTUBbVQ1ko
         SzgNyZ3r1kR7aFgwRCg1MGbEg2QOI++JWOoJJVmI51WYvfW2JH+rulumPGTIpx0LrBMQ
         rk+w==
X-Forwarded-Encrypted: i=1; AJvYcCXCkZyH7DquL0rVJJoUVGCSoQ4Co1tTu5/W/hYcgwzJjz30aTPFTgCkVxIrcMXq3yxUdS5SBPWpGAvJpXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ro0sskcUO45w8eEoc8qDfjfpBopWNQX+phbnWgvDO46dwN3E
	B3uExio/HbKsydlIgaZnpc8cllX+lPS8aNSpAPen9M65L2KLIbGtPaYpLlQNdnIE7iEmQahiCN7
	bARIAzKk43X4GlF5V3+6P7ZR39RArevc0F6g0G5yvPb9mJW+VwDklw0t5sow=
X-Google-Smtp-Source: AGHT+IGS6VjORzVbFjhLZNhi2/vW5olYRrchkl/Z/u8XXQCTsNxxBpemfy02wsXE+3HaOfiN8prQCXrSsy3FwgtW8Ar7f7T/gB01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e04:b0:42f:87c1:cc3f with SMTP id
 e9e14a558f8ab-42f87c1ce10mr9970135ab.18.1759887122380; Tue, 07 Oct 2025
 18:32:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 18:32:02 -0700
In-Reply-To: <20251008011021.8322-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5bf12.050a0220.256323.0030.GAE@google.com>
Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
From: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com
Tested-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com

Tested on:

commit:         0d97f206 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1672da7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6fcded704acad42
dashboard link: https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ef5458580000

Note: testing is done by a robot and is best-effort only.

