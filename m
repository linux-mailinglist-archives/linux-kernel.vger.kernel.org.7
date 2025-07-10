Return-Path: <linux-kernel+bounces-725196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04477AFFBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57183BD1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18228C02B;
	Thu, 10 Jul 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuRx17nY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDfTXCpC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590C28B7F8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135078; cv=none; b=nIyjMXh3OdZ5ykHHYia5npwYIU1s2sVElEbpkP9OZFKkldUNs1fXVsMEidUf3h8ifsiQYtEjTG+2zQ8RIu3tESSRgpWWrAQPKL7krTc46B/Dk1mzQRENOHeP6FkiFFbNkpENNUnD8almJn20sX4Wtz1NIqCnDX6CtsisGhNJVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135078; c=relaxed/simple;
	bh=dsD7VNjjSHdU7qf5/AGTy9WdVgPZeJ71oUU2caxq0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfyEmeZwXW0u5gV1wPm+vfcoWRICFER8b8eiauDYLaShsoXd9mQA/8HvrUA0XLxw2E8jEXTZ/9AG9YrF3kDxs2QdAt/S+Hm2p/IeGG+JkO2XINIJITqUYxGGQH/fOMhCVS2vch7yXNRzuQulmNMCFqnBoeqaWF+NQMDiAxw0hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuRx17nY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDfTXCpC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 10:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752135075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsD7VNjjSHdU7qf5/AGTy9WdVgPZeJ71oUU2caxq0mA=;
	b=FuRx17nYwUISNR6gBIUsyt7JqFkJrsLVMrtRcEtw1GilaVQPnr2kisKqwYscMZuV7Y3ZXP
	dotpymeiJf3t9xZK7a8/M7CdOeE3HewYQhUEvnBeaCIkIenXddFNWGxzYkzuGmfZJ9XUON
	MSIE3q+PXCKps37iy0ThyNo5ROsnTKusWepeNPhtF3ELhoKghlccyNTmR5+bNLMAJpSOel
	OJ9L8zmJq1HNo86Kax/VVbCS+nL7+o9/D+VeBDYuv2nsh7g3YCD/ytzJn+ShN9rsd/bJ/9
	tbY0pzn06yKyYkhswfflXYg9R7DVXdtWeyqnj6RNyHX+ZZ8I0/MT+9hHsyYgSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752135075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsD7VNjjSHdU7qf5/AGTy9WdVgPZeJ71oUU2caxq0mA=;
	b=qDfTXCpCPz/DRV/GKdUOYwfwVE3KQpQ0pjchLZccExYjNpc25GV9qQPcxFI5NUDAuu9b7B
	xpCB/CrauT9+6SAA==
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
Message-ID: <20250710081114.5wnABNG7@linutronix.de>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>

On 2025-07-10 16:00:46 [+0800], Chen, Yu C wrote:
> migrate_disable() disables the task migration between CPUs by restricting
> the task's affinity, but it does not disable the preemption on single
> CPUs IMO. The scope of guard(preempt)() in migrate_disable() is just
> within the migrate_disable(). debug_smp_processor_id() warns when the
> preemption is enabled.

does migrate_disable() really have no effect on
debug_smp_processor_id()?

> Thanks,
> Chenyu
Sebastian

