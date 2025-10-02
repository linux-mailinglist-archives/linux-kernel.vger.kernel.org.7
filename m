Return-Path: <linux-kernel+bounces-839912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22FBB2B80
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C59D381782
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659E2C0F7E;
	Thu,  2 Oct 2025 07:43:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A45C96
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390985; cv=none; b=SZDuv0U0rlOqfx3c5g8E7H6OzP21FQVb1JqS5M8FeeoO0JsGcADg7yIJAv6EXpgTzG9L3lM5136K14BptoFZM22Ry1bdz6FueEZ2s8eeHINYpyZzL4fwSXkTZViL7XK/Hac+RMuEVdyx4MBKUcUmGbiCclGVQrj/B8GugFgyBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390985; c=relaxed/simple;
	bh=HgY3/HGtLj3cXpxmpHfse2TLnd49nDH8poVR7G2lBTA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VYUmw0bqbjDvIaAGmv5kIJ1HHDJV+hfwuB9oNkO9CGi2Zf5ThnWgSqDWEK6xRbQ7HvXXMF9a8/b+bddzPBnnjImATcLcrfFBLZ/Hqog85DLldWfOucpuFZXplBwSp0OuUk+dmwiBovibWqU1wzbGHcDHrV14Cr4BRrxsRs0es1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88c2f1635e1so75214739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390983; x=1759995783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YUCcaBy+G9laxYcZnASoKrRmgvQIa1jZOET6kvtulg=;
        b=VzikVMFcgpj6vCCxEFu5Mq6aYpMoV9ipWIdfS40OSz0a9+BhTy+F0k7uZQC5b37uYe
         SA/vFuxgtKX0ZOXBlCATIGYy7Xhz+tcu0G2Nl/5X6i3YU8SIpf3+6+4ja+fF2hFtUlAy
         9j8pJOwjWeX1Bjy3x1zORiFIerVkLqQAd/jNGjO8hCpAlkYtRT2IidrKp9yrnUvivBCN
         R4zPBSSpDMarzn2DLN0tXzpi4FN0sx+CD6yOeAD+CX+fNq+T/NN6Qf3hH9DXjiH+l0Sm
         s4PMnWcTqPO+LlulRRKkyJtKRUwh3eCCO8yabWZBJ4qPNfqMQ0VO4Bh5HRBVTcs7iA9L
         giUg==
X-Forwarded-Encrypted: i=1; AJvYcCWj3flpwbAy4waQdhhvJgyO5o0Gl8e1alhY7rGFtoN2AXbdIoqiv4rp3yxbf5YzcUKLTv4+5q4u5ap4iV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmcNiQFz+JXGi04dyLnIkfRWneMcRnCoiAoTZBkFoMk1vSSL2
	qhyR+3IVD/o6XaOZAseiNbutfttJ3C8otj9Pm+XWx9Etdh4gJqlVo/KN48AzD5zF9gLiogLW2o1
	54t9OzZWIppu1XpMOZVzKmhcJih4I+/jv+XgpWx6KLFiz6qAg2ABQrE5qtEg=
X-Google-Smtp-Source: AGHT+IH0IEfBsW1Kns06HwWLMafqdDR7mZQRz4yHc2QTCkLnuaF2Lk5u9eX2yUDgyIU6NA9QEY/ATtK73+S0gHetRfgBoPLY320t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140d:b0:8b6:6784:1bb0 with SMTP id
 ca18e2360f4ac-937ac559449mr679102739f.10.1759390982955; Thu, 02 Oct 2025
 00:43:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 00:43:02 -0700
In-Reply-To: <CADfthj02rbyq6dhxB_DT=znADAUjLhKmWY8FLDq7z9k05-UdbQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de2d06.a00a0220.102ee.007d.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128e1334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0e9f5ceb8894f4a
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ac45cd980000

Note: testing is done by a robot and is best-effort only.

