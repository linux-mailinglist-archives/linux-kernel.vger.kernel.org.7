Return-Path: <linux-kernel+bounces-871592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA8C0DB96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CBE3B6022
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEC23D289;
	Mon, 27 Oct 2025 12:50:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912E22F77B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569427; cv=none; b=mpUzLYHom29ZSY5JaSd3abrxYYfm1ZgAnbWUFUaLkB1kfPc3VYM+neu4vDm9IVLAczvwXsuVAT2B+lns+TC2D0Y+DFx5VRO8slrErazFosFqbZEOv+FCJThBMrE6ra4djMClfWimzYATGfzWLkzmEaBkH9qsI8YDKipK8LYEEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569427; c=relaxed/simple;
	bh=tVpd9K6lsAmTNM0IHM0UDIhya3STuvqamyLbLmC5K0M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gn0zjJyeptvOEUGlR696h8A6PuWAOrhPwpkyVkWEIh/hDzZkWtdiMkaOIlhmFWmuqenAQqZ1ltBsLsxtCKwbuKyoJNUC5oZyqsZyWGYYMWcoFt+mjWzehLfvaCtllbhOTBlcpXnyumDJwecQjmxW+EI3bAFZBkDQEjivfXBsPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so598399739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569424; x=1762174224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lm8kK1+CNj81hpim3niy1QHqxI0Nn9TggtZMdd95srw=;
        b=jv3BFiE4vPmqqlpVmJGPBYiO25SmVO4qlhzb/upPu8KBE33ts7vTflVeTzeTGOBiLw
         GxBeKhpa5v+6SJKX9ikmcpohlcyPvHJdXh4p10ddFTIbUnabXuhfy81vKGAjhcreSTkN
         uPkkSN5teArYMbU6PS6IGpx0B0Q60c72X0NIkGt2lBnLZBE65hBLGaLLMywl3wZIc1OH
         EOLHvu3gH5FUw/jmOGR363Q3Ev1Dn/QbVa4EkvqwPeYxFwZOQsm5253Tbkz/lmmSxMD3
         xN88Ag5CM1azsx2vwmuOX3ZnEHATPXmqulVpZDjCr/Og240C13uXWqwC2pJLLwyz6NBR
         3PFA==
X-Gm-Message-State: AOJu0YwpcQjZGEiPQSKMki7/8RGZcPuEXQRXGdqJBS3mulvqtEFUNo7q
	GPjBD7Cx8i3BGI0Bo/xD+JTEd/3B7RjsP7GH2uKMJnF8afngAYKicMlmJ80YoPEXwFHo4kGcqnH
	wcPUdCISbffqmxUcMHTsXBNBVRF2xH2be7OXZ+Q0rXDJ7IDzWyo5533nqP78=
X-Google-Smtp-Source: AGHT+IGiL4rBnV7PYaIposPTlpOgvUQvCmFsOmIdNScae9rJMfLB84IHKqvXTGXCeNCAbH2WIOij5A52YLm5KyXvlNv16eWlLVSf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:460e:b0:431:f39e:6bd8 with SMTP id
 e9e14a558f8ab-431f39e6e29mr115805785ab.5.1761569424689; Mon, 27 Oct 2025
 05:50:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6a90.050a0220.3344a1.0394.GAE@google.com>
Subject: [syzbot] Monthly media report (Oct 2025)
From: syzbot <syzbot+listd6f341b8c90a4c1bdad0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 22 issues are still open and 97 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 394     No    KASAN: slab-use-after-free Read in em28xx_release_resources
                  https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed
<2> 392     Yes   KASAN: slab-use-after-free Read in dvb_device_open
                  https://syzkaller.appspot.com/bug?extid=1eb177ecc3943b883f0a
<3> 84      Yes   general protection fault in su3000_i2c_transfer
                  https://syzkaller.appspot.com/bug?extid=d99f3a288cc7d8ef60fb
<4> 57      Yes   general protection fault in dvb_usbv2_generic_write
                  https://syzkaller.appspot.com/bug?extid=f9f5333782a854509322
<5> 53      No    KASAN: vmalloc-out-of-bounds Write in tpg_fill_plane_buffer (4)
                  https://syzkaller.appspot.com/bug?extid=dac8f5eaa46837e97b89
<6> 3       No    WARNING in dtv5100_i2c_msg
                  https://syzkaller.appspot.com/bug?extid=a83ee2dae0e6cc6cd3aa

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

