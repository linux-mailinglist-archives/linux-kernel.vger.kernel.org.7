Return-Path: <linux-kernel+bounces-711904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E8AF0192
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 19:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D851C236E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9FD27FB2D;
	Tue,  1 Jul 2025 17:08:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331C26F45F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389685; cv=none; b=gjeOtZqwk11lNa17fsV8/dklUd6KfQL33ELigwUaTPAIGEalZH9/1DzUFbqxghbmCefHNtMiJtdT4Jyeg/DIKi8FQ3HYjtZISYi2I8PNTnztCnsmWQCqgWG3n2hwRao0KCwGrybyFLY/sks/PBMPWKyQvSX1C18dwTtjiYR1IYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389685; c=relaxed/simple;
	bh=lGNM49zBAJ4nfrkgrwFTURqaXAtC/maqVZynbpwjkjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rsDQb18giT4VoVJsjAS4BMgqWLFAfy5bQD658c4rJ7uNXnLprpsnIHNWWbcEiTudkbJJB2ykRZXheD6jhIvPmkPEnACmWvgiuOIpCdpKzU9w9q/rzn4+TuoOr68eKlmsAlFSn0wd2xR7nD7TV/Z50PQWBLP/qUwbJwtWA/QhxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86463467dddso300094839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 10:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389683; x=1751994483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JU+KXye9+FPkFTKWwvrCpuyPFHhsroEvlenk5AA3kC4=;
        b=xSvIzxs1XbzQ8NYZ8V92KHn1yYqLLwopS63PR7lLiBnFstW0qAt7+GV1oJAqM0BKt0
         cZ+VC17WNnR9k0Y3GvIpLigccOxcg2ODAXvbPJAndZupP7sc5QvV20kxqDY2VvGBegwi
         ggrUNcJ3RArSiNJT21fn9Rk6WaC72jgrn3uuYyTNZXlxDdxdMFnYaI5BCDgOmo6hrpnG
         BUFgyUCbXjgR0/hpt4X0fT1V2OZx7ohIdGwfZqrZbfIj9lMqLrw68vCPhdVFnvsM+yE5
         L1boZtR5ro4Cb1MwohOxeuogIwPZorOsI7MO0LbYUhpcciUko2Shz89I72vCQJNMLnly
         ZXsg==
X-Forwarded-Encrypted: i=1; AJvYcCVkrXMAlKYBcaiDagTEuyMBW4rkEBI29ejlvAfb+tEVZyfOvnNjU7hrPZKfFcAiiH+KMqfMGLhmNlMQxQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sZh868ZrzwMIwgBVfslnqtC3tHEI5E3kCl17DX9tY4rsImIq
	VqU0AOECAerJF0SekLf0ss3sKVEVkHfA4jdPsuM0pJb6MslXQv4y87chS+7F8/hYV6Ltl/PMb6q
	J+gE8WDGYjO/n3NDPlGVBiwCFilrJn18Wn6AZMwOlsFGo1VqodRoaZDTbnAU=
X-Google-Smtp-Source: AGHT+IG5/C1zGPsp7HYnW/T/uNOu8dvXINXfscxI4yiyLKvJc3Emb3PO1MoZ9EOIl4GvGgrhbiFNCORI2cdNP6UssGaPAkKay6cA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150a:b0:861:7237:9021 with SMTP id
 ca18e2360f4ac-8768825cdd2mr2212540739f.3.1751389683140; Tue, 01 Jul 2025
 10:08:03 -0700 (PDT)
Date: Tue, 01 Jul 2025 10:08:03 -0700
In-Reply-To: <000000000000d62d530617ca4c33@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686415f3.a70a0220.3b7e22.1ec0.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] KASAN: slab-out-of-bounds Read in poly1305_update_arch
From: syzbot <syzbot+9375e47164f8e9588f17@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	herbert@gondor.apana.org.au, hpa@zytor.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d89a34b14df5c205de698c23c3950b2b947cdb97
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Sat Jun 14 09:18:07 2025 +0000

    bcachefs: Move bset size check before csum check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1460388c580000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=9375e47164f8e9588f17
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196bc97180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bc9a4c980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Move bset size check before csum check

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

