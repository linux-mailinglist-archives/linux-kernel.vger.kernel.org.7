Return-Path: <linux-kernel+bounces-872798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E87C12109
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949CC4E5178
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A908314A84;
	Mon, 27 Oct 2025 23:35:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039B2D877C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608105; cv=none; b=uuU1oM//85ZR3YPakJ8QeLcaUiGqiKERuaObON98/95/xujUcYm6SbhQS+3N9RGicaEwN4k6EkulAMt6u2Tje51gvSb5sVoxIGNPFIOgBFpcSrMifc2jKTQYXfAi3CYB7JUyUOkLhXRSlnLiAjjYC9gBHXXpy4vkSIkWmhivFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608105; c=relaxed/simple;
	bh=ScNSGL9voJZweKqS8/XctUHcL4COAxrZGQB8C1S6bAc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=quKLnXB40claYk5it0ir6dGfCkmJUtSsNIyiGmBx1g79DWCI2fFpJV7vzGNQiTRXdj9I3spetN3vPZYqBYN4oPpTKurzeOmTjvCcntgtiyEsJ3iRTzC+JCe9SyF1T4uhq0rDD+lNCSLVLqpQsmBmR/K7s4Wzg/T1jihzV5rrEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430ce62d138so66611615ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761608103; x=1762212903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5tt23mHTI/pAxK8zRJ17pQl3G2BjBuYhUrzhZ6k7xs=;
        b=ZrpSRaRwsIulNcejPOIn+nmn+LyldzNRvuWMNqROsRfQvhi8K62SVvtAFq6x3YZ/bY
         ZYDKaAviKewclVZtZj8bAAUWkTo6mPqDN6L7Yi97svnJ/lz+MU6Y1arC/KyCz761yFfY
         ygbogUWQ2sFAQoM9HKCEk579C9mOTN9bJNK3wbMQkUfvB6kLnB7s1JG51cnvRFmNqr+A
         gspGtcxTIhhZ98Z/MpZUqF1A+DXWAiYWcS+Iq6FSUvDewl9fSyVSCW+gZkh52v2rUSOu
         QOoghDjgtaKMttMIstU4C24eQ5eMB1HsCYSUQF+6h+WHQJpuFORxr7vmmVUMfjHsb2pR
         mfbQ==
X-Gm-Message-State: AOJu0Yz/njPFV8azyMRsKbzC+FgG970bDbjCB2LY4L3/BteSLcbv5DuU
	s+KiMKAq+y06Yn5mDMoygSI6oeSzUJD4JhDieRSkTCCbwZ8PmgB1Rb0kgiAc6TpiX2USYMjzHsD
	6ZOeMMlpbE9e86jsPWcf4GcREDbmBX4qXPAHOAF/aFVrlMpsFhEgxrh3tJpo=
X-Google-Smtp-Source: AGHT+IE/r8IsrIs+jAIO1tX8a7b4PKzDWnNcOhao5MFS9ZBqhuIoumvWOJ3o5H0Lwde0VImNSD00ToWUCDwWfk2jTaO8i7VCiaX7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:430:ab21:8c4d with SMTP id
 e9e14a558f8ab-4320f7bb713mr26392635ab.11.1761608102860; Mon, 27 Oct 2025
 16:35:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:35:02 -0700
In-Reply-To: <CAHjv_auu8L45PK56xgpFZPUb4CuqCRg+xdS4LFZ-0fU1ujfnPA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690001a6.050a0220.3344a1.03a9.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

Tested on:

commit:         b98c94ee arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1219ef34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d60b6f0d339ca06f
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106bd614580000

Note: testing is done by a robot and is best-effort only.

