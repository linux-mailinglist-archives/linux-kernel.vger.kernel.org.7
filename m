Return-Path: <linux-kernel+bounces-857482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC326BE6EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884E0428683
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C8242D91;
	Fri, 17 Oct 2025 07:22:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E8265CA4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685728; cv=none; b=ip2QzmpwNxHf/cPig9jibqFmHFVUPd0z4nML2U3QazIDdw9s5MUMX3p1frK97MoIRLA7Lp/nNPXs6EwUsWgkKosM1aFriXyMEC/qHMYkQFDK7C4A+nU9eKRYVQnp97LcZZI/K+A/6rrs9Pr0NTk3iJD1Z3xJNf53mr3RmNy1h68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685728; c=relaxed/simple;
	bh=q8lETvLaobuL3XgXbBKnxQsn+bRCtfzBwaEJQjNgDqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uIXsWoRRCX87W7USLLetg8zRakA4+dPhmaZdC3CJWtYCsZKeWrI2w1Y09/DlqxP0qwYWSs851xNJ1oUkSKPyV7fylAjfPhbQnChJPXMFW/r+g/43/M1vQa4Fh9cU9q2HohsAXCvFgNB4uJiw4asIye5xg2a0DIm6CPJeOysjtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-92d4dbf9b51so464720339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685724; x=1761290524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdCmJA8jhBXmo4IBQnz6DZIBUwH7MMuVcTakMsfhXEo=;
        b=DS6xfOgAZNi/llI3yY92a7BB9o19Jbui87Nqso6PN4f6MyWHMMbWSLvq6/IFN0CHV/
         siOnFvPCAeFZtz2BeAEC6g9KJbAjxvWNHsoACqWUYmhIdECBYBrKWZvBeXgksXVYdgpi
         yG4acb9HYaCTuOwLuqQFrAxhbNYZPGG9LKJrUdJrwZQVzQxJDjF1mnD2DWCIgmic2JrY
         NOA0eXdccR+ardixDfjYVBLokAiuWwI6rJvoBOFfCGYOW8CnMKpEzYGrMOJDVH0NPwW6
         r5gj9VJcN5xcwIyJlPFibOYtL8LN76PcY+QIMxEc35ypEGnqVW0QKLOOVjpuPeXTBGjs
         SQ1A==
X-Gm-Message-State: AOJu0Yxusc9eUFZ74OAxB6y1+xJd1wfCMsna05vrqy7VN7g+/HaQNcVG
	qLld3FNR35q6L15WqLg9x/llFlk8Ol0lUfoPbdzyEcX/iIe6RGfHimlMawqZjVUEVlfaMVMQrUa
	LHXTc97UVRGFO+QR+i0YSZZbB3wFzg2eSoT4qBfFnocODVU5qFGV0yleiJao=
X-Google-Smtp-Source: AGHT+IFgiMVnSrEVd2xDfgd8O4XbUaNXWA/Td+9ca2dZKYpiwJtifThtzyAm7PJLavQJCLBlKSR8+m0MYwlDaOv1TnpxDV8mLMiZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4506:20b0:430:c8ad:81d3 with SMTP id
 e9e14a558f8ab-430c8ad8410mr14490805ab.30.1760685724070; Fri, 17 Oct 2025
 00:22:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:22:04 -0700
In-Reply-To: <20251017065045.1706877-1-wangliang74@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1ee9c.050a0220.91a22.041a.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

Tested on:

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10084de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f81efe6184ed80d7
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115ba734580000

Note: testing is done by a robot and is best-effort only.

