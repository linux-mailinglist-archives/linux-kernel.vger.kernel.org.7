Return-Path: <linux-kernel+bounces-817724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7944B585AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F156C7A37C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14199283C9F;
	Mon, 15 Sep 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtPDKDtC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92D1F3D56
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966675; cv=none; b=pDXWoVbTEqVTVpEnligy1KSNHp2ocDWkRaJAHxxGQzN2ZEd9y91yXuLaQZOHtxH/F9K5rWRKlDUyo0XmDw0OSwiF7M4RqCCTetC7pCajNAH9t6TCPQtVzCwl5Tar2RcCmWVa2Lc2lowjsgXpM98g7NioXdNXjnAXOSLqrICZEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966675; c=relaxed/simple;
	bh=1owKAYt2TCOpYSYROAzX7QJ4GvHsbsbj6KZDFChzdbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hM7U2xkc26i4sBaX+STmxPv84yZoF4J7nWpDxZxq88vnN3vnrufOp03h1TWIpem+5eHE6grzMgkjukWKB0yFUY3TCTmxXtW7kuA6rPvUAU1swz2JWnwcecSoN5tdkBQ0m6itq9Ytsb7DBTQZwep8ueZ5dY7uHZRX7sZMMRtg2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtPDKDtC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757966674; x=1789502674;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1owKAYt2TCOpYSYROAzX7QJ4GvHsbsbj6KZDFChzdbY=;
  b=DtPDKDtCwTyu3AYBxHYxflN3c832CilVLjc7gg+tF4mfMFJKArziIpI7
   3LM1lBZpVZbELNtNvpBvfw7X2ymXnhAHiyFIYuLZkjGpWn68H1wwidRat
   lXnW3dCMzMpZGBJGwE4G4gN6AaiaBhjNqlYnLZL5dQqn21ZGh/bHeHrCk
   iogNEdiT7ACF+ie9UyqelV8Wubw6ZN5/WL7yZWV2qjzKvwyvJCFDpFKui
   GvQ4xet9x+iWALXwzHxQHu6NQZFLrgVFdS+2UXHPP7UvtX80gwizLARYO
   QKL6W+ZU6c9Vwlwb/Vt3Hn0sLVworXMo6dJJporba4hagXW5w1ejmhmCF
   Q==;
X-CSE-ConnectionGUID: +yy4WLZSTNWe435ohc0nag==
X-CSE-MsgGUID: 1yoZzFb6TpmlGbb0wqRpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59458846"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="59458846"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:04:33 -0700
X-CSE-ConnectionGUID: dpRNcQ8+Qay5WVudkcP5gg==
X-CSE-MsgGUID: fU4BqcU4QtGo7HvUolI8EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="175529331"
Received: from schen9-mobl4.jf.intel.com (HELO [10.54.74.4]) ([10.54.74.4])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 13:04:33 -0700
Message-ID: <146f2f85affc35a735d5e035032d4e661be5507b.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin Schneider	
 <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Libo Chen <libo.chen@oracle.com>, Abel Wu	
 <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>, 
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, K Prateek
 Nayak	 <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,  Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, Arjan Van De Ven	
 <arjan.van.de.ven@intel.com>
Date: Mon, 15 Sep 2025 13:04:32 -0700
In-Reply-To: <01702016805ce31c5e109c9d01a428f4f2e9eaf6.camel@linux.intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
		 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
		 <20250915123738.GD3245006@noisy.programming.kicks-ass.net>
	 <01702016805ce31c5e109c9d01a428f4f2e9eaf6.camel@linux.intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 10:13 -0700, Tim Chen wrote:
> On Mon, 2025-09-15 at 14:37 +0200, Peter Zijlstra wrote:
> > On Thu, Sep 11, 2025 at 11:30:56AM -0700, Tim Chen wrote:

<snip>

> > > +
> > > +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances=
,
> > > +				   &nr_node_levels))
> > > +		return;
> > > +
> > > +	WRITE_ONCE(sched_avg_remote_numa_distance,
> > > +		   avg_remote_numa_distance(offline_node));
> >=20
> > What is the point of all this? sched_avg_remote_numa_distance isn't
> > actually used anywhere. I'm thinking it doesn't want to be in this patc=
h
> > at the very least.
>=20
> sched_avg_remote_numa_distance actually could change when we offline/onli=
ne a
> node.  I think arch_sched_node_distance(i, j) needs to be changed to
> arch_sched_node_distance(i, j, offline_node) so it knows not to include
> offline_node in its avg distance computation.  I will do that then.
>=20

On second thought, GNR and CWF topology only need a remote average
distance.  Whether the offline node is entered into the computation
does not change the resulting sched domain topology.  So paasing
offline node is not necessary and I will update the code as such
and move the average distance computation to x86 specific file.

Tim

