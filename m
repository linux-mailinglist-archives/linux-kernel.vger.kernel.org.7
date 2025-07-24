Return-Path: <linux-kernel+bounces-744220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08727B109B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059B41CE31DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77A2BE642;
	Thu, 24 Jul 2025 11:57:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895892BE625
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358226; cv=none; b=o9/UqdFpQsrlUaW6ublsYAJLGkFE1s/Znvg4u9fI6zM1aGl/EDIad0659WCilPcRmDOD35ZAAzmVJkDiRqg/pD1q3KZO4YF9zZOM9WhRRXFgOnSzGlCHF8znWSF8E/fSiG9h2CTIs6V0yg92yuYcIWesWd8YLOFf9XVKki4fDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358226; c=relaxed/simple;
	bh=WkTHvxCudTJ+htgOxmMBuNNdNOV2TnDRvTf/bcR9QmY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWXkeggJrBxtl+Tgxet3lYv/XyJ3Lj9+ZaWmUnfW4WbEgFl2tzSrRxCia+L50kmRu11RgOrTMh9vk8qMBn4IaRJrkmR7K7DZu6aG6ffa5eCGhNLFhG7RRTFmLTKDzpcMkMnzeX7dEnUSIKbCSkQBir6Kn96sdHEx+xLM64+BZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87b89891d5dso182001539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358223; x=1753963023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVsAhpNRkWrO5l1ARhX9Th8dO5mHiSeSKk1eXlQht4E=;
        b=pyo5G7u05NcuRgvXmqlJu7LZPJdlai7yvuy/wsOGzwsB8yqVW4zb/ZMQTk+YaAYPJM
         k5wLd3BzdZkkeK5/SKgVT8zmJG5K8Nj/Xx/spR0vIxzw/z20UOm1SE5v21yR4UxzUB4i
         9aMOSAlGTE395BFW2/qm9NPpD1Zw7L34OkQqWX2I/zWokx8Owm7+LZtX6+eYFvDNTAUv
         KJ4J2NwvqM8UhY8CSBkmQHooY+U2oq9JBGM0im3tCS7SHH42x7sx08VuYrkVR4FziLph
         M/PwrqV92bAIASk3Q4ix0Z7vOalSg7dErWG+j1PkX+LItJGp0PvfZmn+ZxRtpdPEWVJg
         BRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUm28lGvllVGTOONF14++38jGHE92A2Rscd3m5amk+Csd9J8zLZ7evJhCTJCHzec51Af1FXQdFdAdKbIcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVly7cITa08eN18aljE6YshlJx57T+8H4jKoDiL7vGXkQzEifN
	TCegaDP0spCWBcTbKehonDnmyV+MWUv+JQQ+4BsLnpmQUsWF5pEIuo/zunRithpmHhEYb0uxalD
	PpQBglNYBuuRlbB2+Nhab1bLSwO4MShFzXCM8PgE1asayfaD/KEOD73fSggI=
X-Google-Smtp-Source: AGHT+IFfrFXHvzXS64pTAv1/aR/NBSGN3z1S3C28Yojo2Hh8GtMRjf4Iw1VrR5I4xw5vI0dt45XUhrqs64V2s/mTW08+d3U4K0EO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1c:b0:87c:2e82:5a6a with SMTP id
 ca18e2360f4ac-87c64f95c36mr1338819639f.4.1753358223607; Thu, 24 Jul 2025
 04:57:03 -0700 (PDT)
Date: Thu, 24 Jul 2025 04:57:03 -0700
In-Reply-To: <3d164a94-b643-411b-9f22-3bb02af4e4f0@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68821f8f.a00a0220.2f88df.0024.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in
 gfs2_qd_dealloc (3)
From: syzbot <syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com>
To: agruenba@redhat.com, anprice@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in move_to_new_folio

------------[ cut here ]------------
gfs2_meta_aops does not implement migrate_folio
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 fallback_migrate_folio mm/migrate.c:942 [inline]
WARNING: CPU: 0 PID: 30 at mm/migrate.c:944 move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Modules linked in:
CPU: 0 UID: 0 PID: 30 Comm: kcompactd1 Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fallback_migrate_folio mm/migrate.c:942 [inline]
RIP: 0010:move_to_new_folio+0x696/0x7a0 mm/migrate.c:996
Code: 0d 01 90 42 80 7c 3d 00 00 74 0a 48 8b 7c 24 20 e8 2f 53 fe ff 48 8b 44 24 20 48 8b 30 48 c7 c7 20 bb 97 8b e8 bb b7 5e ff 90 <0f> 0b 90 90 49 bf 00 00 00 00 00 fc ff df e9 7e fd ff ff e8 62 d2
RSP: 0018:ffffc90000516fd0 EFLAGS: 00010246
RAX: daec11f2299abc00 RBX: ffffea000100abc0 RCX: ffff888030f88000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100887b921 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: ffffea00014e3d40
R13: ffff8880443dc7e8 R14: ffffea000100abc8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce2e39a000 CR3: 0000000057fda000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 migrate_folio_move mm/migrate.c:1301 [inline]
 migrate_folios_move mm/migrate.c:1653 [inline]
 migrate_pages_batch+0x1c34/0x2830 mm/migrate.c:1900
 migrate_pages_sync mm/migrate.c:1930 [inline]
 migrate_pages+0x1bcc/0x2930 mm/migrate.c:2039
 compact_zone+0x23f4/0x4ad0 mm/compaction.c:2683
 compact_node+0x1d2/0x280 mm/compaction.c:2952
 kcompactd+0xbc8/0x1290 mm/compaction.c:3250
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12eac0a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118ee0a2580000


