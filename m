Return-Path: <linux-kernel+bounces-874784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD3C17149
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F63B0512
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480252DFA2B;
	Tue, 28 Oct 2025 21:41:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557052DECCB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687666; cv=none; b=M0fB3ec0OPl7vGq/nzCZfZde7utSchqqPLYAB65yd3/9qTfXZ1RFNeEa9/3oEiiWVZmLgMdl8D9jEk2dHyJdT51UClZw0E3XJHXno6hCKnTCk5UtPcuvAetx2/ftexm946l7zbnWJ9L/tH2uS3LHV5yee015qCVioxBBMAamq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687666; c=relaxed/simple;
	bh=/gN3clOYC01cpaZTKe0gQTSDXt/Y/5hVPoKKRSmCGTc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fa9FIqIihPaqg/spZPkBdi9CQPlhep5NZV+cLcXOQvqSvqFWqrrXdMbWdJqx4f4s2fhl9+0lBceRA/0Y4cQ7R23HKVmJjb9QrWEDrSFCZFL9MP4XRJTW4tDjuMNl0olFKpPJSJTWFaPvRk0IZBS3U2Iua/hTACXtwsUfCPxAQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430db5635d6so85757815ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687664; x=1762292464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MkoY91eaH1BJN8fhI/RSr3kTURDmnJEi41nlvMViuk=;
        b=EcOA73slvQjqKmximCztpuKfG/hn/ws5JD1lOBSJWnCK3ihL/p4hp/r4qL6tcqIme/
         GGmdgsGJP/AshVnlZaHU5C6fTdbnC4CjoeKYC82BdK0/dAcAJbf5DndDxJo0WvNX/ELj
         iG5cgIg2wkHvS/MxYfv0yKWhlJvBo9IZZ7vGEI0lc0Msj4yQnRNOr9SA4INVhyyg+6Lx
         wfSkt5opFijHt5UxtXVcm8SpJWGIpzbmQ4bkgeYPu5QWrapHa3ee/pws+LGJxr03BNy2
         6bTI9ISPLthoVH3QSmqcsVOeQgwZqAzNKZG4WuJFVLA16jl8rz9x6Ue+El4Ot0PrbrQN
         vrag==
X-Forwarded-Encrypted: i=1; AJvYcCVv7lM3rTiB7XNwNPFYhIUBert/MJrOQtHhdWKLUodqqcQMNe1zm/KEWQa387n+10ARcXaTGt72VpKj4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2hMjK2DBRYMV90at5iE+UsDoNWCTPd9oHph9nH1OyPMFby/8
	r2wfUwBP2Ptax6eyICYbEXqs2qNnpHNDDuMGgGRSHF4bxgthTAEdqfpss/TpvRxoKkaf5hT2FMa
	unOmCrYETAUX3SbTmk01xMic7PUxELjci/vf7q84sQAJtNx9pMEueu6QNa60=
X-Google-Smtp-Source: AGHT+IH9J+ZtI3IrsE7kUkE7pDCxoEIkA7RszgRHVqwGVQktrP8YCrMH8wh5L4G+50gb0kEX3+2Eo72ZexXnPWrELEzIY3CURW4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-432f9044dffmr9290325ab.28.1761687664489; Tue, 28 Oct 2025
 14:41:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:41:04 -0700
In-Reply-To: <20251028182249.3Rgvk%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69013870.050a0220.3344a1.03f1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=104cf614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16db57e2580000

Note: testing is done by a robot and is best-effort only.

