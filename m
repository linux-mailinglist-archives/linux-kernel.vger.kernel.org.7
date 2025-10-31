Return-Path: <linux-kernel+bounces-880881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9281C26C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FA01B23DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFCD2FFDFF;
	Fri, 31 Oct 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVr36rlw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IP721gad"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBA2FD686
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939371; cv=none; b=YdpJ8aRt0tMo8RwcWA5hHKmsQsC2S3sh0dhg/4eampiFDx0y9IrdORJjWs7EsSQ7RbMlJFUHv70GqyaEfcZlmBRY83LBTg2y4qPqFsxEFvfOniag4YJmYnMSAbTsLTC+lIh2EmV8LGG/V8DJ/kOxfhIsbx5xF4hFvu3GE8Qj2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939371; c=relaxed/simple;
	bh=k0YZzPj6qo3/McZ7KhINAGY1Witq8xpJIDDVK9+zrJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RO/PezpXZMah4WuCqjVH+XkeGxdLxRtylPqO8IW3LZhTx2nYls/2EiGzO32wGk/VQFDv0LYfw2PDkp7Qd3XDGusN8EaxvCVnoWBwmbC2MZKo3OhiUCtAwbjg75Ts32wBNKHoKnXMp5kQEFd2/2sZAhyCJKYSS3CfWTMuA7vkMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVr36rlw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IP721gad; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761939367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CuGaLkEJJjE3v7CnhHjbkfvQ9enHtVZK8jhFMShk9s=;
	b=bVr36rlwitb7ggPVx81JRKmE1Xgdwcxu08LsY6tI+3sQZfQsj3ZV4Dg9L/vM9odwxunbdJ
	SoClB33wh36Ew+p0NBwMSDAknu+cUXM1RdZPHWAJbNx/bQspPvsyBWe+nWimT9SJd8/9wD
	YHBT8o3gbg9lDYNRSC8K3/dRqOIe0dIrK37Iuy+FApceD6cWtNZPGxPS+pIVh7pmNtQfMj
	shvzuC7W0ivu/gye6XoJVyP4gyZKy9O/7ekmJQew7h6ntMWq8WCyndeVZ6a0tM+0nj3hMW
	T3/9UywrZReLdR9Ivjd2aVubSoa6u6W4m54J3ZqW8+6kGJWyA72+/NmjMyvPhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761939367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CuGaLkEJJjE3v7CnhHjbkfvQ9enHtVZK8jhFMShk9s=;
	b=IP721gadKwoLSuA0cw6JhpJHyjhZFIZG8Rt2FFYNBcOdQ5L+yEwwbBdCP78cfMiKsL4gt5
	mK5ePE4kl0F0VYDg==
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
In-Reply-To: <ae8de225-3c07-43ac-80d1-ecb6ac45d5d9@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <47e73026-390e-40d6-a860-10e9378a3bf3@linux.ibm.com>
 <ae8de225-3c07-43ac-80d1-ecb6ac45d5d9@linux.ibm.com>
Date: Fri, 31 Oct 2025 20:36:06 +0100
Message-ID: <87ecqisw2h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30 2025 at 12:10, Shrikanth Hegde wrote:
>> I am running into crash at boot on power10 pseries.
>> Thought of putting it here first. Me trying to figure out why.
>>=20
>> I am using your tree.
>> git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git

Can you update and revalidate? There are a couple of fixes there though
I don't know how they would be related.

>> Oops: Kernel access of bad area, sig: 7 [#3]
>> LE PAGE_SIZE=3D64K MMU=3DRadix=C2=A0 SMP NR_CPUS=3D8192 NUMA pSeries
>> Modules linked in: drm drm_panel_orientation_quirks xfs sd_mod sg=20
>> ibmvscsi ibmveth scsi_transport_srp pseries_wdt dm_mirror dm_region_hash=
=20
>> dm_log dm_mod fuse
>> CPU: 96 UID: 0 PID: 0 Comm: swapper/96 Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 D W=20=20=20=20=20=20=20=20=20=20=20
>> 6.18.0-rc3+ #4 PREEMPT(lazy)
>> Tainted: [D]=3DDIE, [W]=3DWARN
>> NIP [c0000000001b5c10] mm_cid_switch_to+0x58/0x52c

If it happens again, can you decode the source line?

>> LR [c000000001117c84] __schedule+0x4bc/0x760
>> Call Trace:
>> [c00000668367fde0] [c0000000001b53c8] __pick_next_task+0x60/0x2ac=20
>> (unreliable)
>> [c00000668367fe40] [c000000001117a14] __schedule+0x24c/0x760
>> [c00000668367fee0] [c0000000011183d0] schedule_idle+0x3c/0x64
>> [c00000668367ff10] [c0000000001f2470] do_idle+0x15c/0x1ac
>> [c00000668367ff60] [c0000000001f2788] cpu_startup_entry+0x4c/0x50
>> [c00000668367ff90] [c00000000005ef20] start_secondary+0x284/0x288
>> [c00000668367ffe0] [c00000000000e158] start_secondary_prolog+0x10/0x14
>>=20
>
> Issue happens with NR_CPUS=3D8192. System boots fine with NR_CPUS=3D2048

Hmm. Let me build a kernel with 8K and throw it at a VM then.

Thanks,

        tglx

