Return-Path: <linux-kernel+bounces-885598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDBC336D2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10A474EDB77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7934B19E;
	Tue,  4 Nov 2025 23:50:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8272605
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300207; cv=none; b=R33sJJa84d55aqgjFwcd4eklNCfkIbMEwPr6LIv3Hygc7xW8B3PQIJJ6ZjC6yLJUXVgPyq0xAtyugiz9RVA+jYfAjzGL6VBfITvJOy43YaVkisEQLVy/paEniW3rpyRUJAF3bgRsBte9o3TnFzcaY14neOxn+yi0aixli3im+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300207; c=relaxed/simple;
	bh=ajllXdr6oQG38n6+/jJVzr9OiYbL8H4ARC6lksfrV5g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O8Rfy26VadB1SMJeeFweOAezGyvdGGFEpKM0s8uK9wDhQAZRjw8j/858NnUGsS2tVvfi1gq9iPXUDPJ1p1lTaHIuUn4JiQ85T7p8ZWuTY6VFmFNINCSZ9DzOMEwhypxm5POGXYkq4xzBEToIow/RIMesEi/LHSys1wiN++dFI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso23520455ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762300205; x=1762905005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXJusg/90hVbKv8g/HDbOn1yVdo0cSaT3bE2TbPx5h8=;
        b=qWTsj+x/9ITdIe8oDqounAJCIBdEtLuKcJ9ZUVmmYgYq9qPnlces4QlEkYe+4OfS6r
         3CTNPnxD/5CLC25VNNDx5M5qYbYuBQxfxeCkqsH+lvpxLCrP0qeCHwZ++GaxwIXE0cAP
         JQdQVqBponEXlO62ABQze1qL6PuMpasekHIBuEQY8eVfT69dj3nOwiDUrskMLlgLgAM7
         LvVcyGMu1P9eU1Ji3xKSOP7s3RQc7O8YOjGVNiiqtAELWnr13kUpx4NBTqkZRIgApQbP
         oaKypj7DaJwhbtEo/6U6esU22bxa8XGRTG6TgKvE8qkp8PLvqFoWRiiILrr3OwaVptZW
         tdSg==
X-Forwarded-Encrypted: i=1; AJvYcCWmvE81WjQaOx6PY3LGeuImXW5x3hlyfCTEFpC8H7jnufYbWolxZAzxHneuBNtkdg7OATiZaCfUuj9Kz+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7SUCJUWI5ebZxQwruZ3kolCsephXSrA7DChyw3Gk4+YVBHM8
	lKc53Q324etuFMlLgKsz3rBcLkl632OTpm52NVNrz02USW+FBxCvSP/emWvvGxqbYU2ezhcr+hp
	QxYyiK4+cBbC3aAH0sChOQCoe0AiN/zIWRSBAxj1DPDd1CFswX6Jk+EZPVNU=
X-Google-Smtp-Source: AGHT+IHypypk5TOWoHZUuvOeR9HyeCPWvHBh9HcOH8CuA1EiZQz2iCKknNqDprQCRCIDHFMY4wiTaQd210a9h3zgZpoAI+ErOqp/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260a:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-433408017dbmr16123195ab.32.1762300204783; Tue, 04 Nov 2025
 15:50:04 -0800 (PST)
Date: Tue, 04 Nov 2025 15:50:04 -0800
In-Reply-To: <198ed0eb-2451-4651-b723-a506e3cf853b@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a912c.050a0220.3d0d33.001a.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         dd6adb14 RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=11041342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

