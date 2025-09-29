Return-Path: <linux-kernel+bounces-836364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E0BBA978F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A267A3375
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331B308F36;
	Mon, 29 Sep 2025 14:05:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5729BDA5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154707; cv=none; b=ZsAF5PWDnaL6A9AJWXNsg8YLBgEeTbWzdD/qoLs2THA/vTfNU3+qDbmknCyeXlIE6n6lAXETmj9n7duKhG1FeXVjuNAy5JSnk6zkB+7t8y3wP87efLMf1CgxbO0fFMq/vK8exLLLGzcZk4LjTK3vD7nKNCgtp7vo/n+L4GWSHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154707; c=relaxed/simple;
	bh=1kEuho2GfBceA8vSCmqY/6dHpBaVqzrMmCUsbKzg2ag=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CqEBf8KUciEkAiRQWKcZhLSeSkhDGAG+BJcuXZ342RkGJ6yEDvSVSdkfjFtShNRvwGWO0sAcmnYUb+cGM/fcrFuxP7i0l9+tbXz11Gtx2hVWpsCTPIAiKRmP7sPZqqPq3Zi4uhqezT1X/vcSs6AX2lQH+0MmaE+49DGeu5sRKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42571803464so122112865ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154704; x=1759759504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4u1VQ1XBKz2bSv2m0HHOSqT3NjhDSxwCeRprPSzfAA=;
        b=iYAIF7QBVcdeAJnNxrVha0Cjt9Tb5bV/yih440wtRvhcNJvYugLEwKArkEzAkNa4LU
         7Nutt2kF1CJ6fVFePJMC+UF9enBZ+XrlXWoK8hky51WuQwQLdD63lX/L6YjdHsX969yz
         qF+/IDO0R2bHqAUlqZ1zoxLo9j03LoQk/MelIY4uAzmXQQqson2gLcAjCW0czdP++6rd
         VdYxkR4mPkpDu2EaFzYhXnUT0ya1qq3Vd7zjvHlahAejVVT3YtGDx4HG6REG3XCPTIPs
         HLxbv1wOH9TCU/MxfWMTDzuhv9nMEL4NkWlbiBeNfVEMIA6W1RXRmFa4CWqWntgh8oGu
         IDig==
X-Forwarded-Encrypted: i=1; AJvYcCV9O6iW6hqkKOk1gLlUaV10hlHfrPOqexmT0fYIKqK3SPARoMtYQ6kZ3nUFEg5U2lRpO6qpzNJp+8udna4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd3SvmwSMFWmHSzNciHzx8OMHGjI1U+apQ2Qqj7SzpJ4TgbDx
	nFz6j6MOL4Re3rhcWdaB09NYBsAfOOiqwyj/H+X+oTp+maTgOEmNfpQm8uOM4UEtFusbX2Fdzyu
	PqOfSHaabIBHfRxCyug2iHYLHDWeIyyhXpQKXpwYHrba7p6Vp2zFB6P1mqdk=
X-Google-Smtp-Source: AGHT+IERLaW0xSc2mjfKPZkz2KQmwaASB0HGFh5e7znQsdLHOXoOG6O4wUmURcoxlR5Ze/qPO/UWrbY5O8vSqGMcwRfVvLBzopXi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:429:6c5a:61df with SMTP id
 e9e14a558f8ab-42c6f2ce383mr31072545ab.3.1759154703699; Mon, 29 Sep 2025
 07:05:03 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:05:03 -0700
In-Reply-To: <f051f396-cc01-4d8e-a6db-22f7578b1499@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da920f.a70a0220.10c4b.0041.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         e5f0a698 Linux 6.17
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10261ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1540ff12580000

Note: testing is done by a robot and is best-effort only.

