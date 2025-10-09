Return-Path: <linux-kernel+bounces-847186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990FBCA318
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 077EC4FBE3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207D223DD6;
	Thu,  9 Oct 2025 16:31:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43B54654
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027492; cv=none; b=CLjW5IgUrCvDyTgWT9Zqo0gtmK6Hv3nMoTdPBu0U44KOmYobbb6SNDItP8iJHIS2o25PaF7WKBoMUSWD9Zj4oDeLNt/BuPsgkvicaASAzL3oOeVxXCLbDtZKULVGN1pX72PnJezgO5+1MRN85cJdLyvQ/rlruKk4GnmD+Gh7vxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027492; c=relaxed/simple;
	bh=qrYoADEnVXD0we0CMIGwA9CwQG9JnCQdKbRtnkxQ5RI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pJEEhhCKBtIvhqo/uXlXK5Rz9ohfgupUABp/ZQdgru0CMN9+xjNrgdrB4fmiDdmpgW2uJpXBeNwJpeHADRLfoWQ6D7w5ynH27Jv9inuS6Aukle1zyOWdMa+0lBO1qn8YvqB90HqMKmWfhL8MJ/ADbhx5eDMpf/Qypc8sGuLk35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f8befcb06so21107855ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027490; x=1760632290;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvA/J4dyztXMhogEO5JrwyKZPNKcLHZNyBJCUhQ7UMw=;
        b=UzHUx86A8z1GMyOSZ6Q0XDSN42JBLCAzMJMFr8qAxOXgA6Dop1NgDNLbM/rq9yizL5
         i3EmlQJd7F9J+nTlKdR6AG0GEwW52Ng+BJWHwoYa4B6eiGQ4692WRsvip4lPDHpNejEm
         iySS3cgBjnt2obop5u0YQyBqHpwJ/UJoec509hWKRPN1exJaC+Zxrv+jqJ+kz+C5+zqI
         TYM431ovAnuPyUGqnPT9pWW/KHf2HFSfXOBBAjmx0MYpo9myDLNGOmC1inE9wKZOqOwD
         Yq9OKAZXuwbWlLfjy6wH/UL/NX/8hiCPeF87Va5490t+ruJMCMaksxajRER4aCwd+0WF
         bp9w==
X-Gm-Message-State: AOJu0Yyen9hmeFofZQpl/5qfMtMrVbOoZeLDZstyTpAr6DVyEY+VCZ8p
	wFc3mSHnGK6euA2jNiFHJVT7RY3dM0xNtHPe/Ol8hrGBtHhhjdMCdQnUmHyTMaU0dkFRPtbTk30
	rEV40wzf+a76LrWDMVf5BSpyp/nkGYlzbQFE55EquqjpymEVWiFk8ntyrViI=
X-Google-Smtp-Source: AGHT+IH+3ddjgqrEcOVhLcyur4IziVSjaf1FPkRItg24ZYiymtjP8/LF++Mm4T8LVfUSNmSyxqfMm/gjl+oHOieZ3ps/9zMniNVy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:428:24b4:42d3 with SMTP id
 e9e14a558f8ab-42f873e3dc8mr69617735ab.15.1760027490108; Thu, 09 Oct 2025
 09:31:30 -0700 (PDT)
Date: Thu, 09 Oct 2025 09:31:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7e362.050a0220.1186a4.0000.GAE@google.com>
Subject: [syzbot] Monthly mptcp report (Oct 2025)
From: syzbot <syzbot+listd2daf64d46ed16abd4d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mptcp maintainers/developers,

This is a 31-day syzbot report for the mptcp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mptcp

During the period, 2 new issues were detected and 5 were fixed.
In total, 4 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9       No    WARNING in subflow_data_ready (4)
                  https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
<2> 1       No    possible deadlock in mptcp_pm_nl_add_addr_doit
                  https://syzkaller.appspot.com/bug?extid=7fb125d1bae280dc4749
<3> 1       No    possible deadlock in mptcp_subflow_create_socket (2)
                  https://syzkaller.appspot.com/bug?extid=fb2c3fa2ba28aec94627

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

