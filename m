Return-Path: <linux-kernel+bounces-849653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4774BD095D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E043BEBF9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99682EE5FC;
	Sun, 12 Oct 2025 18:09:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D313C3F2
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292548; cv=none; b=VBhROFvMqumParoxmhVXechp7x24c4EXBG7XL5gUyKwUNNWmodYlFKM7ASpWnIqL2Ttu2ZA4JTFitqErHH+TFFmj5YL8YyUF/22pmTZAaAzcE5sNMyO9EqTE8bFee39IJJkAhsK8Le6BgHgng7ShNHPqYsrcaoBo9MF6ZsptnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292548; c=relaxed/simple;
	bh=a+9HCxKO/Tfkvfjn7xjS1J+6aNIbnsvz+25qJ5fQ5R4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nIzamgVFgudFdFf03zjGlmd9tfzXXLpRyxHHJCZxCPrXOUBLUtbXm5b4x4bGmf6/q1AqVOeiK48jJs161t/spcoF5dkIjJS+c4+yV/Ma1IHaU8z19EA45OwE3csvDDhmelcUk9D13PTcbV45zad8qIYBFRs+aItckDhxdd6nVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so119227935ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292544; x=1760897344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/leuJgkCNBtUpYVE+Su3MFYXEIjS4NyQO4vf3iKTnc=;
        b=k/8hYFAGYI9T2YmNPSI9VRRAsUbsGWXFftB9sz1HxvVlqsTpSgaKbOLV/8KHvjU3R0
         ejNL/VlelCDW/B8YY/nRvo/Q7fWF3qM0zYrgrJGxaVq1gVIL5HvVWWpvBGd5ZjMwSBWG
         J0pxQ36y5EOVGovSILLiev8Ug2lCRydMOq4HgR2kOGbQFDYOVS3DAYnPSkci7dIloDC2
         AH3BWUeRcPuvgNRx62oAPtVqx2pIwx/Sro2zOG8cHTBC6qWkwj7ibGMtB7F5dUAzXR61
         B2F8G1u/DzhBcPt9HgxLUsd80vN5Isozq+VHdS1Pg77LPWinWpay0l4YqpTfa3IsQPir
         oiJw==
X-Forwarded-Encrypted: i=1; AJvYcCVjxMgJVSles76Qc1Qi4V+gXEWzQ04DZdtyInfjGcMI528rNfrdgcrjkhN/IfuKPR3BvNAw0EzGdSvg9pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoClsqQXYGWAYR+o0r/yy+AAOCLjz127XjTy9MPLOGiJfCSGtM
	vfA4s0iqTGtAwrLM2I5iL6H6D6zVsJPIwdFpmnU6HXtK+Xy5hSnoNZuqriCUj8Hq8jvF7z5+qqz
	rG0HB6qQbA+5XiX0cV4beHYjBrCASlBkk7tLB7wXcppGk8qM8uBg3DLLTEA4=
X-Google-Smtp-Source: AGHT+IGmnU9gzxOyIEyZM/nYdCOWItrNRsWybOvhvhqZhUPwXwalMG8YorhFABD3998xe/WOpgUtx3Wq6REShKXT929zrhtdA0CG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24b:0:b0:42f:94fd:318f with SMTP id
 e9e14a558f8ab-42f94fd33b7mr137649485ab.9.1760292544077; Sun, 12 Oct 2025
 11:09:04 -0700 (PDT)
Date: Sun, 12 Oct 2025 11:09:04 -0700
In-Reply-To: <1077447959.870110.1760291109361@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebeec0.050a0220.91a22.01de.GAE@google.com>
Subject: Re: [syzbot] [jfs?] WARNING in jfs_rename
From: syzbot <syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com
Tested-by: syzbot+9131ddfd7870623b719f@syzkaller.appspotmail.com

Tested on:

commit:         8765f467 Merge tag 'irq_urgent_for_v6.18_rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13035b34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=9131ddfd7870623b719f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154419e2580000

Note: testing is done by a robot and is best-effort only.

