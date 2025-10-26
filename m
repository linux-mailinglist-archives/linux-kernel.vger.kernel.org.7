Return-Path: <linux-kernel+bounces-870371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA8C0A896
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480973AE2CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB9242D62;
	Sun, 26 Oct 2025 13:31:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88719DF8D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485468; cv=none; b=HFwwYawuJs/+FMDxJkP1YqPAtXcwPgZm1uO/NLLZwsfa1KrhKV49XCSYVVxuuTf6syoy3t6j5VDrHF7FWxZp61g90DC37qVOhfUQjPBFuYA+8mOzfbHAwdi8LVNluCdvJ5Q65Gfk3aYZdExcQuP2fkGcBT9cqh+TC2DcSoqe80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485468; c=relaxed/simple;
	bh=bDf110AlXtv+VnvFhl4VKWo32kn+Ar4IxaVUYUQf3oI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QJ9HaZ7VvS6ObpBJ/OHYtbJy4q2tBgs2KmeFkjtTutMyvUs9Xt6darkIrvc4/we5J8ppvjitKXKOTv7hC6FA+jQX+DGU38IfSZzSle/aiSDj8XCF06ErdWjIHR4KFb+1+X+oOgiJGAUk/Gkomfh03YPbYHrifusVFBOaeCKrQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430e1a4a129so47907635ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761485466; x=1762090266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4ALCs6kaWDA5nJlzDG7U3TtxLYTKIHQn7g5VmhKLv8=;
        b=pQwPonPnUfsx3l5wS8txadSmh/zzp8AJDinyPeg/ksTcK/DK3z+ge/vb9oWPENz+nF
         BdoDllnCvSgQ5B8nLydHpBfafI1VhBHl+GJJ+ZdzteQ4UNoeL1R7Vrkst9w9eDJ6AFbU
         mpvRSZ3xId4+DONpZ+PGpvQYbJftzctApyD5WWVF/3shpCwvcxmnCKFnY1mroL9yaohb
         C5GbmqbovJrx6m1mcAWAyfkROtbBAOs0IL3LDF9fr68TJyIVhYCRbi3dzyhY8Iuo2Yef
         NGrrd2rua03wz3F6go6ph9p5vQwko1I2MXFBG9YHvuPEDC/ZcpUUTAtpTzXf+A9K7THd
         tjBA==
X-Forwarded-Encrypted: i=1; AJvYcCUTtan4G+CUSnj0sorv1qV4zq+ChI2JMaoXmbSM6AZqvTPknc3zb7zUHBCDMCrCAmLY3zJJL9bFmhRuhpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBDWxDr4Xn1c9Eym+p3dKVbs1od73sRq19YwYubMMyyQVI9Ev
	zZ0kYLaYqAmukkpAbo8MSIMoNsgx8ax3+fvCAxPm8dSAZBq/fcwVsbAS59WKWpApxqTsj53prp0
	Msa2TiU3y4ZfnIADrhMST1S2rNdRbhIH+k7MoaGUyWzeIf9Dl1ALSCZkKxxw=
X-Google-Smtp-Source: AGHT+IGPbeJTCC97WbxNt2jkBxxCwuw1/mXjaALFktblj4ldAOvv+jJSI8qQU+emb/k/daEbHJ7BZ/3W2mKq286l0DYz2B38HijV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:430:8bff:c5a2 with SMTP id
 e9e14a558f8ab-431ebef1db7mr97211755ab.30.1761485465810; Sun, 26 Oct 2025
 06:31:05 -0700 (PDT)
Date: Sun, 26 Oct 2025 06:31:05 -0700
In-Reply-To: <CAPqLRf1xv2B+qfrR3Qq5L-AhD7Gn9tZ98M=LBo-B+DbOkn05uw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe2299.050a0220.3344a1.00a0.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

Tested on:

commit:         72761a7e Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111a7b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0d3e651b4bf498
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145827e2580000

Note: testing is done by a robot and is best-effort only.

