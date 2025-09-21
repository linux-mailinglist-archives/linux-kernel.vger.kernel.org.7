Return-Path: <linux-kernel+bounces-826152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D8B8DAAD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95ECD7A67EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352152566D3;
	Sun, 21 Sep 2025 12:20:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A81CBEAA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457206; cv=none; b=MgPGLahuo/34PDNh78Z4Y7WLBe26fskWNnyG5Z409EOK/zEfu9Mf3q8EzStzzu+ndpbqw3EbzaHP2m62Vs775n5cWmNBSDgiDn1mn0cMTQSVmD/VgaS2xkFVnRzU17+U4WV+j1cFvhseTveOMt4ymvzRmgiyZ67ooN6VmyC13m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457206; c=relaxed/simple;
	bh=J/W4x3MRc/tKU09OH4W/ATMRu2/jQCrR23muaPCSwek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Asjiub6lND0QgS37H3xNOlbDprMypYFY+BtvNh5B3oNrjuPwZ/Cb219xegxisORIQ8u7PB/L4wBtQyOFAHt+/r/B0akw6YxHGwe91pBFHxdd4vXZOjMCmuc8PDrD6h8aU9x1mftZ9mU72/BWE6JfrUbrjOmqFZLuElr0MHSqjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-889b8d95367so353913239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457204; x=1759062004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeCp9EBgCw/Y0ZO7peB+VSiGxEqLZdKVzJxZWpPmv+E=;
        b=S1aYXF4PmuN+bXysPH1+jSZUBstBFmyDn6NYsJ51VRVynjbBrNNMKcJ9BLJqRE9pCm
         TYtm8ZNLfQ8+K5deUSUQt6W7CHlrDnLD9qwiUvhSOUJ5jqQ8BE1dgjpCaqeQkiBITB8x
         SOpXniy3n0DhLSq280gkM74ExuS+/96rZsCT8YtnE0+9vw1wqhxl26/E2nKnrqXl7HKv
         1mzW1/ckIaWCkI0CoCqw351NSEvYI7H7/2JLxSu9Tq1PkhZkQi9GsmhIJY21QsIKv4YL
         ajeJGU/vk8cCGexP4DFpt/tpYCeCen5imxBKhEEejAuv87VTcN8TvVmzpp7v7Hz/AWxW
         iq3A==
X-Forwarded-Encrypted: i=1; AJvYcCX8yXiHkKS8ak1r4jJsgYOcNT0nfaAnt2y9u6RXYCWX3OXS9430o4Y1bQSHsuFfpTvKVSl/ky/VcW/Pddw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hxnmJutfPCVT5GAbaBtM7m0uCPEoOA1S+ekmZqRIgfnOlhK4
	3qKEAFrJi/k3136ZQmrXPgA3Jg5NXJKVD0J/3zt1WOL/iczYoCORjT7dSj0kh19nhN9gopmndO4
	7HgajuX2YOWipm/Ek1PI9O0K/hrYx6+Nb0OSvaDtdGoB2We4RsDv+JeKBPhs=
X-Google-Smtp-Source: AGHT+IH4Ww9mMkEEX31pWkncs6aejz3FOJVEHSvANaCyJsvGbLSc90LT1MmxMAvwXCi+lemFoIUC1N9Kiwdb6P6SRUp9SvoPbg51
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:423:f924:c885 with SMTP id
 e9e14a558f8ab-42481938b95mr150400825ab.13.1758457204443; Sun, 21 Sep 2025
 05:20:04 -0700 (PDT)
Date: Sun, 21 Sep 2025 05:20:04 -0700
In-Reply-To: <tencent_B8E8A6ED9ECC6C7B5E6F6C2F6D6DE096E40A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cfed74.a00a0220.37dadf.003d.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Tested-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com

Tested on:

commit:         f975f08c Merge tag 'for-6.17-rc6-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1761fe42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153a6712580000

Note: testing is done by a robot and is best-effort only.

