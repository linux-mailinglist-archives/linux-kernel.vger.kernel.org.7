Return-Path: <linux-kernel+bounces-725814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504CB0044B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89273AFF93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6202E258CD7;
	Thu, 10 Jul 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHOJw6tU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E7272808
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155261; cv=none; b=OvyEdpKWs5qTL0nDkm6V8OMRGTjHKGQTi5fXc7z7VQiad1MgyDJDuK7Zph4nv6iEQ/PSmoxuaN0yEXnd1+E+w57rTmqCpIK4lJvyS+/10BRCfC+UhsFstkPWahVfKLkzJMj2mHECFA8Zwz5m6vSYR4JnCb8YjdScNeIBl9qyGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155261; c=relaxed/simple;
	bh=5zARiQB9AjKHAeXHFLk7UIzfAwcE3fX28JU5k9RdZHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwFVm/MrL56QEPnRlBO9avSsx/7twXIcRszljLNEUQimajdCkTyOVnQDGq3C7qHljW9rQb0XjjXx2YTXhwmtJtulPMD0NbK+BmfKjV2ynOrEAnTWJNidcD3bg8q6QAmiXIGpNTRfj+BBchE6Y/11lw/2iOE+OBZ7+G1NxVEP7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHOJw6tU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752155258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qiyb7ekbhIVIEH8y7TCHNfofyOqYh+CpcNmFmxhbC88=;
	b=FHOJw6tUib6ncNUE/k39JLviUDtKbo03DHdjMkdVVXBBsMguKRpOgzTqnz/0oMbDd+93iy
	3bFZ7/e5yJF53z3U9JEiWpsxzxxNZaN731i0olsNdrgYKKTogQEfJWaO0GE5lXMCSfb2ev
	/JHYaqWWyxLhtquTso0UKaIWalVrYXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-zApi27VVNUqX1LbWCqadzQ-1; Thu, 10 Jul 2025 09:47:36 -0400
X-MC-Unique: zApi27VVNUqX1LbWCqadzQ-1
X-Mimecast-MFC-AGG-ID: zApi27VVNUqX1LbWCqadzQ_1752155255
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so7524165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155255; x=1752760055;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qiyb7ekbhIVIEH8y7TCHNfofyOqYh+CpcNmFmxhbC88=;
        b=XRWX9/d1U79fxiAzyvSNeHu1m8VR8E/uzU5QL1mZxdXje34irlLYw9kg5WQi0XXdrK
         AtpyOjdzhsF2jch/ts+Chw/e2weSimYiluC7NRz9P8V42ag5fX0d6aD2BKQzeuTUgJ/P
         A1mq3w6uEfQ2sh+kPYUCvYrI8hNkPXyWA9GEz3GAlypRLJsrMi6P5iutYsO1IXjae3v8
         FQkH5NL9wADkmgwbKEUwhb+vNJfUYlBy4QYXrN0sh0B2mXYWHMb6a06jdxA9wfh+xv7K
         o0eAdh5HmBTH/HeMPsobt9m19QPEwSVOILqmCH7IwvfgQFSkAV15V9Pbdnx0TyDYpEVQ
         BheQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEZTowqCjcoTyBtpeJ85msdwsmPjuVQTE8qBrbZ5vMY+wKw19PyRsIqDHx4QzXtmDA3QPcSWrVbCXAy48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZjlEd3uhTfnIxKX3ptZfytFbOwckzv0DkcMO2ck+DcCuTs/T
	A0CF6gd/3Rp/cxSfYz9HTAOLbAvy8yjHhnBA3xfj0u/D/P9DiqBQ+b/WHUVwWDy6doArQL/GiIZ
	xNLqOsFaaNRolC1jyWZQTLXXsiC3IAJbdoxLtrGgI5sCSzR5Mf4CzBWbyedy+GbwQhnSLC51Vqg
	oP
X-Gm-Gg: ASbGncuS4iDUHRGSBorYzKxEqorty4Mo8uSTs5CRt1ABVs3FmWDH9YgmcUNcULp32Pa
	0fdxEo7lsg9J1irSQDeAx46tYmm+hbj8LoUCNVapJIFz3B0vGpQ35+gQQ32ZHMsFlIsVdZug8LH
	n1E1EtTYvbG9XYrIqmE0LGIpQ+FY523Q05Hvl2EYg7IymhrWHTZ3f2DjpD80FtO7Cqt2qRchEI4
	oQfn/9ci1pp6X1Cjx8e1WNY8jBG5M7NwlfNtb4lbGHcDiXPO2Tb3yGXiZjz7CyOuIy3eUCXfcQs
	xK0FfOFYpMPBCvkzh88fll6HkIHggKmx5S5aPVZMBEfw/oEV
X-Received: by 2002:a05:600c:4e44:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454dd1e808bmr29300825e9.3.1752155255096;
        Thu, 10 Jul 2025 06:47:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHXcU0PaZHKUUBYWebwFO2ejb7NMAzev5Hg03fni0d6dpXDwHAa4C7fBT29K4RBh3yERIeA==
X-Received: by 2002:a05:600c:4e44:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454dd1e808bmr29300385e9.3.1752155254483;
        Thu, 10 Jul 2025 06:47:34 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d07sm1953735f8f.66.2025.07.10.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:47:34 -0700 (PDT)
Message-ID: <a9d1a27e173c6f2aa6d5d4b94d8af5d6619b688d.camel@redhat.com>
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <oliver.sang@intel.com>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com,  Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.org>
Date: Thu, 10 Jul 2025 15:47:32 +0200
In-Reply-To: <202507100606.90787fe6-lkp@intel.com>
References: <202507100606.90787fe6-lkp@intel.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Thu, 2025-07-10 at 12:56 +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "WARNING:inconsistent_lock_state" on:
>=20
> commit: d06e66c6025e44136e6715d24c23fb821a415577 ("[PATCH v14 2/3]
> sched: Move task_mm_cid_work to mm timer")
> url:
> https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-=
prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250707-224959
> patch link:
> https://lore.kernel.org/all/20250707144824.117014-3-gmonaco@redhat.com/
> patch subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm
> timer
>=20
> in testcase: boot
>=20

It seems calling mmdrop in task_mm_cid_scan (previously
task_mm_cid_work) is not safe in some configurations as it runs from
softirq.

There are solutions to this (mmdrop asynchronously or find another way
to make sure the work runs with a valid mm), but this is getting
unnecessarily complicated.

I am going to proceed with the alternative approach of running the scan
in batches [1] by integrating the findings in this series for more
predictability but still using a task_work.

[1] -
https://lore.kernel.org/lkml/20250217112317.258716-1-gmonaco@redhat.com

Thanks,
Gabriele

> config: x86_64-randconfig-003-20250708
> compiler: gcc-11
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2
> -m 16G
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> +-------------------------------------------------+------------+-----
> -------+
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50c1dc07e=
e |
> > d06e66c602 |
> +-------------------------------------------------+------------+-----
> -------+
> > WARNING:inconsistent_lock_state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > 12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage | 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > 12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +-------------------------------------------------+------------+-----
> -------+
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-lkp/202507100606.90787fe6-lkp@intel.com
>=20
>=20
> [=C2=A0=C2=A0 26.556715][=C2=A0=C2=A0=C2=A0 C0] WARNING: inconsistent loc=
k state
> [=C2=A0=C2=A0 26.557127][=C2=A0=C2=A0=C2=A0 C0] 6.16.0-rc5-00002-gd06e66c=
6025e #1 Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 T
> [=C2=A0=C2=A0 26.557730][=C2=A0=C2=A0=C2=A0 C0] -------------------------=
-------
> [=C2=A0=C2=A0 26.558133][=C2=A0=C2=A0=C2=A0 C0] inconsistent {SOFTIRQ-ON-=
W} -> {IN-SOFTIRQ-W}
> usage.
> [=C2=A0=C2=A0 26.558662][=C2=A0=C2=A0=C2=A0 C0] stdbuf/386 [HC0[0]:SC1[1]=
:HE1:SE0] takes:
> [ 26.559118][ C0] ffffffff870d4438 (pgd_lock){+.?.}-{3:3}, at:
> pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98
> arch/x86/mm/pgtable.c:379)=20
> [=C2=A0=C2=A0 26.559786][=C2=A0=C2=A0=C2=A0 C0] {SOFTIRQ-ON-W} state was =
registered at:
> [ 26.560232][ C0] mark_usage (kernel/locking/lockdep.c:4669)=20
> [ 26.560561][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)=20
> [ 26.560929][ C0] lock_acquire (kernel/locking/lockdep.c:473
> kernel/locking/lockdep.c:5873)=20
> [ 26.561267][ C0] _raw_spin_lock
> (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 26.561617][ C0] pgd_alloc (arch/x86/mm/pgtable.c:86
> arch/x86/mm/pgtable.c:353)=20
> [ 26.561950][ C0] mm_init+0x64f/0xbfb=20
> [ 26.562342][ C0] mm_alloc (kernel/fork.c:1109)=20
> [ 26.562655][ C0] dma_resv_lockdep (drivers/dma-buf/dma-resv.c:784)=20
> [ 26.563020][ C0] do_one_initcall (init/main.c:1274)=20
> [ 26.563389][ C0] do_initcalls (init/main.c:1335 init/main.c:1352)=20
> [ 26.563744][ C0] kernel_init_freeable (init/main.c:1588)=20
> [ 26.564144][ C0] kernel_init (init/main.c:1476)=20
> [ 26.564402][ C0] ret_from_fork (arch/x86/kernel/process.c:154)=20
> [ 26.564633][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)=20
> [=C2=A0=C2=A0 26.564871][=C2=A0=C2=A0=C2=A0 C0] irq event stamp: 4774
> [ 26.565070][ C0] hardirqs last enabled at (4774):
> _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42
> arch/x86/include/asm/irqflags.h:119
> include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)=20
> [ 26.565526][ C0] hardirqs last disabled at (4773):
> _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80
> include/linux/spinlock_api_smp.h:118 kernel/locking/spinlock.c:170)=20
> [ 26.565971][ C0] softirqs last enabled at (4256): local_bh_enable
> (include/linux/bottom_half.h:33)=20
> [ 26.566408][ C0] softirqs last disabled at (4771): __do_softirq
> (kernel/softirq.c:614)=20
> [=C2=A0=C2=A0 26.566823][=C2=A0=C2=A0=C2=A0 C0]
> [=C2=A0=C2=A0 26.566823][=C2=A0=C2=A0=C2=A0 C0] other info that might hel=
p us debug this:
> [=C2=A0=C2=A0 26.567198][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 Possible unsafe loc=
king scenario:
> [=C2=A0=C2=A0 26.567198][=C2=A0=C2=A0=C2=A0 C0]
> [=C2=A0=C2=A0 26.567548][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CPU0
> [=C2=A0=C2=A0 26.567709][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ----
> [=C2=A0=C2=A0 26.567869][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0 lock(pgd_lock=
);
> [=C2=A0=C2=A0 26.568060][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0 <Interrupt>
> [=C2=A0=C2=A0 26.568255][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0 l=
ock(pgd_lock);
> [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]
> [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 *** DEADLOCK ***
> [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]
> [=C2=A0=C2=A0 26.568830][=C2=A0=C2=A0=C2=A0 C0] 3 locks held by stdbuf/38=
6:
> [ 26.569056][ C0] #0: ffff888170d5c1a8 (&sb->s_type-
> >i_mutex_key){++++}-{4:4}, at: lookup_slow (fs/namei.c:1834)=20
> [ 26.569535][ C0] #1: ffff888170cf5850 (&lockref->lock){+.+.}-{3:3},
> at: d_alloc (include/linux/dcache.h:319 fs/dcache.c:1777)=20
> [ 26.569961][ C0] #2: ffffc90000007d40 ((&mm->cid_timer)){+.-.}-
> {0:0}, at: call_timer_fn (kernel/time/timer.c:1744)=20
> [=C2=A0=C2=A0 26.570421][=C2=A0=C2=A0=C2=A0 C0]
> [=C2=A0=C2=A0 26.570421][=C2=A0=C2=A0=C2=A0 C0] stack backtrace:
> [=C2=A0=C2=A0 26.570704][=C2=A0=C2=A0=C2=A0 C0] CPU: 0 UID: 0 PID: 386 Co=
mm: stdbuf Tainted:
> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 T=C2=A0=C2=A0 6.16.0-rc5-00002-gd06e66c6025e #1
> PREEMPT(voluntary)=C2=A0 39c5cbdaf5b4eb171776daa7d42daa95c0766676
> [=C2=A0=C2=A0 26.570716][=C2=A0=C2=A0=C2=A0 C0] Tainted: [T]=3DRANDSTRUCT
> [=C2=A0=C2=A0 26.570719][=C2=A0=C2=A0=C2=A0 C0] Call Trace:
> [=C2=A0=C2=A0 26.570723][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 <IRQ>
> [ 26.570727][ C0] dump_stack_lvl (lib/dump_stack.c:122 (discriminator
> 4))=20
> [ 26.570735][ C0] dump_stack (lib/dump_stack.c:130)=20
> [ 26.570740][ C0] print_usage_bug (kernel/locking/lockdep.c:4047)=20
> [ 26.570748][ C0] valid_state (kernel/locking/lockdep.c:4060)=20
> [ 26.570755][ C0] mark_lock_irq (kernel/locking/lockdep.c:4270)=20
> [ 26.570762][ C0] ? save_trace (kernel/locking/lockdep.c:592)=20
> [ 26.570773][ C0] ? mark_lock (kernel/locking/lockdep.c:4728
> (discriminator 3))=20
> [ 26.570780][ C0] mark_lock (kernel/locking/lockdep.c:4756)=20
> [ 26.570787][ C0] mark_usage (kernel/locking/lockdep.c:4645)=20
> [ 26.570796][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)=20
> [ 26.570804][ C0] lock_acquire (kernel/locking/lockdep.c:473
> kernel/locking/lockdep.c:5873)=20
> [ 26.570811][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)=20
> [ 26.570822][ C0] ? validate_chain (kernel/locking/lockdep.c:3826
> kernel/locking/lockdep.c:3879)=20
> [ 26.570828][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570839][ C0] _raw_spin_lock
> (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)=20
> [ 26.570845][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)=20
> [ 26.570854][ C0] pgd_free (arch/x86/mm/pgtable.c:67
> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)=20
> [ 26.570863][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570873][ C0] __mmdrop (kernel/fork.c:681)=20
> [ 26.570882][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570891][ C0] mmdrop (include/linux/sched/mm.h:55)=20
> [ 26.570901][ C0] task_mm_cid_scan (kernel/sched/core.c:10619
> (discriminator 3))=20
> [ 26.570910][ C0] ? lock_is_held (include/linux/lockdep.h:249)=20
> [ 26.570918][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570928][ C0] call_timer_fn (arch/x86/include/asm/atomic.h:23
> include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/jump_label.h:262 include/trace/events/timer.h:127
> kernel/time/timer.c:1748)=20
> [ 26.570935][ C0] ? trace_timer_base_idle (kernel/time/timer.c:1724)=20
> [ 26.570943][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570953][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)=20
> [ 26.570962][ C0] __run_timers (kernel/time/timer.c:1799
> kernel/time/timer.c:2372)=20
> [ 26.570970][ C0] ? add_timer_global (kernel/time/timer.c:2343)=20
> [ 26.570977][ C0] ? __kasan_check_write (mm/kasan/shadow.c:38)=20
> [ 26.570988][ C0] ? do_raw_spin_lock
> (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-
> fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302
> include/asm-generic/qspinlock.h:111
> kernel/locking/spinlock_debug.c:116)=20
> [ 26.570996][ C0] ? __raw_spin_lock_init
> (kernel/locking/spinlock_debug.c:114)=20
> [ 26.571006][ C0] __run_timer_base (kernel/time/timer.c:2385)=20
> [ 26.571014][ C0] run_timer_base (kernel/time/timer.c:2394)=20
> [ 26.571021][ C0] run_timer_softirq (arch/x86/include/asm/atomic.h:23
> include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/jump_label.h:262 kernel/time/timer.c:342
> kernel/time/timer.c:2406)=20
> [ 26.571028][ C0] handle_softirqs (arch/x86/include/asm/atomic.h:23
> include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/jump_label.h:262 include/trace/events/irq.h:142
> kernel/softirq.c:580)=20
> [ 26.571039][ C0] __do_softirq (kernel/softirq.c:614)=20
> [ 26.571046][ C0] __irq_exit_rcu (kernel/softirq.c:453
> kernel/softirq.c:680)=20
> [ 26.571055][ C0] irq_exit_rcu (kernel/softirq.c:698)=20
> [ 26.571064][ C0] sysvec_apic_timer_interrupt
> (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050)=20
> [=C2=A0=C2=A0 26.571076][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 </IRQ>
> [=C2=A0=C2=A0 26.571078][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 <TASK>
> [ 26.571081][ C0] asm_sysvec_apic_timer_interrupt
> (arch/x86/include/asm/idtentry.h:574)=20
> [ 26.571088][ C0] RIP: 0010:d_alloc (fs/dcache.c:1778)=20
> [ 26.571100][ C0] Code: 8d 7c 24 50 b8 ff ff 37 00 ff 83 f8 00 00 00
> 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 74 05 e8 5f f3 f6 ff 49
> 89 5c 24 50 <49> 8d bc 24 10 01 00 00 48 8d b3 20 01 00 00 e8 87 bc
> ff ff 4c 89
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0 0:	8d 7c 24 50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x50(%rsp),%edi
> =C2=A0=C2=A0 4:	b8 ff ff 37 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=
mov=C2=A0=C2=A0=C2=A0 $0x37ffff,%eax
> =C2=A0=C2=A0 9:	ff 83 f8 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0	incl=C2=A0=C2=
=A0 0xf8(%rbx)
> =C2=A0=C2=A0 f:	48 89 fa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	mov=C2=A0=C2=A0=C2=A0 %rdi,%rdx
> =C2=A0 12:	48 c1 e0 2a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	shl=C2=A0=C2=A0=C2=A0 $0x2a,%rax
> =C2=A0 16:	48 c1 ea 03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	shr=C2=A0=C2=A0=C2=A0 $0x3,%rdx
> =C2=A0 1a:	80 3c 02 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	cmpb=C2=A0=C2=A0 $0x0,(%rdx,%rax,1)
> =C2=A0 1e:	74 05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	je=C2=A0=C2=A0=C2=A0=C2=A0 0x25
> =C2=A0 20:	e8 5f f3 f6 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	call=
=C2=A0=C2=A0 0xfffffffffff6f384
> =C2=A0 25:	49 89 5c 24 50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	mov=
=C2=A0=C2=A0=C2=A0 %rbx,0x50(%r12)
> =C2=A0 2a:*	49 8d bc 24 10 01 00=C2=A0	lea=C2=A0=C2=A0=C2=A0
> 0x110(%r12),%rdi		<-- trapping instruction
> =C2=A0 31:	00=20
> =C2=A0 32:	48 8d b3 20 01 00 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x120(%rbx),%=
rsi
> =C2=A0 39:	e8 87 bc ff ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	call=
=C2=A0=C2=A0 0xffffffffffffbcc5
> =C2=A0 3e:	4c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	rex.WR
> =C2=A0 3f:	89=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.byte 0x89
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0=C2=A0 0:	49 8d bc 24 10 01 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x110(%r=
12),%rdi
> =C2=A0=C2=A0 7:	00=20
> =C2=A0=C2=A0 8:	48 8d b3 20 01 00 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x120(%r=
bx),%rsi
> =C2=A0=C2=A0 f:	e8 87 bc ff ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	=
call=C2=A0=C2=A0 0xffffffffffffbc9b
> =C2=A0 14:	4c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	rex.WR
> =C2=A0 15:	89=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.byte 0x89
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250710/202507100606.90787fe6-lk=
p@intel.com
>=20
>=20


