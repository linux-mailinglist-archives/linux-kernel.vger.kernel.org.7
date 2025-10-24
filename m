Return-Path: <linux-kernel+bounces-868573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36168C05867
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691623B1A84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A330E84E;
	Fri, 24 Oct 2025 10:11:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1230E842
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300666; cv=none; b=G+c4B4tZMRg9RYg1F2+Ep0QheJBhKsCmxHQkd++DcCQegWGylZfta3VwT7IZ5u5n6HKm460boIAxRFbtpeg9yUow77wmCfxrwSyJI53iVFaAPurI/o3YX2tUxkj0P7wIAQhQtGngQot2NcoPVfWgdpbb8VXv1Mhm5rEpkScBvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300666; c=relaxed/simple;
	bh=Ilf6q+AIB1opCSQX/VKbUdHGdIBsSBEFMg9wlp+At8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R75pFanAtzXDuosdMGRjhqRHuz0ChgoQKP1OgwVvG+Z4Ut7utSh6wYRAAtAD/crAWpipfNhkJLBy6v32p3nFsX8WXHYgWMx0LqJFI/W6XQWO1M/5IxmV/JOADJGHwxhq5e7lJe2LDe5xbUshgFExx/b6AvWqBZVOhgk+0SssI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d082fc3dso60958385ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761300663; x=1761905463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgSb2Skl9uaG2+a8AotianAt3blWNBzGt2IxlbtB3sM=;
        b=k/x1cp+h57WXt/yoFdd5sxu+Ypva6ej5+g9Av686FwYP6cZbuUiramc3VM2crSOt6Z
         koBpxXUzOBb48A3fDQX/kA2PgcAOYbJ/vkdmdkJU8YtgC4S040zMwSFK92S5mvic+CMd
         aVCZ4CnPG7OsZtUKB/ig6GYqIvcQCz7RXO3Kd2vBL++cNLp9iMqIGForTMLNYBkER0JD
         rL/JHYmkSG2xAHbT7hwC85jAt8QpxSelsVJFzR5wTRnBW6mWpks5xeZn3MAguUx9hO2a
         BwktU8Dqnq9iSG4Paal7aKRtGnKus1lZ/6RoYd13IOw6PiXmJaCKJCHPpppWKxnSik/w
         y7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZnRZq+fdakAXwHWM0xiZi9V1EuMD/ujvZKI5z1Jz+7UNt9LQ2KUSBPB/futsA1t48wsJhMnTP1TbRas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk87LhtLTza4CT4URswfyv8jxT5jA79sTgHlzUxo0cJkALvbX5
	y1w2bHWxiKAURjxOS51tPfCPpjoHPFTpzqIXETK6ghtmNT4pIJc4bNCEwCdfJ596HPOuXGmOC+J
	Abh2WvbkJF4Uwvm1lV+6NcAIhMg7URDq0TzNUByAnKz3KnyYdbI69CCXEo/8=
X-Google-Smtp-Source: AGHT+IEecUIe/3mJeXqe846uqj94ColRTwSF8cGgFVRmD6kx3NKadKMEHOeFVZymj8GAFI4mj/V+NoZfic5z1Qn5vuqSlilv3iZa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:431:b1fe:147f with SMTP id
 e9e14a558f8ab-431ebf5809dmr24172805ab.18.1761300663578; Fri, 24 Oct 2025
 03:11:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:11:03 -0700
In-Reply-To: <20251024071533.FBv5E%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb50b7.050a0220.346f24.00bc.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=147b0be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45603f6730eb4fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137a8c92580000

Note: testing is done by a robot and is best-effort only.

