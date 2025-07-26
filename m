Return-Path: <linux-kernel+bounces-746874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772BB12C56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5DE1C20EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D467E28935F;
	Sat, 26 Jul 2025 20:43:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7921C700D
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562614; cv=none; b=awTIl1Jv1/83/vd3Sid7jnZb/2fWMqXlsbzWKB5LwJiTVcVitNO580xtdudIX9tWyFwEx8PtPfEhk2F4//XkP73muje/jJGLWhQmLBIPLo4GzegMFjX9ag+UWWBX6MQiDOt9XSZh6slT8nWxKAMPsr7vff65Y5aFMhWZSBwUO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562614; c=relaxed/simple;
	bh=LZkIAmmjLxUThoW04ojalphEQmGoVlpH8nY6KbqpnpM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MMiAFzsEQWx2M76yeDTpnibRPTwt+WhLZ1360Ol5ZBlH+ww9NQB9INYNQiEqXwwvu6beibfPYUWDAMcARtjGgGkrpyjz+v3FIdSCN0A5JQzBEP4NR4xMi2e/RbK6zdKttJs092VXVtwyNrff1JMaPZwL3v1+veYOFUWK6xfESZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df33827a8cso66485025ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562612; x=1754167412;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxVhg158BqRzuZVreFzlZ1lgzEYUTZ4+Sn4ePts3vms=;
        b=vFL13srYhWnv/mLEee9I30dHnexCD7K08svcCiAUVVvogreTnJu4X4MQCzo8/Xl7AT
         cH0pcusq0rlSjESaJ8fhsyDxNozzWA/n5ZNHwcz1N1PQt7eoWej6+wFTET+BUe1YP+dd
         ScJAp9JKZIs7hS/QOOrf1sH4KDAuOPdH0L5CMOGHcw8B1Pnk/EgkwO3hnsuZ/ffqYLvJ
         LtG9tlSCAgbBjGhxko0pf4IH/0XyfjCxky3ExA5uwYdSF3UtxK+WCMvty+bCNotzeZ8s
         bpFd0uXj6COuzbRVrzkTyEozeXGZQENbmxS6EMeEdauTusz8X5OJHL2GSgprR/JwRM0Y
         HKNA==
X-Gm-Message-State: AOJu0Yyl8NuqdvEvKcU2YVOoStibumr6L+b4HerM5eBsbq8QB5XQw0uc
	zeyPBOUlQR7wCvIGfzADFaaQFVdOW0qaCUUeCqDoTr02mjm65S8ZePZhIVTcIuWlkE+hqB6JVIK
	2A6EY5K8BqjBuZUCbi0P4PaNCnLL6aA2Eyzc+pqL/t+J1aIzJ+nAXeobkJKg=
X-Google-Smtp-Source: AGHT+IFN+SLT/uO2DcHLtEfXkzJOLsSz/+L9C/BTDkqNmFPE8jsAnPBi0Vj57TtqRddW5lz/ZRQQUn1W9MnqZF/1xTiAqwXjFPue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:3e3:d2d2:354e with SMTP id
 e9e14a558f8ab-3e3d2d2658fmr22006355ab.17.1753562612094; Sat, 26 Jul 2025
 13:43:32 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68853df4.a00a0220.b12ec.0030.GAE@google.com>
Subject: [syzbot] Monthly media report (Jul 2025)
From: syzbot <syzbot+list9abb6cddef6c590ca302@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 1 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 96 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 423     Yes   WARNING in smsusb_init_device/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=85e3ddbf0ddbfbc85f1e
<2> 339     No    KASAN: slab-use-after-free Read in em28xx_release_resources
                  https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed
<3> 171     Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<4> 169     Yes   KASAN: slab-use-after-free Read in dvb_device_open
                  https://syzkaller.appspot.com/bug?extid=1eb177ecc3943b883f0a
<5> 45      Yes   general protection fault in dvb_usbv2_generic_write
                  https://syzkaller.appspot.com/bug?extid=f9f5333782a854509322
<6> 35      No    KASAN: slab-use-after-free Write in as102_release (2)
                  https://syzkaller.appspot.com/bug?extid=47321e8fd5a4c84088db
<7> 8       Yes   WARNING in media_create_pad_link (2)
                  https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
<8> 6       No    KASAN: vmalloc-out-of-bounds Write in tpg_fill_plane_buffer (4)
                  https://syzkaller.appspot.com/bug?extid=dac8f5eaa46837e97b89
<9> 5       Yes   BUG: corrupted list in az6007_i2c_xfer
                  https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

