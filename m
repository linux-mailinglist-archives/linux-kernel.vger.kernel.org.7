Return-Path: <linux-kernel+bounces-720684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D9AFBF36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722A71AA15BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3445C14;
	Tue,  8 Jul 2025 00:31:05 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5A7464
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934665; cv=none; b=nupOm/8clrsd/b3sjRXL8EcPM0lyGqEl3GOBcC9xEft1ZQHJHQJEqJ0kxL4kOTC06HY/Weo9IcHsq+JqXZwiJjM3fKiO+FzPzbV/V13Ug82EGRLBUR1jv41gg2R74cbJZYT20ipRU4De5Og3dfOmmFIJU9fSSG37ygP7EX6d7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934665; c=relaxed/simple;
	bh=K0sJvhgBni0qpDPlyYY31bsz0DezBvm3KWMurIZHMo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4vJcJlhpmNrAFvneiVuiD4LXBx0Zi8V19HZ8Q8+lE6TiGxsxldL/QCQ1q5ESlNxaID+NOq4Ee0ITovaHV90OuCWOQff9NvAk4LeRwxJHlnUJnIuY6ZlcxcdSbLVUBXLoenbT/96smRz87CwaktX0up1qxZ4E58aPj6HiQBvAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 390911403F2;
	Tue,  8 Jul 2025 00:31:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C40FE20025;
	Tue,  8 Jul 2025 00:30:57 +0000 (UTC)
Date: Mon, 7 Jul 2025 20:30:57 -0400
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
Subject: Re: [????] Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250707203057.1b2af73d@gandalf.local.home>
In-Reply-To: <92674f89641f466b9ebbdf7681614ed3@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707223038.GB15787@redhat.com>
	<2ef88def90634827bac1874d90e0e329@baidu.com>
	<20250707195318.0c7f401d@gandalf.local.home>
	<92674f89641f466b9ebbdf7681614ed3@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C40FE20025
X-Stat-Signature: 6xwmoezwzqecxawrhstfi5g3by4h9p1t
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wBa9r7q/YrFmBm/Xar4TtHkEkohqJ52o=
X-HE-Tag: 1751934657-499278
X-HE-Meta: U2FsdGVkX18Ro957qeYRqTSwbZhR6As9dr4VgOcDJHZeal93lkbxQEtjUYIxvyKfsn9HIf3kQveGxVb6vDKOUdyIhW/6JH9G7Dm54Qi3CmypT363uB1s1nKcviSvNcOgRpfOSryqf5+y38lQIspdnVL3xtzvLjvV/AHL2GQmH+77SY3yiRRafbVPDztRfCsyBCJAUib5zL6Vk52c/4r7L/pSyCArx8IfQgsWtTCR/wzuO9zQI7Qqp5dHbQexr0HxNtlpLn7Pq6KCc8Vb2Lq91oDwAz0SB8KpYfp6SyIF9I7e7r5DaDx0aF0/VirYBmf6PbZAl9Hsin5VfgQwp3xx163xJ5KZ8LhC

On Tue, 8 Jul 2025 00:10:54 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> >         stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> > +       /*
> > +        * Because mul_u64_u64_div_u64() can approximate on some
> > +        * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> > +        */
> > +       if (unlikely(stime > rtime))
> > +               stime = rtime;  
> 
> 
> My 5.10 has not this patch " sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime ",
> but I am sure this patch can not fix this overflow issue, Since division error happened in mul_u64_u64_div_u64()

Have you tried it? Or are you just making an assumption?

How can you be so sure? Did you even *look* at the commit?

    sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime
    
    In extreme test scenarios:
    the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
    utime = 18446744073709518790 ns, rtime = 135989749728000 ns
    
    In cputime_adjust() process, stime is greater than rtime due to
    mul_u64_u64_div_u64() precision problem.
    before call mul_u64_u64_div_u64(),
    stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
    after call mul_u64_u64_div_u64(),
    stime = 135989949653530
    
    unsigned reversion occurs because rtime is less than stime.
    utime = rtime - stime = 135989749728000 - 135989949653530
                          = -199925530
                          = (u64)18446744073709518790
    
    Trigger condition:
      1). User task run in kernel mode most of time
      2). ARM64 architecture
      3). TICK_CPU_ACCOUNTING=y
          CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
    
    Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime


When stime ends up greater than rtime, it causes utime to go NEGATIVE!

That means *YES* it can overflow a u64 number. That's your bug.

Next time, look to see if there's fixes in the code that is triggering
issues for you and test them out, before bothering upstream.

Goodbye.

-- Steve

