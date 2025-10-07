Return-Path: <linux-kernel+bounces-843887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D06BC07EB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2CAE34D36D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182D238D49;
	Tue,  7 Oct 2025 07:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9334BA46
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822086; cv=none; b=oeWOGIWGaHzcxGN2ikgtHVAtspyNkduYt3SOg/WREYiVaw+EJWMEgEi0wW2/lSQZbjB+Vy78uQKqj3hXPnrX/ax6Qk9MVb787SsVX37JVbveQui2Z179WSq1hx5MszZQRck/Ya5X0lFbqMseMclPfStiXEXwJUGE7aSmkXUPCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822086; c=relaxed/simple;
	bh=eCicPT/7rIuyTdi5cmSAMymKBJanyCxdkdmoR34byIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=swcsCZoxpVstlN0cMvgXhnSK4AHyviz8Kc/hM6/DGLnvudXXOpvbIV6HxjAMezytaKDrMqOVavYWCXG/+ospQ67I05EmaIsqVY/iPzWNxnf7Ac1T0GPZSeHQwH6v+OAqE0TXlsOru1XWVle6+7ts6PHec1ej2tNZstxy4axBQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f81a589caso2974275ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759822082; x=1760426882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gs7dnOAcUbl/r+PMfNMWvyhv7qa964bCQ2mwZ7oD3JA=;
        b=s9D/XKKnSw27hShFwMCVK5TK+G911tWsmdDpVOqArnN1pu6Krn+Kg7fMt8g8H1Af8j
         Ic7v1l8jr9dND3njST+08HNJhI4SISdwngtTnZP87mBGP7ZY9Z2xzpPYxI2dAmihnXXu
         y+VdG/ylHdQG73u2X73guRhPYUxEPZpyG4uiv7uBxTDruPyEas2qjruV1hPuxPgX8IT6
         o8e5eaINXSdq+PKywiTZLuDTWPmln8wxuS9Cw1ynwQK4jVT2U55JDEoSnuS78eIUNt7g
         /YiN3LAp5W1t52Ja1Q/goNoS0gOuekAHtN2wIZ7sFvhQfSfaB+C9X0sG2MoV/y7PeXO5
         6XGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfi89qISOeHk4rpiCZfP0VQrs5oUzpQxglMinc9Mf9lOq7QQxPHBihZmF/TMXkpt2xtWKfUwBtjcfVy5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5zY+zpqV3ljgQekLhenSJhv4HG6D3/kl7hjEdLzWZimOn7fe
	sDYOV8vS8IsGvc2puErCOhcEFYBxs6SsRsAasKfDxVlniyEwNBhf16m9MO7q6DIzsdzHKUVYg8v
	gDmodYycggOiHQEi2TBQViv+AxQgbQ00h1q928pxAhlL2OdE33eP1B0+Nowg=
X-Google-Smtp-Source: AGHT+IGKE9p6QdR6qIln8XAJDHEAgxc2VjltZy+Axa58GfuP9CPSUk490rQHhGno8ZhuLlhrKI8C/d+wQ/hHzunWIJB2sR2ZYERq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3788:b0:42e:7444:b019 with SMTP id
 e9e14a558f8ab-42e7adfe854mr221077285ab.32.1759822082555; Tue, 07 Oct 2025
 00:28:02 -0700 (PDT)
Date: Tue, 07 Oct 2025 00:28:02 -0700
In-Reply-To: <20251007060147.340787-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e4c102.050a0220.256323.0019.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: broonie@kernel.org, david@redhat.com, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, osalvador@suse.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         4a715314 Add linux-next specific files for 20251006
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10653092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a5d0a8497f9e6c4
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c255cd980000

Note: testing is done by a robot and is best-effort only.

