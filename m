Return-Path: <linux-kernel+bounces-862501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C657BF5785
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA018A86D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5E32AAD1;
	Tue, 21 Oct 2025 09:21:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40B31D736
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038467; cv=none; b=ZnUY5ifjHT88eUDxYwsWQ4M/Kaj4Meof/n2yeH0wbl1/Ti3kGWuNeZ4t9vvx1q5oSrFdLnmOCy71j/SAQVORPb1LTJyvHpwjtQGZ7yGtA1ZYCoWc6RSCQPVZlu9BTdCkGL08+CSYkJDswx5aGfMOeaTmNRJRSoWGQFqpQiyTZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038467; c=relaxed/simple;
	bh=GY7wZjI2iTLddGSuG3FjHRQKtmIfi6wFGWQgOpbMxXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ij67aA9hSyQlcro3enZ929AC055X0TNvg+Tnz9IobuaK845lWr21mxlnK7rHRJvn8vqdbwvBrx8PHLCzxtsfyXPKtgYSn8rKCGoO/OZdnfvy1U5GS/TGpRdaAmmMHN1UDcbkI/3vsTuB7yxZTDmpBXD8XWERRI1Vlp7LQvXRqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7d299abfso418407639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038465; x=1761643265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUi7xkZCFL68/kx+rtEpM93JYfFqkzwn4VlhtQxg4f0=;
        b=vIKbA4S1udTzlsdxGzWDiwN0xxzi+hvsjTTfMh4xWvAyIbBTMSpXraIRPplKDx+5pf
         m5gthl1WpjSFqMMIZUWs8peYtGHatxNEDhUpwBSUrGNn5CcfzcfcjDjJbV8sIsj546mf
         XMddawBYh230eqQ5Wp+0y2vUyHqVxOarOJ8Eo2e2asC2pLrqWgjs8pQCDXEwP6UeR7ce
         vlkXMKtJR5w0/XKlVDNILAr450wnYXeQ+syg2U2MkcK/xwdisvUjTUl0FCWnOkClaqCY
         0lVRUpzSmHj15ziW7nRvY7piCeUVyK2ZbYZ7ZIP5bfNfJ5QetqLGQBXpP6RkvMlUVIUh
         8XhQ==
X-Gm-Message-State: AOJu0YwRZWc9RhjySOzaSD05irRVPtw8ay7tmSqV9iIkVuaolsHG4jDI
	pedfauJZV/taADQQFz7H0E8Dy7GR7qMcdBj1gHBu/vlqI6qDSUUm4dseDQLtApFeXBrCxbcDTNt
	W0MTlmYQcoPtErZ9Cujk2/pdn3jSG5pwhKdXyUNAImyaC7T8CVwNvXD1TaLc=
X-Google-Smtp-Source: AGHT+IF8uUuwnVUtIGEZDOBF1wI+HJFjyvqx/H8EKJshI23T6/xZ0D5mk+kD2YkPz0vt1M5NmdWlc5WNH7eJeX0yl9YsGCtuPPdk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f92:b0:940:d860:cb71 with SMTP id
 ca18e2360f4ac-940d860cebfmr1044724339f.10.1761038464803; Tue, 21 Oct 2025
 02:21:04 -0700 (PDT)
Date: Tue, 21 Oct 2025 02:21:04 -0700
In-Reply-To: <6c4d42542afeed40435ba0abb94e753e1d259ce1.1761035574.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f75080.050a0220.346f24.0009.GAE@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in poly1305_blocks
From: syzbot <syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com
Tested-by: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com

Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1287a3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=01fcd39a0d90cdb0e3df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1530cd42580000

Note: testing is done by a robot and is best-effort only.

