Return-Path: <linux-kernel+bounces-784300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C1B339AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75503B863E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6629D26B;
	Mon, 25 Aug 2025 08:40:46 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6123AB95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111246; cv=none; b=mCbOGavnpjFoeTL+9UcOns1Alak9+Awh30Qi/nXLwhF6BShNiKha2IUFXu5lDbRbhZMRJuMUgF7vFNXHANbEPBuueGO14MVkNspkBCdhNlJGUvkMsjKAW8cq5SPxwHVprkLiu26HDMw4aasQpOrpupToot7a1uknxtpK/o+fSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111246; c=relaxed/simple;
	bh=X+2Fbj6S8nuzTyz+2ZgkfPG0CBKFKbl5r8jvD7hPPYw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ecFw8DVvg1H8LMe5jzlLtuIhszmhlLgmyWZ0fRShrkH8T2gw5N0RrcGKRr/hmVEukXmgacBN05xbgAF6gCelCk0F7EjEflb/ZEuuSPmibGD5XY6GEqpOD3I7P/sAmqmjCNqWfAfrUScVEyXkF1O/SqJMjUXheCSrrOCZZlMTuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ec23dea2e3so10329355ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111244; x=1756716044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8Hdg78udQncgEx19zGqlBrSwHXLvMSvhZx9CS0nBD8=;
        b=hB/c/Jol1aga0/wa08TeIHIrkiqmPYprGqXXsIlS6eaZ95jiMqw0ieU+eb/gnQNBjY
         61LWDkF9XTuev82YFYRuOHPvrhul7p8g/ySBfHZnfmNM+dAGs9nWrdfOek74OgXDDc+u
         rBrgZkITj/cSIXpErxeMogoqLwb/qGd3ZfCvLAns6JS7fPJWLLhP0gr+PXsd5E8ubBW0
         poa0cX4ttd+AT9NhsHkUwCegh0OuptZazurTxKa4pmiKyhVJJOv7mMa1qrYasfFZPlbQ
         Kl349sHupkBq4Tn6Fzyt+OVhH8TmrEWAFdSicYyBs3Jc8sczkwnGiEuXwDjyhRnZ6TAJ
         2iqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8QKzLKycaAV5BxYEv3CI1v9UKNgXL0THZZDJ4OtFYbpCTKWV2FlWnC6AP3ViKBEvaXZqPVV+gUWDsQ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUG83zQNKI7hT+qLeLdxU6oT/w15UzTPf3KK61jD+Cl5wqqaI
	E+OHSQGq1U5OkmBkk9LPfyS9DDE0xuhAMQwWMNpfsOxF3GuZfASyRZGMMoINMv7lO5OvFEFNr50
	qW8w9tVWpnX7BeZF6KGXTKiS/WV5O/F5sLxLNMVCeS69AQ2kyPkgGd3eXkDI=
X-Google-Smtp-Source: AGHT+IEQfoxqhW0ZEVExh/MHqvkydluHD+eOCLUCHY06tn4EmF6hVh3z9SaoiIVaJjMovJ0zERaluIe6O4SZp8xXKp0EnsfuGvQT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:3e5:5269:89be with SMTP id
 e9e14a558f8ab-3e921a5d80dmr165890935ab.15.1756111243758; Mon, 25 Aug 2025
 01:40:43 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:40:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac218b.a00a0220.33401d.0401.GAE@google.com>
Subject: [syzbot] Monthly hams report (Aug 2025)
From: syzbot <syzbot+listc5aabc82846dc8bee53a@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5358    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 1111    Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3> 327     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 155     No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
<5> 28      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<6> 7       Yes   WARNING: refcount bug in ax25_setsockopt
                  https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

