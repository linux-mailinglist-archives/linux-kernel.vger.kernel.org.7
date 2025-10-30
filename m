Return-Path: <linux-kernel+bounces-879215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53099C228E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BD53B08DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42033B6E1;
	Thu, 30 Oct 2025 22:29:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FA31328D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863348; cv=none; b=a2E5XB/OsysUFtxPpZ1nbJZ9x+w4jiWX/mMETD2xaG9tS6ZQBwFoGc1DAa+7bVacM5pIogetCuVlf5x5MFd5JMPJl0Do1igalzF4V9m+1cxvmY7DCdn7l3ZUzRrfjhtMV9E3tGnJMhCmKmXmaFMIweooY31Tok73rtUz77DiNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863348; c=relaxed/simple;
	bh=kNgxO6FhX//pka83UnigwiUdfGuLc0ob87riglTRHZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fowBVvmHWK2awroXI++29l0BQde3pziLtdSFOLZEwsTswgOHJYF5PmdCigEEW62FCLjTOyxGpitLjdnpGg5pdfotGcgVH5FETw96eAhkgAjr16L0eiNyo0N6Z8BQLktO6Q0fX36ttEcw1PU1j94SZETcA9IwnmsknOp8c1Dv8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945c705df24so325573239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863343; x=1762468143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfmnIUG98kAZW3wPhM4jgyCipy8wdV4D/0XRh+wNgT4=;
        b=PDnu1EVfYJi0addh1r3dUwk2K3XTKjDxn3jXP65TZ1P6rYmMf0Uk9bm11gwbElRduo
         ZzA2VGH6Ol53lmn3vfdSLq2iXDFi34btNJ4dfcvOx2yqa+DZLbkyfx0kgh9y1f3whkc7
         v7frVE0kzIe+IX2V3ruOlkxcEvl8QZHVzMTnqOV7BOSQWCoe92b1M1R2wIICaoHxV4zZ
         EGRZDKieDS7o059hjJUN1VsbNyVROmKzisp1sjzBcuIK3sx+hTjaLh3zYXFYTVGj8e7d
         /IW8kGyzOmXcQa3aSPkkIM/A+UEoYPHTicyvT3qawCOxHRoZybu65VvWE8e4CgGTBwYj
         eo/Q==
X-Gm-Message-State: AOJu0Yz0FUWPizNOL1TD+PbsM81rg7gWPrXhFpaevUXfzvICWTMbGcIK
	2JluukfPpyqrEHGwKfdCu2dR72BA9c24bCBEhHQLM42l1A9vERT5Z0yMo5T971/tQKrPGDpIvUS
	h941en/T9+65bJEAkx9ePegYihF3Butshv1clQHTA3JNLpAQ1dzcOxjmiioU=
X-Google-Smtp-Source: AGHT+IFAR7O8tC6pzO1fipRqw4Rryg1W1HksbGJZDfRrZWnDVAhXioNisMIJxyqsvTDwjphyVJilbNRg/lGiR7JMXWLtks+/W0TH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2485:b0:430:c857:734e with SMTP id
 e9e14a558f8ab-4330cf069admr32085835ab.10.1761863343508; Thu, 30 Oct 2025
 15:29:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:29:03 -0700
In-Reply-To: <CAHjv_avAugj+r52YYT0i=OwOGTCEoEvQ5jWDhJj0mtTGmHGZqg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903e6af.050a0220.32483.0230.GAE@google.com>
Subject: Re: [syzbot] [bfs?] INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Tested-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1350d932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ea7c92580000

Note: testing is done by a robot and is best-effort only.

