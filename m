Return-Path: <linux-kernel+bounces-879373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF6C22F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986511A26725
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894441D88D7;
	Fri, 31 Oct 2025 02:15:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956401DEFE0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876908; cv=none; b=bTizXrQHDSRIraGJoGpVHRgrqB7+mKZG7IAMoude33o9Xgwodm5YkWV1YY3QFOeVicTJYLPwwkVsMbJ7f5FGU9nSKzrU+Vm5aiQHyH6QbglQWUYY5jI3yW85GiiEbJAMc8X4GkZvcNy0IIgYu3YPHC1e0FG9v1NbOnta7fCuzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876908; c=relaxed/simple;
	bh=+mFl1uyVNVnqUTlxoyL/PzmZIDc9eASk+xqHG4K7DWI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hE2iBfHXPGbwRLUBADRAxfzpXZXfj4WOVvBNeJxKPngJuxM5YhMN3abtwlf+snjKBRQTBextaM5V2ti6d+oHQnYgyKgyKACetk6dkqCfgPG1Nu0up4mpc8zPOOViacv4y287jtQL7vLrtxSGS6/UL6uFAPgB0L1GYnf+aUfuA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945ab8d3d0bso207406939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761876903; x=1762481703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuL7K6Z5bBdY7m4Ni69nyEw1n4yrR+LADYSCNIs3ItI=;
        b=NttCb9+/xdU2ff5lbAU+zcZuNCEQzPT5il2/BoKou+Ns8/n8DWzRfJup5ZLAmbLMwY
         kv86c1mMWew+9jGB7NssLB0sNj/CzCtu0PTZwqJ2AiIBmxkkX1hJk34Fzzot3G8Gq+vG
         GO/ZzGz63lrsPVMZXR1tZKxorS4ZfmQ9qXazfYiULJLqE5z20pCOfRTgfcbD2oduiQOJ
         UfkdGHnoznuQM6FsTrYuw17Pp0lbAurhiqbVj/HtmZ9uxLuO1huycZqgCAE9UBjQqxWc
         3dx4QpQ9IIhjLLMf0qVNMAFbapdoRpf+SoK5eDwGkG0CDt6ozK/xuqyf1Y0w4+JSY8Dr
         J5vQ==
X-Gm-Message-State: AOJu0Ywk90uahZQzVtk8ePpQojBnC+rYfKes62YReijUvTXJhRYg1/OS
	1vEptMRGgDhSdqOGrE+B0ANvkc9c6jMvW2t4iZNBBNXq3gWgFAf8a3YlJUCsSShZMQEhJVDIylN
	omKBwWq5H37XBocVpej4v1TEmmBnUNpnmAV2xMcO45jY1gVwgJV9rXZDYFtU=
X-Google-Smtp-Source: AGHT+IEmtd6CeqoD9Z7rWXl7brCRLl1BSu/8fxANt/lOAsK4/QuYPmxGxtM8bH4qergcHkactzQLPE7kV57tMkleEZf0i+uffeR8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:430:c4de:f161 with SMTP id
 e9e14a558f8ab-4330d128661mr31410515ab.4.1761876903702; Thu, 30 Oct 2025
 19:15:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 19:15:03 -0700
In-Reply-To: <20251031015305.1439863-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69041ba7.050a0220.3344a1.0452.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
From: syzbot <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com
Tested-by: syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c7bfe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1473cfe2580000

Note: testing is done by a robot and is best-effort only.

