Return-Path: <linux-kernel+bounces-676951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD772AD138F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B13188B562
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD61A5B91;
	Sun,  8 Jun 2025 17:33:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E413CF9C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749404006; cv=none; b=nktb8ZkRDFJOeJxjU6Zi34SDkPv9x0Hb2jJZUtdfg9ZXagYbUyE9QMSJ7RJsP9q33VTzvfGLUEMY/nl4xJJS9uFOppqP9K25H15W/Cz2sWp3gXFlZ8g7g/MoBnExOxszq/xd+rUkdmMFGUBZz+UGQsbKHz0TPhZ5OZERccC/JLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749404006; c=relaxed/simple;
	bh=1dcZaILzSakXHRsTkrO9kppM/tZMtQJf+QX2iJF1Fxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PhLXWct3KBiAefF9mMmC6HnClUKU5QcHCcz3pnmxQXBqHo9NTUE/et3MLM6eTkH+qaE6Rd0cy1LmBnJpKXR9fktLeoDSePymWMTe0vmrGW8n0tJQ3UPPMXU3eCu+gFJq7joSyltWdEMe+7DpZVFaKSvoxPNejdrMhpasS5erlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddc4908c4dso51374165ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jun 2025 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749404004; x=1750008804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFW/NuTEn5TNLyBWHCBQOAd2Uud9j7JfPOBL+FUkB7A=;
        b=YYkvkXob+sZUtFYlUMI31bDZ/f+SyCXW4xXuybx4w4f5G/q6Bz6TDujM/zSkfAxPDw
         ruy6FBgN3b7marQWx2hi9PhsC6lo+YspP66HSryWE9oAdXmJ2KRChkxmNDAKCo+3so5g
         j5pnjZckfrUyNFZc+sl9Ebs22c7v+9IDtr50TQxnrNvvNe4AUF7H8sDLy3jRs6ZxeP92
         SXcqo7L/iq9sfKo8lrJldNpJlUf/hEnlOOg4ibDuwmMqmamRCCxEI4/EJc2ewmQLxyAs
         +vhPUvkxzUCtzVW31NYvBhjwOP5jJVbwRYTurJ8Az9Sb5cFmTYqtLJ7ujH85hl2uaxPs
         ldcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcWf1ZsMU+P2HtbxNU5/KBAC+KVTmbzUL+zBzkKlWQiJaJrVekAO2ohVNT+uiTY0Sp9wM6IqnezypsNBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuajwc4Q7l6RYSA3iK2ZwGLFMI/Wfmb/C241J6cB274h+m59pJ
	43JeDcI8M6TbTcpM9ZNahxVJQPO0L7MGTQ7pmzjT+U5Gl7UQmiZgcZdc0lqgGSVzr0T6XQfa76X
	/h2XChO80ZiKleIYI/3erP9Ct1dijSS7dk1svVB0SIxRxPj8JeDBWVZY+eQA=
X-Google-Smtp-Source: AGHT+IF0lc9ABofCUqs/RisGvJeLynT7Jt763hXtaN8l8QPAdT4+vCu+y3llhHTSImkSLUsFk4KE5uQJZ/N4Vl8hJase3ANmr23G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:3dd:a4f0:8339 with SMTP id
 e9e14a558f8ab-3ddce3fe9damr119300195ab.8.1749404004336; Sun, 08 Jun 2025
 10:33:24 -0700 (PDT)
Date: Sun, 08 Jun 2025 10:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845c964.050a0220.daf97.0af2.GAE@google.com>
Subject: [syzbot] Monthly kvm-x86 report (Jun 2025)
From: syzbot <syzbot+list7793d6728ee703d6cd2d@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm-x86 maintainers/developers,

This is a 31-day syzbot report for the kvm-x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm-x86

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 2 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 585     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<3> 6       Yes   WARNING in vcpu_run
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

