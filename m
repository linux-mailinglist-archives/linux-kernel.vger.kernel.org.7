Return-Path: <linux-kernel+bounces-884126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BFC2F6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E633B810C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F24259C92;
	Tue,  4 Nov 2025 06:06:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C406EEBB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762236391; cv=none; b=aIz5fAKipEmKVZMO5n3FXkIRreWBRgu2TidvTNyJcTVmfduDA7PW2lEJIe5Mhip0WhvDMcVFVm57jxs2hN69PWLaNQyhycy9GdQfUk7LIDsyA/silu9yACwvzCSNT0De1LIPyhdA6Ru/EyFyZNaCw96rIpYDlYNIciJ6VY18djA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762236391; c=relaxed/simple;
	bh=YCNCvryIgbweInETRVCdOfA9qW63yMtsogrfrsAKkQ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T7zpN+uqqqh6LcHdjA3oyqehPt0+3oUz4MBbrlcUnKgb3wk5veNZtUSREAHW/sdSToJakM2qoMA8p+1I3T/fdkC7CcyyndyWV2ml6n2Mvaj1ilUDT2I25+qlH65ZLn31eCMOQjIc6IpNdTgLNHbMfGIA601ZKZe80uy6qzXZOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-9485cb0d460so31054039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762236388; x=1762841188;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2MtcMlEE82GEjvJ+h4Eq5mxYoxrPD48G3ns9H0l9m0=;
        b=JhT2UrnUvO9w2dDLmp+11VxRpm5bAvGWC4U/DYuBFAVFycYwCBOKsHs/zncc/VlCKo
         Ej8LVkGniiQ1hczEWAMZJwguCpQ7fI6CU8aOl4EYSLMDJcz1djlX2lhvd2Qoj9y2FORk
         ytiPND/R5l/q28c5BzLBUHyeob6DoetVtxkB/GVt4XVrKw2oDn3oUrrsXamZgHEPk1ZX
         DyP1uqx1+xGNRCLAEexV2r1K2sSOEtKvu+sRrTm7ZAGDU8XGdAPjgKM34QGCPpchaaRT
         NwSJUAXEg7PzgUGJcCfmm7UtQ0Ukxc4FyHAayJSi7FO/J8POSCui9UrLThnLtaP8B4gO
         69ZQ==
X-Gm-Message-State: AOJu0YwINpR1kmiplylCo7Npx91+PrarvQ+MigPkgqt10QsrYI7eQehX
	TAbQo6xbCOak7vkZyQaVWSbBxhhxXTylI2uqh52JudFJJHj3Rkz6JJ9oVUJxg320cAuWrj/7S84
	MfwBnHhdsM5Tr8Kzq6mnTsE0kY+B8tC4oB4xEuRt5nWX6OQtiLGjBfrs0wEwMrA==
X-Google-Smtp-Source: AGHT+IG5p0Dbqt6s4RBcciydL3vrwyBeGqPctE3XSn7wYfhwTandRIj4t3iAkyFjDSFQ900oIWQaulzt6WIrA1tjS9zUnCcpdg++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f81:b0:93e:7f36:a90f with SMTP id
 ca18e2360f4ac-9482291deefmr2383992739f.3.1762236388397; Mon, 03 Nov 2025
 22:06:28 -0800 (PST)
Date: Mon, 03 Nov 2025 22:06:28 -0800
In-Reply-To: <6903e832.050a0220.3344a1.044e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690997e4.050a0220.98a6.009f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
Author: listout@listout.xyz

On 30.10.2025 15:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e53642b87a4f Merge tag 'v6.18-rc3-smb-server-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ca5932580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17273fe2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15374fe2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c69a7713b158/disk-e53642b8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7138dd74fe48/vmlinux-e53642b8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e715eea6ae3e/bzImage-e53642b8.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/cd997f980581/mount_0.gz
> 
> The issue was bisected to:
> 
> commit d2d6422f8bd17c6bb205133e290625a564194496
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Fri Sep 6 10:59:04 2024 +0000
> 
>     x86: Allow to enable PREEMPT_RT.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e84e14580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e84e14580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e84e14580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

#syz test

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8f9fe1d7a690..895a75b036c3 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3023,12 +3023,14 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	/*
 	 * Way 1 - Add new + remove old.
 	 */
+	preempt_disable();
 	err = ni_add_name(new_dir_ni, ni, new_de);
 	if (!err) {
 		err = ni_remove_name(dir_ni, ni, de, &de2, &undo);
 		WARN_ON(err && ni_remove_name(new_dir_ni, ni, new_de, &de2,
 			&undo));
 	}
+	preempt_enable();
 
 	/*
 	 * Way 2 - Remove old + add new.

-- 
Regards,
listout

