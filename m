Return-Path: <linux-kernel+bounces-826164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69339B8DB91
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8283BC6C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600AB22FE10;
	Sun, 21 Sep 2025 13:06:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F32D4819
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459966; cv=none; b=YvHTDU8w7wPEZl7ZQMDwD96bVaMWii2FQaBH6Ei8ni2E57AMW9oBDXwltfCLfcgPJQhqiMEaTselGwMRn8cTMsk3/gmUjs8gwsAufoTHfuj1U0joil4aaMGlRDLrm7FJVFu0OEdBC7DOWwZJhIwkdrK542sQV2JooHJOUECSBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459966; c=relaxed/simple;
	bh=eRd3RzYqLOCCAYuhui+299GCD3XOaKJcpcBwn6s5/sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YF/ef8wxa6dIR9kLi/kPWLrJiG+uVG8Vd62qNmmXjoNedvNAPT8z2hqJ2lpQKz3o0jv+9f2U9UV1jukFlwXaCueZs5P3Y/YZ7PY3fIGXJUZqMZw77Y3miS2KpRHzks4L3RYYf4+WW0SSoSbBtJAKPGr5pe6HPb9xsCBqbaFeKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88778bf677cso683236539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758459962; x=1759064762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VitOOdivmYsdmoDyKRwcdNz5/IrpJ2XDV/1XXG7CF8o=;
        b=oYh9qEJcMnYVlSCAxHV6drmbwyd0zuc6WfafitWI/20niC7Px44NMSvW0KjC0Zgw0r
         kxNj8hKOPwPdYO/VBWvaG268uJYpHOPPLJUKfi0/XsoPfKG8WW6wje7ef/GptBMuysVe
         wJkyUZRDsGzBed3zzssZqV6jQKweo9iAxgYYgWbTeXDe2p50E7aU88cvYLMCKE2p/Flq
         ng35YME+k7Yy3VIkTs5FyYAEZvYcwQ0KJWJP46eCaKGRfGlt+VFn++IZpD/HAWTo24ik
         YjjN1OOzMR91Sk8KUKC1PRhiVyszwVmGs2CQyarrubBYhBo/sTgHaK+EtIp74YctO6Tk
         AqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCULMr6J05asNjaIj6nzt1bgaH/dfHk2ikk1kcZcjAV5gTLDF6rgD9/OVb3NK89Yc2fH4PLOl6TSZ3ltpRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGyPDR9SNJDi2VaWCti4avnejecLgwD8YZsID0xr6182UctaN
	xvfzwV87exi8v7brXsKYruFFokGYftszjrJ2q/6ai0bqjyR3m4STBSG2WeYUvMelhL3G+XycBl1
	/iSSBhw+fHDDWdNCUpFIrlPOllm1Xvfyr3CDG4QnUvm0II988KZUYHGlNa4U=
X-Google-Smtp-Source: AGHT+IHsQg9hNVUsmGySy4Eog8k4yGRP9nEAd0ckzEGdHk1dg/fkbWzqwMh1iy/AhMT+A7H4KEzmwnZpyh3BjVzRLrhnFXFSgD5i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:425:7291:22f with SMTP id
 e9e14a558f8ab-42572910296mr24952605ab.32.1758459962600; Sun, 21 Sep 2025
 06:06:02 -0700 (PDT)
Date: Sun, 21 Sep 2025 06:06:02 -0700
In-Reply-To: <20250921123825.7352-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cff83a.050a0220.13cd81.0035.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Tested-by: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com

Tested on:

commit:         f975f08c Merge tag 'for-6.17-rc6-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c9fe42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175e9534580000

Note: testing is done by a robot and is best-effort only.

