Return-Path: <linux-kernel+bounces-847264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF517BCA639
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C12535471C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDF242D7D;
	Thu,  9 Oct 2025 17:36:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5354654
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031366; cv=none; b=AS3+B6K6Utp1Nqr9PFiJtSuwkOlQoKLHGUzMt7VTwVE+mK5bmlNBCoOSljjZC7Q8UboJ5yp8ZUmsGrNmOUFFQBZD7ZRauX93CobOzzztBi4El1L3a3xlp6MQyEkrzr9BERhhyM1ZwZznOwsZU/IkvfU3ZDvsOAuJPIuAMm+kQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031366; c=relaxed/simple;
	bh=OpV4TsGF92X3oiskZRRC6V3HdMHdVZa3kcGuZNK4DV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qQ/1W1K+omY0d3NuzX/J1zg5X1NfEqc2O31P1HJgWIeKSCVzv9TH39jDBuhnyXkkLWh3+BQZWhHnFYoyFMG8jY8txHkV8dtkwmxO7YuJnUuld9G/faMMUHm0m6NT49V9xYf5Rw7SL2o3ZAenXvbjx7hMahYVtYbsGVCyPWRiNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f86e96381so28071685ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031363; x=1760636163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4/wNl39+2c4C44X8Q+rbUZnGlTwKglY852L6exZeSg=;
        b=OcD79nfH9CYEK3egNhbgJmDnsIUa6tw/pMn0kxgcUp9mX43hjq3LXV97b0x6xcbU2v
         d2/vAlzg3QHgJUXRXSMHcmLI8THUuvRHAHpgYyaRE35xVPawiJ2KQG+mZN26+XiThWHC
         PJfEpYW1AhHrkZTJHQ6Ayw6Mhc9i2q+bexrAmJObRDuhg+kznnKiV1R5ahZPwW+WuebZ
         xDnyE+HSKwRyWYn1YJsFLO26yyBjbeVcF1wwF2FG5wTZCttzSevu6VJSHxN7vmLvER6v
         IVzdFsf9FkhaSkbDnhPu9Qgz9+mLe4J7y148fuRPG6Z2gAlkZLMFyOGBt3VlOEjiRdFK
         QoiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsrDmRWetdiesFj+2Y+tedzOhHoIrgQf8EE6Mdq0fI0fffzVgF17xlYq5oV/6vuhCnrhYgqtgTEVoErVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6I4bH/OCn+/e13ScRlOZs68qCAOB5qFjWBFtZOuhEYLCYHQf
	MfPTw7XRQjF5imp31tr8VHTQtew44HBEZxxTJGb0MLalg85vJ0NTyzkbfXpuBNfRIEkf3vHkEoV
	vYtqJ4FWsXDTr1drkunr3PHIukCRSqIIFUK/hr0r8dZZ/vszLQCXXyQwez0I=
X-Google-Smtp-Source: AGHT+IFyyeL+us2LF1YiBURzVWw058rW2fTifH+zt9ge+YLvksn3kTnKBmg033NPurehAtV13ccGg8ZWLR65I3gruITP4jFbFG/L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:42d:8a3f:ec8b with SMTP id
 e9e14a558f8ab-42f87362229mr74454055ab.3.1760031363121; Thu, 09 Oct 2025
 10:36:03 -0700 (PDT)
Date: Thu, 09 Oct 2025 10:36:03 -0700
In-Reply-To: <d9f47040-4a12-4584-8293-8bc2719cf263@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7f283.050a0220.91a22.000b.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_waitid_wait
From: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com
Tested-by: syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com

Tested on:

commit:         554d1823 io_uring/waitid: use io_waitid_remove_wq() co..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git syztest
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe1304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6da9233e22696ba7
dashboard link: https://syzkaller.appspot.com/bug?extid=b9e83021d9c642a33d8c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

