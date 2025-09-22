Return-Path: <linux-kernel+bounces-827490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D83DB91E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D0D2A4D74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F62E0401;
	Mon, 22 Sep 2025 15:23:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AA27F73A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554587; cv=none; b=Merq6nuM94YMT4+spmj25ZrM313UzE3rRETHO5PAnEn8fkDZl+s948vbk/jDSQhL+b7K6qzIlRct4fHD+clIy+0wSus34I+r4RmPjmp63LUXRbQKHy6UPLuiKjvPPSVRlliFZTzCjMWC67dVYR8v30MF/ye0RNirv6ZV9Uajr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554587; c=relaxed/simple;
	bh=uACaGCYKkxJT43jgxw6J/+CMBMEUS6N2nCBuxQS15ko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MzaeQjRcPqfYRuvuI4fzzAkfeNDy2/0gfiFjnLGdEcUKSw3po3CRwJgXXIZSvGmG8W2xR8WRNql1lR1Ki9iGSUL0pxihDABjJSXPzyXJsZggbIQgOlokF2H8XTW/ahMJ909es65qmd/yQBmE9fOgUb/IXJcRz6iyZAQkiYP9cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4241c41110eso109516535ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758554584; x=1759159384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWDDzEx+QFBpsOFwARvEWpnp1B4L3Ye7IyedE+aHLVM=;
        b=Eh1cFlXfcoQoeI9B2gPzTRUX+BuSWys1foaqFMgqKFC5JDMu86p0xXwDTSn+ECbG7r
         pdrQ3huIXKrLCXgj448SjDSGAOXZMFmVnvbGw6zCOfOYw3phO8iS4KdDvgiKV67z4OMB
         kEvQrinWuSTvYBMT7bFtDCUtsgGmAewAkoX8LJ22sVVjbKuruLXxkgeVV1mzl83HYzSZ
         8Rjz4QlivKfYSFC85svBKIE4dU2EwkgiSusi7hcQMr/HbG5m4QsDtM0AEvnRVc4oRtkA
         3YR4fHGG2cX/bWPiFBNupJBauEmkLTzuR3ynwPXliH5v7lOpZSsGYzIGiroc7Lpch+NT
         owgQ==
X-Gm-Message-State: AOJu0YxKkTendCwiNEg4Y6exjmRlL6UEWG3jrynOAV6XopCCppWdwUfm
	vyUW/L8kwWqOz56xonXclS8hi5JoASdaFmxekEhLPkQCptmWo+rAeusFf3gFrrLwbYkvRQs/wjl
	nTSFEU54sb4xoOLq+LTpal8K+oaQLTwrvPNZmNUeHFGFTHHMkMR28oOhjkEw=
X-Google-Smtp-Source: AGHT+IHgCUuQ1sI1P+GUH4ssQ1uFW/s+lZLWgAwdf/y1rA/Y8js8g8JUsCWIZcgjnfPqZZoHKxgxDNxK7PuuxsLZoR/2iFlgnmZY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:415:fe45:3dfe with SMTP id
 e9e14a558f8ab-424818f7d6fmr215144735ab.3.1758554582015; Mon, 22 Sep 2025
 08:23:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:23:01 -0700
In-Reply-To: <CAPrAcgNJ_p2d8rwn1FZOiHhAGo8agX=UrGPAer-YW3OAk4ssNw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d169d5.050a0220.139b6.001a.GAE@google.com>
Subject: Re: [syzbot] [mm?] [net?] WARNING in max_vclocks_store
From: syzbot <syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com

Tested on:

commit:         07e27ad1 Linux 6.17-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1300427c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f55712580000

Note: testing is done by a robot and is best-effort only.

