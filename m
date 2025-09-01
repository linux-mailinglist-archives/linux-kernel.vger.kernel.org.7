Return-Path: <linux-kernel+bounces-793991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C65B3DB3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E47B3BED9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55E270572;
	Mon,  1 Sep 2025 07:38:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E026F2BD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712315; cv=none; b=g2HMRdsg8JQWJwVLhZhv6MXTYRdxVsrYLe/PxwuiTuspw4F27PMca5sxGjYwdwfevhEgiMZ4Uzt02Vb5oot9Mc6/2QWpTyVzMGjk7TO9WHmITlPaOYNxE9jqzm/gXAnybhJcHqWoORbppKwCd1lMpWvqeCfdC+jYKUPK1lxosOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712315; c=relaxed/simple;
	bh=H1mxaiAMN3sc2eH/vsvRcfjUz6xIJV97cFrGw0wJMmo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nbxf/4O7XmEnxrH0eyUPPgbehR4DoYJ01WTAMnZ7nu3T2ZeL2Do9RDdck0qsD70/PjAWh4FQ1PMJEbjsjv+G6UD2agDrXQhTIS0ekLQsdlT6zEpA3rAgeBrad/H1jSA9hGcogBrb07z3UxSenuwSMPNu4DoXITzzD6TRTUNipsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886ff73eacbso926260439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712312; x=1757317112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obHWzG0ygEaObehtACUvL+DH8pKrrwQ0y+2bONAOBfg=;
        b=Ed4nd2d5gPiw9cSytdpSYvkjQ6LPgTj6ydzCmNuHfzczcOvhe8bFN4ixCy9U9tWou4
         TpX5CLh5niHoinEZyfVkPmme/dKLsoM6jJQ6VBz/6NYlYKxJkFEgQqA4bBzJ5bgi5QyJ
         BqT99pEsYTcC/euCn2EUDW50t3a4BWvOmz2l/9t04JJfmFu3t6CdYjKmDOe3jGd6tu4z
         acpPAhIul7Q+y1SEttnWKEjq5m7sgig9bE8d+PjuMWA4aRdAO4gofiWUQfqrPUcWnBSj
         LA+fZorN0yww1Jkd3JUsQVdNMxoce2o8TcKjh9hV+DBIOs8sFqpRbcVRK8fBpoMyZMrn
         WTGw==
X-Forwarded-Encrypted: i=1; AJvYcCV7PnhdIgtOvWPv6/VNRQKeyftidOfaUIbhK84oV6vC8B8N1m+/J9dAXAEmg1HTMMzlmZkpUnXetWffHnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm9tebB1/AhJtAWInA7A0ciOEzdtB6jdMJyemcMRZYbI7Ek/C
	TfZiFAgO6MLCC6uLstOyJSEsZp2OqyipmaolSaQuRv2wyG6l5jbdySf4z4X5l5jLyagMF1TnsQ4
	59sWGDpW+im45vdbI39fkHoWxrQxhlwImWn3j9DGeO5LoYa42W0a201X+pxc=
X-Google-Smtp-Source: AGHT+IHwJr2Tps5ny4OjP2FS9RRvLgmLjK2SqygClVKfYMS5rNpQPeem48MvZ94Qxz8iif+BgcBOiBp9rZELv0Nu9xUxQ36YmO7f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:180a:b0:886:f2c1:8ed3 with SMTP id
 ca18e2360f4ac-8871f51f15emr1016078539f.17.1756712312641; Mon, 01 Sep 2025
 00:38:32 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b54d78.a70a0220.1c57d1.0543.GAE@google.com>
Subject: [syzbot] Monthly tipc report (Aug 2025)
From: syzbot <syzbot+list7f83bd0f801034393a79@syzkaller.appspotmail.com>
To: jmaloy@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello tipc maintainers/developers,

This is a 31-day syzbot report for the tipc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/tipc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 85 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 676     Yes   INFO: rcu detected stall in corrupted (4)
                  https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<2> 86      No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<3> 26      Yes   KMSAN: uninit-value in tipc_rcv (2)
                  https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
<4> 2       No    KASAN: user-memory-access Write in tipc_crypto_stop
                  https://syzkaller.appspot.com/bug?extid=2434dfff4223d77e8e1d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

