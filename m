Return-Path: <linux-kernel+bounces-875804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC2C19DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A2118913B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E26331A5D;
	Wed, 29 Oct 2025 10:39:12 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639892ECD36
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734352; cv=none; b=uir5LJeVlVgBEfqqTPqw3YLyRfJJQrmWqT9tXGSpkgAtElOxoJF4UVdotKcA90jmWYetkwPe4y+JYq76qj5Dc4H2YqrlS3DGuysCWGDUMBGYTj7h7JUincBuv0DhjnQBKHYCq+TtRwn2nReurNdjoa5vo/dOUyaw59yZIlELEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734352; c=relaxed/simple;
	bh=gKfbYjTwWEnD5qGvZ+jAX359lz2zBiSd9drhDidcSCc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PoCdtLXg3+tDVuX1q0wo2zFIyhH9ByWWoRj2JfcybdNExgkILORvN2eutVTnLq/TN6LNZuRWnhC5tWPqR6kGxf5yb92jdWqfU/vu7p4iVwIH3zEjv7hIhWJjQWJxgCuCyLtmIvy8/U1LUDbOIpDZXBSXnfZdRsFr54EJeir3r9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940e33d65b8so2077041639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734345; x=1762339145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8mx8oCUH+ytt7ZmKuXC0ixGuKT18ZqjQQQSKfrYqrM=;
        b=w7O1m6YMCMA43AJjOGIl/yhZKyeCiFU2jkSbcOdB2UpxVbd1X0dEiz5Qg3nSaWoAjo
         qVo5vRLCW6u24sbdv+6zQzh3+DnsZvxE5/7ux1jzYt/5AJF84XVe9nDOdPUFjAeD8skD
         n1I4KnMf8iTjcfu3EPNIUUyTJkzuela2C/F4BF103Dl+JDSdCQEpPqafNJFqv3KITd0t
         87gfgUTbl+KifeyR4B6e1OUBtC1hEuAGyKG6rIr8UAaJmEB8aMmMJGfrVtA/6BJ+Xg3h
         5z7oObrkSLeYlsOYd2jJljCXkhuI5ezOXG7kaaaFSpdpmNrf1/1kVhHbGGslD6To4P+t
         qjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5G7YZtTAP1CSFD6kH8l7gEsXBzrbs91Xzw+6h2zDTuZ7tFYy2dx4JFAsUZJT2kjSUY6rTcvrIMSvdSXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOpEzMxJJHF6gbvN/mVLi7wbMvVIgmSz8Iu5PdUsc1v1aCHxK
	QR/9pv07A4/XFtRnNoOoFhcgvs3UiXw2A5lkboe+T0WspXoM4SG8nATMTOFApCDCf4o3boNS1zo
	PlW7Gr/PZVKPEfYX18XRog4CmM3xmRheIOMo+84aKygEicCICKf1HOfqOYIk=
X-Google-Smtp-Source: AGHT+IH8dB+yTuxZJRlHXY7yRtE5WM3nMqo6+tzpv6ZLS5w4U6lZtiGKp18fZc47U+0SR68nHXfjJJys2QNYqOwqp5LJnL+7YDvP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2613:b0:430:9707:ef2f with SMTP id
 e9e14a558f8ab-432f9044a0emr29363915ab.25.1761734345645; Wed, 29 Oct 2025
 03:39:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 03:39:05 -0700
In-Reply-To: <CADfthj20y6KMBwQg-kT=be30X7hMOE7rPaS6OiDVLXDPgBub5g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901eec9.a70a0220.5b2ed.0013.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_file
From: syzbot <syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Tested-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1258232f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dd0e4f446d638a
dashboard link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1287f614580000

Note: testing is done by a robot and is best-effort only.

