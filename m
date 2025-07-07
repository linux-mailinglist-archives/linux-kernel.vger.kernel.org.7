Return-Path: <linux-kernel+bounces-720655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A42AFBECF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A604A357A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D05F28727A;
	Mon,  7 Jul 2025 23:53:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D927713
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932406; cv=none; b=PdKaHDHh423/lgojmJyp0GI7Zac9carWgT1T6klX4zzJTbNpZr4pOc+cE+5kskUEfYsERwABtfQj6Q8Ip04++Ymg57qDymcNw8FFxQTHmjxeLKnbAs6laTAd3dGfkucuvnvshrh9Lk0af8JLTCwXq/wTM6Ex5iIhzeCky8x9RXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932406; c=relaxed/simple;
	bh=59a5+/4pwVWmNffzrQS7H7kdgAzRylgAqxxbC/2s9d0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFvtZWmVDS/Jb/uNw4h1Z6pCl02C2qXsNk6UhSszCVt2dyXvPZa/0Y6SLDqOxBf+bLhO9vDc7y/fyJ7f7NkHT6BX/6WqHfrT4IjuEjwOc3nMq/0obnMmCN4VOoy+eQkCNlULkcLZz9Kx2gOeNFc4Cp/ZQWfd6qfECSD8f4iUcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A7F68128A1D;
	Mon,  7 Jul 2025 23:53:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 3A4AA20026;
	Mon,  7 Jul 2025 23:53:19 +0000 (UTC)
Date: Mon, 7 Jul 2025 19:53:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 David Laight <david.laight.linux@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "bsegall@google.com" <bsegall@google.com>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250707195318.0c7f401d@gandalf.local.home>
In-Reply-To: <2ef88def90634827bac1874d90e0e329@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zwxk4nrxgdr6esdbrjgghoo5esugs38i
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3A4AA20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ENrYwZT/NTfM7vuG0zW8vu+8BvH8G/34=
X-HE-Tag: 1751932399-456642
X-HE-Meta: U2FsdGVkX199z3S/FAf93rtIrG8RFdh9Ta4tb9KZyL3x+dedBy82Lcaea/qCf0PcrkcR2rULmZF0CInp45KqYiBSyjYKMmyXbrJuf5s1rEJ4fJ0qyKFKoEGYUeKg6aJWfC7r+ylH5YnRHSfW29Q37auYKJZmYG74hzPzI02bg63kgxcFVFPwa0rBz8SMI7RyjqC0g3q4lEGR69IitXw57v1WjsjxA41B+oXgtk9wf7GhdEwGi3ZZEMn2/MaL2kPgtalHVGXImFhSCNlUCrB9RBTjUnasztYoV7UvNnGJypYltbapxxo3220jrm1Znh4Pzl9QfOBgdV5swCxCuNjWwHiaD7mUz6U+

On Mon, 7 Jul 2025 23:41:14 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> > On a second thought, this
> > 
> >     mul_u64_u64_div_u64(0x69f98da9ba980c00, 0xfffd213aabd74626,
> > 0x09e00900);
> >                         stime               rtime
> > stime + utime
> > 
> > looks suspicious:
> > 
> > 	- stime > stime + utime
> > 
> > 	- rtime = 0xfffd213aabd74626 is absurdly huge
> > 
> > so perhaps there is another problem?
> >   
> 
> it happened when a process with 236 busy polling threads , run about 904 days, the total time will overflow the 64bit
> 
> non-x86 system maybe has same issue, once (stime + utime) overflows 64bit, mul_u64_u64_div_u64 from lib/math/div64.c maybe cause division by 0
> 
> so to cputime, could cputime_adjust() return stime if stime if stime + utime is overflow
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 6dab4854..db0c273 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -579,6 +579,10 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>                 goto update;
>         }
> 
> +       if (stime > (stime + utime)) {
> +               goto update;
> +       }
> +
>         stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
>         /*
>          * Because mul_u64_u64_div_u64() can approximate on some
> 

Are you running 5.10.0? Because a diff of 5.10.238 from 5.10.0 gives:

@@ -579,6 +579,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
        }
 
        stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+       /*
+        * Because mul_u64_u64_div_u64() can approximate on some
+        * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+        */
+       if (unlikely(stime > rtime))
+               stime = rtime;
 
 update:


Thus the result is what's getting screwed up.

-- Steve

