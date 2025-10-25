Return-Path: <linux-kernel+bounces-870067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3903C09DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1364F46C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5E2D9784;
	Sat, 25 Oct 2025 16:43:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437901DE8BE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410587; cv=none; b=M+G5OmNMypfMXcb05tq3ZYJOXUoMo0oD75V+nlU0t5T1plUnuGLz4L0wxp78R1CHQmF+kwmG/h1q53pN3IdSBE1DZVwTxgOguiMUO41GB6LBlRESpwrtLmE2T5/Q3vCtpTyPX5PI7don0p52raddfABDHVutSgU4igtA0A4aaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410587; c=relaxed/simple;
	bh=4JkVmAqnU4JyznV0nba/jwlw4U+Ff+ZlHLoFxt2TEpE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fg6bBuooS+Z+qAyaTctNao6AEeL5aOjnEuURnGofQcz1iabMMNnf/9dW5i+SsG/GYSZpxF/a51nNniXpUdWcLhd9yWTNNeDctWE+zHcFNQQBVOlP4ut6+2X59nGv4GAGiMYzaQ04Po4ap1nTLPHm0vQMIWau+m5htLiw1ygnOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afceae09so35130025ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410582; x=1762015382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXMpskhSaFH/uBSbU35Otfq6GuSaMBgqf17YrN3BtBw=;
        b=IQE1H65SzJlBmBHUFoK4B/NSNmP3RGIHqjP8fr3+fAfdCvvlxZ4Il9sPqryaZJ/1YS
         B4vQ6Bk5hJWPY0HfHOTtJxkrVCxn7+bgVnh1dMuOAD88c+zicSL17JaYYXTkWKSe5w8N
         SHQWyqrmYhvT7T8/BIk7g+3KlAnMGHre7BbbaGSGc8qko4C7zICIe8ueNMuIDrNtJAU0
         DsmYFhmB9kz/TVIBSq6vBoICRdl97j/Al4rv+IeGgTV2U5xNs9aO6+bCLV8Y3HJmIGAn
         dnTts+Jadq7GC73KVJW5y6dsBxfJCQ/Zv8etXrD+I9ioUoxOSYcmH/03vVQK6i476yWF
         As8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf/xQ5roOdNFQTmjVTLSfrLPHLlxOWE93cGVWFAE1HpG8HPMJz69HQ3Ok8+7+MLDkImts4JBR0ltuKZuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPbCRUsOhUJ2/4mJ5uIKxBRL7Fm7LBdu2LztClfu2oXLHBVYI
	IE1tKTS6lakO621K5nzsnhDjZm+qUgSQ0Du8KO2q0Y3Eqx5w9RyT3BoH9NwgAz+wwzX3VHxofXw
	JBW2KkOs+cDPisiBiv0vOahRQn/USFwt7q81v6smUJQ3bXmSYp13Dz8BTx7E=
X-Google-Smtp-Source: AGHT+IEwu10woP+ou+FESnPo8XQtxARDMQxoVyJIbuOf4etKwABBGADZHwCBGVR7OpfXWyla77lkmFsq9fvbI9dCv93qYDTsPSUc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:431:d83a:9c7 with SMTP id
 e9e14a558f8ab-431ebed4198mr81811815ab.24.1761410582420; Sat, 25 Oct 2025
 09:43:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:43:02 -0700
In-Reply-To: <hmzw6ng2gv6ctvgjhpttxuodpxriz63kpcnu7keywc2aioiw3v@x5xcenq5whr7>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcfe16.a70a0220.12011.0002.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d91d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10214be2580000

Note: testing is done by a robot and is best-effort only.

