Return-Path: <linux-kernel+bounces-785590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A0B34E25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D84207FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18124283FDF;
	Mon, 25 Aug 2025 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdBdWS8l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D9F9CB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157810; cv=none; b=d+Q+UQKeGGbH34Dqvpz/VrW1bYT0S0l+5OwBvptfA0GBRXqkWsvSifT0ecJNYSvmOyycBavcqhi42zAnAA49AZLBZgw4T4dtHa1Ie95twNi0do23fpBeeZ+8uSWhPq+lVxtzVfIYh6aYb8itJZcLQZhri6Wv/ZuCZVUlwLChXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157810; c=relaxed/simple;
	bh=LSjLh8/zKeMDm6KzwnGzjK+OJV+4cQytrAdeFiMaDZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJ7DlrlSCUq3hIluwRLXlzHvEL3I5SV//mrVG4PVW8hOh0TfA1MXtL7rbqwUrhe/i5hSRdClI+b6/AtnfpldSj9gFFO7W1NqZT/C+gAJQFtkdkCAifA6EIohi7e0FZygAw+bRL6VWhMiM7OxQRwzjktLnY6PlOMwo2wLr1sIjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdBdWS8l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756157808; x=1787693808;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LSjLh8/zKeMDm6KzwnGzjK+OJV+4cQytrAdeFiMaDZU=;
  b=UdBdWS8lYwRTC1dm8erSnBkYjamTRA8T3ZenT89K2q6w4WOASe85RM+7
   EwGoUuQcOqX7AGwsgEHQI+ayd6yvr+Kz1drSK3x0tIgzg3uvVT2huyhWG
   vdzrj7qYXgWrg1Bso8LqwPaumuidJZ3hAksaeyZanM6WazaIy1zvKFOMj
   QV+oyjeN8g0p0FcsDXpYus2pyQ+27+x31lxRBkVWuqHFVINwkRM9jdz1y
   8H3pfm5Iz34Ip7o1earnjilc6v4TF0lE5UoUiWpwl3siNMN25Jh8Me5XE
   4KgiyZTVxEZ6NfIgH1k578xv8xDTjG5Pxv0xEHeshULW2yaeTwHWEUy6f
   g==;
X-CSE-ConnectionGUID: BWPJw4KeRImCNVqexrsu6Q==
X-CSE-MsgGUID: 6U0TSOCIR/+hLeXtKqpsBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58482978"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58482978"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:36:47 -0700
X-CSE-ConnectionGUID: xfUwmkSrRSiPT0rXTwWk4A==
X-CSE-MsgGUID: xsGdwk9iQombUoyczT5tIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206559496"
Received: from schen9-mobl2.jf.intel.com (HELO [10.98.24.137]) ([10.98.24.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:36:47 -0700
Message-ID: <65e8f7e3f4bc039f529a2ed6cbad68e121a26306.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] sched: Fix sched domain build error for GNR-X,
 CWF-X in SNC-3 mode
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin Schneider
 <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Libo Chen <libo.chen@oracle.com>, Abel Wu
 <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>, 
 linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, 
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Zhao Liu
 <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Chen Yu <yu.chen.surf@foxmail.com>, Arjan van de Ven <arjan@linux.intel.com>
Date: Mon, 25 Aug 2025 14:36:47 -0700
In-Reply-To: <20250825075642.GQ3245006@noisy.programming.kicks-ass.net>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
	 <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
	 <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>
	 <20250825075642.GQ3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 09:56 +0200, Peter Zijlstra wrote:
> >=20

... snip ...

> > > > > > +		/*
> > > > > > +		 * Trim finer distance tuning for nodes in remote package
> > > > > > +		 * for the purpose of building sched domains.
> > > > > > +		 * Put NUMA nodes in each remote package in a single sched g=
roup.
> > > > > > +		 * Simplify NUMA domains and avoid extra NUMA levels includi=
ng different
> > > > > > +		 * NUMA nodes in remote packages.
> > > > > > +		 *
> > > > > > +		 * GNR-x and CWF-X has GLUELESS-MESH topology with SNC
> > > > > > +		 * turned on.
> > > > > > +		 */
> > > > > > +		d =3D (d / 10) * 10;
> > > >=20
> > > > Does the '10' here mean that, the distance of the hierarchy socket
> > > > is 10 from SLIT table? For example, from a socket0 point of view,
> > > > the distance of socket1 to socket0 is within [20, 29), the distance
> > > > of socket2 to socket0 is [30,39), and so on. If this is the case,
> > > > maybe add a comment above for future reference.
> >=20
> > This is all because of the ACPI SLIT distance definitions I suppose, 10
> > for local and 20 for remote (which IMO is actively wrong, since it
> > mandates distances that are not relative performance).
> >=20
> > Additionally, the table above magically has all the remote distances in
> > the range of [20,29] and so the strip 1s thing works.
> >=20
> > The problem of course is that the SLIT table is fully under control of
> > the BIOS and random BIOS monkey could cause this to not be so making th=
e
> > above code not work as intended. Eg. if the remote distances ends up
> > being in the range of [20,35] or whatever, then it all goes sideways.
> >=20
> > ( There is a history of manupulating the SLIT table to influence
> > scheduler behaviour of OS of choice :-/ )
> >=20
> > Similarly, when doing a 4 node system, it is possible a 2 hop distances
> > doesn't align nicely with the 10s and we're up a creek again.

We don't expect 4 node systems for GNR nor CWF. So hopefully we don't need =
to
worry about them.  Otherwise we may need additional code to check for 2 hop=
s.

> >=20
> > This is all very fragile. A much better way would be to allocate a new
> > SLIT table, identify the (local) clusters and replace all remote
> > instances with an average.

Are you suggesting to have one SLIT distance table that's simplified for
scheduler domain build and another for true node distance?

> >=20
> > Eg. since (21+28+26+23+26+23+26+23+21)/9 ~ 24, you end up with:
> >=20
> >  node     0    1    2    3    4    5
> >      0:   10   15   17   24   24   24
> >      1:   15   10   15   24   24   24
> >      2:   17   15   10   24   24   24
> >      3:   24   24   24   10   15   17
> >      4:   24   24   24   15   10   15
> >      5:   24   24   24   17   15   10
> >=20
> >=20

Will take a closer look to use average for nodes
in remote package.

Tim

