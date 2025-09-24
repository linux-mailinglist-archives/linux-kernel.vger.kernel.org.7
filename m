Return-Path: <linux-kernel+bounces-830513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80406B99DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26CB4C571E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33703054F6;
	Wed, 24 Sep 2025 12:39:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145E2FD7C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717578; cv=none; b=WBp8lSkRa9+tUkUDq7Kip+eAd5Kj+ha97sc2/q8TsTreLRb7ezHXpcwCroqPGEFjG8zgO0hP45VhrYq+FcxphjV77AAPD0ialOZzD6e6xOUSenr7E0FWFwK4fe9YGDpZmZS+PqTn0mipZ6oeRUKgFJnxl50ot+sa7O4Kdmm4/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717578; c=relaxed/simple;
	bh=oX68zCB8/CvAtEvevupWhPnhsGBk87uZYxbs7eiOEiE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SeJiNlHKpMj7bqg/XfO/n/ZKyVMinIdAVuEu0aUPx9uz9uVaNxfplTiFcJ6H+4GjGYb7YJFedBVGhGKTRZL2XKtpjInZz3vegOhVBq0pP/ejmNDsEK5nt/83QAPKD2pD/u86LD4dYd+klENKfY7ighy7Jb//unu7Ki1GdHDFEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42591c9fca7so4348715ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717576; x=1759322376;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEDO0il/OOKvYx0dUl7SOgrMg3pwl4vLJ5Yd70P8tMk=;
        b=UZiAakGxBXFPBbZzf4M+1N+fODujZ0P+JJbeY2/LGgyc92U9KLPEX4+NdlqPIO4/JF
         P3TMezAAFKmWLRw7Hvw5DDgIwK/OJMH1/W3h+3pyBMU/H/HBJMMYOg9GyJ2e1zu7BAOl
         4FZtrevXhFBmQSt9R1NKAngjz45RC7rBAsMvY7Vq3JVAfmAhV7bPsRdN2fuLwUSFzILI
         pButA5Dk6Twt7SyF/DD1Lz8v9iOU1n1hvFfNc9PKjI57f9m2AHo+9v+fwusWQYlTorXZ
         nBFw0313Sie5Ewqfeljq76xtdbj475m6HmNm4Sq4MChQqPEYaFvAzmfqdAA493R+XlJJ
         rPcw==
X-Gm-Message-State: AOJu0YxXCdPqkCL4v9OUFJaJm21abLedgZPU08LvUTXT20j2ocu4ppWk
	RHZw4LYG/EhZICPX8hhEVPmj3ADy67nStX2iln0rmmYehL0bskbfM6Qaa1ddFm9dv4g3j+gaV+T
	m3k+nqcTry0d+kj/2CbZalha8QU9jaWzv1X9LcHzKtR0iN07SsNPT0WzWX7w=
X-Google-Smtp-Source: AGHT+IFEHfiSaAT95eJPGTu6BBYvfSYdfpN2z9fXd0T3JzhWMB8SHBaDtpP6G1nyEAJ3DoDioZ3xQ9ALU1kCfkq+rWCnZdoEux3I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:425:720f:deec with SMTP id
 e9e14a558f8ab-42581eae239mr81766185ab.31.1758717575755; Wed, 24 Sep 2025
 05:39:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e687.a70a0220.4f78.0027.GAE@google.com>
Subject: [syzbot] Monthly usb report (Sep 2025)
From: syzbot <syzbot+listaf472b258244e52aa817@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 5 new issues were detected and 1 were fixed.
In total, 86 issues are still open and 393 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17783   Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<2>  5661    Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<3>  3005    Yes   WARNING in usb_free_urb
                   https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<4>  2461    Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<5>  1565    Yes   possible deadlock in input_inject_event
                   https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
<6>  1488    Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<7>  1402    Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<8>  941     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<9>  807     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
<10> 750     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

