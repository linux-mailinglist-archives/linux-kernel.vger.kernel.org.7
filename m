Return-Path: <linux-kernel+bounces-695260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6326AE1794
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD01677A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82460283FCC;
	Fri, 20 Jun 2025 09:32:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DB2836B5
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411953; cv=none; b=TlK9CsdaJmJbPrsu3FmiLmsqZv/IBrrxgvW8i/ExO284s3YlDHvEaNNLxZpS/GZ3VI3e7gyq/xdjSLGGvr/MDMBHB0eqP+9M/egxVCAOF5zRZ4qAA+CS6fHCe85HP25X7J1iCrQSratLzXaKHMK50YKe/g1h8u3mB9H+2ERNXsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411953; c=relaxed/simple;
	bh=XSt8yjir+j7q6ThZS+DLNWaeRixtG7m5efJNSrgc7dw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uYPbW+TzR5Htdv6+57nI0TWLep3Hgm0+vKnZIwKa9UQ+iwqUMpeAbDnW2zROgYFgmVc1DkzknKAs/3Ry7EvvXeAqo1E8mcKfZXGVJt8a6wsz8OrPRXdmWOqAHhLNE4CPsmnrO2llcb+E8TFIMFjzmj+O3CsfLOpgerPLPulDRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso26485085ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750411950; x=1751016750;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9E2kq42ZD9qRSgSXyC28TJfm5YqId2EmAZSaqaw20PM=;
        b=p2IWHrY3+juc0CYgzfF9vkgI4PJfBPFVzvsn2Okhz/XMQsi/hL3o5rdB15RBUC1ADs
         2PftIRqEU+qz4hXfbIw4/gLkFc87mrUCDf88OjtdSoh3hNUGYmrjun6QPwcFkm13k0m1
         z2BIzc9AEMpIXYm5jAO0VDykna+kb9Qv1xxM+shTGt0wEJcsQxQb9xDJTp4x+qdQOpqa
         UTqV8s55LWaDCUSc93sjKRnpqPS+mIba3/xXMG2uKjV7m1vOGFKlSXZGnZaWi7juZkMF
         V4pywUIJGXX/QyrFSSDVhG+vpKlbhyIOn01yIy8edF2airKVFoww4mvQg6xLLrmpHqo5
         qZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWsjT7SmuHyz0YY0uxRBaxWqaDzQvG+m1e8uSFSeYldk+/I2tdU9qs/PIN5DfGGNzKaPWV9ReYGE2wbGDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOTXVwWcfghv9PoYvjM2eFl1r91nCn3dTd9ZkJyczJde+3XSV
	Y0qg1WhEF+pUJEucrbv+EJmOABr08M41hnk7Dlhua0/At9ecltGsrXJvYKjAeu9sImlRkNwV/B6
	OyfDxvFibpHpnmV/2WNp+AfTH3tjMsryaISOLVxVAPmQdEqaK9RD40XFxKvw=
X-Google-Smtp-Source: AGHT+IEreq/NJ2lfspoLHxJH5IT6SCQ358Wmd/1Ww5uHreuDQ4u/nCE/yJSSxp3ZAgE6q1WXDu4CQ7NMMXsKx1Eo4LezLeM2Al/P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3091:b0:3dd:c04e:49af with SMTP id
 e9e14a558f8ab-3de38c1df1emr27315815ab.3.1750411950671; Fri, 20 Jun 2025
 02:32:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 02:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68552aae.a00a0220.137b3.003e.GAE@google.com>
Subject: [syzbot] Monthly afs report (Jun 2025)
From: syzbot <syzbot+lista4e2951ab8aafe47e457@syzkaller.appspotmail.com>
To: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello afs maintainers/developers,

This is a 31-day syzbot report for the afs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/afs

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 587     Yes   KASAN: slab-out-of-bounds Read in afs_proc_addr_prefs_write
                  https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
<2> 42      Yes   INFO: task hung in afs_cell_purge (2)
                  https://syzkaller.appspot.com/bug?extid=750f21d691e244b473b1
<3> 13      Yes   WARNING: ODEBUG bug in delete_node (3)
                  https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

