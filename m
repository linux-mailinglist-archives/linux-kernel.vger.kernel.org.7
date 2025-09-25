Return-Path: <linux-kernel+bounces-832833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291BFBA0860
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B3D1BC7BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB440306485;
	Thu, 25 Sep 2025 16:00:48 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065923043CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816048; cv=none; b=L3mF25fq6sKXNiJfPDU8J73eqV1o7QnHKrgPjEsSxj/JJ3oyNi7dqEAZQp+PrNJglaPd5sK8J56URKe6b7g57UTd1VocTrAJw32OPFTlitbluWMBOBIM8orhhJHQ4PDfzaAGn974x1psqlvwVB/kGkP4U1iJC1v+kYfWPMqcr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816048; c=relaxed/simple;
	bh=clJBQDWh/zNrXluwuNaP+UzVrqiZJAwHcx5fPaY/DKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=keoBa9sL9fJL9m/Lc41KdqaBRwOdiJcd7p07OM55ILhqWIABCi+8jea+8gwtFE7Cc+B/QsM1+RjmBTDwKWDSK+pvQsJbns4k4cwbZH5Q40g9TXlcDWueYLdq/x0IFPp309VAPzw8qQAfVQ3V68TaxGxPZ3KGih8K+PdAhQu6V2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42570afa5d2so30803905ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816046; x=1759420846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+l9y4ClNSZC4OMEj8WYATKzCCtW+tw+e0avGGqDKz8w=;
        b=qOwIYIjJiw2+mTEbkO5gbPnokGmxR5bHy+Ce1lQvXJAAiFx/HubApgGA0pkw03ydyp
         5S9xzIMwUrVaNTQWc6RcR7FQapUlKRrquDuhJTnIDseL1NFrVtdCRY42t1Wb4Hf6a7K5
         KDqE7xoYsDfySQJQxcHBedf7rY5jr8SsXW55TOpfA2ElgWL2UKiWOlrep31vNS9uBaRd
         jx4kz5l2Y7rdSVfEuACPPeN97r5IjrBWbsZKebCRgpFZ98+F1Ruhw1nx1jalctfrbUCG
         fPRczv/1HQswjxD4XNOT9MRCy/6YUGDL45gUA91yJ3LGcNMRd8JnBnz8vm7DudBjz0Ni
         iXgA==
X-Forwarded-Encrypted: i=1; AJvYcCUqXbdlehBxak5yWduMxUhSkV+c4y9T2u7C1k51KX5EOurTnYKcjuvlJFGC/mo1yy3ZYOqTMWI7xixFeMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4M29+IgNgmEPVu/WTErxycZzcplsdcXbjriyMKO7SBzR5FsRs
	y1dDq6OEWqJrWlJ03SZl26jX5lriAGfhlDbRr8mBuK8b3IDjdxdoD2G9K95nNUGyHDU+9QOVAAz
	7J+L9bqOaG6e+/cdcGEVPHrHspWSIeonRICyE65ylm0dTkhfU8mAOcD5AYY8=
X-Google-Smtp-Source: AGHT+IFsfYrF1uYyzpWcJOKtuhZJDTPHI7OxwP4UZRMUaLjByqvD0ccRSNBQRmp5+WOt52QKQVjcCKwYaE0kqZ+/1SXCs134TiPg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c06:b0:425:7a1a:b052 with SMTP id
 e9e14a558f8ab-42595661557mr62587695ab.30.1758816027113; Thu, 25 Sep 2025
 09:00:27 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5671b.050a0220.25d7ab.0041.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Sep 2025)
From: syzbot <syzbot+listba416414d9aeef5cb04b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 2 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17936   Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<2>  7077    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<3>  5560    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<4>  4922    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<5>  3230    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<6>  2881    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<7>  2807    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<8>  492     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
<9>  456     Yes   KMSAN: uninit-value in bcmp (3)
                   https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
<10> 359     Yes   possible deadlock in mi_read (2)
                   https://syzkaller.appspot.com/bug?extid=17f812893d5906837f33

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

