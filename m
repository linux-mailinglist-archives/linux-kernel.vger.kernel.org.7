Return-Path: <linux-kernel+bounces-743989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C684B10691
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4306B00640
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057D2417E6;
	Thu, 24 Jul 2025 09:32:44 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249852376F2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349563; cv=none; b=EpZELqfpxvs5l2wC/zEjTn903Auhxhvp4JGM9Y/24z1PQm80QX0a0soAAYfCBgqHjSn11st2u/9gCiyaKDqwYN5aUgQAZcXnMd8d2DyK035d0BA1SSN6SpE+MRWFM1YgtiOtsZfqt4KczpEQG+U/EoYFfCLvKoRIN8s/SSOm9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349563; c=relaxed/simple;
	bh=pChQkNlGn9BPMwJ9ysWPIwH9nodNQ6RxqfEtgfuxfBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sykdbzR4mu7Q8FWVoIrG9zKqtgAFO1kGdmrEjI3zdzXXMmpyZ+xazqlxVacpOX2e5wr8Cwiad4hPnJC2PcHs7ssvaBxctAp/RkCxwJ8YNAyUUxAqDXARzSMIteoBbFTwSo+Vrok59zdzm73PXWJcSu94yPqbcC4BIIqsdQM/PjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso97115639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349561; x=1753954361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fM7tZEMMfnB9aiXE9yOhmAoa/YmcJckca1xdXwphRcE=;
        b=ATK9B0NyDQb7x79+zPE0ff8pJqOnBCun27Xc8GdE2VxDVa/QtU+CnwpE9VyjwcgGVi
         WxthCiEdnb07pBCnClVrnHSDHM8RvckGWm9zzjMLfvK/9SU9w7n0QUrDh/ebtXivHiZ6
         giCgPDYHyyBjOEVJ53B89fcGuyb34+4E4gktil6W2UHqsynEKBcMPXi9/8XtFeud9PyF
         LHZOWywKOLq58E5RpDT8+xADQY0TApMhuQtBxAHyfRlczSJNudjdUmSkW75sil6FLttU
         Z7+LdVoOE6g42P6Aueu4jL+gAgU+5QVukN3YZ0yIyO0qRwJOAyaJSj8gEst/5qw0iObd
         o4dA==
X-Forwarded-Encrypted: i=1; AJvYcCVgbIvVRr0lFnC+4kxI+UrshKyPMSjMl1iNV7GzrQi86ogtxRUVRV5F/Vmp0HwoJa/qyGrb/M4WjG3Cq8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMahosoJqvip5BLVCkVAxUVZN3rs7ZP+doRj4YFaBgqNbv/o9
	Jy47+J/aMZZKSpeiJc6RhA+MiiBDj2hmW3bqAi+cg5k07BFERd9RuWj7farHMlmAslRcfjfYBoc
	yaEo2s2Aam8C8nlOOaKYUrKbh1PYGYqrwFzsR6l9PTrG/EnoOUn0/jFfedfo=
X-Google-Smtp-Source: AGHT+IHQMo0Aiy/J3O3dobbLBRiY1q1B/lxv2RN1PRtoMpVNOYd2lGggs250MNk7Eq/yS79SyrVBHcVPdxIdRujDKNoC9v6bbE1W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3891:b0:876:1c5e:8c50 with SMTP id
 ca18e2360f4ac-87c64f7bb29mr1092486439f.7.1753349561149; Thu, 24 Jul 2025
 02:32:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:32:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdb9.a00a0220.2f88df.001b.GAE@google.com>
Subject: [syzbot] Monthly comedi report (Jul 2025)
From: syzbot <syzbot+listd7b384ba0689e09274cf@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello comedi maintainers/developers,

This is a 31-day syzbot report for the comedi subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/comedi

During the period, 14 new issues were detected and 4 were fixed.
In total, 14 issues are still open and 4 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 377     Yes   general protection fault in pcl818_ai_cancel
                  https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
<2> 190     Yes   BUG: unable to handle kernel paging request in subdev_8255_io
                  https://syzkaller.appspot.com/bug?extid=f7ad508e3c76c097483f
<3> 103     Yes   BUG: unable to handle kernel paging request in parport_attach
                  https://syzkaller.appspot.com/bug?extid=c47f45cfb7fc1640ced7
<4> 77      Yes   UBSAN: shift-out-of-bounds in pcl726_attach
                  https://syzkaller.appspot.com/bug?extid=5cd373521edd68bebcb3
<5> 56      Yes   UBSAN: shift-out-of-bounds in aio_iiro_16_attach
                  https://syzkaller.appspot.com/bug?extid=f1bb7e4ea47ea12b535c
<6> 15      No    divide error in comedi_inc_scan_progress
                  https://syzkaller.appspot.com/bug?extid=af53dea94b16396bc646
<7> 12      Yes   INFO: trying to register non-static key in waveform_detach
                  https://syzkaller.appspot.com/bug?extid=eec47f88bae8951c6afd
<8> 7       No    divide error in comedi_buf_write_free
                  https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
<9> 3       No    WARNING in comedi_compat_ioctl
                  https://syzkaller.appspot.com/bug?extid=6048f8e5da91c7055339

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

