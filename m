Return-Path: <linux-kernel+bounces-879757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A929AC23F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D251A20E90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8D329E62;
	Fri, 31 Oct 2025 08:55:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B95328B77
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900931; cv=none; b=Eas7gjlWQjdqjCNQ421Giy6NaYIIMgM/z0F7sqN27Ajl8PW/H0ohIDYjKMnegSgj580gSZh7BACc6xgTXubGzmQKbiq0gXAH5i+eZV/tBzv4oSAp+0ZXvulx408wuy6zeKRSt0VC34K+dVwPgeysW574y7zYCNyvG9UKkVi7GbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900931; c=relaxed/simple;
	bh=yKJia9ig9B/6F1hYjOmDx4MH0LEy2pBuagFT2leWtpE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tP0SaPvMuNLOzmVM8skj+LtPnWKGIvTnKJhRWhcWiUAGcrx1GSPY/oEkBLxxrH2tH0jTMKbC2CzY73RNv4sc67e81qiWDWb9GQMaZSNYMsvfeNjPsF2YC8nCsX38iRUhnHJA+53S0NxKL8GooUuclCGSmLMXoGcCcqudTarfgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430db5635d6so26222005ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900928; x=1762505728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQznDTewHzt7+x/YG9L0Jd10kp8tx1TfNBen+HEnewQ=;
        b=BIX4ZQZ55ZcRlJPIrTZ2Td2hnkys0XjMQCp3lo2taTBmxMg0sPfUaaEue17VkdFsMI
         WkePtZ3xgRwD43FexExjbEmPVDQDPOvBemBurOYo30ch2koZstWmsJsSta63gysHZr/2
         sdejkNecKwAZ6HQ9p3AnK+TLeM0D1geEm6UozTX+AUnEu1W7kRFbzRKteqwhFSQw5ktC
         83cU1q37rDXDLtmzJ1oxAMsxlIR6GDdPOeBYn95gmaK8dN2pw3ZkwAzxUAs6TnYHdGUn
         o90/N7CQ5oGOo+DCxdlsHZ23WYpPUHgYOrL+zELooSgP8pDSIFX765hvDNEVoIHaTaJj
         iqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzn0j1pTJh0GKPbmyCGWq7SukYP8Y/hAk7bWde2aCczfNA3OdmTrzHJ28J3OUEuVfwk+PJV3MOrbFm4tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIiHeS5QbvQCaSpxs6og+yyFOTIZmHZEMzwDPfhC397phclwm
	yw2GlRVfvVx58aTDR80McZLYX7uJ1F2mZk6xjpqi38b9vS5+k0L3ymZG0Xcb+FBUQmI7LKCbNN9
	XeqCCsNEwnZQj24cmC3kZliGAJHRsYluwDooXHvf0HnWQd0wQLlzvYLDIhcw=
X-Google-Smtp-Source: AGHT+IGN0FNZi7bjppFgoPLB5NtNJOF6wA2T4eKlOvcfmIP1GS399KhMwT/MT6NeCXq8YnHjmGhpHmQGtwidwTeKMvVqhISXsqsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:430:ad98:981f with SMTP id
 e9e14a558f8ab-4330d14382cmr45224415ab.4.1761900928655; Fri, 31 Oct 2025
 01:55:28 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69047980.050a0220.e9cb8.0006.GAE@google.com>
Subject: [syzbot] Monthly fs report (Oct 2025)
From: syzbot <syzbot+list0377cc5e08cc9b971109@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 5 new issues were detected and 1 were fixed.
In total, 59 issues are still open and 398 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7013    Yes   BUG: sleeping function called from invalid context in hook_sb_delete
                   https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
<2>  6890    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6341    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  4584    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<5>  4464    Yes   BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
                   https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
<6>  4309    Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<7>  3776    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<8>  3646    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<9>  2852    Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<10> 2314    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

