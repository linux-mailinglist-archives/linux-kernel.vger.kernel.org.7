Return-Path: <linux-kernel+bounces-860170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD439BEF7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EDAE4EC3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1FD2D8391;
	Mon, 20 Oct 2025 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="icqJrFMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bpwyBLN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE614F9FB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942083; cv=none; b=Ohi1+MiUQSBHxe0WXlekzh/ZgFYUgxMGI+HnVNYVCyu0Q9RHVlZ5qASBcY8iVNkyB8i0wT9BfGrV3QC92/JNGfDdSbqZ+eiLF8GesRrouZ3IT3+GIZ0fBQjPW57mE1zbSLcOeGmoZpsPVDG5b7okjnnYTWXw34gIVh8VhuGdzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942083; c=relaxed/simple;
	bh=c05lRLbjIbPoHMhort8OqRczsZK7QgHl2QWJlZ2nrOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpUZzkVPkiNpiELiS3jnb4RW93yBAFUhEJQi1J4oyYVqCiYMTUgYbfmmg9o/MsLUXJJ4ycuTFJvQvEcbKXRXEWE+k8rIkDXv6U2pZAQ9gJYN8QBFBq2Kq+WV0dQMSMSp/CWQN0jgWk1/Z5rY3DDududO7e0YGhsjGHMspN/AaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=icqJrFMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bpwyBLN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760942079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c05lRLbjIbPoHMhort8OqRczsZK7QgHl2QWJlZ2nrOI=;
	b=icqJrFMclsGLshVgS1YlZUXCp1q7ZZIwG0liX6w9cGFsShH+x4zw/L2ivT/HEDCeh6q066
	iZdtItMxTF7klVW8yjoSuRMUdve9rKV0wXTB/Qaz/Inf6pUVJFUr4eR8C5+/YKvGfVrXbP
	bf8wdWlt4nmx8KO8h3E2q8kLDG8BECWBYieE9xYlX55PsrtMK/5ecgWTZZXx/Ub9G2jhnI
	t3QOzqO/PQn3FGvppRmWTVdzTLb38CioFBNmTHiVQsAm993fX5E1XeTls+pIJodO/pTNX2
	glen5CtcA7/M+SrZp3gZv1EDsaP/SdYUNtUBxHFtxELlh6Bk0P/V6o6LvnNBqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760942079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c05lRLbjIbPoHMhort8OqRczsZK7QgHl2QWJlZ2nrOI=;
	b=3bpwyBLNivWBdd99MdOH4NGxS85wVhTW0MFMTIWgif9w1eL3IsZZajZfuVZ9P9/sTcev3V
	ZX3oX9J59YFGudCg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>
Subject: Re: [patch 16/19] sched/mmcid: Provide CID ownership mode fixup
 functions
In-Reply-To: <20251015172835.313805515@linutronix.de>
References: <20251015164952.694882104@linutronix.de>
 <20251015172835.313805515@linutronix.de>
Date: Mon, 20 Oct 2025 08:34:38 +0200
Message-ID: <87h5vuytc1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 15 2025 at 19:29, Thomas Gleixner wrote:
> As the goal is to avoid serialization of the scheduler hotpath, this
> requires that the switch back threshold is maximally nr_cpu_ids / 2.
> Otherwise the CID space might become exhausted when tasks are scheduled in
> on CPUs which already transferred ownership before the fixup function was
> able to free or transfer enough CIDs. That would result in a live lock
> because the task loops in mm_get_cid() with runqueue lock held and the
> fixup function is stuck on that runqueue lock.

I've found a way how to lift that limit and to address a problem I've
overlooked in the initial implementation.


