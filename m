Return-Path: <linux-kernel+bounces-725781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65940B003E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A60C6408DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6125BF00;
	Thu, 10 Jul 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egh8EtlL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54C25A331
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154846; cv=none; b=PqEewKg9ZfzZgP1K8wWsvC5Fm/nwf0GAhzy6e1Zq8RpYaxCRJX7WPu29U20LkjKqOIFwpUj6XJmtbBuhUiLFhakWI97wUFVWDH66yjYOEwmsI72Es+4LBJcXFnQT2RoJjreFtcOWuDqWOevCB+kBF6TzAnqIdJvtsG/F4szelRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154846; c=relaxed/simple;
	bh=IvuK1bTxHRsDJklDKcPCn1JXQ/p3NAVR4u9xAQlZCwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgfhDCTmT12j0rdVJ0TLgmuHLWhkP7Qq3rxpZ4ytKi4x+eGF14fYTWpnqkZKXZJQUBjVyi/BIgxauhtJGI1766eM3tve7mr0vDz59+un1V8Iz++dRD8wlbzd+I7N/HxbEzRE46HATlElKZgB1KrAYzrPPOSA+ZnGubUniO3D89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egh8EtlL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752154843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o4YsobBrj+MEQdmCpIc3VlUTTKBLXwGx7WqZOSzhGY4=;
	b=egh8EtlLYq9gnIbWyxrBXPmHXEut4OZjO9ib+5rburEmmZS25dZJmPtBB2hiNT8iQC1M1X
	lqmS/M8Q+eSVt/N2y3wZ5D3FxDyEtWgM59Q7LE5VANzBRxUjgvgDL9m3FURlc3ihJ5HERX
	8u7zBLovK+PYLUleH4I61O2iBAlSdoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-K4cp_J4aOnSTRC1bf7ADsA-1; Thu, 10 Jul 2025 09:40:41 -0400
X-MC-Unique: K4cp_J4aOnSTRC1bf7ADsA-1
X-Mimecast-MFC-AGG-ID: K4cp_J4aOnSTRC1bf7ADsA_1752154840
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so519483f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154840; x=1752759640;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4YsobBrj+MEQdmCpIc3VlUTTKBLXwGx7WqZOSzhGY4=;
        b=i/IMjxTHCa6yRrf5f5i1dQNatblNyonShTc0jrIJrgOaQbMuo+AxlCHdmyM6gRsBEL
         RYHeYbwiS3DDIVAYJ9yFkrc4RVN4SvqOSV/JJGoLU3rlGBDepPI0XSsuny+uZ+p4J7DO
         qzKlvH7XRCGc4X39lHmiU42OQ7ncifjG9bOtyDDCG9v/peTXQf8GtxF4+I33K9QtdAd2
         XSx+G0VOvcBCI/HG1uaa7MmlaqOBsjiNkV/1vO8fFQK3S2hJrMnMC+wf6Mx8X6LLtPNp
         vvQM5u2+H7uP2c97p0GFDOuS7OO0t5drh1tg9BsXUJL1MxR/EG+EAX5MZDrosxysZY1s
         Qm1A==
X-Forwarded-Encrypted: i=1; AJvYcCVgKd1zqfBltQPQShNCw/PWoSyu2tkrI3bv93xQKsnOUFgjodiEStGgpQP9ODzQ9JrWEpNsBaKkHeIEhMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdgdOl21NJSZbOdA5QTkdDvhpx3B/+TMoOSG7s6lXTCC96m1w
	jawmwLk6GKQyKRBRbVq7qfROedbpSCnl5qs8tzBcrHhLZzishf73HfanNUw8MBIYC/Od5u1vgG4
	ENgmc6vqveuJ9qAXKn5u1CyxckZZaTVim34EPvRFBVfEbVENZNVPR46Fy27kqBEJrtA==
X-Gm-Gg: ASbGncvzbRM6ZB4I5qgpL9zFv9oKdfYg1oMcLmjLmjeqzFHTSL82X+rWYfJ10x6r0+h
	feuTU+HSjdh1VxmGSDCW3K224PCxd4bvXR2eVNQ6yCZ+xsPUabiQDbkcsOkeNorBzGBLp9C6y5Z
	jzt6ERMkwFsp8KpiIctpEhLvfvr6dX5XDIKiQsG3cuVNHahC6bw9qny4yeRZsAmpHlI2Fs9lBZ3
	K8OH/kgEkIXArP7+3ANzzd+BBs7TIth13oK87kghXfmlfhxeEl+R3q+9fsGeozAmlFZrSZqJ5cX
	Xytp8w5WwlheYt96XAWTXHrAPYgvKq+NipRziDvOX5OSCw/l
X-Received: by 2002:a05:6000:188d:b0:3a6:d296:feaf with SMTP id ffacd0b85a97d-3b5e450b4ccmr4887237f8f.24.1752154839653;
        Thu, 10 Jul 2025 06:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy9x5N0/8PpYt+kD67va6hnXk1oZALQPnjh4gJzrRvzZsyp+0N1hfGHmyfe7QHatJNFv3QEQ==
X-Received: by 2002:a05:6000:188d:b0:3a6:d296:feaf with SMTP id ffacd0b85a97d-3b5e450b4ccmr4887199f8f.24.1752154838985;
        Thu, 10 Jul 2025 06:40:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd540a95sm20251075e9.29.2025.07.10.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:40:38 -0700 (PDT)
Message-ID: <fa7a3ea2c6326639911fbe49b86975f79db92372.camel@redhat.com>
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot
	 <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com,  Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.org>
Date: Thu, 10 Jul 2025 15:40:36 +0200
In-Reply-To: <d8eacb24-af73-4580-8248-1fd1ac33e28f@efficios.com>
References: <202507100606.90787fe6-lkp@intel.com>
	 <d8eacb24-af73-4580-8248-1fd1ac33e28f@efficios.com>
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



On Thu, 2025-07-10 at 09:23 -0400, Mathieu Desnoyers wrote:
> On 2025-07-10 00:56, kernel test robot wrote:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed "WARNING:inconsistent_lock_state" on:
> >=20
> > commit: d06e66c6025e44136e6715d24c23fb821a415577 ("[PATCH v14 2/3]
> > sched: Move task_mm_cid_work to mm timer")
> > url:
> > https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Ad=
d-prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250707-224959
> > patch link:
> > https://lore.kernel.org/all/20250707144824.117014-3-gmonaco@redhat.com/
> > patch subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm
> > timer
> >=20
> > in testcase: boot
> >=20
> > config: x86_64-randconfig-003-20250708
> > compiler: gcc-11
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
> > 2 -m 16G
> >=20
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >=20
> >=20
> > +-------------------------------------------------+------------+---
> > ---------+
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50c1dc07e=
e |
> > > d06e66c602 |
> > +-------------------------------------------------+------------+---
> > ---------+
> > > WARNING:inconsistent_lock_state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > 12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage | 0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > 12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +-------------------------------------------------+------------+---
> > ---------+
> >=20
>=20
> I suspect the issue comes from calling mmdrop(mm) from timer context
> in a scenario
> where the mm_count can drop to 0.
>=20
> This causes calls to pgd_free() and such to take the pgd_lock in
> softirq
> context, when in other cases it's taken with softirqs enabled.
>=20
> See "mmdrop_sched()" for RT. I think we need something similar for
> the
> non-RT case, e.g. a:
>=20
> static inline void __mmdrop_delayed(struct rcu_head *rhp)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mm_struct *mm =3D=
 container_of(rhp, struct mm_struct,
> delayed_drop);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mmdrop(mm);
> }
>=20
> static inline void mmdrop_timer(struct mm_struct *mm)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Provides a full memor=
y barrier. See mmdrop() */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_dec_and_test(=
&mm->mm_count))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 call_rcu(&mm->delayed_drop, __mmdrop_delayed);
> }
>=20
> Thoughts ?
>=20

Thanks for the suggestion.

I noticed the problem is in the mmdrop over there, but I'm seeing this
is getting unnecessarily complicated.
I'm not sure it's worth going down this path, also considering pushing
the timer wheel like this might end up in unintended effects like it
happened with the workqueue.

I am going to try the alternative approach of running the scan in
batches [1] still using a task_work but triggering it from
__rseq_handle_notify_resume like here.
If that works in the original usecase, I guess it's better to keep it
that way.

What do you think?

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20250217112317.258716-1-gmonaco@redhat.com

> Thanks,
>=20
> Mathieu
>=20
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes:
> > > https://lore.kernel.org/oe-lkp/202507100606.90787fe6-lkp@intel.com
> >=20
> >=20
> > [=C2=A0=C2=A0 26.556715][=C2=A0=C2=A0=C2=A0 C0] WARNING: inconsistent l=
ock state
> > [=C2=A0=C2=A0 26.557127][=C2=A0=C2=A0=C2=A0 C0] 6.16.0-rc5-00002-gd06e6=
6c6025e #1 Tainted:
> > G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 T
> > [=C2=A0=C2=A0 26.557730][=C2=A0=C2=A0=C2=A0 C0] -----------------------=
---------
> > [=C2=A0=C2=A0 26.558133][=C2=A0=C2=A0=C2=A0 C0] inconsistent {SOFTIRQ-O=
N-W} -> {IN-SOFTIRQ-
> > W} usage.
> > [=C2=A0=C2=A0 26.558662][=C2=A0=C2=A0=C2=A0 C0] stdbuf/386 [HC0[0]:SC1[=
1]:HE1:SE0] takes:
> > [ 26.559118][ C0] ffffffff870d4438 (pgd_lock){+.?.}-{3:3}, at:
> > pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98
> > arch/x86/mm/pgtable.c:379)
> > [=C2=A0=C2=A0 26.559786][=C2=A0=C2=A0=C2=A0 C0] {SOFTIRQ-ON-W} state wa=
s registered at:
> > [ 26.560232][ C0] mark_usage (kernel/locking/lockdep.c:4669)
> > [ 26.560561][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
> > [ 26.560929][ C0] lock_acquire (kernel/locking/lockdep.c:473
> > kernel/locking/lockdep.c:5873)
> > [ 26.561267][ C0] _raw_spin_lock
> > (include/linux/spinlock_api_smp.h:134
> > kernel/locking/spinlock.c:154)
> > [ 26.561617][ C0] pgd_alloc (arch/x86/mm/pgtable.c:86
> > arch/x86/mm/pgtable.c:353)
> > [ 26.561950][ C0] mm_init+0x64f/0xbfb
> > [ 26.562342][ C0] mm_alloc (kernel/fork.c:1109)
> > [ 26.562655][ C0] dma_resv_lockdep (drivers/dma-buf/dma-resv.c:784)
> > [ 26.563020][ C0] do_one_initcall (init/main.c:1274)
> > [ 26.563389][ C0] do_initcalls (init/main.c:1335 init/main.c:1352)
> > [ 26.563744][ C0] kernel_init_freeable (init/main.c:1588)
> > [ 26.564144][ C0] kernel_init (init/main.c:1476)
> > [ 26.564402][ C0] ret_from_fork (arch/x86/kernel/process.c:154)
> > [ 26.564633][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> > [=C2=A0=C2=A0 26.564871][=C2=A0=C2=A0=C2=A0 C0] irq event stamp: 4774
> > [ 26.565070][ C0] hardirqs last enabled at (4774):
> > _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42
> > arch/x86/include/asm/irqflags.h:119
> > include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> > [ 26.565526][ C0] hardirqs last disabled at (4773):
> > _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80
> > include/linux/spinlock_api_smp.h:118 kernel/locking/spinlock.c:170)
> > [ 26.565971][ C0] softirqs last enabled at (4256): local_bh_enable
> > (include/linux/bottom_half.h:33)
> > [ 26.566408][ C0] softirqs last disabled at (4771): __do_softirq
> > (kernel/softirq.c:614)
> > [=C2=A0=C2=A0 26.566823][=C2=A0=C2=A0=C2=A0 C0]
> > [=C2=A0=C2=A0 26.566823][=C2=A0=C2=A0=C2=A0 C0] other info that might h=
elp us debug this:
> > [=C2=A0=C2=A0 26.567198][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 Possible unsafe l=
ocking scenario:
> > [=C2=A0=C2=A0 26.567198][=C2=A0=C2=A0=C2=A0 C0]
> > [=C2=A0=C2=A0 26.567548][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CPU0
> > [=C2=A0=C2=A0 26.567709][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ----
> > [=C2=A0=C2=A0 26.567869][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0 lock(pgd_lo=
ck);
> > [=C2=A0=C2=A0 26.568060][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0 <Interrupt>
> > [=C2=A0=C2=A0 26.568255][=C2=A0=C2=A0=C2=A0 C0]=C2=A0=C2=A0=C2=A0=C2=A0=
 lock(pgd_lock);
> > [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]
> > [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 *** DEADLOCK ***
> > [=C2=A0=C2=A0 26.568452][=C2=A0=C2=A0=C2=A0 C0]
> > [=C2=A0=C2=A0 26.568830][=C2=A0=C2=A0=C2=A0 C0] 3 locks held by stdbuf/=
386:
> > [ 26.569056][ C0] #0: ffff888170d5c1a8 (&sb->s_type-
> > >i_mutex_key){++++}-{4:4}, at: lookup_slow (fs/namei.c:1834)
> > [ 26.569535][ C0] #1: ffff888170cf5850 (&lockref->lock){+.+.}-
> > {3:3}, at: d_alloc (include/linux/dcache.h:319 fs/dcache.c:1777)
> > [ 26.569961][ C0] #2: ffffc90000007d40 ((&mm->cid_timer)){+.-.}-
> > {0:0}, at: call_timer_fn (kernel/time/timer.c:1744)
> > [=C2=A0=C2=A0 26.570421][=C2=A0=C2=A0=C2=A0 C0]
> > [=C2=A0=C2=A0 26.570421][=C2=A0=C2=A0=C2=A0 C0] stack backtrace:
> > [=C2=A0=C2=A0 26.570704][=C2=A0=C2=A0=C2=A0 C0] CPU: 0 UID: 0 PID: 386 =
Comm: stdbuf Tainted:
> > G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 T=C2=A0=C2=A0 6.16.0-rc5-00002-gd06e66c6025e #1
> > PREEMPT(voluntary)=C2=A0 39c5cbdaf5b4eb171776daa7d42daa95c0766676
> > [=C2=A0=C2=A0 26.570716][=C2=A0=C2=A0=C2=A0 C0] Tainted: [T]=3DRANDSTRU=
CT
> > [=C2=A0=C2=A0 26.570719][=C2=A0=C2=A0=C2=A0 C0] Call Trace:
> > [=C2=A0=C2=A0 26.570723][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 <IRQ>
> > [ 26.570727][ C0] dump_stack_lvl (lib/dump_stack.c:122
> > (discriminator 4))
> > [ 26.570735][ C0] dump_stack (lib/dump_stack.c:130)
> > [ 26.570740][ C0] print_usage_bug (kernel/locking/lockdep.c:4047)
> > [ 26.570748][ C0] valid_state (kernel/locking/lockdep.c:4060)
> > [ 26.570755][ C0] mark_lock_irq (kernel/locking/lockdep.c:4270)
> > [ 26.570762][ C0] ? save_trace (kernel/locking/lockdep.c:592)
> > [ 26.570773][ C0] ? mark_lock (kernel/locking/lockdep.c:4728
> > (discriminator 3))
> > [ 26.570780][ C0] mark_lock (kernel/locking/lockdep.c:4756)
> > [ 26.570787][ C0] mark_usage (kernel/locking/lockdep.c:4645)
> > [ 26.570796][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
> > [ 26.570804][ C0] lock_acquire (kernel/locking/lockdep.c:473
> > kernel/locking/lockdep.c:5873)
> > [ 26.570811][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
> > arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> > [ 26.570822][ C0] ? validate_chain (kernel/locking/lockdep.c:3826
> > kernel/locking/lockdep.c:3879)
> > [ 26.570828][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570839][ C0] _raw_spin_lock
> > (include/linux/spinlock_api_smp.h:134
> > kernel/locking/spinlock.c:154)
> > [ 26.570845][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
> > arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> > [ 26.570854][ C0] pgd_free (arch/x86/mm/pgtable.c:67
> > arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> > [ 26.570863][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570873][ C0] __mmdrop (kernel/fork.c:681)
> > [ 26.570882][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570891][ C0] mmdrop (include/linux/sched/mm.h:55)
> > [ 26.570901][ C0] task_mm_cid_scan (kernel/sched/core.c:10619
> > (discriminator 3))
> > [ 26.570910][ C0] ? lock_is_held (include/linux/lockdep.h:249)
> > [ 26.570918][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570928][ C0] call_timer_fn (arch/x86/include/asm/atomic.h:23
> > include/linux/atomic/atomic-arch-fallback.h:457
> > include/linux/jump_label.h:262 include/trace/events/timer.h:127
> > kernel/time/timer.c:1748)
> > [ 26.570935][ C0] ? trace_timer_base_idle
> > (kernel/time/timer.c:1724)
> > [ 26.570943][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570953][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> > [ 26.570962][ C0] __run_timers (kernel/time/timer.c:1799
> > kernel/time/timer.c:2372)
> > [ 26.570970][ C0] ? add_timer_global (kernel/time/timer.c:2343)
> > [ 26.570977][ C0] ? __kasan_check_write (mm/kasan/shadow.c:38)
> > [ 26.570988][ C0] ? do_raw_spin_lock
> > (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-
> > arch-fallback.h:2170 include/linux/atomic/atomic-
> > instrumented.h:1302 include/asm-generic/qspinlock.h:111
> > kernel/locking/spinlock_debug.c:116)
> > [ 26.570996][ C0] ? __raw_spin_lock_init
> > (kernel/locking/spinlock_debug.c:114)
> > [ 26.571006][ C0] __run_timer_base (kernel/time/timer.c:2385)
> > [ 26.571014][ C0] run_timer_base (kernel/time/timer.c:2394)
> > [ 26.571021][ C0] run_timer_softirq
> > (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-
> > fallback.h:457 include/linux/jump_label.h:262
> > kernel/time/timer.c:342 kernel/time/timer.c:2406)
> > [ 26.571028][ C0] handle_softirqs (arch/x86/include/asm/atomic.h:23
> > include/linux/atomic/atomic-arch-fallback.h:457
> > include/linux/jump_label.h:262 include/trace/events/irq.h:142
> > kernel/softirq.c:580)
> > [ 26.571039][ C0] __do_softirq (kernel/softirq.c:614)
> > [ 26.571046][ C0] __irq_exit_rcu (kernel/softirq.c:453
> > kernel/softirq.c:680)
> > [ 26.571055][ C0] irq_exit_rcu (kernel/softirq.c:698)
> > [ 26.571064][ C0] sysvec_apic_timer_interrupt
> > (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050)
> > [=C2=A0=C2=A0 26.571076][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 </IRQ>
> > [=C2=A0=C2=A0 26.571078][=C2=A0=C2=A0=C2=A0 C0]=C2=A0 <TASK>
> > [ 26.571081][ C0] asm_sysvec_apic_timer_interrupt
> > (arch/x86/include/asm/idtentry.h:574)
> > [ 26.571088][ C0] RIP: 0010:d_alloc (fs/dcache.c:1778)
> > [ 26.571100][ C0] Code: 8d 7c 24 50 b8 ff ff 37 00 ff 83 f8 00 00
> > 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 74 05 e8 5f f3 f6
> > ff 49 89 5c 24 50 <49> 8d bc 24 10 01 00 00 48 8d b3 20 01 00 00 e8
> > 87 bc ff ff 4c 89
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0=C2=A0=C2=A0 0:	8d 7c 24 50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x50(%rsp),%edi
> > =C2=A0=C2=A0=C2=A0 4:	b8 ff ff 37 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	mov=C2=A0=C2=A0=C2=A0 $0x37ffff,%eax
> > =C2=A0=C2=A0=C2=A0 9:	ff 83 f8 00 00 00=C2=A0=C2=A0=C2=A0=C2=A0	incl=C2=
=A0=C2=A0 0xf8(%rbx)
> > =C2=A0=C2=A0=C2=A0 f:	48 89 fa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	mov=C2=A0=C2=A0=C2=A0 %rdi,%rdx
> > =C2=A0=C2=A0 12:	48 c1 e0 2a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0	shl=C2=A0=C2=A0=C2=A0 $0x2a,%rax
> > =C2=A0=C2=A0 16:	48 c1 ea 03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0	shr=C2=A0=C2=A0=C2=A0 $0x3,%rdx
> > =C2=A0=C2=A0 1a:	80 3c 02 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0	cmpb=C2=A0=C2=A0 $0x0,(%rdx,%rax,1)
> > =C2=A0=C2=A0 1e:	74 05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	je=C2=A0=C2=A0=C2=A0=C2=A0=
 0x25
> > =C2=A0=C2=A0 20:	e8 5f f3 f6 ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0	call=C2=A0=C2=A0 0xfffffffffff6f384
> > =C2=A0=C2=A0 25:	49 89 5c 24 50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0	mov=C2=A0=C2=A0=C2=A0 %rbx,0x50(%r12)
> > =C2=A0=C2=A0 2a:*	49 8d bc 24 10 01 00=C2=A0	lea=C2=A0=C2=A0=C2=A0
> > 0x110(%r12),%rdi		<-- trapping instruction
> > =C2=A0=C2=A0 31:	00
> > =C2=A0=C2=A0 32:	48 8d b3 20 01 00 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 0x120=
(%rbx),%rsi
> > =C2=A0=C2=A0 39:	e8 87 bc ff ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0	call=C2=A0=C2=A0 0xffffffffffffbcc5
> > =C2=A0=C2=A0 3e:	4c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	rex.WR
> > =C2=A0=C2=A0 3f:	89=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.byte 0x89
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =C2=A0=C2=A0=C2=A0 0:	49 8d bc 24 10 01 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 =
0x110(%r12),%rdi
> > =C2=A0=C2=A0=C2=A0 7:	00
> > =C2=A0=C2=A0=C2=A0 8:	48 8d b3 20 01 00 00=C2=A0	lea=C2=A0=C2=A0=C2=A0 =
0x120(%rbx),%rsi
> > =C2=A0=C2=A0=C2=A0 f:	e8 87 bc ff ff=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0	call=C2=A0=C2=A0 0xffffffffffffbc9b
> > =C2=A0=C2=A0 14:	4c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	rex.WR
> > =C2=A0=C2=A0 15:	89=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	.byte 0x89
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250710/202507100606.90787fe6-=
lkp@intel.com
> >=20
> >=20
> >=20
>=20


