Return-Path: <linux-kernel+bounces-676979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D389AD13EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 20:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD315161B22
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEF1A314D;
	Sun,  8 Jun 2025 18:54:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DD1A5B91
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749408878; cv=none; b=F7Ak0ZAqZ3A/F1SvWKgQhX+Or72982bgZEx/RLQQBRFLy3GnubmaxVwL+Oxy+hZqhnYm2GiOOFI6jOpnP0ptuJLX3p8cZmqEW6ycG/yMuqMeF8NDPMromIHujwdgc4aZvDlxC7lAtRZ7g970ZwdSQvAc7CvyyQyl0Ab11XpVqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749408878; c=relaxed/simple;
	bh=0e+ZPgS4d1SgXPwa7fKgOCMnZMTdfvr8q/YXFT4v6JY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VIG1zN/yVXUIB8Gz72lOxADNcq0mY0Ahhr6Yabr783sX+OVRo71SGudrinIVAPhlDgi5Qbiv28J0FDE5tvcClCZ5rXuJj9gp7Dw402N9d1jMzWrwMMl0/jpqZ1UOqv/Se6hDpcfpW1abDoUO6mIZxG+pBzA4VzXhUd/Th7G0FGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so7344715ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jun 2025 11:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749408876; x=1750013676;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgsijAwwECKxtIfaX6vID5yInExtJ80pYGQbSecD5bU=;
        b=aa+sM7pQV/5Ho0AgsdV81CTFmOqC0Ih8fEo5v5soaSBkaNRPzYsQtwVCa6pwHtMKmr
         d3rDDRXDkqkWiSMEdsMdZNjhai9VeudBoXaF6rps1g+oNJ2NgK9xvyCOkT1r6h4zkJwo
         2Weq8dF/q6gHyQvCFkUFCXkETn2ni0CKubPeSU/kqVpP/Oa1qdaJjr+5GOQZ3vmKu4q1
         4aSCuVHDn/YvsX5h2GatmnuT1NKjZoHhYQaHOlhNuiuzskMvlQoqZuBL7jcy3gl5xn3k
         mYW/bo1FF1g0msMVARVstDCO0nSm9FlRHw4ADNLjOmNj1tsUhggZcTTxILiCF6i38T58
         s3Aw==
X-Gm-Message-State: AOJu0Yz6wQK0SIitObwOQDbCdPRnj/TvmfZBAkBfWhgMmHre7EyBMvgF
	HbISJ1Fn5V0Wgm17bvmHBg7qxxkPJT2CyKUt2Z7EG2Rz7GzBlMMkp9uZXfCvLP/7nvsLd47aQeW
	32vGxDDJvpbjwAWGW1hQYXsx6Z4Vhn/hlVh/CKnSngZAAoYwi333G3Uy0/0c=
X-Google-Smtp-Source: AGHT+IHf5dEhS9FMvjdPKtBV8GytrlcYVTCI2NIpJ8tGDRIK/eNSRgRaS0VwaIATVTJ/HlJah6BX1dNevklvOnswiYLBjrXNTnDX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:3dd:cacd:8fe2 with SMTP id
 e9e14a558f8ab-3ddce44f9f0mr133195335ab.18.1749408875995; Sun, 08 Jun 2025
 11:54:35 -0700 (PDT)
Date: Sun, 08 Jun 2025 11:54:35 -0700
In-Reply-To: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845dc6b.050a0220.daf97.0af4.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds
 Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
Author: ipravdin.official@gmail.com

#syz test

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..720cb79adf96 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 
        size = hdev->dump.tail - hdev->dump.head;
 
-       /* Emit a devcoredump with the available data */
-       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
-
        /* Send a copy to monitor as a diagnostic packet */
        skb = bt_skb_alloc(size, GFP_ATOMIC);
        if (skb) {
                skb_put_data(skb, hdev->dump.head, size);
                hci_recv_diag(hdev, skb);
        }
+
+       /* Emit a devcoredump with the available data */
+       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
 }

Ivan Pravdin


