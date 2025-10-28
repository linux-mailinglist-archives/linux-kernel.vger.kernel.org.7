Return-Path: <linux-kernel+bounces-874903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76927C1769B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3350D1A2445E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F913064AE;
	Tue, 28 Oct 2025 23:52:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA305E27
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695524; cv=none; b=p85A/VMDFWSR64qVrseXjyAi52E0GFTWgO6FGCtDdrmHW6/15vgcYVUOSqx6dc3+hlnqw0MRKuiUQ3TcDnITYuMgqCZP1lGbhpAYIoHiRa4N47CUpXFD+QXF5b2HNsbjkbx/qL9pNcYuFOokn77ZSMh6I4lRUF0nVrJaYQYQ1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695524; c=relaxed/simple;
	bh=uGkSSVuJ/N5l/TIQFimhCSNNpG2nEsvsPNgXu999t7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mLJv4+mE14hMaH260Mu0ox33tsv51yuBQ+4+T157A3WUkXMQ25Ycx1YEbsqUOeO9VO7RfYB2lVdYlrmoP+qmMklZ54VlUQo1btnH5LOduitDdWmeJr2egapeh87fCVZnmVPHlmwb7hLUy6iQwSzxbtgrnjvF2KEhKxq3JFAxl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430ced58cd2so242919665ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695522; x=1762300322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9+vde9L9W9dBoPTK0llIL2Hwu+poqDEZvWXXwYtUkU=;
        b=grKsIFSR6XBUUnvC1cnhFS3+//2ZpnO89+fuqI8RE8hOTuqnHCPGTNk1FRRbfUXWqZ
         wwe3524olhVBJBBRyIzEM3qL0EB+ksHcXI5Zy8jC4NysN8teJskBeQtjZmFmmTCq/R9p
         xsKahaRov7s5eCEG/55dPqer1qirz2J/cMSz7XT6HYsql09ik1LaGXInprV3K0eq002l
         xDF7FwPspsdy0oymBM35dDUg9o6qYEmeUFVjCdGygp3Wkw7n9AExe85DF998xVSWVcoG
         HVzENdBkC09YB4WgtaDrgt/pSs9ozywIaOEjREBql0Yydkl+tGw7q95VjPvaCtE/bQXN
         jj7g==
X-Forwarded-Encrypted: i=1; AJvYcCVFaom606mCBP+RE5M3IY9/8RgCr5rSz7AImXjofGCZWa3/HNXDw6KXEEwp5fPvHpVII9ZAXAZ68rYPgWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5Bm8kXrdVK9lGoVfRZg1yyPlz8lYdwUiosDOygadog121cUo
	JQjgl3IQupOTREglWQX4eKEAHVVLQTFMZlHZxJFbqSBybMyUMeL8EGFfDZCVPdLk2+KeGIUfH2/
	iBjFKIVuG/k4kGOvXdgWJ6V5z7MiAT92rECTHXHBMydGRVnfKrcpkwZGO+4Q=
X-Google-Smtp-Source: AGHT+IHLCKXGea3x7t6x8GYyLSvZ3wAcPoXwuHWrv1qbT1B1ofzinJX52+1Di/ExcUqu1G/NTz/45Fao5mEogVv63ciVvdU3T6v1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c6:b0:430:9f96:23bb with SMTP id
 e9e14a558f8ab-432f8fad442mr12682955ab.8.1761695522035; Tue, 28 Oct 2025
 16:52:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:52:02 -0700
In-Reply-To: <CAHxJ8O-DsKCj085k8N97bGqgWnHUpa++2HE4Au+axkvMkAPRcw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015722.050a0220.32483.01e2.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_file
From: syzbot <syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Tested-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com

Tested on:

commit:         8eefed8f Merge tag 'nfsd-6.18-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135c1258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dd0e4f446d638a
dashboard link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114af614580000

Note: testing is done by a robot and is best-effort only.

