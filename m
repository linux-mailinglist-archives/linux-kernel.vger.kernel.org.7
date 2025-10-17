Return-Path: <linux-kernel+bounces-857645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455DBE7547
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388A3626F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E12D543A;
	Fri, 17 Oct 2025 08:58:32 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD22BE7D9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691512; cv=none; b=DMkyRVBXvhMtFAi5kyQZtmTV6f2x+d6SvGnponq6t68hkxYL2nf6RlR3Ni5Bv1cmbhBQX0IRjDt1jr11CiDmxtGvZ3FLu+azxSTzi2h+Icui7K2hIFC52NnDtUw8VBdNdt8+TKXy0BS8hckwyp6Aqjzzn+GaL/OEgn6uMNNF6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691512; c=relaxed/simple;
	bh=2X701DJUSwexjym3gY3cjzmqUeoQGSHeuVLX6ygHnZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNo6vr739y0aw1AM5x6xsKAzBuKdWfOLfa0i9wSe9fRnL3p9CspucmiGWG8G4jSYFsqmFsCeLsIJceL4PWu8xYCdSb+hB3jtO/8Me0yDqizplCGwg6J9CvgI4ZXVr9LNyYO2YIIOpozfMaOzfH9OxanY2puMoUjBVj3XRjP5Hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 42B5F59EE2;
	Fri, 17 Oct 2025 08:58:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 17B3217;
	Fri, 17 Oct 2025 08:58:19 +0000 (UTC)
Date: Fri, 17 Oct 2025 04:58:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: XueBing Chen <chenxb_99091@126.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix code indentation at line 10371
Message-ID: <20251017045817.137483e1@batman.local.home>
In-Reply-To: <20251017064152.48490-1-chenxb_99091@126.com>
References: <20251017064152.48490-1-chenxb_99091@126.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9wm77zof4nkfya98g678kxasg6dbemei
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 17B3217
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188ENMsA3Vumyarw/nD2Uzyj5/UTcIxT9s=
X-HE-Tag: 1760691499-884447
X-HE-Meta: U2FsdGVkX1+bQJAlaELIL4dd9gWsSeXj9AlAFOEgTCRGAcIV0b0JleuljMmJ/480ANQfDsgoSlJlIYch4yKQIv1xyjFrrwB4f/OhNUngBDF0ZqCFm1l9jJbFpEjW781B13D0dyrVqNqiiZhhz1us5kRQMdeQ8j/gSeDh+Y51FtMIXCpqUwz0l3bM3720YCscDTTy0AfYr9jC2NsL7FJTLxTwFp+oKcIREgxIoRMJK1igyv50Oh3s8w+Zj06ubbiYWglqdUlvOYlIJn9wzZaku5rR3PO+39U9dtJR0Ly1tuTgJ6szgz5taaEFmLDatGGV9fc5KdR2f84xw8WHUI73k1kSOW7HMzuO+u55Mm7e+UrXnvaYjqgL4ZSN9j1sEQVG

On Fri, 17 Oct 2025 14:41:52 +0800
XueBing Chen <chenxb_99091@126.com> wrote:

> Fix checkpatch.pl indentation warning by replacing spaces with tab.

checkpatch.ps is to be used on patches *AND NEVER EXISTING CODE*!

Please do not "fix" existing code with what checkpatch complains about,
unless it's a real bug. That's not its purpose. This just adds noise to
the git log.

NAK.

-- Steve


> 
> Signed-off-by: XueBing Chen <chenxb_99091@126.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 198d2dd45..24fd78d42 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10368,7 +10368,7 @@ const u32 sched_prio_to_wmult[40] = {
>  
>  void call_trace_sched_update_nr_running(struct rq *rq, int count)
>  {
> -        trace_sched_update_nr_running_tp(rq, count);
> +	trace_sched_update_nr_running_tp(rq, count);
>  }
>  
>  #ifdef CONFIG_SCHED_MM_CID


