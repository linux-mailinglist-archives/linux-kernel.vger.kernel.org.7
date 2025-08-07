Return-Path: <linux-kernel+bounces-759443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7510B1DD9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9117F7AA1DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD522A813;
	Thu,  7 Aug 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ItpylaLY"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF92206BC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595801; cv=none; b=jjFWNs9hsdjUvpzh3xV/iA9v6RN1wiD0j1oBZ/763FO0VRgn6V0VLlW6PHzu0t03go9nbW5lFcjDNPCi7eQWYsLitB0PdQpyvda0VP8/AHzMvibZd/ML6Y8ZdqZnDiwUkUmyrZmwI0SMN0HhYpiJ6yiqFsq3bfQYN61Su7AKrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595801; c=relaxed/simple;
	bh=dEbV9u1yf7ixFmqTZylHBZeQnC4X+gY+bk3DjkiR0ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0zJtXphQYNFS2KUU4Pcd6qslPlOpUTM4TFZzxDuI0CA3VonZ/C28BvEJKPGHInuiA3jIhh1j0vT04nlfZmWeJyQllH9OLAHeSxyqC5fhgoeMbpW2O3bkYqKw0vGMDFR68X6hm3/7s/kbhE3b+CYxs1lViUwm2dyQUvwb0aVObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ItpylaLY; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e40d006105so8434815ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754595796; x=1755200596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksN7QoEbspBuW98h37TMe0g97VeYrOETORSi4asOWIE=;
        b=ItpylaLYTzjLoY4U6YWATMUp0ImPyerOPadkIq8GWh7eQ6xIOSIIZEdW53W6hkXb4b
         2+GkCLSnQGjGtExzikjLAnyUYvfzJfock12vf4TbuNB//buGXzXQjksC8wTT4A/DHeyI
         QZ5uz11e0TshmARWhFTaWzoH0z02kYnddsjlDmfCDL0624mYVHw2dcn/+ZFix/znBd9Y
         ERywnMKGc1wOlsYVOXWwY37Psxcq1GtAwxFSvsSgJqQaS1gPPdaGZRIs8VqtdAd3T2kX
         xH1Cr43sK7zCPz9aXeizU/dkVMu7fdkQ3R5zWkoHEIc28+Bn6qLNN8WsVQFIGPq0so7w
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595796; x=1755200596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksN7QoEbspBuW98h37TMe0g97VeYrOETORSi4asOWIE=;
        b=eMaKvqdHr0pgof+awW8LyEQXcgiCOMjaASNjQkSbhnEMTceJVvL5fYZae70R/gD2EM
         lixotwPu/jyGC4C6PR28sFkEZlmHcscFh3mxgRjhbVhiGdEWj0EflSJeTEOTVOcpVgBw
         9Bqvj303X17NEyPWdq0F3d2JzLzP3mh3Edvd6H0T6a/2oTJyXoxNO7X9bLsOfhlBfprZ
         7LP3aX/TxlOCmv0Xp9pGkRkivPbPCKZ0QUb54rLhBp93BYNyJeoNY0gjKqUy0nGUZe3t
         Uxxf5uywXzOs809NxU0l87GtTthN66cin0bh4trWCoGq880Z+lhbsMUO3C6hDzcEkXZY
         gWSw==
X-Forwarded-Encrypted: i=1; AJvYcCUpk3DZTUaREVAA15HW5surH7b4NrOj2ENtz3o2Dk2f1Xmnn6Sjr0e+VVYU4C1hBf0q8GL4HHbR8yNkxU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEe+/H1+WG6/eDYpr7gOcx3l/9xoqZKWJXmDSLAagAwr8Ln56
	YyzEU9hhBn/6ZCxx9omI28VRM0VBZSjPaI70p/JnYqAZck1CfVqkr/qoal2m8MujMuF8Oob94sI
	nho+VqiI=
X-Gm-Gg: ASbGncvF00TfPgmuYbhaRHOFvIrG1317scVjZgATuP9PtYLLVp2hfXwkU2IvEAPJnPb
	D/kIqapOntVHf1w2YrZ4F8f3WjVrkmTFEeLOcvlJEfVXkZEX/ArHp+cxkTEg6RqmoxuVOCdmoMq
	BFVb2wEpS+Y/5PGyRWgiL2AUn9ADRmxn9lPYErEnbtDvUG/6p19HLtO4C4xFZTqU619eYr7MUPD
	/9nAM3iyGIlSLVivn1aLnNlGZ09ktJZi7cHB/bnQ5rNWPkc9K30yHn6GP3nm2X16j39m5eR7NqP
	EATUlqb2s4076vx2C7KUdFJzQLlbUtt3n87eqomtDMhF0nwzhSkEDdvrxm8UlJ1DV1evhO0jK4r
	nylsJ
X-Google-Smtp-Source: AGHT+IFA/sAzgFcR2AzlnIx+4w0z6jjnn+uYNSIEDm7YokMqWR7scpx2gbqcep8UiSxQf6yrkGVliw==
X-Received: by 2002:a05:6e02:170c:b0:3e5:261c:bac0 with SMTP id e9e14a558f8ab-3e53317c453mr6676585ab.22.1754595796368;
        Thu, 07 Aug 2025 12:43:16 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:1b37::2b6:36])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e5254b5765sm11400145ab.34.2025.08.07.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:43:15 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:43:14 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [BUG] ipmi_si: watchdog: Watchdog detected hard LOCKUP
Message-ID: <aJUB0gQZ6cH1zMRE@CMGLRV3>
References: <aJO3q8JiVXKewMjW@CMGLRV3>
 <CA+QrTELaLFRGn1ynG5dG+KB_40aPA31hU5QgLn7ikh2Zbk3Hpg@mail.gmail.com>
 <aJPGItElGBN3nilX@mail.minyard.net>
 <aJPK6Vuxc1jL-uu_@CMGLRV3>
 <aJPccSayM2nXk891@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJPccSayM2nXk891@mail.minyard.net>

On Wed, Aug 06, 2025 at 05:51:29PM -0500, Corey Minyard wrote:
> On Wed, Aug 06, 2025 at 04:36:41PM -0500, Frederick Lawler wrote:
> > On Wed, Aug 06, 2025 at 04:16:18PM -0500, Corey Minyard wrote:
> > > On Wed, Aug 06, 2025 at 03:19:02PM -0500, Fred Lawler wrote:
> > > > + CC: Corey Minyard <corey@minyard.net>
> > > > 
> > 
> > > I'm wondering if something is happening with the BMC resetting and
> > > interactions with ACPI involved in that.  Adding the extra part of
> > > trying to talk to the BMC while it's being reset could cause the BMC to
> > > get confused and do bad things?
> > > 
> > 
> > Sure, it's a possibility we explored. We have a lot of automation.
> > Predominately of which is a prometheus module exporting IPMI information
> > from the sysfs files. And we also have config management that's querying
> > sysfs files to regulate updates etc... Sometimes, the config management
> > automation will attempt to reset the BMC.
> 
> Ok.  I have tests that do BMC resets, but I can't run at the scale you
> do, and I'm running in a simulator so it's not going to be have the
> same.
> 
> The other possibility is the processor goes into the idle code while
> interrupts are off, but I think the kernel has checks all around that.
> I can't think of how else a processor would get stuck in idle.
> 

Yes, it's a bit of an odd case. There's nothing obvious reported by the
crash utility. By the time we get the NMI/panic, the CPUs are off doing
something else in our crash typical case. That said, earlier this week I got a
hard lockup outside of a BMC reset, but the node had too many MCE
correctable memory errors.

For sake of completeness, I'll post that stack trace here anyway since
that may provide some more context clues. In this case, I did catch two
separate reads to sysfs files, and then they appear to have competed.
The cat process seemed to already be off CPU, but the KCS
message is still coming in at the same time the python script was being
processed too. Only the python run was on CPU at time of crash. But NMI
panic was still on a idle CPU. Unfortunately, I didn't write down all
the logs this one, so it's missing the idle state NMI for watchdog, but
hopefully the snippets show what's happening. I posted this below.

> > 
> > > > >
> > > > > I tried also tried to load the CPUs with stress-ng, but the best I can do
> > > > > are the hung tasks.
> > > > >
> > > > > I identified that sni_send()[1] could be locked behind the
> > > > > spin_lock_irqsave() and within the KCS send handler, there's another irq
> > > > > save lock. I suspect this is where we're getting hung up. Below is a
> > > > > sample stack trace + log output.
> > > 
> > > Yeah, I don't see that in the traceback.  There is a lock in the KCS
> > > sender, but I don't see how that could do anything.
> > > 
> > > Maybe you could try changing the cpuidle handler?  That would be at
> > > least something to try.
> > > 
> > 
> > Would that help in forming a reproducer? I'd need to deploy any kernel
> > modifications fleet wide to cast a wide enough net. The lockups arn't
> > extremely consistent. We may get a couple or more a week.
> 
> Ah, so this isn't readily reproducable.  Bummer.
> 
> If the problem goes away if you change the cpuidle handler to something
> non-ACPI, that would be a big clue that it's an ACPI issue.
> 
> > 
> > Lastly, I have the rate limit patch backported. I'll be able to start
> > testing with that tomorrow, and same with loading the IPMI watchdog
> > module.
> 
> Ok.  I don't have much hope for it making much difference, but it's safe
> and will be coming in the next kernel release.
>

It occurred to me last night that I'd probably like a rate limit on the KCS
messages as well. I didn't see if a patch for that was made. I can whip
that up sometime next week, that could be of use to anyone.

[1533534.869508] [Hardware Error]: Corrected error, no action required.
[1533534.884635] [Hardware Error]: CPU:1 (17:31:0) MC18_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
[1533534.912122] [Hardware Error]: Error Addr: 0x0000000313c7a020
[1533534.926641] [Hardware Error]: IPID: 0x0000009600350f00, Syndrome: 0x9fec08000a800a01
[1533534.943278] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0
[1533534.946635] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#1channel#3 (csrow:1 channel:3 page:0x0 offset:0x0 grain:64 syndrome:0x800)
[1533535.369487] INFO: task cat:1844873 blocked for more than 10 seconds.
[1533535.385145]       Tainted: G        W  O       6.12.35-cloudflare-2025.6.15 #1
[1533535.401614] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[1533535.418715] task:cat             state:D stack:0     pid:1844873 tgid:1844873 ppid:1844872 task_flags:0x400000 flags:0x00004002
[1533535.447475] Call Trace:
[1533535.458691]  <TASK>
[1533535.469154]  __schedule+0x4fa/0xbf0
[1533535.481433]  schedule+0x27/0xf0
[1533535.493181]  __get_guid+0xf4/0x130 [ipmi_msghandler]
[1533535.506325]  ? __pfx_autoremove_wake_function+0x10/0x10
[1533535.519910]  __bmc_get_device_id+0xd6/0xa30 [ipmi_msghandler]
[1533535.534459]  ? srso_return_thunk+0x5/0x5f
[1533535.546509]  ? srso_return_thunk+0x5/0x5f
[1533535.558540]  ? __memcg_slab_post_alloc_hook+0x21b/0x410
[1533535.571722]  aux_firmware_rev_show+0x38/0x90 [ipmi_msghandler]
[1533535.585304]  ? __kmalloc_node_noprof+0x3f6/0x450
[1533535.598144]  ? seq_read_iter+0x376/0x460
[1533535.609621]  dev_attr_show+0x1c/0x40
[1533535.621024]  sysfs_kf_seq_show+0x8f/0xe0
[1533535.632316]  seq_read_iter+0x11f/0x460
[1533535.643172]  ? security_file_permission+0x9/0xb0
[1533535.655102]  vfs_read+0x260/0x330
[1533535.665368]  ksys_read+0x65/0xe0
[1533535.675559]  do_syscall_64+0x4b/0x110
[1533535.686324]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[1533535.698530] RIP: 0033:0x7f72b587125d
[1533535.708857] RSP: 002b:00007ffccc21bb48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[1533535.723411] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f72b587125d
[1533535.737361] RDX: 0000000000020000 RSI: 00007f72b5755000 RDI: 0000000000000003
[1533535.751191] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
[1533535.764847] R10: 00007f72b5788b60 R11: 0000000000000246 R12: 00007f72b5755000
[1533535.778536] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000000000
[1533535.792210]  </TASK>

crash> bt -l 1781073
PID: 1781073  TASK: ffff9d91c7040000  CPU: 81   COMMAND: "/usr/bin/python"
 #0 [ffffb3a171683c00] __schedule at ffffffff9d559eea
    /cfsetup_build/build/linux/kernel/sched/core.c: 5338
 #1 [ffffb3a171683c80] schedule at ffffffff9d55a617
    /cfsetup_build/build/linux/arch/x86/include/asm/preempt.h: 84
 #2 [ffffb3a171683c90] __get_guid at ffffffffc22aa574 [ipmi_msghandler]
 #3 [ffffb3a171683ce8] __bmc_get_device_id at ffffffffc22aa696 [ipmi_msghandler]
 #4 [ffffb3a171683da0] aux_firmware_rev_show at ffffffffc22ab1c8 [ipmi_msghandler]
 #5 [ffffb3a171683dd0] dev_attr_show at ffffffff9d1175dc
    /cfsetup_build/build/linux/drivers/base/core.c: 2425
 #6 [ffffb3a171683de8] sysfs_kf_seq_show at ffffffff9cc64caf
    /cfsetup_build/build/linux/fs/sysfs/file.c: 60
 #7 [ffffb3a171683e10] seq_read_iter at ffffffff9cbddf7f
    /cfsetup_build/build/linux/fs/seq_file.c: 230
 #8 [ffffb3a171683e68] vfs_read at ffffffff9cba8590
    /cfsetup_build/build/linux/fs/read_write.c: 489
 #9 [ffffb3a171683f00] ksys_read at ffffffff9cba9165
    /cfsetup_build/build/linux/fs/read_write.c: 713
#10 [ffffb3a171683f38] do_syscall_64 at ffffffff9d550c8b
    /cfsetup_build/build/linux/arch/x86/entry/common.c: 52
#11 [ffffb3a171683f50] entry_SYSCALL_64_after_hwframe at ffffffff9d60012f
    /cfsetup_build/build/linux/arch/x86/entry/entry_64.S: 130
    RIP: 00007f04e1b7c29c  RSP: 00007ffea7aaf6c0  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000a840f8  RCX: 00007f04e1b7c29c
    RDX: 0000000000001001  RSI: 000000002fd06ef0  RDI: 00000000000000c1
    RBP: 00007f04e1a82fc0   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000246  R12: 0000000000001001
    R13: 000000002fd06ef0  R14: 00000000000000c1  R15: 0000000000a41520
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b

crash> files 1781073
...
193 ffff9db5132e5800 ffff9dafb18bd200 ffff9da7b780bcf0 REG  /sys/devices/platform/ipmi_bmc.0/aux_firmware_revision

crash> log -c
...
[1533553.998160] [      C7] ipmi_si IPI0001:00: KCS in invalid state 6
[1533554.009156] [      C7] ipmi_si IPI0001:00: KCS in invalid state 8
[1533554.019973] [T1844873] ipmi_si IPI0001:00: KCS in invalid state 9
[1533554.031005] [     C81] ipmi_si IPI0001:00: IPMI message handler: device id fetch failed: 0xd5


