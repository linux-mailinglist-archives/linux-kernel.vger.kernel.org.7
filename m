Return-Path: <linux-kernel+bounces-615728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A9A981A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5136B189A6DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DAB270EB2;
	Wed, 23 Apr 2025 07:50:42 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955F26FA5D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394641; cv=none; b=lln9QIULZGwVP3ABM/+7RHsCW8xsGuPtszBdgtk1tLFDcgkFfaBTrMk+0AImOHpmadZNBLBukn6RWeWxqSettTuEgx9jYAePEuAcjcKyNppTjwWGlJOim88n2Tihj2WZTywNMApEmjIIofDg5OumUbTkq+IeXD+QVu8w6xZdWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394641; c=relaxed/simple;
	bh=al+frGc8+s1dm76ODqj2Z8/1RnDsvo23VzeIBR3RsDQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B7Bghypo/2mgOFreAIFYftjBQoEADAchvL2me0tdN8j37I6EbWfxtc4+PGxoOdkL/vNKjxQZq/H5g6bLT23miE0mkZwvgU+Qot4GnDKVoCUTlnQGN6O5FQ5WiQGly8LIO6C1JYQouS43Vk33XwLn4t7IPfQfUPEDiwpMQcOFo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d90ba11afcso41817175ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394639; x=1745999439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuThavoLQFnNNllqB36w9iF3pcSUNQsBnPw1UbIkX/0=;
        b=el8tt1kPNUdyZAarRdYf9Crg/9z0pIOgQzvBLHkVpUi1b++OngrS6EmPCjKLOuvTbT
         Qg0bpKbuS8U2m4NORrj5Y9qsl4kvKOpccBRzZVeVMxjleLX+0jKf57tZTog+ZGXLW9gM
         W80RBnIFtUBAWsyaPplyGnXlK3fioF5VkdTY3Ax3kfcXp2f9uptws3DbSg/E0mqcCvEE
         ywHmugpY0Pm3jdBDAqrU02JE+1BVDxf6MT+KcfXIprYtagwlBZl1tS9KjV59cf9L42z5
         YVp8dxdMY+HeTucfHhWyS/d8oy9iWMspuGa/kW5dLGXJ921VPtaccw/ELwX1Kf4LfWtF
         pjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCURK51jh2R2EZ1hHhyC8epL/StUDM9ds8EoG98J2P797eT17WPGxMg7YQXpm95CLQT2k7byShBCYn4thrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEMwzpJVcJVYX5cMRx+wSf31I1Aq2eRoq1pSdqdOackFOdBXt
	CiSmo3U2O2O/u32Xz0ct4v7lmcRQhNOmhj8GhtCTh4akNOiijP3UHi9697X4FsMNJdavDKI3Xmx
	Eh/PMZWP34+ptBnb98JtghQyf6OSRfIUR73lpA2iqqMUKk+D15xCgh7E=
X-Google-Smtp-Source: AGHT+IEONT04EfO3W2Xdd6K5CAX2eA5M72ZERzdf9qHibbRkS+VeKdqg5K5btTHGxTAtSvaoucaL48YKipCxDBTpxYEEPDetZRf2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:3d8:18d4:7bce with SMTP id
 e9e14a558f8ab-3d88ed65543mr189879555ab.2.1745394639409; Wed, 23 Apr 2025
 00:50:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:50:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089bcf.050a0220.36a438.000c.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Apr 2025)
From: syzbot <syzbot+list4354a0e836e319a1f6c0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  74123   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  15640   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12534   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  6506    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  3643    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  3561    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3427    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<8>  3321    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2867    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2701    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

