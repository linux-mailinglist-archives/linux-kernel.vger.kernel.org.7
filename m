Return-Path: <linux-kernel+bounces-851127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19ABBD59AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A223E2ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86D27FD52;
	Mon, 13 Oct 2025 17:51:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712821FF47
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377867; cv=none; b=eBDdktHMFzS0QgU+hcJ/rBxWNjkXW6NoJJJv1nCcdQiqr40JkYmsktx9OlhJWWRQg/mDYCgel5Q3SBfQp2FMny48ORRR82T4YDDcVvXTxTceb7zWazl5GNTq9+9H0TPhb6gVoJ4gvW81nrUBDu9rELKu4N3672ZBiXA9mOgd/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377867; c=relaxed/simple;
	bh=ESmH6PDf/y025GTVQd9tAUQWKrM82DPTtOLdH3WIVbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rOH45RCld2Z0IYGmcteJdaDXWGeqrbrEmr1OmUWuuDxtr+dzExcwvsTw1c8hgP00cJ8MoblsAk3StmkmN17qsNAjwTf+LwNFuIqhoEDZf28QycPASlpkU2m6Un2Mumj6kYoOIXnEQXVLELE/JfAdRtK6Z/pGTYfib8PGjjnYOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42955823202so122543235ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377865; x=1760982665;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpBMfdidBE3O+0BxDMwBE/bLozZX3gjRZnFgwoDa/2w=;
        b=J+Fm0TaJz/htGOkmIZfUvouIg4Q6ji0HInMiE+sXtSsGzswJ6jPTovG1jfIMEPxFdP
         QPQj/hBzi5lBsAXLg/pyYQ/aQfpINcrBRFcGZ9IN/u3uHqNIo57jZ9Krcj1bGKS+uYE2
         zhQBbqz2daa53jtONXF4wCrtSFXYQuVbCB0aWYZMCaA8O0UfFis7hhdkXKXr23EQMI3C
         TF/vbEHEzb32F2jasFb5qNFHiPZGu0OdA6+dF1kVDM4Ren2mON9k7m7NbUXV3zI3FZ48
         ljeFPWE/ZL3WQiMnwrh4YJ77AZOam68+5XkxEjDr41lfKH0sQYZ7NZOMeG34ftok68+1
         SBsw==
X-Forwarded-Encrypted: i=1; AJvYcCUwilWydOPx3n2zVsvL/ARTEdnIeEYdxAsZ0wefYsKeKm7LSCNFkH6ayPGbrVX4P5vIdWvp806e173wEv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8OWu2zfgIQ4Sl2HS2eGtciiCE5B6k9Kqt/U1UTHp4HO4fzgr
	8ghYBBnLdd6fxgJgJ5qODrs/AeB5MHPT8q1pMSSmx67vfTFtAltgKCeg9saxA2sxG33BwMEVG+F
	y/wPnfsUXRgcLjlVjHeMUSUzYNLqqfGcSNI05njkPtOrUEXMLWENvHW5O6+Y=
X-Google-Smtp-Source: AGHT+IF0mRRqrrYbDkimSP3HVk6dixhTQT3Lv9MBcrqNeYt5SAiNW0Gr6ZCjlr87h57RmW7I20aL5cO0VXaaf/3qxAKYHl6kXh0n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:424:7128:a06a with SMTP id
 e9e14a558f8ab-42f87417ff1mr260568725ab.7.1760377865528; Mon, 13 Oct 2025
 10:51:05 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:51:05 -0700
In-Reply-To: <20251013162906.1265465-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed3c09.a70a0220.b3ac9.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1017867c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1620e3721dc97c0
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fd652f980000

Note: testing is done by a robot and is best-effort only.

