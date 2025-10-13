Return-Path: <linux-kernel+bounces-850148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA0BD2114
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406623BD74B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0112F5A1B;
	Mon, 13 Oct 2025 08:32:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D712F5A27
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344354; cv=none; b=ldy8JW4SqMwbCQfpxBcwymrvHJe3gN/Jngitn5RdzLm+2UX0CxFXG7VqcDWOE6v370diJEwbxSQkELCejWGDLFpfucKo7q+Am9HxB8U9Zy24m/4t7+8sG6uvaJ2ijRvyhA/2/rG2J4j4h8DzomtINYUBGADKxalkOQXNRe/3YX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344354; c=relaxed/simple;
	bh=+ONzhQiIFmJaziExfduaS0rzIr8zFTndFGeaq7jYSzk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qqDmCUZ+uyRwqz5T3apm+WT8XOtCL7LTEnQn9h/8JTSJLGzhDvFhh+vNPKjAQrovflGnEX2rFWjpO4AvDxSe2AtQyZhc4UOa79UkpPTJwYOZhA62a0FkuzPnxWbUlH2hnCF11ClgHi8CC8uvwy07qFqTX8MQfL0ZXgYSpaFhXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e4a324b9bso28367539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344352; x=1760949152;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXiS97ixT4Np5C/+rHttod7a2+RHkrH+mWX2BsOO7HA=;
        b=mngXHY2Sk+LniVu3xCYvxlZgxRLoQdKPcaVQEczsfmjEC+FTrsIvAuUhzllfV9wie1
         P6D9PT5RHw3Is6mPQGAGmJmV7I+IUSA+6f9pW53YHdCsA9mwCi10TTsARu7NI4jkJd5x
         siWWshVWUY8h9oBNVCF4R8Lic5thTFzAXW7jFyHNwqP8wvAPZF+ob6CD+7SCe5ovvywx
         J/Z7A2HV6TOVo+RHjF4pHeOKdnHpEpu40SA9af+aMHfLFT8sDkRRxqxb+l/G2NHzPNaU
         510SJIhy9eL8skKygJktiQNNglh9ZyNgOYKWbyiglZhbmuojZcS8zk7nyXtTyapxVv2F
         orZg==
X-Forwarded-Encrypted: i=1; AJvYcCXvaKdX0LuZyCGd7Ni0/vdrFNycPRTnNFaNVZMB7tJ3CXtVxa6RAbqVHTGUXxbN41+UGMowJWDEVOew8t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkYP9fvfb3QpE8eVHLdY0CnBj34QhUaiptNhL5orb7d0M0f0M
	pDMSpXrabG/zX8KibvL3GrxYOIRqhMMqeyNF6xjFhE6LsUVlU1I2rSBDa5709TuWdVlbF/157yH
	oTG/p6EIqlBijGI4v4nev5KOz9hNRE1wIOem9o/W8SlJW5MJWg2fq2DwNG48=
X-Google-Smtp-Source: AGHT+IGhBVJ6VubaQitg7eBtMXuxI/ua/n9vYODxJToULXQW5KsNiCz0bITuRBT+CG5xaTN/Q+5eBocTjiPA4g+UdFmeN0KG7clS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-42f8737f064mr225990605ab.13.1760344351997; Mon, 13 Oct 2025
 01:32:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 01:32:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecb91f.050a0220.ac43.0017.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Oct 2025)
From: syzbot <syzbot+list4b745788333aaa1a5dfc@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 49      No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c
<2> 44      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<3> 14      Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

