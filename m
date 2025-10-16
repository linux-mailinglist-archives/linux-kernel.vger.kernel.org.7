Return-Path: <linux-kernel+bounces-855746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9CBE22C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB91483D13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D6307AD0;
	Thu, 16 Oct 2025 08:36:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D182040B6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603787; cv=none; b=e+sEaFbrMJBL4pR8Pi1TJmh0SeFdyOf3b0Uj2xU+/tJh3huBm0XoNWLPOJuF3aHN2aXvwwUXfNdrSArqeNtPZsOMDOS9Jkr6ER0zAKCxd9ewnhv0PzGiCBoVq0+//I+S15IY7KqfpUtTyqAlV9zRoY/RgYpnx9/NElCOLd+3OMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603787; c=relaxed/simple;
	bh=8MUj6qyjYnTTQOvmPkpEhyV8mZAio0fZko4alPxIYSk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i6QNr2EI4leEfD3mX7RVllG/bKqaH6PbhQMYzAySsqhinDRXO0scAd78UQNGbKMdiQJ37KkUIU/lSfHU9ufaBIdjb9BmrfUvTr19Wct0iVPYlI4oXA8zn4SMwrOFlg4f7CbhGmhd2Dr6VjGdKV/Fyj+NzCyJ+2fbHlxGTHFmLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b03322ffso14744335ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603785; x=1761208585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SblbsSfQCXkxVngmocYPkbkONIPvuCDleLX032/rk8k=;
        b=Bwm5bjUCRu87UKbWAIPGnt4+p+ZMsdIfAJ6SLvTrppmvWj6nmlXQRA/gtkjwbdwQho
         aY/D7ccLxWiJNLw4CNfNzQ548MGGGfQm58PibF/aAAmyFgSa4ExAPSCgcxw0alGYoLGX
         nPetRNI2Qv3oaz5vuG/3PlMM3X1WcHQP+NFkeya/eGAt5998DlG24bqItgf8WZesTrkh
         hq3R2tF/jubcJmheDQAXLiisJO64dM6ODZ+ctAX3l82Utvwo8N9XddO2p6lOiSvZg47b
         4kmsgCgGwDsZARbs414bkSOmJ/r+1lFuRxVpRvn1F25GxQ6ZZ0p/CoBxNvgV2TLiXSh1
         Ch2Q==
X-Gm-Message-State: AOJu0YxVJLwWu1CjjNvObacdN8uw5fGEnflGD9k8vTj3BEsUQZadnx3c
	40Cu0fHxIKcCMRI9LGWaKOkhUSUtcnYxiLNOGowxg1G5WIy28jdf+pJArtwoYPIgQk3dEMaiuQ5
	7f0yk8HYjqz9kDyucSFW8PCaCjevYjpNQCu/39p4pvyXrHpgz0lpMkdf1DS4=
X-Google-Smtp-Source: AGHT+IER/95QsMONNzCVxGOjCiO0fm7rIZDRnw0mhgwh/04mcMDIkgzwvi3UqUCSDVnmqA8k0omRNWegCPvSdPod+M4R0UdqZaGm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:430:a5cc:c8e8 with SMTP id
 e9e14a558f8ab-430a5ccc9e1mr106444805ab.28.1760603785612; Thu, 16 Oct 2025
 01:36:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0ae89.050a0220.91a22.03e2.GAE@google.com>
Subject: [syzbot] Monthly mm report (Oct 2025)
From: syzbot <syzbot+list1a8ee4d1ea17f2fbcfa5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 7 new issues were detected and 5 were fixed.
In total, 117 issues are still open and 349 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7428    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<2>  5678    Yes   WARNING in v9fs_fid_get_acl
                   https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<3>  2930    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<4>  761     Yes   kernel BUG in __filemap_add_folio
                   https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
<5>  589     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                   https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<6>  582     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<7>  485     Yes   kernel BUG in filemap_unaccount_folio
                   https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
<8>  469     Yes   INFO: rcu detected stall in sys_newfstatat (4)
                   https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c
<9>  457     Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<10> 390     Yes   INFO: rcu detected stall in x64_sys_call
                   https://syzkaller.appspot.com/bug?extid=65203730e781d98f23a0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

