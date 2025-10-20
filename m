Return-Path: <linux-kernel+bounces-860435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F79BF01EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E33824F0A34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3992F5301;
	Mon, 20 Oct 2025 09:16:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA832F3C30
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951767; cv=none; b=LCfJoxgHwrYyAxQ/xVbYL1Kl9JV/5YO8tdzCCYA8XuAUcGLD1XSjJxmSw89LBqVB7Ihu2wHH0NEoDGRR9T7oTG4F58Fae7eE/I70Y6bXkTDAFBgwiV+bIz/BLBunJnvST9upoaiW/kPq5BKHPFWHqz/1tHaLQ2e4T6ZeruOzIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951767; c=relaxed/simple;
	bh=c4PtZ5cktC9uu0vSK3tMudtlPfmR7MnQPC7VB3m/6ho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qEFi0sVNH8ah7AwE/cYIQWVPraW/pZ73pgp/ZD2o/sioXiTG/GsrRnOt6jzcCZmVUEQ0ZchtK62XCoeiBDyPdCQVFy1j6zccfwwP6yfzaTXYM8QwpDhGlFQrAuchyoXiSLJl/+9dIyScf+cSvOyC+tFEt0x3oFmzt5hR2Shpeh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c9176acaso34514675ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951762; x=1761556562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCyuvpVjGxrz8lwTG1cSy4lyHO8PZhtM24CUly0vPbI=;
        b=tH+uxI2USPedW9FtzFU6VlM6+ywFSPMfE5yFgB1hCroAy6g8jLR02fkOU6O/hIaKqx
         /S34aXLzUCOQdFFOXRMMpHLJ9nlC4f/+BUP5Uyl8YfOa1AkSTycadTTdk8jqjKSt1r/l
         7tShZ3qMRoE24i2D1rHuKkX30lHfe2OBnUfi6bpTtBbvBl8NhoNl6XRSrWa4wgZsig1Z
         nlGZGiEk/QAGtpPHih56lEPFPHlgApDd2kFQQJ8wgk/ZUtUPq9QOFtc4KIzO2RFWw5vj
         s5IRVIEM4nQjqi06GzmWfWi4V6skpomHyv79IhomjgvHv3+UQOsiBtrobq4smfaOv949
         qyLg==
X-Forwarded-Encrypted: i=1; AJvYcCWzWkjU7iqIrhH7/ElQcFkW6YrRFEDBukV4sEK2/IEa5QptGBLUgzlv9w0pWcp5Z0cBl6u4SWkD7++Z/aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ue3xFZhayQ63Cj6S80IIZydd38Bj9URUrFj23BZOMFCS5Dqa
	rVYggFjnsl62/1kg4ogBqIManBYE18AvOObMQkxaLfKUaKxU9sBHWnJUXCoKVa5CMTXKU5El4T9
	lBwvrbJUDfuLENe1M8pll5Cx5emFCg25cn28ctq+J0qCoOwKMVGZ8sGlxszk=
X-Google-Smtp-Source: AGHT+IF6/3ZnwBhbV9tOrCNf058OCn3eMsrNb1KSlZH7XD27rMYe4qviKRIC2MAzCz3qVvms1+hsnHf/keDaytD7AA1RV/OR3qkf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:430:b004:3d5c with SMTP id
 e9e14a558f8ab-430b4366fc0mr229009665ab.9.1760951762109; Mon, 20 Oct 2025
 02:16:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 02:16:02 -0700
In-Reply-To: <68b87c9f.050a0220.3db4df.01fa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5fdd2.050a0220.1be48.000a.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, chandna.linuxkernel@gmail.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kas@kernel.org, 
	kevin.brodsky@arm.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, nooraineqbal@gmail.com, peterz@infradead.org, 
	riel@surriel.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 86e6815b316ec0ea8c4bb3c16a033219a52b6060
Author: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date:   Fri Jun 6 17:10:35 2025 +0000

    x86/mm: Change cpa_flush() to call flush_kernel_range() directly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bb8d42580000
start commit:   f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11bb8d42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16bb8d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=e34177f6091df113ef20
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173dda14580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ab52f980000

Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call flush_kernel_range() directly")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

