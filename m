Return-Path: <linux-kernel+bounces-735961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA87B095F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E794A8304
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A8224B03;
	Thu, 17 Jul 2025 20:49:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53203224B1B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785345; cv=none; b=l3gZf277Jpi2U6HWKEtzDvxmPbArHLOQMQZNMjt7qYl7i9wcidGLC/nQd5/eKDnMxkI09LXr8+S2ZzvV0ecsASqNWD1cUa64/fwHBmTjQOSGcWb7WWGgKfW8If5UR5T3p1qd1LW7OmGuH7dYpynAFxbQ0ZmU3t4CYnwLwq6BxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785345; c=relaxed/simple;
	bh=njUYsEgXkQ0hNuSVW45bgXJ1jRIG35uFopRW5zduEh4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RGanjuHk+j2UYQdndT5YFFkB7uxskDlWDgnIMKGP8csWCQUKUIql0/JCD697CiqJYmeAq690IbdA5b4JCG7iN8RfLF04ZeJQTx9/gpIRDNOvR/v/d949eaBc0CUzS3c6v5xVZHccH3g/jGk+40hQS12aqy1Hs3Y11OUOG8jqGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-879c1688420so237840139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785343; x=1753390143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMCCR4NjqinNx0Yb9BoXgWtnyOd8OzQojf3uYj8vk8g=;
        b=OQT28N9NTtwuLRpg69hIdGMw3XM7mmlzMd8JMUER9N/+90+ltNBp9Bei+ntH8xlvq3
         k9DZ7zbMR+50z3vyUREq0yVbvATk7I9+R4nXDYdyKqWFUUSaNVe3SLZxXNo1h63F9+xe
         PcD2njEC/ixYkNgiycPryYGVyD4yzP/foDk9W6sC1eN/vuNex8ZBOCG3Eiv4UvBMpp+O
         qsnF+jmtKKTUS1jz4mLSS2RXDo66VvSQpKYpYzS9epLgRJzia4OeCCS1GDuwXs3xaGys
         LmuxlJYrvhRKMiPGiSvnvwJBlR03LGUNSQiYpqf90OgDGk91YqFqxIr1cbPrq300rBnz
         /UBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEs7vHUurpw+so/nZPvk1CNOXSOJq5tvCXvtlZ/NpuV2rHXEKx/x8AOmRKuzGNBPRnpy4I1WAlIyg0REU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbN+N0ZM/MpW4gdxPm8qeDOK4Rxev7hi3lklqj6BWhMzWz+o5
	U7teqiUfQ/o1qC57/fF/pt8JnQ1XdsvLPkjvCRrNMSMK9g+dFkotHBMTtEhLUyV+4hwkRDs+42K
	KuoEx3xMKcIdjxJu4eehPx7KoSWUWkkOaozPbm2pShSQxqHPgSiII0QtYEaY=
X-Google-Smtp-Source: AGHT+IGYF7mheS3xQS8I3lc6hTphuwM361O6wySntxozH0dPZfPlv93Kcel02lBV84MKKUoXx9DZxTS4qov86q8EQM4OQgrS7vHQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:401a:b0:876:737:85da with SMTP id
 ca18e2360f4ac-87c0badb864mr173583839f.0.1752785343538; Thu, 17 Jul 2025
 13:49:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:49:03 -0700
In-Reply-To: <67b2eaf8.050a0220.173698.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687961bf.a00a0220.3af5df.0023.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in crypto_poly1305_update
From: syzbot <syzbot+d587b24799bd8c2d32f4@syzkaller.appspotmail.com>
To: bfoster@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, herbert@gondor.apana.org.au, hpa@zytor.com, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	mmpgouride@gmail.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d89a34b14df5c205de698c23c3950b2b947cdb97
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Sat Jun 14 09:18:07 2025 +0000

    bcachefs: Move bset size check before csum check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1722a58c580000
start commit:   2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=d587b24799bd8c2d32f4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4f2e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e4c498580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Move bset size check before csum check

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

