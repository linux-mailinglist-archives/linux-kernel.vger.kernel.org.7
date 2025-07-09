Return-Path: <linux-kernel+bounces-723912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDCAFEC61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6432E17D483
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B92E5B0A;
	Wed,  9 Jul 2025 14:40:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E712E3B1E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072024; cv=none; b=d/nADgCmrQ7SJRVyKeMItwL806CO9QNEn4qeeqolxfcnD1MnKkPUppvrSSf3wPmAXQ/TS8VChe1g61rh0GY3ICiRCGpTg8VmEIdigKQo30IMg0Jiv/kjvGKwcnS0Xz1US3YNJYIUzDjuRHX68n3I/f/fnpaWDPNKzQLEbpyIHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072024; c=relaxed/simple;
	bh=+wiF1mWfrRX/2nd2AOlkGQKaziBZSRMRaVApHmfDW1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1jsNXuMxsrP4OxVL83PrefcyaMJ63kl6U9vyIAlDMgIg9ZoA74CiJuoZISNoVx16RXvLRHC5pnWKU7t0k/fgQ/xXxAGBpbYotFHKV3VzzS1tXFbgWsoShZryIz1TPAoQn70cOkDg8jeYpR10xR+LfpxGjz20TLKNq75eu7jQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id AFB1B140540;
	Wed,  9 Jul 2025 14:40:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 0B2FC20011;
	Wed,  9 Jul 2025 14:40:18 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:40:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Chillara <quic_achillar@quicinc.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] tracing: Prevent double unregister of tracepoint
 probes
Message-ID: <20250709104017.69190334@batman.local.home>
In-Reply-To: <20250709-fix-double-perf-probe-unregister-v1-2-2b588b3c0140@quicinc.com>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
	<20250709-fix-double-perf-probe-unregister-v1-2-2b588b3c0140@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dnokiu6mc51n7f8gcodffz7ho97uf87c
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0B2FC20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0bJeFijTuz8/ZNXl7BNW8Ds+81Svj7oU=
X-HE-Tag: 1752072018-302675
X-HE-Meta: U2FsdGVkX1+Zt3Adlh1n+22dMlWnMcXKeIEDMXvzuDY2MkspvQvc2Gp8ua0hb5vlI+pw72c3P4p7b7p1/A1yBluoV2rdL7W2t6EUn/a/CLIlHipiu6Ej+eY2Lcv3A3TuMcRS0Bkt+DFwdcw97Pdvw7fPRTeyQaIu8nMkMQ0xgY+FuycvSyZ0JDFdJg1Ygod3RZ8dkVomo/OMcYKFiPNxduqkZNLMTY/4+/DCmZg8weUxn699L5fC9wKOCSmRjy2CFCZro6pSDoaN3VtDwgtNARhHGhC7embtusnqqNvLnDl0+RIc1XOaEkh9cRgxnPfzZA3+69bLLkKfd2gIsrTRg5J2q0Sdy513beRlf0ASg47YkNk0mYooA/mHsj99mAl8

[ Added Mathieu who is the author of the tracepoint code ]

On Wed, 9 Jul 2025 11:11:10 +0530
Aditya Chillara <quic_achillar@quicinc.com> wrote:

> Prevent tracepoint_probe_unregister from being executed multiple times
> for the same probe, which can cause issues with perf due to the lack
> of error handling.
> 
> Return an error if the probe is not present in the list of probes.

This patch even shows that the first patch is fixing a symptom.

Yes, I agree with this patch (with some cleanups below), but there
should be no reason for perf to be ever calling unreg() if it doesn't
have a tracepoint registered. Something else got screwed up in the mean
time.

> 
> Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
> ---
>  kernel/tracepoint.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index ef42c1a1192053cc05b45ccb61358a4996453add..e6eee7e44a9d6f4f19114fbcf8fd9e5c85075324 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -232,7 +232,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  static void *func_remove(struct tracepoint_func **funcs,
>  		struct tracepoint_func *tp_func)
>  {
> -	int nr_probes = 0, nr_del = 0, i;
> +	int nr_probes = 0, nr_del = 0, nr_tp_stub_del = 0, i;
>  	struct tracepoint_func *old, *new;
>  
>  	old = *funcs;
> @@ -246,11 +246,18 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
>  			if ((old[nr_probes].func == tp_func->func &&
>  			     old[nr_probes].data == tp_func->data) ||
> -			    old[nr_probes].func == tp_stub_func)
> +			    old[nr_probes].func == tp_stub_func) {
> +				if (old[nr_probes].func == tp_stub_func)
> +					nr_tp_stub_del++;
>  				nr_del++;
> +			}

I would make this a bit cleaner by:

 			if ((old[nr_probes].func == tp_func->func &&
 			     old[nr_probes].data == tp_func->data))
				nr_del++;

			 if (old[nr_probes].func == tp_stub_func)
				nr_tp_stub_del++;
>  		}
>  	}
>  
> +	/* If there is nothing to delete, do not allow */
> +	if (nr_del - nr_tp_stub_del == 0)
> +		return ERR_PTR(-ENOENT);

	if (!nr_del)
		return ERR_PTR(-ENOENT);

	nr_del += nr_tp_stub_del;

-- Steve

> +
>  	/*
>  	 * If probe is NULL, then nr_probes = nr_del = 0, and then the
>  	 * entire entry will be removed.
> 


