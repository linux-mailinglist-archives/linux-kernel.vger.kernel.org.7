Return-Path: <linux-kernel+bounces-858041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7107BE8A86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EE03B9257
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8B32D0FA;
	Fri, 17 Oct 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PP6kxqme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKbWpXkO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037C2E0917
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705374; cv=none; b=GCVi/DFTEK8F/Lb+hpV6bpZPZUliZ1GIvsDVbqREgpARqK/VSEAw2FWYTghDpN6OoXq0TX4rBV8dwrqHBit5FTDlQ9lX0JyhZpy+MeTd+mMuaA+bMmfBaf8Nq1h/ciMpnEbFjhUwtxxIB5+PrdY8ZkFzJowCMGW+1jQqyVXsjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705374; c=relaxed/simple;
	bh=pO7K6XrTRrHHZja1IVrUX6Qp6eDbKW+UAY/Gl/rNUT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZo5wsVrWKjgDvZJ5FenDvVe3YOOqNm5iCiNpUWZ7T97JXuw8ccLlKX6blLBDH+W4BacHfGErcLHiTUzTyEfhAo/lbNF2ZO9MSXiG7xBOIrxjXh6M5KrkTlZ02pAjyU/Lfu1mPrzd1sRWt5pybFtmDNKTAlKOp22lk0jTiP9yMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PP6kxqme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKbWpXkO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760705370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FUXXO+qfYr+iBt+EHhpzMOAT7zbThRLrSDiAiXPzPY=;
	b=PP6kxqme9cQp4apgSmBbIcSk0t2aINTyhb0bSZBZ8fbIWoLE39TP4LAA3Ckxt54j3xZXDC
	D/wwIgyoi+ZtQmhyng6f8cyooSPeIA1oqhiODtMVsqKW6pp88hGZG3lI4sMhKJPopdyIiw
	+FHEzAXCQzHHHfviJO0gKNQ+Rs3DviaJj+ve+o1+TahEoIpjJm/kOy1nRCW2krUbdlbjgC
	b2Yht9IHXConMqpTFmGqJY6mA9f6OA5ToC8o/D2sjP11AaikKhCVo87kEsBpINeL7noUD7
	pGlL6TF64ANnkwSyZRKc9vWvSdzigxfzkpT+BL/42vzYZB8GQpnzBs4BEFVy5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760705370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7FUXXO+qfYr+iBt+EHhpzMOAT7zbThRLrSDiAiXPzPY=;
	b=QKbWpXkO9Lp5vW3lPtNnamnG0kva0AiRNlwDMqD2iH7fBQq/xSw90Otq5v5EnwQfkVGtqS
	lfT+8v/QwWsw7EAQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
In-Reply-To: <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
Date: Fri, 17 Oct 2025 14:49:29 +0200
Message-ID: <87y0p9zo9y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 13:12, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 07:29:34PM +0200, Thomas Gleixner wrote:
>
>> +	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
>>  		return;
>
> FWIW this doesn't work on architectures that change their
> cpu_possible_mask around (eg. Power).

No. Power does not change it after boot either. Half of the kernel would
explode if that'd be the case.

Thanks,

        tglx

