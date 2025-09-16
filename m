Return-Path: <linux-kernel+bounces-818088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1AB58C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF871B23365
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D312475D0;
	Tue, 16 Sep 2025 03:50:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BF1519A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994605; cv=none; b=XegQCuA7NCB+9aaZNuG+7XBz72bujUYEFea5PSYLranPVuylBUcyXEshO1uMGYbemU9nXGCWGnU/SILgjzTzzvnYflWcak/mSXir88mPxsQxgEKJspSb5e9kaWAJO3G+eh8v3hRvQTB8De8CsM+sY+zU/ZD81y7SOeDHrudbQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994605; c=relaxed/simple;
	bh=JSnfukqOADN2kn80OmWHnaFMqLRrNoKQAIVsV1FUMV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ppooFc4Pcn+VtZU/J86OS1PT+Rbo76GIeYFGS2ixSGLq6/oOY8sbFOgtQtqKNnPnJaH0e039QKUm0Eovib2FcbvWTbmlKi6JuatFzGKKlSSPleuiN4rYgTBRrUikkird7c0LzZqGPXqKGGlKxQdkK7uvHrn8GJ5bXCo+UdfYSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42408b2d55dso17580845ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757994603; x=1758599403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iuioZyvb9LZ0SUGtSeUjaLTUycNk5X2ZJgIMk86y1o=;
        b=deCxWyUs2kBjwiYp/sZ5bn+AxZ9BhCWgW7mgIBUJiobfWUc295vrBtqKyAt9lXjSur
         BsUcZr+IINCmWoGT4kbfInQoljajsVy8C2B8LKImcST4UzPToR+4F6Ma8iiqD51R1sGz
         dNF1iPjgOlhWOqveLQSCqNadrTrTY8um4x822/2JPbQHTf5D9l8/Yg/nASM55RrhL2lt
         p23rPEYS7ZfVL65TKKALVblsxtA60zp8kFcCXMJymWsidgH7KAHOSFHAYZf7W9x8dOk8
         0ZxiJh9+zTd+DHtxUuoCq/lDPZuBUqeSLxaaY+Gmmv2OREmqvhnLuorrftASL2CP5wZT
         I54A==
X-Forwarded-Encrypted: i=1; AJvYcCUmHoBUjufqbpJAAFDfkp4GZm/nDOh7dJYd247TwZZr3MTWY1XTX4OIXr1ckHvtRgcXVUz6kBhcNm8mQBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP40IWuHHYu4aa/5i1pbo2G96+lyuPA/zKRtFHmm1y7VPJa02I
	0By71nRnrJd1I7en/pWE5n/zsRORZF0Xv3XGST8dfJfHbP+Ws+NkECvudB6i/rPElBt1Yx95yub
	RXeuTiytGEtJsAO63uYpnmY18Y8kGyo5aXk58MrhglYir6eKWu0LM02+9A3k=
X-Google-Smtp-Source: AGHT+IH1Kj0pLDfdIXpjFMSEPpxwQh6SDcGPn2Imk407BqvlOLykHVEi+Jw3QKtMfl4Iqb8F/s9N2NxMiOS7ueMSjHSucVZ+VSfN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4503:b0:424:f57:ef58 with SMTP id
 e9e14a558f8ab-4240f57ef63mr14534085ab.3.1757994603113; Mon, 15 Sep 2025
 20:50:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:50:03 -0700
In-Reply-To: <68c85b0d.050a0220.2ff435.03a5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8de6b.050a0220.3c6139.0d26.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
From: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, luis.gerhorst@fau.de, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit dadb59104c6441f54d0c42bba3e4bd11e25fc6d9
Author: Luis Gerhorst <luis.gerhorst@fau.de>
Date:   Sat Jul 5 19:09:07 2025 +0000

    bpf: Fix aux usage after do_check_insn()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13850534580000
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10450534580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17850534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355f934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12170e42580000

Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
Fixes: dadb59104c64 ("bpf: Fix aux usage after do_check_insn()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

