Return-Path: <linux-kernel+bounces-892134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A044C4468F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08F514E3D6F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEA25A2CF;
	Sun,  9 Nov 2025 20:00:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1C258CD7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718405; cv=none; b=LyEqK9PdfzLPnE6brNA2bcrP1JpySMbGNxtNHR+oXWhSe8WjY9wPAv5bUMvAF8/eL/TinsFIqdzTVSyUzPdkyz3WXR5ukSRPEssvyBEJOGqhkM9x/OeOjyK8ORsQcQFNnsZOZwojrj8fn3sn2tYuHoZVmDraUSn2FBrbdb+vv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718405; c=relaxed/simple;
	bh=OYJ6ne2lDezWa4rB0UgObkRqLqe9wKySXuFFK7tx6Uc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yc5fmJCqQCEclr+ZjFME0WIsBY088hHERTc92JYeyUPo6FKtI2qMh7oiCVMq0RzoBwvowPGpgd+RAkwz17zWMX6WJjlvN0ZiXkHhxcyNJWlYhRKdW8hEeht8K00z4OYE/HlaEWA+Ic+z6lfNNJuMmztQCmApCLdHFZ9PmWsG75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9488163e81cso178112739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 12:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762718403; x=1763323203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnD8btK315sg2Zt1voEHKJyBAYTLemDjfI6se4fukcU=;
        b=eJOrSa3MbplTZ2W/ZRYkXUJcEHyk/EdlpI1ih5ggVUKUn++EWCnxX0uQ5rAFfaCWSf
         Ffw4EEQPibNINJ5xItybz82DaSRbgsFOPJ5rQ5K/AePIItiJq6mXLHIma85l9+95NQIR
         9WEQ62jEzXqZqs+VvnuMP/p8A/8W0mySA8/IdBqfy2Sk47fvfNgPmOBytSEaJHR3HrMH
         78fZBy/kzKdvrCRsrVdjtkteWJYcXGXIz5GaM9QGKWrcnNihNCvOm/mGdA+2mWgYA1TJ
         IqcWNwkq2txnSJWWM2io8IX7PM0HroyAsN1RqfuTZa5ca6Qs/F6iw7+4Y3Pts/ZGY5k8
         IXDg==
X-Gm-Message-State: AOJu0Yw7iBo10kMfveabqe0wV3k2oy1QtKA8EplX+dcWXov3IwV+85yU
	pxM+kRrOOTJzA37vgRRJRF+7rRV6ik7Gi+wldIS+yf9L7gbDksna2TYHAlpNqlac3Lw29xkGXuk
	CJv0FKVvLV4RBanZbQ5480aXdjHEywfuGcgNn2pf2hlTCf3d9nELoQchLixg=
X-Google-Smtp-Source: AGHT+IGyWclZmOeZ0ZUtQ9bKiKJYfc5Y7CzMLXuioAcuw1ptgxrcaraTYhce3yfY3lD+0so1GHNPOuV9qNaQNqRZxVSA7MU/Ch1E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219a:b0:433:30d7:7ab4 with SMTP id
 e9e14a558f8ab-43367e59b13mr85623895ab.26.1762718402832; Sun, 09 Nov 2025
 12:00:02 -0800 (PST)
Date: Sun, 09 Nov 2025 12:00:02 -0800
In-Reply-To: <CAHjv_atAdhZoCs=C1CFnq2ZdqycdaQnDi5MDUGFo5J_2AAdHAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910f2c2.a70a0220.22f260.00c4.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Tested-by: syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com

Tested on:

commit:         f850568e Merge tag 'i2c-for-6.18-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1357517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=a2a3b519de727b0f7903
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d4a412580000

Note: testing is done by a robot and is best-effort only.

