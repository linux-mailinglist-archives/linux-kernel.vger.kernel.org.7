Return-Path: <linux-kernel+bounces-869004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DDFC06B15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC2402F45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711E221FC7;
	Fri, 24 Oct 2025 14:26:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CE203706
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315964; cv=none; b=q5yuxfdfeQVv3pirZvf2epQadOT8k7R/KKgeL8f6okY5UXA7rldCIWhzzTxDxaR8bWCvFj73vrVcmmkDzu0HmJuIzUpm2iJxqxJIS+7dLtpXRokvLUPhyZ38D8cXOCMOZVAsDvZdg2ZHEJMjqvrBo9/McAma1kRMsO49fsdZP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315964; c=relaxed/simple;
	bh=L9GuY12nXVi+xmOy3Z+ONG2yV3BvDvi6jOkaR9AXtgM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y74qkF6Lod9w8luWyjmjJ3IyfHbhr4/k0kR6TMnlubS01rWWM/E/6tyCmdAYgK9WGL8IntC4+V1obYeSjDgXzuKhnoOc/8DE8oNSfUxWNHIldHaOHX+09wMdIepIkksrgxBfpAviDmMIOwfgNSE0LyDDnRnhSfQrqO79/eKyrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so26253835ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315962; x=1761920762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+izLjw2ZkxvWcDREvi4+nhe7gxfAPmKZIDS4bQp0DY=;
        b=k3TduyTYniW4NvP0o6MG4K+xJ/LMQaOon1Ew+Td4kzI2QWH3Zrim1afgASnWZmcPyY
         MggnxGM7ik5ns9sP2EurRj1Eb6HW2QDs79KiqAi+XOLcitVItlYL3O9TmvL3kiIxt4hr
         VCdSjHmtTMhoFR2RvQVaB/oyFBDY86JXjGEVU/Lv3hSR1nw2DxXiYLUkMlkyDgwJLl8q
         38g8vLUJ5yQ+op82MJ64StKFMjFGBBQS1Mw1pu4uZMXrpw/gYICkzfskVjBxj8jSpGY0
         3EdZXl1xPwqJy5iN5qUH70CVm6W+xSuYDlL8Q5gnDFiS7/V+5vUNtJCQ8ihsgB4ycFpu
         S6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX5iuzXE0RVLBSq9rt7G8cSDmEnThMWnMf4QddX7shg5nRh5UmReNlfiTHJbMoJK8OkSxp86Y0WDvefoOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RXpvmrdBVN43bgTfWFIV0SE+dIspeaQzIz6fTOawGoa2WlUJ
	h7TJoG7s9g/2yIVfc0fKGLLBSwcmPiUDQXhoKUg+F5R/mqEFE/u7tI6wVOl9zroH5zNYLtd/hQ9
	k3lX4eXaIFLbP8jScjrtLTE4GxqoYcGWVx7A5almz8x2jRl6Kvvl43g91weg=
X-Google-Smtp-Source: AGHT+IFLaGBegS2CqaypP67YgfTVhNwZhPmDtWVpN1qErUmpWfnIxBs6aOh/HD4G6U73ziiKxzd7C4lIFtMG8dS0w6Cp9b7wGKM0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3785:b0:42e:d74:7252 with SMTP id
 e9e14a558f8ab-430c531e3bamr406954765ab.31.1761315962099; Fri, 24 Oct 2025
 07:26:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:26:02 -0700
In-Reply-To: <20251024071535.FSE50%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8c7a.050a0220.346f24.00fe.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17197734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c2405120cc7eb82
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114eae7c580000

Note: testing is done by a robot and is best-effort only.

