Return-Path: <linux-kernel+bounces-872199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80752C0F869
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B633C4EC814
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E752367B3;
	Mon, 27 Oct 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XIKUsAiR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMhrivgT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3530FC05
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584795; cv=none; b=Te05TCRuDhDSznJ+TKPIyOTU/dyk+vkKpa0HMP4hB9S/6mP7cfBbwOtj21wj45F/giYe9mXj5oi571HV8JPkrCjGsG+xs3VIaulh0tJMK66LwZUzuhYhiDEyU91E1N3IgCvX/k91eKj2qFfRi7o58jJy3PJ1MRIYy/SsMI3lHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584795; c=relaxed/simple;
	bh=guGA+zl679L6+9h1x55GihZkKLSlBHlEFgVM8Z7SdRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lh1B4lUbtn4Cj+7jOzEAkQfkg3oAs8xj67vnd08YIwlNl63eFOgebCyJ3FD+O2W/9MJZBf4j4H9BT/U7uodTFJmMZ84CFzJKcrd/Airk/AV08d1okmLmLsCPyDiFtk1p41qbvj5FubnGxIIUEOx4t2KbgVvh+MQezKfpAtjsRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XIKUsAiR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMhrivgT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761584792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly9lHTV7pGY90o2gDvQwQAclp/mCDZvMngSMfxYBzBs=;
	b=XIKUsAiRLj71JSTXYtA2mvzg6OMGGpuSU8qzaHKQUJZ0ab4AQFETnXDP2GVyChQeLFzf3g
	WwzI6+5+I4uQYFF2jU9T+wLerdcq7aGP2o2AnlV7KpYy6sbUd2yHt6hxe4faLYrs9TUA/f
	2VWLXjNTUR8RwGsyWEFiKxuWlQj02Bu6tj1hPkqUgvDITwXLKBZxwb7hslyjH8M0K1vnCf
	2mZB22hTiYKODkWAPmRDG+2L5WVoTBTnRbuHC7faUWspZjcIZs9V+GUHefKCdC3+cY2sgf
	5nA+Cxhmgysw9/aT9aAjiB+Lx1cbezKHzcJIMQSlLOO6QCESy30k/VcZNwJkxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761584792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly9lHTV7pGY90o2gDvQwQAclp/mCDZvMngSMfxYBzBs=;
	b=pMhrivgTZh57ymMKQy8Hd6JF87LtmQ3sUEJmyqMg4YHzO/xjHuYYrFs6VrupPkvWdFjteF
	a3C8TxB+WyvqmMBw==
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>, Waiman Long <longman@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Joel Granados <joel.granados@kernel.org>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when
 shutting down nonboot cpus
In-Reply-To: <20251022121345.23496-3-piliu@redhat.com>
References: <20251022121345.23496-1-piliu@redhat.com>
 <20251022121345.23496-3-piliu@redhat.com>
Date: Mon, 27 Oct 2025 18:06:32 +0100
Message-ID: <877bwgw9yf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22 2025 at 20:13, Pingfan Liu wrote:
> The previous patch lifted the deadline bandwidth check during the kexec

Once this is applied 'The previous patch' is meaningless.

> process, which raises a potential issue: as the number of online CPUs
> decreases, DL tasks may be crowded onto a few CPUs, which may starve the
> CPU hotplug kthread. As a result, the hot-removal cannot proceed in
> practice.  On the other hand, as CPUs are offlined one by one, all tasks
> will eventually be migrated to the kexec CPU.
>
> Therefore, this patch marks all other CPUs as inactive to signal the

git grep "This patch" Documentation/process/

> scheduler to migrate tasks to the kexec CPU during hot-removal.

I'm not seeing what this solves. It just changes the timing of moving
tasks off to the boot CPU where they compete for the CPU for nothing.

When kexec() is in progress, then running user space tasks at all is a
completely pointless exercise.

So the obvious solution to the problem is to freeze all user space tasks
when kexec() is invoked. No horrible hacks in the deadline scheduler and
elsewhere required to make that work. No?

Thanks,

        tglx

