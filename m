Return-Path: <linux-kernel+bounces-702690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672AAE85E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F9F3B290B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C0265CAA;
	Wed, 25 Jun 2025 14:14:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817E25FA31
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860874; cv=none; b=mF36GELJ6lKVyC9NdOQ0vP4vNcFbYHwlsput5dPyWFHA8VbQ07XQc2lJ0kpvC2ssAcw/UZQ70ykaePa9cOBGNt9CFHlT0cyv2bIKz6Njqe1zFCgdiJ882cEen8TxYSGWy+ovLb5wh0vmEzb152L5+q8DLRSqe2u0XSPJQpQwnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860874; c=relaxed/simple;
	bh=TwJhoQVTKewqAiecfG3kRNUnDXWKo7e5dMkPkOD0uPc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IiMPM6U1vKk7p4hXoL1Too/vvcamiDHVXwO+ZEjHdktZbHCQULtaJh+8Tj+cgLqiTTWXw7+rfWPrwUODmPPiqZo3xwVgoCHBhZk0u8qCpWW9ubNuYl82u32WUGrBAuDKnx2R1nvKGCEZgKKcTgkq7xwAaYYOBUx3pagUc/cZLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfe68a8bbso161143439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 07:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860872; x=1751465672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVAdq5Xq3i/M/33mG03JeSbgLnvbME+n59OXXHf2FJI=;
        b=b1EwJ4kDrl7P5CJdS5V17B0aktf8L2lnMIpKocS0+S9+sk1uFwouIld4vKzMzH9e25
         SmQfFfZgYYaX9us0UJph6R+uxZRmZxHvCXSuneBqIQQ3AONHonv2Enu+xLzl384lbcGH
         ikzJLeJlvq9kd3xDIKzPxyMW3A1coN6HndSdl0sFxX2naEbWt+E4U4/p4w8TC0g8fJEQ
         s8yZ42yaj0bvapcLkICCyUigbf6+U8Y7H8b702kbWF2avy23SUnLGnfwQmZbh8OrrSwF
         FMXTssSRaHHgPIX9F7wm/7WzPJ/Hqx0yaCMCnI6J/yRu3lCKK1Hf9u01ITjScp9HvPPQ
         PBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXC+UAbgz6h2g4aHqI1VbYnkXAoF/RF0WkRGkHgM0aaFjfda40TphK7wvN9lMBrkuS0pwzaVquAefi/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXPM3lRPautZGligwkgjpeLpm9ZQB5IQce1jfocAZvusfDhZF
	75Ys77RfkWfp6CwNjEPyk2IWkzORUcNW05V4G6tnenCi/VAeAZ3HtzkvaBqhOX5WL0sQfNYbYEZ
	yeqdRyieK0ryNiTPUCzD7ed1mFptjhGbntk7ZxMi9juw7Q9jvvI7bdwIQqPY=
X-Google-Smtp-Source: AGHT+IFAY8cbF/hrLSvfXwLM3Q/WedY9hHd354EOrKS1CI3bA11yz9a/SmJikGlDR2rNWrnyoxqwq6e2gjjWCu9ETmLS9cysCgaJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cc:b0:3dd:ebb4:bcd8 with SMTP id
 e9e14a558f8ab-3df32920042mr36725445ab.9.1750860872003; Wed, 25 Jun 2025
 07:14:32 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c0447.a00a0220.34b642.00c3.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Jun 2025)
From: syzbot <syzbot+listb92358b4c1405dc20706@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 2 were fixed.
In total, 25 issues are still open and 294 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 269     Yes   INFO: rcu detected stall in sys_clone (8)
                  https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<2> 13      Yes   general protection fault in bpf_get_local_storage
                  https://syzkaller.appspot.com/bug?extid=e6e8f6618a2d4b35e4e0
<3> 5       Yes   WARNING: kernel/bpf/verifier.c:LINE at do_check, CPU: syz.NUM.NUM/NUM
                  https://syzkaller.appspot.com/bug?extid=dc27c5fb8388e38d2d37

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

