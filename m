Return-Path: <linux-kernel+bounces-721253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E6AFC6B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B4188BD11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22B2BEC57;
	Tue,  8 Jul 2025 09:06:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB92571B4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965565; cv=none; b=CAkkF2NE3UYgrtq9bprL5WVTq+9GeMCt893wNXgGWqab4DulHy3GQYTs/04AFnoMPlN19mTOVGb8/LU9CPe8H4NDMG8XVTJzT0EbGuMrdDsyauCyMoWKwEkD1UEkrOcY7r2xPW0Bno6R1TAizpqPaHW9VHiSIlRhMghFs4lqbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965565; c=relaxed/simple;
	bh=Xhb9ffyW8dSjYoMTKUPlDRr5VE0teCeAMQ6EAiIEer8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PJ9sVJuFVxpoX4QcIuRG340Q2a0/0AL0CTzsoIv0JXb9o306sF0tU6QT2GSc4+0wqORn37GjPc1ktRLyUuISBNZXUUEkH8pGswf6fYB/aGMKtDChjFXLstWPa86yhwpROrsPYyFMsr8BHaZ9jIVvG785TGJc6GCGcvErHJuCFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df33f39384so18747045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 02:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751965563; x=1752570363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKU2Ks7QggMb85/IbT+YTciHNCoFkKdX3/APeX+LtU0=;
        b=nWsIgHIHo21qqWCkjxJfncbk7SB1+B9iX+uTAQ/FVJdqkZDwTGkQJT2l/h96n1Eukm
         KJJBSkJggJb+pEZfmITe7x04OQQ+qSAKxBkUbMMRVBPmcZd93bMQF1DpNT/CiGoamrB0
         E8SRafsytfniezSEVF0LkcyMDMtAz9RhY7VP1kjQbA4g8i0NL3DKNooONyL6NQybkH2q
         ZV7tku0h0+bb15KYlQVHA9To3DSwSmPM2HXKH7gTZuqdbW8vwitt+TSxd/ZSQWlN5lov
         IGFhrOeFcAEiinS3zuF0S4AriDdqhpiA4IIUwDRtAprhxlspJ6Ls6hxHa86AzDxbse3M
         ZrEw==
X-Forwarded-Encrypted: i=1; AJvYcCUNZkmBJlAJz9WdJLzS4RZMSTjnzrJSMfNA2McU1etG8q3hjM7w/kPJ566LxifURURQlNn4ZnVE8otGgFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9/r7Mf1WbJOAiAE0mHJz2GfTGKC0UnyO2cvKVBBdtz4BSgFk
	AQ/kZdLahmacXSMQyUchQ7+ORnzp6yUHuVYmZOvmGZDIu2/YCPBBjss6sfz2sqhPk79jEd0IZEs
	oRRGdyTyRl2sET6pgPe7XBBDryhVBFQ1p6kdm8nw2zr1MLti5yjU4cPNoBv8=
X-Google-Smtp-Source: AGHT+IE+BaPhaNoHXu+pbQ9ISl094NhJTXYh45F6pUUAI/I/nlwym42E7vyfZwRJ1uOiDI6DxQFhoxw/D9f/d3mFKp6yk62/EznT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3df:43ac:af5a with SMTP id
 e9e14a558f8ab-3e154da8d00mr21915035ab.2.1751965562784; Tue, 08 Jul 2025
 02:06:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 02:06:02 -0700
In-Reply-To: <CAF3JpA5UK1iRiHTbPZNej5izQZNVwi3phN5f0pzCzadqn7K0+Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686cdf7a.a00a0220.338033.000b.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename
From: syzbot <syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Tested-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com

Tested on:

commit:         26ffb3d6 Add linux-next specific files for 20250704
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a14a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59817f9ef599726c
dashboard link: https://syzkaller.appspot.com/bug?extid=b0373017f711c06ada64
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a9df70580000

Note: testing is done by a robot and is best-effort only.

