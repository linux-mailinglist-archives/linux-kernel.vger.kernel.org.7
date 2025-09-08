Return-Path: <linux-kernel+bounces-806455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31FB49703
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2220D3B450E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7833148D6;
	Mon,  8 Sep 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SvQISnKl"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145E3148CE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352866; cv=none; b=H/QXDMV7yKAyFyskl3HUex2E5EAGNGf7s8cPrP41v+mAJJWLP+YmY5sWEQtzUeHsK352zwzjdLOzc3IaPWrprbMVolbtL441lw6QblsbAI2lGCRmLBcOFEGQNajPTROQ2RKJIMO9mmY+1EVX/98NScQm8mzmRa0yVKmsvmq6T4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352866; c=relaxed/simple;
	bh=pgD1gNKpvNl5PPkW2ttuf0nOW9fRCBbgauUQRDFwsBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2T92Xi2wQUWgqBtpa7LCiGh7B0ymZIbshVrcL6aYyHL0ZqU8LdHBQBD4SC8BlYZErGBQYbjDKPHY42ILpISXW13A45XBq0bWLd37Gp8MBa+1wVB/jewGp4EQcaCCWrOp8AkF3o6/Pu6U48h9wFS3mp229lBtJgrzrRT7iCbErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SvQISnKl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 13:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757352862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RI+4qBnk3MrykJHWhGMohkHW+kG9BF8eSFcQInaYa7k=;
	b=SvQISnKlR1oILzgDvsjbRDxXubVynYLhCelBHtp/U9kB5wfTLXx0dUZiQAFKUapZTYrZsJ
	Ql5pbx7rrCtJ9O3NrYBT+FA/ZqbuZnWwHdVSHpiLIp83MUCTzhNwG3aKFcuU9018widx8q
	plU7OUU7PAG+fSXTz3ObRRiv7K5hyg4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Yueyang Pan <pyyjason@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sourav Panda <souravpanda@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
 <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLFKHGe2loD657fu@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 29, 2025 at 08:35:08AM +0200, Michal Hocko wrote:
> On Tue 26-08-25 19:38:03, Suren Baghdasaryan wrote:
> > On Tue, Aug 26, 2025 at 7:06 AM Yueyang Pan <pyyjason@gmail.com> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 12:53:03PM -0700, Shakeel Butt wrote:
> > > > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > > > Right now in the oom_kill_process if the oom is because of the cgroup
> > > > > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > > > > can have a large cgroup workload running which dominates the machine.
> > > > > > > The reason using cgroup is to leave some resource for system. When this
> > > > > > > cgroup is killed, we would also like to have some memory allocation
> > > > > > > information for the whole server as well. This is reason behind this
> > > > > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > > > > information for people? I am happy with any suggestions!
> > > > > >
> > > > > > For a single patch, it is better to have all the context in the patch
> > > > > > and there is no need for cover letter.
> > > > >
> > > > > Thanks for your suggestion Shakeel! I will change this in the next version.
> > > > >
> > > > > >
> > > > > > What exact information you want on the memcg oom that will be helpful
> > > > > > for the users in general? You mentioned memory allocation information,
> > > > > > can you please elaborate a bit more.
> > > > > >
> > > > >
> > > > > As in my reply to Suren, I was thinking the system-wide memory usage info
> > > > > provided by show_free_pages and memory allocation profiling info can help
> > > > > us debug cgoom by comparing them with historical data. What is your take on
> > > > > this?
> > > > >
> > > >
> > > > I am not really sure about show_free_areas(). More specifically how the
> > > > historical data diff will be useful for a memcg oom. If you have a
> > > > concrete example, please give one. For memory allocation profiling, is
> > >
> > > Sorry for my late reply. I have been trying hard to think about a use case.
> > > One specific case I can think about is when there is no workload stacking,
> > > when one job is running solely on the machine. For example, memory allocation
> > > profiling can tell the memory usage of the network driver, which can make
> > > cg allocates memory harder and eventually leads to cgoom. Without this
> > > information, it would be hard to reason about what is happening in the kernel
> > > given increased oom number.
> > >
> > > show_free_areas() will give a summary of different types of memory which
> > > can possibably lead to increased cgoom in my previous case. Then one looks
> > > deeper via the memory allocation profiling as an entrypoint to debug.
> > >
> > > Does this make sense to you?
> > 
> > I think if we had per-memcg memory profiling that would make sense.
> > Counters would reflect only allocations made by the processes from
> > that memcg and you could easily identify the allocation that caused
> > memcg to oom. But dumping system-wide profiling information at
> > memcg-oom time I think would not help you with this task. It will be
> > polluted with allocations from other memcgs, so likely won't help much
> > (unless there is some obvious leak or you know that a specific
> > allocation is done only by a process from your memcg and no other
> > process).
> 
> I agree with Suren. It makes very little sense and in many cases it
> could be actively misleading to print global memory state on memcg OOMs.
> Not to mention that those events, unlike global OOMs, could happen much
> more often.
> If you are interested in a more information on memcg oom occurance you
> can detext OOM events and print whatever information you need.

"Misleading" is a concern; the show_mem report would want to print very
explicitly which information is specifically for the memcg and which is
global, and we don't do that now.

I don't think that means we shouldn't print it at all though, because it
can happen that we're in an OOM because one specific codepath is
allocating way more memory than we should be; even if the memory
allocation profiling info isn't correct for the memcg it'll be useful
information in a situation like that, it just needs to very clearly
state what it's reporting on.

I'm not sure we do that very well at all now, I'm looking at
__show_mem() ad it's not even passed a memcg. !?

Also, if anyone's thinking about "what if memory allocation profiling
was memcg aware" - the thing we saw when doing performance testing is
that memcg accounting was much higher overhead than memory allocation
profiling - hence, most kernel memory allocations don't even get memcg
accounting.

I think that got the memcg people looking at ways to make the accounting
cheaper, but I'm not sure if anything landed from that.

