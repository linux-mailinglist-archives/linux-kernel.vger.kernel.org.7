Return-Path: <linux-kernel+bounces-792577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15BB3C602
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B01C818E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D353FFD;
	Sat, 30 Aug 2025 00:06:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76120191
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512364; cv=none; b=ooSNnymYOw3BXr1oxayOD3WWqX39pRCzSA5mY8I2ATZTFbOntfN9FTUNQwpVLNdYxphiBerNwOEbh+bdsjUiMr4R3RwJwO+kFU3FseR2yO8NAx7jK7GoPvJ8zLLgadYcbTOHRWMM79TEiwYbS6pnmc8dZWlcRV8u0tistYw28O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512364; c=relaxed/simple;
	bh=zoRQlWYjSRtrHtkuhENexsAuhMGRUA8iw9umQOgXtNU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RoZxs0YYbr8o/FlqpWNGbgsorV5UQUSBxAGKSjU+/9Jhm563hAfSrsqouR3OodMQIaXN3pPF15sX8zFuXaemOG0spLlDRbTEBmvYj9aD53cnMlQVGXxsdAL0uCQHDjribD7fBU73GmjW4w1lA4F+Wc/o1yWt4hyIeozUJzvKK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8870e77d31bso372590639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756512362; x=1757117162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPwIJr83OOiOrOvJNnQwQo6sczvTMrs9wgSQP9HaOf8=;
        b=Ht+HAKV7wsDIyUUwPiSe8OdwAxh5kRN0QZ/6RIkjQlI9Cg5RFOwi0fMOTzNFJAi889
         Ui/5XTEOC+iZnWZgz0VkxrwXnrwaSGI9RZXFGs1d2yoNqlzcFpIGSSQlNbiNWxI/dtKs
         k3Alxm1H9skGWBnXxYCQ574fgzVcgKYeA0GaemwuQtVZ2GV1v9UTDRKpTyAgnwZV/Ups
         fO9eGpGAMD4XiH+uCTwAxiI/VdC9uzyEtaqTj5m/30iJe6y7zUkFi5AWGuBa3ixwP8K5
         5Vj1b3kj2yRW9CIOTBUDV0RuTS3mSiByIuF71acu4ajFiSkSiCEZlEmXwbQBPMEa8d26
         Lflw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5o5JHSbFvz9gA6llqUb0gr/QaIOssFEHs8ukzj0U7Z7c5m1SLzR5sUkFgN1Xm3sr+cxW/9dr9HIB14I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+T6xBEysreaifAKhIoGacqNevVH46+JunlNmv+hsoodSnZqU
	tuLNCSf/KpuGD53v03SKmyzzJ2EPXE5tQ7R+85UlvOWSc2czmhjZnWw/XrG82ITGs73kWsr2mWn
	h5wgiLPugGk9MHfS14pyVw3lcioKU/Ed9WKl8NYgbqkifgVNRuu7E9mRlNNo=
X-Google-Smtp-Source: AGHT+IGS4MjUvuBUzFelAc/TkrLIxgjXujY8JD7wF/mNfz5vdBBd30lWZc1FTkcV7rNtn3W8GceodYn/Al4zbVxLFamU50La0eXs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc5:b0:3f3:ee32:375c with SMTP id
 e9e14a558f8ab-3f3ffda8782mr10398005ab.2.1756512362698; Fri, 29 Aug 2025
 17:06:02 -0700 (PDT)
Date: Fri, 29 Aug 2025 17:06:02 -0700
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00f0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b2406a.a00a0220.1337b0.001e.GAE@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
From: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	mingo@redhat.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d2d6422f8bd17c6bb205133e290625a564194496
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri Sep 6 10:59:04 2024 +0000

    x86: Allow to enable PREEMPT_RT.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12db5634580000
start commit:   07d9df80082b Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11db5634580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16db5634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=10b4363fb0f46527f3f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10307262580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17110242580000

Reported-by: syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com
Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

