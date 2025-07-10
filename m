Return-Path: <linux-kernel+bounces-725475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C95EAFFF96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301D25A46CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E22DEA7B;
	Thu, 10 Jul 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jAUJfQ1E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+vSIxPP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDF2D3ED2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144465; cv=none; b=JhEObL47jl6rMoisYMN6idsAwstprLnA6CToJeWM4hSZPMsGm/hmxeGHOMrdzIRMIQShVRGXHRUhPfgjWLAArAB7F0RyCx8Wdl7/AR4eg7bB+1Z31KwdBoBpP9OsZxGnRQnj7d2WJe5PG48XddoBDjWQVokq1frYS8KH7lJlJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144465; c=relaxed/simple;
	bh=PagKpfrg/CoVjOCw2gulRvIjEDVrXdnTDmoAFAYLbnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9ipB3Yzoq7w6sTYkjQZ6wVIBYHT+8IIQSYGAg9YhVMT0EdyyWdEA/bD2BmGiJzHFC6m+otV2Wx2siNC7VhM7HSb3g7rpEJQZP02THBVkKhnRNIdFWG/qIPKY/afYUBYytppTacbWSaKgLOPo91ADekSiav4asc24H+2tH/v1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jAUJfQ1E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+vSIxPP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752144462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PagKpfrg/CoVjOCw2gulRvIjEDVrXdnTDmoAFAYLbnw=;
	b=jAUJfQ1EsTwFcysThuS+KO9PEGuqZEh8nGOZoo43TMNHng3gpe2oFLkTUJkWD4cm1Y2ODq
	KTD+oTny42JjNrXzm5glxn8ojp4m+SR5pHIbSqBVuTDJkyAZPlzehHaRrAFEbQEEIoh4wr
	UUHxuZqwPaffva1EWAZeY7AzUhBc7qTSWru2uaSVcv7sjlzDd1WIt/bIRmOTpamqvkwj6h
	LUuKFwPryCWMuVeWvissTzVbrnbqijztda1jM3HkJAtRK0KQbNnZ9Zi9EhYriilWuz00rz
	a/HqFeglH/Wvzuo2jdRUzEiPgmurVwll7zCZ1WfLQBK7+HTnYyuo8DKspRMmkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752144462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PagKpfrg/CoVjOCw2gulRvIjEDVrXdnTDmoAFAYLbnw=;
	b=2+vSIxPPORjjdSfzFFX7diVuu+QwkLrVLn6SAUealHMHy8JhJt9CiQe6FLy2xp3L/OEbfF
	ipygo0MoeCe4M6DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Ingo Molnar <mingo@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/smp] 06ddd17521:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <20250710104740.XLv9MRX1@linutronix.de>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
 <20250710081114.5wnABNG7@linutronix.de>
 <99573578-95e8-4b97-b2c8-d8229e4816e5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <99573578-95e8-4b97-b2c8-d8229e4816e5@intel.com>

On 2025-07-10 16:29:51 [+0800], Chen, Yu C wrote:
> I see. So there is still a CONFIG_SMP to check migrate_disbled
> in debug_smp_processor_id(), and that was skipped if we do not
> have CONFIG_SMP set.

Exactly, sorry for that.
I planned to let you do the figuring out and sending the patch but got
confused midway, had to look it up and then had the patch ready and
decided to send it=E2=80=A6

> thanks,
> Chenyu>> Thanks,
Sebastian

