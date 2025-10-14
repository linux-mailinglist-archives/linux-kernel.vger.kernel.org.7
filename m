Return-Path: <linux-kernel+bounces-852224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D37FEBD87A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A59184FB314
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BF2EA49F;
	Tue, 14 Oct 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CO09Qhhq"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB62DC79B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434822; cv=none; b=HZwZkjUIfCLeQl5Fb/tLhHCBNQl5sA3Be9qBw1JGYxQ9uZVWXzyhmYeZ7+p1rRlZcCbgTyHHaEztERmlh9w5kIRgYwcLEFtztGpuwMWXUWQddi4NQaCWBnioXsn5M320Cbzr1dkLbygGqH/c8HVObWT+hUqFleEdv19ACo71Wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434822; c=relaxed/simple;
	bh=ucdddFZXZBcovG3tGzXG10VSqLbiPbUBuVnrSi/WIw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq2yc141JPoaJjqsIHGxWQTB1vSQuHzxbQrt//sEG17jCZbr0Em/X+RamEaBQC0p8+rkijlwobwXBRcPtLMfgrY//eNys1JBofjr2uIWOcw3VRxN+YFNpuD/TK5mkNx0Uxxc3eoRn6sC5w5HniWAdicohU7/xyRrgf5d2GUR1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CO09Qhhq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 19DF33F1DD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760434462;
	bh=KBL4UdMT5NMKXetc48TxKCq//fpeAujD6S0Wp3+3ewc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=CO09QhhqfrqyIimtoUBJFztNmab+ftM1TC/AZWhuNuERfYlFMZ0yyqWcnBBxgWoa2
	 Ajy0YT6QVl0eObnhkgKokLNISRpFX4XwUyPhleI3Lcqq996PgYhzbfuLULilwsSrP4
	 aDfkFJVBejULQgPRy3+sNOxQ7mjeGllYIeiyoD5LYLoCuT+YTbtphSncNi7534eryB
	 JdvqwquFl7I7i7E16U9itIpiJ7jNB3T8yLd9zHFP26Q9QAzN3jVesIvM9OIH8X2g4O
	 68mrrEzm/76VQfIyAOnVgHuBs5MSZkfic7vuseeQ7VEZJqgxKlfTl6l0bO6PtQxtuR
	 9ZCgda+S3GWqni/ILsYNFfvATdb+Grlb2Ij4EeVz96PvSmCvWzaYyVf3YqQuMXE3VN
	 fhDxFdZwiKWd7ZFn2D/HuWCNcq75Yo4I/vcN3+CRyydhknRRvw8Eaok67CdZLn3VIY
	 fNgAfUaY7muTBrg7lmL0ZBQS37B7AjBDUOpBUB9f+bRxAiKqwI+9J6sFJ9BJc9KJCR
	 NWSQpxfuk9Pv+i+yq96ZO9Tsafk0pGo+T1CUG83QJZdm4jrRDcAyrUHJy1ZxYHJQH6
	 op3nXzOvLGqlAYq3u8Moz0AAfFDBLBFYn3enLWt1wLPggfrBm05s+4aCNoLKVDceKj
	 /hTqyur6pK4Y2+Z+OWLXZX2g=
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eed7bdff0so91711825ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434461; x=1761039261;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBL4UdMT5NMKXetc48TxKCq//fpeAujD6S0Wp3+3ewc=;
        b=AiEmITiP2bqcu3pijG2RHEya8rwg9Ju6NL5h96p5Ft8Mtq97S4EsEvTysyA+QJbF6W
         3J9gt6Bjtw4Y9a/Onsy7Inh5Q4CofpGC69B7wIhLqCW0Jm3zDD8aZN+zIg6IfvtQTd6V
         2oE+9k9+kwcY6+qoD0V1ScAsGQ+qaOBJEU6i+EXPlQ63DHUM1VhiBoaZdgI0leO10Kik
         YQe/Gx6Tcszqv9V9uB7UId8Qa5euL6WPfIjclMLDWfztkLoDByOl/la8AQKqB4uvJIly
         6p8FSqvwlI3p8cMXozecWyycHanaOQJOon5yMUokZcbQjRTbODz4OeRxAj1uUMeMGAxn
         qt0A==
X-Forwarded-Encrypted: i=1; AJvYcCWJLiMeo/q2lbhrwXs+fvcdtEG7O5w55zkMjb352BSaPmKYFAR4l94QUUjS36J6vFKTN25Vy6C78zTUM8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oWusFxNOu/uOyP9sQsX+Dmx89CnKB7IP4JSAfjdVs1uBxYSr
	BlZg3kB+QLhivflVBiAUNETOtZ7doUvevMdTB2wC7KvLtTJSpN8GO5kGVlkuX2qfRrYZgInOXeQ
	hvPAbSskSzRp1doWV2aomA1k8EPXV0XCEpTlHPtrnIf27yafwmAOoQwFy9SsK3XeXAV9CMccjoJ
	Ulc3zs9g==
X-Gm-Gg: ASbGnctfENMilR0ZDOKQOXQkVWZ0EiXq191xM2yo3PzXzI9/MZbieUfdBfENhlGSW4L
	LKmf2qvtl2cwDkIOFYBltohd1q6HEtB+ftMnJnisvBf+ltz9kZDDz+/jzeVAO0gWZg5dQHNpYop
	9nPzf0KlyEd5trupLZUZuRV04X1CDOrVZd97aADM0nB385ae7psIojDav6vpBT5hzgrMAbOXabl
	FmT7FnBfJCbk82LIzoz+htyYJShGaXQbdsamU2Gnm8J6gBL8aa1mZpviiE/Ey1x3/lANOIWvKLr
	Zz2Oe6e3S8rDvw86/EjK+YkCmXuLb3k/WfprybMKGbbns9mn
X-Received: by 2002:a17:903:2c0f:b0:266:57f7:25f5 with SMTP id d9443c01a7336-28ec9c272b4mr365703385ad.7.1760434460613;
        Tue, 14 Oct 2025 02:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1/eZpcCa1YiTEXnTlt8Ed3BswUI0eJyHL6NAs6yF4ooP22ANxdj2r0VNdYqhsgMgHgcP8dg==
X-Received: by 2002:a17:903:2c0f:b0:266:57f7:25f5 with SMTP id d9443c01a7336-28ec9c272b4mr365703005ad.7.1760434460092;
        Tue, 14 Oct 2025 02:34:20 -0700 (PDT)
Received: from acelan-precision5470 ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362efsm159582725ad.89.2025.10.14.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:34:19 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:34:05 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Andrei Kuchynski <akuchynski@chromium.org>, 
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, Venkat Jayaraman <venkat.jayaraman@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix workqueue destruction race during
 connector cleanup
Message-ID: <xqxkwf6se64yppiwqe5nwkc5tpumxb4rw3bb4g7q346u7zj2da@omdcvtnljntm>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Andrei Kuchynski <akuchynski@chromium.org>, 
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, Venkat Jayaraman <venkat.jayaraman@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002013026.4095030-1-acelan.kao@canonical.com>
 <aOY-OyN90DScHr85@kuha.fi.intel.com>
 <dr5dderec7diwlsiu7n5vziotw4lnnkletyy7hb55miosrdiy7@oy3nqplgcv6s>
 <aOfB9bdEzlxPFzhg@kuha.fi.intel.com>
 <o64vjcwwb7qxj2re2jyho32edblfwjvyttitiot2f2sl2gnzhb@aybmrxw6citf>
 <aOz34fBN4z-Zuvnp@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOz34fBN4z-Zuvnp@kuha.fi.intel.com>

On Mon, Oct 13, 2025 at 04:00:17PM +0300, Heikki Krogerus wrote:
> On Sun, Oct 12, 2025 at 10:00:03PM +0800, Chia-Lin Kao (AceLan) wrote:
> > On Thu, Oct 09, 2025 at 05:08:53PM +0300, Heikki Krogerus wrote:
> > > On Thu, Oct 09, 2025 at 09:58:22AM +0800, Chia-Lin Kao (AceLan) wrote:
> > > > On Wed, Oct 08, 2025 at 01:34:35PM +0300, Heikki Krogerus wrote:
> > > > > On Thu, Oct 02, 2025 at 09:30:26AM +0800, Chia-Lin Kao (AceLan) wrote:
> > > > > > During UCSI initialization and operation, there is a race condition where
> > > > > > delayed work items can be scheduled but attempt to queue work after the
> > > > > > workqueue has been destroyed. This occurs in multiple code paths.
> > > > > > 
> > > > > > The race occurs when:
> > > > > > 1. ucsi_partner_task() or ucsi_poll_worker() schedule delayed work
> > > > > > 2. Connector cleanup paths call destroy_workqueue()
> > > > > > 3. Previously scheduled delayed work timers fire after destruction
> > > > > > 4. This triggers warnings and crashes in __queue_work()
> > > > > 
> > > > > What warnings?
> > > > Here is what I got.
> > > > 
> > > > Sep 24 13:24:22 ubuntu kernel: sysfs: cannot create duplicate filename '/devices/platform/USBC000:00/typec/port0/port0.0/partner'
> > > > Sep 24 13:24:22 ubuntu kernel: CPU: 1 UID: 0 PID: 132 Comm: kworker/u64:1 Tainted: G           O       6.14.0-1012-oem #12-Ubuntu
> > > > Sep 24 13:24:22 ubuntu kernel: Tainted: [O]=OOT_MODULE
> > > > Sep 24 13:24:22 ubuntu kernel: Hardware name: Dell Inc. Dell /, BIOS XXXX XX/XX/2025
> > > > Sep 24 13:24:22 ubuntu kernel: Workqueue: USBC000:00-con1 ucsi_poll_worker [typec_ucsi]
> > > > Sep 24 13:24:22 ubuntu kernel: Call Trace:
> > > > Sep 24 13:24:22 ubuntu kernel:  <TASK>
> > > > Sep 24 13:24:22 ubuntu kernel:  dump_stack_lvl+0x76/0xa0
> > > > Sep 24 13:24:22 ubuntu kernel:  dump_stack+0x10/0x20
> > > > Sep 24 13:24:22 ubuntu kernel:  sysfs_warn_dup+0x8a/0xb0
> > > > Sep 24 13:24:22 ubuntu kernel:  sysfs_do_create_link_sd+0xf1/0x100
> > > > Sep 24 13:24:22 ubuntu kernel:  sysfs_create_link+0x21/0x50
> > > > Sep 24 13:24:22 ubuntu kernel:  typec_probe+0x7e/0x100 [typec]
> > > > Sep 24 13:24:22 ubuntu kernel:  ? driver_sysfs_add+0x66/0xd0
> > > > Sep 24 13:24:22 ubuntu kernel:  really_probe+0xee/0x3c0
> > > > Sep 24 13:24:22 ubuntu kernel:  __driver_probe_device+0x8c/0x180
> > > > Sep 24 13:24:22 ubuntu kernel:  driver_probe_device+0x24/0xd0
> > > > Sep 24 13:24:22 ubuntu kernel:  __device_attach_driver+0xcd/0x170
> > > > Sep 24 13:24:22 ubuntu kernel:  ? _pfx__device_attach_driver+0x10/0x10
> > > > Sep 24 13:24:22 ubuntu kernel:  bus_for_each_drv+0x94/0xf0
> > > > Sep 24 13:24:22 ubuntu kernel:  __device_attach+0xb6/0x1d0
> > > > Sep 24 13:24:22 ubuntu kernel:  device_initial_probe+0x13/0x20
> > > > Sep 24 13:24:22 ubuntu kernel:  bus_probe_device+0x9f/0xb0
> > > > Sep 24 13:24:22 ubuntu kernel:  device_add+0x513/0x710
> > > > Sep 24 13:24:22 ubuntu kernel:  device_register+0x1a/0x30
> > > > Sep 24 13:24:22 ubuntu kernel:  typec_register_altmode+0x253/0x3a0 [typec]
> > > > Sep 24 13:24:22 ubuntu kernel:  typec_partner_register_altmode+0xe/0x20 [typec]
> > > > Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmode.constprop.0+0x30e/0x390 [typec_ucsi]
> > > > Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmodes+0x162/0x250 [typec_ucsi]
> > > > Sep 24 13:24:22 ubuntu kernel:  ucsi_check_altmodes+0x19/0xb0 [typec_ucsi]
> > > > Sep 24 13:24:22 ubuntu kernel:  ucsi_poll_worker+0x3d/0xf0 [typec_ucsi]
> > > > Sep 24 13:24:22 ubuntu kernel:  process_one_work+0x178/0x3d0
> > > > Sep 24 13:24:22 ubuntu kernel:  worker_thread+0x2de/0x410
> > > > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_worker_thread+0x10/0x10
> > > > Sep 24 13:24:22 ubuntu kernel:  kthread+0xfb/0x230
> > > > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> > > > Sep 24 13:24:22 ubuntu kernel:  ret_from_fork+0x44/0x70
> > > > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> > > > Sep 24 13:24:22 ubuntu kernel:  ret_from_fork_asm+0x1a/0x30
> > > > Sep 24 13:24:22 ubuntu kernel:  </TASK>
> > > > Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: failed to create symlinks
> > > > Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> > > 
> > > That does not look like anything you described in the commit message?
> > > 
> > > You have there an attempt to register the same alternate mode twice,
> > > but the workqueue seems to be very much alive when that happens.
> > > 
> > > Based on the above this looks like either a race where the driver
> > > really ends up registering the alternate modes multiple times or, and
> > > more likely, the firmware is reporting the same alternate mode
> > > multiple times.
> > > 
> > > Or am I missing something?
> > Here is another one. It's not immediately obvious how this one relates to typec_ucsi.
> > 
> > [  170.605181] ucsi_acpi USBC000:00: con2: failed to register alt modes
> > [  181.868900] ------------[ cut here ]------------
> > [  181.868905] workqueue: cannot queue ucsi_poll_worker [typec_ucsi] on wq USBC000:00-con1
> > [  181.868918] WARNING: CPU: 1 PID: 0 at kernel/workqueue.c:2255 __queue_work+0x420/0x5a0
> > ...
> > [  181.869062] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc7+ #1 PREEMPT(voluntary)
> > [  181.869065] Hardware name: Dell Inc. , BIOS xx.xx.xx xx/xx/2025
> > [  181.869067] RIP: 0010:__queue_work+0x420/0x5a0
> > [  181.869070] Code: 00 00 41 83 e4 01 0f 85 57 fd ff ff 49 8b 77 18 48 8d 93 c0 00 00 00 48 c7 c7 00 8c bc 92 c6 05 27 47 68 02 01 e8 50 24 fd f
> > f <0f> 0b e9 32 fd ff ff 0f 0b e9 1d fd ff ff 0f 0b e9 0f fd ff ff 0f
> > [  181.869072] RSP: 0018:ffffd53c000acdf8 EFLAGS: 00010046
> > [  181.869075] RAX: 0000000000000000 RBX: ffff8ecd0727f200 RCX: 0000000000000000
> > [  181.869076] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [  181.869077] RBP: ffffd53c000ace38 R08: 0000000000000000 R09: 0000000000000000
> > [  181.869078] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [  181.869079] R13: ffffffff913995e0 R14: ffff8ecc824387a0 R15: ffff8ecc82438780
> > [  181.869081] FS:  0000000000000000(0000) GS:ffff8eec0b92f000(0000) knlGS:0000000000000000
> > [  181.869083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  181.869084] CR2: 000005593e67a008 CR3: 0000001f41840002 CR4: 0000000000f72ef0
> > [  181.869086] PKRU: 55555554
> > [  181.869087] Call Trace:
> > [  181.869089]  <IRQ>
> > [  181.869093]  ? sched_clock+0x10/0x30
> > [  181.869098]  ? __pfx_delayed_work_timer_fn+0x10/0x10
> > [  181.869100]  delayed_work_timer_fn+0x19/0x30
> > [  181.869102]  call_timer_fn+0x2c/0x150
> > [  181.869106]  ? __pfx_delayed_work_timer_fn+0x10/0x10
> > [  181.869108]  __run_timers+0x1c6/0x2d0
> > [  181.869111]  run_timer_softirq+0x8a/0x100
> > [  181.869114]  handle_softirqs+0xe4/0x340
> > [  181.869118]  __irq_exit_rcu+0x10e/0x130
> > [  181.869121]  irq_exit_rcu+0xe/0x20
> > [  181.869124]  sysvec_apic_timer_interrupt+0xa0/0xc0
> > [  181.869130]  </IRQ>
> > [  181.869131]  <TASK>
> > [  181.869132]  asm_sysvec_apic_timer_interrupt+0x1b/0x20                                                                                        [  181.869135] RIP: 0010:cpuidle_enter_state+0xda/0x710
> > [  181.869137] Code: 8f f7 fe e8 78 f0 ff ff 8b 53 04 49 89 c7 0f 1f 44 00 00 31 ff e8 86 bf f5 fe 80 7d d0 00 0f 85 22 02 00 00 fb 0f 1f 44 00 0
> > 0 <45> 85 f6 0f 88 f2 01 00 00 4d 63 ee 49 83 fd 0a 0f 83 d8 04 00 00
> > [  181.869139] RSP: 0018:ffffd53c0022be18 EFLAGS: 00000246
> > [  181.869140] RAX: 0000000000000000 RBX: ffff8eeb9f8bf880 RCX: 0000000000000000
> > [  181.869142] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> > [  181.869143] RBP: ffffd53c0022be68 R08: 0000000000000000 R09: 0000000000000000
> > [  181.869144] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff93914780
> > [  181.869145] R13: 0000000000000002 R14: 0000000000000002 R15: 0000002a583b0b41
> > [  181.869148]  ? cpuidle_enter_state+0xca/0x710
> > [  181.869151]  cpuidle_enter+0x2e/0x50
> > [  181.869156]  call_cpuidle+0x22/0x60
> > [  181.869160]  do_idle+0x1dc/0x240
> > [  181.869163]  cpu_startup_entry+0x29/0x30
> > [  181.869164]  start_secondary+0x128/0x160
> > [  181.869167]  common_startup_64+0x13e/0x141
> > [  181.869171]  </TASK>
> > [  181.869172] ---[ end trace 0000000000000000 ]---
> > [  226.924460] workqueue USBC000:00-con1: drain_workqueue() isn't complete after 10 tries
> > [  329.470977] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> 
> Okay, so to me it looks like there are two separate issues here.
Yes, there are 2 issues.
> 
> The first one looks like an EC (or PD controller) firmware related
> issue, where the response to the GET_ALTERNATE_MODES command is
> getting corrupted for some reason, and second is this race that you
> see as a consequence from the first FW related issue.
> 
> So this patch is for the second issue - the race. I'll wait for the v2
> from you guys. But I want to solve both issues.
Here is v2 https://lkml.org/lkml/2025/10/13/312

And I have a patch to fix the second issue, will submit it later.
> 
> thanks,
> 
> -- 
> heikki

