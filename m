Return-Path: <linux-kernel+bounces-759503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F730B1DE51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C4F163F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409741FBEB6;
	Thu,  7 Aug 2025 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Zb3Z/clE"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A453FE7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598556; cv=none; b=OPf7vG2UTiKhb6B0Et27RY3yxGd/F7bM+rNDJ26hzuuSZxFZ55ev17xhUnWg+5ttPp5oGgugi2ZACj8Dp+gILCWtkcNVDdQ3zT7kCK7w3R/nahs6cPhJ7g1RUhklKiQNNIM+q1YhsMrKH5BoKmja1gU3WJ26uwIaj/mLO+DmyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598556; c=relaxed/simple;
	bh=wsr1qEOxDRYojxOQyO3jfFubJ/SAHb5NyCwQ5gbBxrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGJpa3Xh/LgxDPQGYtwAXsYcFtm4eU0BkE9ruAjZtzLUwYQQ7xNLFZkKF4fOYxp/fWouBjNl9aLBHXDb2Q2ZBcKxEVesChdf9KHL/v/OmZfyhi2/bCpK4L+vfYpNpx/gOZ3GRDjIHsrlsh9UXPbOAOEMZ59+yAYbBM0zVOI7IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Zb3Z/clE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-741c0d47aadso949784a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754598553; x=1755203353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIqlvQFrxYwl3uh7TgoGBkH+JrtKoH+8x+kfuvMJktA=;
        b=Zb3Z/clERTVjYjRsZK8O+ExjioeAwtQv/s1J5iSn+QY1zalO6rr8bFqLnX3SRYW63C
         KwJZuK/REe36rRcM+zz5lcR7K9IBZoGYKLuDW5/CezZfKyC2KHmA8tL9DbtpxT0dcbXY
         9qDWrkZwezAsnk8TVGCPdV8a+FPR/J5uNJGs75r3kVcBgq71tf2JTs7TElXE+Tis8Slq
         TAzp33Xg8XA7FpllX11kJhOAczHWoxvKDYj7Id9lA+RunECx1gibztzzKHHfqVWhcbRo
         E1UihWbKoG2PZ4C91kHZo/5Ap+TWqBMehN6HpNVHrHFdo8HEJYyNFPhMh1N/xOIdv2R3
         Crwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754598553; x=1755203353;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIqlvQFrxYwl3uh7TgoGBkH+JrtKoH+8x+kfuvMJktA=;
        b=nu9YGaCkCxaNL9AqGWeME/l2+I8QLxT3LwlueYw2m70F+ZunpmPD+5ROkh5I6C5q6f
         4jQc6sCBnsRp/oaShvmm5MwG6KPSw7Qa3sH7KR3XMvJFqkEzqDGwAa/uxOz0x0XDQtYM
         8iNCUfMSRTE8GKs6mTOc1RBuh2/rpHJtlM9IqU939XOPsirbUmCrDyWQjf7R1htWy7Rn
         RihsHeH0fzxnLZ44xu6anzCR/Sa5mMx7qRtWzfq0qKq34azyIICLt2FtYvdcuEJXaEda
         SJkITIe9nnAEv8CY5cRu0EwlLaV4PFBUIHPx5e16s+Q65EuIE7vxRHkv0YiESphj08ql
         rNYA==
X-Forwarded-Encrypted: i=1; AJvYcCX/RWgJK2UI0/L5OFNw1JE56/IEZuakcy2DitT6OzJJlaNxUJ2Xl20t5XaSDWBgZgfOZ+cE26LqBbUW5uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGS+NSfjGGfprAl8L8uhFqpWDF8jIa+ufwNeCA4cP+Tw+VSEZV
	mF6Q7U0Tt/wGsQU29gFhvibqp3JwcKEgtK+YHpGyZ0zPdHWe/f/dldUAX/nq+0F/hY6D9NBh/CE
	Sxfuy
X-Gm-Gg: ASbGncu+BvIWWuizkis0+pUoI0GsAHkgp1j7Rkh/TigGx9hTW2hquUM/k8U0cO2idvx
	Rm6nZGAZ66BQjoApmLwfzDOIEusbV+0bbPkN3La+Q1tvqsKjxuqDfRv64hp/ZkUdpYFMjOTZJ2m
	79WedAeqCnoUCOxbN7lQn7ZWImXcQvYE0N+zvnh1uRZ201a6QyteI+l3bbkUqldGT9H5Lpwpij3
	9Sq4Lc86iU6fViLsf6dyLieoqgW9egsjQzRuxQ7qITc+IzxTbQj59J/lO5wPgv0XNdSxiEh1v0b
	GPGtenDYWNIIFdmtKKSOAMc6jzsj1WjizK49rhZ7xR7anUMvzCofy0YXqhxNIA0cNDFF8ynXCXk
	p08vmStkJXizlXHOH51rSyhlo8w==
X-Google-Smtp-Source: AGHT+IHCZJurdRIwU4wfFIwuhvsPHbftFeS/wE2rphZqxkateyl66SIEUs0wEvn1pXagzXrZNrWWrg==
X-Received: by 2002:a05:6830:2b24:b0:73e:9857:9839 with SMTP id 46e09a7af769-7432c5bf6d6mr396716a34.0.1754598553210;
        Thu, 07 Aug 2025 13:29:13 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741a67da683sm3135237a34.40.2025.08.07.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 13:29:12 -0700 (PDT)
Date: Thu, 7 Aug 2025 15:29:08 -0500
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [BUG] ipmi_si: watchdog: Watchdog detected hard LOCKUP
Message-ID: <aJUMlAG17c6lCgFq@mail.minyard.net>
Reply-To: corey@minyard.net
References: <aJO3q8JiVXKewMjW@CMGLRV3>
 <CA+QrTELaLFRGn1ynG5dG+KB_40aPA31hU5QgLn7ikh2Zbk3Hpg@mail.gmail.com>
 <aJPGItElGBN3nilX@mail.minyard.net>
 <aJPK6Vuxc1jL-uu_@CMGLRV3>
 <aJPccSayM2nXk891@mail.minyard.net>
 <aJUB0gQZ6cH1zMRE@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUB0gQZ6cH1zMRE@CMGLRV3>

On Thu, Aug 07, 2025 at 02:43:14PM -0500, Frederick Lawler wrote:
> 
> It occurred to me last night that I'd probably like a rate limit on the KCS
> messages as well. I didn't see if a patch for that was made. I can whip
> that up sometime next week, that could be of use to anyone.

That jogged my memory a bit; there is something called "maintenance
mode" in the IPMI driver.  It's used primarily for firmware updates,
but it's triggered by reset commands in addition to firmware update
commands.  It has three basic affects:

* It turns off automatic messages sent to the BMC by the driver
  (only fetching flags, I think).

* It changes the way the timing works to check for the BMC being ready
  a lot more often.  (This is a hardware check and shouldn't affect
  the BMC, but maybe it does on some.)

* It changes the timing for messages routed to the IPMB bus to give
  them more time.

It solved two problems:

* For systems without IPMI interrupts, firmware updates were taking
  forever.  

* When you would reset the BMC, the driver's automatic messages would
  generally time out.  And IPMB messages pending would time out.

The theory was that if the user reset the BMC, they wouldn't issue any
IPMI commands, and the driver wouldn't either, so it would leave the
BMC interface alone until it's done resetting.

It's not perfect, the reset or firmware update can happen over the LAN
interface, but it seemed to help a lot of people.

Anyway, after that long explaination, maybe that needs to be extended
and if the driver goes into maintenance mode have all sysfs accesses
to the BMC return an error.

It also might be a good idea to differentiate between resets and
firmware update commands.  After a reset nothing will probably work, but
the BMC is still partially function during a firmware update.  So no
IPMI commands at all for a little while after a reset.  That is a
behavioral change, but it's probably not a lot different that what would
happen, anyway.  The error just comes back faster.

None of this solves the basic issue, though.

I'm not exactly sure what you mean by a rate limit on KCS messages.  It
would lower the probability, perhaps, but it wouldn't eliminate the
problem, either.  Just not allowing anything during these times is
probably better.

> 
> [1533534.869508] [Hardware Error]: Corrected error, no action required.
> [1533534.884635] [Hardware Error]: CPU:1 (17:31:0) MC18_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
> [1533534.912122] [Hardware Error]: Error Addr: 0x0000000313c7a020
> [1533534.926641] [Hardware Error]: IPID: 0x0000009600350f00, Syndrome: 0x9fec08000a800a01
> [1533534.943278] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0
> [1533534.946635] EDAC MC0: 1 CE Cannot decode normalized address on mc#0csrow#1channel#3 (csrow:1 channel:3 page:0x0 offset:0x0 grain:64 syndrome:0x800)
> [1533535.369487] INFO: task cat:1844873 blocked for more than 10 seconds.
> [1533535.385145]       Tainted: G        W  O       6.12.35-cloudflare-2025.6.15 #1
> [1533535.401614] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [1533535.418715] task:cat             state:D stack:0     pid:1844873 tgid:1844873 ppid:1844872 task_flags:0x400000 flags:0x00004002
> [1533535.447475] Call Trace:
> [1533535.458691]  <TASK>
> [1533535.469154]  __schedule+0x4fa/0xbf0
> [1533535.481433]  schedule+0x27/0xf0
> [1533535.493181]  __get_guid+0xf4/0x130 [ipmi_msghandler]
> [1533535.506325]  ? __pfx_autoremove_wake_function+0x10/0x10
> [1533535.519910]  __bmc_get_device_id+0xd6/0xa30 [ipmi_msghandler]

Yeah, this is what I would expect to see if you are doing this operation
and the BMC is in reset.  It's going to sit there until it times out and
returns an error.

-corey

> [1533535.534459]  ? srso_return_thunk+0x5/0x5f
> [1533535.546509]  ? srso_return_thunk+0x5/0x5f
> [1533535.558540]  ? __memcg_slab_post_alloc_hook+0x21b/0x410
> [1533535.571722]  aux_firmware_rev_show+0x38/0x90 [ipmi_msghandler]
> [1533535.585304]  ? __kmalloc_node_noprof+0x3f6/0x450
> [1533535.598144]  ? seq_read_iter+0x376/0x460
> [1533535.609621]  dev_attr_show+0x1c/0x40
> [1533535.621024]  sysfs_kf_seq_show+0x8f/0xe0
> [1533535.632316]  seq_read_iter+0x11f/0x460
> [1533535.643172]  ? security_file_permission+0x9/0xb0
> [1533535.655102]  vfs_read+0x260/0x330
> [1533535.665368]  ksys_read+0x65/0xe0
> [1533535.675559]  do_syscall_64+0x4b/0x110
> [1533535.686324]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [1533535.698530] RIP: 0033:0x7f72b587125d
> [1533535.708857] RSP: 002b:00007ffccc21bb48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [1533535.723411] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f72b587125d
> [1533535.737361] RDX: 0000000000020000 RSI: 00007f72b5755000 RDI: 0000000000000003
> [1533535.751191] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
> [1533535.764847] R10: 00007f72b5788b60 R11: 0000000000000246 R12: 00007f72b5755000
> [1533535.778536] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000000000
> [1533535.792210]  </TASK>
> 
> crash> bt -l 1781073
> PID: 1781073  TASK: ffff9d91c7040000  CPU: 81   COMMAND: "/usr/bin/python"
>  #0 [ffffb3a171683c00] __schedule at ffffffff9d559eea
>     /cfsetup_build/build/linux/kernel/sched/core.c: 5338
>  #1 [ffffb3a171683c80] schedule at ffffffff9d55a617
>     /cfsetup_build/build/linux/arch/x86/include/asm/preempt.h: 84
>  #2 [ffffb3a171683c90] __get_guid at ffffffffc22aa574 [ipmi_msghandler]
>  #3 [ffffb3a171683ce8] __bmc_get_device_id at ffffffffc22aa696 [ipmi_msghandler]
>  #4 [ffffb3a171683da0] aux_firmware_rev_show at ffffffffc22ab1c8 [ipmi_msghandler]
>  #5 [ffffb3a171683dd0] dev_attr_show at ffffffff9d1175dc
>     /cfsetup_build/build/linux/drivers/base/core.c: 2425
>  #6 [ffffb3a171683de8] sysfs_kf_seq_show at ffffffff9cc64caf
>     /cfsetup_build/build/linux/fs/sysfs/file.c: 60
>  #7 [ffffb3a171683e10] seq_read_iter at ffffffff9cbddf7f
>     /cfsetup_build/build/linux/fs/seq_file.c: 230
>  #8 [ffffb3a171683e68] vfs_read at ffffffff9cba8590
>     /cfsetup_build/build/linux/fs/read_write.c: 489
>  #9 [ffffb3a171683f00] ksys_read at ffffffff9cba9165
>     /cfsetup_build/build/linux/fs/read_write.c: 713
> #10 [ffffb3a171683f38] do_syscall_64 at ffffffff9d550c8b
>     /cfsetup_build/build/linux/arch/x86/entry/common.c: 52
> #11 [ffffb3a171683f50] entry_SYSCALL_64_after_hwframe at ffffffff9d60012f
>     /cfsetup_build/build/linux/arch/x86/entry/entry_64.S: 130
>     RIP: 00007f04e1b7c29c  RSP: 00007ffea7aaf6c0  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000a840f8  RCX: 00007f04e1b7c29c
>     RDX: 0000000000001001  RSI: 000000002fd06ef0  RDI: 00000000000000c1
>     RBP: 00007f04e1a82fc0   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000246  R12: 0000000000001001
>     R13: 000000002fd06ef0  R14: 00000000000000c1  R15: 0000000000a41520
>     ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
> 
> crash> files 1781073
> ...
> 193 ffff9db5132e5800 ffff9dafb18bd200 ffff9da7b780bcf0 REG  /sys/devices/platform/ipmi_bmc.0/aux_firmware_revision
> 
> crash> log -c
> ...
> [1533553.998160] [      C7] ipmi_si IPI0001:00: KCS in invalid state 6
> [1533554.009156] [      C7] ipmi_si IPI0001:00: KCS in invalid state 8
> [1533554.019973] [T1844873] ipmi_si IPI0001:00: KCS in invalid state 9
> [1533554.031005] [     C81] ipmi_si IPI0001:00: IPMI message handler: device id fetch failed: 0xd5
> 

