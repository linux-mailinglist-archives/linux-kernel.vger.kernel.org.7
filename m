Return-Path: <linux-kernel+bounces-785008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA5B344A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7538D1892E13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563A2FCBE1;
	Mon, 25 Aug 2025 14:54:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83A2FC022
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133646; cv=none; b=RdR4dOIKCiLolfyUyXALogOdlU50VCbYztvtUcczBG9OAgAXifMo4AivsgbNveDiVHoRH/rBh3MN8r1iSZue75Eww7M77xTxgHVvH5Le0uxWqiaV/j8bwkiFSsYV7suX8bE+XizwcMD4H2nz3QkLq0gd2+cfnxoZhNtx/psE/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133646; c=relaxed/simple;
	bh=RYFQttZPQBLdTyL00fjIksscvOx7+ZWQBTuIJxy7cw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RnKPRsdxNFYGNxkLo58eGCuy55+Unsw/ybKkfhTdgzEv97UKkT6La2/rzyQaqY2jzIkv1YvM2XCCu4H2bVs6wzFtticbjkHlYeXsDt6RKgGVW2oktm5qNCJ3BqapcS1Z8cLM4RM0Yn4617vZQLC+bgE+dmwa3nyoSjw3ggUUxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e671c9e964so46096255ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133644; x=1756738444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks23e8Q91CQ7KaAQ1Tjq9eK94AD7/WwIK7YtecKc1XM=;
        b=mp9asCxcq3D0UukSmFx+3RCKYg5fM2CxKvseiqmiFTB7On4TnhpEpje6HFoN4VSWph
         Sgzu+iLevYexpt8/O5HY78ZPzts7ifnqfaf1Bjf5oQow5a4dfCQK5xH+W2v5Ua7rRhUX
         lbPq45l1mN7hvb81JjEzrUQfevOTobCGVf/M75/CEjC9BQyjQ32vgUsgSKNPQCP5gdj0
         BKivl2xR/uzSM6O55kK7pU8puD4n9t0ro48HujS2GCVar2lspmZKcokDasjxjXJvQMa5
         HW0LBXscDhreVpnZvRgU8pT5h+kuH5qa3ySRsnC62kucd2s+kIq2iGZKVI456RnVINQH
         FLjA==
X-Forwarded-Encrypted: i=1; AJvYcCVM5nlR7PrRd19/67SUMuUemMELrR162CpllO/8T6XQxsxr9vop8bwQ5OEPPOgMX1k/HsqvL1OxHHs9f2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXjwtVSgSLkZbcLBltUsDs4g67qMzRJ/dIx1wWFZCYBpGV44y
	riax4jT7WgfMfEFXPCn2mtGj9eNtVYNmFXdahki3efSsrb6ESWLaVmfqwM+YL3d7Ew+9m5aLLP6
	WLKoCMG7Rs3z5bCh9FdwFt4Vq70twB0QLMSWwxM4hBfBN13wvoGTuQ57ZFcQ=
X-Google-Smtp-Source: AGHT+IEV+VyyptRyr/7EBnA/JSPf8pu7sBw+c/GLiXBPcD6TdhCdNFG/G0lngV0hKVH63z5s5QlSb2A2h86r6wPSk1CAJDXfK+QI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:3eb:e261:15e0 with SMTP id
 e9e14a558f8ab-3ebe2611d45mr77989085ab.28.1756133644131; Mon, 25 Aug 2025
 07:54:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 07:54:04 -0700
In-Reply-To: <0d6d8778-a45e-498f-9e31-1d926f582d7e@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac790c.050a0220.37038e.0095.GAE@google.com>
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid
 context in dummy_dequeue
From: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, ysk@kzalloc.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com
Tested-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com

Tested on:

commit:         8d245acc Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=17b38462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ee6862580000

Note: testing is done by a robot and is best-effort only.

