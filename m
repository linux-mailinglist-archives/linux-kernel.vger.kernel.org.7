Return-Path: <linux-kernel+bounces-830509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F232B99DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869857A72F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764BF3009FF;
	Wed, 24 Sep 2025 12:39:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF92417C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717577; cv=none; b=fY6aTCoHmMNiEMt/EG83Uia6mNWtxDnMIRgrTFQn64CZLM0+K3EmGNb4U7fyk6oGdsr9Us48FYiEck4ULwHXNDTYNyBo8TWLeKD2BfFktO4XJ8C8dtuQ12n/G0pog5e/C5O8SpBKjd0va0Uz0/8Q4R8J8JJHaWVYXIV7nk1bhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717577; c=relaxed/simple;
	bh=k3UC0+sDUty0bqHOXRgKqlQ4Wfe4JIgKWq6+jTjIefY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QD40kf+f1ki/M2y2dv1JcSj8jBe32p/bOMfiZ5jWLQHhOnHDVpVQKAdv4HAmXXurHDaER6sKqJ2HNqxz4JfeQZmEmMwqPEJ6iLL+8YjJ2dKdQbOsYnQIvwQQ9MOUc4lTfP944T7liyhE3s6zJPvaBBs5nLSN6DnP1DFbLi87UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42575c5c876so42030375ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717575; x=1759322375;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCBkAvciMIfhEXb9B02ZXA5Q7/R2bL631dgebWBIimU=;
        b=nOoyCOwRLK/pxu2tPNTWp8YpHq3iKriJwGXtDwCRCqWDvRDwVSxoV03kZpr8LgftFj
         I2bW2V8KGSmw4K4enV8RvfMARdQJM4BqgHkHCJefE1+tX7bioXtVP8f4rRlJdvr53AUb
         7e/Y1vc7r3c3hP2vv6zQFHE1SN6TKwjggyYDb7WsdskT3OGvpxC0m5V7DsGUIJ/Bl4dZ
         S0UAcnA85E/K5dVxv3b3cw4182JHzrihE5BLIVvCeHBVa4XFcnq205uoEIODcFZaFVFG
         npPqqFPgPnPL5QQrcfcAbCi6wdlB9u7SgUQhlpf6NbPVVj+SEQv3/RSIzm1ejiGaTnMX
         c5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxD6TKZHKKJbo5G+2iyUckT3bivxvORq8WTE+ffy37fDnTZJGUIvUn0bP0qNYmqIxsbBOVzDv33JnokRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxcAIETjdQvMuw6O9mlLvWhe6VtZW8oRcflLvzqejErVZDYKk
	AEWh7yCl5BCxMksdXmPBh9pOVFO7CHEz4Wt/57N0NOjp9H3ikszxT/r9Z1biZoSXekDBdwf4jWb
	C8+4dLFosFzXDXikk7a3Xy4kan2EhDUv/r0telcaO7n/AynyRLj8C54pPXlo=
X-Google-Smtp-Source: AGHT+IGglByV7oAt0AvvUsyv4OluheBxCIqzswCTekEX65jtiEkOcG4IX9vOVIkgRX1YKd1ZxVskcuoi0ggOIR1TO7+iXh/bn0T+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380d:b0:424:8d44:a267 with SMTP id
 e9e14a558f8ab-42581eac095mr102076685ab.29.1758717574612; Wed, 24 Sep 2025
 05:39:34 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e686.a70a0220.4f78.0023.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Sep 2025)
From: syzbot <syzbot+list84175158135809b979c6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 1 were fixed.
In total, 38 issues are still open and 91 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  43283   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7364    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  3411    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1710    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  719     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  360     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<7>  304     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<8>  274     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<9>  139     Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
<10> 113     No    BUG: corrupted list in hci_cmd_sync_dequeue_once
                   https://syzkaller.appspot.com/bug?extid=5250d87dea2afdb718a5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

