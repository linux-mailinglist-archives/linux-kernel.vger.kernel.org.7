Return-Path: <linux-kernel+bounces-661528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D1AC2C89
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28853A24A84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108461EF09B;
	Fri, 23 May 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6IbL15D"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F01E04AC
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748044402; cv=none; b=A7eACECnCfk5kXIlchD09JnmSuNOs7M78cx+2FuG7QzSeEXeMbU7JPt1kJ6NeRhBez1zGj9igugo5a5O0CYbawPv6uwxK8REi1xxDaRF0+GxeXXDQmtNOrTiAZxwRQuqBVdTiqAEEQvM2CDuWlkdY5LKVwAPpLTZzOOUi4DSEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748044402; c=relaxed/simple;
	bh=FNaoXQ/DWBGXP+tPBYyfn9WkOJ19EQKKbiBGnBrLFJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCuBqiN4Jz1OYUB07R59O2b2Rpa73eFnpA71bPSp0Q/Cko+c+0wy71scAGVxEKEpI7XmMGVgsW6veaTVb9An5Yzweo0VdlGuuJV/nN8ByK1e5kp7giNeoZBsmxSngUcWlAi96So4lyZQvLRTYmCUEfRFsgBNCd7MotF6GdAShBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6IbL15D; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 16:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748044395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwhu4z2b7XnDz5DmFRgSfvRvsvme49qnGrnKAviEMhI=;
	b=P6IbL15DSmtaZaqqU1boExvqggqPvwfVbNZr7VVj/axwdnNVCBm52eaJ54bjJBb5h6xlAK
	vWXyo6Z0KCnnLOK9jqyITnUYt8sAYC6drgxLM7j+EwB7fWlRMTAXw9sKtmYdFLp9wY/H73
	rFyMWrg9o7eYVuUzklIREXTjjgdXRlc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Yu <yu.c.chen@intel.com>, peterz@infradead.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 0/2] sched/numa: add statistics of numa balance task
 migration
Message-ID: <qob64enpuewivcne2b7prnuahs3nr6v6kuil7suskcsfgdoqew@pdxpbd4ghrxk>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523150635.5901dbb92b8379c9d88f88ca@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 03:06:35PM -0700, Andrew Morton wrote:
> On Fri, 23 May 2025 20:48:02 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > Introducing the task migration and swap statistics in the following places:
> > /sys/fs/cgroup/{GROUP}/memory.stat
> > /proc/{PID}/sched
> > /proc/vmstat
> > 
> > These statistics facilitate a rapid evaluation of the performance and resource
> > utilization of the target workload.
> 
> Thanks.  I added this.
> 
> We're late in -rc7 but an earlier verison of this did have a run in
> linux-next.  Could reviewers please take a look relatively soon, let us
> know whether they believe this looks suitable for 6.16-rc1?
> 

The stats seems valuable but I am not convinced that memcg is the right
home for these stats. So, please hold until that is resolved.

