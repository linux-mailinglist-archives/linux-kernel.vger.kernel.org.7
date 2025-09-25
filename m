Return-Path: <linux-kernel+bounces-832772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C7BA045A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BC47BC201
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C12E2F03;
	Thu, 25 Sep 2025 15:24:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC3288C26
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813845; cv=none; b=CZiPgUGRAJoDdSI9Cnvaw7ODTETAth8XJrftDB5bdJia0EHPqPZTWBvhtOhO2XZ3i0eahSPcPT71RIjs84kSKHTCxilPewlLzr39It6L/7O2C0PWZTj6kkFXmPrgWPhA9dxlynDkTWsqQVwze5aPn70ZDhXkaDlX/CfE69JBZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813845; c=relaxed/simple;
	bh=kGr3nrzeR8/F2Mjzj8t/M7DWIxj0WymFdipHIDIzGqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A7AlG+8hNie751nUwZ2R7GjKGmXzXcyOauC8ycqP/nyul19SH6xNNQZZsXhNRNBIW/ekJ4mjgfDodFP5rkUdqJHo0pT6onCFufVsUf0sWN55QVyZAN6D/fRs1B2zo+a2Ggt8kDOVnJhRM2j38/gAWT0TbPgv1KxQcSAgnGR2OXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42571c700d2so24890145ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813842; x=1759418642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxh5s96LCNd9ikId/sxv/BmGLoqIAtvtuwT/WLO93cM=;
        b=oLuCwULms1Br2U9Zfy8CcMEcUSm5mJfBTkzkDvKcakNcP0IdQR4qsxLxbXamRfnXzG
         X9el3HWQ2mu7TP+mQY7Gb7MDIn/5ccbfr7sx02iVGffvHbmmnyfdxVgt8k3aL3KFeT0a
         Gy4cCvgar6VWbIGHHhd1ZLst+EzIEcA6oFVZJui1xEPc/pyjVxLktx2a8GZdHen0Ujtv
         xHbl6QCpnwp3BYh/4lgleo9Whd9zAkRT/GSNz2KYdT2FJSB7CTlE51WyZ5wXNgiyiIne
         9rpJrn5UwUEIsQgz3MQ277d4zzh04ebYU5rzkW7GPuC0HhFCmSTc892KIOCLjtck+SQd
         LUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUanhb8AsqwEfAYPo0SMxC2IfV8JhKqCXIQ9snHP/StM/VjifjEvVV9gsuNjV2+JoJsOYYRnWB23dh5VH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrK7orSMG5NfN8+gxyBnlS0+93Xnsg721bhBUZzJ8yWg1iUNZV
	Zr+p0/cAi8ibPk4Kma1oDrdIyjAAVN+M37jIrqhle8Aa7d0/rGS0P98uG+Z1RCLajsfvVvmZQt9
	TtH6TWR5ojR/B9xmyTsnKvYaTtqvHh5ZHrNX7OpS38zPErPyotXwq2ss1j2Q=
X-Google-Smtp-Source: AGHT+IHeE3pd9te6t3rx1sayjW29x+4/HsjqFsS5bYtjXrk6mv0Jbez/zM/ZCAKOSXV4JDb1JUdhR6fNZ8VhlC7vsWvt6lDr5DzD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cb:b0:426:a72f:1c7a with SMTP id
 e9e14a558f8ab-426a72f1cfbmr17061615ab.28.1758813842702; Thu, 25 Sep 2025
 08:24:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:24:02 -0700
In-Reply-To: <CABFDxMH6UKpBs8GEhvuA=E2=QDRJehK4Gzg0WbbZfYmta7Swxg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d55e92.a00a0220.303701.0015.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Tested-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com

Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea1d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1105e142580000

Note: testing is done by a robot and is best-effort only.

