Return-Path: <linux-kernel+bounces-835202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB239BA67DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C84F7A54F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46928DB49;
	Sun, 28 Sep 2025 04:45:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7C1DE3A4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034705; cv=none; b=kPE/pso6ej/EjSxyLy1N04YuFrlXd5I5sVkcNE0g8zLgoUXiBMeblF32Jpo40l7uuFqfajT6t2l7kE7Cy8t4qShQtuNLy8ZqDvT6owyKUFPaTGFq7TQGA8W2myhVDiHWg3NcoDn6O5vt4vR34+S0/AxKDswzaxOe0X9dUVRpg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034705; c=relaxed/simple;
	bh=ZRPJkYDahbCYgcNiXbH3CVDiRGxayddbM95DCpc37kI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZKgHTNbvxQV77MjPUYn7Qif8dDcmjY9Rj/JXU49FuGbO9GwTQn7qCKBv8aVsC4M91ZWzFZZNe4rYXq2vq10NTjZrClbPrr2ee864Rro33mM84sC27/2LYUH+Na9KFUrMBIkQXtLsXmLgSBdMPCfEgbajR6CGVbhTyQLhanVQA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4278a8ecfa0so58638735ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759034703; x=1759639503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmqu5lwdCKoySk+fKbYs/4CJ8cOzbhiG+ctxIG4Bju0=;
        b=V7Kye6PLwooUCTyXVYPSd1nqswufMxOyAmBL4bGxuk9carvCS5qA6RVHI3mJax6MeG
         O8RhnrVYgg6NO4wlPEvq/udZpb8MDu+tDtyMzHYE6etHr+YD9myhWh1r/Q9BKNFoH19m
         qCmIR4HQOG2lizrjH2jIAvomAPjFh+VaT9DWewS509coJovWBGurybPME6KlxDNpEIF0
         RuVe0PnlTbYy3HAkPoNfiIDRDmZ0ViJX2h12TOBMk4PgzoHrndtlBcx8Et18gzqyDZFI
         bK9UN6DkcvJSvcrv1ScnPExV0CXLlJZA/G5sHAJb971H2qwfmVD6dOVAhDLjayysFNJj
         rvng==
X-Gm-Message-State: AOJu0YycV/tARs7iHnlipin7xxwUW/dm60mXrc0vXfg6fguILSJ/7IwZ
	bBm6nZVsMzvUU+gt022MaDkFvAC3z71tOHwoSRQZY4bIykOd3ctyk5/cqjida2ufPl6xWqMQaVA
	zjmpBlXZ449X4/Uc5Zk2+NiARWV4FXzo8X+7Z3Gtv0VR6j02DnZGZJglUW/Q=
X-Google-Smtp-Source: AGHT+IFYq/xiaxb0XlTh80X6IBNpttZ4+ZL13a9PE6qHGJNiqbf7vm1FJmKH8Tk9zb4eZNcJn9d5rFAf0RRK9qZGN70Sf5vL/0yz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481b:b0:425:8aea:7313 with SMTP id
 e9e14a558f8ab-4259563c0bcmr179031455ab.18.1759034703517; Sat, 27 Sep 2025
 21:45:03 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:45:03 -0700
In-Reply-To: <87ikh32pm3.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d8bd4f.050a0220.25d7ab.047b.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Tested-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com

Tested on:

commit:         51a24b7d Merge tag 'trace-tools-v6.17-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137172e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc258b7c9b0229c1
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

