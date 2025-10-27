Return-Path: <linux-kernel+bounces-870930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AEC0C000
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C60A189B9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E02BE7D2;
	Mon, 27 Oct 2025 06:54:28 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CF29E110
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548068; cv=none; b=rdeRbKdA/ReMeFSTjUDRscSuK5W1cgiafSWvvLJ1OGkQALGbj4JQk8obn+oERR8Ue4u4x23rV1ctq0ZSn4JFQazmIqV3lqAb6GKmhGOj0ekvTpQWpDixdCiRm6+02pZ+lFKjaO5smfKK+7NxB2ZtN1wlLll7uKRitsD4z5y0R3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548068; c=relaxed/simple;
	bh=mUpMk+2KzSM3LgyuKinDbeu4n+ch3liL0DKEIyu00ng=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LdIzjvxsgC2B25ePT7v//i+9YM6mZZid+kNLYh4Fm4C4MAP4hX6OeWkAxtIocdN/WlbqhdLOWX15+DI5VPYFoSEt7VOrQ8tC0IP++V0mNKTdeWFSlI7WXrWWT5Nr515BpKf/JJhNk4EcPLU3LCdN31Em3TXIjuTogZhVq5IJAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso1093783a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761548066; x=1762152866;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVKmLdguS7AfOuEMfq4aVZJS4TeMKkPMqGxNG1TyXBU=;
        b=lutIb/z2/2WeV25n3PelMnnsUcw5zNph6MITio6fiTsqqfAwCR5zVLXw+WixDUGAon
         LbESCfFIHRO0T1oNdK27dzqCAV7TnMt59BGBrJMRu7Xn6crio40r82jx3P2E/COdWhQu
         0A8Qh6qRo4cA31y5vJiYDi2MH8hnAcWrkRyPPqIwEZ+aktlb4ozLsS7Q4MV2ljfjXzwg
         ZF50FeXK0iKfCE/iKYtcFi75nYXQEUtl7n8WAG3W1s2nDPDsYXN9oQgeVxKBw6yQHXKr
         zKRd4daHFUknGstZvoBz7lY3BvsmvyCgRglf98N+VTT2gXIkMJreEO5sAkgkrwcfmbJ/
         BySg==
X-Forwarded-Encrypted: i=1; AJvYcCVJEywaegll51eSzGk0parSF+FB5joZW+KX2wo5WIfjKGaUq8qeXvJLMzz3o/rll9qwFzUGwSRPC9i6QVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6enMDQK8uODzG6XjZfUvpUQKo/32cTOPr2Tesm67UVD/Z7VP
	V4Po6zOX4Oi8K4klQRGs9NSNU5uKeyna7G7x/rn/iZ6AFzJ/YkZ7ObIg
X-Gm-Gg: ASbGnctZHKMgZevDpjLCNvaKTu21n3x9Hxbjxy7S7VdpNft4H+ovemSUw+uZvZQ0LxZ
	m6/egdZwovcqJxmsq8t+hryiNuBrkJkxCnqNo+olKvdewts3PmiwjlWc85kPL2utLBMikAL1nh7
	2AefPhGnPru6tosxETsZkzFJQSOkKf+fuR8Ku7OvcsKoU96httJfkFmfsPhuG56JQgxfMu4BV7B
	WU1MRrU8aq3zGu7igt7pl931dBN5cgksBx6Y1QKw7QqvPKyi6GaEBW94UKa04RbuM5sX0yxc5It
	bjaKAbQiWScQRemPEL4QK20XjmmzZi7kWOWVMN3jM6oN6/vHrnivz7nRGQIjkFBClskgGx6BI5Y
	+JKiorsWppswVIvRiCGaSsFwcSWPZToTvp39J19iK0aNTZbB4kSgCRH3hBcMZOvdgySpLRDBASR
	ukW4uz9BvnN4APqUPkWqjXkbp+RA==
X-Google-Smtp-Source: AGHT+IEnRBGDjtpkNuiU1iBSvNffsGVDA18gA44ZAZi+2gUhs2nqIUnhGs0/F+96E0WjTLYJtu5vWw==
X-Received: by 2002:a17:90b:3811:b0:33d:ad3d:1a6f with SMTP id 98e67ed59e1d1-33dfabfb168mr13977735a91.8.1761548065894;
        Sun, 26 Oct 2025 23:54:25 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm7272685a91.19.2025.10.26.23.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 23:54:25 -0700 (PDT)
Message-ID: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
Date: Mon, 27 Oct 2025 15:54:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nam,

I've been very interested in RV (Runtime Verification) to proactively detect
"sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm looking
for ways to find cases where sleeping spinlocks or memory allocations are used
within preemption-disabled or irq-disabled contexts. While searching for
solutions, I discovered the RV subsystem.

I've tested with it as follows, and I have a few questions.

# cat /sys/kernel/tracing/rv/available_monitors
wwnr
rtapp
rtapp:sleep

# cat /sys/kernel/tracing/rv/available_reactors
nop
printk
panic

# echo printk > /sys/kernel/tracing/rv/monitors/rtapp/sleep/reactors

# cat /sys/kernel/tracing/rv/monitors/rtapp/sleep/enable
1

# echo rtapp:sleep > /sys/kernel/tracing/rv/enabled_monitors

> [192735.309072] [   T6957] rv: sleep: multipathd[6957]: violation detected

# echo panic > /sys/kernel/tracing/rv/monitors/rtapp/sleep/reactors

> [ T6957] Kernel panic - not syncing: rv: sleep: multipathd[6957]: violation detected
> [193521.768666][ T6957] CPU: 4 UID: 0 PID: 6957 Comm: multipathd Not tainted 6.17.0-rc3-g39f90c196721 #1 PREEMPT_{RT,(full)}
> [193521.771727][ T6957] Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu3 10/08/2025
> [193521.774126][ T6957] Call trace:
> [193521.774998][ T6957]  show_stack+0x2c/0x3c (C)
> [193521.776281][ T6957]  __dump_stack+0x30/0x40
> [193521.777523][ T6957]  dump_stack_lvl+0x34/0x2bc
> [193521.778797][ T6957]  dump_stack+0x1c/0x48
> [193521.779984][ T6957]  vpanic+0x220/0x618
> [193521.781211][ T6957]  oom_killer_enable+0x0/0x30
> [193521.782512][ T6957]  ltl_validate+0x7ac/0xb1c
> [193521.783870][ T6957]  ltl_atom_update+0xd0/0x32c
> [193521.785198][ T6957]  handle_sched_set_state+0xb8/0x12c
> [193521.786773][ T6957]  __trace_set_current_state+0x128/0x174
> [193521.788450][ T6957]  do_nanosleep+0x128/0x2a4
> [193521.789731][ T6957]  hrtimer_nanosleep+0xb4/0x160
> [193521.791167][ T6957]  common_nsleep+0x6c/0x84
> [193521.792404][ T6957]  __arm64_sys_clock_nanosleep+0x1a8/0x1f0
> [193521.794031][ T6957]  invoke_syscall+0x64/0x168
> [193521.795353][ T6957]  el0_svc_common+0x134/0x164
> [193521.796707][ T6957]  do_el0_svc+0x2c/0x3c
> [193521.797897][ T6957]  el0_svc+0x58/0x184
> [193521.799048][ T6957]  el0t_64_sync_handler+0x84/0x12c
> [193521.800514][ T6957]  el0t_64_sync+0x1b8/0x1bc
> [193521.801818][ T6957] SMP: stopping secondary CPUs
> [193521.803320][ T6957] Dumping ftrace buffer:
> [193521.804510][ T6957]    (ftrace buffer empty)
> [193521.805848][ T6957] Kernel Offset: disabled
> [193521.807084][ T6957] CPU features: 0xc0000,00007800,149a3161,357ff667
> [193521.808941][ T6957] Memory Limit: none
> [193522.655297][ T6957] Rebooting in 86400 seconds..

Here are my questions:

1. Does the rtapp:sleep monitor proactively detect scenarios that
   could lead to sleeping in atomic context, perhaps before
   CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the actual point of
   sleeping?

2. Is there a way to enable this monitor (e.g., rtapp:sleep)
   immediately as soon as the RV subsystem is loaded during boot time?
   (How to make this "default turn on"?)

3. When a "violation detected" message occurs at runtime, is it
   possible to get a call stack of the location that triggered the
   violation? The panic reactor provides a full stack, but I'm
   wondering if this is also possible with the printk reactor.


Here is some background on why I'm so interested in this topic:

Recently, I was fuzzing the PREEMPT_RT kernel with syzkaller but ran into
issues where fuzzing wouldn't proceed smoothly. It turned out to be a problem
in the kcov USB API. This issue was fixed after I reported it, together
with Sebastian’s patch.

[PATCH] kcov, usb: Don't disable interrupts in kcov_remote_start_usb_softirq()
 - https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de/

After this fix, syzkaller fuzzing ran well and was able to detect several
runtime "sleep in atomic context" bugs:

[PATCH] USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels
 - https://lore.kernel.org/all/bb192ae2-4eee-48ee-981f-3efdbbd0d8f0@rowland.harvard.edu/

[BUG] usbip: vhci: Sleeping function called from invalid context in
vhci_urb_enqueue on PREEMPT_RT
 - https://lore.kernel.org/all/c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com/

This led me to research ways to find these issues proactively at a
static analysis level, and I created some regex and coccinelle scripts
to detect them.

[BUG] gfs2: sleeping lock in gfs2_quota_init() with preempt disabled
on PREEMPT_RT
 - https://lore.kernel.org/all/20250812103808.3mIVpgs9@linutronix.de/t/#u

[PATCH] md/raid5-ppl: Fix invalid context sleep in
ppl_io_unit_finished() on PREEMPT_RT
 - https://lore.kernel.org/all/f2dbf110-e2a7-4101-b24c-0444f708fd4e@kernel.org/t/#u

Tomas, the author of the rtlockscope project, also gave me some deep
insights into this static analysis approach.

Re: [WIP] coccinelle: rt: Add coccicheck on sleep in atomic context on
PREEMPT_RT
 - https://lore.kernel.org/all/CAP4=nvTOE9W+6UtVZ5-5gAoYeEQE8g4cgG602FJDPesNko-Bgw@mail.gmail.com/


Thank you!

Best regards,
Yunseong Kim

