Return-Path: <linux-kernel+bounces-600304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C236FA85E30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F027B7374
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC34964E;
	Fri, 11 Apr 2025 13:07:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371625634
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376843; cv=none; b=Ay7XuLlhjzfrJlA7SrJ221AGal/6VZtg4n5ye9MeJt/QmwmVdndeSNHOBzyvlkBWiCZoTu0/QGM+2l5G4rZ5/I8ODnXAygZ4eWPpNFjeR6luWLMzF1FZAC8IOIO9BRWL8Z4/xtIkSJUHGtITCngXgw+X+tHAiRbhNRMFbvxIVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376843; c=relaxed/simple;
	bh=spH96PgGCe3FyPMJbH7IqkgbG26PXyo76sOr+JoBPS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XLvdZ2ZQoxRBsEgsVCdtWe/iE/ffMNRYmI6h9sReJ1G0QPOnzjtfFDAs7M6uPwrjeY1Jd44UxW0Swe9begoDm5vTgP8vi1y4DJQX+7ourQkmy64rI3UgjLcjJu9z5ZqfnAH8DdShSv/0bRyZfim4jcUD8vHJWdWkgiSWcQFQb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so40444705ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744376841; x=1744981641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5t+V+PJBNrCRf7SuNBoLNK8zVU0kFwToI+VtpEMXY4=;
        b=KES8Aua4ygrg6YzUpEf+yXL/ENGL0usCiFeAsouWv45svdPybONdreNAHwknOP1MuI
         F06VtqT5cX9AyNMZjmp8lSZ6piBN0ILbZ5+LZ6E4o3SLiLcJMocPq55cu2qt6IoQPRm/
         27qg79M5kLVCetGQKxyz35wLyG6WcVdERRjH3H5KkFG2jJ6yPsKBTBVZbxMAw4xubff9
         TDzrxtTtgoHEBIgfdbrJZ5Qr8D0jSww29DJba0QYlEEcjrZLOGfbjuTaM6PMyo1DnOZh
         Bhv+ZEoHfJxsEHIcm6GdEaIZvO8tdh/w0Llcd2zGSxO3gO8pNypEJWxEfsw6kn6bmvWO
         7Sig==
X-Forwarded-Encrypted: i=1; AJvYcCUXd8cgEnBUlICILvpgLEPXNlIvg7wVYe2Nzac2Yb2RnBEjphu4yhpjC0Vf21ZSzHGyNkrWGGykI3ZEQBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsavfdyp6CV6i1zgmZyLr5i4AIA+itpZd1G3Xx1wq4AAnWRLT1
	k+r5nn0FVUMzkjm6XtAfRT82o31Wt+CJan0PEEAggjBDWeQIpdTSVKsQ6zT9xIs1q6WkmcRW027
	WuYVzMfPaGNFeqjsAmqh2PoJ1gRXqlmAkP5lM7oVufinjuEgScomGjAY=
X-Google-Smtp-Source: AGHT+IHylQSQLPuTufArzk4fimUu3VvUqWSvI7rPJeLl7KDcZ0xfZf/P8RL8ka9hymqKn2mPM/LuDeJZGEgwSL5mj/z8hLh+fTgK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3792:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d7ec1f3fb5mr32697045ab.8.1744376840793; Fri, 11 Apr 2025
 06:07:20 -0700 (PDT)
Date: Fri, 11 Apr 2025 06:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f91408.050a0220.355867.0025.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Apr 2025)
From: syzbot <syzbot+listab49c99c53036ef082c3@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 265     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 32      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 14      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<4> 11      Yes   WARNING in cfg802154_switch_netns (3)
                  https://syzkaller.appspot.com/bug?extid=bd5829ba3619f08e2341

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

