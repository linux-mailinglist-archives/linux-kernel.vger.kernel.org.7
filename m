Return-Path: <linux-kernel+bounces-840204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F57BB3D27
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B549325CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031527F010;
	Thu,  2 Oct 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mgD4MLp7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCB304BC6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405875; cv=none; b=UH84oOCY/I+RoEBKStiSVnmIDAHZA1O71m07ef3kIXn49h7gbB+wMpukOK4M0O+HVCO9zUW+p/OSDdyR9eP/3FE8OgXUjMZQPbqlY7xX2RsM2jULCE1Upy7c1c11fWdaP9OE5CssYcJWIXr1CpwNp2VrRTE8T0L2+FgXVNT1lv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405875; c=relaxed/simple;
	bh=yLBbZ9jfwcCAUUW6go/oHQkQFqPUDBxewKa/dr1Crjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9drcHDauRr+AAX10HxxYjY0r07cVhjXrPhNEtKjaz/GO1a3jMEUa/ypOjyz4Pdn3PiXfjtaq8R5B5u2frLVDT2fiEBwsTx4UuYVayGZf9vOjWOe9GLYbpdrR8vtXrIe873efWNj7Li2ELWahfZJdTrQvZUKFccnYyiqUtgBmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mgD4MLp7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ioO2N+FXkPcJWuPZKGaDiYhArSpzEuAlf3L8sLL3grs=; b=mgD4MLp7j6I4EeZt5ngGOfslTA
	99ulM+lgOr/GfAiW9tU8+xrgVYFVsNoq4PvJRro+PaLErPgFQTcUF+qfcRJJ2/JKAJcNAK2NIPEbh
	c0LmU+NBT2Kuwze5y+KHLTQ/e6bNtL56y5+CoIjKcvuh6cVGzFSc+CntaEhJUOej9QAbDNl85z0Kb
	uUbXPQ7jqG8VWSWTMhGsWWF7gdY6SzPYHfOthfElH7740E6oHv4K1mH1mswxlXMtUP3iUzN/B54ML
	IGqL3Eprs1YSeRK7nIOmZtJqFopgG+W/Wk0O/QI3m+kBz1ochLDlUzOCkVl9Y8/RkJgolXiVaT6lm
	rSlXuZ6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4HpU-0000000EG2G-230o;
	Thu, 02 Oct 2025 11:50:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE6B9300754; Thu, 02 Oct 2025 13:50:34 +0200 (CEST)
Date: Thu, 2 Oct 2025 13:50:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 07/28] sched: Add helper function to decide
 whether to allow cache aware scheduling
Message-ID: <20251002115034.GS3419281@noisy.programming.kicks-ass.net>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
 <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
 <89c777b7-33bd-400d-8b6f-4e6d697dc632@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c777b7-33bd-400d-8b6f-4e6d697dc632@intel.com>

On Thu, Oct 02, 2025 at 07:31:40PM +0800, Chen, Yu C wrote:
> On 10/1/2025 9:17 PM, Peter Zijlstra wrote:
> > On Sat, Aug 09, 2025 at 01:03:10PM +0800, Chen Yu wrote:
> > > From: Tim Chen <tim.c.chen@linux.intel.com>
> > > 
> > > Cache-aware scheduling is designed to aggregate threads into their
> > > preferred LLC, either via the task wake up path or the load balancing
> > > path. One side effect is that when the preferred LLC is saturated,
> > > more threads will continue to be stacked on it, degrading the workload's
> > > latency. A strategy is needed to prevent this aggregation from going too
> > > far such that the preferred LLC is too overloaded.
> > 
> > So one of the ideas was to extend the preferred llc number to a mask.
> > Update the preferred mask with (nr_threads / llc_size) bits, indicating
> > the that many top llc as sorted by occupancy.
> > 
> > 
> 
> Having more than one preferred LLC helps prevent aggregation from going
> too far on a single preferred LLC.
> 
> One question would be: if one LLC cannot hold all the threads of a process,
> does a second preferred LLC help in this use case? Currently, this patch
> gives up task aggregation and falls back to legacy load balancing if the
> preferred LLC is overloaded. If we place threads across two preferred LLCs,
> these threads might encounter cross-LLC latency anyway - so we may as well
> let
> legacy load balancing spread them out IMO.

Well, being stuck on 2 LLCs instead of being spread across 10 still
seems like a win, no?

Remember, our friends at AMD have *MANY* LLCs.

> Another issue that Patch 7 tries to address is avoiding task
> bouncing between preferred LLCs and non-preferred LLCs. If we
> introduce a preferred LLC priority list, logic to prevent task
> bouncing between different preferred LLCs might be needed in
> load balancing, which could become complicated. 

It doesn't really become more difficult to tell preferred LLC from
non-preferred LLC with a asm. So why should things get more complicatd?


Anyway, it was just one of the 'random' ideas I had kicking about.
Reality always ruins things, *shrug* :-)

