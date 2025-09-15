Return-Path: <linux-kernel+bounces-817752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEFB58610
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0608D188A18A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D310298CAF;
	Mon, 15 Sep 2025 20:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3072610
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968264; cv=none; b=UYr/1PSD5nSYhIkCsMIZ3PTfyH4Ae4siPKaTpwTX90qm5R9qSDqmTPG2z5l3SQ1jAISqnBF7zj/YMbWzQ/daDJX7yAsKk2NCdDls+CxmWx34MHxy/yv/p8FuI6WoZm3HR8Y80QJuys6b9K+xC2Ehz2vsroaA76n+SSivnRGmHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968264; c=relaxed/simple;
	bh=b6xUAhSkq9CF20QAKR8T5QLGnQzzvGI5ZPW5RG7BblE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XR1mIVTq9cUu4usAa/IV6qSID8WNelvdXXHUwKVy0nF5GeSzwRpKifsYtbcuFq9KEULN6sVHFeBO5iyzxCwc5nCKMI1DX/N6I93oCWe2LYJ5d3uK+cZ3LCeSCIUKTTQC/gFA3xy0uRkXipxBuVBd7HKU+85CyJ1wfpaqJQbLhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-893620de179so341994439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968262; x=1758573062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSfa1TS/tc9azsXeHlqsi+zqwnTdr1EPZWX2g+MVJp4=;
        b=PttKeQK9Ih7gGjGVENz1tSLwnZqwYAvcWZL8sUwtXh4NtX9Iuz54zkgIky07o9GRCf
         z87Lotgg0adbn57oYZgK+0XsTnpzis3ZohBi7i0m/skrtMDZkHNpjArYiBcEiYe3Ktmn
         zwEKAT7apLHTdLwwFGoL1W5O5uiJfhWcoNqCSgxbcCKRPvMPnrCecKpyPYsrAZcimpP+
         Qjp3EuqJNaTb2GnRAA2XFhKLH6Ur9QDER4gCaWNqLXwwpz3B7wMDfW8K6tODeuZVBwpl
         H6VFt/r3omK2LmLlHoue12lMVu4JgQSKRNMwDQ0daYGQ+56O3eKhQA7JpvVSqN2KtCI7
         CC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxuvyuL83fI5GXMdUzxE6SbaTbFN0N9rU2MED17O49HWd1jFcVEmajUK0HPx2ivbifIN3P8W0Dx7rTtVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYXA17fy12ocw/VxLTbAFoR2nYjvcWV+iNK29DfEofYxdFVyi8
	Yr21PR5HKQTWCIMnyAQgnFzqQiKzHFYxjXJSfYQCYdrhq2QjF4+pvUdKFKr2MRap9KlKjOJEEeo
	KDpJLkXWsryp4l/JpjeO1e/yyjVvgBMlQWqQM6x2jWeWW7PLprY8oJz47Wac=
X-Google-Smtp-Source: AGHT+IHMZF8VsSDt1pYApy3XkiXUF1lcW/9T96gt2lhVyAj716cXCgtAjjDt0M2JEJTrdjas03ad8DK8GY+v0KtAVAkq8hgVMwAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3783:b0:409:d91f:a48f with SMTP id
 e9e14a558f8ab-420a42686eamr127681255ab.22.1757968262491; Mon, 15 Sep 2025
 13:31:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:31:02 -0700
In-Reply-To: <CAC_ur0onFzDuog+3e76qiG2mc15wxBxSSe45A-ESL3QmWyVcNA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c87786.050a0220.2ff435.03ae.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Tested-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com

Tested on:

commit:         f83ec76b Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103a1762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153f947c580000

Note: testing is done by a robot and is best-effort only.

