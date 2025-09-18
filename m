Return-Path: <linux-kernel+bounces-788863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5591B38B43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961003B14CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46282D46B4;
	Wed, 27 Aug 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HM+MoNbM"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB8149C6F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329332; cv=none; b=YUL0Ck2ERyXLEoExQc4I6sTJxa1gMP9TmQrOyqnJG3ZorIDh4q6M4UC35og2lyRr3frYgHQJ6pxdGrxFLvFjQXTCHNaEyIqA47mbC65Q60vnnbJKFq89Val0BQlDXXclTGGuUfl0LGuTELtyDfYBXtkhnstlOBDUhi59tjqdS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329332; c=relaxed/simple;
	bh=EjEuwO68MZNs1T0NGo3hCuUSMM1gRk/jrT/8Jsa/fjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOVHxvYNBBhkykm6TB+5NCFx3WorLkHQa4H/6jBvgkcPWSBL+yvXRY6/V+/FB5Iy5gNLbUNkYJIWnTNho8pptsJxGjtUQD3KoMoNXK/QP4A9haI3RnPu9xWWraxkGKjpCz1peb56wZuSt/9KQoApRgbBN7aGDW63HcoBl3zPVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HM+MoNbM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 14:15:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756329326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcc5U5sbYk7C+fJouaFaLhZUqm8inNlgZ+ZSLJCNPX4=;
	b=HM+MoNbMsASGnf9PdqLIBZiLT7S/fvLPSA+4c+b2WmnR90L0kJ3APowlgO5+qbgAzEU6Lq
	UiCQbQHsZyBvPNuf1ozbITBcpLgxRV4AThg5lumSZk/ANCftpc5c7/iITOteh9CZQh0sMv
	fnZBlC+Cy8vru9NSp39gtom8KRaS2/M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <5o52rxp4ujglel53cs6ii2royaczuywuejyn7kbij6jknuglmf@frk4omt5ak7d>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 07:32:17PM -0700, Suren Baghdasaryan wrote:
> On Thu, Aug 21, 2025 at 12:53 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > Right now in the oom_kill_process if the oom is because of the cgroup
> > > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > > can have a large cgroup workload running which dominates the machine.
> > > > > The reason using cgroup is to leave some resource for system. When this
> > > > > cgroup is killed, we would also like to have some memory allocation
> > > > > information for the whole server as well. This is reason behind this
> > > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > > information for people? I am happy with any suggestions!
> > > >
> > > > For a single patch, it is better to have all the context in the patch
> > > > and there is no need for cover letter.
> > >
> > > Thanks for your suggestion Shakeel! I will change this in the next version.
> > >
> > > >
> > > > What exact information you want on the memcg oom that will be helpful
> > > > for the users in general? You mentioned memory allocation information,
> > > > can you please elaborate a bit more.
> > > >
> > >
> > > As in my reply to Suren, I was thinking the system-wide memory usage info
> > > provided by show_free_pages and memory allocation profiling info can help
> > > us debug cgoom by comparing them with historical data. What is your take on
> > > this?
> > >
> >
> > I am not really sure about show_free_areas(). More specifically how the
> > historical data diff will be useful for a memcg oom. If you have a
> > concrete example, please give one. For memory allocation profiling, is
> > it possible to filter for the given memcg? Do we save memcg information
> > in the memory allocation profiling?
> 
> Actually I was thinking about making memory profiling memcg-aware but
> it would be quite costly both from memory and performance points of
> view. Currently we have a per-cpu counter for each allocation in the
> kernel codebase. To make it work for each memcg we would have to add
> memcg dimension to the counters, so each counter becomes per-cpu plus
> per-memcg. I'll be thinking about possible optimizations since many of
> these counters will stay at 0 but any such optimization would come at
> a performance cost, which we tried to keep at the absolute minimum.
> 
> I'm CC'ing Sourav and Pasha since they were also interested in making
> memory allocation profiling memcg-aware. Would Meta folks (Usama,
> Shakeel, Johannes) be interested in such enhancement as well? Would it
> be preferable to have such accounting for a specific memcg which we
> pre-select (less memory and performance overhead) or we need that for
> all memcgs as a generic feature? We have some options here but I want
> to understand what would be sufficient and add as little overhead as
> possible.

Thanks Suren, yes, as already mentioned by Usama, Meta will be
interested in memcg aware allocation profiling. I would say start simple
and as little overhead as possible. More functionality can be added
later when the need arises. Maybe the first useful addition is just
adding how many allocations for a specific allocation site are memcg
charged.


