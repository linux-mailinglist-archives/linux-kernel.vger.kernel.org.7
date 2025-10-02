Return-Path: <linux-kernel+bounces-839753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA552BB2532
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B75325C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83278F2B;
	Thu,  2 Oct 2025 02:03:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689734BA29
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370587; cv=none; b=CQ69+jc5E32XIC02N9BX1JfpHyq792TfaiJ3cAAP5m6oy6bmVbjKOrgE64gOugUnrvTxjR5ExJRKO+qJmikRUTBmrOhFUAD0a9Lq9gL/zIpSOMa+dotBLgDj57Ft9u+RylprzHGPm7liYOkxL9L5Z6SWXcqD+ysSW/UutMAfo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370587; c=relaxed/simple;
	bh=UKF0q7+q03cCDAVT5XbkBBfAQEv/x7aUkjnNhMNUggY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RtJl1IWJ/TbiuEVWg3pvNISaOBXt/QvfDciCQfRKs12P+K7dZ+lbY5qgxvsA8soYzHgsg9Wqnt/wVkUMn2skQB4QMdPD8TgNknrzP9PVeB7sOJfDSozIk5ENKesLCQUjttr4OHl2AmpbnMUpBvB25G7MUL7Ah8ZHPXdmBb6ZMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so64045639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370583; x=1759975383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po3AbjS1M0wJg3XilCpuTjM7c21ge6YIEbKqJTWNeQM=;
        b=vbNXavNZyU+rOkdlphgQGhImEWb1ffPpXHR69kQ60Da4o6MqQNRx9bCODcISOJ5vN9
         rih6jmsu6ZR3jRAP03+EKQAMwnw6B19mwYjOaHo5BbtXQQzJpAVao2JT9gIUd47DDcVQ
         Y6RSIu9nlyDHbaqXRhLjDDPp9hEh2JXgJcNqm1UXZcMigEowbGwgx9W4Yl5tVrd98MeI
         Ir8bswemhTZjW9+4t37VyaszxVcpx7WHI4w9sAAdguyuu2q/8mtdaL429yAErAodn5x+
         nutaI5wfo7kawepyJS/2BjT/UkFyhRpq+1dLm7mFqCq4gyalPPNoUkTGxDFXUCiL9ocG
         N/gA==
X-Forwarded-Encrypted: i=1; AJvYcCUvF4sVztjoBr4U28hTD+yBmq7AcCKl3Mo6i5/2Z5oiEfpC+hkT6JxbKuCMDmhVIt2LXLCxtf64JSnY4FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyefvljGHXg8/rd03XAjbkz0zTL9vz3xrP10fgpTeZLBgJFI189
	XTrMKRMV5t/PrrDyUXYmtu+egQBz7ZMSmM2d8/G0XiNAIc1UU2tM/2y8U3smEcJgxN9TGwHv6pd
	vMR/lPIxba6tg80a7gJbnmmDVKheeipbd2w6TVgSanYjmmvfTZiUxpM8BsoA=
X-Google-Smtp-Source: AGHT+IEI9xNu6eltd7vE6Hc9N76+raoI7LyODQG0rTU6SRtzkyYPh487H4gofqTqSJxWEKdB9WeNQ7s8HkvJivjClQNb33meeuGU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b8b:b0:921:2f68:fa0 with SMTP id
 ca18e2360f4ac-937a70f0ed8mr784201539f.2.1759370583480; Wed, 01 Oct 2025
 19:03:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 19:03:03 -0700
In-Reply-To: <20251002005443.7942-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dddd57.a00a0220.102ee.0072.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Tested-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com

Tested on:

commit:         d2b2fea3 Merge tag 'asm-generic-6.18' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1737a334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9d13d0fd373120a
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112de942580000

Note: testing is done by a robot and is best-effort only.

