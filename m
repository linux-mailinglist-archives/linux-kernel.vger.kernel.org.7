Return-Path: <linux-kernel+bounces-651552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB921AB9FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 17:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E512D175687
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0E1B4F09;
	Fri, 16 May 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cAx9vsNI"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893181B87EB
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409738; cv=none; b=SqOk3lj5a62mHNvANGkC33iZ7zVjL8g1Mriafy4uBe06HWJw3rP2+8yhhVRQ2ow/aQ8JeFBxlp4zFPHnkiLvtF6iXJu3cZJ5HGZ3dCNlg5n6eRARPyhkEjJfbmhgRA+o7sn0wUSTVrQdT7q47JlvNDRKdRlhQ/2I+XIiDzxlW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409738; c=relaxed/simple;
	bh=4spRlZNhnCEicwsxcWbx2Jkoz9+deyk3RJe76Gi67JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVQ8kl1iZCE62PEfbkUlvNl0oLUSTVXNnAatRO1051Vap2CM6qQJ4l0pw1GHZLiw1haqb6kaY/7bL7CaoumVj6g9uWoDBnJ57LgUkxKtGPBlbNGAY9MtIZMH9V/4bcMXU8rcQP8ki7cg1QVt53cGQdDYTjbuVQfAW/TjaPpL/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cAx9vsNI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 May 2025 08:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747409723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDu+jRkwpaRbOzcYJWxPfjXvLWF0YO9LpUYPWyot3l4=;
	b=cAx9vsNICzLyqKSVXLYeLdMpNBqma8I1rnl8JSm8TPTOnHA9zjtZ9WEs7rM9pfJ1oBaxjP
	Nc5+Uy0/GmWjLJcuLPIdIRB664JgTaGoN+lV/Y+g45NGik3oIoV4MohXMzxjGOP8v54W6h
	wsRQ29Nmaxnx+/VSJ/PIMK/i4BE0yp0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 5/5] memcg: make memcg_rstat_updated nmi safe
Message-ID: <7v2v2bwgd4jbprimygguwatdi6zhsvidibk2zlddkx7ksg3y6l@u3mlw5bw3tyt>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
 <20250516064912.1515065-6-shakeel.butt@linux.dev>
 <8114231b-ec06-44a9-9075-9ccf0809de4a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8114231b-ec06-44a9-9075-9ccf0809de4a@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, May 16, 2025 at 11:45:39AM +0200, Vlastimil Babka wrote:
> On 5/16/25 08:49, Shakeel Butt wrote:
> > memcg: convert stats_updates to atomic_t
> 
> You have two subjects, I guess delete the second one?

Oops I squashed the patch at the very end and forgot to fix this.

> 
> > Currently kernel maintains memory related stats updates per-cgroup to
> > optimize stats flushing. The stats_updates is defined as atomic64_t
> > which is not nmi-safe on some archs. Actually we don't really need 64bit
> > atomic as the max value stats_updates can get should be less than
> > nr_cpus * MEMCG_CHARGE_BATCH. A normal atomic_t should suffice.
> > 
> > Also the function cgroup_rstat_updated() is still not nmi-safe but there
> > is parallel effort to make it nmi-safe, so until then let's ignore it in
> > the nmi context.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks a lot.

