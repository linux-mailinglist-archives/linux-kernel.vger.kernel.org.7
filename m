Return-Path: <linux-kernel+bounces-733757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB52B0789F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B35716DE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219F291C05;
	Wed, 16 Jul 2025 14:50:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B613A244
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677407; cv=none; b=fOEWy+T6piyqubCAkHc28fJxcdC9AaNsz5PXozcjEE8yst0i+nat3FIYO5YaiRcL+92EEfiFoaO4pbIw+Ct3r2OWOCcQ/GkVqXEYx9vAy+qx229P4i7skikFkZ7O6FFqc5GnzfQ9njI4VcvYX3OHCtpO482x9OSLnBSEbuyf/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677407; c=relaxed/simple;
	bh=v/cFd8LGc77JiQS6Ma1a9yIBm4YncIv4X5DpZLd5K70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eBfnZcAKpwHMrAeITPbaKiSd/aNVsdsyMBR/6F7a9RBdMA6/glfao1ohqlGT64fGC4cLamIxPOYUh49eY/Kwbk4PKcWL0POfQtFBNziFvrYmbX10VTnsevHUp60C4dmDmwUJL+2BgSI3QkRMTWksYnATHncggLDpKEnyJ02i6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so1193503839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677405; x=1753282205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sc0V+S5OAOz3pvNlHvI1SrT3sYqqIKrLyk5lIAGwRxU=;
        b=I10sfIvED66BDUEk0YHs5CxQHP84CVueRWBCnjRFgEFPyiIF3GKQp1tkeFvjLzlnZr
         MU3WPKIAECgRmHcoehg8iEdexf5gdJ1tr55TR1pD8L69atvSJqsmCkpkRGJcEPCtiJ1N
         IkL4FWSmyf6y1EaRtEYeHcXE+M6NztOcUZKlpNcEROriC2XfuJsI3LxFfEb2XNnjc9d1
         ZiUAEm+7nA2Mxt+m58G8DBBmB3gcc6QRXICnFTEzwdDkJOkidIvXKhaV9yRGfoXSn0a9
         u2VDBgd4SGEScsVUUaE8+tdYTpJukvbmQ4Q3TraflMJE+JSpNr7AT4BSM/HM+Dq3X7RI
         DZkA==
X-Forwarded-Encrypted: i=1; AJvYcCV0g2LKZi5H9WwuylCdchBEwf281gAmGhN4EhKVOuk6uMiyIjJOKvW0hoOagdmEit39nHtOwDzcKHwUJO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWy19wAGb0mJVeKRffqpGJSk2X5dg/PRw4Z2zYxkLai/9dE6ns
	a38HiJjlq4SQhj5QsW/dfwETJNhiZZL5dHtK6lTUDTXztTRUEaqN9f/PD46EQ1ZCt3fpbMHxOtq
	MpdohvpdnbhIA8S3yvoMarX36gVfPm/bV5e8qe777qSid9Jd4QPr++jrs5Tg=
X-Google-Smtp-Source: AGHT+IGdc8vzM7iSvXCp9mmrCm/Yx2viXXS0+jBJNeQ1/3p6asXTO6JfB2XsUtZHnhxp0zGrSm5hmCR7kciIQp0XhsrFyeM0Avm+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4f42:b0:873:1c2d:18e7 with SMTP id
 ca18e2360f4ac-879c2ae999fmr240157039f.10.1752677404683; Wed, 16 Jul 2025
 07:50:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 07:50:04 -0700
In-Reply-To: <78c3fb66-c30f-4c64-a499-61c1665186a8@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877bc1c.a70a0220.693ce.002b.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
From: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in s32ton

usb 1-1: config 0 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 9
usb 1-1: New USB device found, idVendor=045e, idProduct=07da, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
microsoft 0003:045E:07DA.0001: unsupported Resolution Multiplier 0
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in drivers/hid/hid-core.c:69:16
shift exponent 4294967295 is too large for 32-bit type '__s32' (aka 'int')
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.15.0-syzkaller-11339-gc2ca42f190b6-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x386/0x410 lib/ubsan.c:494
 s32ton+0xde/0x140 drivers/hid/hid-core.c:69
 hid_output_field drivers/hid/hid-core.c:1844 [inline]
 hid_output_report+0x419/0x790 drivers/hid/hid-core.c:1876
 __hid_request+0x14a/0x420 drivers/hid/hid-core.c:1999
 hidinput_change_resolution_multipliers drivers/hid/hid-input.c:1950 [inline]
 hidinput_connect+0x218a/0x3030 drivers/hid/hid-input.c:2327
 hid_connect+0x499/0x1980 drivers/hid/hid-core.c:2250
 hid_hw_start+0xa8/0x120 drivers/hid/hid-core.c:2365
 ms_probe+0x180/0x430 drivers/hid/hid-microsoft.c:391
 __hid_device_probe drivers/hid/hid-core.c:2735 [inline]
 hid_device_probe+0x3a0/0x710 drivers/hid/hid-core.c:2772
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 hid_add_device+0x398/0x540 drivers/hid/hid-core.c:2918
 usbhid_probe+0xe13/0x12a0 drivers/hid/usbhid/hid-core.c:1435
 usb_probe_interface+0x644/0xbc0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_set_configuration+0x1a87/0x20e0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0xa39/0x16c0 drivers/usb/core/hub.c:2663
 hub_port_connect drivers/usb/core/hub.c:5531 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5671 [inline]
 port_event drivers/usb/core/hub.c:5831 [inline]
 hub_event+0x2941/0x4a00 drivers/usb/core/hub.c:5913
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---


Tested on:

commit:         c2ca42f1 HID: core: do not bypass hid_hw_raw_request
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e948f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec692dfd475747ff
dashboard link: https://syzkaller.appspot.com/bug?extid=b63d677d63bcac06cf90
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f6f58c580000


