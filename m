Return-Path: <linux-kernel+bounces-665579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C5AC6B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D361BC6BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8982874EC;
	Wed, 28 May 2025 13:59:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371320B81D
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440742; cv=none; b=k6P9QIioK57qxnxGpgksCaeqsrIsoOPf4ZGUGjE/dsLyqgvyZGZWLglX0U4JL+xRI5p6ZfV4IWFznJvP8m2p7tr6Bq6n61bsGxTJ2c+ZGI2jz13d3Qw3imtHd7x3FLv2102azAJzNBWAnHOBgrsIz9oKQ3mzOjN73w0mHTqTJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440742; c=relaxed/simple;
	bh=lvfyVyNh2GfH/oh2OLT87WzGcnpGXZD/TplYVhyCgNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyPRi0htF6CbPjW58cvp8HOuyfWaVl0yA4x1nUnDvr/eW0CU4WxeIjP0WeZ+CbBzgdauuxCdOEQECVxOShF+OBcXr+2TLoOR3pvh23MC3c+E+j5hxwCzHnhdL/of2JJ+e0lcRB1oSyURRucvC+7Pspe2nW5sbQ34B2YqUl/0Zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F4C4CEE3;
	Wed, 28 May 2025 13:59:00 +0000 (UTC)
Date: Wed, 28 May 2025 10:00:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Mel Gorman <mgorman@suse.de>, Vincent Guittot
 <vincent.guittot@linaro.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/43] sched: Use the SMP scheduler on UP too
Message-ID: <20250528100000.0ab0a8b1@gandalf.local.home>
In-Reply-To: <20250528085813.GX39944@noisy.programming.kicks-ass.net>
References: <20250528080924.2273858-1-mingo@kernel.org>
	<20250528085813.GX39944@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 10:58:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> You know about unifdef, right :-)

I didn't know about that!

> 
> $ unifdef -m -DCONFIG_SMP=y kernel/sched/*.[ch] include/linux/sched.h include/linux/sched/*.h

Cool!

Although I wish there was better documentation about it.

-- Steve

