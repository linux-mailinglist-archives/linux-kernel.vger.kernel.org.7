Return-Path: <linux-kernel+bounces-876148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C5C1AB20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7392C5A2422
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2624DD17;
	Wed, 29 Oct 2025 13:18:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3F153BD9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743889; cv=none; b=ZgVZGdloVSnzCzlKkuqaL+caeq61EdnKUoTmDW2iAJralufXEutIPLlnj42kmvMl6w5OovDX5GYqMT719rpFTO7ecoZYigiJx57XlaIlqjAencY90iqiZ6uc1JE76BOHOuQsmcPfmVkC82p/K10OULpSmvCrjLvLO8Zluo61bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743889; c=relaxed/simple;
	bh=/YNIQ2UF1/+GxUfOk5uFMZJpgT1pbGLwoA6u0/iTfRg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pwYxa2E9Ikf5YbHPWpZo4RCtxfyJAuoDZ8ogobTH4KEOpEv+ahPu/j5431+evaGuxAnWhVJVdpFbOOurOb77nx2r43CbDWx9sNm94rfFMlrXvgRxGUIiudJAxcF7fZpw27GacCr5V1FQSBO6GwqRAQgYL4Gf3IXBizdLX4brO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945a94ceab8so366034939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743884; x=1762348684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgNl6WywUcR4Z/yxVl/hc2vWHbewAzZn/17z94yWkQI=;
        b=QS/RyN13fTvCOv7nI1hMOWcvtV27+YNszluzsLxnHHU5D6XzCRGmHnx4vMeaxv0qBY
         I8kDHKd8vMpuYAlfIcxppdktL5Pxd823ojhZUtpfY1R1XbdZRlIH4HprbLINGfENJtv0
         q55IonXrBw71tkUFR6NewJZk9cgCfJHmnFvEC9S69ChgCQIxBo6gKvokVDX4iUJj1w3N
         6qWhM5Jlajj9Q16wYEoOxEr+70g4FShseKlwcg+3sNiixh3lf9xX0XVe1UhaxE0H8g0r
         5py2oqp7x6y1D7thY/LQPwAj63BcMstQY+fz+895fZLnvmQEpHhMVSGnFCiSS6kcwJ1H
         ulfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/EPNzSqvk1/Ev3YHZ8r+Njk/9bidU1Rq/cGjFtsJ+AbTswkV+DSdOYvPngmQf6HnzPRC9ofxXj2n6XaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBlMR8hzD22Wx83TJI0ngEwZqptwcYwzFC4mjA3iFIi31vsyh
	eWxK92j4Jq6drXOpj856Yz9EECCXcKpNk//kjVjTmDTU3+0UYWJ1d4Hv6PdF2vyda4qOpCUWJct
	U1dAJmOnUEnEERSJPAAEUwDqCN1cqigcQ+Ht5NCTU10Sx8psbVyDQmR6s370=
X-Google-Smtp-Source: AGHT+IGyG+IEcXZEeSWmuIjemue/R++7Dlj7GeKIvsooGh2IJtG9j62qZ6fqgXXdRCLPyxJil/Cyz1ot2WgjSQQqjIo15J8e5D6x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:430:1c6b:7ed2 with SMTP id
 e9e14a558f8ab-432f8fad576mr40533765ab.10.1761743883839; Wed, 29 Oct 2025
 06:18:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 06:18:03 -0700
In-Reply-To: <20251029062549.Ioi6x%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6902140b.050a0220.3344a1.0421.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com
Tested-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1514efe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ba9932580000

Note: testing is done by a robot and is best-effort only.

