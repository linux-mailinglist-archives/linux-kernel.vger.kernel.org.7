Return-Path: <linux-kernel+bounces-723922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E90AFEC75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9737A4E1EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326E72E6106;
	Wed,  9 Jul 2025 14:45:04 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C52DF3FB;
	Wed,  9 Jul 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072303; cv=none; b=OuAhP4v+ulTyfXo4+wUnoUkfhZhHfl5nYM2AONLHF9S8QmmHwBCTXpOj88kKHvPcxWIZJTIyKfiQ4SdE/fObc+u1APOIefXQwRy83o6qrB35YmjRkAYYiIFFudqnUUvFB+9Cd6dEOmEzTjyyL2EAPabwbiRXHYqZXV6hPJkZ0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072303; c=relaxed/simple;
	bh=YHka2Nd7nyCr1LB/Jm4DIH6wxerrlY5O2lslqHt1pok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6NPf3QFa3/TPxamb9tocOKYUe78SEcz3VazkwYOj2RQzAFSXj697c50H9zXPga1tDBIoMcsBnYB/doN+izjb8CEZ3Le/LSW3Qhez+su5yUADWXaNKRKblVpXmlMeC1zXl3O+e3+O0rASxgoTnqiCxCxHlBpp3A3At6gBhnpHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 569Eim8x071199;
	Wed, 9 Jul 2025 23:44:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 569Eimtq071192
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Jul 2025 23:44:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
Date: Wed, 9 Jul 2025 23:44:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/09 23:27, Alan Stern wrote:
> Which of these three BUG_ON's did you hit, and where did you hit it?

kernel BUG at ./include/linux/usb.h:1990!

matches the BUG_ON(endpoint > 0xF) line. The location is shown below.

Call Trace:
 <TASK>
 hub_configure drivers/usb/core/hub.c:1717 [inline]
 hub_probe+0x2300/0x3840 drivers/usb/core/hub.c:2005
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
 usb_set_configuration+0x1ab9/0x2120 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c1/0x390 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 usb_new_device+0x9fd/0x1610 drivers/usb/core/hub.c:2694
 register_root_hub+0x275/0x590 drivers/usb/core/hcd.c:994
 usb_add_hcd+0xba1/0x1050 drivers/usb/core/hcd.c:2976
 dummy_hcd_probe+0x134/0x270 drivers/usb/gadget/udc/dummy_hcd.c:2694
 platform_probe+0x148/0x1d0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26a/0x9a0 drivers/base/dd.c:657
 __driver_probe_device+0x18c/0x2f0 drivers/base/dd.c:799
 driver_probe_device+0x4f/0x430 drivers/base/dd.c:829
 __device_attach_driver+0x2ce/0x530 drivers/base/dd.c:957
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:462
 __device_attach+0x2b8/0x400 drivers/base/dd.c:1029
 bus_probe_device+0x185/0x260 drivers/base/bus.c:537
 device_add+0x7b6/0xb50 drivers/base/core.c:3692
 platform_device_add+0x4b4/0x820 drivers/base/platform.c:716
 dummy_hcd_init+0x293/0x1070 drivers/usb/gadget/udc/dummy_hcd.c:2845
 do_one_initcall+0x233/0x820 init/main.c:1274
 do_initcall_level+0x137/0x1f0 init/main.c:1336
 do_initcalls+0x69/0xd0 init/main.c:1352
 kernel_init_freeable+0x3d9/0x570 init/main.c:1584
 kernel_init+0x1d/0x1d0 init/main.c:1474
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


