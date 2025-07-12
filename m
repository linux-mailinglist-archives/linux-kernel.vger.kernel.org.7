Return-Path: <linux-kernel+bounces-728499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF64EB0290F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAEB5419FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F08717A31E;
	Sat, 12 Jul 2025 03:06:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004D2AD0C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752289564; cv=none; b=DFakcus+IeutbAOq5TvcJcX145WATb66a35bYjaeHQkB4ICE+m5kG+t4egrg7sFEZ7nuaM9hQh7jVqSe2VUOswnNyC/izhRNkpqtJkYwxS33puVjkLiK28lC+qjlwxXblG8WQya5IXTumzy1wCmK5sFyti+6byBLIpg7hRbB8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752289564; c=relaxed/simple;
	bh=6K8Q3nUxNMXWI6u5X3ooQwJHwXSbU2/zP+mQ4ntCYrM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IgbyvyqO+iUI1XYb7bk0o38qMt5nUSOn+gX95IlQ/us6W/F3N4cadTQNXCDodupgVjyM5zmsLFVq6bomr1eoVN42Box4f31LauPqqIrNMuUMhVvsPQWSxhPFZhq30Ww4ACTmGv5SkN3qgx6Wd0KkYsf203EebvT/TnlSrakRRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8730ca8143eso355960739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752289562; x=1752894362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZerS+1Rl07g/SxHtnO7Y6WMrwGicrzVB8pZyK4FA8dg=;
        b=gmMErPmumxngwuQNtbuxnMg98LPC0/cDG/htFfnFahZeKqYwSGI7VZeKogKWRiiej6
         5s7WMZOjUjVtZU05ZHWkwbRS9lZaPAl8LM9W1ZdTRZwSEtxS2Mef6qQF/lZ5SNUn3NBa
         4zVS57Vwlyua7zL6BPfZ9jMMWXtb+Ay5Hvl2whVD2hbUMhkWC9fL+W6fkqUkKmrMBprR
         9FbUPCDYgpG7Rbqo/nV9SEjFbCmOoFGscRaD0drP8AOEsD36xNI71I5wEmI4LMZcvGPo
         yyAz1290zZm2ckXj6/db4kteQE87Py33Twzm/T+ZjsveDICYagXwW0wvJU/igq1LBROU
         hNJA==
X-Forwarded-Encrypted: i=1; AJvYcCWsTjoqveSgn9w5wOiHICYB9eVrKDOpRVC8w0WupVKjMV/Hlq1ziVRpa1QuCfncYXEyGF0floT2vz9tncE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxw0izuqLwZdYDS88czSouR+T5e7WduCbpmaJFRlR8WfNUDbfZ
	QCRW//qi+Rp+I5XMLouSyjzDcyZOxRRGjhmKufLnYjPZOb08YTdFtr3FTHw2kCY+XUUNwCluMYy
	LBO9t4u+lVfB4yVNHR2a0Ok/pabrCcuxhIhjdwl4DRpn7ujlng7KvvrSQYcI=
X-Google-Smtp-Source: AGHT+IFmM52/FBIkY4ZxB4CF2KYP0mqGz+Tq7msl7WUZVaRP46CD9mKlaLECGJK5+lPIo9ut+blFB+tPTo78Vd0ZAbaYiAQze7lN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc4:b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3e244642b0bmr73060895ab.4.1752289562288; Fri, 11 Jul 2025
 20:06:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:06:02 -0700
In-Reply-To: <20250712011856.3599-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871d11a.a00a0220.26a83e.006b.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in rt_set_nexthop
From: syzbot <syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com
Tested-by: syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com

Tested on:

commit:         379f604c Merge tag 'pci-v6.16-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a0ae8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=97bf275720e06ad75f63
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14db2e8c580000

Note: testing is done by a robot and is best-effort only.

