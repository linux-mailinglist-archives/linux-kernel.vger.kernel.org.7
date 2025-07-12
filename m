Return-Path: <linux-kernel+bounces-728665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACFB02BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1CF1AA0583
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9223274FF0;
	Sat, 12 Jul 2025 15:18:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5418D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333485; cv=none; b=KIWCZL0TU3CUlVoRSVoAeZk39ir1xPF6V27jUYcU6zxfaIQ/eekybggbqy4xzQhv7K23bvbS57JjMZ1GUUHJBU8mAX57LgBf4rBHeqQ/OEI0ioCAAOKHXqqR8quQv4VJ2U3SjK/W9Xa4fijq2UNt+m+kJJOV8Nvu6n59/4Svttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333485; c=relaxed/simple;
	bh=0VpQjvHq++pVoa9YdAiGcjE2M8N3TTSF3NJJI8/+I2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o5bu4tea3fRA18wJza/ppyJU9y5cakbBpfhyDFkqmnQDiDDABx99Fq8nvIVoRwa+jyAdIc9vaU17vvf8lWh8dUPHefVCqxAvhfboYO+XYzcu1/i4FAR9U4Iog4MFR+5Kf94ZLNbVxHy2oCn0cD0hsOVPkMFCpT4+M86cnRI/50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a65a7157so284204439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752333483; x=1752938283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeDNAN4KaCOqzz0u34xmMSQhrZ6LmZ/0AIyc5h0R558=;
        b=mOyv+mGU5VOCPQTjvygxBAsvRygI9VEkBNdZ9jDmBkPMbCgm8Jcr8dSJw1TJ18InUw
         ZZHfYNoFV2wZ34Bijo7EuZQ8CpErjn1mgoi9ShadAQnH226MGOJoSMKaoJf8hecgRaYf
         4y5pHM7SxVEB/KauPab8roSNGkqPxFbI3njCDnKVuG5+IpC5KfYCHLLiWBtq+zxkQtjN
         q3p+Xfv0HDpf9ng9ETFafUZMRbU7iGAzViE2miwnP4TaMwtEvz7hVxgfOeEP7hiqJuZj
         M3BpLkEHRI/EQet6Acr1o4AKz4yVfMp45FRrU8mJB1u1ze4/pK+jqpCdkgSB5b86Nl0l
         LrMA==
X-Gm-Message-State: AOJu0YxwCriPs8lDX43D77PeNlC3iJw1ktWAJ4HSlgY5LB+GhlsjLOF/
	tPrL1k4jpWadXXofYw8wEuapzyrTLLVc+rsL4qIQ26M933EnTyUeiz4HaAdG6pW9BzaxAHV2mHD
	rKEvCrG/a19CmY85TeKLy4SG84GU0Y5E7MzNaXkIU2cA/L18n7qrOk9uY2Zc=
X-Google-Smtp-Source: AGHT+IF6/JNtwZk5YpP0ho9rLumxe4FCDEk2DB9/tr/292jI010IxkZvl+L2YhYs5usdTWV+BhzjZAFVzaiEWJ6IPtvcLIwgKPVB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6786:b0:85d:ad56:af88 with SMTP id
 ca18e2360f4ac-87966f0a5a4mr955477939f.1.1752333483089; Sat, 12 Jul 2025
 08:18:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 08:18:03 -0700
In-Reply-To: <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68727cab.a00a0220.26a83e.0082.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in corrupted

INFO: task syz.2.18:6947 blocked for more than 140 seconds.
      Not tainted 6.16.0-rc5-syzkaller-00224-g379f604cc3dc-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.18        state:D


Tested on:

commit:         379f604c Merge tag 'pci-v6.16-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a310f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166b6d82580000


