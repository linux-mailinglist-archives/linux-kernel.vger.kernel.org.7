Return-Path: <linux-kernel+bounces-817521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8504B58332
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41C11A265C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01ED293C44;
	Mon, 15 Sep 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iN091Dr+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E42BEFE8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956518; cv=none; b=fqa9mF4HOJYN/0dU7+QJrB2NAJ07zDC6G3gYxtdXlSBb6t+eNv3xZIjvV0VfjIZTFp4Ihrw7i3jJdEAOTQUvFcpxaySirJFoF4Ch9a71xVh41lsDVPX9MM843Yr4DVBDFXcjCR5+iPonF1hPXC7YYpzAVpaiZtQ4ROxw3xWYSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956518; c=relaxed/simple;
	bh=w1Dey2fNQj87mvlexNodjjREVtdjkVTUuRFwezrwII0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL0SCvVZMTJmLM7H1KoKR7uNnsas3AWPkjt4tPKADZ6RH8ZiuITu7HWYxCkWTqLZouYydI6IPQMNi4Jbi6eWPXaShYf0sbudPhrhsWoQBpj0dWGLejdHBW4Cxjl9ss8tRlMkiH4pD4+zbNbHs9xtWcHXdXyyu/PSpzLg1nOW17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iN091Dr+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757956516; x=1789492516;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=w1Dey2fNQj87mvlexNodjjREVtdjkVTUuRFwezrwII0=;
  b=iN091Dr+IJ4wfhArB7n84mxONMN1fub4dKVPNKSOHabo1UcCgdsu0Odk
   s5lMbCInnkB05q2eROYnG/6M20SdPveFGrOPwG06duKhV5bw/JpaY63FO
   BEJ6xg6K6tRwbVZ/BY2OyKa4clXCEuKOjV6OBQyAi+LAi4iFHWvvAP5XU
   w65IjAjsdDnBuE0SRC8y8rOtygl30ft4xjqQG2oqqGThoNV+zzpU0Hg2z
   dbktmBvfZcg8bILmh726TJqGZtLuIYANNetVPqzi80ZNVQgSjv0+WrNRr
   rlpWBZhbwybkV22W06nVd/RIcKN8g9vFlTwEC33ijGlci0PRCho43lX8a
   g==;
X-CSE-ConnectionGUID: jHmWd7DKQ0a5I0abM212xQ==
X-CSE-MsgGUID: 42kdjXfjTWibg29d3zBanw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60154556"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60154556"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:15:15 -0700
X-CSE-ConnectionGUID: hfdOj/2tR8+Jvr6DTfYqIg==
X-CSE-MsgGUID: 5fP+CC5tQ6aMAyY6RWD+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174245096"
Received: from schen9-mobl4.jf.intel.com (HELO [10.54.74.4]) ([10.54.74.4])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:15:15 -0700
Message-ID: <fc688b2dc7d6dcc27bf86a17b291962aeac18bb1.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann	
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen	
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Libo
 Chen	 <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	 <len.brown@intel.com>, linux-kernel@vger.kernel.org, Chen Yu
 <yu.c.chen@intel.com>,  "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Zhao
 Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
  Arjan Van De Ven <arjan.van.de.ven@intel.com>
Date: Mon, 15 Sep 2025 10:15:15 -0700
In-Reply-To: <91ab8136-64f3-45e3-9fec-567aab193353@amd.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
	 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
	 <91ab8136-64f3-45e3-9fec-567aab193353@amd.com>
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

On Fri, 2025-09-12 at 10:38 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 9/12/2025 12:00 AM, Tim Chen wrote:
> > It is possible for Granite Rapids (GNR) and Clearwater Forest
> > (CWF) to have up to 3 dies per package. When sub-numa cluster (SNC-3)
> > is enabled, each die will become a separate NUMA node in the package
> > with different distances between dies within the same package.
> >=20
> > For example, on GNR, we see the following numa distances for a 2 socket
> > system with 3 dies per socket:
> >=20
> >     package 1       package2
> > 	----------------
> > 	|               |
> >     ---------       ---------
> >     |   0   |       |   3   |
> >     ---------       ---------
> > 	|               |
> >     ---------       ---------
> >     |   1   |       |   4   |
> >     ---------       ---------
> > 	|               |
> >     ---------       ---------
> >     |   2   |       |   5   |
> >     ---------       ---------
> > 	|               |
> > 	----------------
> >=20
> > node distances:
> > node     0    1    2    3    4    5
> > 0:   	10   15   17   21   28   26
> > 1:   	15   10   15   23   26   23
> > 2:   	17   15   10   26   23   21
> > 3:   	21   28   26   10   15   17
> > 4:   	23   26   23   15   10   15
> > 5:   	26   23   21   17   15   10
> >=20
> > The node distances above led to 2 problems:
> >=20
> > 1. Asymmetric routes taken between nodes in different packages led to
> > asymmetric scheduler domain perspective depending on which node you
> > are on.  Current scheduler code failed to build domains properly with
> > asymmetric distances.
> >=20
> > 2. Multiple remote distances to respective tiles on remote package crea=
te
> > too many levels of domain hierarchies grouping different nodes between
> > remote packages.
> >=20
> > For example, the above GNR-X topology lead to NUMA domains below:
> >=20
> > Sched domains from the perspective of a CPU in node 0, where the number
> > in bracket represent node number.
> >=20
> > NUMA-level 1    [0,1] [2]
> > NUMA-level 2    [0,1,2] [3]
> > NUMA-level 3    [0,1,2,3] [5]
> > NUMA-level 4    [0,1,2,3,5] [4]
> >=20
> > Sched domains from the perspective of a CPU in node 4
> > NUMA-level 1    [4] [3,5]
> > NUMA-level 2    [3,4,5] [0,2]
> > NUMA-level 3    [0,2,3,4,5] [1]
> >=20
> > Scheduler group peers for load balancing from the perspective of CPU 0
> > and 4 are different.  Improper task could be chosen for load balancing
> > between groups such as [0,2,3,4,5] [1].  Ideally you should choose node=
s
> > in 0 or 2 that are in same package as node 1 first.  But instead tasks
> > in the remote package node 3, 4, 5 could be chosen with an equal chance
> > and could lead to excessive remote package migrations and imbalance of
> > load between packages.  We should not group partial remote nodes and
> > local nodes together.
> > Simplify the remote distances for CWF-X and GNR-X for the purpose of
> > sched domains building, which maintains symmetry and leads to a more
> > reasonable load balance hierarchy.
> >=20
> > The sched domains from the perspective of a CPU in node 0 NUMA-level 1
> > is now
> > NUMA-level 1    [0,1] [2]
> > NUMA-level 2    [0,1,2] [3,4,5]
> >=20
> > The sched domains from the perspective of a CPU in node 4 NUMA-level 1
> > is now
> > NUMA-level 1    [4] [3,5]
> > NUMA-level 2    [3,4,5] [0,1,2]
> >=20
> > We have the same balancing perspective from node 0 or node 4.  Loads ar=
e
> > now balanced equally between packages.
> >=20
> > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> > Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>=20
> Feel free to include:
>=20
> Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thanks for reviewing and testing.

Tim

