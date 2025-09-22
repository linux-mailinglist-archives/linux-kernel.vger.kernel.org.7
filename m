Return-Path: <linux-kernel+bounces-827794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33266B93008
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A641907AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F22F291B;
	Mon, 22 Sep 2025 19:42:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0A4222590
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570125; cv=none; b=Z6jAWq0at8a71G/TrGfPkIbSXa13z19RXza1moEphlUdlImHPLY+I9cZbeDfWAqaMPKxKdTptNtSOLvUnF486f6g6W/pgDUtH2PvibvRD48wZb7fCODLGTXcCNzhlK/IkiXwD3DaFeqxK4OnDJcGdt24SeTQOHOzvmOe6Oo9mFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570125; c=relaxed/simple;
	bh=4ujGpaeGDUjd+SnIcWOdIskUJI9EivKuLUDyTNZHIfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u73Lddfx+U5M+x2kx24aLq+20IA1Hb1XvyURRKFJ7kTH0kTwc9kt2qftc2y74IWJl6ys91qUCT2uo76Vweh+mVYVp3ItxftM38Ud+qgJNLCeWvCmfzi9CUCNo9Rf3F04MY+iWiEqPqIpyknlHGk7EBgpIZq5fNghG6xI+VPvsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42570afa5d2so62331585ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570122; x=1759174922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiVhWYbXwEB5twvMMlSHvCBy2KkajPpqpRG8MrdHnNs=;
        b=DppkacXEiY5hZlRU2Tn5NusUURKGWqBriWL06Hi0Q6CqL05+3WCFn6Qp972erulfD2
         sKBUfn7lHVcChDn4pNFq+th1x49M+Cs0mJpNw2pBqs13npipQBkIQQ+JuEKTBfjdnSXW
         tuVNm2eYNWzA9iKz3GoCPutoVct0U9mi8fX8J7/8ZJwm1YIhPqVzAJCagfy2sBdqpJNI
         4Hnbprr2A88Pyg4x2C8JeJMmG36wrRRYeoqDYx1dAx5dbkWFdqpmUM18Zxe0C/IJ/ue4
         FiET6JXT7fpSz1iAs74QRDFYt/J7hKHF4et+DAM16Fe9EZF99Q2lpzUmAhptSS4a+3Bc
         O70Q==
X-Gm-Message-State: AOJu0YwKM4bW1UTP3ZmWcv7lOfkA/Me/zsjJRIR+PsXu32Xqa8TZHE6T
	883rWSqVX1Z1AXh8KRocMlf+ACa3egx5i50nxo7uCq/5HiQiMsANrb/I6/BihRICHlBj1Y4Zw/5
	JffDFk+NSu48363oVQc/irBOg8NAq9iarJqhaUmGwC45beWROEQk2nABv5p4=
X-Google-Smtp-Source: AGHT+IHnuDUdxMIbwSBjowlSB9NHjee6C6soIUirc92DwnG7mGCeznEjq7vsx6kuFeh8YUuQ2bDRRTVxCXfWMidrdglP/7Frz19B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:424:ed48:9acd with SMTP id
 e9e14a558f8ab-42581e8edf5mr1630985ab.27.1758570122643; Mon, 22 Sep 2025
 12:42:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:42:02 -0700
In-Reply-To: <20250922180305.163051-2-sidharthseela@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d1a68a.a70a0220.4f78.0002.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sidharthseela@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com
Tested-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

Tested on:

commit:         d4c7fccf Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119e427c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c1e8e2580000

Note: testing is done by a robot and is best-effort only.

