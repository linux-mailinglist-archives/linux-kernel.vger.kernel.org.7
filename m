Return-Path: <linux-kernel+bounces-885989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2952FC3474E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CBD4EE2BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE382D6E5C;
	Wed,  5 Nov 2025 08:25:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3C29B78E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331130; cv=none; b=RjVx/lZNhNMrKXbVo0cPwZbDuyOdXdMu+FKcybpJ9IDaaNjGpqPlVwhbNfEVGeTq7nxpIUrZjF9lSviKx1SDhE0gCx9fwQOiaOX/Ezb7mrXbwlcRwAb93mMyfzujbRUxFi4uun0zXNekR/dOLkryH1VpKHbQBMWAqAGr9G6nnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331130; c=relaxed/simple;
	bh=GOE67wpi41jUoSc0MQ4KRzrdZxuBfrvSx9dUaIOHt3E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AbPVVkEq7bKvnXgEhhWJQSwSSgm9cvIlb0Nq2ilVg0A+8sKTNO904i6wZGUwi3czZ4OPed3tP2XqPCklSYA5hmjkb63HCbVRd2AzvEVjlArk5CsmiTYUyzBaABuVjnTqipsCJWlHiwDdA9TLsg5GWwsFDHRP8uAjWBbMm8FZvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433312ee468so5974645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331128; x=1762935928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prkYdn9mJny4BtkC26UzdFHiJbc5mYZSsL43kGm1Grs=;
        b=ULKPhZ3Y2u3MzONXyGYdpfnQjPNmtMYxPhb6exChBrPFhZ75+rqId2M0e0nZSktWS3
         D/2rXsQoI8nKXoTUP4KB8VIYjJZZdn/G44Gry06efuGdkFGKaktoKLXolwtgKqr5luPL
         nDR5WxI2b7tBLhUvXroMavqrj/0BqsutcmZlL4+ESeFKFEMzGESKtnZeG02eaA2cC6tT
         KtcS9ysWxwvJA7RNSvijza4FAHzWCyU+uD+rIJ5xStoOQhD9PUVc/avGjjgoVcc9cy4g
         Fj1dEnBjGnVDdXKoIhx8q+26N9kVKTxcKsYxLgqMfXa2aZwvRFEefHtFkVH/x81A8REk
         bOuw==
X-Forwarded-Encrypted: i=1; AJvYcCWLu1obyGQ8Uo5BzJi7rkr8VB+KdNQhMWplvTCSpJmje31qch8C9MFIlfh6s7vhDKuBeoHIBQLZBav5lek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgTEE/Xhxjdrsa71mEkH8nvyoUcMtKh92gaMwE748fBGaYDK7
	aX3PNoLT6cy4C+FwhcC6opkUjg2sDz23qnNODyqAiMGfH0hXMnvucRhBVEsinNxNsRsDAQZyJQN
	yy2OT/wJVG0qV8bWLb4bt6o7KqXV+rYzEtQZYGSPVjTitGC3YsaplgX8+ajE=
X-Google-Smtp-Source: AGHT+IFruNvAMdI/9edBg5y6Se/k77CL/Wgl5vEv9Zw7+7i6D+gB9mL5R5d/B3PTQ4SDd6dJ6HO6W/xGW1llPsREeaZ/LVN76Uci
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:433:2920:a0f6 with SMTP id
 e9e14a558f8ab-433401a3776mr35071045ab.11.1762331127985; Wed, 05 Nov 2025
 00:25:27 -0800 (PST)
Date: Wed, 05 Nov 2025 00:25:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b09f7.050a0220.baf87.000c.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Nov 2025)
From: syzbot <syzbot+list9b8f8e5b91eb4f6d281c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 1 were fixed.
In total, 21 issues are still open and 312 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10888   Yes   KASAN: invalid-access Write in do_bad_area
                  https://syzkaller.appspot.com/bug?extid=997752115a851cb0cf36
<2> 97      No    INFO: task hung in dev_map_free (3)
                  https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
<3> 21      No    KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
                  https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
<4> 12      Yes   INFO: rcu detected stall in sys_close (7)
                  https://syzkaller.appspot.com/bug?extid=393022c13d02e1f680e3
<5> 5       Yes   INFO: rcu detected stall in vm_area_alloc (6)
                  https://syzkaller.appspot.com/bug?extid=2ddfdc64a6b68a324ae2
<6> 2       Yes   possible deadlock in down_trylock (3)
                  https://syzkaller.appspot.com/bug?extid=c3740bc819eb55460ec3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

