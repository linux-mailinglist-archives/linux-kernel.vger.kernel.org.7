Return-Path: <linux-kernel+bounces-833477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D1BA21C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC42A6F45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573828371;
	Fri, 26 Sep 2025 00:50:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CA625
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758847806; cv=none; b=ZDUCboGm3EV2qPSGeSUM+8mqucBmomdwaIT+3Qmd2vJAXl4jURSAn9ZwmwZ8NKo17mjfZAVYP+9tHOm2yX/fqpQTsuk9OCkEGqPixlOcgeUJ3ih9ITvxHxr9ywPTKUjS1lP2EuLYFdHgmNpyBSpoRTEVZbxAyEZi8CKkM+FD4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758847806; c=relaxed/simple;
	bh=uEFfr4G3GR20KTwoYldZlHy381ysNxDdDVtnnR+Mhlw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bMTT26N8y1p7r68tZnOMJ0ZgzhUdx8kA9GpBZU4ZPkcu9R4IXcpeqgHFa63lhwSnfKCZXB9uIsdSRKph57NQ2ve01ljOWZYGsNhN3kjvtw+KvUIVZAgxH3SwK5xpuXZEyFfN1fpRmMe61/DqXkbc9UfrW4U9yAT665dQsJ4WJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-893dd6dfe1fso205206639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758847802; x=1759452602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nw3kDYvGU5OS1XXgwfTlRzqwYVwai98//cC9KXbZWbs=;
        b=HUOzhC3t3AYY3mqCHsDcvfRsEJ45EYeZiA6zKPGd5ojjxrxO5vGiF59BYfnxNra8Zq
         P86kqBqIRkQsYuDldQrg7m3T2QpqhJRUITsD5h2ihiqjLvmu8xEwoMVjBd0ALxad/Ifm
         5wwHixji2RHYq0uCjE4LTMOo8mLAX0Y3rncr1yFysHKbtrBEqoKCD25DOJwbZCm1o9sY
         eddmqTOSWXCkXIDjYjXZ/RYgLCbKLXu5rmI4T1NnHoMLTBHVZEyvWulNeZlC3Y6vwM+r
         /SXH2SZPOmGQ92bhY3tN9XU1/tDbez3a7ekYvyOrTbF1sntM3FOPYbR0RMXdPHUbob9c
         +WvA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8fMJgTA5n7qcvHiAz/kfQE03NRM9q8UWIkXQSqrYn+NvHrjjxrPqxSnitepPHy8WmJAFNrKwW16egcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzQ9DEVmM7cfv9PEmpX+0bxpXd/TmB6OGBLXGxog06LBSTl66
	bWnALEacaAmiq3OX7HOFoBuVR/R+QYulciRslEib3nDD5u77igYW2bdTYhOw8cPeeeYWLGD7USS
	4OK+dOkSnsDdvH2DJ4JSscjW7y4RujlRxKAPG12tfJ5cAgDrFutSZFOERlrA=
X-Google-Smtp-Source: AGHT+IEJgqn6Mj1rWgI6+7tIS8FhOKsYrlHtzb0nbphUvibLvnwg7FsQKbPpVFA469hQUmEb9uYjnNhL/mzcZba89TROIsPVQymV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:425:6f0b:a1db with SMTP id
 e9e14a558f8ab-4259560a54cmr89467485ab.9.1758847802767; Thu, 25 Sep 2025
 17:50:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:50:02 -0700
In-Reply-To: <20250925231946.5171-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5e33a.050a0220.25d7ab.00b7.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         8e2755d7 Add linux-next specific files for 20250925
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f1af12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ba7bd7be9b0a083
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123474e2580000

Note: testing is done by a robot and is best-effort only.

