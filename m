Return-Path: <linux-kernel+bounces-849467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84EBD0303
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A873A9250
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20631274B57;
	Sun, 12 Oct 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="UQKCNHFJ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87B1C861E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277630; cv=none; b=oXsO1RZdAdtDss9zMaV5zFsXmpyHxGW9tMJiYQPXy+Aqd5+MDHAkYzMbFg21Wm7+TdOUf0THOOrGKz342LJgcEPkEBofI35dEPyyG6sTSs+WCTfdZzBaggaJ+XRqA/LgWNLpgYR1THRcjmnqW0Kb7qmhADAB8Uv+aESsn8cgpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277630; c=relaxed/simple;
	bh=ZM71+7V/tLJb4pWyImSbisg9MTh/1jsmdRT9OdpEOlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbRuuLvQHC3f1QmJg+8Sz85Upa4Dq9Sm/jHn66Pa04ZUORcbO58OrimhfXsX+3EW8qRzNBcuo2sv5LMQn+VZCu0Lh8iuZ64iw33RqO60DFy6Q0mzhAiHcfJr59gNQuCwDBfzLfxH79vJn+SIZ/7k5nU9g25NICWDKoA5m4LzBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=UQKCNHFJ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61AE93F2C5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760277620;
	bh=SzVFz1p5CqGIWMfH5kqx8WbSk5FnKQ4DWMs0lS9VkAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=UQKCNHFJGsYZU0gFx4/+vxjylO+fErcrGmJ7jXtoOC25BP+Nv1+/8xySQ3aFIMLWq
	 +DBbuCNp+XZ/FVWhWQtsI6hs7FpO73cz4ReoZr2wzdTbVc3kclSYVTQGCdgCWhivos
	 1P931AeZjnG2NOuDEyTwqyMKpKmXfprxzkNvfinrW8dqyF3GPRIdDj1M9tbMvoYGm0
	 HbUQjuHrpAEZ2ZHe0BKmFwB6UbJLUm/aMVOI8IwUxVCh6PGvK142WeeAoG6NH6TDy5
	 mDzhGsdZ3UG91+MbBc+3Nt6P32d3m55lE4L0a8Lt8hf5f3FELasWSBsuCJAiKCDiiC
	 jYQO6jKKQXyp4XP10CEmUrrrQ0Y3yd0v+BIuZJDfxnSku7iaifDvHAEDj/2f5d9mLt
	 DVQiP94SSp9M52rFso9jvfcCt2Ybja9g172xlYEAmwDYkYeiN5XcIyhpjyBghAoZOv
	 /FkvwA+wryKiK6hM8YRbrlwYtjfBR4ge5lfgSKLMHJpQGdapM+/dOTa6uq/SVd0VFH
	 SchYHGxfuIoftEDNqVNiwJed+BWE/c/UK+1625CVw5s1FgKxwfWmnCXPug7vRAtyxr
	 F5h4ZLJJrv69zJFBw9B5Gz7hHccugNVP+Kn6RIpz8TV7n41GK6DJADTS5fIz9djNtT
	 DF4rXuA1D9lC6RZJukSBrYkc=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3307af9b595so7396024a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760277619; x=1760882419;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzVFz1p5CqGIWMfH5kqx8WbSk5FnKQ4DWMs0lS9VkAU=;
        b=J47WvqbUO4DA36AksVl8IMwql33qOAlzFuBj9sjrjy0tO+RILi26SQbHG5fD4Rj/SK
         M+Z8VeSmftFevFg+1hr7ocj6/1AxYJguyIVHXhA+pzLEDSxp7LtJimn+vqbv7+gu20nE
         oB5tQ+9DlZ/0Cyunz5bVPaPpMxEmMHKD4PIdzKU9J8vDbQsHHV6RV7zrYQbOpRhJX50D
         qMW2qzlOiINmBjRtobzDfudzB4Y/pBhs7lxaUw850HP2r/t8nTehZz+JOBWND3wrahpw
         hrcpdNoX9pK2mGZhnGZJNkNBZtt0sAJb6nlExwVj4tnrfxrawmFLIS9a/6hQT/jtJF/n
         51MA==
X-Forwarded-Encrypted: i=1; AJvYcCVDP9o5rSYunGfUTlSyXG1w/K4ia3cxqsnNHkNdpZTLdAKUDoX1AeLnPc4Eq3cdzViLDsZPylNyXEC+ujw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgP8TemfmZCvPLot3PjlsHs18fKC9xCO+EBZlDbRlM4r28fzD3
	yVH2ZtmkXjfRxHlgyMoxp5BKXkozphtPapfzZN1s4pE8b848tbuOI2dVIVInH7ZC7EUnPsD8w6X
	izrxo9M5V0MADev+yjTWO50hyXm7RpHX2jXRIoxKCrOE2R88uso4p8p61vgSooG7n5WmjeQdxlw
	ogwFdjpw==
X-Gm-Gg: ASbGncudi5qSXcE3zj94qBSgG7Lvxk76wf7kIagrmspW2h3xIfa1bak8+MgvTWFo3WM
	1oDl/7KeFETXB9oseNUb+QcS6D3CrgTpgk2aAngf08Li5lMCdtWzaM2AuIR+EuNxcxhRx+b7woa
	QYEypxVo3WmXikF2BwrVs8iEVGUQJjUOoOvNYSw+hvR2BAomu8YWulK100VvpdeupGz8N3SUfTJ
	AAS4F0fmFKZdg/H+j/aeoLyQuAqTZPzFAzi5NIeZm7e5j8Mv6Tpkp4F1mxe1SWYqYQ+N9KRhNl4
	3Q7FwkukKc3YN8D0ErnNbporplGQU9jHsbVMyMiVaQ1FTECZ
X-Received: by 2002:a17:90b:4d07:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-33b513ea08amr24332161a91.36.1760277618487;
        Sun, 12 Oct 2025 07:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7AO+w/82WyNVXqK3YiOKaPTdDBumLi6AQ6LVltPZ/6gUZCaUBj04PQdyI7HY4YPD0l3r5A==
X-Received: by 2002:a17:90b:4d07:b0:32e:3830:65d5 with SMTP id 98e67ed59e1d1-33b513ea08amr24332008a91.36.1760277616385;
        Sun, 12 Oct 2025 07:00:16 -0700 (PDT)
Received: from acelan-precision5470 ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626e94aasm8680707a91.24.2025.10.12.07.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:00:15 -0700 (PDT)
Date: Sun, 12 Oct 2025 22:00:03 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Andrei Kuchynski <akuchynski@chromium.org>, 
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, Venkat Jayaraman <venkat.jayaraman@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix workqueue destruction race during
 connector cleanup
Message-ID: <o64vjcwwb7qxj2re2jyho32edblfwjvyttitiot2f2sl2gnzhb@aybmrxw6citf>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Andrei Kuchynski <akuchynski@chromium.org>, 
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, Venkat Jayaraman <venkat.jayaraman@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002013026.4095030-1-acelan.kao@canonical.com>
 <aOY-OyN90DScHr85@kuha.fi.intel.com>
 <dr5dderec7diwlsiu7n5vziotw4lnnkletyy7hb55miosrdiy7@oy3nqplgcv6s>
 <aOfB9bdEzlxPFzhg@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOfB9bdEzlxPFzhg@kuha.fi.intel.com>

On Thu, Oct 09, 2025 at 05:08:53PM +0300, Heikki Krogerus wrote:
> On Thu, Oct 09, 2025 at 09:58:22AM +0800, Chia-Lin Kao (AceLan) wrote:
> > On Wed, Oct 08, 2025 at 01:34:35PM +0300, Heikki Krogerus wrote:
> > > On Thu, Oct 02, 2025 at 09:30:26AM +0800, Chia-Lin Kao (AceLan) wrote:
> > > > During UCSI initialization and operation, there is a race condition where
> > > > delayed work items can be scheduled but attempt to queue work after the
> > > > workqueue has been destroyed. This occurs in multiple code paths.
> > > > 
> > > > The race occurs when:
> > > > 1. ucsi_partner_task() or ucsi_poll_worker() schedule delayed work
> > > > 2. Connector cleanup paths call destroy_workqueue()
> > > > 3. Previously scheduled delayed work timers fire after destruction
> > > > 4. This triggers warnings and crashes in __queue_work()
> > > 
> > > What warnings?
> > Here is what I got.
> > 
> > Sep 24 13:24:22 ubuntu kernel: sysfs: cannot create duplicate filename '/devices/platform/USBC000:00/typec/port0/port0.0/partner'
> > Sep 24 13:24:22 ubuntu kernel: CPU: 1 UID: 0 PID: 132 Comm: kworker/u64:1 Tainted: G           O       6.14.0-1012-oem #12-Ubuntu
> > Sep 24 13:24:22 ubuntu kernel: Tainted: [O]=OOT_MODULE
> > Sep 24 13:24:22 ubuntu kernel: Hardware name: Dell Inc. Dell /, BIOS XXXX XX/XX/2025
> > Sep 24 13:24:22 ubuntu kernel: Workqueue: USBC000:00-con1 ucsi_poll_worker [typec_ucsi]
> > Sep 24 13:24:22 ubuntu kernel: Call Trace:
> > Sep 24 13:24:22 ubuntu kernel:  <TASK>
> > Sep 24 13:24:22 ubuntu kernel:  dump_stack_lvl+0x76/0xa0
> > Sep 24 13:24:22 ubuntu kernel:  dump_stack+0x10/0x20
> > Sep 24 13:24:22 ubuntu kernel:  sysfs_warn_dup+0x8a/0xb0
> > Sep 24 13:24:22 ubuntu kernel:  sysfs_do_create_link_sd+0xf1/0x100
> > Sep 24 13:24:22 ubuntu kernel:  sysfs_create_link+0x21/0x50
> > Sep 24 13:24:22 ubuntu kernel:  typec_probe+0x7e/0x100 [typec]
> > Sep 24 13:24:22 ubuntu kernel:  ? driver_sysfs_add+0x66/0xd0
> > Sep 24 13:24:22 ubuntu kernel:  really_probe+0xee/0x3c0
> > Sep 24 13:24:22 ubuntu kernel:  __driver_probe_device+0x8c/0x180
> > Sep 24 13:24:22 ubuntu kernel:  driver_probe_device+0x24/0xd0
> > Sep 24 13:24:22 ubuntu kernel:  __device_attach_driver+0xcd/0x170
> > Sep 24 13:24:22 ubuntu kernel:  ? _pfx__device_attach_driver+0x10/0x10
> > Sep 24 13:24:22 ubuntu kernel:  bus_for_each_drv+0x94/0xf0
> > Sep 24 13:24:22 ubuntu kernel:  __device_attach+0xb6/0x1d0
> > Sep 24 13:24:22 ubuntu kernel:  device_initial_probe+0x13/0x20
> > Sep 24 13:24:22 ubuntu kernel:  bus_probe_device+0x9f/0xb0
> > Sep 24 13:24:22 ubuntu kernel:  device_add+0x513/0x710
> > Sep 24 13:24:22 ubuntu kernel:  device_register+0x1a/0x30
> > Sep 24 13:24:22 ubuntu kernel:  typec_register_altmode+0x253/0x3a0 [typec]
> > Sep 24 13:24:22 ubuntu kernel:  typec_partner_register_altmode+0xe/0x20 [typec]
> > Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmode.constprop.0+0x30e/0x390 [typec_ucsi]
> > Sep 24 13:24:22 ubuntu kernel:  ucsi_register_altmodes+0x162/0x250 [typec_ucsi]
> > Sep 24 13:24:22 ubuntu kernel:  ucsi_check_altmodes+0x19/0xb0 [typec_ucsi]
> > Sep 24 13:24:22 ubuntu kernel:  ucsi_poll_worker+0x3d/0xf0 [typec_ucsi]
> > Sep 24 13:24:22 ubuntu kernel:  process_one_work+0x178/0x3d0
> > Sep 24 13:24:22 ubuntu kernel:  worker_thread+0x2de/0x410
> > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_worker_thread+0x10/0x10
> > Sep 24 13:24:22 ubuntu kernel:  kthread+0xfb/0x230
> > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> > Sep 24 13:24:22 ubuntu kernel:  ret_from_fork+0x44/0x70
> > Sep 24 13:24:22 ubuntu kernel:  ? __pfx_kthread+0x10/0x10
> > Sep 24 13:24:22 ubuntu kernel:  ret_from_fork_asm+0x1a/0x30
> > Sep 24 13:24:22 ubuntu kernel:  </TASK>
> > Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: failed to create symlinks
> > Sep 24 13:24:22 ubuntu kernel: typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> 
> That does not look like anything you described in the commit message?
> 
> You have there an attempt to register the same alternate mode twice,
> but the workqueue seems to be very much alive when that happens.
> 
> Based on the above this looks like either a race where the driver
> really ends up registering the alternate modes multiple times or, and
> more likely, the firmware is reporting the same alternate mode
> multiple times.
> 
> Or am I missing something?
Here is another one. It's not immediately obvious how this one relates to typec_ucsi.

[  170.605181] ucsi_acpi USBC000:00: con2: failed to register alt modes
[  181.868900] ------------[ cut here ]------------
[  181.868905] workqueue: cannot queue ucsi_poll_worker [typec_ucsi] on wq USBC000:00-con1
[  181.868918] WARNING: CPU: 1 PID: 0 at kernel/workqueue.c:2255 __queue_work+0x420/0x5a0
...
[  181.869062] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc7+ #1 PREEMPT(voluntary)
[  181.869065] Hardware name: Dell Inc. , BIOS xx.xx.xx xx/xx/2025
[  181.869067] RIP: 0010:__queue_work+0x420/0x5a0
[  181.869070] Code: 00 00 41 83 e4 01 0f 85 57 fd ff ff 49 8b 77 18 48 8d 93 c0 00 00 00 48 c7 c7 00 8c bc 92 c6 05 27 47 68 02 01 e8 50 24 fd f
f <0f> 0b e9 32 fd ff ff 0f 0b e9 1d fd ff ff 0f 0b e9 0f fd ff ff 0f
[  181.869072] RSP: 0018:ffffd53c000acdf8 EFLAGS: 00010046
[  181.869075] RAX: 0000000000000000 RBX: ffff8ecd0727f200 RCX: 0000000000000000
[  181.869076] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  181.869077] RBP: ffffd53c000ace38 R08: 0000000000000000 R09: 0000000000000000
[  181.869078] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  181.869079] R13: ffffffff913995e0 R14: ffff8ecc824387a0 R15: ffff8ecc82438780
[  181.869081] FS:  0000000000000000(0000) GS:ffff8eec0b92f000(0000) knlGS:0000000000000000
[  181.869083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.869084] CR2: 000005593e67a008 CR3: 0000001f41840002 CR4: 0000000000f72ef0
[  181.869086] PKRU: 55555554
[  181.869087] Call Trace:
[  181.869089]  <IRQ>
[  181.869093]  ? sched_clock+0x10/0x30
[  181.869098]  ? __pfx_delayed_work_timer_fn+0x10/0x10
[  181.869100]  delayed_work_timer_fn+0x19/0x30
[  181.869102]  call_timer_fn+0x2c/0x150
[  181.869106]  ? __pfx_delayed_work_timer_fn+0x10/0x10
[  181.869108]  __run_timers+0x1c6/0x2d0
[  181.869111]  run_timer_softirq+0x8a/0x100
[  181.869114]  handle_softirqs+0xe4/0x340
[  181.869118]  __irq_exit_rcu+0x10e/0x130
[  181.869121]  irq_exit_rcu+0xe/0x20
[  181.869124]  sysvec_apic_timer_interrupt+0xa0/0xc0
[  181.869130]  </IRQ>
[  181.869131]  <TASK>
[  181.869132]  asm_sysvec_apic_timer_interrupt+0x1b/0x20                                                                                        [  181.869135] RIP: 0010:cpuidle_enter_state+0xda/0x710
[  181.869137] Code: 8f f7 fe e8 78 f0 ff ff 8b 53 04 49 89 c7 0f 1f 44 00 00 31 ff e8 86 bf f5 fe 80 7d d0 00 0f 85 22 02 00 00 fb 0f 1f 44 00 0
0 <45> 85 f6 0f 88 f2 01 00 00 4d 63 ee 49 83 fd 0a 0f 83 d8 04 00 00
[  181.869139] RSP: 0018:ffffd53c0022be18 EFLAGS: 00000246
[  181.869140] RAX: 0000000000000000 RBX: ffff8eeb9f8bf880 RCX: 0000000000000000
[  181.869142] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
[  181.869143] RBP: ffffd53c0022be68 R08: 0000000000000000 R09: 0000000000000000
[  181.869144] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff93914780
[  181.869145] R13: 0000000000000002 R14: 0000000000000002 R15: 0000002a583b0b41
[  181.869148]  ? cpuidle_enter_state+0xca/0x710
[  181.869151]  cpuidle_enter+0x2e/0x50
[  181.869156]  call_cpuidle+0x22/0x60
[  181.869160]  do_idle+0x1dc/0x240
[  181.869163]  cpu_startup_entry+0x29/0x30
[  181.869164]  start_secondary+0x128/0x160
[  181.869167]  common_startup_64+0x13e/0x141
[  181.869171]  </TASK>
[  181.869172] ---[ end trace 0000000000000000 ]---
[  226.924460] workqueue USBC000:00-con1: drain_workqueue() isn't complete after 10 tries
[  329.470977] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

> 
> thanks,
> 
> -- 
> heikki

