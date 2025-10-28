Return-Path: <linux-kernel+bounces-874805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB5C17230
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4838A3ABA44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605313563D7;
	Tue, 28 Oct 2025 22:08:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC823557E8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689290; cv=none; b=a+FObDXux9y8/8PDgOOW/346XJuO5NZvZ0rzsqNwiWmVvjVaYRCQLW89c0kjPioBBnZfHyXV2R/LePpL4HjNT7Xg1S0hsBLOJY6EmaaJVidbvkbcCYbX+7pP9Jd1zKNgFZ8NG5rlMt1UN2eoYYx3qf5ogLCpazEWFnKt0AXUlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689290; c=relaxed/simple;
	bh=Sm78WCRP6vB5on7Tyw7/kLLR1Y1PcFCrNXd9TSzoycM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EftH5el91h6Xa3M6zshLDlWgJmooRvs2eoCvmNxV41WEm3I9vyn7hfuNXK5FYPspeiNZ0OeUtD7tuOzEWrRUr+yP/rccK+AMAOsSbAdXQMqAVSl6aPQm+hSiAuL/bjQImQJbFQJVi7kH4F06xlKHNC715Zi1kSjY2YvSHY5mBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430ce62d138so82122545ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689284; x=1762294084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hg6iEDDS7SYPE/b4B0cjRHn69/dlDeZaDOZ/klLG6Gg=;
        b=UnxlDF6nItZqriKcUHR8HeH9DQ2caMzoiJiooF+LHWCPrEsSIi962mMmB/VH1aoDvs
         OYQPzscA1QZE7pJ/yImr4xgRP1AeN+lKTaO0om0iBHuuRYEQHBSFxSsim/mV0Uw3301V
         aiLXptfERXnM522aJln0jp0FQK8QTvjIx701fOmM2aCFYX7KsrpJxIWWOO1xDkx092Cn
         pHokTS0jGivRNj3afKUu6tqlcuCg+Xzb8BIq3n/gWLLJXYBZU5WhAGSTaC6+PnehukZf
         L1LS5ydNot4zMW6vLBOr9BErV4P02MywBTR3H29mOKREU2lt7bTQLlCBVCIrMwVO6V1N
         Tyew==
X-Forwarded-Encrypted: i=1; AJvYcCVC8kgVswhbRkRK5k0JMA/xa2FgX0sop3ywybzY3Y20S+Qky18q4Khksq+r+s23gChGZkdlDFjvXfoTzaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTVZs/sdnn5AcmqwLUIsaNMOb5/+IwsBGM1CxWxGTbM/AqAXz
	nma8Cua+DoIc/qFkzxcDmBrPWiLNFYDSA/Jl2ioYCHz9B6m3+sMcVAj3iGeY+lIx6EBII1wnrNH
	OO+K27FoxlhJl/dFVofGoPzPox2f2zwptg5+Y9S9TMOlgxGmLiRRmEHupz/E=
X-Google-Smtp-Source: AGHT+IHqjTjlu8yaDyvxHKX6YspBp3gzusF73VCtUWLhZAdYsc1CNZR8w4RUWClvBv6a2wh9nfph3wSbRrvnMGP1ggZXUHcBKPU+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:430:db56:33ba with SMTP id
 e9e14a558f8ab-432f9044655mr10786745ab.22.1761689283784; Tue, 28 Oct 2025
 15:08:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:08:03 -0700
In-Reply-To: <20251028182301.mjdz5%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69013ec3.050a0220.32483.01de.GAE@google.com>
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

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17358bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ea67e2580000

Note: testing is done by a robot and is best-effort only.

