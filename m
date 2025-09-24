Return-Path: <linux-kernel+bounces-829810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42AB97F44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91E92A1713
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD811DF75B;
	Wed, 24 Sep 2025 00:56:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C51C6FF4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675369; cv=none; b=S9/oGHLxxKQezU3rH2RSUE64wtW+1k26Ech/ZHSI9F5+Wn+hK6p+vieT98n5hJDO+TdOt0G9Oq983Dj4Go/Ib8LmOO3TTiAJNflzTnIz50OsSBVNdSk/bwL1061c0UPfsAMnphp9G6oOMiJ3EAGHhSlrNdoMJ+XPfK0eWuPrsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675369; c=relaxed/simple;
	bh=AnBBuhoamhB+RnsjY5/PZaDXVVq4KDQhE80w5wGy4nU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PmUhAh15gn0XukEOHe12ptaiJi5YC2RR1Zp1jDgb6fh7HqH0T6NkFc+8qhBlagqOX03oPuKuHcnKHkm0/hzqxoe+yVACtAeUcpoyyqK2342J6NwYujHGZE0Y63/y1MEcKGCMNjp8VnHJx8h5X4y41i7GOqVAiD4GlZevHHGZfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4258a5580edso5153125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675367; x=1759280167;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXJ3cNaNIjOy1WUdkyIXjCHz8xTbzPaOfEPUZ6M6+pg=;
        b=vC4akraPweJVthxsGrkWrXtERm5eGdQIHB9364Cv02jU6TcY6FbC2Z84U/0Tbw+Tsb
         pCKL9/Lng0DJPTJdWkz/yz/RZ4hKi+JiWhOlLPKrOqVvj2cdlqei9OxYJEAzzG2kuLDR
         PMNsr3HPBAZ2HRvPCV7JIXjBQ2nFSJ2GbGqHzWBB6tsstfr4yNGfJvOjPnKBFwRHXQzo
         RZ9laBC+ub8jgC080gJUJ3KtdBzcsCAQMJzelQ+O/icD+OUKrMhD1CeGXQyTE4aIDCAC
         T2ft5Yh1ubhAIhMEqTQ8489EBgEhR407MJzuw5+Pj1n0HQP2D3N14npNwQiyFqx/HZPv
         FZfw==
X-Forwarded-Encrypted: i=1; AJvYcCV764q7YGJUiEO5zQPRq9HOuTigRvXaXQXpnaJ6jCRoEq3aq6JgvScGlhNOvyXvmlwVoWNDYjpvtE5Ss+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqdPkhlDsqdMQ4MzLjm0FmMba5gtSVnF0el8elp2uLdkYXUt3
	n+1YpcSZU8M/MOITkfufH7rjj6o/Ul2CeZbkApwLYAoRMWaPO1++7/CfwFjZq5Hsw/v+N82Ddgl
	DRsQGyzjZrzUFcl5mPmygjNbz5XxWNA2MeqrRCF+HwHLuCxriiZ6G0hKb7tA=
X-Google-Smtp-Source: AGHT+IEfsspHXoLfnel84jvPGDVCDHpBQtNTbRek0ZrWDPd0zBDMfrGs6loqrW0Oi1sCYO9E/sSq4o21XKBZHF/ERJzUEiPSwRkk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:425:7a75:1014 with SMTP id
 e9e14a558f8ab-4258d8cb0f8mr7973905ab.12.1758675366946; Tue, 23 Sep 2025
 17:56:06 -0700 (PDT)
Date: Tue, 23 Sep 2025 17:56:06 -0700
In-Reply-To: <20250924002850.7530-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d341a6.a70a0220.4f78.0015.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Tested-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com

Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13182142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108c8f12580000

Note: testing is done by a robot and is best-effort only.

