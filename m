Return-Path: <linux-kernel+bounces-816948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C7B57B21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A033A9FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A83090EC;
	Mon, 15 Sep 2025 12:33:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E083019C2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939615; cv=none; b=eHMqcJCARTAZNr3GHVf3hZnskOAXjtj09MydjUqLHj4s1O89R9qt9l4smGvjWIFGjIJYsJai2fQ0FozPAlRPR028WukMZHjCTb3Kkhwb3XNrdGFuhMzcMjuzB4/RqS8RP1ldHPNZAluL4nWT7QrAgzeQKe6g22GHSeeFUDXWGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939615; c=relaxed/simple;
	bh=mkfxhxO5ScFXWsiUPniKXa6nzPgwAWZ4l03poV8U9+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oSHtF4Y8YJA7g3J7MwFwB+0hwcM+jkmZaUWZ0Bi2qe4yKgONne96UJ80u1Uf2z3eBps8enzJvrIMhlEetK1PiXiC1ZIWmCcCwNT8JYIXqxCHJ1Hz8LBAA/M792E28liLYs/13D35N3DxIunSCfrgPLIIQDm13INauelGYco61+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424090abf73so6923445ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939613; x=1758544413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKK4zDUIxsAmsfDEa3KR9K/Y4eq48dkCLdUH7Uw49FM=;
        b=g1YCGWniyGzDXanLLuWmQeKoz/S1ZgNwFHThaYWhdGSBU6714DXl2JfHSIn4tlS+ZY
         04IuRN+kc+/sLlxwxRU3ATHN1AK+PgN1Mihj4U2WWkX7J1N1jZz5f4BlAW1Pv1LgwsuA
         IDb5jdViPJuipzjMR/AwTP3E7jMNE8W9lx1hyNGrnAwNVBq1qkPezwTVP5UalwNBSUoO
         xZYQr5TBfDgI31RIcBPyGRwqm2Y7kJDoFQ9llb7mMzgManEuZLdGIrVJOgsIdx/r4z8D
         menVpBo8szar13KQa5YWN0FB+Px24dVJWC+H/UM8nv8UcDPRnqzUdpZqHOB/rQJfsmG2
         roFw==
X-Forwarded-Encrypted: i=1; AJvYcCUeI2GUvjMCNSIdydbMQT49jDM/44ltDN1xG8pZlrdZmD2uC1Y1a4GCFOOCVl7ARwt/JyjCjuVuujSs/Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpRyjVnX5yTpopmmA51kJsJq+ar4ApDHLQzjyrnR/pMWDW0xt
	ofrI7b5/zbkiQTDkdU882kxIJKfJbpV7sJUFfK2441+g0kJzLcXvV7zZGABCtJ021hzBgVErn9S
	Iz3ctwymz0PVDVnB3OFzFxTNRB/X9gjCaSfz8L+8h3l0UUGRwD5WNzlrhP9c=
X-Google-Smtp-Source: AGHT+IFTef8u8kJ5d86e6D/xRM+920v/pXfkePhDr57nCgIHu0rgSkAE+v8ScINcUklMNz2Qpda699xqVeueGr8dqIebQxY8n8kI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:413:5e19:aec4 with SMTP id
 e9e14a558f8ab-4209e278566mr116167385ab.8.1757939613224; Mon, 15 Sep 2025
 05:33:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 05:33:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8079d.050a0220.3c6139.0d14.GAE@google.com>
Subject: [syzbot] Monthly kvm-x86 report (Sep 2025)
From: syzbot <syzbot+listaae77a5bd21f06f0ffbc@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm-x86 maintainers/developers,

This is a 31-day syzbot report for the kvm-x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm-x86

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 74 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 642     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 27      Yes   WARNING in kvm_apic_accept_events
                  https://syzkaller.appspot.com/bug?extid=b1784a9a955885da51cd
<3> 7       Yes   WARNING in vcpu_run
                  https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

