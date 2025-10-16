Return-Path: <linux-kernel+bounces-856443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C2BE42CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70C68508A95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23219345724;
	Thu, 16 Oct 2025 15:17:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88632860A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627827; cv=none; b=vBClzfLBaEtvAOuR5bztUNXh+Y8pRol/Jae41H/xYc16kW6AZ3dQAIbNK6JximrVi1z515wseuE0HWmeK0xzeOqlf1QQ1U8g6LUFuofPaBv7+LTDpIE2LNJwhxP2cqHnndJVhPkKuA/eOYFaQBRBmkU8MAI00rihTMNmIt0UGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627827; c=relaxed/simple;
	bh=rqxB8fRZGr/vpRI0rlbG7eUIE0NetMIvAtKwGEP3Qzs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sw4oSCq60saMWBTskCsMgS2T+zizK3gh7eKPpe8MAAQKmC+WjKPpjqko8DAyhwP/TDDf/xPD3y4afedptvDE36WIdeLebhCLLmpyM2BndQueSaFZF4RyEdXL3ATgkjN8bni03EhbN1Q+mARtUc5xt2hIY/D3Ic3r1AroOkoMjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257e203f14so36055565ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627825; x=1761232625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YIEw4zjHFhmxiznPKTUuOgfVZrZ8eBhLOXiXO1y5Ro=;
        b=dvvd4ulvJW11CEehztruUmiDKbrfKza0hR5SrtI4YlE8Vr8TQgsMFg0wxJaNRFgr+e
         SGwriywDipdFgJz00iYrVmtBKRfbFkV9UEPtFaZaKZfb5QEM6GbnTOug4ZtczNCwutUn
         aeaOeAXFsfwyOVCfqtrYia6Rm9O1r9yJBa8l7BO6qrhIkZQkc14YaaZpJsEmo8PD8oFi
         2rByUNRItSiEIGv48RM53lRG+ovup4ylUF0fQB5E9VQTJoYlvYdmd6BeAoIFsvwbWi8l
         RRwn9bciTrX2G1vvQ8QXRuxFgP3OB4A9p1O+Kd7/zi+EkI2ZK1pNaMkNBKVmgWsy4j4S
         xukw==
X-Forwarded-Encrypted: i=1; AJvYcCXI18MB8PSRxOhw8ozWljj+7TdfQ6USMfZ8EidckHQMy4b3pXk8fRmp/r7FwyUP8hJdLkw6VEclv76Uep8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQKKeaBQZQoZDt0D35D1Uc45HTzsX95h89WyIQ8PxLsmOLroE
	CMN+5TMVQuelxrwRNmH202gjSDv3M0+eAV9rgm2+jmsn80Lb8hWIaXMbmCo2HFWg2GKDJm82EPe
	STZ4sKuFEHMjJUkjdg32+E3MRtj/yn4BHLX6eUtsvD1JWttBRnpciyct5Ggo=
X-Google-Smtp-Source: AGHT+IElJHTTAofewZGbiItx2fBhOAecgmEckdvr/T9JQW+qO2PL0cL5r0TQ4jMQI9MQo5vAFV07y+S3LC5seLXP5vWonwuhL/zE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:42f:94f5:465f with SMTP id
 e9e14a558f8ab-430c5292301mr9370565ab.29.1760627825380; Thu, 16 Oct 2025
 08:17:05 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:17:05 -0700
In-Reply-To: <68b09cce.050a0220.3db4df.006a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f10c71.a00a0220.361615.000d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in truncate_setsize (2)
From: syzbot <syzbot+0d26e9339d135e85c6e1@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10240734580000
start commit:   b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=0d26e9339d135e85c6e1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14309c42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1198eef0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

