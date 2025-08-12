Return-Path: <linux-kernel+bounces-765107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CDB22B81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AF02A6EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595D92EFDBC;
	Tue, 12 Aug 2025 15:16:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2262AD2D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011764; cv=none; b=NJ3BvB0H/hobwKKGiTRPSeTktspY11/JIaVD1k+kbHqUZ39oeFnIC906ybx+DB0B91nmiCytwjtI7au/coU7FHg6diso1ljx8MJc6P1aMhEpno+8ULw0F3hV4xMOXPLDeVHs0oMIv44VB3MLWmB6ciAJ/zsSA/O6haFqCijQHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011764; c=relaxed/simple;
	bh=CX7jPNBn7wxHARtwbasBXDJhtc1XYMRaU2FDSRT8og0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n+6DhYUE5egm6dhf3AWA7ZpwkHyZhO9QixGqnRQNje2Kvt69TA/pHXbblu8zGekPVuppT5735yqxjgPPR+lmXd+QCnAqXaXvbqFLaooEdAp/hM5oJkvRGJEh0C/wsgQGIConp5oQsnUAkPSXTwUcOKZkFudviN1z2iAU2DCQb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8649be94fa1so1461298239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755011762; x=1755616562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWq6cCoKkW1g55Zadx4S5Qv5nNw1dNlm8R48LpFQV0k=;
        b=h9aWtFqXbTOdDF/WeDrOjdoOirm+kTK7M7FCCoGLtHNLxkJrC4jMM1mOb/Sbbslnts
         Rhcbg0Nnng7DWNnFW+Oah+u8qlnppLQfptCxvj2XFPVSg+ubsyRSsSMDioWiJ3r80g5k
         FNd7ZLTgjkf2sMDRMeMj6qBIoXhLLmC5U21mK2x+81XjXJKVcMqTvJloZ+wat2eiMpfc
         X3cxLOX17d1DHE6/yCNi3kxRJ0YI4n4NKpWWOMk3/PqYUIOYuizcJiFetsXa/Tgz1mAv
         3wqcNAt5rZQFuF1FVou9zabZExxZ1mQ6m6OfXeuj+0+EYIf8Z0LcdgnYq3fJj+UCZ2hf
         V6mA==
X-Forwarded-Encrypted: i=1; AJvYcCULOPPkckw5fCqUZr7+rsLN7XXUt5q7FB+yW/y4R6obG6aXW8HaeB+N12tUDeKwmIYEUqtauZI58JTcSS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM/1WuOL87JJpUMeB2Epmjog4iewSgv9MLTh2nvqNXhyOikxi
	dyxyTiaJoKyqQyHYbm8tFSaCHvZW5xXojRQM7Kim7AHmAvnoPQ96jWI66jCe6OrV2gRs3AYB4HU
	pGl60axRBJoQnEt8E3J2tIDSWXEZuQ3YeT0ItTXw6ckVQJOnJY4bq2BbFFHU=
X-Google-Smtp-Source: AGHT+IFAtRFmDMXP8YmlixQvA4ItwKf/d1GVjNY3gW59Mw0I2eM2GZcQtOM75tW9gQGugm6R/XnPdvQMGrgt5XYIiHumKALNVZrR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6011:b0:883:f419:e3a8 with SMTP id
 ca18e2360f4ac-8841be8dc77mr579261639f.7.1755011762428; Tue, 12 Aug 2025
 08:16:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:16:02 -0700
In-Reply-To: <20250812145648.4310-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b5ab2.050a0220.51d73.00b0.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for netdevsim3 to become free. Usage count = 2


Tested on:

commit:         53e760d8 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a335a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13164c34580000


