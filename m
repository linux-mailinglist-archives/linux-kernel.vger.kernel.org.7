Return-Path: <linux-kernel+bounces-897452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2EC53156
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 954DC4FCC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E93054F2;
	Wed, 12 Nov 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QE+tYIDk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9D23F431
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958655; cv=none; b=O0VV6god1QAuKgnGkFV6Mf71PR++eeJhE+etiM0gQ4qh/n/D1J4EXHRCjCwGcIJSJZ8F0H1WSG2/BK8uXwC+iDBfOfXyaxDvAvoD0AdDOGG/7hq/ddr1kiDGMNcq2ZrWf2rAB+0JMxN6ARz7nITTUJsFHKf99P3ofqiCxWOfVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958655; c=relaxed/simple;
	bh=uB8d7JtKTTmDsaF5Tr+v7fqtYO6IKYX+h65FpevQW0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el+F3VJG5lqWFWRtIqqslUNjS5U3bolLoeYq/ox/yqhVRBGXP9R7bTs2J9L15rt6JUJ4qeDi1h3cn7uwpcRX3UWvPoL7yTIfB8Q43cKHsLvcTb5RMovPJ0l0NbVUAxXBZX3sgIp8UMBkJLGfzdSxUAJJ7Brd30azSqlCibnhrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QE+tYIDk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b729a941e35so145602166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762958652; x=1763563452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLIg4vHVi3UzjZEgn5d3+DJwJQ3Me/YDQDfOXcmSEOw=;
        b=QE+tYIDkEQoChdRTTeoxNL3ui+lj5s+JnZzHIXO/57Vd/+l1uKukdroqiXdBgy62bX
         lAcG0KgCIKuKgyTnmRU5YGxuik4tP5gbm3E5SA1cf3xHKtY3wWAw3FSjtDOGYR1d60MA
         ES7YP8E7Z3hlfRZK1uxRka1+aoGlAjinTqsRLcnqI80R74H1AUYyvL2QxUah2x6dZCIb
         GdCKlSsU6f56/tjRnK6fJUrCUmlnH/ToS7aJah0x1y4xSnyX7x/Ax5BhIDmBPixB+s/d
         WM2YTPLKPmganNExvltUdUB4ruv8mJLQL6Gu1e8WKcxVoidNJMxmDdURWKz/tATm9FMa
         dh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958652; x=1763563452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLIg4vHVi3UzjZEgn5d3+DJwJQ3Me/YDQDfOXcmSEOw=;
        b=D8jkt7bcvNO11aQEjK7NvUiSu8Qw5NekPHQEzM1CU2IOghFYJmUAMRoso7DQh1H4KQ
         AERoR1t2lUNdrEM+DXxStxJ9UZM8Mt5pw0R84a2M+q8VOLUAL1xmUfKeAhIXu0Sx5KZL
         i0MamnHh4heRnNnuqxNQ4nOIZsGw5aiYxR4mR1k3dG99nBBWRsa2GbtKqetTft6kG/Ol
         njYV7M2aRaxQDGVl7AEU4ybLxvcfCDRtXE1G62+hirqrYa4QypHvh24p5U+1aCnCxFmR
         zid0z1sZwTuI2ruFbMo8OJz3QPKOd6ldqQcNwLEtbWhyU8iqY8haGM/yq8dCN2KLE043
         eS+A==
X-Forwarded-Encrypted: i=1; AJvYcCXSwKbNv6JCgxz1BgVc3aI1E8rf7rP9pp+EHsuOrcF3k9XOlVcNv6OXIZRke536iaApfZ3uVxY669X5Sq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqlzlVhQ2aXFK6mQvy4p1ZL4nlCZUTnsEPGWUnzIJghj8Q4JJ
	JScOh7os3CrKWNnuUwEE1SHYLNP5ZleOvTFEyJFyrzRRhhp8TQ+YMaYTLcJ4kPWbCg1lZsxxC4C
	+kQnDmEA=
X-Gm-Gg: ASbGnctgMMn772wLJ6IUAQj4Zkpz8Ul37gK4aYh0YH5cL/KQhum6wvfxhmE/8wOUdwU
	QtTkdxref3+sZssGa1/fPpbwBVYHQGsn+jOWgRXPBml8DCrDI/5YyXaCU2ld3gvDkcl7FlhUHDV
	tO9LYLw5pQ2jsodWlEZABsPABmMjf6k58rJfLUDt9GzGZJpjxJdrgBS0+QoR/2r/Huvs9rQvcwH
	OWOr//uzgMgH2g/fSqDa82iilQMEwdjboNY7LZE79Sp8XM0I09QLHfqrskyGQOGAJ5rpUJ29wNR
	hkScHH38mt4P+qeIEZyP/76tv2d3MNkmlVeSmfbid9IiemnjBAgmshxQ01r6b0UuJA5TZeQAp/L
	72KxlUky9La8XW6cqFIKHdK3JpfjKmENBuElXqtQ0PfE6NLAcaQwH/lXX0+w4lzl5uhd+rb4yuE
	Lh1i4=
X-Google-Smtp-Source: AGHT+IFVBPavB+srd//2HfzL1+TTC9nQ/mWcrqEp7JRXj5iTIb1kQGBJxTMGJNbkKlt1nf6vpk85BQ==
X-Received: by 2002:a17:906:4794:b0:b73:42df:27a with SMTP id a640c23a62f3a-b7342df0b7emr41109666b.1.1762958651890;
        Wed, 12 Nov 2025 06:44:11 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm1596553966b.56.2025.11.12.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:44:11 -0800 (PST)
Date: Wed, 12 Nov 2025 15:44:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
Message-ID: <aRSdOfA3bgvCzdfH@pathway.suse.cz>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
 <aRInLdgKCzaVeyG0@pathway.suse.cz>
 <aRRupyzGaP5Z35qE@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRRupyzGaP5Z35qE@U-2FWC9VHC-2323.local>

On Wed 2025-11-12 19:25:27, Feng Tang wrote:
> On Mon, Nov 10, 2025 at 06:55:57PM +0100, Petr Mladek wrote:
> > On Thu 2025-11-06 10:30:31, Feng Tang wrote:
> [...]
> > @@ -315,8 +295,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >  {
> >  	int max_count = sysctl_hung_task_check_count;
> >  	unsigned long last_break = jiffies;
> > +	unsigned long total_hung_task;
> >  	struct task_struct *g, *t;
> >  	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
> > +	unsigned long si_mask;
> >  
> >  	/*
> >  	 * If the system crashed already then all bets are off,
> > @@ -325,6 +307,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >  	if (test_taint(TAINT_DIE) || did_panic)
> >  		return;
> >  
> > +	si_mask = hung_task_si_mask;
> > +	if (sysctl_hung_task_warnings || hung_task_call_panic) {
> > +		si_mask |= SYS_INFO_LOCKS;
> > +
> > +		if (sysctl_hung_task_all_cpu_backtrace)
> > +			si_mask |= SYS_INFO_ALL_BT;
> > +	}
> 
> This probably needs to be moved to after the loop check of
> check_hung_task(). 

I did it on purpose because "sysctl_hung_task_warnings" might get
decremented down to "0" in the loop below. But IMHO, we need to print
the information if it was non-zero at the beginning.

It might be worth to add a comment why it has to be done
before the cycle.

> > +
> >  	rcu_read_lock();
> >  	for_each_process_thread(g, t) {
> >  

Best Regards,
Petr

