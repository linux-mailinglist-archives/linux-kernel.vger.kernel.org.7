Return-Path: <linux-kernel+bounces-616173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919BA988A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 13:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE325A36E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A9C26D4F9;
	Wed, 23 Apr 2025 11:33:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C8269D06
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408013; cv=none; b=q4FwVkvx6yP/1J5Zus4SQORraJ4MP4Fiel1QGeSLuc5f+V+Q9IyQjPp2ALqXaEO9LKsy8ogfLwZv/pXLx/JgEuFccS/BhOgJ8pOOovVFcrxBVFbDCS4WmXkFWh6Nx093Jrvma1fLcjIKN8suKg1bIwM7vu9dEXHExLXXIXifZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408013; c=relaxed/simple;
	bh=uBwNBy6e2qho9b1KDPMVFZUc5qPXPIPJiqNey/PPKps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YaqInVq4WMvy8HH2dbYEGea0+csDOOCU9t+ux3dsNLKiOQhHCOaAdIgFqCqk2TkIL61eJSEB5h2Qf3hXVigxuxI7KvX9PjWSNRSMPlUFh4wBjMzx1eLrlJT1U+gK3haiAvD0jUqykLMLMzfREMeDC14yRnxwdpfUPT04NEMxX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d81b9bb1b3so59446945ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 04:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408011; x=1746012811;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=by7DrroduhU0kTQwwybJNFfys8OUAmHf0NUzuH2xjiY=;
        b=PNJfdp69GxKkWBZRlC5kQ3M52i/cq1h+RybjukZABshu9AW5tg3BdKLuxwKe9hBYcp
         wM0lpVsdKVFjTFmpJpNgQt0P2DtdLxP8lI1RwAJ+EWpQWv5UNJaX4kHlOr7focWnZgKJ
         FFf3EOxHYd6lgb0XtNfluNz/Y/oolTzl37k/24kbgOu97Yx9GhLmhoXlJxy9STVegS38
         fjK/BM1cUehSSfAiF8d+I0PBbLTySH/GH7pZBmyZKGAcxoR/VBPXaVGjE+urWbct4uH7
         ZUlEufrbQ/3x5aUzUkumG+w+5cP6NBxNROIGKD4o7b7M2Ga02gnKSKr9c1IbO+u4dl6B
         UivQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYlos2mEUU3VvroIgMhyi2PFmeInhIcdfw9FPKEgNS7HHhUdGFoLA/xlXxQNiQScInsPI6wmHqy05eNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmjIwPLwQrCXsEGLRdxWh28kpqN2jpYlIdTKkJJsdDGK0NmiO
	QR+uaeG/E1K0F+F+fvP5UhSbx5QDsEN00AZLNJ/Q/ePdHjMh00j4IdLRCbGzjABK/X5POyJAz95
	uUxwj/F43HY/rVLzaOwgb+6BT7rlnnHHzw7ZKvPecjcLjGuIeKY/Rwf4=
X-Google-Smtp-Source: AGHT+IH8Z1AWTNurHAyBR3YCwTMX3e7pCDleTcSFSfT+ZBs0txTVUHOkllnBcX+UFTr7EU3+sYzIxheCCwniFk01/8NLkRZS0xBN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:3d3:fbae:3978 with SMTP id
 e9e14a558f8ab-3d88eda88b8mr150959195ab.9.1745408011006; Wed, 23 Apr 2025
 04:33:31 -0700 (PDT)
Date: Wed, 23 Apr 2025 04:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6808d00a.050a0220.7184a.0010.GAE@google.com>
Subject: [syzbot] linux-next build error (21)
From: syzbot <syzbot+19396db90a543f153fad@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6ac908f24cd7 Add linux-next specific files for 20250423
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=160e9a6f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3bf8ea2b5f8ef14
dashboard link: https://syzkaller.appspot.com/bug?extid=19396db90a543f153fad
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19396db90a543f153fad@syzkaller.appspotmail.com

kernel/dma/coherent.c:410:1: error: static assertion expression is not an integral constant expression
kernel/dma/contiguous.c:497:1: error: static assertion expression is not an integral constant expression
drivers/clk/clk-fixed-rate.c:197:1: error: static assertion expression is not an integral constant expression
drivers/clk/clk-fixed-factor.c:379:1: error: static assertion expression is not an integral constant expression

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

