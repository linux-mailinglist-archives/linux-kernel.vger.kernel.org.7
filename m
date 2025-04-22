Return-Path: <linux-kernel+bounces-614791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93CA97223
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 18:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C487C188E7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E31290BB0;
	Tue, 22 Apr 2025 16:13:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A03281352;
	Tue, 22 Apr 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338388; cv=none; b=LAm83tlgQNkCYcwyeNIsZ+NG7vXEU8FvlDV9CxK+DKKNW2jPympj0ngWbWRpXCA9okKFyR956wyDMICiT7jmgxtAkNVxEpgq/R/lLdlfgW/P7k1vyOYVRDCw15Zkg4k9XAzgbizja8VnFAe30sBH2z+y9vkY6ieY50/oAON4jP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338388; c=relaxed/simple;
	bh=lkfHBQRCLbTLa8njSs4KJ85m1TEWJJ16k65UksbYCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWbUD0QjHYBykaucVCoScNmA8g+JyOq1un1i/7YmPlVpEd9bU+rj5qagxKem8Xjc02hzXoMGauyom0Kbpgjp3lqIqB33HjRAfAlMj9p8gSsibuHI2Sg/nLy1DIGnQU1QC/cLLuXs4LDN7HDhX9/kd9CXuqpjHpp6c29jFNjznis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A1C4CEE9;
	Tue, 22 Apr 2025 16:13:04 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250422121454.523757af@gandalf.local.home>
In-Reply-To: <20250122122821.GN7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
	<20250122122821.GN7145@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


/me is resurrecting the sframe work

On Wed, 22 Jan 2025 13:28:21 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > The error has to be checked before the write to task->task_works.  Also
> > the try_cmpxchg() loop isn't needed in NMI context.  The TWA_NMI_CURRENT
> > case really is special, keep things simple by keeping its code all
> > together in one place.  
> 
> NMIs can nest, consider #DB (which is NMI like) doing task_work_add()
> and getting interrupted with NMI doing the same.
> 

I was looking at this patch and was thinking that the trycmpxchg() is still
for the race against other CPUs.

Another CPU can add a task_work for this task, right?

If so, then even though the NMI adding the task work can't be interrupted
(considering there's no #DB and such), it still can clobber an update done
for this tasks task_work from another CPU.

Is this patch still even needed?

-- Steve

