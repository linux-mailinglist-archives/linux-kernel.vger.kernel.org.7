Return-Path: <linux-kernel+bounces-862175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D732BF4996
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C252C18A70DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9B1FE44A;
	Tue, 21 Oct 2025 04:46:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593086340
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761021965; cv=none; b=l5fM0eH7cKpNWjC/e4HkVcDqhXoACLgdx+/iyfDf07RSIOrZDcjLSduxUkYLWGxZCwIwNCFudzeRmSzF/0/WSfei7sZcBPKmZGPjhG0Da8m/VwacW5vmj2Wf6BaR62aJsxcZW9UVU5nJftss5RMtWkc2yrafrroxMspksQbBzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761021965; c=relaxed/simple;
	bh=ARk+dXl3GJp829fATNzWdWTntrB3DUJx6d7EBiAx2hg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jPz+LpfL3yESwzvkGQtXQbeDW7HaYPg0OdzYD5nEvxQXd3qoLatvQ12yFgzv26xo2DicGZyg187eBmW/fZtCLQ3g610kzVWx6/66Bq+qBvLBf/c6QPKREnLGekKPVD9xARvbBo4zSK6pB6G16bATOob1qSbDDTh3OdZP70iOFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-927b19c5023so496481239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761021963; x=1761626763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ov/NnCma+uLr4ou4mPJLWd11XV7/Qt/IINScC/AN+mI=;
        b=CFcoV/EUdTDBfpP/GIGUReLv5uQOKOJ/thlA6BByKnho5NM1CfXMbKHvAzwTQ83Bbs
         L76FGeFDyWF5lkDRMmjtwVF7HUk7nI8UGqW6tpg1hnL6HpOdvKjC0GVGS7HhJYvPpYsN
         4Jex2dObH9Kxf9yeJh3hlJLKdVOO0qePm4GCxebnzkdkHRE1XUmxv8vCMxGjdi5lldbp
         NbJGGx4GoPv9rPArOFgLELfD6GwaT9jzwI3pTyCjeZOtqXL24Ve1FdUPxJqxXpsQikYH
         nwoLf82vkT8V/VU8CMyBhHSD+Bw9xGaXsyWBstD/KSrUAnkzJMcC7OgLeclRav57ZyMA
         GqaA==
X-Forwarded-Encrypted: i=1; AJvYcCWCrMPb2pqYEdx+MhAHivX7UoUKDOmYw0TqoDXxV0o4E3tJ7wg3RLeX301RyrN0ktE+bZgIzfkihkO6poc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrU7t/xPMHJ5bQ78sEILadXQZwVR95aEHMWq4nIOJzyuPKp12Q
	OX2xliPTcOXPPA+cg2S+GyqXjZsnI0rN/XnV8ml2/GIh+rbs3UMqjdi1zDQX7iw03RohVvlvLfK
	VsZ2yHQm32rKioOnFUCeXW088Tl+6TfNLdTWL/x5svMBmZhO2+Q6D4zF+5+8=
X-Google-Smtp-Source: AGHT+IHtHLdU4RZdjcnPEHKSIHzV8h2CMzpMI0ejwHCLtyeRB/GOhSmM/Iue0OC9qhphyW6/fHt8grXqO19BOIY6mcWWZqVX4NGX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:940:d475:315f with SMTP id
 ca18e2360f4ac-940d475355amr1238712139f.11.1761021963260; Mon, 20 Oct 2025
 21:46:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:46:03 -0700
In-Reply-To: <6556ef55c42ea17d82561b8182d9453b19d66a62.1761016077.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7100b.a70a0220.3bf6c6.0000.GAE@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in poly1305_blocks
From: syzbot <syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com
Tested-by: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com

Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1266fde2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=01fcd39a0d90cdb0e3df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b58e7c580000

Note: testing is done by a robot and is best-effort only.

