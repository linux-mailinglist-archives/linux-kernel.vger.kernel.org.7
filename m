Return-Path: <linux-kernel+bounces-761095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B59AB1F452
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BC6627258
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649123A997;
	Sat,  9 Aug 2025 11:08:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD881724
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737687; cv=none; b=Hht9aksGJDPi8g+a5krnpB7+U46r6mqG7SAB02S+D+Y6i10PIVr52lJGFkGo/da6xknFoBA8Ei4uW7/vr4pbn8J857mLeDbNCOzYMbfpwnTTzbxtY8pGye7xZRlAxzYzg6BbAWlVLW0c7D7niisT9aaF7hMMZ4NPnvrh6ANCAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737687; c=relaxed/simple;
	bh=t6qLLP9Rz8mssywd0ufPhKeYTotDncfutg9w7wbI55Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QtUSlSYAnsmq57Ucu2jwIcyh28bv+ilA9JrL3U2Nxbw+BYpMp4tZzd9QsHtBju2UTiTnoNLbj0VSYKcZ2Gk7gHtQb/D9KC3wMJOayX2rbRBOWonQvXBTWoYBMZRywM/WMjwyIqHBmZ6TbuqoO3RqEta18PXRNxKM4PvFQGigCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88178b5ce3aso258374639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754737685; x=1755342485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbEzHNHqfjiCuUufwBJO2evFDMLd4HVgOd4AQLnCVEk=;
        b=od6AR7C5ciQtyHp4/hJuvUCsGoFB1ZYuut9sqhaQhhEAK9jSgLKvLEGFNG1qTeU87K
         wps5W9sRuTvG1ZKtwjZGBkdqKfGBoW0x8+S/ZEkVXgYJY1POx8+hE69/JkPlLamnEIYq
         s3DnnaDM2lRxuWYovQqSIeEJm4qt+vMd3E8joNTznqvWCEntA74Q7tR+btlaYK9N+kYb
         RJxiZIulGZ6d7q6sq3rbY8cxTX1yGGowsVglH+qRBpbff7Ek/x5t1uZo3lmmXeQ5O/Rg
         m8A5sPO2xFK/c5RE7NHoidulrjlMxciRgXeA33foTEGgEidhdZMnnoZefYgPd/4cgZFe
         9t8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4a33cXM0pvOMncIDVmRbXPe8kWOKxPeplS2SEYAUXoXgxuNm0OC9nmxNf7bPJ8ryGLA6cDEf/wtwQxDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaO4K9ZudoOaY7q388GW8GZRxjjUEsMDxKAz4WrfBIap0myxGw
	mjMIwsONJUyz1vRftRLfIDmq+HeYmoMF4kMqij2lQge4uOw+hwy1ssdrN8Awj8QYJSdwy4dThQE
	5d08/P7g9IZOOoetX0ZOI7XgC8c3WQ7QKMEYZLDualFS3j1qGmxaACtQXFEA=
X-Google-Smtp-Source: AGHT+IFpmNIROBnotn/eZ20nh2RW8rf5uIFcU/r7kNwFI7QL+wiDjwTaCcDbw8svHpcr4zXxO/E0ty25Rw81cWk4FhlwT2lxc7fD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:881:7627:b0a3 with SMTP id
 ca18e2360f4ac-883f1273eafmr1248942339f.14.1754737684757; Sat, 09 Aug 2025
 04:08:04 -0700 (PDT)
Date: Sat, 09 Aug 2025 04:08:04 -0700
In-Reply-To: <20250809075631.4090-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68972c14.050a0220.7f033.00aa.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sven@stegemann.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Tested-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com

Tested on:

commit:         c30a1353 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10927ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134a5434580000

Note: testing is done by a robot and is best-effort only.

