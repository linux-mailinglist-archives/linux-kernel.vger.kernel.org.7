Return-Path: <linux-kernel+bounces-894513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604CC4B363
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0E654E4CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D86347FCC;
	Tue, 11 Nov 2025 02:28:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA632E6A6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828085; cv=none; b=Js8G2D0Vs3/0PTgQyvjKW4re4dHlgB3Y5GruvyoJ8gSwrPj+L4d77d5H78sKJ11UiQtOzhnoWXJ4232x4XUnOpWJIPJ90TxWQCq+dH0mkxSLAkniFb9BhYSkjjyXk9SRVI4mMOizlqDCHabiYT69tOn/LzGsAcEpYLoFqJaUiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828085; c=relaxed/simple;
	bh=ym0OqX1psFk7YYrtptBXRXlD7l+A5Du6O43ojH3kS4Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sb+wGxWKyCjWrqxwTMfurc7KGaQrZag9sXeEyXuhPU1t057IfUQ2+GYgv6FY3J0cWpEuJfPnlj2JNOOQaz6YK4Uu9KAdPDZ0IinyUQmVV0tLQfv7i9hz4uNvhnnNcpfT2WtAYazfZ6NjCXSbOZW7sOefTalRedtF8jwLrppQeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43329b607e0so56706535ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828082; x=1763432882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh2hpAouIkcZ949ObzWL+KWY0b48eBNnxhGXlKrI3+8=;
        b=EJ48uHRxfVS0uP+9dacQBeKiugRWgeBY7/ttSWUxVX1bejBD3gzcUT2UamePN+oSA/
         MvtaNN/95wJ1YkHNHy2wcULhghhKzxKQR1t04AFz0nvkjjK44MfoxQFjEbf9fsiFBPio
         scZyxqEA6t8ZOcfKnH3DxE/73fU9kXpSYackoLPCT69nMunuISPJ9vtyXgyodQyh0nDx
         eMd+KVILAtCUumkMPeIaQJw34lYVybe5XFiTLEDIdK1YojfW+ypgD0Xa2+SQ6wIYGMPu
         os4Llx9D4GJZbXx6lcCOBBQsl8Jor3f1OqB5cBJv2Mm4orosI5MWSz6gHxywvKyVG7rf
         32iQ==
X-Gm-Message-State: AOJu0YzzL/0x/Xduw3x0lYX858betlwxmMAD0F9mk+gK8Sbz/IvkwV8U
	8vMlYQx1KueWDiKD0+VYEDJI5wefKd8PwiaKOExUc9NjFYTHrP9hFi7vX8YAOOlxkjH5bACeJEj
	xmu46ismEsKnvh6R+ajrQBNxr1tU7ikGqyXT7qADSd/ALdJux74ahLR9Sa1o=
X-Google-Smtp-Source: AGHT+IEG/1pDDDsMxVltX2dWgnzBxGnhlbG5G5QCRWpgLK8N33G8T9u8Jhat8lukmxQEbTejRAsGWt1wU4f8BDkMx/qND3pJua/o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2587:b0:433:2812:8066 with SMTP id
 e9e14a558f8ab-43367e44f37mr133038245ab.23.1762828082619; Mon, 10 Nov 2025
 18:28:02 -0800 (PST)
Date: Mon, 10 Nov 2025 18:28:02 -0800
In-Reply-To: <nytg5vjyof6he3v46kqhhyqochwgpk7bjx2topppykhqmw6kds@pin7crrdgg2i>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69129f32.a70a0220.22f260.011e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com

Tested on:

commit:         f8c67d85 bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10790658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1033fa92580000

Note: testing is done by a robot and is best-effort only.

