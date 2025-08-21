Return-Path: <linux-kernel+bounces-780719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C70B30850
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF0C1C868B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614452C027F;
	Thu, 21 Aug 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nRBfV4DJ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E20393DC2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811614; cv=none; b=D1/PY3FgGv0sClBhQgcdrjY30zEkYF8j9mD6CycBmdMB0m0x+j0A645Ur/Zw5+p9LMyJJTxg+YPtY3r/GPUR7pdBMnn6woxPsnG5djE1OZhs3V6qhJkSkxNE1iXNn9oG6v9G5C+wAk5gUQkrAFUdHnUoV5r6rXMC1abV+vICTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811614; c=relaxed/simple;
	bh=1M5fQXY9LFpVUn/kNz5UCd6/90ssbQi+Zm8hDFl9FWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5AQl/eHjxXJGVIeV10I0RZ7XfYhgQeYP9+deKfgZGWG/zINDgHGstf8XNGpN70FsSeb24EtXEScpkoCxYn9QDYzDQP78mpIhT4KBEZfkPBoJd7fVFtIemb4M07OkpLLKhcLIm7TkmWpJZ6y08tuL0s9aNu9Ypr1GtJ4dSACBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nRBfV4DJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 14:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755811609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E24ReIpbujFlBQVR2Mugo0ODX1BdUsz5lvQufosPcvU=;
	b=nRBfV4DJDNoIQxkoYBSQaChCTGmadsYlnewjDld2fzur0xiZxZCR/iIA/nTBsZSlaCUsRD
	o7gv6ZvYoAW2Dd2KVll7GoWVNKIZ/xul1ll5zKJy/6oKf83OZSROddfyGH/4ztARr0P4Ng
	0OI0MZlVkdbGJmflc1julyPOZdZxdaI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <gxildlinmmimk7rd4olsz4rstsiapttbjbtbtzbekrmfxbvuhh@cmio2ckbyzxn>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <CAJuCfpFKNQrjtoctVt0N=r1cABeyPjpwrzP6M=OTpp1Rq_0QaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFKNQrjtoctVt0N=r1cABeyPjpwrzP6M=OTpp1Rq_0QaQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 01:00:36PM -0700, Suren Baghdasaryan wrote:
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
> No, memory allocation profiling is not cgroup-aware. It tracks
> allocations and their code locations but no other context.

Thanks for the info. Pan, will having memcg info along with allocation
profile help your use-case? (Though adding that might not be easy or
cheaper)

