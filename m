Return-Path: <linux-kernel+bounces-834855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B43BA5A64
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718F24C62C6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397A2BD5A4;
	Sat, 27 Sep 2025 07:49:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A635950
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758959345; cv=none; b=j+T51rITTCxEaZewBetWjkhqub7YqdAcRRTk7+r3rzSHBdcwxG815nMtEiAQ+E8x77vs3zIrWA+Rq/uud5u+WYv4z1rUQ/bxYH8endrcmXkNfjQ5qnlYTyD8qGWPcaqQ6s3k2fgVDlgDuS5JUm+TVpqzfo3wLqdHrOAAJzyM32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758959345; c=relaxed/simple;
	bh=0cQCsIKXQMH+0jh7F0PILz1EImA/j8CXtmNVpwxG4e4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b7389a8haBfwfjZ3T7hu4E0oupY1Ko7gjyMLsBXsIGkgiXxEL2NPQnrCrxnFh0+JV0HnigbnBgRFVACo4UuYjLPe72WfZQdvJK3Auju6YsXXGGowuxIV+ghjxQgj0wsSnH5ahhKVkEpYnpLcLvGFiervRKGXYTD2t1ZXzV8zFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257ae42790so44028585ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758959342; x=1759564142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXk3rpCTHyeiQjYeWkWzRgtWQQsQATUgT5QkHrKl6UA=;
        b=FWcJpecZk8kDmFR5oj28xYNPjM45hGQNMB9OXznoQ5hUgxxgH4pgfHzoce7NUGsiSd
         isr85zqTFMykrWSt/ts4MzfKKtIOcTIiji+HlCGjfaA+OmBm6Pv1Ck0wpI69mHPDY3No
         1wBLQSiZxMWWcfeNqt8cNmCsnQbp2tZmO9Nu7b1vDbrhKIOgqvi2semsxQD8f2G4TDKs
         6T+KJ/poiCYV5DmKcg/BUrKwt5kaDZzpn/1AYqqbWz1ZAfjl0xQRwDfG7c/dLeX1chZN
         UvE5Mij0b9VihWltmjfX8PJvGvpFpZSJA9TojmsMubtStIfIzbF3xaMDoQoEexUVB6VC
         6cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/yZ6yluRSiQJv83S8uecWElMLyDznmnp7ekqGZD6fqYrqTa+QawngRXD3V0GiLZ71xVwQKuRTlTL6Rj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQ4jRqL0HMozNWRYol6N2AH6CR6aR47BPaBBNgLeXDSWnYpBz
	DEZcJu9C5tGc/nVgm5rnBMNCJVHkLKHbjmxc21eTfJ9i93hzZbLILUCATSbYrDp/2+/5AmuN5Qv
	puvPkO+R1h9GNPo5RlR/Fou3IohJdDwAVpH2B9Be3uRr6aUbksXBXtrDSaA4=
X-Google-Smtp-Source: AGHT+IF2vlddaWa0Ihs8BpDKTD6ZSOYNQlpgR0uYskS1NAMpIofncHlTWFHwloshB1TEbG6VarNL5si4kPn36WMN4drgQNNlQc7C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a27:b0:426:5a34:77ec with SMTP id
 e9e14a558f8ab-4265a347968mr137824735ab.11.1758959342725; Sat, 27 Sep 2025
 00:49:02 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:49:02 -0700
In-Reply-To: <20250927072538.39483-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d796ee.a00a0220.102ee.0012.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_seek_pagecache_hole (3)
From: syzbot <syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com>
To: =syzbot@syzkaller.appspotmail.com, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com
Tested-by: syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com

Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17339f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dde2e2580000

Note: testing is done by a robot and is best-effort only.

