Return-Path: <linux-kernel+bounces-756319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F239EB1B2A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6528189CF3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21318258CD3;
	Tue,  5 Aug 2025 11:34:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1D241691
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393644; cv=none; b=IrNnnGCae/gAxUynBGDfhaOmHHDrV9LuYkGVu6V0POoaO9Wfm/SM6KKvSupKM+IX3IVTMJFPb+48FwDRRPxnSl6tq594yJdL2ltp2RABBaGJ8uXITVJpBKnyMSMAB3+gx5azrNPwRHK1V08bFnfAXHKKa5Kmrcogriaxnv2Td98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393644; c=relaxed/simple;
	bh=Sflcpsg0PD5XG5dljOG1ybZHenmBO0Bu1t55tSERMg8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbmeowSJqZ+dJup2fttQ7XRZPZ7x87uCB9M1yIc6RsbrC6/ALH4nMj7MHsrWqNYdOVjmHmy5jFe0Nv3ZBh6GP5lLFmLlnRSwbz1heWIktDJgiGU4VAmMRw9SqPwxm1jW/oLH414GTdxYxhW/iBfj/3cIdWVaWApDpB40d2IMt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88174f2d224so236214039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754393642; x=1754998442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95FWEmXIfrIEO/zYb45Z4W0pP1aqivE7KsjXCppK0uA=;
        b=hft1tQAE+IiCua1hNyWjYr5gyY8q2+VtLRYc9W7md7T+8dD50no69lfa4GJcGr0RHw
         /KxHpXG72Selzq0o0R/8SctE3U00jmSodV6qJ2oIhdItn5aFfOdN2YeS6iB85YTHgyqV
         YSqZzX3yPxLdai6SySv+HN5aTV72J1T26tBp/U1WecZMVk4t4FGlDYRfXZHWdIWTYvoQ
         04czOkfu8qxaVmg+9nksU2AV0taTy1+B9KVsoU8gfyswSuyF95sRouD6pv5LFOw874KU
         M1jf7BVaPG8nRJzhrNqJUhLkafFOJI/3IoYnOj1xn/bzXsf6FTLfnGJIHC2528oKr56x
         jAbw==
X-Forwarded-Encrypted: i=1; AJvYcCXLq5JjINNJArBoxm28gbtcgLLdNkdyy3egOM2pdUnMxqibHfcuBmepOLLmfqUNSBKTaiAU4Nos+zpprbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8sVpfFCxPV2npQW0eawsG8LtYLQ9H1yaDXGtBidGye286eAD
	HhoGbrH+oJaHqd/WnwNQUPqyZlpBQ2ucSxhCN9rQl1r5RIPFpwGHzYC55vzqVt+RFPh4dh+PmmW
	5U7QmSICrbqeRgOFvZ4SZ/UJaatJWAu04mCpT1KYGWhYmGwCv5IF0A89Kv4w=
X-Google-Smtp-Source: AGHT+IFMu0t0Nn/b9qQTRS7KeyLXQj5B5JqMmtkPaTMaH+YrEoz27P7XhK1L1Ba/Tj2GJG85jei9IWOi9alFMFHti0KIahs+RlUF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2507:b0:3e3:c918:e3b6 with SMTP id
 e9e14a558f8ab-3e41607aa64mr220823675ab.0.1754393642206; Tue, 05 Aug 2025
 04:34:02 -0700 (PDT)
Date: Tue, 05 Aug 2025 04:34:02 -0700
In-Reply-To: <67f66c9c.050a0220.25d1c8.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6891ec2a.050a0220.7f033.0021.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: null-ptr-deref Write in rcuref_put (4)
From: syzbot <syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com>
To: atenart@kernel.org, davem@davemloft.net, dawid.osuchowski@linux.intel.com, 
	edumazet@google.com, gal@nvidia.com, horms@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de9c4861fb42f0cd72da844c3c34f692d5895b7b
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jul 29 08:02:07 2025 +0000

    pptp: ensure minimal skb length in pptp_xmit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cb2042580000
start commit:   5c5a10f0be96 Add linux-next specific files for 20250804
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142b2042580000
console output: https://syzkaller.appspot.com/x/log.txt?x=102b2042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4ccbd076877954b
dashboard link: https://syzkaller.appspot.com/bug?extid=27d7cfbc93457e472e00
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1628faa2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12490434580000

Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com
Fixes: de9c4861fb42 ("pptp: ensure minimal skb length in pptp_xmit()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

