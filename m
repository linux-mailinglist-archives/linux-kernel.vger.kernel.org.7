Return-Path: <linux-kernel+bounces-825539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520B7B8C139
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990E41BC20DA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0A2EB5C4;
	Sat, 20 Sep 2025 06:52:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA31E8324
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758351126; cv=none; b=Q7b1frs+5nbHpr6vm4cNGM8l8Nk+9GXkw8GSPassgOY9Kc3Hr4HSkEUCwnAC4m7ukHEswQ2BZVqqpDYhL1OkjFzkGMaUk9bUFt9aIMoWYn1OmlPSGd3Y/2urmt6ksNpOnynKyMHMDsBhDva1V9sEzIRMyaw9eG59bAILCA9xV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758351126; c=relaxed/simple;
	bh=0A3UN6LJOPp/OZfQ1gyQ88jOqiCAaywlt9ynTRCXTOQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mY7x00YybzKAIrT8K8e2A42MKcUMA0tEPE+gFeRqIAncznlc+X8/ILjLF+HF4N/9zc/wLTY5zBRGUw/0RSd1jE5KSqBvVRtFowiWTJyqovFU+5Ci8pghP60MuoUXB67X8szX/4bd4suPaG4ZTh5nsAsC/2NobqnBoyaa3gPawZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4247dedc97fso60131075ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758351124; x=1758955924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4LEO1FGizwQheZAp+/czE31tJW/ITYrqK47/XHpiws=;
        b=iEX9t2IjZtt/uVkT4P0CiNGA8p6bqUuGJMQqguO3AbZ/b5C84JqDfqVbd8l1ndJfj8
         UWh1IK+TAnSd2mswweaITDxRh4wO1/usi6NnC9UpNy2Eh/Em163KjJva8KbLcFgv2j3f
         E/JHD/X4f5A7YaSCQDh6wt/tIBgqvyipOSM6PZDzX88IVlLarVsluPls6VM13VkXltD5
         gTpOH5FAK4Z/YTXUtT1vhVNqwu5qdAt/Uk529SQWZMG6cmMRUL+wYK+C6yiNsTLdYUbU
         Ef7ytC44nrORs4joXdd1HFgkzZWrrzL3LrrzagkZE7EflbfvfDYdYWImFRv4oReOc0rl
         RQTg==
X-Gm-Message-State: AOJu0Yxrn4JvkpU1CXmPa79xkM0C/iEhuEjk5HiwxtSH9vGgCKMQbRHs
	n/EcNMbcjtoIzzOfk/lGaoPDoD/LdZLaj3omoLVaPyyhUt7krSptpAM/kCFHd2dZMZPqzCULtgh
	uGKExQt56hPn3igtxKNE3VbUSMcFli/bNkzQhWvxT3BRni6Iudw5DnPHRVeA=
X-Google-Smtp-Source: AGHT+IFk2ivyv/T41tozdkfanIx6JpttUK1xxhTgZqBmUoSeelYWRE0sOcYZnKVWJMBEFYXr1BsIXV7c521L4jjIKa98VP6cUTpU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:424:30f:8e7f with SMTP id
 e9e14a558f8ab-4248199c513mr88966625ab.17.1758351124090; Fri, 19 Sep 2025
 23:52:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 23:52:04 -0700
In-Reply-To: <20250920064813.386544-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce4f14.a00a0220.37dadf.0026.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10864d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102f5c7c580000

Note: testing is done by a robot and is best-effort only.

