Return-Path: <linux-kernel+bounces-720789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5119AFC065
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537C95607F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE521B8F5;
	Tue,  8 Jul 2025 02:01:11 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DFC20DD75
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940071; cv=none; b=jbYaeSpnS3326Z8R6xwSaT5HPq9cJIq9NfSHPPWWvu+1zF7QHp+epRQw9Gtw5yk3fbE6D2DXy1736MZLH/MXoWGUmHbGq3vIqgJZyuEfVG1UUsgbBz2Da3h5TJe0XBfZbE/KnM0Wxn7HjTq+4xh0yynP26okK6bIOLeHxGJ/Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940071; c=relaxed/simple;
	bh=z6y7IOeDjNMJhZTBF9Z0MIt6zjY4xdtUGncSaCBeI3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7SUg4jTN/fJcKnmxr6nPA9SHfdRf7jX2xgI/zzqvR6hcJDa/mDqsXwgem7VocjpQ3hhn03d7pjX3QyKNzSQEcHkisHH3I9Lkpu8E+DyNy4JLXqQhZcpIxhSpfm0XCtvtXYeNVJriL3YDizDyOlN4rDLAohmfAxu+AXmxzEV4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D17FF14042B;
	Tue,  8 Jul 2025 01:53:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 6229B20032;
	Tue,  8 Jul 2025 01:53:22 +0000 (UTC)
Date: Mon, 7 Jul 2025 21:53:22 -0400
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
Message-ID: <20250707215322.0e4ec431@gandalf.local.home>
In-Reply-To: <42f5344b80e244278aaf49f112498e02@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
	<20250707183331.029570bf@gandalf.local.home>
	<42f5344b80e244278aaf49f112498e02@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dt47jj1esr1161c1diqhqtdu7fobhh16
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6229B20032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jSp8rIk6Px7djoMX3FWrS8SmfaUcs64Y=
X-HE-Tag: 1751939602-601385
X-HE-Meta: U2FsdGVkX18gYAwzcgmsVOdNJwuaVqcHgd/fH9NYZfGpTE/lUTYSWWjG4E6Fvoy/9Wmx48p8z2DJHrwYyrHcTaTXR4T5Yyej6uoQdfRPGuRgvadBcDz47ZZgxuJZsg0q0NAVn1g2bIX6H7wjsDeR1w517AImqHuQxO3Soej9RZtX/ej+r6B+S0tLTpA+fvBZT0W40J12KzImNjQIxWeXBn3tOtrcKWNvahBBqdvzGqbljuiaJSVZmMkK1YR7pGcWZxsQIqSPeXQ28/Y2s0qre6RSx+lu/Dz9QAX/2juEwN2o7gxW20IlYOoENveuT0Lxe1X5D4wPsixLnbOEO4BWruV/mQm8/C2K

On Tue, 8 Jul 2025 01:40:27 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> > That would be:
> > 
> >                                    minutes    days
> >                                       v        v
> >   9223372036854775808 / 1000000000 / 60 / 60 / 24 / 365.25 = 292.27
> >                            ^               ^         ^
> >                         ns -> sec       hours       years
> > 
> > So the report says they have threads running for a very long time, it would still
> > be 292 years of run time!  
> 
> Utime/rtime is u64, it means overflow needs 292.27*2=584 year,
> 
> But with multiple thread, like 292 threads, it only need two years, it is a thread group total running time
> 
> 
> void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
> {
>     struct task_cputime cputime;
> 
>     thread_group_cputime(p, &cputime);
>     cputime_adjust(&cputime, &p->signal->prev_cputime, ut, st);
> }
> 

So you are saying that you have been running this for over two years
without a reboot?

Then the issue isn't the divider, it's that the thread group cputime can
overflow. Perhaps it needs a cap, or a way to "reset" somehow after "so long"?

-- Steve


