Return-Path: <linux-kernel+bounces-806617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB63B49967
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3B93B5DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91232231845;
	Mon,  8 Sep 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F83k32kO"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8E188CB1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358490; cv=none; b=XAkCgpwCigO1d4Wk9m2Tlwaf9N9Z8VtTOW4jyTmAo3dMGgPr/ZCk0hhjmvoWqNAj758Rk60s9g0F3vs/FOUUAJGhCS7AFFxyaqEU4sdYspPj2jOJUjJgBNEzBYOlMcaHbwGETIeCcn5sL09t6lsGxCguypYJrCZjWmV1I4WDFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358490; c=relaxed/simple;
	bh=5CuqOh5PmcIYb+Dn3xzu7WtpE8K7iHZFUyUArp7UrCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLHy9fHM3Mur30unIybRjfzHSfVZFqppj2Ov7cLtNFbjXrX6tjVYaju7HVxLEtdgQxp1XBNjepEPPwSVfyMS4SSw+rJ92yNGv98EhfIH/LDZ11lWTV+dYU+UTVxifM1MZSrNGZZg9NyTm8NDjd5AVIYLKdTK1olNIm7lDL2fE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F83k32kO; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Sep 2025 12:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757358483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGp9LNECER4PONZr9C/fe03oMsJEOgr+safV7HEdOq8=;
	b=F83k32kO1p358K6H++eGircDmUq+XCZC/aspVKfnFaMPaxp8/t0SQcFIkN/dOImro4LmKB
	zaJDIlMFITlhwcR5N09VvQvIZI2Kf39xcTmnxRzBw1+81IsdJ7bSptr8GUi4zzeQBHH3F5
	KjlsBkB4qS+4o2IpWTm3uIGTlTSje+Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Yueyang Pan <pyyjason@gmail.com>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sourav Panda <souravpanda@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <cca3gvk5gco6i2vbjvtarmi77imgj5y64kqb7bebcrbjagdwca@4p6zq4iaiqr6>
References: <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
 <CAJuCfpHJMSd16j3ANrtJGVfLieHdeO_Epq=U9OKty3TV362ckQ@mail.gmail.com>
 <aLFKHGe2loD657fu@tiehlicka>
 <zerazodfo2uu5az4s6vuwsgnk7esgjptygh5kdgxnb74o2lzjm@fkziy4ggxrxc>
 <CAJuCfpFynEuwBSu28UiRDjWrayN-raX4Nqqh283MwRoJLi8bMQ@mail.gmail.com>
 <uoyjzkybkqd3wkvauofmorv72gnjisoq3owvijsezpt3wbrazz@at562ngtvszd>
 <CAJuCfpG17E_yoZeqEDrN0PFn8UBKqiGT28KDwEDmBm6byFje-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG17E_yoZeqEDrN0PFn8UBKqiGT28KDwEDmBm6byFje-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 10:51:30AM -0700, Suren Baghdasaryan wrote:
> On Mon, Sep 8, 2025 at 10:49 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Mon, Sep 08, 2025 at 10:47:06AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Sep 8, 2025 at 10:34 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > I think that got the memcg people looking at ways to make the accounting
> > > > cheaper, but I'm not sure if anything landed from that.
> > >
> > > Yes, Roman landed a series of changes reducing the memcg accounting overhead.
> >
> > Do you know offhand how big that was?
> 
> I'll need to dig it up but it was still much higher than memory profiling.

What benchmark/workload was used to compare memcg accounting and memory
profiling?

