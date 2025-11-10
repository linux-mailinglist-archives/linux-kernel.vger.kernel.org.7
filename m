Return-Path: <linux-kernel+bounces-892663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D645C45921
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430E83B5086
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3D2FFFAC;
	Mon, 10 Nov 2025 09:15:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E82FF657
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766131; cv=none; b=Wkm/+TpOcQJHy059VHA41grqIb58qGphKsgtqgL+BopjgXoXhAUrTBuesZLpWbNgo3LZd2KPX0gRvvOqcIsPIbjSuXMN+h6OBkpcmXW4os7OxyYOxr4NyPVqd1ZyJkwoy1sxaOap/6qHzQwAYadxl2sYHR9Ifv7NRWPEwTbiloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766131; c=relaxed/simple;
	bh=RHdlzNwsm1rGh6l1iv4amcMnpmuQc13+wyGWkig97Nk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TzPH1qUDABJAJWCQJEZodxpcHNxw/2ziCoktnomP3SIbw5T2ozTSuoHLBF2eAvb0BTrUHVxBU8EdUKkVY7y6aNO/okR/H1eu6t8w/GkL8KA7t1MghwmQUVEke2QfVIolSz3cIxgaX8zOINfx2OD5DZ71rBcfLN2eaekpNGqzOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9489bf08bcfso99365939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766128; x=1763370928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jw2bDWpqQJslaUc/Vfp6E0lnnDbC5SF5uOE2l/qaVjo=;
        b=v8cl7c4GhaivFKBM8Ho71i8JwVUAE/Ny1CQsG4D3cmm1NZ9OUCPxG1OIlNnhaQLBID
         lIs0G2qmpReeDZW0fVTpEz15M3SM26B6bfJqToyBpPIl0c2ySuATDPS3I06vBFUTToRo
         RNojbcKn042ZQK5WWapubadgXdPeC3MfZanNxv3C7QLNvDIifRSv8nlCwHazddpnGxfH
         SLTXVT0Gxeh0/56V7dep1SEKErXmB1kTY+iDqhViIyZgyNwKvDkoM8w73Qx4vjQfHQ81
         UJ63joacqJyWb0QVGizEPefXv5gkqst3q0rVhacThdUvmolGBj0jFR+iG6hZLNsxI747
         f+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUTTFIW+Z0PapCcLBY0O6fJLW8p3sXOyqOXzNvchIYPTWyJqhNI9A+l4dWzA1wFK/mP0M0iVev9CtRrk9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhmmqE9PJ0wTpOCPx+IZhWtuzTyZbtcf+hw1f0PUyf+NwBiG1
	gA8MsjPO76N0E/HydbolC7O9MLe31lacH5Kk+JXNCe2sKco/ofPrT0JQU+1aadCuWMBv7827JZn
	Ku2tMY1TJHX0J5+etXvKNVGHZZfyMoSu1J1Qr8R2FXg7uROJMyHe6McWVF2I=
X-Google-Smtp-Source: AGHT+IFGoLLGsLuMug/dj+lI2VD0pkcyljAM2VnR4P59cgDRW0UyxoCuEkr3CuH2LCfsm+cTZJFZj9tUN4V9dnREGbTBNGoA/v6O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2613:b0:433:2cdf:6457 with SMTP id
 e9e14a558f8ab-43367ddd999mr111923965ab.12.1762766128501; Mon, 10 Nov 2025
 01:15:28 -0800 (PST)
Date: Mon, 10 Nov 2025 01:15:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911ad30.a70a0220.22f260.00db.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Nov 2025)
From: syzbot <syzbot+listda402db1e75d5f5b58c4@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7       Yes   WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
<2> 3       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

