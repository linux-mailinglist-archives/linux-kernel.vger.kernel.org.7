Return-Path: <linux-kernel+bounces-840902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A14BB5AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9603BD72F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A6C13AD05;
	Fri,  3 Oct 2025 00:44:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA2175BF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452249; cv=none; b=bHEPlnLXSbsD2irZf8dm4Gl0FaVVu72DLbFRiWQodgNYllxdeJ44B9xkIjG1LLkzMZZIzrM3JTVUEUusV/Hncsr9tjmsj8VsmPQRcQkrRvAsgEyG6O5M2Nh2Z5BfZ498ZYxq+veJkzTTgJCKYVGnX2D0dl2BUGtslgfr1R38oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452249; c=relaxed/simple;
	bh=bVUVWfUE9j7TRIaKTBQ6VjJa9kSzAQfQmnWZY460BvM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GBr5jor/ZEV6AEC3WJbI2PRpFiwMxSWw5Qv4gCDjU0MmvmXLu6VJLaBIKDyi4WuS9AeuAbzQNfpvc+Mfs2O0P4MY1LGlu6k2DDybG8luCBKicf/HO8YkVbamxhI3XuK5sH/6rNptCHeH4W3bin21SiNlQOGdstbBFFVygkJo+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-937ce715b90so362960539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452243; x=1760057043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DB6rk783n/dxOfpuMSrSsBzsYrGxddc5NRnLEKImi08=;
        b=WBVw8gEz2FOumKn9U0e14OEHooI8J4MuLbKXDttwqFBrzcoZpDpsbpYfAR4eJLJ1eR
         66gLWDgoRVMeV9ybdva+zOAdhSvHOAYNTMeS6itPMvMRs1sFu69RKKrBpeduc7BzpZPL
         1+wwUKsHxL0EDM+3P2CaPdpvqeI2zNsCac7duXtvxDV++jJFteDGecl6/tI4OwEo0YtV
         cg8tV7G7vKIfNof8qO9HSwykzdRENqE8JOZKItM0PMc296gsienSd/VybX27aZYM/sia
         n0sAZv1iMFgay84EoIuBDLMAON52Vsx8j3plV5n0OnET/42uZjD6DGsnrn7WLlTPAY00
         MLYg==
X-Forwarded-Encrypted: i=1; AJvYcCW6r43fSPRz+PcZu4Nggm0eeyUGuxYTlFL80cH92eF7M/GPY/PbGMAcCAUrkDXJDJGX3INyv+umv8gUidI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVfQOLYF69zJYeojXuGQGFMK37eeTJWfAesYvZbtM0ewOdQeF
	YpDnD50vyyTZ7qOQTO/TBeB/tq2eHT7/BQUKO5ocikdEjqnELhxRbmXpfr5IIWYu4iZ9omu0mSs
	m/ozw3SfuwUNQw1InJGlhX3D+gVNMQw601g86eA3A747Ki0UOJAPNDJ3b0m8=
X-Google-Smtp-Source: AGHT+IH4Quq2Vwh14KBUQl2GBVEOFb+saFBYEuDwFxj/wqYfG/HPUrY5xw+PUMytvLw5w1NAcZnTJVy7nhjbEqSyevqPgR5zPvcU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a08:b0:42d:8af3:74b6 with SMTP id
 e9e14a558f8ab-42e7b242598mr10289725ab.12.1759452243383; Thu, 02 Oct 2025
 17:44:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:44:03 -0700
In-Reply-To: <20251003002303.2398961-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df1c53.050a0220.2c17c1.000c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10341ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bc5f6d89013f5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1030d942580000

Note: testing is done by a robot and is best-effort only.

