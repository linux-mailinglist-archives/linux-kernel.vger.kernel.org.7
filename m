Return-Path: <linux-kernel+bounces-875391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA2C18DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A163B1B27812
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AA3128AB;
	Wed, 29 Oct 2025 08:05:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D72EAB6E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725105; cv=none; b=hGnIsyfmReVu0CzBS/dL+1pRvX+FzofNuP/XoUaJq3LqzZy+WqlJm0RLqsOu6CZIxBT2k5V1dk42AyVbX1lrhzPSc1fR/U0xJnxk0nilFhBEUU4f5mmWfq5JTIbUghGVbhvmxI7GErEMWVplOJ9ZmIYcd1s1fuq1w+04tFEbWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725105; c=relaxed/simple;
	bh=HgRlERt9hBlQBV27rSGQRCj0bxirN1bdvMNmCWNu0qk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c9mDM8Ih7lo206+GwoFdB25JuM9X8uqjL0WDpLbUasVV6olZZzgT0JkCex8BV6SmYA2rRw8brnzMSQBZtKkXp0n9gp/jVEBkRkxNAO/oL9HDmCk5JEQmxNdwFpqFwB3YggJntfb8uYF4KQM2ZvOAAK7LGknxkZ4CICPzjtH0T1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso91496585ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725102; x=1762329902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SylL30dXlRAUEhqvIpa6xZAywvUZp0/FDRj2fmjEcwI=;
        b=P1yflPBc0UAgqOyCpe+vR4ArUDRqpIho2vQvfvKGUtWfQeF3CpCTZGcb2TkTJJaMrJ
         iDpntb9ong00Tvb2Gp9QUZ9pPE7ReR1bOXqD7n+xcMO2I39nClZQzi1Pjb1ceMFYmZO5
         0fudDzZycK+9iW2OIX6SEldlDkulbdTsB7gVfwNxvJwEIJEA/ywTFVh4j0YQ8EKpxeL4
         wGxw27KqX2CiD/SZzimJzRwFwU0rRtpmW2ka8pt0pQlrc8oDeMBk2PQOzJQZWY0wAG8k
         +cIvzSK9/MBpVF5zNyoRp/+bN6saV7JF3+7kfPh5uSUOL7ROjtZKRESIQQcZmhxwghUH
         r+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVdEs9ZRzDos0a+WZKhYv58kKVgo3qZGhfq1DHVR4WQLWMDVnIjwrcGW1ypwfoBIbZ9jxhxGXpu76XH7T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqHUexlOPSKWV9uCai2vjWuyf5EzNP7W0B4P0Cyj9ttraPtBG
	+EtdWlikLFklQ4oWuzWc+pvAS0vRY45ckq40wZNE4stEShKVHLpMV8F1nj1rpqrbOSxfbXFE+zB
	JCijj8xCNnEYtg0f/MrPrj8RdXuA0oSCNRG5pjexR33YrbpCTLSAcYLcPVQM=
X-Google-Smtp-Source: AGHT+IFJcw/XoSSSKeoj2xp7525+LX3vz/tGPI4QhqxFcTF10JN/4TDU2t5WJlBFhaovclpG/x77Oe0YnC1S4CFlyEreGEMRG5tE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3420:b0:430:e5a4:6f41 with SMTP id
 e9e14a558f8ab-432f9071405mr26822635ab.32.1761725102615; Wed, 29 Oct 2025
 01:05:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:05:02 -0700
In-Reply-To: <20251029062547.hO0d8%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901caae.050a0220.3344a1.0415.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=115bdfe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef8bef4a2b3407ea
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16abf614580000

Note: testing is done by a robot and is best-effort only.

