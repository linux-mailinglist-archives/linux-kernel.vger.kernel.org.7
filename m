Return-Path: <linux-kernel+bounces-780542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD1B3033A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656E51C83043
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79F3451B0;
	Thu, 21 Aug 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o1yC6A/4"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C632E8B80
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805992; cv=none; b=R3qmBqdv0GOuYWnU4blN4ixafwKsrDvneJNhwlNDTkP/mu4FL1+CKdzLeBVnaLd7WXdvWlAbYo7Bl8D8ScNjvtZAxGviv/oqVCke5gAQ3WiIA0FsLuNqRh2vyo52pqQ/YaxnaAqqmpSAs7JEebCWBu396LgVs2FlDL80cuD7Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805992; c=relaxed/simple;
	bh=u96Uv83YnGa8eeJgKmSXSyAJdR8Al8WgTTQ1XdualO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNlyrvmZz1u5XFV9Gocbh7NweMUD+EWZkBM4bpNLXFXfxKwYHiJ4EnhvahPPp5WeGjBQ4sDVSHaY6SYPeuyv7B6N6qqr9RpunsQO0awpfiYl30hHl0SBqXOkhSENKi3IlOV6B7V+hENUuyRqlH+LbqXtXAuirLnJqKZ06zuVZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o1yC6A/4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 12:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755805987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpvhqNtwaoyMgWmFR5mwGylcVpnj0fZDmJSFlxK6MrA=;
	b=o1yC6A/4MYpDYec+ATsSlQvU4cv7FEoHdPAkutVaf6y41WvCnonOpwaNPIZ97ErDDm5LNT
	MbP9JeKXJj3IbIorKChzLj6Svci8zwwRjZERbaM8OhmfRR6dc6z3DQEGh8D7Fy3v1XLk4v
	Lg0l76RFV4mxF0xN285lCCqY6CO/o2U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > Right now in the oom_kill_process if the oom is because of the cgroup 
> > > limit, we won't get memory allocation infomation. In some cases, we 
> > > can have a large cgroup workload running which dominates the machine. 
> > > The reason using cgroup is to leave some resource for system. When this 
> > > cgroup is killed, we would also like to have some memory allocation 
> > > information for the whole server as well. This is reason behind this 
> > > mini change. Is it an acceptable thing to do? Will it be too much 
> > > information for people? I am happy with any suggestions!
> > 
> > For a single patch, it is better to have all the context in the patch
> > and there is no need for cover letter.
> 
> Thanks for your suggestion Shakeel! I will change this in the next version.
> 
> > 
> > What exact information you want on the memcg oom that will be helpful
> > for the users in general? You mentioned memory allocation information,
> > can you please elaborate a bit more.
> > 
> 
> As in my reply to Suren, I was thinking the system-wide memory usage info 
> provided by show_free_pages and memory allocation profiling info can help 
> us debug cgoom by comparing them with historical data. What is your take on 
> this?
> 

I am not really sure about show_free_areas(). More specifically how the
historical data diff will be useful for a memcg oom. If you have a
concrete example, please give one. For memory allocation profiling, is
it possible to filter for the given memcg? Do we save memcg information
in the memory allocation profiling?

