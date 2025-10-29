Return-Path: <linux-kernel+bounces-875647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68CC197B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36C143549E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC02328605;
	Wed, 29 Oct 2025 09:50:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9F2F1FC7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731426; cv=none; b=gpdhWDKxoHe3SagyHqdfspQbVLcOqhYZvsn19csu9zvj52Pzp3bCe+fozL8+ulhxnjp+L66LD4jr982jW70AekODWeVuqhrD9oIy2YCxVuQP/JicM6nDfNBdXqEg6+B09fHANYT/WiSNjPrYRQLwjj1RmbEL5NSedHRCMihfgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731426; c=relaxed/simple;
	bh=BMvFhu2JQpaF4T3E9tc1blugVNdOnldVDb7ENcjLjqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gm29f6kfSnl85J8febPjZ281Nm5yCIv3sV9OmGbXY6VhnoEd4rE9wdNuQh2NVge1j3GkDBCDnPA+QB83ZHP0ecd2MlbfraK7Aa6gYgNIVvUgOATm7YUh8In8FqVhH/nM3VV5LftexY9Dgz3fZoZ/aycILly+C2riqEnAfgvc30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso2270137339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731424; x=1762336224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRFPHqBvWqE41m7o5rfMlavGfndw1tlWRpHHn/CNEBo=;
        b=Hf2mH6XucNetnfVndT3t4fiIld6Ut8SodYbB2cD2mqczkLx1TV6IeWO6rlgOOh2Wa/
         dQJdMJf/vzu+u05a11T4HE/t39vXe80fd3baY1etg3LvsGLDxblgY6tM5f9Ulhc1FJuH
         1/r95niYWMWoXo6JtrsHoy1fNlhzWPDbgNfNWcQ4NjcqZ2Dy6soODo0VEAkq86WAdRr7
         k3ko4p46vfYwziQkKww3vHRRTa8Nq0UoMcl/qB7HQBw37UcffBS9HaJkIfTkK5reD9fY
         DKzm0pu8W3MyIK7HEY+pIWFGp1dQmHTi1QXLUYAlFCMW7wrpjse8MF0rVXuJ6BYt1XEK
         wZUg==
X-Forwarded-Encrypted: i=1; AJvYcCW8l/ujnkf3wLZPL6ckQLTyNqqMHds0eR46TZN8HLJ/1FeCpVxXx0mGTOjdpUjPQgZyi47RGjCy/VAbwSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWfxQLED8+n2UMvy3s29lOcbt5XDVc4IXo5gazkeKBLdQVNoE
	SO4zqaZo55CVuQUYplcMZc8TYN2S4uz/nJMcbzQv7yXGlz1OLGWyA1SfqQEJImn4Gj1QV1NVFoy
	MIs/QYWp0RTDlfEvy8jrj1EKtDYynl9dhAQdUJ+Oi2EXbC+yE/ybHMfxTc5Q=
X-Google-Smtp-Source: AGHT+IHzKNuLQKknWwbqJmjw7SumWQ7v695K1Sy9XomlF/7maRIeOSfPAicmFWK1kqWHpy8bD71ucg6XtZulYHJM1NQS07uPNA8i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:431:d721:266d with SMTP id
 e9e14a558f8ab-432f9090ee3mr27884615ab.31.1761731424434; Wed, 29 Oct 2025
 02:50:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e360.050a0220.32483.0208.GAE@google.com>
Subject: [syzbot] Monthly xfs report (Oct 2025)
From: syzbot <syzbot+list2a4b52d8d4fbe066ed08@syzkaller.appspotmail.com>
To: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2779    Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<2> 254     Yes   KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<3> 108     Yes   INFO: task hung in xfs_buf_item_unpin (2)
                  https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
<4> 53      Yes   INFO: task hung in vfs_setxattr (7)
                  https://syzkaller.appspot.com/bug?extid=3d0a18cd22695979a7c6
<5> 17      Yes   KASAN: slab-use-after-free Read in xfs_buf_rele (4)
                  https://syzkaller.appspot.com/bug?extid=0391d34e801643e2809b
<6> 13      Yes   KASAN: slab-out-of-bounds Read in xlog_cksum
                  https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
<7> 8       Yes   INFO: task hung in xfs_buf_get_map
                  https://syzkaller.appspot.com/bug?extid=d74d844bdcee0902b28a
<8> 3       Yes   INFO: task hung in xlog_force_lsn (2)
                  https://syzkaller.appspot.com/bug?extid=c27dee924f3271489c82
<9> 1       Yes   INFO: task hung in xfs_file_fsync
                  https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

