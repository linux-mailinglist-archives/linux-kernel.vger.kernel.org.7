Return-Path: <linux-kernel+bounces-777138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C3B2D5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC174E0364
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981972D9EE6;
	Wed, 20 Aug 2025 08:11:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8882D94BA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677499; cv=none; b=TjJogeMF+y1RQTm/EuRdJWxB+ZYnVtDtBxyQvs90QV2hQHeJ5FQPxXqNSb/VFHcEfF2vJbfv+yhZ7UYEB/ZR45JE40nSa0ydkGYnbBlPtpBHOJd+IjuVqaIC8O6F55IxzvSladtXUqlK70LqIJTToYVT6aYcItv1zxrxl9C8XCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677499; c=relaxed/simple;
	bh=V2ORPdLKdyIF6IEfPL3tmlEaAeXzXJCqBpmsLyhacgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=osw4Ulm74dnG1PnHayIGNQJ0ZDv1xWdWbWkGRCJW4bqQIBIYWyHkKahqkE2ABAiHN/2oi1q/LYi7pzwGOBeli82/6OESHrkIGPl0a+i5nLgM5EwJyMT+c64OPR/vdoOF1dnFNJPYwJ+Lp7yxkuFSPDfpFuSMK37BkVubfRTO43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e5d398a961so98762595ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677495; x=1756282295;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfbB1FSHiw6P4C31LBsKWDW7GmtJlZq19wObesXeHDo=;
        b=rrgS217aq1Ni7fqpEQgkct/ia3593dfq6XZSpItSkKUsLrtKbdH0KPcpnq46scDR0p
         IG46Fr1uBDoFFhAPxUp/WFONN8AgJUPT743X9t9S1ct3QtTJir+rEmy4D15i5OrsWEss
         T/e/EjHfvgKHwdS2UwICmokvH6u8Sv3XiC2Vr68PFt9eoZIgZvxAbsDUtmi9U6TF0xBH
         JZUaFvJl8olZWAWmwd87d7/0TWiBWWyn3a7hafIrubFdZNgbuHjJ5/rc4iGeUFuKDJrP
         dR/V52AVm1zG8GwNOBjl7igniaUorqTnfBnwSEBoOm5TSsyj3kd2Rskc2Pupu1ESVGjl
         meqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6NYWyNd0O60HDkEzOiKPGy6VVLGvMen9qDUAFLyUrfQYdPxjqeEMzdPbloniUfMpS/TjbVM9xkXdoSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CAgRqB28KCOCswt0BcvHKCpiNJWZccp/+rnsV2z3N/GiGUg2
	PYeOlAyTc+AB1+85rjZBqPdfhsmOBlDyU0XRlpsdcV0DOJXkBvLwfDmEMo+AmZR5DHmS/QToSfK
	Z78wb12pvtCa6pMIC1t/iUqA1uAaWw1HJbGsilxCnET4D/HFtHdGvVs7Ok08=
X-Google-Smtp-Source: AGHT+IHnRF+BVNV37CIIil93Du05nxMCfrOSZyzGWdOXk9nJ995NrsrdEI3T3s9GiJy67Kvuu4cXP2vILSqqRV705ZzYbnkNZ5za
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2511:b0:3e5:50a5:a7ef with SMTP id
 e9e14a558f8ab-3e67ca7243amr37639535ab.15.1755677495685; Wed, 20 Aug 2025
 01:11:35 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a58337.050a0220.1b2f6c.000b.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Aug 2025)
From: syzbot <syzbot+list9abda43ae935f9073c3e@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 2 were fixed.
In total, 10 issues are still open and 191 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 552     No    KMSAN: uninit-value in __schedule (5)
                  https://syzkaller.appspot.com/bug?extid=28bdcfc1dab2ffa279a5
<2> 203     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 104     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

