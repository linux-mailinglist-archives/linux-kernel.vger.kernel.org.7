Return-Path: <linux-kernel+bounces-869407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F354C07CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E17189D505
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715A34B41E;
	Fri, 24 Oct 2025 18:48:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7331354C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331710; cv=none; b=mEnMZ+faQIAVI+Y+UtfT/YEE4Ts60Jn7rVTSNsglmacu+uZl7uRopLJAT8b8tpjrGeC/fJvIlBo22Qpx8nxlfby0Ar4Z2k4ke1XRpht+nUFP6pfyXw+OzE3cBOKWRplEgKY9QPf4cHPgLihuwqJwCpZxkXz8ujWhVTtqUIFUZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331710; c=relaxed/simple;
	bh=fDijtuwiEhlwkDTtGcvFXRtp4U6kxPCtS3/c4WMiHgA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GbrUCDAYg9dRy/ZFLioEPI1Bc3Jw6TWnUwXNu8omRxUBgRU3psMaVyPRfagwzmIsJ9Hth5yLS7GBjTcI4nd7WZBWRHG7hquPJFUr2o7NDcqwfASv33aAzv/sKyObAQu3bBKByGonhoYYOia5pogNKsFuMyBZ1MvzK0tHklUvN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db5635d6so31411575ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331708; x=1761936508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TlINdt0svkSrJe3OM+W/FrHLw0RPfB7YQtqUWUDNfc=;
        b=R+v3zA+Ic0S3D6S/vxYRUMElMIybsSEAxKmHkdZlG1tROlzczgq17UhdeqD32ldfrh
         WQGcM1E4KJ0minJUVNtlTHd9Rtb4HJNy85c3qJ+5PRMfuOmq5sVBZGpZg2j/2bMA/SZz
         O2fU6zAQoBUQ8bGVB0j3RQxeMsRiz0ZTeJrtQmY0yewF/YUDrx719XG3Y5odo9OxOkwc
         rzUt+8eJYTEmRmCPVAW8wqZlRczVKo9O+C190Ee9IBik6ctHh/oBDz3CGYixb8GIYqnD
         eShRR02nmr07Yw8lUayysXhMB5yRvQankpvxt73/Q8QPqTGqs0Dh+jnQ1bE6CTnXhzs+
         YxPg==
X-Forwarded-Encrypted: i=1; AJvYcCXBCySph/2NZz+HjLP6X3ti0Ar5QPNkLqt7d/RX5yIkgYYr68VgEST2i2pj2XqqDSt8tVR4Yx1GCaIlejw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5l/lMaG0srXQJ0KxMDIcH16Yjos98w9HYN88N7Lp5g+LXv7Qn
	hMAcd9fIuVoh0uYSkqtKju9/Tb1yAgkq1YG8mQs4w154/Suy+TIY4r5YEu/ttX0YhgAtm7ZaZO9
	sCZgIq8J2RwpGSHHh0TOzRYZIBCU9OwO9Wad/k8vkZomusi3+I+uD/TvAZds=
X-Google-Smtp-Source: AGHT+IEHw9DBAt30oJGNzYmdu/6XjHvDF53KydCD/kmP16b6cS6Vveh9KSeZRC8fkn/KpnF4de3BdXlnpk1GrRHhcHKoeoGTuveJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:431:d864:366a with SMTP id
 e9e14a558f8ab-431d8643888mr128262485ab.2.1761331708479; Fri, 24 Oct 2025
 11:48:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbc9fc.050a0220.346f24.0154.GAE@google.com>
Subject: [syzbot] Monthly hams report (Oct 2025)
From: syzbot <syzbot+list9f996a166fa4824c1704@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7989    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 2208    Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3> 709     No    WARNING: ODEBUG bug in handle_softirqs
                  https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<4> 560     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<5> 230     No    WARNING: ODEBUG bug in __run_timers (3)
                  https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<6> 13      Yes   WARNING: refcount bug in ax25_setsockopt
                  https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<7> 2       No    KASAN: slab-use-after-free Write in rose_t0timer_expiry
                  https://syzkaller.appspot.com/bug?extid=350060a9356421ae83dc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

