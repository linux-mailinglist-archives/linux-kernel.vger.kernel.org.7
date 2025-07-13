Return-Path: <linux-kernel+bounces-728867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F9B02E43
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A39E482698
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE75223;
	Sun, 13 Jul 2025 00:28:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14910F2
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366486; cv=none; b=BLIiNXZ9YVH8yWLMsT+SLakyrW+u0DhBU7H4neMZTqoNxU0pREvc0DOrCY7AEEAQpY7xxC74S8Kv8iIbvT35Afgjd0z3qS7nRdnCL/bI7IgzTK8UHGDaIZe1nskAToN6x4VSMdThiXHuxEABRxbVSV2ev+bA9zPXZJaAiOK+z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366486; c=relaxed/simple;
	bh=cFICLrCXW7GLns+0qvqdNgk6QfHyagq1XOrHmxPZzCU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zxc66KDb3Un2kOEVJwKvGsnMsT6PEfQe6tTCV2htEKA//T6I3+eN1WEM2LMqKeMCgK4C37GRuqQoLCxCyoJeuF0tkDgagrxbbwhl46qt5JXyOA33KsOP7H3cTOoX1LrL2zBewYuQZs2e9zhM254BHYRnjf8os8ohOsfjEhpeBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cf89ff625so301931439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752366484; x=1752971284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amfs6r1iNE/7LmFCJpdE+jSxSKq111Rvot20z7gdjQI=;
        b=RUNq9C39dfRLyMr0oet1d86BoOHVvEX9z28on3aMorZTNufseQAPpCQu/t5LWV/Tmk
         bJwxze+Q9nh5e8MDBYCpvy9BSzmsQSpcbBBb7UWCaL6E0UPjkWqtRlvfqr58iJeVycqx
         MQtSdN3fEytRlZ03m4DWocIU4P6ExYhQdTGNj2GFlWQkeBnq/VWd9FylszqaLS3UOc0o
         rziHwhdlrVNBqWA1nl8/JBTiu94oEoLjEo9kCwmz27HUT1jHJcfZT56doP+hQQcU0pdz
         XJkYA638lqy6BoqWZWO01MofmyYkAM1Q1qzTf4rW+ZQkI8kICpRc0Hgfin+VRlJ3hlbj
         ZQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFMOIrnsxeImR7fVCrC09gwCLIPpMxgvaE8IDFtnGyET4HlP+ogr1IDDTZMtzthXYrg+C1AjzcVOqTQag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfMCu7q4XBVsHKBJrJ8hh7sJHWvhbjBUqR/hKeQ9ftbXg0SJK
	AYcTdNyYNN2QvSv+IH+++5wnF2cKbnLToG5YvInSV2XV8Qj0EF7arm7mUPgro9IERkHeSsqfExk
	uXtiLbZ8NqinpTDyM7j53PklGXy9wbLj1nzDRH3II47UtN/4O6qJ5IEDwP5o=
X-Google-Smtp-Source: AGHT+IFUJwrjoGCPBLZtF3R8nVgaYpVPeABpJ0+SyF66eXttYh0+CldG8vZrePK0TxVwwsj7cMDevEsW/Ij3t3moSkbwKP1yvRVM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:720c:b0:873:de29:612f with SMTP id
 ca18e2360f4ac-879787b81dfmr895202039f.3.1752366484419; Sat, 12 Jul 2025
 17:28:04 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:28:04 -0700
In-Reply-To: <abc0b8db-347e-41e4-9c9d-10f2d15aecd8n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872fd94.a70a0220.3b380f.0013.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/arm64/kvm/guest.c
Hunk #1 FAILED at 844.
1 out of 1 hunk FAILED



Tested on:

commit:         15724a98 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10644e8c580000


