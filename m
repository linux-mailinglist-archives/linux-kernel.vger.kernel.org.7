Return-Path: <linux-kernel+bounces-773476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF59B2A0C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5EA1885600
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516AA261B92;
	Mon, 18 Aug 2025 11:42:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF152E229F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517326; cv=none; b=W73/j3vzOoxMm5Zvdgi5Kd6C8MLJZG1sMyubJy5t95JafJ/lWutc2IaBrufT++ZahVln3VVobY2fB/0x8h8k0CSRB8cbG7HnjKcwH7nJXMM7FkD2kKYL2JXJOdizgr2l3zVhRCNGGX/eqpsPvadk9QuFi7X60giIo4HnNyZdpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517326; c=relaxed/simple;
	bh=AJVHwASVjghqYW8sxs8M/9CaP7vYAt+blu6nmVZosos=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BLPkw4akEdHq0iz93txHNOP1LZOBZ2pgfO2XajuA7MdSDBEZ3+A1+PQU8i899NyqoqwCuZRukx9+DJlDdzzkOOEh8f0/gUHJnfZ8sp+hSztJ09LOiyskWSS33i1OmANe6dY51+a4YJI2FCAYJAyASXl5Wb3TO1bdnxtwwpMkFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-884328d81aaso518048039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755517323; x=1756122123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7Yhf0T4XRLYdOFtlk1c/boW5NrsaswK0wqf7mY8sQc=;
        b=n/NqjtyhoGHUhBaFINALr9BYuNmjxiid1C73C5ZUDMIz1jndY6zqXIw5pd3jfwgpbH
         x4uJYj05TL3YlAqKLOP+QcqnLmF9NT6FS1gt4/NKbLI0HpLprmfVxukBtIMMOXlwq5px
         OEfZWQkpSsyHf47jQL6d/4GPK0mG5xHD0349TPrRd9hJt6eV7HkH1Vs/hXA1VbY4UGjI
         wAeXLF1SWuFNWu/fjUg+D5NRQ9SngDtZmLBtJGuF+aWTSavPvyMUhc298B5PB6X3dMcE
         aC+V5PzaSaTNh68K8bwa6pwFCBj/vJVryD+SgrIRtaCz/YQq5tuZ7g+MahrEeH6/2LHx
         0o4g==
X-Forwarded-Encrypted: i=1; AJvYcCX1MhCgenncdvLCVhupxcotyEHQzJOpOdTcTAYxBwWsSRxRSy9mhq4r90faxvQIYgQMsOIMzYxrR9re6dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3/JV6X0p7D93j6Luvoe3x+h07geuBCaMj/A036qujtiVSid3
	Qj0tFVfSx8DMuBCNnlsBfXwDIZ/Dzt/ywIesRRn0v8G4RiXqb4xw3aSvyozF9KXQHzxue8I5ezf
	5VK1HP6+8GCRuANhFw5Sd+r56zx5QttaBImQ76dBz4SFsXdapuWn7YQk5sXg=
X-Google-Smtp-Source: AGHT+IHrR0LEa+2cdVLKjYd0udN1mP0847OBOxiYKOoeOWLg0ueMyozZpFlJq1gzAqupTDIwq2ErxRmmEGD2IWEokuog8mk8nRjB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36ca:b0:884:4543:fa56 with SMTP id
 ca18e2360f4ac-8844543fab8mr2052102839f.8.1755517323487; Mon, 18 Aug 2025
 04:42:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 04:42:03 -0700
In-Reply-To: <20250818100758.5020-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a3118b.050a0220.e29e5.00a2.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in vfree (2)
From: syzbot <syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com
Tested-by: syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com

Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a85234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86c8eaeb53db06
dashboard link: https://syzkaller.appspot.com/bug?extid=f65a2014305525a9f816
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bba442580000

Note: testing is done by a robot and is best-effort only.

