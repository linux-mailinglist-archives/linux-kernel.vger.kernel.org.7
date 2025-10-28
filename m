Return-Path: <linux-kernel+bounces-872837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691DC12253
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533F319C0719
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A02D05D;
	Tue, 28 Oct 2025 00:10:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69218626
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610207; cv=none; b=eC9ZFqetV3eigHqCrFNDf9PjvrdppKD9Si7E1dlLXtSUzfz2+fjXwJHcpPZFTNuu2XjKiU9BQvZ/2wxEY0Ag6oOFhla5DOxXNPGRYLRWqJ7ks85NB7/Yi4fkUmaVkQqlqYv6KiABdptcrAPDE41X3CtfQPFU5TPC7onlaC9uzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610207; c=relaxed/simple;
	bh=fzFZjay8mmM5bbt1WFhLYVMCw9xTXthelq7ASLtGPuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g/rOXBLTPJqOLiDQJpIQbpfM9CKh3NGUDZ1EPAQf+qCTl8wh7bYv4EoQAoDIdeCbARh7L1qwRu7YUD2GIzarxGvc+wtko4Ag4iJQNLE9Gfqq3/joShWlh3JtY0ozwJPpMKonXz8rozc8DHDq1AL8Kil+Q3Ud6x7AUXUdEB4MbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-431d84fdb91so159093875ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610203; x=1762215003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6Z0mW5auIrtEQwo5h2ryIniLAb1A70e0USEKcCVR8A=;
        b=oRPPnFCqOaOFE1zuFl75RBW2QjkUUPT+UyxtRQQSKaq52rfvqXWIn9pncnEx4ffgIJ
         qpQ44KfCrVvQubY3nnSV0HcJ+DwjvKvUhtvkCD4LUXtGoHtcKrVp6/k+CwG4Z+g1OgUp
         GYl8xYiC//6nKqTs/jzr0znnK7u70bAhyN5WUXGgWmPjLwKUewb/ZSNgA7ljNmqzlm3m
         nUvdsYO+Lp3yjGP4eVsRLvxrYClWLHowRLBcJTNCy1tb+b4fEWGdUhjWdQ3PV3zdi8de
         f9pCdHtzPA1k1C79qvTthHlBW9mG3ZbTO1hbprajsg+GguQs2XIJkCqP+KIy0Qp2DtWG
         hCKw==
X-Forwarded-Encrypted: i=1; AJvYcCUKgY/dNbUeg9Y4CFy9y1Y84DWqlP5rozCIvZL1cHNkvPK/uoocKnUf8+sk8pbQcpcsMg+ulQoYeo0pIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpO0hm/q1qlodqXKObTF/M8GI5F+nput/UFcVq+VP6s0c2ofa
	xmUgcnvnKhYcLINEkadK/3J0jimvNrDUAylvT5WywqmRrfp8pyV15+nISbI99nh2q/hyxfTB83n
	WKtgAPeqQGnfgRcOYCG+/rqnjBqt0uyJi/lVAs2EnfJD80mhyxkX6mJD8kMA=
X-Google-Smtp-Source: AGHT+IGu5P/JXOfIAUFWbeY4ieYB3DWAsJEOGHEHEUjoL5K5UvP06+Bnb4QA+vWUqO6j0vwVQOEoXCKAn70Xgkwqvr6GBWgRsdq6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f06:b0:42e:2c30:285b with SMTP id
 e9e14a558f8ab-4320f838a0fmr26213675ab.20.1761610202831; Mon, 27 Oct 2025
 17:10:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:10:02 -0700
In-Reply-To: <1264655320.2784069.1761606404872@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690009da.050a0220.17b81f.0003.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in inode_set_ctime_current
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com
Tested-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com

Tested on:

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10aa832f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=cd7590567cc388f064f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1749ef34580000

Note: testing is done by a robot and is best-effort only.

