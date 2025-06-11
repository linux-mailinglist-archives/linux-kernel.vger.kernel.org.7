Return-Path: <linux-kernel+bounces-681020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336EEAD4D64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 09:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B47189A1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 07:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF582356A9;
	Wed, 11 Jun 2025 07:46:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8A234973
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627993; cv=none; b=Ihv+Vof1VYSYwfqc9aYOWJDUa+iWmbIeZXRYNeY4EZGZbvJqiC+MFhRkqxbKyO2Lpiaqc78qGUf55Envwa32pkg/TRo73Y28czkFBOLf8RTY4zAS+adNa7XTV1dqakWp4nbFhB8qDE1PUYiA9yHRhhT5YugQjt6ucFNUKBWECl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627993; c=relaxed/simple;
	bh=QdvcsZQCPQUQneY1mRYicjvuWfiYG/75rVkdYz/3/e8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AWUMv4QoAmLcoAr2ItC1B8ZpESiUNjYjERjrXtXeFo+B1nxbP8L8ZMg2kwA7WBHDn8Jpd2cL2nu3OuZ/uhYl+O8kPWaNSZCCv8HChfwCy6NSuoj3B804qTI2d7C7dd8w1O8FtHwcqUt5p3hFcV2d9SeCpPpQUeaSK+mPF/Hqrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf306fc68so1021435939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 00:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749627991; x=1750232791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJQYX4ht+z6t6dbB+Oe7UWnCz1EkkvIUIfzk0yOqfzA=;
        b=fGxqJ66x1f9/zdO1Qv8/qg2GYpy7g0g1TT6toKeD/fznff09FtCrHvXN3mktu/LIDv
         vjKvqD90/RxFNZiKrMkR/mjJS9wFymaysFyWECAfGap/SW9EEM6+aKTwkWRTTE6Fgfvj
         j6iXJVDcaN50TshU/1v2fg1NnvSh0TlSQiHbbl8540b3nUxQ2SlaHs2KvPOI7hf+yuAf
         sVwbSqLtKRbjqHzUtvNDafDiT5uIr3TtvCoM9Uy1aznrO2OAcK5l5OY4c8s0XYMDINQ0
         7alf+V4h2cNOOT7PA+Zpk/BLk26oTOK/PsjX1WFfkOUJmVxM5G0SyRnmhF0Ex+SrGk64
         gR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4mdC7WbKTezy+HSZabltExsrcVvb9AWsi4V0nTDoUSJdHudDI3R4SYm9SFMm+XSLcAm03sgqtM71zspQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAy2epmDOrPh/uefcw15cMhaojagVDh0OGpAp+02Fgx0agMul0
	DBdzvQzSpYuklY5WtQ91Rs17n7tdwZelG8Y4vGM1ilnLL6Aq6iEgel8BTKqhQjX/eu8dhFdUuVG
	Qkb1U0GhY76h7fpaCzARWfJ8IJANWc+TszcJNtgJ2i9HdW4bicPoXniHXgx0=
X-Google-Smtp-Source: AGHT+IHHdveevBdbL721x+5J/WieNE1O77deO3ouXaSVyKHnG99k7DWE6nuShOh44QmeYvETkRCpdE9iT/O0Yp+vcebOUhsbw4pN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:3dd:9a7e:13f4 with SMTP id
 e9e14a558f8ab-3ddf42628e5mr25309115ab.6.1749627991085; Wed, 11 Jun 2025
 00:46:31 -0700 (PDT)
Date: Wed, 11 Jun 2025 00:46:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68493457.050a0220.33aa0e.0367.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Jun 2025)
From: syzbot <syzbot+list6c47f600adb8edca7977@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1720    Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 146     Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
<3> 20      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
<4> 11      No    KASAN: vmalloc-out-of-bounds Write in fillrect
                  https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

